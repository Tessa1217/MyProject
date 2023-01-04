package egovframework.fusion.survey.vo;

import java.util.List;

public class SurveyQuestionVO extends SurveyQuestion {

	private Integer questionLevel;
	
	private List<SurveyOptionVO> optionList;
	
	private List<SurveyAnswerVO> answerList;
	
	private String categoryDesc;

	public Integer getQuestionLevel() {
		return questionLevel;
	}

	public void setQuestionLevel(Integer questionLevel) {
		this.questionLevel = questionLevel;
	}

	public List<SurveyOptionVO> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<SurveyOptionVO> optionList) {
		this.optionList = optionList;
	}

	public String getCategoryDesc() {
		return categoryDesc;
	}

	public void setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
	}

	public List<SurveyAnswerVO> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<SurveyAnswerVO> answerList) {
		this.answerList = answerList;
	}

}
