package egovframework.fusion.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.comment.service.CommentService;
import egovframework.fusion.user.vo.UserVO;

public class BoardInterceptor implements HandlerInterceptor {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		if (!(handler instanceof HandlerMethod)) {
			return true;
		}
		
		if (request.getRequestURI().endsWith("List.do") || request.getRequestURI().endsWith("Select.do") || request.getRequestURI().endsWith("Download.do")) {
			return true;
		}
		
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/notAuthorized.do");
			return false;
		} 
		
		return true;
		
	}	
	
}
