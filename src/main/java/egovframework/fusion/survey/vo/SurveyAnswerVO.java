package egovframework.fusion.survey.vo;

public class SurveyAnswerVO {
	
	private Integer answerNo;
	
	private Integer surveyNo;
	
	private Integer questionNo;
	
	private String submitterNo;
	
	private Integer optionNo;
	
	private String answerText;
	
	private Integer answerCnt;

	public Integer getAnswerNo() {
		return answerNo;
	}

	public void setAnswerNo(Integer answerNo) {
		this.answerNo = answerNo;
	}

	public Integer getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(Integer surveyNo) {
		this.surveyNo = surveyNo;
	}

	public Integer getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(Integer questionNo) {
		this.questionNo = questionNo;
	}

	public String getSubmitterNo() {
		return submitterNo;
	}

	public void setSubmitterNo(String submitterNo) {
		this.submitterNo = submitterNo;
	}

	public Integer getOptionNo() {
		return optionNo;
	}

	public void setOptionNo(Integer optionNo) {
		this.optionNo = optionNo;
	}

	public String getAnswerText() {
		return answerText;
	}

	public void setAnswerText(String answerText) {
		this.answerText = answerText;
	}

	public Integer getAnswerCnt() {
		return answerCnt;
	}

	public void setAnswerCnt(Integer answerCnt) {
		this.answerCnt = answerCnt;
	}

}
