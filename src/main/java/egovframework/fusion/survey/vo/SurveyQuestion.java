package egovframework.fusion.survey.vo;

public class SurveyQuestion {
	
	private Integer surveyNo;
	
	private Integer questionNo;
	
	private Integer questionTypeNo;
	
	private Integer categoryNo;
	
	private Integer questionOrder;
	
	private String questionContent;
	
	private Integer parentQuestionNo;
	
	private String questionReqyn;
	
	private Integer questionAnsCnt;

	public Integer getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(Integer questionNo) {
		this.questionNo = questionNo;
	}

	public Integer getQuestionTypeNo() {
		return questionTypeNo;
	}

	public void setQuestionTypeNo(Integer questionTypeNo) {
		this.questionTypeNo = questionTypeNo;
	}

	public Integer getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(Integer categoryNo) {
		this.categoryNo = categoryNo;
	}

	public Integer getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(Integer surveyNo) {
		this.surveyNo = surveyNo;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public Integer getQuestionOrder() {
		return questionOrder;
	}

	public void setQuestionOrder(Integer questionOrder) {
		this.questionOrder = questionOrder;
	}

	public Integer getParentQuestionNo() {
		return parentQuestionNo;
	}

	public void setParentQuestionNo(Integer parentQuestionNo) {
		this.parentQuestionNo = parentQuestionNo;
	}

	public String getQuestionReqyn() {
		return questionReqyn;
	}

	public void setQuestionReqyn(String questionReqyn) {
		this.questionReqyn = questionReqyn;
	}

	public Integer getQuestionAnsCnt() {
		return questionAnsCnt;
	}

	public void setQuestionAnsCnt(Integer questionAnsCnt) {
		this.questionAnsCnt = questionAnsCnt;
	}
	
	
}
