package egovframework.fusion.survey.vo;

import java.util.List;

public class SurveyResultVO {
	
	private Integer surveyNo;
	
	private Integer submitCnt;
	
	private List<SurveyAnswerVO> answerList;

	public Integer getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(Integer surveyNo) {
		this.surveyNo = surveyNo;
	}

	public Integer getSubmitCnt() {
		return submitCnt;
	}

	public void setSubmitCnt(Integer submitCnt) {
		this.submitCnt = submitCnt;
	}

	public List<SurveyAnswerVO> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<SurveyAnswerVO> answerList) {
		this.answerList = answerList;
	}

}
