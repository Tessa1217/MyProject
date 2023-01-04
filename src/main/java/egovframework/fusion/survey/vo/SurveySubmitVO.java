package egovframework.fusion.survey.vo;

import java.util.Date;
import java.util.List;

public class SurveySubmitVO {
	
	private Integer surveyNo;
	
	private String submitterNo;
	
	private Date submitRegDate;
	
	private Date submitModDate;
	
	List<SurveyAnswerVO> answerList;

	public Integer getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(Integer surveyNo) {
		this.surveyNo = surveyNo;
	}

	public String getSubmitterNo() {
		return submitterNo;
	}

	public void setSubmitterNo(String submitterNo) {
		this.submitterNo = submitterNo;
	}

	public Date getSubmitRegDate() {
		return submitRegDate;
	}

	public void setSubmitRegDate(Date submitRegDate) {
		this.submitRegDate = submitRegDate;
	}

	public Date getSubmitModDate() {
		return submitModDate;
	}

	public void setSubmitModDate(Date submitModDate) {
		this.submitModDate = submitModDate;
	}

	public List<SurveyAnswerVO> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<SurveyAnswerVO> answerList) {
		this.answerList = answerList;
	}
	
}
