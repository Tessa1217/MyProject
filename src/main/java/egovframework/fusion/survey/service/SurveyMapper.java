package egovframework.fusion.survey.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.survey.vo.SurveyAnswerVO;
import egovframework.fusion.survey.vo.SurveyOptionVO;
import egovframework.fusion.survey.vo.SurveyQuestionVO;
import egovframework.fusion.survey.vo.SurveyResultVO;
import egovframework.fusion.survey.vo.SurveySubmitVO;
import egovframework.fusion.survey.vo.SurveyVO;

@Mapper
public interface SurveyMapper {

	public List<SurveyVO> getSurveyList(Criteria cri);
	
	public List<SurveyQuestionVO> getQuestionList(@Param("question") SurveyQuestionVO vo, 
												  @Param("cri") Criteria cri);
	
	public Integer getSurveyCnt(Criteria cri);
	
	public List<SurveyOptionVO> getOptionList(SurveyQuestionVO vo);
	
	public List<SurveyAnswerVO> getAnswerList(SurveyAnswerVO vo);
	
	public List<SurveyAnswerVO> getAnswerResultList(SurveyResultVO vo);
	
	public Integer getQuestionCnt(SurveyQuestionVO vo);
	
	public Integer getRequiredQuestionCnt(SurveyQuestionVO vo);
	
	public Integer getCompleteQuestionCnt(SurveyAnswerVO vo);
	
	public Integer getSubmitCnt(SurveyResultVO vo);
	
	public SurveyVO selectSurvey(SurveyVO vo);
	
	public SurveySubmitVO selectSurveySubmit(SurveySubmitVO vo);
	
	public void insSurveyAnswer(SurveyAnswerVO vo);
	
	public void insSurveySubmit(SurveySubmitVO vo);
	
	public void updSurveySubmit(SurveySubmitVO vo);
	
	public void delSurveyAnswer(@Param("survey") SurveyAnswerVO vo, 
								@Param("list") List<SurveyAnswerVO> list);
	
}
