<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	var ws = new WebSocket("ws://192.168.6.144/chat/replyEcho.do?roomNo=" + $("input[name='roomNo']").val()); 
	ws.onopen = function() {
		console.log("INfo: connection opened")
	}
	ws.onmessage = function(e) {
		$("#chat").append(e.data);
	}
	ws.onclose = function(e) {
		console.log("Closed");
	}
	ws.onerror = function(e) {
		console.log(e.error);
	}
	
	function enterKey(e) {
		if (e.keyCode == 13) {
			sendMessage();
		}
	}
	
	function sendMessage() {
		let message = $("input[name='messageContent']").val();
		ws.send(JSON.stringify(makeChatObj()));
		$("input[name='messageContent']").val('');
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