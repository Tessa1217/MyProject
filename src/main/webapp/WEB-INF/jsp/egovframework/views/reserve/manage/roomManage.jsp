<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container px-3">
	<input type="hidden" name="roomNm" value="${room.roomNm}">
	<input type="hidden" name="roomOpenTime" value="${room.roomOpenTime}">
	<input type="hidden" name="roomCloseTime" value="${room.roomCloseTime}">
	<input type="hidden" name="roomUseyn" value="${room.roomUseyn}">
	<div class="card">
		<div class="card-header">
			<h3>${room.roomNm}</h3>
		</div>
		<div class="card-body">
			<form id="room-form">
				<div class="form-group mb-3">
					<input type="hidden" value="${room.roomNo}" name="roomNo">
					<label class="form-input-label">독서실명</label>
					<input class="form-control" type="text" name="roomNm" value="${room.roomNm}" readonly maxlength="100">
				</div>
				<div class="form-group mb-3 time-select">
					<label class="form-input-label">독서실 운영시간</label>
					<fmt:parseNumber value="${fn:substring(room.roomOpenTime, 0, 2)}" var="openTime"/>
					<fmt:parseNumber value="${fn:substring(room.roomCloseTime, 0, 2)}" var="closeTime"/>
					<div class="d-flex flex-row">
						<select class="form-select d-inline" name="roomOpenTime" disabled>
							<c:forEach begin="0" end="23" var="i">
								<option value="${i}" <c:if test="${openTime eq i}">selected="selected"</c:if>>
									<c:choose>
										<c:when test="${i < 10}">0${i}:00</c:when>
										<c:otherwise>${i}:00</c:otherwise>
									</c:choose>
								</option>
							</c:forEach>
						</select>
						~
						<select class="form-select d-inline" name="roomCloseTime" disabled>
							<c:forEach begin="1" end="24" var="i">
								<option value="${i}" <c:if test="${closeTime eq i}">selected="selected"</c:if>>
									<c:choose>
										<c:when test="${i < 10}">0${i}:00</c:when>
										<c:otherwise>${i}:00</c:otherwise>
									</c:choose>
								</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group mb-3">
					<label class="form-input-label">운영 여부</label>
					<select class="form-select" name="roomUseyn" disabled>
						<option value="Y" <c:if test="${room.roomUseyn eq 'Y'}">selected="selected"</c:if>>운영 중</option>
						<option value="N" <c:if test="${room.roomUseyn eq 'N'}">selected="selected"</c:if>>운영 종료</option>
					</select>
				</div>
				<div class="form-group mb-3 text-end">
					<button type="button" class="btn upd-btn btn-primary" onclick="updForm(this)">수정하기</button>
					<button type="button" class="btn upd-btn d-none btn-danger" onclick="updStudyRoom(this)">수정완료</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script>

	function updForm(btn) {
		const form = $(btn).parents('form');
		form.find("input").prop("readonly", false);
		form.find("select").prop("disabled", false);
		$(".upd-btn").toggleClass("d-none");
	}
	
	function updStudyRoom(btn) {
		const form = $(btn).parents("form");
		if (formValidation(form)) {
			let flag = haveToCheck(form);
			if (flag > 0) {
				checkReserveStatus(form, flag);	
			} else {
				updStudyRoomAjax(makeRoomObj(form));
			}
		}
	}
	
	function haveToCheck(form) {
		let flag = 0;
		if ($(form).find("select[name='roomUseyn']").val() == "N") {
			flag = 1;
		} 
		const open = $(form).find("select[name='roomOpenTime']");
		const close = $(form).find("select[name='roomCloseTime']");
		const openTime = parseTime($("input[name='roomOpenTime']").val());
		const closeTime = parseTime($("input[name='roomCloseTime']").val());
		if (open.val() != openTime || close.val() != closeTime) {
			flag = 2;
		}
		return flag;
	}
	
	function makeRoomObj(form) {
		return {
			roomNo : form.find("input[name='roomNo']").val(),
			roomNm : form.find("input[name='roomNm']").val(),
			roomOpenTime : formatTime(form.find("select[name='roomOpenTime']").val()),
			roomCloseTime : formatTime(form.find("select[name='roomCloseTime']").val()),
			roomUseyn : form.find("select[name='roomUseyn']").val()
		}
	}
	
	function parseTime(time) {
		return parseInt(time.substring(0,2));
	}
	
	function formatTime(time) {
		let timeStr = "";
		if (parseTime(time) < 10) {
			timeStr = "0" + time + ":00";
		} else {
			timeStr = time + ":00";
		}
		return timeStr;
	}
	
	function checkReserveStatus(form, flag) {
		let chkStatus = {
				roomNo : $("input[name='roomNo']").val()
		}
		if (flag == 2) {
			chkStatus.reserveDate = dateShortFormatting(new Date());
			chkStatus.reserveInTime = $("select[name='roomOpenTime']").val() + ":00";
			chkStatus.reserveOutTime = $("select[name='roomCloseTime']").val() + ":00";
		}
		new Promise((succ, fail) => {
			$.ajax({
				method : 'POST',
				url : '/reserve/getReservedList.do',
				data : chkStatus,
				success : function(list) {
					succ(list);
				},
				fail : function(list) {
					fail(error);
				}
			})
		}).then((list) => {
			if (list.reservationList.length > 0) {
				if (flag == 1) {
					msg = "현재 독서실에 예약이 존재합니다. 독서실 운영을 중단할 수 없습니다.";
				} else if (flag == 2) {
					msg = "변경 전 운영 시간 기준으로 예약이 존재합니다. 예약 시간을 변경할 수 없습니다."; 
				}
				alert(msg);
				$("#manage-main").load("/reserve/selStudyRoom.do", {roomNo : $("input[name='roomNo']").val()});
				return;
			} 
			updStudyRoomAjax(makeRoomObj(form));
		});
	}
	
	function updStudyRoomAjax(data) {
		$.ajax({
			method : 'POST',
			url : '/reserve/updStudyRoom.do',
			data : data,
			success : function(msg) {
				if (msg == "success") {
					alert("수정이 완료되었습니다.");
					$("#manage-main").load("/reserve/selStudyRoom.do", {roomNo : $("input[name='roomNo']").val()});
				}
			}
		});	
	}
	
	function formValidation(form) {
		
		const roomNm = $(form).find("input[name='roomNm']");
		const open = $(form).find("select[name='roomOpenTime']");
		const close = $(form).find("select[name='roomCloseTime']");

		if (roomNm.val().trim() == '') {
			alert("독서실명을 입력해주세요.");
			roomNm.focus();
			return false;
		}
		
		if (parseInt(open.val()) > parseInt(close.val())) {
			alert("오픈 시간은 마감 시간보다 작아야 합니다.");
			return false;
		}
		
		return true;
		
	}
</script>