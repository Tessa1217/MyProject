<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="card mb-3">
	<div class="card-header d-flex flex-row justify-content-between p-3">
		<h3>예약현황 확인</h3>
		<div>
			<p>선택 독서실: ${reserveInfo.roomNo}</p>
			<p>선택날짜: ${reserveInfo.reserveDate}</p>
			<p>선택좌석: ${reserveInfo.seatNo}</p>
			<button type="button" class="btn btn-primary" onclick="returnToSeat()">좌석 보기</button>
		</div>
	</div>
	<div class="card-body">
		<input type="hidden" value="${room.roomOpenTime}" name="roomOpenTime">
		<input type="hidden" value="${room.roomCloseTime}" name="roomCloseTime">
		<div class="container container-fluid">
			<div id="seat-timetable" class="row row-cols-2">
			</div>
		</div>
	</div>
</div>
<div class="card">
	<div class="card-header">
		<h3>예약목적 및 선택시간</h3>
	</div>
	<div class="card-body">
		<div>
			<form>
				<input type="hidden" name="roomNo" value="${reserveInfo.roomNo}">
				<input type="hidden" name="seatNo" value="${reserveInfo.seatNo}">
				<input type="hidden" name="reserveDate" value="${reserveInfo.reserveDate}">
				<input type="hidden" name="totalHour">
				<div class="form-group">
					<label class="form-input-label">사용목적</label>
					<input class="form-control" type="text" name="reserveReason" maxlength="100" placeholder="100자 이내로 입력해주세요.">
				</div>
				<div class="form-group">
					<label class="form-input-label">사용시간</label>
					<div class="d-flex flex-row">
						<select class="form-select d-inline" name="reserveInTime">
						</select>
						~
						<select class="form-select d-inline" name="reserveOutTime">
						</select>
					</div>
				</div>
				<div class="form-group mt-2 text-end">
					<button type="button" class="btn btn-primary" onclick="reserveTime()">예약하기</button> 
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	
	$(document).ready(function() {

		getReservedList();
		
	});
	
	function getReservedList() {
		$.ajax({
			method : 'POST',
			url : '/reserve/getReservedList.do',
			data : makeInfoObj(),
			success : function(status) {
				reserveTimeTable();
				let input = $("input[name='reserveDate']").val();
 				if (new Date(input).toDateString() == new Date().toDateString()) {
					for (let i = parseInt($("input[name='roomOpenTime']").val()); i <= new Date().getHours(); i++) {
						let passedTime = $("#seat-timetable div[data-start=" + i +"]");
						occupiedTime(passedTime);
					}
				}
				$(status.reservationList).each((idx, obj) => {
					let start = parseInt(obj.reserveInTime);
					let end = parseInt(obj.reserveOutTime);
					occupyTimeTable(start, end);		
				});
				$(status.inactiveList).each((idx, obj) => {
					console.log(obj);
					const startDate = obj.inactiveStartTime.substring(0, 10);
					const endDate = obj.inactiveEndTime.substring(0, 10);
					let start;
					let end;
					if (input == startDate) {
						start = parseInt(obj.inactiveStartTime.substring(10));
						if (startDate == endDate) {
							end = parseInt(obj.inactiveEndTime.substring(10));
						} else {
							end = parseInt($("input[name='roomCloseTime']").val());
						}
					} else if (startDate != endDate && input == endDate) {
						start = parseInt($("input[name='roomOpenTime']").val());
						end = parseInt(obj.inactiveEndTime.substring(10));
					}
					occupyTimeTable(start, end);
				});
			}
		}); 
	}
	
	function occupyTimeTable(start, end) {
		for (let i = start; i < end; i++) {
			let reservedTime = $("#seat-timetable div[data-start=" + i + "]");
			occupiedTime(reservedTime);
		}
	}
	
	function returnToSeat() {
		
		let close = parseInt($("input[name='roomCloseTime']").val());
		let open = parseInt($("input[name='roomOpenTime']").val());
		let workHour = close - open;
		let currentHour = null;
		if (new Date().getHours() > open) {
			workHour -= (new Date().getHours() - open);
			currentHour = new Date().getHours() + ":00";
		} 
		$("#reserve-seat").load("/reserve/getRoomSeatList.do", {roomNo : $("input[name='roomNo']").val(), 
																currentDate : $("input[name='reserveDate']").val(), 
																totalHour : workHour,
																currentHour : currentHour});
		
		
	}
	
	function occupiedTime(div) {
		div.addClass("r-prohibit");
		div.find("p").addClass("occupied");
		div.find("span.reserve-title").text(" (예약불가)");
	}
	
	function resetTimeTable() {
		$("#seat-timetable").empty();
		$("select[name='reserveInTime']").empty();
		$("select[name='reserveOutTime']").empty();
	}
	
	function reserveTimeTable() {
		resetTimeTable();
		const openTime = parseInt($("input[name='roomOpenTime']").val());
		const closeTime = parseInt($("input[name='roomCloseTime']").val());
		$("input[name='totalHour']").val(closeTime - openTime);
		for (let i = openTime; i < closeTime; i++) {
			makeTimeTable(i);
			makeTimeSelect(i);
		}
	}
	 
	function makeTimeTable(i) {
		let div = $("<div/>").attr("class", "time-table-wrapper").attr("data-start", i).attr("data-end", i + 1);
		let s = formatHour(i);
		let e = formatHour(i + 1);
		let span = $("<span/>").text(" (예약가능)").attr("class", "reserve-title");
		$("<p/>").text(s + " ~ " + e).append(span).appendTo(div);
		$("#seat-timetable").append(div);
	}
	
	function makeTimeSelect(i) {
		let s = formatHour(i);
		let e = formatHour(i + 1);
		$("select[name='reserveInTime']").append($("<option/>").val(s).text(s));
		$("select[name='reserveOutTime']").append($("<option/>").val(e).text(e));
	}
	
	function formatHour(i) {
		if (i < 10) {
			i = "0" + i + ":00";
		} else {
			i = i + ":00";
		}
		return i;
	}
	
	function makeInfoObj() {
		return {
			roomNo : $("input[name='roomNo']").val(),
			seatNo : $("input[name='seatNo']").val(),
			reserveDate : $("input[name='reserveDate']").val()
		}
	}
	
	function makeReservationObj() {
		let totalHour = parseInt($("input[name='roomCloseTime']").val()) - parseInt($("input[name='roomOpenTime']").val());
		let currentHour = null;
		if (new Date($("input[name='reserveDate']").val()).toDateString() == new Date().toDateString()) {
			currentHour = new Date().getHours() + 1;
			totalHour -= (currentHour - parseInt($("input[name='roomOpenTime']").val()));
			currentHour = currentHour + ":00";
		}
		return {
			roomNo : $("input[name='roomNo']").val(),
			seatNo : $("input[name='seatNo']").val(),
			reserveDate : $("input[name='reserveDate']").val(),
			reserveInTime : $("select[name='reserveInTime']").val(),
			reserveOutTime : $("select[name='reserveOutTime']").val(),
			reserveReason : $("input[name='reserveReason']").val(),
			totalHour : totalHour,
			currentHour : currentHour,
			openHour : $("input[name='roomOpenTime']").val(),
			closeHour : $("input[name='roomCloseTime']").val()
		}
	}
	
	function reserveTime() {
		if (reserveValid()) {
			$.ajax({
				method : 'POST',
				url : '/reserve/insReservation.do',
				dataType : 'json',
				data : makeReservationObj(),
				success : function(msg) {
					if (msg == "failed") {
						alert("실패함");
					} else if (msg == "success") {
						alert("성공함");
						getReservedList();
					} else if (msg == "occupied") {
						alert("이미 예약됨.");
						getReservedList();
					} else if (msg == "passed") {
						alert("예약 가능한 시간이 아닙니다.");
						getReservedList();
					}
				}
			}); 
		}
	}
	
	function reserveValid() {
		if ($("input[name='reserveReason']").val().trim() == '') {
			alert("사유를 입력해주세요.");
			$("input[name='reserveReason']").focus();
			return false;
		}
		
		const inTime = parseInt($("select[name='reserveInTime']").val());
		const outTime = parseInt($("select[name='reserveOutTime']").val());

		if (inTime >= outTime) {
			alert("예약 시작시간은 종료 시간 이전이어야 합니다.");
			return false;
		}
		
 		for (let i = inTime; i < outTime; i++) {
 			if ($("#seat-timetable div[data-start=" + i + "]").hasClass("r-prohibit")) {
 				alert("예약 불가한 시간입니다.");
 				return false;
 			}
 		}
		
		return true;
	}
	
</script>

