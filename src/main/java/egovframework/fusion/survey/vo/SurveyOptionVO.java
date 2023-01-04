package egovframework.fusion.survey.vo;

public class SurveyOptionVO {
	
	private Integer surveyNo;
	
	private Integer questionNo;
	
	private Integer optionNo;
	
	private Integer optionOrder;
	
	private String optionContent;
	
	private Integer optionTypeNo;
	
	public Integer getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(Integer surveyNo) {
		this.surveyNo = surveyNo;
	}

	public Integer getOptionNo() {
		return optionNo;
	}

	public void setOptionNo(Integer optionNo) {
		this.optionNo = optionNo;
	}

	public Integer getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(Integer questionNo) {
		this.questionNo = questionNo;
	}

	public String getOptionContent() {
		return optionContent;
	}

	public void setOptionContent(String optionContent) {
		this.optionContent = optionContent;
	}

	public Integer getOptionOrder() {
		return optionOrder;
	}

	public void setOptionOrder(Integer optionOrder) {
		this.optionOrder = optionOrder;
	}

	public Integer getOptionTypeNo() {
		return optionTypeNo;
	}

	public void setOptionTypeNo(Integer optionTypeNo) {
		this.optionTypeNo = optionTypeNo;
	}
	
	
}
