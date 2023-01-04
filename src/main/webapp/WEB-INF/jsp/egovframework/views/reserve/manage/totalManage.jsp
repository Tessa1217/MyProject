<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="p-3 container-fluid">
	<input type="hidden" name="roomNo" value="${room.roomNo}"> 
	<div class="card study-room-card">
		<div class="card-header">
			<h3>독서실 운영 관리</h3>
		</div>
		<div class="card-body d-flex flex-row">
			<div class="col-2">
				<ul class="list-group manage-list shadow">
					<li class="list-group-item active" onclick="changeManagePage(this)" data-type="room">독서실 관리</li>
					<li class="list-group-item" onclick="changeManagePage(this)" data-type="management">독서실 운영 관리</li>
					<li class="list-group-item" onclick="changeManagePage(this)" data-type="seat">좌석 관리</li>
				</ul>
			</div>
			<div id="manage-main" class="col-10"></div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		changeManagePage($("li.list-group-item.active"));
	});
	function changeManagePage(li) {
		const type = $(li).data("type");
		const roomNo = $("input[name='roomNo']").val();
		if (type === "room") {
			$("#manage-main").load("/reserve/selStudyRoom.do", {roomNo : roomNo});
		} else if (type === "management") {
			$("#manage-main").load("/reserve/adminCalendar.do");
		} else if (type === "seat") {
			$("#manage-main").load("/reserve/getAdminRoomSeatList.do");
		}
		$(".manage-list .list-group-item").removeClass("active");
		$(li).addClass("active");
	}
</script>