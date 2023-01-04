<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>s
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container-fluid p-4">
	<div class="card">
		<div class="card-header">
			<h3>채팅방</h3>
		</div>
		<div class="card-body">
			<table class="table table-hover">
				<thead class="text-center">
					<tr>
						<th>방 번호</th>
						<th>방 이름</th>
						<th>방 개설자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${roomList}" var="room">
						<tr onclick="goToChatRoom(this)" data-room-no="${room.roomNo}">
							<td>${room.roomNo}</td>
							<td>${room.userName}</td>
							<td>${room.roomName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	function goToChatRoom(tr) {
		location.href="/chat/chattingRoom.do?roomNo=" + $(tr).data("room-no");
	}
</script>