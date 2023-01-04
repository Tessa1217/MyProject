<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="stageTab-1" class="m-3 border-secondary border p-5 tab">
	<div class="m-2">
		<h4 class="fw-bold py-3"><i class="fas fa-user-tie"></i> 요청 내용</h4>
	</div>
	<form id="updForm">
		<input type="hidden" value="${req.reqNo}" name="reqNo">
		<div class="form-group editable mb-2">
			<label>요청 제목</label> <input class="form-control" type="text"
				name="reqTitle" readonly value="${req.reqTitle}">
		</div>
		<div class="form-group editable mb-2">
			<label>요청 내용</label>
			<textarea id="updEditor" rows="5" class="form-control" readonly
				name="reqContent">${req.reqContent}</textarea>
		</div>
		<div class="form-group mb-2">
			<label>요청자</label> 
			<input type="text" class="form-control" readonly value="${req.requesterNm}"> 
			<input type="hidden" name="requesterNo" value="${req.requesterNo}">
		</div>
		<div class="form-group mb-2">
			<label>요청 등록일</label> <input type="text" name="reqRegDate"
				class="form-control" readonly value="${req.reqRegDate}">
		</div>
		<div class="form-group mb-2">
			<label>요청 수정일</label> <input type="text" class="form-control"
				name="reqModDate" readonly value="${req.reqModDate}">
		</div>
	</form>
</div>
<div class="d-flex justify-content-center align-items-center">
	<c:choose>
		<c:when
			test="${user.userAuth eq 'MEMBER' and user.userNo eq req.requesterNo}">
			<c:if test="${empty req.reqReviewNo}">
				<button type="button"
					class="btn rounded-pill btn-outline-primary upd-btn"
					onclick="updRequest()">수정</button>
				<button type="button"
					class="btn rounded-pill btn-outline-danger d-none upd-btn"
					onclick="updRequestAjax()">수정 완료</button>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(user.userAuth, 'ADMIN')}">
			<c:if test="${empty req.reqReviewNo}">
				<button type="button" onclick="openAdminModal()"
					class="btn rounded-pill btn-outline-primary me-2">검토</button>
			</c:if>
			<div class="modal-wrapper">
				<div class="modal modal-lg" tabindex="-1" id="adminModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">요청 검토</h5>
								<button type="button" class="btn-close"
									onclick="closeAdminModal()"></button>
							</div>
							<form id="req-admin-form" onsubmit="return insResponseAjax(this);">
								<div class="modal-body">
									<label for="reqApproveyn">승인상태</label>
									<select class="form-select" name="reqApproveyn" id="reqApproveyn">
										<c:forEach items="${codeMap['approveYn']}" var="yn">
											<option value="${yn.cdCode}">${yn.cdNm}</option>
										</c:forEach>
									</select> <label for="updAdminEditor">검토내용</label>
									<textarea class="form-control" id="insAdminEditor"
										name="respContent" rows="10"></textarea>
									<input type="hidden" name="reqNo" value="${req.reqNo}">
									<input type="hidden" name="responserNo" value="${user.userNo}">
									<input type="hidden" name="respDegree" value="${req.objCnt}">
									<input type="hidden" name="respType" value="REVIEWED">
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										onclick="closeAdminModal()">닫기</button>
									<button type="submit" class="btn btn-primary">제출</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>
</div>
<script>
	generateEditor("#updEditor");
	
	function updRequest() {
		editor.disableReadOnlyMode("#updEditor");
		$("#updForm").find(".editable .form-control").attr("readonly", false);
		$(".upd-btn").toggleClass("d-none");
	}

</script>