package egovframework.fusion.request.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.request.vo.RequestVO;
import egovframework.fusion.request.vo.ResponseVO;

public interface RequestService {
	
	public List<RequestVO> getRequestList(Criteria cri, RequestVO req);
	
	public Integer getRequestCnt(Criteria cri, RequestVO req);
	
	public List<ResponseVO> getResponseList(ResponseVO resp);
	
	public RequestVO selRequest(RequestVO req);
	
	public void insRequest(RequestVO req);
	
	public void updRequest(RequestVO req);
	
	public void insResponse(ResponseVO resp);
	
	public void updResponse(ResponseVO resp);


}
