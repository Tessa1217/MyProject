<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="seat-location container">
	<input type="hidden" name="reserveDate" value="${roomSeat.currentDate}">
	<div class="seat-place">
		<c:forEach items="${seatList}" var="seat">
			<div class="seat <c:if test="${(seat.seatAvailyn eq 'N') or (seat.seatOccupied eq 'N')}">occupied</c:if>" 
			style="position:absolute;left:${seat.locLeft}px;top:${seat.locTop}px;"
			data-seat-no="${seat.seatNo}">${seat.seatNo}번 좌석</div>
		</c:forEach>
	</div>
</div>
<script src="/js/fabric.min.js"></script>
<script>
	$(document).ready(function() {
		
		$(".seat").on("click", function(e) {
			if ($(e.target).hasClass("occupied")) {
				alert("해당 좌석은 예약이 마감되었습니다.");
				return;
			}
			let obj = makeSeatObject($(e.target).data("seat-no"));
			$("#reserve-seat").load("/reserve/getReservationList.do", obj);
		});
	});
	
	function makeSeatObject(seatNo) {
		return {
			roomNo : $("input[name='roomNo']").val(),
			seatNo : seatNo,
			reserveDate : $("input[name='reserveDate']").val()
		}
	}
</script>