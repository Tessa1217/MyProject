/*********************************************************
 * 업 무 명 : 게시판 파일 컨트롤러
 * 설 명 : SNS 게시판 텍스트 에디터(CKEDITOR) 파일 업로드/조회 시 사용
 * 작 성 자 : 권유진
 * 작 성 일 : 2022.12.20
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
package egovframework.fusion.board.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.fusion.board.service.BoardService;

@Controller
public class BoardFileController {
	
	
	@Autowired
	BoardService boardService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping(value="/board/editorFileUpload.do", method=RequestMethod.POST)
	public void uploadEditorFile(HttpServletResponse response, MultipartHttpServletRequest multipartRequest) {
		PrintWriter printWriter = null;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html);charset=utf-8");
		MultipartFile file = multipartRequest.getFile("upload");
		String oriFileName = file.getOriginalFilename();
		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "").concat(oriFileName);
		String filePath = uploadPath + "\\editors\\" + storedFileName;
		try {
			File transferFile = new File(filePath);
			transferFile.getParentFile().mkdirs();
			file.transferTo(transferFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String fileUrl = "/board/editorFileDownload.do?fileName=" + storedFileName;
		try {
			printWriter = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		printWriter.println("{\"filename\" : \"" + oriFileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
        printWriter.flush();
	}
	
	
	@RequestMapping(value="/board/editorFileDownload.do", method=RequestMethod.GET) 
	public void editorDownload(@RequestParam(value="fileName") String fileName, HttpServletRequest request, HttpServletResponse response) {
		File file = new File(uploadPath + "\\editors\\" + fileName);
		try {
			byte[] data = FileUtils.readFileToByteArray(file);
			response = setHeaderInfo(response, fileName, getMediaType(fileName).toString());
            response.setContentLength(data.length);

            response.getOutputStream().write(data);
            response.getOutputStream().flush();
            response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private MediaType getMediaType(String filename) {

        String contentType = FilenameUtils.getExtension(filename);
        MediaType mediaType = null;

        if (contentType.equals("png")) {
            mediaType = MediaType.IMAGE_PNG;
        } else if (contentType.equals("jpeg") || contentType.equals("jpg")) {
            mediaType = MediaType.IMAGE_JPEG;
        } else if (contentType.equals("gif")) {
            mediaType = MediaType.IMAGE_GIF;
        }

        return mediaType;
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
	

}
