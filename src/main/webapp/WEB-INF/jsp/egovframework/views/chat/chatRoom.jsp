<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container-fluid p-5">
	<div class="card">
		<div class="card-header">
			<h3>${chatRoom.roomName}</h3>
		</div>
		<div class="card-body">
			<div id="chat"></div>
		</div>
		<div class="card-footer">
			<div id="chatForm">
				<div class="form-group">
					<input type="hidden" name="roomNo" value="${chatRoom.roomNo}">
					<input type="hidden" name="userNo" value="${user.userNo}">
					<input type="hidden" name="userName" value="${user.userName}">
					<input class="form-control" type="text" name="messageContent" onkeyup="enterKey(event)">
				</div>
			</div>
		</div>
	</div>
</div>
<script src="/js/sockjs.min.js"></script>
<script>
let ws;
let message = document.getElementById("chat");

$(document).ready(function() {
	openSocket();
});

function openSocket() {
	if (ws != undefined && ws.readyState != WebSocket.CLOSED) {
		writeResponse("WebSocket is already opened.");
		return;
	}

	ws = new WebSocket("ws://192.168.6.144/chatting.do/" + $("input[name='roomNo']").val());

	ws.onopen = function(e) {
		if (e.data === undefined) {
			return;
		}
		writeStatus(e.data); 
		console.log("info: connnection opened");
	}

	ws.onmessage = function(e) {
		writeResponse(e.data);
		message.scrollTop = message.scrollHeight;
	}

	ws.onclose = function(e) {
		writeStatus("대화 종료");
	}
}

function sendMessage() {
	const message = JSON.stringify(makeChatObj());
	ws.send(message);
	$("input[name='messageContent']").val('');
}

function closeSocket() {
	ws.close();
}

function writeResponse(text) {
	$(message).append(text);
}

function writeStatus(text) {
	// $(message).append($("<p/>").text(text)); 
	console.log(text);
}

function enterKey(e) {
	if (e.keyCode == 13) {
		sendMessage();
	}
}

function makeChatObj() {
	return {
		roomNo : $("input[name='roomNo']").val(),
		userNo : $("input[name='userNo']").val(),
		userName : $("input[name='userName']").val(),
		messageContent : $("input[name='messageContent']").val()
	}
} 
</script>