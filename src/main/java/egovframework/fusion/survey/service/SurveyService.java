package egovframework.fusion.survey.service;

import java.util.List;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.survey.vo.SurveyAnswerVO;
import egovframework.fusion.survey.vo.SurveyOptionVO;
import egovframework.fusion.survey.vo.SurveyQuestionVO;
import egovframework.fusion.survey.vo.SurveyResultVO;
import egovframework.fusion.survey.vo.SurveySubmitVO;
import egovframework.fusion.survey.vo.SurveyVO;

public interface SurveyService {
	
	public List<SurveyVO> getSurveyList(Criteria cri);
	
	public List<SurveyQuestionVO> getQuestionList(SurveyQuestionVO vo, Criteria cri);
	
	public List<SurveyAnswerVO> getAnswerList(SurveyAnswerVO vo);
	
	public Integer getSurveyCnt(Criteria cri);
	
	public Integer getQuestionCnt(SurveyQuestionVO vo);
	
	public List<SurveyOptionVO> getOptionList(SurveyQuestionVO vo);
	
	public Integer getRequiredQuestionCnt(SurveyQuestionVO vo);
	
	public Integer getCompleteQuestionCnt(SurveyAnswerVO vo);
	
	public SurveyVO selectSurvey(SurveyVO vo);
	
	public SurveySubmitVO selectSurveySubmit(SurveySubmitVO vo);
	
	public SurveyResultVO selectSurveyResult(SurveyResultVO vo);
	
	public void insSurveyAnswer(SurveyAnswerVO vo);
	
	public void insSurveySubmit(SurveySubmitVO vo);
	
	public void updSurveySubmit(SurveySubmitVO vo);
	
	public void delSurveyAnswer(SurveyAnswerVO vo, List<SurveyAnswerVO> list);

}
