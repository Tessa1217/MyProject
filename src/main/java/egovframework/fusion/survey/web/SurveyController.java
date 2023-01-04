/*********************************************************************
 * 업 무 명 : 설문 컨트롤러
 * 설 명 : 설문 화면에서 사용 
 * 작 성 자 : 권유진
 * 작 성 일 : 2022.11.30
 * 관련테이블 : SURVEY, SURVEY_ANSWER, SURVEY_QUESTION, 
 	         SURVEY_QUESTION_OPTION, SURVEY_OPTION  
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************************/
package egovframework.fusion.survey.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.cmmn.vo.PageDTO;
import egovframework.fusion.survey.service.SurveyService;
import egovframework.fusion.survey.vo.SurveyAnswerVO;
import egovframework.fusion.survey.vo.SurveyQuestionVO;
import egovframework.fusion.survey.vo.SurveyResultVO;
import egovframework.fusion.survey.vo.SurveySubmitVO;
import egovframework.fusion.survey.vo.SurveyVO;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class SurveyController {
	
	@Autowired
	SurveyService surveyService;
	
	@RequestMapping(value="/survey/surveyList.do", method=RequestMethod.GET)
	public String getSurveyList(SurveyVO surveyVO, Criteria cri, Model model, HttpSession session) {
		Integer userType = 1;
		UserVO user = (UserVO) session.getAttribute("user");
		
		if (user != null) {
			if (user.getUserAuth().contains("ADMIN")) {
				userType = 0;
			}
		}
		
		PageDTO paginationInfo = new PageDTO();
		paginationInfo.setCurrentPageNo(cri.getPageIndex());
		paginationInfo.setRecordCountPerPage(cri.getRecordCountPerPage());
		paginationInfo.setPageSize(cri.getPageSize());
		paginationInfo.setTotalRecordCount(surveyService.getSurveyCnt(cri));
		
		List<SurveyVO> surveyList = surveyService.getSurveyList(cri);
		for (SurveyVO survey : surveyList) {
			if ("MEMBER".equals(survey.getParticipantType()) && user != null) {
				SurveySubmitVO submitVo = new SurveySubmitVO();
				submitVo.setSurveyNo(survey.getSurveyNo());
				submitVo.setSubmitterNo(String.valueOf(user.getUserNo()));
				survey.setSurveySubmit(surveyService.selectSurveySubmit(submitVo));
			}
		}
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("cri", cri);
		model.addAttribute("surveyList", surveyList);
		model.addAttribute("userType", userType);
		return "views/survey/surveyList";
	}
	
	@RequestMapping(value={"/survey/selSurvey.do", "/survey/modSurvey.do"}, method=RequestMethod.GET)
	public String selSurvey(SurveyVO surveyVo, Model model, HttpServletRequest request, HttpSession session) {
		Integer surveyType = 1;
		surveyVo = surveyService.selectSurvey(surveyVo);
		if (surveyVo == null) {
			model.addAttribute("errorType", 2);
			return "views/survey/surveyError";
		}
		
		UserVO user = (UserVO) session.getAttribute("user");
		
		String submitterNo = "";
		if ("MEMBER".equals(surveyVo.getParticipantType())) {
			if (user == null) {
				model.addAttribute("errorType", 1);
				return "views/survey/surveyError";
			}
			submitterNo = String.valueOf(user.getUserNo());
		} else if ("USER".equals(surveyVo.getParticipantType())) {
			submitterNo = RandomStringUtils.randomAlphabetic(30);
		}
		if (request.getRequestURI().contains("mod")) {
			surveyType = 2;
		}
		model.addAttribute("submitterNo", submitterNo);
		model.addAttribute("survey", surveyVo);
		model.addAttribute("surveyType", surveyType);
		return "views/survey/selSurvey";
	}
	
	@RequestMapping(value="/survey/surveyResult.do", method=RequestMethod.GET)
	public String surveyResult(SurveyVO survey, Model model, Criteria cri) {
		
		cri.setRecordCountPerPage(5);
		PageDTO paginationInfo = new PageDTO();
		paginationInfo.setRecordCountPerPage(cri.getRecordCountPerPage());
		SurveyQuestionVO questionVO = new SurveyQuestionVO();
		questionVO.setSurveyNo(survey.getSurveyNo());
		paginationInfo.setTotalRecordCount(surveyService.getQuestionCnt(questionVO));
		
		List<SurveyQuestionVO> questionList = surveyService.getQuestionList(questionVO, cri);
		for (SurveyQuestionVO question : questionList) {
			question.setOptionList(surveyService.getOptionList(question));
		}
		
		SurveyResultVO resultVO = new SurveyResultVO();
		resultVO.setSurveyNo(survey.getSurveyNo());
		resultVO = surveyService.selectSurveyResult(resultVO);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("cri", cri);
		model.addAttribute("questionList", questionList);
		model.addAttribute("result", resultVO);
		
		return "views/survey/adminSurveyQuestion";
	}
	
	@RequestMapping(value="/survey/showShortForm.do", method=RequestMethod.POST)
	@ResponseBody
	public List<SurveyAnswerVO> showShortForm(@RequestBody SurveyAnswerVO answer) {
		List<SurveyAnswerVO> ansList = new ArrayList<SurveyAnswerVO>();
		ansList = surveyService.getAnswerList(answer);
		return ansList;
	}
	
	@RequestMapping(value="/survey/takeSurvey.do", method=RequestMethod.GET)
	public String selSurveyQuestion(SurveyQuestionVO questionVO, 
									String submitterNo,
									Model model, 
									Criteria cri, 
									HttpSession session) {

		cri.setRecordCountPerPage(5);
		PageDTO paginationInfo = new PageDTO();
		paginationInfo.setRecordCountPerPage(cri.getRecordCountPerPage());
		paginationInfo.setTotalRecordCount(surveyService.getQuestionCnt(questionVO));
		
		SurveyAnswerVO answerVo = new SurveyAnswerVO();
		answerVo.setSurveyNo(questionVO.getSurveyNo());
		answerVo.setSubmitterNo(submitterNo);
		
		List<SurveyQuestionVO> questionList = surveyService.getQuestionList(questionVO, cri);
		
		for (SurveyQuestionVO question : questionList) {
			question.setOptionList(surveyService.getOptionList(question));
			answerVo.setQuestionNo(question.getQuestionNo());
			question.setAnswerList(surveyService.getAnswerList(answerVo));
		}
		
		model.addAttribute("questionList", questionList);
		model.addAttribute("submitterNo", submitterNo);
		model.addAttribute("surveyNo", questionVO.getSurveyNo());
		model.addAttribute("reqQCnt", surveyService.getRequiredQuestionCnt(questionVO));
		model.addAttribute("comQCnt", surveyService.getCompleteQuestionCnt(answerVo));
		model.addAttribute("cri", cri);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "views/survey/selSurveyQuestion";
	}
	
	@RequestMapping(value="/survey/insAnswer.do", method=RequestMethod.POST)
	@ResponseBody
	public String insAnswer(@RequestBody SurveySubmitVO submit, 
								HttpServletRequest request, 
								HttpServletResponse response) {
		
		String message = "";
		if (surveyService.selectSurveySubmit(submit) != null) {
			message = "modify";
			surveyService.updSurveySubmit(submit);
			SurveyAnswerVO answer = new SurveyAnswerVO();
			answer.setSurveyNo(submit.getSurveyNo());
			answer.setSubmitterNo(submit.getSubmitterNo());
			surveyService.delSurveyAnswer(answer, submit.getAnswerList());
		} else {
			message = "submit";
			surveyService.insSurveySubmit(submit);
		}
		
		for (SurveyAnswerVO answer : submit.getAnswerList()) {
			surveyService.insSurveyAnswer(answer);
		}
		return message;
	}

}
