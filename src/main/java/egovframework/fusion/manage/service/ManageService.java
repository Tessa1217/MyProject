package egovframework.fusion.manage.service;

import java.util.List;

import egovframework.fusion.manage.vo.MenuLogVO;
import egovframework.fusion.manage.vo.MenuVO;

public interface ManageService {
	
	public List<MenuVO> getMenuList(MenuVO vo);
	
	public List<String> getMenuGroupList(MenuVO vo);
	
	public List<MenuLogVO> getMenuStatList(MenuLogVO vo);
	
	public MenuVO selMenu(MenuVO vo);
	
	public void insMenu(MenuVO vo);
	
	public void insMenuLog(MenuLogVO vo);
	
	public void updMenu(MenuVO vo);
	
	public void updMenuOrder(List<MenuVO> menuList);
	
}
