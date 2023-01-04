package egovframework.fusion.user.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.user.vo.UserVO;

@Mapper
public interface UserMapper {
	
	/* 로그인 체크 */
	public UserVO getUser(UserVO userVO);
	
	/* 아이디 중복 체크 */
	public UserVO getId(UserVO userVO);
	
	/* 회원가입 */
	public void insUser(UserVO userVO);
	
	/* 회원 목록 */
	public List<UserVO> getUserList(UserVO userVO);

}
