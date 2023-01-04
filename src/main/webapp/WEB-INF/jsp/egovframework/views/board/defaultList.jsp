<%
/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퓨전 게시판(목록)</title>
</head>
<body>
<main id="board" class="mt-2 pt-2">
	<div class="container-fluid px-4">
		<div class="d-flex justify-content-between align-items-end flex-row my-3">
			<h1>게시판</h1>
			<c:if test="${not empty user}">
				<div>
					<button class="btn btn-primary" onclick="openNewWindow('boardInsert', 0, '', '')"><i class="fas fa-edit"></i> 글 작성</button>
				</div>
			</c:if>
		</div>
		<div class="card mb-4">
			<div class="card-header d-flex flex-row justify-content-between">
				<form class="pageSearchForm w-50" onsubmit="return false;">
					<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
					<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
					<select class="form-select d-inline w-25" name="searchCnd">
						<option value="" <c:if test="${empty cri.searchCnd}">selected</c:if>>-</option>
						<option value="USER_NAME" <c:if test="${cri.searchCnd eq 'USER_NAME'}">selected</c:if>>작성자</option>
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
						<c:if test="${not empty boardList}">
							<c:set var="boardNum" value="${paginationInfo.totalRecordCount - ((cri.pageIndex-1)*cri.recordCountPerPage)}"/>
							<c:forEach items="${boardList}" var="board" varStatus="status">
								<c:if test="${board.boardDelyn eq 'N'}">
								<tr>
									<td>${boardNum}</td>
									<td class="title">
										<div style="padding-left:${(board.boardLevel-1) * 20}px;">
											<a href="javascript:void(0);"
											onclick="openNewWindow('boardSelect', ${board.boardNo}, '', '')">
												<c:if test="${board.boardParentNo > 0}">
													<span class="material-symbols-outlined red">subdirectory_arrow_right</span>
													<span>답글: </span>
												</c:if>
												${board.boardTitle}</a>
										</div>
									</td>
									<td>${board.userName}</td>
									<td>${board.boardViewCnt}</td>
									<td><fmt:formatDate pattern="YYYY-MM-dd" value="${board.boardRegDate}"/></td>
								</tr>
								</c:if>
								<c:if test="${board.boardDelyn eq 'Y'}">
									<tr>
										<td>${boardNum}</td>
										<td class="grey">삭제된 게시글입니다.</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
									</tr>
								</c:if>
							<c:set var="boardNum" value="${boardNum - 1}"></c:set>
							</c:forEach>
						</c:if>
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
</body>
<script type="text/javascript">

	$(document).ready(function() {
		
		searchCondition();
		
		$("select[name='recordCountPerPage']").change(function() {
			searchPage(1);
		})
		
		if (!(window.location.href.indexOf("?") > 0)) {
			$(".modal").show().draggable({'cancel':'.modal-body'});
			let cookie = getCookie('popup');
			if (cookie) {
				cookie = cookie.split(",");
				for (let i = 0; i < cookie.length; i++) {
					$("#modal-" + cookie[i]).hide();
				}
			}
		} 
	});
	
	function popUpNoDisplay(bool, boardNo) {
		if (bool == false) {
			$("#modal-" + boardNo).hide();
			return;
		}
		if (bool) {
			$("#modal-" + boardNo).hide();
			addCookie(boardNo);
		}
	}
	
	function setCookie(name, value) {
		let todayDate = new Date(new Date().setHours(24, 0, 0, 0));
		document.cookie = name + "=" + escape(value);
		document.cookie = "expires=" + todayDate.toGMTString();
	}
	
	function getCookie(name) {
		let x, y;
		let cookie = document.cookie.split(";");
		for (let i = 0; i < cookie.length; i++) {
			x = cookie[i].substr(0, cookie[i].indexOf("="));
			y = cookie[i].substr(cookie[i].indexOf("=") + 1);
			x = x.replace(/^\s+|\s+$/g, '');
			if (x == name) {
				return unescape(y);
			}
		}
		return false;
	}
	
	function addCookie(boardNo) {
		let cookies = getCookie('popup');
		if (cookies) {
			let cookieArray = new Set(cookies.split(","));
			cookieArray = Array.from(cookieArray);
			if (cookieArray.indexOf(boardNo) != -1) {
				return;
			} 
			cookieArray.push(boardNo);
			cookies = cookieArray.join(',');
			setCookie('popup', cookies);
		} else {
			setCookie('popup', boardNo);
		}
	}
</script>
</html>