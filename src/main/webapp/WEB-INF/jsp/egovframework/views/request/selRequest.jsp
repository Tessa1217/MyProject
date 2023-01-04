<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="/js/request-ajax.js"></script>
<div class="mt-2 pt-2 selRequest">
	<div class="container-fluid px-4">
		<div class="m-3 d-flex flex-row justify-content-between">
			<h3>요청서</h3>
			<div id="state-badge">
				<c:forEach items="${codeMap['stageList']}" var="stage">
					<c:if test="${stage.cdCode eq req.reqStage}">
						<span class="badge rounded-pill stage-${stage.cdCode}">${stage.cdNm}</span>
					</c:if>
				</c:forEach>
				<c:if test="${req.reqStage eq 4}">
					<c:forEach items="${codeMap['approveYn']}" var="yn">
						<c:if test="${yn.cdCode eq req.reqApproveyn}">
							<span class="badge rounded-pill bg-danger">${yn.cdNm}</span>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div class="p-2 d-flex flex-row justify-content-between">
			<div id="tab-nav" class="col-1">
				 <div class="nav flex-column nav-pills nav-pills-custom" id="v-pills-tab">
				 	<c:forEach items="${codeMap['stageList']}" var="stage">
				 		<c:if test="${stage.cdCode le req.reqStage or (stage.cdCode eq 3 and req.objCnt gt 0)}">
				 			<a class="nav-link mb-3 p-3 shadow" href="javascript:void(0)" onclick="switchTab('${stage.cdCode}')">
				 				<span class="fw-bold text-uppercase">${stage.cdNm}<c:if test="${stage.cdCode eq req.reqStage}"><i class="ms-2 fas fa-arrow-circle-left"></i></c:if></span>
				 			</a>
				 		</c:if>
				 	</c:forEach>
	             </div>
			</div>
			<div class="col-11 px-5 shadow">
				<input type="hidden" value="${req.reqNo}" name="reqNo">
				<div class="card p-5">
					<div id="req-content" class="ps-5 card-body">
					</div>
					<div class="card-footer">
						<a href="javascript:history.back();" class="btn rounded-pill btn-outline-secondary me-2">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		switchTab(${req.reqStage});
	});
		
	function openAdminModal() {
		if (editor != undefined && $(editor.sourceElement).attr("id") != "insAdminEditor") {
			generateEditor("#insAdminEditor");			
		}
		modalLocation("#adminModal");
		$("#adminModal").show();
	}

	function closeAdminModal() {
		if (editor != undefined && $(editor.sourceElement).attr("id") == "insAdminEditor") {
			editor.setData("");
		} else {
			$("#req-admin-form textarea[name='respContent']").val('');
		}
		$("#req-admin-form select option").prop("selected", false);
		$("#adminModal").hide();
	}
	
	function updResponse(formName) {
		$(event.target).addClass("d-none");
		$(event.target).siblings("button").removeClass("d-none");
		let form = $("form#" + formName);
		if (editor != undefined) {
			editor.disableReadOnlyMode("#updAdminEditor");
		}
		form.find(".form-group").removeClass("d-none");
		form.find(".form-control").attr("readonly", false);
		form.find(".form-select").attr("disabled", false);
	}

	function openObjModal() {
		modalLocation("#objModal");
		$("#objModal").show();
	}
	function closeObjModal() {
		$("#objModal [name='respContent']").val('');
		$("#objModal").hide();
	}
	
	
</script>
<div class="modal-wrapper">
	<div class="modal modal-lg" tabindex="-1" id="objHistoryModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">이의 신청 이력조회</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeObjHistoryModal()">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>