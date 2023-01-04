package egovframework.fusion.user.service;

import java.util.List;

import egovframework.fusion.user.vo.UserVO;

public interface UserService {
	
	/* 로그인 체크 */
	public UserVO loginChk(UserVO userVO);
	
	/* 아이디 중복 체크 */
	public UserVO idCheck(UserVO userVO);
	
	/* 회원가입 */
	public void signIn(UserVO userVO);
	
	/* 회원 목록 */
	public List<UserVO> getUserList(UserVO userVO);

}
