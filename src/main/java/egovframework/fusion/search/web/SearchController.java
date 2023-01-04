package egovframework.fusion.search.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.manage.service.ManageService;
import egovframework.fusion.manage.vo.MenuVO;
import egovframework.fusion.survey.service.SurveyService;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class SearchController {
	
	@Autowired
	ManageService menageService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	SurveyService surveyService;
	
	@RequestMapping(value="/search/totalSearch.do", method=RequestMethod.GET)
	public String getTotalSearchResult(Criteria cri, Model model, HttpSession session) {
		UserVO user = null;
		if (session.getAttribute("user") != null) {
			user = (UserVO) session.getAttribute("user");
		} else {
			user = new UserVO();
			user.setUserAuth("USER");
		}
		int totalCnt = 0;
		MenuVO vo = new MenuVO();
		vo.setUserAuthCode(user.getUserAuth());
		List<MenuVO> menuList = menageService.getMenuList(vo);
		List<HashMap<String, Object>> mapList = new ArrayList<HashMap<String, Object>>();
		for (MenuVO menu : menuList) {
			HashMap<String, Object> map = new HashMap<>();
			if (menu.getMenuPath().startsWith("/board")) {
				BoardVO board = new BoardVO();
				Integer typeIdx = menu.getMenuPath().indexOf("=");
				Integer bulletinIdx = menu.getMenuParameter().indexOf("=");
				board.setBoardTypeNo(menu.getMenuPath().substring(typeIdx + 1));
				board.setBulletinNo(Integer.parseInt(menu.getMenuParameter().substring(bulletinIdx + 1)));
				map.put("list", boardService.getBoardList(board, cri));
				Integer count = boardService.getBoardListCnt(board, cri);
				totalCnt += count;
				map.put("listCnt", count);
				map.put("menu", menu);
			} else if (menu.getMenuPath().startsWith("/survey")) {
				map.put("surveyList", surveyService.getSurveyList(cri));
				Integer count = surveyService.getSurveyCnt(cri);
				totalCnt += count;
				map.put("listCnt", count);
				map.put("menu", menu);
			}
			mapList.add(map);
		}
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("mapList", mapList);
		model.addAttribute("menuLength", menuList.size());
		model.addAttribute("cri", cri);
		return "views/search/search";
	}
	
}
