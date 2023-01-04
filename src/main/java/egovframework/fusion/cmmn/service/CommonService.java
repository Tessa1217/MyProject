package egovframework.fusion.cmmn.service;

import java.util.List;

import egovframework.fusion.cmmn.vo.CommonCodeVO;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.cmmn.vo.Criteria;

public interface CommonService {
	
	List<CommonGroupVO> getCommonGpList(Criteria cri, CommonGroupVO vo);
	
	Integer getGpCnt(Criteria cri, CommonGroupVO vo);
	
	List<CommonCodeVO> getCommonCdList(CommonGroupVO vo);
	
	CommonGroupVO getCommonGp(CommonGroupVO vo);
	
	CommonCodeVO getCommonCd(CommonCodeVO vo);
	
	CommonGroupVO getCommonCdCnt(CommonGroupVO vo);
	
	void insGroup(CommonGroupVO vo);
	
	void insCode(CommonCodeVO vo);
	
	void updGroup(CommonGroupVO vo);
	
	void updCode(CommonCodeVO vo);
	
	Integer delGroup(CommonGroupVO vo);
	
	Integer delCode(CommonCodeVO vo);

}
