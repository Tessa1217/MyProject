package egovframework.fusion.request.vo;

import java.util.List;

public class RequestVO extends Request {
	
	private String requesterNm;
	
	private Integer reqReviewNo;
	
	private List<ResponseVO> responseList;
	
	private Integer objCnt;
	
	public String getRequesterNm() {
		return requesterNm;
	}

	public void setRequesterNm(String requesterNm) {
		this.requesterNm = requesterNm;
	}
	
	public Integer getReqReviewNo() {
		return reqReviewNo;
	}

	public void setReqReviewNo(Integer reqReviewNo) {
		this.reqReviewNo = reqReviewNo;
	}

	public List<ResponseVO> getResponseList() {
		return responseList;
	}

	public void setResponseList(List<ResponseVO> responseList) {
		this.responseList = responseList;
	}

	public Integer getObjCnt() {
		return objCnt;
	}

	public void setObjCnt(Integer objCnt) {
		this.objCnt = objCnt;
	}
	
}
