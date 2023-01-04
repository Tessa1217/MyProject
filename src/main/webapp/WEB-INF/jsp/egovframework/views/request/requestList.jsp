<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="mt-2 pt-2 requestList">
	<div class="container-fluid px-4">
		<div class="d-flex justify-content-between align-items-end flex-row my-3">
			<h1>요청 사항 게시판</h1>
			<c:if test="${user.userAuth eq 'MEMBER'}">
				<a href="/request/insRequest.do" class="btn rounded-pill btn-outline-primary">요청 등록</a>
			</c:if>
		</div>
		<div class="card mb-4">
			<div class="card-header d-flex flex-row justify-content-between">
				<form id="req-form-search" class="d-flex flex-row justify-content-start">
					<div class="form-group">
						<label class="form-input-label">게시글 개수</label>
						<select class="form-select" name="recordCountPerPage">
							<c:forEach begin="1" end="4" var="i">
								<option value="${i*5}" <c:if test="${cri.recordCountPerPage == (i*5)}">selected="selected"</c:if>>${i*5}개씩</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label class="form-input-label">요청 상태</label>
						<input type="hidden" name="searchCnd" value="REQ_STAGE">
						<select class="form-select" name="searchKeyword">
							<option value="" <c:if test="${empty cri.searchKeyword}">selected="selected"</c:if>>모든 상태</option>
							<c:forEach items="${codeMap['stageList']}" var="stage">
								<option value="${stage.cdCode}" <c:if test="${cri.searchKeyword eq stage.cdCode}">selected="selected"</c:if>>${stage.cdNm}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group d-flex flex-row align-items-center">
						<button type="button" onclick="movePage(1)" class="btn btn-sm rounded-pill btn-primary py-2"><i class="fas fa-search"></i> 검색</button>
					</div>
				</form>
			</div>
			<div class="card-body px-5">
				<div>
					<table class="table table-hover">
						<thead class="text-center">
							<tr>
								<th width="10%">번호</th>
								<th width="40%">제목</th>
								<th width="10%">진행단계</th>
								<th width="10%">승인여부</th>
								<th width="10%">글쓴이</th>
								<th width="10%">등록일</th>
								<th width="10%">수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:set value="${paginationInfo.firstPageRecordIndex}" var="idx"/>
							<c:forEach items="${reqList}" var="req" varStatus="status">
								<tr onclick="selRequestPage('${req.reqNo}')">
									<td>${idx}</td>
									<td class="text-start"><span class="req-title">${req.reqTitle}</span></td>
									<td><span class="badge rounded-pill stage-${req.reqStage}">${codeMap['stageList'][req.reqStage - 1].cdNm}</span></td>
									<td><span class="badge rounded-pill approve-${req.reqApproveyn}">${codeMap['approveYn'][req.reqApproveyn].cdNm}</span></td>
									<td>${req.requesterNm}</td>
									<td>${req.reqRegDate}</td>
									<td>${req.reqModDate}</td>
								</tr>
								<c:set value="${idx - 1}" var="idx"/>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-center">
					<ul class="pagination">
						<c:if test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
							<li class="pagination-item">
									<a class="page-link" href="javascript:void(0)" onclick="movePage(1)">&lt&lt</a>
							</li>
							<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="movePage(${cri.pageIndex eq 1 ? 1 : paginationInfo.firstPageNoOnPageList - 1})">&lt</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}">
							<li class="pagination-item <c:if test="${num eq cri.pageIndex}">active</c:if>">
								<a class="page-link" href="javascript:void(0)" onclick="movePage(${num})">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
							<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="movePage(${(paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize) < paginationInfo.totalPageCount ? paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize : paginationInfo.totalPageCount})">&gt</a>
							</li>
							<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="movePage(${paginationInfo.totalPageCount})">&gt&gt</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	// Search + Page Move
	
	function selRequestPage(reqNo) {
		location.href = '/request/selRequest.do?reqNo=' + reqNo;	
	}
	
	function movePage(idx) {
		location.href = URLqueryString(idx);
	}
	
	function URLqueryString(idx) {
		let str = location.pathname;
		str += "?" + decodeURI($.param(queryObject(idx)));
		return str;
	}
	
	function queryObject(idx) {
		let form = $("#req-form-search");
		return {
			pageIndex : idx, 
			recordCountPerPage : form.find("select[name='recordCountPerPage']").val(),
			searchCnd : form.find("[name='searchCnd']").val(),
			searchKeyword : form.find("select[name='searchKeyword']").val()
		}	
	}
	
	
</script>