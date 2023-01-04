/*********************************************************************
 * 업 무 명 : 요청 API 컨트롤러
 * 설 명 : 요청 조회/생성/수정/삭제 화면에서 사용 
 * 작 성 자 : 권유진
 * 작 성 일 : 2022.11.30
 * 관련테이블 : REQUEST, RESPONSE 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************************/
package egovframework.fusion.request.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import egovframework.fusion.cmmn.service.CommonService;
import egovframework.fusion.cmmn.vo.CommonCodeVO;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.request.service.RequestService;
import egovframework.fusion.request.vo.RequestVO;
import egovframework.fusion.request.vo.ResponseVO;

@RestController
public class RequestRestController {
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	RequestService requestService;
	
	@ModelAttribute("codeMap") 
	public Map<String, List<CommonCodeVO>> getStageList() {
		Map<String, List<CommonCodeVO>> codeMap = new HashMap<String, List<CommonCodeVO>>();
		CommonGroupVO vo = new CommonGroupVO();
		vo.setGpCode("REQ_STAGE");
		codeMap.put("stageList", commonService.getCommonCdList(vo));
		vo.setGpCode("RESP_TYPE");
		codeMap.put("respList", commonService.getCommonCdList(vo));
		vo.setGpCode("REQ_APPROVEYN");
		codeMap.put("approveYn", commonService.getCommonCdList(vo));
		return codeMap;
	}
	
	private Logger logger;
	
	@RequestMapping(value="/request/insRequest.do", method=RequestMethod.POST)
	public RequestVO insRequest(RequestVO req) {
		try {
			requestService.insRequest(req);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return new RequestVO();
		}
		return req;
	}
	
	@RequestMapping(value="/request/updRequest.do", method=RequestMethod.POST)
	public String updRequest(RequestVO req) {
		RequestVO checkReq = requestService.selRequest(req);
		if (checkReq.getReqStage() > 1) {
			return "failed";
		}
		try {
			requestService.updRequest(req);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/request/insResponse.do", method=RequestMethod.POST) 
	public ResponseVO insResponse(ResponseVO resp) {
		
		if (checkFinalStage(resp) == null) {
			return new ResponseVO();
		}
		
		RequestVO req = new RequestVO();
		req.setReqNo(resp.getReqNo());
		req.setReqApproveyn(resp.getReqApproveyn());
		
		if ("REVIEWED".equals(resp.getRespType())) {
			if ("1".equals(resp.getReqApproveyn()) || resp.getRespDegree() == 3) {
				req.setReqStage(4);
			} else if ("0".equals(resp.getReqApproveyn())) {
				req.setReqStage(2);
			}
		} else if ("OBJECTION".equals(resp.getRespType())) {
			req.setReqStage(3);
		}
		
		try {
			requestService.updRequest(req);
			requestService.insResponse(resp);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return new ResponseVO();
		}
		return resp;
	}
	
	@RequestMapping(value="/request/updResponse.do", method=RequestMethod.POST)
	public ResponseVO updResponse(ResponseVO resp) {
		
		if (checkFinalStage(resp) == null) {
			return new ResponseVO();
		}
		
		List<ResponseVO> checkRespList = requestService.getResponseList(resp);
		for (int i = 0; i < checkRespList.size(); i++) {
			if ("OBJECTION".equals(resp.getRespType())) {
				if (resp.getRespDegree() == checkRespList.get(i).getRespDegree() 
						&& "REVIEWED".equals(checkRespList.get(i).getRespType())) {
					return new ResponseVO();
				}
			} else if ("REVIEWED".equals(resp.getRespType())) {
				if (resp.getRespDegree() + 1 == checkRespList.get(i).getRespDegree()
						&& "OBJECTION".equals(checkRespList.get(i).getRespType())) {
					return new ResponseVO();
				}
			}
		}
		
		
		RequestVO req = null;
		if (resp.getReqApproveyn() != null || !"".equals(resp.getReqApproveyn())) {
			req = new RequestVO();
			req.setReqNo(resp.getReqNo());
			req.setReqApproveyn(resp.getReqApproveyn());
			if ("1".equals(req.getReqApproveyn())) {
				req.setReqStage(4);
			}
		}
		try {
			if (req != null) {
				requestService.updRequest(req);
			}
			requestService.updResponse(resp);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
		return resp;
	}
	
	
	@RequestMapping(value = "/request/selRequestStage.do", method=RequestMethod.POST)
	public ModelAndView selRequestStagePage(RequestVO req,
									  HttpSession session,
									  Model model) {
		Integer targetStage = req.getReqStage();
		ModelAndView mv = new ModelAndView();
		req = requestService.selRequest(req);
		ResponseVO resp = new ResponseVO();
		resp.setReqNo(req.getReqNo());
		req.setResponseList(requestService.getResponseList(resp));
		mv.setViewName("views/request/stage/reqStage" + targetStage);
		mv.addObject("req", req);
		mv.addObject("targetStage", targetStage);
		return mv;
	}
	
/*	@RequestMapping(value = "/request/delRequest.do", method = RequestMethod.POST)
	public String delRequest(RequestVO req) {
		return "success";
	}*/
	
	private RequestVO checkFinalStage(ResponseVO resp) {
		RequestVO checkReq = new RequestVO();
		checkReq.setReqNo(resp.getReqNo());
		if (requestService.selRequest(checkReq).getReqStage() == 4) {
			return null;
		}
		return checkReq;
	}

}
