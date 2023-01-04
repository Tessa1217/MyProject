package egovframework.fusion.board.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.board.vo.BoardFileVO;
import egovframework.fusion.board.vo.BoardLikeVO;
import egovframework.fusion.board.vo.BoardTagVO;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.comment.service.CommentService;
import egovframework.fusion.user.vo.UserVO;

@RestController
public class BoardRestController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;
	
	private Logger logger = Logger.getLogger(BoardRestController.class);
	
	private BoardController boardController;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy\\MM\\dd");
	private SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");
	private Date date = new Date();
	private String today = sdf.format(date);
	private String sToday = sdf2.format(date);
	
	/*
	 * 게시판 리스트 출력 (AJAX 이용, POST 방식)
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	

	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.POST)
	public List<BoardVO> getBoardListAjax(BoardVO boardVO, Criteria cri, HttpSession session) {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		cri.setCommand(boardVO.getBoardTypeNo());
		UserVO user = null;
		if (session.getAttribute("user") != null) {
			user = (UserVO) session.getAttribute("user");
		}
		if (user != null) {
			boardVO.setUserNo(user.getUserNo());
		}
		if ("GALLERY".equals(boardVO.getBoardTypeNo()) && cri.getRecordCountPerPage() == 10) {
			cri.setRecordCountPerPage(20);
		} else if ("SOCIAL".equals(boardVO.getBoardTypeNo()) && cri.getRecordCountPerPage() == 10) {
			cri.setRecordCountPerPage(5);
		}
		try {
			boardList = boardService.getBoardList(boardVO, cri);
			if ("GALLERY".equals(boardVO.getBoardTypeNo())) {
				boardList = boardController.getTagList(boardList);
			}
		} catch(Exception e) {
			logger.error("SQL Exception");
			return null;
		}
		return boardList;
	}
	
	/*
	 * 게시글 등록
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardInsert.do", method = RequestMethod.POST)
	public String insBoardPost(BoardVO boardVO, MultipartFile[] fileList, HttpSession session, Model model) {
		
		UserVO user = (UserVO) session.getAttribute("user");
		
		try {
			boardVO.setUserNo(user.getUserNo());	// 작성자 정보를 Session 으로 처리 해야 함
			boardService.insBoardPost(boardVO);
			if (fileList != null && fileList.length > 0) {
				insBoardFile(boardVO, fileList);
			}
			if (boardVO.getTagString() != null && boardVO.getTagString() != "") {
				insBoardTag(boardVO);
 			}
		} catch(Exception e) {
			logger.error("SQL Exception");
			return "failed";
		}
		
		return "success";
	}
	
	/*
	 * 게시글 조회
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	
	@RequestMapping(value="/board/boardSelect.do", method=RequestMethod.POST)
	public BoardVO boardPost(BoardVO boardVO, HttpSession session) {
		try {
			if (session.getAttribute("user") != null) {
				UserVO user = (UserVO) session.getAttribute("user");
				boardVO.setUserNo(user.getUserNo());
			}
			boardVO = boardService.getBoardPost(boardVO);
		} catch (Exception e) {
			logger.error("SQL Exception");
			return new BoardVO();
		}
		return boardVO;
	}
	
	/*
	 * 게시글 수정
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.POST)
	public String updBoardPost(BoardVO boardVO, MultipartFile[] fileList, @RequestParam(value="originalFiles", required=false) String originalFiles) {
		
		try {
			boardService.updBoardPost(boardVO);

			// 삭제 파일 키 값 리스트를 통해 삭제
			if (originalFiles != null && !"".equals(originalFiles)) {
				String[] originalFileNums = originalFiles.split(",");
				for (String originalFileNum : originalFileNums) {
					BoardFileVO boardFile = new BoardFileVO();
					boardFile.setFileNo(Integer.parseInt(originalFileNum));
					boardService.delBoardFile(boardFile);
				}
			}
			
			if (boardVO.getThumbnailIdx() != null && boardVO.getThumbnailIdx().startsWith("fileNo=")) {
				resetThumbnail(boardVO.getBoardNo());
				BoardFileVO thumbnailFile = new BoardFileVO();
				thumbnailFile.setFileNo(Integer.parseInt(boardVO.getThumbnailIdx().substring(7)));
				thumbnailFile = boardService.getBoardFile(thumbnailFile);
				thumbnailFile.setBoardNo(0);
				thumbnailFile.setFileIsThumbnail("Y");
				makeThumbnail(thumbnailFile);
				boardService.updBoardFile(thumbnailFile);
			}

			if (fileList != null) {
				insBoardFile(boardVO, fileList);
			}
			
			if (boardVO.getTagString() != null && boardVO.getTagString() != "") {
				BoardTagVO boardTagVO = new BoardTagVO();
				boardTagVO.setBoardNo(boardVO.getBoardNo());
				boardService.delBoardTag(boardTagVO);
				
				String[] tags = boardVO.getTagString().split(",");
				for (int i = 0; i < tags.length; i++) {
					boardTagVO = new BoardTagVO();
					boardTagVO.setTagContent(tags[i]);
					boardTagVO.setBoardNo(boardVO.getBoardNo());
					boardTagVO.setTagOrder(i + 1);
					boardService.insBoardTag(boardTagVO);
				}
			}
			
		} catch(Exception e) {
			logger.error("SQL Exception");
			return "failed";
		}
		return "success";

	}
	
	private void insBoardTag(BoardVO boardVO) {
		BoardTagVO tagVO = new BoardTagVO();
		tagVO.setBoardNo(boardVO.getBoardNo());
		String[] splitTags = boardVO.getTagString().split(",");
		for (int i = 0; i < splitTags.length; i++) {
			tagVO.setTagContent(splitTags[i]);
			tagVO.setTagOrder(i);
			boardService.insBoardTag(tagVO);
		}
	}
	
	private void insBoardFile(BoardVO boardVO, MultipartFile[] fileList) {
		for (int i = 0; i < fileList.length; i++) {
			BoardFileVO boardFile = new BoardFileVO();
			boardFile = registerFile(boardVO, fileList[i]);
			boardFile.setFileOrder(i);
			if (boardVO.getThumbnailIdx().startsWith("newOrder=") && Integer.parseInt(boardVO.getThumbnailIdx().substring(9)) == i) {
				resetThumbnail(boardVO.getBoardNo());
				boardFile.setFileIsThumbnail("Y");
				boardFile = makeThumbnail(boardFile);
			} else {
				boardFile.setFileIsThumbnail("N");
			}			
			boardService.insBoardFile(boardFile);
		}
	}
	
	private BoardFileVO registerFile(BoardVO boardVO, MultipartFile file) {
		BoardFileVO boardFile = new BoardFileVO();
		boardFile.setBoardNo(boardVO.getBoardNo());
		boardFile.setFileOriName(file.getOriginalFilename());
		boardFile.setFileStoredName(getStoredName(file));
		boardFile.setFileExtension(file.getContentType());
		boardFile.setFileSize(file.getSize());
		boardFile.setFilePath("/uploads/" + sToday + "/" + boardFile.getFileStoredName());
		File filePath = new File(uploadPath + "\\uploads\\" + today + "\\" + boardFile.getFileStoredName());
		filePath.getParentFile().mkdirs();
		try {
			file.transferTo(filePath);
		} catch (IllegalStateException | IOException e) {
			logger.error("IllegalState or IO Exception");
			return null;
		}
		return boardFile;
	}
	
	private String getStoredName(MultipartFile file) {
		return UUID.randomUUID().toString().replaceAll("-", "") + file.getOriginalFilename();
	}
	
	private BoardFileVO makeThumbnail(BoardFileVO boardFileVo) {
		try {
			String dateDir = today;
			if (boardFileVo.getFileRegDate() != null) {
				dateDir = sdf.format(boardFileVo.getFileRegDate());
			}
			BufferedImage srcImg = ImageIO.read(new File(uploadPath + "\\uploads\\" + dateDir + "\\" + boardFileVo.getFileStoredName()));
			int tw = 316;
			int th = 237;
			int ow = srcImg.getWidth();
			int oh = srcImg.getHeight();
			int nw = ow;
			int nh = (ow * th)/tw;
			if (nh > oh) {
				nw = (oh*tw)/th; 
				nh = oh;
			}
			BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh);
			BufferedImage destImg = Scalr.resize(cropImg, tw, th);
			String thumbPath = uploadPath + "thumbnails\\" + today + "\\" + boardFileVo.getFileStoredName();
			File thumbnailFile = new File(thumbPath);
			thumbnailFile.getParentFile().mkdirs();
			ImageIO.write(destImg, "jpg", thumbnailFile);
			
		} catch (IOException e1) {
			logger.error("IO Exception");
		}
		boardFileVo.setThumbnailPath("/thumbnails/" + sToday + "/" + boardFileVo.getFileStoredName());
		return boardFileVo;
	}
	
	@RequestMapping(value="/board/{fileNo}/download.do", method = RequestMethod.GET)
	public void downloadImage(@PathVariable int fileNo, HttpServletResponse response) {
		
		BoardFileVO boardFile = new BoardFileVO();
		boardFile.setFileNo(fileNo);
		boardFile = boardService.getBoardFile(boardFile);
		
		String fileName = boardFile.getFileOriName();
		String fileStoredName = boardFile.getFileStoredName();
		String contentType = boardFile.getFileExtension();
		
		response = setHeaderInfo(response, fileName, contentType);
		
		try (FileInputStream is = new FileInputStream(uploadPath + "\\uploads\\" + sdf.format(boardFile.getFileRegDate()) + "\\" + fileStoredName); OutputStream out = response.getOutputStream();) {
			int readCount = 0;
			byte[] buffer = new byte[1024];
			while((readCount = is.read(buffer)) != -1) {
				out.write(buffer, 0, readCount);
			}
			boardService.updFileDownCnt(boardFile);
		} catch (FileNotFoundException e) {
			logger.error("FileNotFound Exception");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			logger.error("IO Exception");
		} 
		
	}
	
	private HttpServletResponse setHeaderInfo(HttpServletResponse response, String fileName, String contentType) {
		try {
			response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Content-Type", contentType);
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		return response;
	}
	
	
	private void resetThumbnail(int boardNo) {
		BoardFileVO thumbnailFile = new BoardFileVO();
		thumbnailFile.setBoardNo(boardNo);
		boardService.updBoardFile(thumbnailFile);
	}
	
	/*
	 * 게시글 삭제
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST)
	public String delBoardPost(BoardVO boardVO, Model model) {
		
		try {
			boardService.delBoardPost(boardVO);
		} catch(Exception e) {
			logger.error("SQL Exception");
			return "failed";
		}
		
		return "success";
	}
	
	@RequestMapping(value = "/board/delBoardFile.do", method = RequestMethod.POST)
	public String delBoardFile(BoardFileVO boardFileVO) {
		try {
			boardService.delBoardFile(boardFileVO);
		} catch (Exception e) {
			logger.error("SQL Exception");
			return "failed";
		}
		return "success";
	}
	
	
	@RequestMapping(value = "/board/delBoardTag.do", method = RequestMethod.POST)
	public String delBoardTag(BoardTagVO boardTagVO) {
		try {
			boardService.delBoardTag(boardTagVO);
		} catch (Exception e) {
			logger.error("SQL Exception");
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/board/likeBoard.do", method = RequestMethod.POST)
	public String likeBoard(@RequestParam("command") int command, HttpSession session, BoardLikeVO boardLikeVO) {
		
		UserVO user = (UserVO) session.getAttribute("user");
		boardLikeVO.setLikesUserNo(user.getUserNo());
		
		try {
			if (command == 1) {
				boardService.insBoardLike(boardLikeVO);
				return "liked";
			} else if (command == 2) {
				boardService.delBoardLike(boardLikeVO);
				return "disliked";
			}
		} catch (Exception e) {
			logger.error("SQL Exception");
			return "failed";
		}
		return "";
		
	}
	
}
