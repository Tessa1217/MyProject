package egovframework.fusion.request.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.fusion.cmmn.service.CommonService;
import egovframework.fusion.cmmn.vo.CommonCodeVO;
import egovframework.fusion.cmmn.vo.CommonGroupVO;
import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.cmmn.vo.PageDTO;
import egovframework.fusion.request.service.RequestService;
import egovframework.fusion.request.vo.RequestVO;
import egovframework.fusion.request.vo.ResponseVO;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class RequestController {
	
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
	
	@RequestMapping(value="/request/requestList.do", method=RequestMethod.GET)
	public String getRequestList(Criteria cri, 
								HttpSession session, 
								Model model, 
								RequestVO req) {
		
		UserVO user = (UserVO) session.getAttribute("user");
		
		if (user != null) {
			if ("MEMBER".equals(user.getUserAuth())) {
				req.setRequesterNo(user.getUserNo());
			}
		}
		model.addAttribute("reqList", requestService.getRequestList(cri, req));
		
		PageDTO paginationInfo = new PageDTO();
		paginationInfo.setCurrentPageNo(cri.getPageIndex());
		paginationInfo.setPageSize(cri.getPageSize());
		paginationInfo.setRecordCountPerPage(cri.getRecordCountPerPage());
		paginationInfo.setTotalRecordCount(requestService.getRequestCnt(cri, req));
		
		model.addAttribute("cri", cri);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "views/request/requestList";
		
	}
	
	@RequestMapping(value="/request/insRequest.do", method=RequestMethod.GET)
	public String insRequestPage(RequestVO req, HttpSession session, Model model) {
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null || !"MEMBER".equals(user.getUserAuth())) {
			return "redirect:/notAuthorized.do";
		}
		model.addAttribute("req", req);
		return "views/request/insRequest";
	}
	
	@RequestMapping(value = "/request/selRequest.do", method=RequestMethod.GET)
	public String selRequestPage(RequestVO req, 
								HttpSession session,
								Model model) {
		
		req = requestService.selRequest(req);
		
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null || 
				(req.getRequesterNo() != user.getUserNo() && !user.getUserAuth().contains("ADMIN"))) {
			return "redirect:/notAuthorized.do";
		}
		
		ResponseVO resp = new ResponseVO();
		resp.setReqNo(req.getReqNo());
		req.setResponseList(requestService.getResponseList(resp));
		model.addAttribute("req", req);
		return "views/request/selRequest";
	}

}
