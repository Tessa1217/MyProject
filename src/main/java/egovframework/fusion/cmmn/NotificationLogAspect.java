package egovframework.fusion.cmmn;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.comment.service.CommentService;

@Component
@EnableAspectJAutoProxy
@Aspect
public class NotificationLogAspect {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;
	
	@Pointcut("execution (* egovframework.fusion.board.web.BoardController.*(..))")
	private void getController() {
	}
	
}
