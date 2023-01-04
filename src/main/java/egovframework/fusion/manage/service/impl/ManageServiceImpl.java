package egovframework.fusion.manage.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.fusion.manage.service.ManageMapper;
import egovframework.fusion.manage.service.ManageService;
import egovframework.fusion.manage.vo.MenuLogVO;
import egovframework.fusion.manage.vo.MenuVO;

@Service
public class ManageServiceImpl implements ManageService {

	@Autowired
	ManageMapper manageMapper;
	
	@Override
	public List<MenuVO> getMenuList(MenuVO vo) {
		return manageMapper.getMenuList(vo);
	}
	
	@Override
	public List<String> getMenuGroupList(MenuVO vo) {
		return manageMapper.getMenuGroupList(vo);
	}

	@Override
	public MenuVO selMenu(MenuVO vo) {
		return manageMapper.selMenu(vo);
	}

	@Override
	@Transactional
	public void insMenu(MenuVO vo) {
		manageMapper.insMenu(vo);
		for (String authCode : vo.getUserAuthCode().split(",")) {
			MenuVO menu = new MenuVO();
			menu.setMenuNo(vo.getMenuNo());
			menu.setUserAuthCode(authCode);
			manageMapper.insMenuGroup(menu);
		}
	}
	
	@Override
	public void insMenuLog(MenuLogVO vo) {
		manageMapper.insMenuLog(vo);
	}

	@Override
	@Transactional
	public void updMenu(MenuVO vo) {
		manageMapper.updMenu(vo);
		manageMapper.delMenuGroup(vo);
		for (String authCode : vo.getUserAuthCode().split(",")) {
			MenuVO menu = new MenuVO();
			menu.setMenuNo(vo.getMenuNo());
			menu.setUserAuthCode(authCode);
			manageMapper.insMenuGroup(menu);
		}
	}

	@Override
	public List<MenuLogVO> getMenuStatList(MenuLogVO vo) {
		return manageMapper.getMenuStatList(vo);
	}

	@Override
	public void updMenuOrder(List<MenuVO> menuList) {
		manageMapper.updMenuOrder(menuList);
	}

}
