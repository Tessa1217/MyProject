<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="stageTab-3" class="m-3 border-secondary border p-5 tab">
	<div class="m-2">
		<h4 class="fw-bold py-3"><i class="fas fa-user-plus"></i> 이의 신청</h4>
	</div>
	<div id="objection-body">
		<c:choose>
			<c:when test="${not empty req.responseList and fn:length(req.responseList) gt 1}">
				<c:forEach items="${req.responseList}" var="resp">
					<c:if test="${resp.respDegree ne 0}">
						<c:if test="${resp.respType eq 'OBJECTION'}">
							<h5 class="py-3">이의신청 ${resp.respDegree}차</h5>
							<c:set value="${resp.respDegree}" var="objDegree"/>
							<form id="updObjForm-${resp.respDegree}" class="shadow mb-2">
								<div class="col-12 p-3 mb-3">
									<div class="form-group editable mb-2">
										<div class="d-flex flex-row justify-content-between align-items-center">
											<p><i class="fas fa-user"></i> 이의신청자: ${resp.responserNm}</p>
											<div class="d-flex flex-column justify-content-end">
												<span class="gray">이의신청 등록일: ${resp.respRegDate}</span>
												<span class="gray">이의신청 수정일: ${resp.respModDate}</span>
											</div>
										</div>
										<label class="form-input-label">이의신청 내용</label>
										<textarea id="updEditor" rows="5" class="form-control" readonly
											name="respContent">${resp.respContent}</textarea>
									</div>
								</div>
								<input type="hidden" value="${req.reqNo}" name="reqNo"> 
								<input type="hidden" value="${resp.respNo}" name="respNo">
								<input type="hidden" value="${resp.respType}" name="respType">
								<input type="hidden" value="${resp.respDegree}" name="respDegree">
							</form>
						</c:if>
						<c:if test="${resp.respType eq 'REVIEWED'}">
							<c:set value="${resp.respDegree}" var="respDegree"/>
							<div class="d-flex flex-row justify-content-between">
								<div class="col-1 d-flex flex-row justify-content-center align-items-center">
									<h3><i class="fas fa-arrow-alt-circle-right"></i></h3>
								</div>
								<div class="col-12">
									<form id="updRespForm-${resp.respDegree}" class="bg-dark shadow text-white col-11 mb-2">
										<div class="col-12 p-3 mb-3">
											<div class="form-group editable mb-2">
												<div class="d-flex flex-row justify-content-between align-items-center">
													<p><i class="fas fa-user"></i> 검토자: ${resp.responserNm}</p>
													<div class="d-flex flex-column justify-content-end">
														<span class="gray">답변 등록일: ${resp.respRegDate}</span>
														<span class="gray">답변 수정일: ${resp.respModDate}</span>
													</div>
												</div>
												<div class="form-group d-none">
													<label for="reqApproveyn">승인상태</label>
													<select class="form-select" id="reqApproveyn" name="reqApproveyn">
														<c:forEach items="${codeMap['approveYn']}" var="yn">
															<option value="${yn.cdCode}">${yn.cdNm}</option>
														</c:forEach>
													</select>
												</div> 
												<label class="form-input-label">답변</label>
												<textarea id="updEditor" rows="5" class="form-control" readonly
													name="respContent">${resp.respContent}</textarea>
											</div>
										</div>
										<input type="hidden" value="${req.reqNo}" name="reqNo"> 
										<input type="hidden" value="${resp.respNo}" name="respNo">
										<input type="hidden" value="${resp.respType}" name="respType">
										<input type="hidden" value="${resp.respDegree}" name="respDegree">
									</form>
								</div>
							</div>
						</c:if>
					</c:if>
				</c:forEach>
				<div class="d-flex flex-row justify-content-end">
					<c:if test="${(empty respDegree or respDegree lt objDegree) and req.reqStage ne 4}">
						<c:if test="${fn:contains(user.userAuth, 'ADMIN')}">
							<button type="button" class="btn btn-primary rounded-pill" onclick="openAdminModal()">답변하기</button>
							<div class="modal modal-lg" tabindex="-1" id="adminModal">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">이의제기 답변</h5>
											<button type="button" class="btn-close"
												onclick="closeAdminModal()"></button>
									</div>
									<form id="req-admin-form" onsubmit="return insResponseAjax(this);">
										<div class="modal-body">
											<label for="reqApproveyn">승인상태</label>
											<select class="form-select" id="reqApproveyn" name="reqApproveyn">
												<c:forEach items="${codeMap['approveYn']}" var="yn">
													<option value="${yn.cdCode}">${yn.cdNm}</option>
												</c:forEach>
											</select> 
											<label for="respContent" class="my-2">답변 내용</label>
											<textarea class="form-control" id="respContent"
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
						</c:if>
						<c:if test="${user.userAuth eq 'MEMBER' and req.requesterNo eq user.userNo}">
							<button type="button" class="btn btn-primary rounded-pill" onclick="updResponse('updObjForm-${objDegree}')">수정</button>
							<button type="button" class="btn btn-danger rounded-pill d-none" onclick="updResponseAjax('updObjForm-${objDegree}')">수정완료</button>
						</c:if>
					</c:if>
					<c:if test="${(respDegree eq objDegree and fn:contains(user.userAuth, 'ADMIN')) and req.reqStage ne 4}">
						<button type="button" class="btn btn-primary rounded-pill" onclick="updResponse('updRespForm-${respDegree}')">수정</button>
						<button type="button" class="btn btn-danger rounded-pill d-none" onclick="updResponseAjax('updRespForm-${respDegree}')">수정완료</button>
					</c:if>
				</div>
			</c:when>
			<c:otherwise>
				<div class="">
					<p>이의신청한 내역이 없습니다.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>