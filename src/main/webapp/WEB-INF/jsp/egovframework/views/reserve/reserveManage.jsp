<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="p-4 mt-2 d-flex flex-row justify-content-between reserveManage">
	<div class="col-1">
		<div id="tab-nav">
			 <div class="nav flex-column nav-pills nav-pills-custom" id="v-pills-tab">
			 	<a class="nav-link mb-3 p-3 shadow active" href="javascript:void(0)" onclick="changeManageTabs(0)">
			 		<span class="fw-bold text-uppercase">예약현황</span>
			 	</a>
				<a class="nav-link mb-3 p-3 shadow" href="javascript:void(0)" onclick="changeManageTabs(1)">
			 		<span class="fw-bold text-uppercase">독서실 관리</span>
			 	</a>
             </div>
		</div>
	</div>
	<div id="reserve-list-main" class="col-11 reserveList d-flex flex-row justify-content-between shadow p-3">
	</div>
</div>
<script src="/js/reserve-main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.0.0/index.global.min.js"></script>
<script>
	$(document).ready(function() {
		changeManageTabs(0);
	});
	
	function changeManageTabs(idx) {
		if (idx == 0) {
			$("#reserve-list-main").load("/reserve/myReserveList.do", {pageIndex : 1});
		} else if (idx == 1) {
			$("#reserve-list-main").load("/reserve/getStudyRoomList.do");
		}
		$("#tab-nav .nav-link:not(" + idx +")").removeClass("active");
		$("#tab-nav .nav-link:eq(" + idx + ")").addClass("active");
	}
</script>