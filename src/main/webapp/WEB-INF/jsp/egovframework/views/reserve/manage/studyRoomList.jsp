<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="p-3 container-fluid">
	<div class="card study-room-card">
		<div class="card-header">
			<h3>독서실</h3>
		</div>
		<div class="card-body">
			<table class="table table-hover">
				<thead class="text-center">
					<tr>
						<th>NO.</th>
						<th>독서실명</th>
						<th>독서실 운영시간</th>
						<th>독서실 운영여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sList}" var="s">
						<tr onclick="moveToManagePage(this)" data-room-no="${s.roomNo}">
							<td>${s.roomNo}</td>
							<td>${s.roomNm}</td>
							<td>${s.roomOpenTime} ~ ${s.roomCloseTime}</td>
							<td>
								<c:choose>
									<c:when test="${s.roomUseyn eq 'N'}">운영 종료</c:when>
									<c:when test="${s.roomUseyn eq 'Y'}">운영 중</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div>
	</div>
</div>
<script>
	function moveToManagePage(tr) {
		const roomNo = $(tr).data("room-no");
		$("#reserve-list-main").load("/reserve/roomManage.do", {roomNo : roomNo});
	}
</script>