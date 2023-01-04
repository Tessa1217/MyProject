package egovframework.fusion.cmmn;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.fusion.manage.service.ManageService;
import egovframework.fusion.manage.vo.MenuVO;
import egovframework.fusion.user.vo.UserVO;

public class LoginInterceptor implements HandlerInterceptor {

	@Autowired
	ManageService manageService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		
		if (!(handler instanceof HandlerMethod)) {
			return true;
		}
		
		HttpSession session = request.getSession();
		UserVO user = new UserVO();
		if (session.getAttribute("user") != null) {
			user = (UserVO) session.getAttribute("user");
		} else {
			user.setUserAuth("USER");
		}

		String requestPath = getFullURL(request);
		
		MenuVO menuVO = new MenuVO();
		List<MenuVO> menuList = manageService.getMenuList(menuVO);
		
		for (MenuVO menu : menuList) {
			if (requestPath.equals(menu.getFullPath())) {
				if (manageService.getMenuGroupList(menu).indexOf(user.getUserAuth()) < 0) {
					response.sendRedirect("/notAuthorized.do");
					return false;
				} 
			}
		}
		
		menuVO.setUserAuthCode(user.getUserAuth());
		menuVO.setMenuDelyn("N");
		request.setAttribute("menuList", manageService.getMenuList(menuVO));
		
		return true;
		
	}
	
	String getFullURL(HttpServletRequest request) {
		String requestURI = request.getRequestURI();
		String queryString = request.getQueryString();
		if (queryString == null || queryString == "") {
			return requestURI;
		} else {
			return requestURI + "?" + queryString;
		}
	}
}
