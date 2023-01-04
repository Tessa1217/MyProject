<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="stageTab-2" class="m-3 border-secondary border p-5 tab">
	<div class="m-2">
		<h4 class="fw-bold py-3"><i class="fas fa-user-tie"></i> 검토 내용</h4>
	</div>
	<form id="updAdminForm">
		<c:forEach items="${req.responseList}" var="resp">
			<c:if test="${resp.respDegree eq 0 and resp.respType eq 'REVIEWED'}">
				<c:set value="${resp}" var="review" />
				<input type="hidden" value="${req.reqNo}" name="reqNo">
				<input type="hidden" value="${resp.respNo}" name="respNo">
				<input type="hidden" value="${resp.respType}" name="respType">
				<input type="hidden" value="${resp.respDegree}" name="respDegree">
				<div class="form-group editable mb-2 d-none">
					<label>승인 상태</label> 
					<select class="form-select" name="reqApproveyn" disabled>
						<c:forEach items="${codeMap['approveYn']}" var="yn">
							<option value="${yn.cdCode}"
								<c:if test="${req.reqApproveyn eq yn.cdCode}">selected="selected"</c:if>>${yn.cdNm}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group editable mb-2">
					<label>검토내용</label>
					<textarea id="updAdminEditor" rows="5" class="form-control" readonly
						name="respContent">${resp.respContent}</textarea>
				</div>
				<div class="form-group mb-2">
					<label>검토자</label>
					<input type="text" class="form-control" value="${resp.responserNm}" readonly>
				</div>
				<div class="form-group mb-2">
					<label>검토내용 등록일</label>
					<input type="text" class="form-control" value="${resp.respRegDate}" readonly>
				</div>
				<div class="form-group mb-2">
					<label>검토내용 수정일</label>
					<input type="text" class="form-control" value="${resp.respModDate}" readonly>
				</div>
			</c:if>
		</c:forEach>
	</form>
</div>
<div class="d-flex justify-content-center align-items-center">
	<c:choose>
		<c:when
			test="${user.userAuth eq 'MEMBER' and user.userNo eq req.requesterNo}">
			<c:if test="${(req.objCnt le 3 and fn:length(req.responseList)%2 ne 0) and (req.reqStage gt 1 and req.reqStage lt 4)}">
				<button type="button"
					class="btn rounded-pill btn-primary upd-btn btn-lg"
					title="이의신청 잔여 차수"
					data-bs-toggle="popover"
					data-bs-trigger="hover"
					data-bs-content="앞으로 ${3-req.objCnt}번 이의신청 가능합니다."
					onclick="openObjModal()">이의신청</button>
				<div class="modal-wrapper">
					<div class="modal modal-lg" tabindex="-1" id="objModal">
						<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">이의제기 신청</h5>
										<button type="button" class="btn-close"
											onclick="closeObjModal()"></button>
									</div>
									<form id="req-admin-form"
										onsubmit="return insResponseAjax(this);">
										<div class="modal-body">
											<label for="respContent">이의제기 내용</label>
											<textarea class="form-control" id="respContent"
												name="respContent" rows="15"></textarea>
											<input type="hidden" name="reqNo" value="${req.reqNo}">
											<input type="hidden" name="responserNo" value="${user.userNo}">
											<input type="hidden" name="respDegree" value="${req.objCnt + 1}">
											<input type="hidden" name="respType" value="OBJECTION">
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												onclick="closeObjModal()">닫기</button>
											<button type="submit" class="btn btn-primary">제출</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(user.userAuth, 'ADMIN')}">
			<c:if test="${(req.objCnt eq 0 and review.responserNo eq user.userNo) and req.reqStage eq 2}">
				<div class="d-flex flex-row justify-content-end align-items-end">
					<button type="button" class="btn rounded-pill btn-primary"
						onclick="updResponse('updAdminForm')">수정</button>
					<button type="button" class="btn rounded-pill btn-danger d-none"
						onclick="updResponseAjax('updAdminForm')">수정 완료</button>
				</div>
			</c:if>
		</c:when>
	</c:choose>
</div>
<script>
	$(document).ready(function() {
		$("[data-bs-toggle='popover']").popover();
		generateEditor("#updAdminEditor");
	});
</script>