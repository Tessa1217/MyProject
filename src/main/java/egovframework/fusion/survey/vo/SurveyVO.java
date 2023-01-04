package egovframework.fusion.survey.vo;

import java.util.Date;

public class SurveyVO extends Survey {
	
	private String participantTypeDesc;
	
	private String surveyOwnerName;
	
	private Integer dateDifference;
	
	private Date winnerDate;
	
	private Integer questionLength;
	
	private SurveySubmitVO surveySubmit;
	
	private Integer requiredQuestionCnt;

	public String getParticipantTypeDesc() {
		return participantTypeDesc;
	}

	public void setParticipantTypeDesc(String participantTypeDesc) {
		this.participantTypeDesc = participantTypeDesc;
	}

	public String getSurveyOwnerName() {
		return surveyOwnerName;
	}

	public void setSurveyOwnerName(String surveyOwnerName) {
		this.surveyOwnerName = surveyOwnerName;
	}

	public Integer getDateDifference() {
		return dateDifference;
	}

	public void setDateDifference(Integer dateDifference) {
		this.dateDifference = dateDifference;
	}

	public Date getWinnerDate() {
		return winnerDate;
	}

	public void setWinnerDate(Date winnerDate) {
		this.winnerDate = winnerDate;
	}

	public Integer getQuestionLength() {
		return questionLength;
	}

	public void setQuestionLength(Integer questionLength) {
		this.questionLength = questionLength;
	}

	public SurveySubmitVO getSurveySubmit() {
		return surveySubmit;
	}

	public void setSurveySubmit(SurveySubmitVO surveySubmit) {
		this.surveySubmit = surveySubmit;
	}

	public Integer getRequiredQuestionCnt() {
		return requiredQuestionCnt;
	}

	public void setRequiredQuestionCnt(Integer requiredQuestionCnt) {
		this.requiredQuestionCnt = requiredQuestionCnt;
	}
	
}
