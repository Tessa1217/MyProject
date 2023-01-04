<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="p-4 mt-2 d-flex flex-row justify-content-between">
	<div class="col-1">
		<div id="tab-nav">
			 <div class="nav flex-column nav-pills nav-pills-custom" id="v-pills-tab">
			 	<a class="nav-link mb-3 p-3 shadow active" href="javascript:void(0)" onclick="changeTabs(0)">
			 		<span class="fw-bold text-uppercase">나의 예약현황</span>
			 	</a>
				<a class="nav-link mb-3 p-3 shadow" href="javascript:void(0)" onclick="changeTabs(1)">
			 		<span class="fw-bold text-uppercase">독서실 예약하기</span>
			 	</a>
             </div>
		</div>
	</div>
	<input type="hidden" name="roomNo" value="${room.roomNo}"> 
	<input type="hidden" name="roomOpenTime" value="${room.roomOpenTime}">
	<input type="hidden" name="roomCloseTime" value="${room.roomCloseTime}">
	<div id="reserve-list-main" class="col-11 reserveList d-flex flex-row justify-content-between shadow p-3">
	</div>
</div>
<script src="/js/reserve-main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.0.0/index.global.min.js"></script>
<script>

	$(document).ready(function() {
		changeTabs(0);	
	});
	
	function changeTabs(idx) {
		if (idx == 0) {
			$("#reserve-list-main").load("/reserve/myReserveList.do", {pageIndex : 1, roomNo : $("input[name='roomNo']").val()});
		} else if (idx == 1) {
			$("#reserve-list-main").load("/reserve/reserveCalendar.do");
		}
		$("#tab-nav .nav-link:not(" + idx +")").removeClass("active");
		$("#tab-nav .nav-link:eq(" + idx + ")").addClass("active");
	}
	
</script>
