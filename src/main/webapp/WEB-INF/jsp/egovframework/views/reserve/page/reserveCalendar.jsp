<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="col-6">
	<div id="reserve-calendar" class="p-4"></div>
</div>
<div id="reserve-seat" class="col-6 p-4"></div>
<script>

	$(document).ready(function() {
		let eventDates = [];
		makeCalendar();
	});
	
	function makeCalendar() {
		let calendarEl = document.getElementById("reserve-calendar");
		let calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			showNonCurrentDates : false,
			eventSources : [
				{	
					events : function(info, successCallback, failureCallback) {
						$.ajax({
							url : '/reserve/getManagementList.do',
							method : 'POST',
							dataType : 'json',
							data : {
								roomNo : $("input[name='roomNo']").val(),
								currentMonth : info.startStr.substring(0,7)
							},
							success : function(data) {
								eventDates = data;
								data = makeEventObject(data);
								successCallback(data);						
							}
						});
					}
				}
			],
			locale : 'ko',
			validRange : {
				start: new Date()
			},
			dateClick : (info) => {
				$("td .fc-day.active").removeClass("active");
				loadSeat(info);
			}
		});
		calendar.render();
	}
	
	function loadSeat(info) {
		for (let i = 0; i < eventDates.length; i++) {
			if (info.date >= eventDates[i].manageStartDate && info.date <= eventDates[i].manageEndDate) {
				alert("휴무 기간동안은 예약을 진행할 수 없습니다.");
				$("#reserve-seat").empty();
				return;
			}
		}
		let close = parseInt($("input[name='roomCloseTime']").val());
		let open = parseInt($("input[name='roomOpenTime']").val());
		let workHour = close - open;
		let currentHour = "00:00";
		if (new Date().getHours() > open) {
			workHour -= (new Date().getHours() - open);
			currentHour = new Date().getHours() + ":00";
		} 
		testDate = info.date;
		let dateStr = info.dateStr;
		$("#reserve-seat").load("/reserve/getRoomSeatList.do", {roomNo : $("input[name='roomNo']").val(), 
																currentDate : info.dateStr,
																openHour : $("input[name='roomOpenTime']").val(),
																closeHour : $("input[name='roomCloseTime']").val(),
																totalHour : workHour,
																currentHour : currentHour});
		$(info.dayEl).addClass("active");
		
	}
	
</script>
