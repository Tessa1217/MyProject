package egovframework.fusion.cmmn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.cmmn.service.CommonMapper;
import egovframework.fusion.cmmn.service.CommonService;
import egovframework.fusion.cmmn.vo.CommonCodeVO;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.cmmn.vo.Criteria;

@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	CommonMapper commonMapper;

	@Override
	public List<CommonGroupVO> getCommonGpList(Criteria cri, CommonGroupVO vo) {
		return commonMapper.getCommonGpList(cri, vo);
	}
	
	@Override
	public Integer getGpCnt(Criteria cri, CommonGroupVO vo) {
		return commonMapper.getGpCnt(cri, vo);
	}
	
	@Override
	public List<CommonCodeVO> getCommonCdList(CommonGroupVO vo) {
		return commonMapper.getCommonCdList(vo);
	}

	@Override
	public CommonGroupVO getCommonGp(CommonGroupVO vo) {
		return commonMapper.getCommonGp(vo);
	}

	@Override
	public CommonCodeVO getCommonCd(CommonCodeVO vo) {
		return commonMapper.getCommonCd(vo);
	}

	@Override
	public CommonGroupVO getCommonCdCnt(CommonGroupVO vo) {
		return commonMapper.getCommonCdCnt(vo);
	}

	
	@Override
	public void insGroup(CommonGroupVO vo) {
		commonMapper.insGroup(vo);
	}

	@Override
	public void insCode(CommonCodeVO vo) {
		commonMapper.insCode(vo);
	}
	
	@Override
	public void updGroup(CommonGroupVO vo) {
		commonMapper.updGroup(vo);
	}

	@Override
	public void updCode(CommonCodeVO vo) {
		commonMapper.updCode(vo);
	}

	@Override
	public Integer delGroup(CommonGroupVO vo) {
		return commonMapper.delGroup(vo);
	}

	@Override
	public Integer delCode(CommonCodeVO vo) {
		return commonMapper.delCode(vo);
	}


}
