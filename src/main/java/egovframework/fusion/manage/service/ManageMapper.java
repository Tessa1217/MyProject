package egovframework.fusion.manage.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.manage.vo.MenuLogVO;
import egovframework.fusion.manage.vo.MenuVO;

@Mapper
public interface ManageMapper {
	
	public List<MenuVO> getMenuList(MenuVO vo);
	
	public List<String> getMenuGroupList(MenuVO vo);
	
	public List<MenuLogVO> getMenuStatList(MenuLogVO vo);
	
	public MenuVO selMenu(MenuVO vo);
	
	public void insMenu(MenuVO vo);
	
	public void insMenuGroup(MenuVO vo);
	
	public void insMenuLog(MenuLogVO vo);
	
	public void updMenu(MenuVO vo);
	
	public void updMenuOrder(List<MenuVO> menuList);
	
	public void updMenuGroup(MenuVO vo);
	
	public void delMenuGroup(MenuVO vo);

}
