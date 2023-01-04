package egovframework.fusion.request.vo;

public class Request {
	
	private Integer reqNo;
	
	private Integer requesterNo;
	
	private String reqTitle;
	
	private String reqContent;
	
	private String reqRegDate;
	
	private String reqModDate;
	
	private Integer reqStage;
	
	private String reqApproveyn;

	public Integer getReqNo() {
		return reqNo;
	}

	public void setReqNo(Integer reqNo) {
		this.reqNo = reqNo;
	}

	public Integer getRequesterNo() {
		return requesterNo;
	}

	public void setRequesterNo(Integer requesterNo) {
		this.requesterNo = requesterNo;
	}

	public String getReqTitle() {
		return reqTitle;
	}

	public void setReqTitle(String reqTitle) {
		this.reqTitle = reqTitle;
	}

	public String getReqContent() {
		return reqContent;
	}

	public void setReqContent(String reqContent) {
		this.reqContent = reqContent;
	}

	public String getReqRegDate() {
		return reqRegDate;
	}

	public void setReqRegDate(String reqRegDate) {
		this.reqRegDate = reqRegDate;
	}

	public String getReqModDate() {
		return reqModDate;
	}

	public void setReqModDate(String reqModDate) {
		this.reqModDate = reqModDate;
	}

	public Integer getReqStage() {
		return reqStage;
	}

	public void setReqStage(Integer reqStage) {
		this.reqStage = reqStage;
	}

	public String getReqApproveyn() {
		return reqApproveyn;
	}

	public void setReqApproveyn(String reqApproveyn) {
		this.reqApproveyn = reqApproveyn;
	}
	
}
