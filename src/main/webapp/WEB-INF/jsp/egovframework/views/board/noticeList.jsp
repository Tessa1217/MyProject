<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>퓨전 게시판(공지사항)</title>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
</head>
<body>
<main class="mt-2 pt-2">
	<div class="container-fluid px-4">
		<div class="d-flex justify-content-between align-items-end flex-row my-3">
			<h1>공지사항</h1>
			<c:if test="${not empty user and (user.userAuth eq 'ADMIN' or user.userAuth eq 'SUPERADMIN')}">
				<div>
					<button class="btn btn-primary" onclick="openNewWindow('boardInsert', 0, '', '')"><i class="fas fa-edit"></i> 글 작성</button>
				</div>
			</c:if>
		</div>
		<div class="card mb-4">
			<div class="card-header d-flex flex-row justify-content-between">
				<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
				<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
				<form class="pageSearchForm w-50" method="GET" action="/board/boardList.do">
					<select class="form-select d-inline w-25" name="searchCnd">
						<option value="" <c:if test="${empty cri.searchCnd}">selected</c:if>>-</option>
						<option value="BOARD_TITLE" <c:if test="${cri.searchCnd eq 'BOARD_TITLE'}">selected</c:if>>제목</option>
						<option value="BOARD_CONTENT" <c:if test="${cri.searchCnd eq 'BOARD_CONTENT'}">selected</c:if>>내용</option>
						<option value="ALL" <c:if test="${cri.searchCnd eq 'ALL'}">selected</c:if>>전체 검색</option>
					</select>
					<input class="w-50 form-control d-inline" type="text" name="searchKeyword" 
					<c:if test="${!empty cri.searchCnd}">
					value="${cri.searchKeyword}"
					</c:if>>
					<button type="button" class="searchBtn btn btn-primary" onclick="searchPage('1')">검색</button>
				</form>
				<select class="w-25" name="recordCountPerPage">
					<option value="10" <c:if test="${cri.recordCountPerPage == 10}">selected</c:if>>10개</option>
					<option value="20" <c:if test="${cri.recordCountPerPage == 20}">selected</c:if>>20개</option>
					<option value="50" <c:if test="${cri.recordCountPerPage == 50}">selected</c:if>>50개</option>
					<option value="100" <c:if test="${cri.recordCountPerPage == 100}">selected</c:if>>100개</option>
				</select>
			</div>
			<div class="card-body boardList">
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="noticeNum" value="${paginationInfo.totalRecordCount - ((cri.pageIndex-1)*cri.recordCountPerPage)}"/>
						<c:forEach items="${noticeList}" var="notice" varStatus="status">
							<tr>
								<td>${noticeNum}</td>
								<td class="title">
									<div>
										<a href="javascript:void(0);"
										onclick="openNewWindow('boardSelect', ${notice.boardNo}, '', '')">
										<span class="badge bg-danger me-2">공지</span>
											${notice.boardTitle}</a>
									</div>
								</td>
								<td>${notice.userName}</td>
								<td>${notice.boardViewCnt}</td>
								<td><fmt:formatDate pattern="YYYY-MM-dd" value="${notice.boardRegDate}"/></td>
							</tr>
						<c:set var="noticeNum" value="${noticeNum - 1}"></c:set>
						</c:forEach>
					</tbody>
				</table>
			</div>
				<div class="d-flex justify-content-center">
				<ul class="pagination">
					<c:if test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
						<li class="pagination-item">
								<a class="page-link" href="javascript:void(0)" onclick="linkPage(1)">&lt&lt</a>
						</li>
						<li class="pagination-item">
							<a class="page-link" href="javascript:void(0)" onclick="linkPage(${cri.pageIndex eq 1 ? 1 : paginationInfo.firstPageNoOnPageList - 1})">&lt</a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}">
						<li class="pagination-item <c:if test="${num eq cri.pageIndex}">active</c:if>">
							<a class="page-link" href="javascript:void(0)" onclick="linkPage(${num})">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
						<li class="pagination-item">
							<a class="page-link" href="javascript:void(0)" onclick="linkPage(${(paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize) < paginationInfo.totalPageCount ? paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize : paginationInfo.totalPageCount})">&gt</a>
						</li>
						<li class="pagination-item">
							<a class="page-link" href="javascript:void(0)" onclick="linkPage(${paginationInfo.totalPageCount})">&gt&gt</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	</main>
	<script>
	$(document).ready(function() {
		
		searchCondition();
		
		$("select[name='recordCountPerPage']").change(function() {
			location.href="/board/noticeList.do?pageIndex=1&recordCountPerPage=" + $(this).val();
		})
	})

	</script>
</body>
</html>