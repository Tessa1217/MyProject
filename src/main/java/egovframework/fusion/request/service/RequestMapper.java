package egovframework.fusion.request.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.request.vo.RequestVO;
import egovframework.fusion.request.vo.ResponseVO;

@Mapper
public interface RequestMapper {
	
	public List<RequestVO> getRequestList(@Param("cri") Criteria cri, @Param("req") RequestVO req);
	
	public Integer getRequestCnt(@Param("cri") Criteria cri, @Param("req") RequestVO req);
	
	public List<ResponseVO> getResponseList(ResponseVO resp);
	
	public RequestVO selRequest(RequestVO req);
	
	public void insRequest(RequestVO req);
	
	public void updRequest(RequestVO req);
	
	public void insResponse(ResponseVO resp);
	
	public void updResponse(ResponseVO resp);

}
