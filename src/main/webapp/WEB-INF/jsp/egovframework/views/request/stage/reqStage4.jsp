<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="stageTab-4" class="m-3 d-flex flex-row justify-content-between align-items-center tab">
	<h2>최종</h2>
	<button class="btn btn-primary rounded-pill" type="button" onclick="objectionHistory()">이력조회</button>
	<input type="hidden" value="${req.reqNo}" name="reqNo">
</div>
<div id="page-navigation" class="d-none">
	<h6 class="mb-1"><i class="fas fa-location-arrow text-primary"></i> 페이지 목차</h6>
	<ul>
		<c:forEach begin="1" end="3" var="i">
			<li><a href="#stage-page-${i}">${codeMap['stageList'][i-1].cdNm}</a></li>
		</c:forEach>
	</ul>
</div>
<div>
	<c:forEach begin="1" end="3" var="i">
		<div class="mb-3" id="stage-page-${i}">
			<jsp:include page="reqStage${i}.jsp"></jsp:include>
		</div>
	</c:forEach>
</div>
<script>
	$(window).on("scroll", function() {
		if (window.scrollY <= 400) {
			$("#page-navigation").addClass("d-none");
		}
		if (window.scrollY > 400) {
			$("#page-navigation").removeClass("d-none");
		}
	});
</script>