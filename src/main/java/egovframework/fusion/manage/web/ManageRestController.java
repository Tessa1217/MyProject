package egovframework.fusion.manage.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import egovframework.fusion.cmmn.service.CommonService;
import egovframework.fusion.cmmn.vo.CommonCodeVO;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.manage.service.ManageService;
import egovframework.fusion.manage.vo.MenuLogVO;

@RestController
public class ManageRestController {
	
	@Autowired
	ManageService manageService;
	
	@Autowired
	CommonService commonService;
	
	@RequestMapping(value="/manage/menuStatistics.do", method=RequestMethod.GET)
	public ModelAndView getMenuStats(MenuLogVO menuLogVO) {
		
		if (menuLogVO.getMenuStatType() == null) {
			menuLogVO.setMenuStatType("year");
		}
		
		List<MenuLogVO> menuLogList = manageService.getMenuStatList(menuLogVO);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("statList", menuLogList);
		mv.addObject("menu", menuLogVO);
		mv.setViewName("views/manage/menuStatistics");
		
		return mv;
	}
	
	@RequestMapping(value="/manage/groupList.do", method=RequestMethod.POST)
	public List<CommonGroupVO> getGroupList(String param) {
		return commonService.getCommonGpList(null, null);
	}
	
	@RequestMapping(value="/manage/codeList.do", method=RequestMethod.POST)
	public List<CommonCodeVO> getCodeList(CommonGroupVO groupVO) {
		return commonService.getCommonCdList(groupVO); 
	}
	
	@RequestMapping(value="/manage/getCommonGp.do", method=RequestMethod.POST)
	public CommonGroupVO getCommonGp(CommonGroupVO groupVO) {
		return commonService.getCommonGp(groupVO);
	}
	
	@RequestMapping(value="/manage/getCommonCd.do", method=RequestMethod.POST)
	public CommonCodeVO getCommonGd(CommonCodeVO codeVO) {
		return commonService.getCommonCd(codeVO);
	}
	
	@RequestMapping(value = "/manage/insGroup.do", method=RequestMethod.POST)
	public String insGroup(@RequestBody CommonGroupVO groupVO) {
		commonService.insGroup(groupVO);
		return "success";
	}
	
	@RequestMapping(value="/manage/insCode.do", method=RequestMethod.POST)
	public String insCode(@RequestBody CommonCodeVO codeVO) {
		commonService.insCode(codeVO);
		return "success";
	}
	
	@RequestMapping(value="/manage/updCode.do", method=RequestMethod.POST)
	public String updCode(@RequestBody List<CommonCodeVO> codeList) {
		for (CommonCodeVO code : codeList) {
			commonService.updCode(code);
		}
		return "success";
	}
	
	@RequestMapping(value="/manage/updGroup.do", method=RequestMethod.POST)
	public String updGroup(@RequestBody CommonGroupVO groupVO) {
		commonService.updGroup(groupVO);
		return "success";
	}
	
	@RequestMapping(value="/manage/delGroup.do", method=RequestMethod.POST)
	public Integer delGroup(@RequestBody List<CommonGroupVO> groupList) {
		Integer deleteRow = 0;
		for (CommonGroupVO group : groupList) {
			deleteRow += commonService.delGroup(group);
		}
		return deleteRow;
	}
	
	@RequestMapping(value="/manage/delCode.do", method=RequestMethod.POST)
	public Integer delCode(@RequestBody List<CommonCodeVO> codeList) {
		Integer deleteRow = 0;
		for (CommonCodeVO code : codeList) {
			deleteRow += commonService.delCode(code);
		}
		return deleteRow;
	}
	
	@RequestMapping(value="/manage/getCommonCdCnt.do", method=RequestMethod.POST)
	public List<CommonGroupVO> getCommonCdCnt(@RequestBody List<CommonGroupVO> groupList) {
		List<CommonGroupVO> cntList = new ArrayList<CommonGroupVO>();
		for (int i = 0; i < groupList.size(); i++) {
			cntList.add(commonService.getCommonCdCnt(groupList.get(i)));
		}
		return cntList;
	}
}
