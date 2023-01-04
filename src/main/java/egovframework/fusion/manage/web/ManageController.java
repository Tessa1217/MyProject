/*********************************************************************
 * 업 무 명 : 관리 컨트롤러
 * 설 명 : 메뉴 조회, 공통 코드 조회 화면에서 사용 
 * 작 성 자 : 권유진
 * 작 성 일 : 2022.11.30
 * 관련테이블 : COMMON_CODE, COMMON_GROUP, MENU, MENU_GROUP, MENU_LOG 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************************/
package egovframework.fusion.manage.web;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.cmmn.service.CommonService;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.cmmn.vo.PageDTO;
import egovframework.fusion.manage.service.ManageService;
import egovframework.fusion.manage.vo.MenuVO;

@Controller
public class ManageController {
	
	@Autowired
	ManageService menuService;
	
	@Autowired
	CommonService commonService;
	
	@RequestMapping(value="/manage/commonList.do", method=RequestMethod.GET)
	public String getCommonList(CommonGroupVO groupVO, Criteria cri, String tabIndex, Model model) {
		
		System.out.println(tabIndex);
		
		if (tabIndex == null || "".equals(tabIndex)) {
			tabIndex = "0";
		}
		
		PageDTO paginationInfo = new PageDTO();
		
		List<CommonGroupVO> groupList = commonService.getCommonGpList(cri, groupVO);
		for (CommonGroupVO group : groupList) {
			group.setCodeList(commonService.getCommonCdList(group));
		}
		model.addAttribute("gpList", groupList);
		model.addAttribute("cri", cri);
		model.addAttribute("tabIndex", tabIndex);
		return "views/manage/codeList2";
	}
	
	@RequestMapping(value="/manage/menuLog.do", method=RequestMethod.POST)
	@ResponseBody
	public MenuVO menuLog(String menuNo, HttpServletResponse response) {
		Integer no = null;
		try {
			no = Integer.parseInt(menuNo);
		} catch (NumberFormatException e) {
			return null;
		}
		MenuVO menu = new MenuVO();
		menu.setMenuNo(no);
		return menuService.selMenu(menu);
	}
	
	@RequestMapping(value="/manage/menuList.do", method=RequestMethod.GET)
	public String getMenuList(Model model) {
		CommonGroupVO vo = new CommonGroupVO();
		vo.setGpCode("USER_AUTH");
		model.addAttribute("authList", commonService.getCommonCdList(vo));
		vo.setGpCode("M_TYPE");
		model.addAttribute("menuTypeList", commonService.getCommonCdList(vo));
		
		MenuVO menu = new MenuVO();
		menu.setMenuDelyn("Y");
		List<MenuVO> menuList = menuService.getMenuList(menu);
		for (MenuVO m : menuList) {
			m.setUserAuthList(menuService.getMenuGroupList(m));
		}
		model.addAttribute("list", menuList);
		return "views/manage/menuList";
	}
	
	@RequestMapping(value="/manage/insMenu.do", method=RequestMethod.POST)
	@ResponseBody
	public String insMenu(MenuVO menu) {
		menuService.insMenu(menu);
		return "success";
	}
	
	@RequestMapping(value="/manage/updMenu.do", method=RequestMethod.POST)
	@ResponseBody
	public String updMenu(@RequestBody List<MenuVO> updMenuList) {
		if (updMenuList.size() == 1) {
			menuService.updMenu(updMenuList.get(0));
		} else {
			menuService.updMenuOrder(updMenuList);
		}
		
		return "success";
	}
	
	@RequestMapping(value="/manage/delMenu.do", method=RequestMethod.POST)
	@ResponseBody
	public String delMenu(MenuVO menu) {
		return "success";
	}
	
}
