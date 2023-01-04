package egovframework.fusion.survey.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.survey.service.SurveyMapper;
import egovframework.fusion.survey.service.SurveyService;
import egovframework.fusion.survey.vo.SurveyAnswerVO;
import egovframework.fusion.survey.vo.SurveyOptionVO;
import egovframework.fusion.survey.vo.SurveyQuestionVO;
import egovframework.fusion.survey.vo.SurveyResultVO;
import egovframework.fusion.survey.vo.SurveySubmitVO;
import egovframework.fusion.survey.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired
	SurveyMapper surveyMapper;
	
	@Override
	public List<SurveyVO> getSurveyList(Criteria cri) {
		return surveyMapper.getSurveyList(cri);
	}

	@Override
	public List<SurveyQuestionVO> getQuestionList(SurveyQuestionVO vo, Criteria cri) {
		return surveyMapper.getQuestionList(vo, cri);
	}
	
	@Override
	public List<SurveyAnswerVO> getAnswerList(SurveyAnswerVO vo) {
		return surveyMapper.getAnswerList(vo);
	}
	
	@Override
	public Integer getSurveyCnt(Criteria cri) {
		return surveyMapper.getSurveyCnt(cri);
	}
	
	@Override
	public Integer getQuestionCnt(SurveyQuestionVO vo) {
		return surveyMapper.getQuestionCnt(vo);
	}

	@Override
	public List<SurveyOptionVO> getOptionList(SurveyQuestionVO vo) {
		return surveyMapper.getOptionList(vo);
	}

	@Override
	public SurveyVO selectSurvey(SurveyVO vo) {
		return surveyMapper.selectSurvey(vo);
	}
	
	@Override
	public SurveySubmitVO selectSurveySubmit(SurveySubmitVO vo) {
		return surveyMapper.selectSurveySubmit(vo);
	}

	@Override
	public void insSurveyAnswer(SurveyAnswerVO vo) {
		surveyMapper.insSurveyAnswer(vo);
	}

	@Override
	public void insSurveySubmit(SurveySubmitVO vo) {
		surveyMapper.insSurveySubmit(vo);
	}
	

	@Override
	public void updSurveySubmit(SurveySubmitVO vo) {
		surveyMapper.updSurveySubmit(vo);
	}

	@Override
	public void delSurveyAnswer(SurveyAnswerVO vo, List<SurveyAnswerVO> list) {
		surveyMapper.delSurveyAnswer(vo, list);
	}

	@Override
	public Integer getRequiredQuestionCnt(SurveyQuestionVO vo) {
		return surveyMapper.getRequiredQuestionCnt(vo);
	}

	@Override
	public Integer getCompleteQuestionCnt(SurveyAnswerVO vo) {
		return surveyMapper.getCompleteQuestionCnt(vo);
	}

	@Override
	public SurveyResultVO selectSurveyResult(SurveyResultVO vo) {
		vo.setSubmitCnt(surveyMapper.getSubmitCnt(vo));
		vo.setAnswerList(surveyMapper.getAnswerResultList(vo));
		return vo;
	}

}
