package egovframework.fusion.survey.vo;

import java.util.Date;

public class Survey {

	private Integer surveyNo;
	
	private String participantType;
	
	private int surveyOwnerNo;
	
	private String surveyTitle;
	
	private String surveyDesc;
	
	private Date surveyRegDate;
	
	private Date surveyStartDate;
	
	private Date surveyEndDate;

	public Integer getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(Integer surveyNo) {
		this.surveyNo = surveyNo;
	}

	public String getParticipantType() {
		return participantType;
	}

	public void setParticipantTypeNo(String participantType) {
		this.participantType = participantType;
	}

	public int getSurveyOwnerNo() {
		return surveyOwnerNo;
	}

	public void setSurveyOwnerNo(int surveyOwnerNo) {
		this.surveyOwnerNo = surveyOwnerNo;
	}

	public String getSurveyTitle() {
		return surveyTitle;
	}

	public void setSurveyTitle(String surveyTitle) {
		this.surveyTitle = surveyTitle;
	}

	public String getSurveyDesc() {
		return surveyDesc;
	}

	public void setSurveyDesc(String surveyDesc) {
		this.surveyDesc = surveyDesc;
	}

	public Date getSurveyRegDate() {
		return surveyRegDate;
	}

	public void setSurveyRegDate(Date surveyRegDate) {
		this.surveyRegDate = surveyRegDate;
	}

	public Date getSurveyStartDate() {
		return surveyStartDate;
	}

	public void setSurveyStartDate(Date surveyStartDate) {
		this.surveyStartDate = surveyStartDate;
	}

	public Date getSurveyEndDate() {
		return surveyEndDate;
	}

	public void setSurveyEndDate(Date surveyEndDate) {
		this.surveyEndDate = surveyEndDate;
	}
	
	
	
}
