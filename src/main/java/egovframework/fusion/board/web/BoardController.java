/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
package egovframework.fusion.board.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.board.vo.BoardHistoryVO;
import egovframework.fusion.board.vo.BoardLikeVO;
import egovframework.fusion.board.vo.BoardTagVO;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.cmmn.vo.PageDTO;
import egovframework.fusion.comment.service.CommentService;
import egovframework.fusion.comment.vo.CommentVO;
import egovframework.fusion.user.vo.UserVO;



@Controller
public class BoardController {

	private Logger logger = Logger.getLogger(BoardController.class);
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;
	
	/*
	 * 게시판 리스트 출력
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(BoardVO boardVO, Criteria cri, Model model) {
		PageDTO paginationInfo = new PageDTO();
		paginationInfo.setCurrentPageNo(cri.getPageIndex());
		cri.setCommand(boardVO.getBoardTypeNo());
		if ("GALLERY".equals(boardVO.getBoardTypeNo()) && cri.getRecordCountPerPage() == 10) {
			cri.setRecordCountPerPage(20);
		} else if ("SOCIAL".equals(boardVO.getBoardTypeNo()) && cri.getRecordCountPerPage() == 10) {
			cri.setRecordCountPerPage(5);
		}
		paginationInfo.setRecordCountPerPage(cri.getRecordCountPerPage());
		paginationInfo.setPageSize(cri.getPageSize());
		paginationInfo.setTotalRecordCount(boardService.getBoardListCnt(boardVO, cri));
		
		if ("BOARD_TAG".equals(cri.getSearchCnd())) {
			BoardTagVO boardTagVo = new BoardTagVO();
			boardTagVo.setTagContent(cri.getSearchKeyword());
			boardService.insBoardTagLog(boardTagVo);
		}
		
		model.addAttribute("board", boardVO);
		
		try {
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("cri", cri);
			List<BoardVO> boardList = boardService.getBoardList(boardVO, cri);
			if ("DEFAULT".equals(boardVO.getBoardTypeNo())) {
				model.addAttribute("boardList", boardList);
				return "views/board/vueList";
			} else if ("NOTICE".equals(boardVO.getBoardTypeNo())) {
				model.addAttribute("noticeList", boardList);
			} else if ("GALLERY".equals(boardVO.getBoardTypeNo())) {
				model.addAttribute("galleryList", getTagList(boardList));
				List<BoardTagVO> recentTags = boardService.getRecentTagList("recent");
				List<BoardTagVO> topTags = boardService.getRecentTagList("top");
				model.addAttribute("recentTags", recentTags);
				model.addAttribute("topTags", topTags);
			} else if ("SOCIAL".equals(boardVO.getBoardTypeNo())) {
				model.addAttribute("socialList", boardList);
			}
			return "views/board/" + boardVO.getBoardTypeNo().toLowerCase() + "List";
		} catch (Exception e) {
			logger.error("SQL Exception");
		}
		return "";
	}
	
	List<BoardVO> getTagList(List<BoardVO> boardList) {
		for (BoardVO gallery : boardList) {
			BoardTagVO boardTagVo = new BoardTagVO();
			boardTagVo.setBoardNo(gallery.getBoardNo());
			gallery.setBoardTags(boardService.getTagList(boardTagVo));
		}
		return boardList;
	}
	
	/*
	 * 게시글 등록 페이지 이동
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardInsert.do", method = RequestMethod.GET)
	public String boardInsertPage(BoardVO boardVO, Model model) {
		model.addAttribute("board", boardVO);
		return "views/board/boardIns";
	}
	
	@RequestMapping(value = "/board/boardSelect.do", method = RequestMethod.GET)
	public String boardPost(BoardVO boardVO, Model model, HttpSession session) {
		
		/* 
		 * 회원의 경우 조회수, 좋아요 처리
		 * */
		
		if (session.getAttribute("user") != null) {
			
			UserVO visitor = (UserVO) session.getAttribute("user");
			BoardHistoryVO boardHistoryVO = new BoardHistoryVO(visitor.getUserNo(), boardVO.getBoardNo());
			
			if (boardService.getBoardHistory(boardHistoryVO) == null) {
				boardService.insBoardHistory(boardHistoryVO);
				boardService.updBoardCnt(boardVO);
			}
			
			BoardLikeVO boardLikeVo = new BoardLikeVO();
			boardLikeVo.setLikesBoardNo(boardVO.getBoardNo());
			boardLikeVo.setLikesUserNo(visitor.getUserNo());
			model.addAttribute("boardLike", boardService.getBoardLike(boardLikeVo));
			
		}
		
		try {
			
			BoardVO boardPost = boardService.getBoardPost(boardVO);
			model.addAttribute("board", boardPost);

			CommentVO commentVO = new CommentVO();
			commentVO.setBoardNo(boardVO.getBoardNo());
			List<CommentVO> commentList = commentService.getCommentList(commentVO);
			model.addAttribute("commentList", commentList);
			
		} catch(Exception e) {
			logger.error("SQL Exception");
		}
		
		return "views/board/boardSel";
	}
	
	/*
	 * 게시글 수정 페이지 진입
	 * @param	
	 * @return	
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.GET)
	public String boardPostModify(BoardVO boardVO, Model model, HttpSession session) {
		try {
			BoardVO boardPost = boardService.getBoardPost(boardVO);
			model.addAttribute("board", boardPost);
		} catch(Exception e) {
			logger.error("SQL Exception");
		}
		
		return "views/board/boardUpd";
	}
	
	
}
