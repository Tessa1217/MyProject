package egovframework.fusion.request.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.request.service.RequestMapper;
import egovframework.fusion.request.service.RequestService;
import egovframework.fusion.request.vo.RequestVO;
import egovframework.fusion.request.vo.ResponseVO;

@Service
public class RequestServiceImpl implements RequestService {
	
	@Autowired
	RequestMapper requestMapper;

	@Override
	public List<RequestVO> getRequestList(Criteria cri, RequestVO req) {
		return requestMapper.getRequestList(cri, req);
	}

	@Override
	public Integer getRequestCnt(Criteria cri, RequestVO req) {
		return requestMapper.getRequestCnt(cri, req);
	}

	@Override
	public List<ResponseVO> getResponseList(ResponseVO resp) {
		return requestMapper.getResponseList(resp);
	}

	@Override
	public RequestVO selRequest(RequestVO req) {
		return requestMapper.selRequest(req);
	}

	@Override
	public void insRequest(RequestVO req) {
		requestMapper.insRequest(req);
	}

	@Override
	public void updRequest(RequestVO req) {
		requestMapper.updRequest(req);
	}

	@Override
	public void insResponse(ResponseVO resp) {
		requestMapper.insResponse(resp);
	}

	@Override
	public void updResponse(ResponseVO resp) {
		requestMapper.updResponse(resp);
	}


}
