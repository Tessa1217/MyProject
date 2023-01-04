package egovframework.fusion.cmmn;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.fusion.manage.service.ManageService;
import egovframework.fusion.manage.vo.MenuLogVO;
import egovframework.fusion.manage.vo.MenuVO;
import egovframework.fusion.user.vo.UserVO;

@Component
@EnableAspectJAutoProxy
@Aspect
public class MenuLogAspect {
	
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	ManageService manageService;
	
	@Pointcut("execution (* egovframework.fusion.*.web.*Controller.*(..))")
	private void getController() {
	}
	
	private String getFullURL(HttpServletRequest request) {
		String requestURI = request.getRequestURI();
		String queryString = request.getQueryString();
		if (queryString == null || queryString == "") {
			return requestURI;
		} else {
			return requestURI + "?" + queryString;
		}
	}
	
	@AfterReturning(value="getController()")
	public void writeLog(JoinPoint jp) throws Throwable {
		
		 HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		 HttpSession session = request.getSession();
		
		 MenuVO menuVO = new MenuVO();
		 
		 if (session.getAttribute("user") != null) {
			 UserVO user = (UserVO) session.getAttribute("user");
			 menuVO.setUserAuthCode(user.getUserAuth());
		 } else {
			 menuVO.setUserAuthCode("USER");
		 }

		
		 
		 MenuLogVO log = new MenuLogVO();
		 
		 if ("/manage/menuLog.do".equals(request.getRequestURI())) {
			 log.setMenuNo(Integer.parseInt(request.getParameter("menuNo")));
			 manageService.insMenuLog(log);
		 } else {
			 List<MenuVO> menuList = manageService.getMenuList(menuVO);
			 for (MenuVO menu : menuList) {
				 if (getFullURL(request).equals(menu.getFullPath())) {
					 log.setMenuNo(menu.getMenuNo());
					 manageService.insMenuLog(log);
					 return;
				 }
			 }
		 }

	}
	
}
