<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container-fluid">
	<div id="calendar"></div>
</div>
<script>
	$(document).ready(function() {
		makeAdminCalendar();
	});
	
	function makeAdminCalendar() {
		let calendarEl = document.getElementById("calendar");
		let calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			showNonCurrentDates : false,
			selectable: true,
			height: 800,
			width: 800,
			eventAdd : function() {
				console.log()
			},
			eventClick : function(info) {
				if (confirm("해당 일정을 삭제하시겠습니까?")) {
					let data = {
							roomNo : $("input[name='roomNo']").val(),
							manageNo : info.event._def.publicId
					}
					console.log(data);
					delManagement(data);
				} 
			},
			select : function(arg) {
				new Promise((succ, fail) => {
					let data = {
							roomNo : $("input[name='roomNo']").val(),
							reserveChkStart : arg.startStr,
							reserveChkEnd : arg.endStr
					}
					$.ajax({
						method : 'POST',
						url : '/reserve/getReservedList.do',
						data : data,
						success: function(list) {
							console.log(list);
							succ(list);
						}
					});
				}).then((list) => {
					if (list.reservationList.length > 0) {
						alert("이미 예약이 있습니다.");
						calendar.unselect();
					} else {
						let title = prompt("휴무 사유를 입력해주세요.");
						if (title) {
							arg.title = title;
							arg.roomNo = $("input[name='roomNo']").val();
							let data = makeManagementObject(arg);
							insManagement(data);
						} else {
							calendar.unselect();
						}
					}
				});
			},
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
								data = makeAdminEventObject(data);
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
			}
		});
		calendar.render();
	}
	
	function insManagement(data) {
		$.ajax({
			method : 'POST',
			url : '/reserve/insManagement.do',
			data : data,
			success : function(msg) {
				if (msg == "success") {
					$("#manage-main").load("/reserve/adminCalendar.do");
				}
			}
		}); 
	}
	
	function delManagement(data) {
		$.ajax({
			method : 'POST',
			url : '/reserve/delManagement.do',
			data : data,
			success : function(msg) {
				if (msg == "success") {
					$("#manage-main").load("/reserve/adminCalendar.do");
				}
			}
		})
	}
	
</script>