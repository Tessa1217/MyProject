<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="today"/>
<div class="p-3 container-fluid">
	<div>
		<div class="card-header">
			<h3>나의 예약현황</h3>
		</div>
		<div class="card-body myReserveList">
			<table class="table table-hover">
				<thead>
					<tr class="text-center">
						<th width="10%">No.</th>
						<th width="10%">예약자</th>
						<th width="10%">독서실 번호</th>
						<th width="10%">예약 좌석</th>
						<th width="20%">예약 일자</th>
						<th width="20%">예약 시간</th>
						<th width="20%">예약 현황</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="rNum" value="${paginationInfo.totalRecordCount - ((cri.pageIndex - 1) * cri.recordCountPerPage)}"/>
					<c:forEach items="${myReserveList}" var="r" varStatus="status">
						<tr data-reserve-no="${r.reserveNo}">
							<td>${rNum}</td>
							<td>${r.userName}</td>
							<td>${r.roomNo}</td>
							<td>${r.seatNo}번 좌석</td>
							<td>${r.reserveDate}</td>
						 	<td>${r.reserveInTime} ~ ${r.reserveOutTime}</td>
							<fmt:formatDate value="${r.reserveFullDate}" pattern="yyyy-MM-dd HH:mm:ss" var="reserveDate"/>
								<c:choose>
									<c:when test="${reserveDate > today}">
										<th><button type="button"
												class="btn btn-sm rounded-pill btn-primary" onclick="cancelReservation(this)">예약취소</button></th>
									</c:when>
									<c:otherwise>
										<th><button type="button"
												class="btn btn-sm rounded-pill btn-secondary disabled">입실완료</button></th>
									</c:otherwise>
								</c:choose>
						</tr>
						<c:set var="rNum" value="${rNum - 1}"/>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="card-footer">
			<div class="d-flex justify-content-center">
				<ul class="pagination">
					<input type="hidden" value="${cri.pageIndex}" name="pageIndex">
					<c:if
						test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
						<li class="pagination-item"><a class="page-link"
							href="javascript:void(0)" onclick="linkPage(1)">&lt&lt</a></li>
						<li class="pagination-item"><a class="page-link"
							href="javascript:void(0)"
							onclick="moveMyReservePage(${cri.pageIndex eq 1 ? 1 : paginationInfo.firstPageNoOnPageList - 1})">&lt</a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${paginationInfo.firstPageNoOnPageList}"
						end="${paginationInfo.lastPageNoOnPageList}">
						<li
							class="pagination-item <c:if test="${num eq cri.pageIndex}">active</c:if>">
							<a class="page-link" href="javascript:void(0)"
							onclick="moveMyReservePage(${num})">${num}</a>
						</li>
					</c:forEach>
					<c:if
						test="${paginationInfo.totalPageCount > paginationInfo.pageSize}">
						<li class="pagination-item"><a class="page-link"
							href="javascript:void(0)"
							onclick="moveMyReservePage(${(paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize) < paginationInfo.totalPageCount ? paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize : paginationInfo.totalPageCount})">&gt</a>
						</li>
						<li class="pagination-item"><a class="page-link"
							href="javascript:void(0)"
							onclick="moveMyReservePage(${paginationInfo.totalPageCount})">&gt&gt</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<script>

	function reservationData(reserveNo) {
		let data = {
				roomNo : $("input[name='roomNo']").val(),
				reserveNo : reserveNo
		}
		return data;
	}

	function checkReservation(btn) {
		let reserveNum = $(btn).parents("tr").data("reserve-no");
		let data = reservationData(reserveNum);
 		$.ajax({
			method : 'POST',
			url : '/reserve/selReservation.do',
			dataType : 'json',
			data : data,
			success : function(obj) {
				console.log(obj);
				if (checkDate(obj)) {
					cancelReservation(obj);
				} else {
					alert("예약 취소가 불가능함돠.");
				}
			}
		}); 
	} 
	
	function checkDate(obj) {
		if (obj == null || obj.reserveNo == 0) {
			return false;			
		}
		let today = new Date();
		let compareDate = new Date(obj.reserveDate + ' ' + obj.reserveInTime);
		if (compareDate < today) {
			return false;
		}
		return true;
	}
	
	function cancelReservation(btn) {
		let reserveNum = $(btn).parents("tr").data("reserve-no");
		let data = reservationData(reserveNum);
		new Promise((succ, fail) => {
			$.ajax({
				method : 'POST',
				url : '/reserve/selReservation.do',
				dataType : 'json',
				data : data,
				success : function(obj) {
					succ(obj);
				},
				fail : function(obj) {
					fail(error);
				}
			}); 
		}).then((obj) => {
			if (checkDate(obj)) {
				$.ajax({
					method : 'POST',
					url : '/reserve/updReservation.do',
					dataType : 'json',
					data : data,
					success : function() {
						alert("예약 취소가 완료되었습니다.");
						let pageIndex = $("input[name='pageIndex']").val();
						moveMyReservePage(pageIndex);
					}
				});
			} else {
				alert("예약 취소가 불가능합니다.");
			}
		});
	}
</script>