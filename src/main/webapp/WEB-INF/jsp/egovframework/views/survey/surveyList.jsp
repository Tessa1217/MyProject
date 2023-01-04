<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<title>Insert title here</title>
</head>
<body>
<main class="mt-2 pt-2">
	<div class="container fluid px-4">
		<div class="d-flex justify-content-between align-items-end flex-row my-3">
			<h2><i class="fas fa-poll-h"></i> 참여 가능한 설문조사</h2>
		</div>
		<div class="card mb-4">
			<div class="survey-list">
				<div class="card-header d-flex flex-row justify-content-between">
					<form class="pageSearchForm w-50" method="GET" action="/board/boardList.do">
					<select class="form-select d-inline w-25" name="searchCnd">
						<option value="" <c:if test="${empty cri.searchCnd}">selected</c:if>>전체</option>
						<option value="SURVEY_TITLE" <c:if test="${cri.searchCnd eq 'SURVEY_TITLE'}">selected</c:if>>제목</option>
						<option value="SURVEY_OWNER_NAME" <c:if test="${cri.searchCnd eq 'SURVEY_OWNER_NAME'}">selected</c:if>>주관자</option>
						<option value="ALL" <c:if test="${cri.searchCnd eq 'ALL'}">selected</c:if>>전체 검색</option>
					</select>
					<input class="w-50 form-control d-inline" type="text" name="searchKeyword" 
					<c:if test="${!empty cri.searchCnd}">
					value="${cri.searchKeyword}"
					</c:if>>
					<button type="button" class="searchBtn btn btn-primary" onclick="searchSurveyPage('1')">검색</button>
					</form>
					<select class="form-select w-25" name="recordCountPerPage">
						<option value="10" <c:if test="${cri.recordCountPerPage == 10}">selected</c:if>>10개</option>
						<option value="20" <c:if test="${cri.recordCountPerPage == 20}">selected</c:if>>20개</option>
						<option value="50" <c:if test="${cri.recordCountPerPage == 50}">selected</c:if>>50개</option>
						<option value="100" <c:if test="${cri.recordCountPerPage == 100}">selected</c:if>>100개</option>
					</select>
				</div>
				<div class="card-body table-responsive">
					<table class="table table-hover">
						<thead class="table-primary align-center text-center">
							<tr>
								<th>설문지 번호</th>
								<th>설문지 제목</th>
								<th>설문지 참여기간</th>
								<th>설문지 참여대상</th>
								<th>설문지 참여</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty surveyList}">
								<c:forEach items="${surveyList}" var="survey" varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td class="text-start">${survey.surveyTitle}</td>
										<td><fmt:formatDate value="${survey.surveyStartDate}" pattern="YYYY/MM/dd"></fmt:formatDate> ~ <fmt:formatDate value="${survey.surveyEndDate}" pattern="YYYY/MM/dd"></fmt:formatDate></td>
										<td>${survey.participantTypeDesc}</td>
										<c:if test="${userType eq 1 and empty survey.surveySubmit}">
											<td><a class="btn btn-sm rounded-pill btn-outline-primary" href="/survey/selSurvey.do?surveyNo=${survey.surveyNo}">참여하기</a></td>
										</c:if>
										<c:if test="${userType eq 1 and not empty survey.surveySubmit}">
											<td><a class="btn btn-sm rounded-pill btn-outline-primary" href="/survey/modSurvey.do?surveyNo=${survey.surveyNo}">수정하기</a></td>
										</c:if>
										<c:if test="${userType eq 0}">
											<td><a class="btn btn-sm btn-outline-primary" href="/survey/surveyResult.do?surveyNo=${survey.surveyNo}">결과보기</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-center">
					<ul class="pagination">
						<c:if test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
							<li class="pagination-item">
									<a class="page-link" href="javascript:void(0)" onclick="surveyLinkPage(1)">&lt&lt</a>
							</li>
							<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="surveyLinkPage(${cri.pageIndex eq 1 ? 1 : paginationInfo.firstPageNoOnPageList - 1})">&lt</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}">
							<li class="pagination-item <c:if test="${num eq cri.pageIndex}">active</c:if>">
								<a class="page-link" href="javascript:void(0)" onclick="surveyLinkPage(${num})">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
							<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="surveyLinkPage(${(paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize) < paginationInfo.totalPageCount ? paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize : paginationInfo.totalPageCount})">&gt</a>
							</li>
							<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="surveyLinkPage(${paginationInfo.totalPageCount})">&gt&gt</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</main>
<script>

	$(document).ready(() => {
		searchCondition();
	})
	
function surveyLinkPage(pageIndex) {
	
}

</script>
</body>
</html>