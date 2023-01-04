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
					<c:forEach items="${rList}" var="r">
						<tr onclick="moveToReservePage(this);" data-room-no="${r.roomNo}">
							<td>${r.roomNo}</td>
							<td>${r.roomNm}</td>
							<td>${r.roomOpenTime} ~ ${r.roomCloseTime}</td>
							<td>
								<c:choose>
									<c:when test="${r.roomUseyn eq 'N'}">운영 종료</c:when>
									<c:when test="${r.roomUseyn eq 'Y'}">운영 중</c:when>
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
	
	function moveToReservePage(tr) {
		location.href="/reserve/reserveList.do?roomNo=" + $(tr).data("room-no");
	}

</script>