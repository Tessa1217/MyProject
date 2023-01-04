package egovframework.fusion.cmmn.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.cmmn.vo.CommonCodeVO;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.cmmn.vo.Criteria;

@Mapper
public interface CommonMapper {
	
	List<CommonGroupVO> getCommonGpList(@Param("cri") Criteria cri, 
										@Param("gp") CommonGroupVO vo);
	
	Integer getGpCnt(@Param("cri")Criteria cri, 
					 @Param("gp") CommonGroupVO vo);
	
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
