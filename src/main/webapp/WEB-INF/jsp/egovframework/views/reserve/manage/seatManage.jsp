<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="text-end">
	<button type="button" class="btn btn-sm control-btn btn-success d-none" onclick="getSeats('div')">좌석 비활성화 관리</button>
	<button type="button" class="btn btn-sm control-btn btn-primary" onclick="getSeats('can')">좌석 배치 관리</button>
</div>
<div class="container-fluid p-4 d-flex flex-row justify-content-center align-items-center">
	<div id="seat-div"></div>
	<canvas id="canvas" class="d-none"></canvas>
	<div id="control-canvas" class="d-flex flex-column justify-content-center align-items-center p-3 d-none">
		<button type="button" class="seat-btn" onclick="updRoomSeat()">좌석 변경 완료</button>
		<button type="button" class="seat-btn" onclick="addSeat()">좌석 추가</button>
		<button type="button" class="seat-btn" onclick="getSeats('can')">좌석 초기화</button>
	</div>
</div>
<div class="modal modal-xl" id="seatModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">좌석 비활성화</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeSeatModal()"></button>
      </div>
      <div class="modal-body p-4 d-flex flex-row">
      	<div class="col-8">
      		<table class="table table-hover">
      			<thead class="text-center">
      				<tr>
      					<th width="20%">좌석번호</th>
      					<th width="80%">비활성화 기간</th>
      				</tr>
      			</thead>
      			<tbody>
      			</tbody>
      		</table>
      	</div>
      	<div class="col-4">
      		<c:set var="today" value="<%=new java.util.Date()%>"/>
      		<fmt:formatDate value="${today}" var="minDay" pattern="yyyy-MM-dd"/>
      		 <form>
	        	<div class="form-group">
	        		<label class="form-input-label">좌석번호</label>
	        		<input class="form-control" type="text" name="seatNo" disabled>
	        	</div>
	        	<div class="form-group">
	        		<label class="form-input-label">비활성화 시작일</label>
	        		<input class="form-control" type="date" name="inactiveStartTime" min="${minDay}">
	        	</div>
	        	<div class="form-group">
	        		<label class="form-input-label">비활성화 종료일</label>
	        		<input class="form-control" type="date" name="inactiveEndTime">
	        	</div>
	        </form>
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeSeatModal()">취소</button>
        <button type="button" class="btn btn-danger" onclick="inactiveSeatAjax(this)">비활성화</button>
      </div>
    </div>
  </div>
</div>
<script>
	$(document).ready(function() {
		let myCanvas;
		let testObj;
		// div일 경우에는 div
		// can일 경우에는 canvas 그리기 호출
		getSeats("div");
		
		$(document).on("click", ".seat", function(e) {
			const seatNo = $(e.target).data("seat-no");
			openSeatModal(seatNo);
		});
	});
	
	function updRoomSeat() {
		let data = seatList();
 		$.ajax({
			method : 'POST',
			url : '/reserve/updRoomSeat.do',
			data : JSON.stringify(data),
			contentType : 'application/json',
			dataType : 'json',
			success : function(msg) {
				if (msg == "success") {
					getSeats('can');
				}
			}
		}); 
	}
	
	function seatList() {
		let objArr = myCanvas.getObjects();
		const roomNo = $("input[name='roomNo']").val();
		let insList = [];
		let updList = [];
		objArr.forEach((val) => {
			if (val._objects == undefined) {
				insList.push(new RoomSeat(roomNo, null, val.left + ", " + val.top));
			} else {
				updList.push(new RoomSeat(roomNo, val._objects[1].seatNo, val.left + ", " + val.top));
			}
		});
		return {insList : insList, updList : updList};
	}
	
	function getSeats(command) {
		let data = {roomNo : $("input[name='roomNo']").val()};
		$.ajax({
			method : 'POST',
			url : '/reserve/getAdminRoomSeatList.do',
			data : data,
			success : function(list) {
				if (command === "div") {
					locateSeats(list);
					$(".control-btn").eq(0).addClass("d-none");
					$(".control-btn").eq(1).removeClass("d-none");
				} else if (command === "can") {
					drawSeats(list);
					$(".control-btn").eq(0).removeClass("d-none");
					$(".control-btn").eq(1).addClass("d-none");
				}
			}
		});
	}
	
	function locateSeats(list) {
		$(".canvas-container").remove();
		if ($("#canvas").length == 0) {
			$("#seat-div")
						.after($("<canvas/>")
								.attr("id", "canvas")
								.attr("class", "d-none"));
		}
		$("#control-canvas").addClass("d-none");
		$("#seat-div").empty().removeClass("d-none");
		for (seat of list) {
			let positionArr = getPosition(seat.seatLoc);
			let div = $("<div/>").attr("data-seat-no", seat.seatNo)
								 .attr("class", "seat")
								 .text(seat.seatNo + "번")
								 .css({
										"position":"absolute",
										"left":positionArr[0],
										"top":positionArr[1]
									  });
			$("#seat-div").append(div);
		}
	}
	
	function getPosition(positionStr) {
		let arr = positionStr.split(", ").map(Number);
		return arr;
	}
	
	function drawSeats(list, command) {
		
		$("#canvas").empty().removeClass("d-none");
		$("#seat-div").empty().addClass("d-none");
		$("#control-canvas").removeClass("d-none");
		
		let canvas = new fabric.Canvas("canvas", {
			backgroundColor : '#F8F9F9',
			width: 800,
			height: 800
		});
	
		myCanvas = canvas;
		
		$(list).each((idx, val) => {
			const location = val.seatLoc.split(", ").map(Number);
			
			let rect = new fabric.Rect({
				fill : '#B03A2E',
				height: 120,
				width: 120,
				originX : 'center',
				originY : 'center'
			});
			
			let text = new fabric.Text(val.seatNo + '번', {
				fontSize: 19,
				stroke: 'white',
				fill : 'white',
				strokeWidth: 1,
				originX : 'center',
				originY : 'center',
				seatNo : val.seatNo
			});
			
			let group = new fabric.Group([rect, text], {
				left : location[0],
				top : location[1]
			});

			canvas.add(group);
		});
		
		canvas.renderAll();

	}
	
	function addSeat() {
		myCanvas.add(new fabric.Rect({width:120, height:120, fill:'#CD6155'}));	
	}
	
	function getInactiveList(data) {
		$.ajax({
			method : 'POST',
			url : '/reserve/getSeatInactivationList.do',
			data : data,
			success : function(list) {
				if ($("#seatModal .modal-body .no-data").length > 0) {
					$(".no-data").remove();
				}
				if ($("#seatModal").find("tbody tr").length > 0) {
					$("#seatModal").find("tbody").empty();
				}
				if (list.length == 0) {
					let div = $("<div/>").attr("class", "no-data")
										 .text("해당 좌석에 대한 비활성화 내역이 존재하지 않습니다.");
					$("#seatModal .modal-body .col-8").append(div);
				} else {
					for (log of list) {
						let tr = $("<tr/>");
						let seat = $("<td/>");
						seat.text(log.seatNo);
						let time = $("<td/>");
						time.text(log.inactiveStartTime + " ~ " + log.inactiveEndTime);
						tr.append(seat).append(time).appendTo("#seatModal tbody");
					}
				}
				$("#seatModal").show();
			}
		});
	}
	
	function openSeatModal(seatNo) {
		$("#seatModal").find("input[name='seatNo']").val(seatNo);
		let data = {
				roomNo : $("input[name='roomNo']").val(),
				seatNo : seatNo
		}
		getInactiveList(data);
	}
	
	function closeSeatModal() {
		$("#seatModal").find("form")[0].reset();
		$("#seatModal").hide();
	}
	
	function inactiveSeatAjax(btn) {
		const form = $(btn).parents("form");	
		if (seatFormValidation(form)) {
			const chkStart = $("input[name='inactiveStartTime']").val();
			const chkEnd = $("input[name='inactiveEndTime']").val();
			let data = {
					roomNo : $("input[name='roomNo']").val(),
					seatNo : $("input[name='seatNo']").val()
			}
			if (chkStart == chkEnd) {
				data.reserveDate = chkStart;
			} else {
				data.reserveChkStart = chkStart;
				data.reserveChkEnd = chkEnd;
			}
			new Promise((succ, fail) => {
				$.ajax({
					method : 'POST',
					url : '/reserve/getReservedList.do',
					data : data, 
					success : function(list) {
						succ(list);
					}
				})
			}).then((list) => {
				if (list.reservationList.length > 0) {
					alert("해당 좌석에 예약이 있어 해당 일자에 비활성화가 불가능합니다.");
					return;
				} else {
					let data = makeInactiveObj();
					$.ajax({
						method : 'POST',
						url : '/reserve/getSeatInactivationList.do',
						data : data,
						success : function(list) {
							if (list.length > 0) {
								alert("해당 일자에 이미 해당 좌석이 비활성화되어 있습니다.");
								return;
							} else {
								insSeatInactivation(data);
							}
						}
					})
				}
			});
		}
	}
	
	function seatFormValidation(form) {
		const start = $(form).find("input[name='inactiveStartTime']").val();
		const end = $(form).find("input[name='inactiveEndTime']").val();
		if (start > end) {
			alert("종료일은 반드시 시작일보다 커야합니다.");
			return false;
		}
		// 시작일자가 오늘 날짜보다 커야함
		return true;
	}
	
	function insSeatInactivation(data) {
		$.ajax({
			method : 'POST',
			url : '/reserve/insSeatInactivation.do',
			data : data,
			success : function(msg) {
				if (msg == "success") {
					alert("등록 성공");
				}
			}
		});
	}
	
	function makeInactiveObj() {
		let start = $("#seatModal").find("input[name='inactiveStartTime']").val();
		let end = $("#seatModal").find("input[name='inactiveEndTime']").val();
		start = dateFormatting(calcStartDay(start));
		end = dateFormatting(calcEndDay(end));
		return {
			roomNo : $("input[name='roomNo']").val(),
			seatNo : $("#seatModal").find("input[name='seatNo']").val(),
			inactiveStartTime : start,
			inactiveEndTime : end, 
			inactiveType : 'INACTIVE',
		}
	}
	
	
</script>