/*********************************************************************
 * 업 무 명 : 유저 컨트롤러
 * 설 명 : 로그인/로그아웃, 회원가입 화면에서 사용 
 * 작 성 자 : 권유진
 * 작 성 일 : 2022.10.30
 * 관련테이블 : BOARD_USER
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************************/
package egovframework.fusion.user.web;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.user.service.UserService;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="/loginCheck.do", method=RequestMethod.POST)
	public String loginChk(UserVO userVO, HttpSession session) {
		String returnURL = "";
		
		if (session.getAttribute("user") != null) {
			session.invalidate();
		}
		
		UserVO checkVO = userService.loginChk(userVO);
		if (checkVO != null) {
			session.setAttribute("user", checkVO);
			returnURL = "redirect:/home/home.do";
		} else {
			returnURL = "loginFail";
		}
		return returnURL;
	}
	
	@RequestMapping(value="/logout.do", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "logOut";
	}
	
	@RequestMapping(value="/signIn.do", method=RequestMethod.GET)
	public String signIn() {
		return "signIn";
	}
	
	@RequestMapping(value="/idCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String idCheck(UserVO userVO) {
		String returnMsg = "";
		UserVO idValidation = userService.idCheck(userVO);
		if (idValidation == null) {
			returnMsg = "success";
		} else {
			returnMsg = "failed";
		}
		return returnMsg;
	}
	
	@RequestMapping(value="/signIn.do", method=RequestMethod.POST)
	public String signInChk(UserVO userVO, HttpServletResponse response) {
		userService.signIn(userVO);
		return "redirect:/login.do";
	}
	
	@RequestMapping(value="/notAuthorized.do", method=RequestMethod.GET)
	public String notAuthorized() {
		return "notAuthorized";
	}
}
