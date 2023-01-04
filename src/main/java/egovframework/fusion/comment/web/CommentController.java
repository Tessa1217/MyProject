package egovframework.fusion.comment.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.comment.service.CommentService;
import egovframework.fusion.comment.vo.CommentVO;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class CommentController {
	
	@Autowired
	CommentService commentService;

	@RequestMapping(value="/comment/commentList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<CommentVO> getCommentList(CommentVO commentVO) {
		List<CommentVO> commentList = null;
		try {
			commentList = commentService.getCommentList(commentVO);
		} catch (Exception e) {
			e.printStackTrace();
			return commentList;
		}
		return commentList;
	}
	
	@RequestMapping(value="/comment/selComment.do", method=RequestMethod.POST)
	@ResponseBody
	public CommentVO selComment(CommentVO commentVO) {
		try {
			commentVO = commentService.getComment(commentVO);
		} catch (Exception e) {
			e.printStackTrace();
			return new CommentVO();
		}
		return commentVO;
	}
	
	@RequestMapping(value="/comment/insComment.do", method=RequestMethod.POST)
	@ResponseBody
	public String insComment(CommentVO commentVO, HttpSession session) {
		UserVO userInfo = (UserVO) session.getAttribute("user");
		commentVO.setUserNo(userInfo.getUserNo());
		commentService.insComment(commentVO);
		return "success"; 
	}
	
	@RequestMapping(value="/comment/updComment.do", method=RequestMethod.POST)
	@ResponseBody
	public CommentVO updComment(CommentVO commentVO) {
		try {
			commentService.updComment(commentVO);
		} catch (Exception e) {
			e.printStackTrace();
			return new CommentVO();
		}
		return commentVO;
	}
	
	@RequestMapping(value="/comment/delComment.do", method=RequestMethod.POST)
	@ResponseBody
	public CommentVO delComment(CommentVO commentVO) {
		try {
			commentService.delComment(commentVO);
		} catch(Exception e) {
			e.printStackTrace();
			return new CommentVO();
		}
		return commentVO;
	}

}
