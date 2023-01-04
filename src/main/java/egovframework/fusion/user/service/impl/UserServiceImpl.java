package egovframework.fusion.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.user.service.UserMapper;
import egovframework.fusion.user.service.UserService;
import egovframework.fusion.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserMapper userMapper;

	@Override
	public UserVO loginChk(UserVO userVO) {
		return userMapper.getUser(userVO);
	}

	@Override
	public void signIn(UserVO userVO) {
		userMapper.insUser(userVO);
	}

	@Override
	public UserVO idCheck(UserVO userVO) {
		return userMapper.getId(userVO);
	}

	@Override
	public List<UserVO> getUserList(UserVO userVO) {
		return userMapper.getUserList(userVO);
	}
	
}
