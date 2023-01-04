<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="egovframework.fusion.user.vo.UserVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<head>
<title>퓨전소프트 게시판</title> 
<style>
	.totalSearch-btn {
		width: 10%;
		height: 40px;
	}
	
	[name='searchKeyword'] {
		width: 70%;
	}
	
	[name='recordCountPerPage'] {
		width: 15%;
	}
	
	
	.totalSearch {
		border: 2px solid white;
		padding: 15px;
		height: 100px;
	}
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-primary navbar-light d-flex flex-column">
	<div class="container-fluid px-4 mb-3">
		<div class="col-3">
			<div class="ms-3">
				<a href="/home/home.do"><img src="/images/egovframework/fusionsoft.png" width="200px" height="50px"></a>
			</div>
		</div>
		<div class="totalSearch col-5 d-flex flex-column justify-content-center">
			<h2 class="text-center text-white fw-bold"><i class="fas fa-search"></i> 통합 검색</h2>
			<form class="d-flex flex-row justify-content-center align-items-center" action="/search/totalSearch.do" method="GET">
				<input type="hidden" name="searchCnd" value="TOTAL_SEARCH">
				<input type="text" class="form-control me-2 w-75" placeholder="Search" name="searchKeyword" required <c:if test="${param.searchCnd eq 'TOTAL_SEARCH'}">value="${param.searchKeyword}"</c:if>>
				<button type="submit" class="me-2 totalSearch-btn btn btn-outline-light">검색</button>
				<select class="form-select" name="recordCountPerPage" id="cntSelect">
					<c:forEach begin="1" end="10" var="i">
						<option value="${i}" <c:if test="${param.searchCnd eq 'TOTAL_SEARCH' and cri.recordCountPerPage eq i}">selected = "selected"</c:if>>${i}개씩</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="col-3">
			<div class="mx-3">
	 			<c:if test="${empty user.userName}">
					<a href="/login.do">로그인</a>
				</c:if>
				<c:if test="${not empty user.userName}">
					<a href="/logout.do">로그아웃</a>
				</c:if> 
			</div>
		</div>
	</div>
	<div class="container-fluid px-4">
		<button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 bg-primary">
				<c:if test="${not empty menuList}">
					<c:forEach items="${menuList}" var="menu">
						<li class="nav-item">
							<a class="nav-link" 
							<c:choose>
							<c:when test="${fn:startsWith(menu.menuPath, '/')}">
							href="${menu.fullPath}"
							target="${menu.menuTarget}"
							</c:when>
							<c:otherwise>
							href="javascript:void(0)"
							onclick="linkToPage('${menu.menuNo}')"
							</c:otherwise>
							</c:choose>
							>${menu.menuNm}</a>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center">
			<div class="mx-3">
				<c:if test="${not empty user.userName}">
					<span class="text-white">${user.userName} 님, 환영합니다!</span>
				</c:if>
			</div>
		</div>
	</div>
	<script>
		function linkToPage(menuNo) {
			$.ajax({
				method : 'POST',
				url : '/manage/menuLog.do',
				data : {menuNo : menuNo},
				success : function(obj) {
					if (obj != null) {
						window.open(obj.menuPath, obj.menuTarget);	
					} 
				}, 
				error : function(obj) {
					fireAlert("잘못된 접근입니다.", 7);
				}
			})
		}
	</script>
</nav>
</body>
</html>