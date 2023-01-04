package egovframework.fusion.chat;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.fusion.chat.vo.ChatMessageVO;

@Controller
@ServerEndpoint(value="/chatting.do/{roomNo}")
public class ChatHandler {
	
	private static Map<Session, Integer> sessionMap = new HashMap<Session, Integer>();
	
	@OnOpen
	public void onOpen(Session session, EndpointConfig config, @PathParam("roomNo") Integer roomNo) {
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("<p class='enter-text'>대화방에 연결되었습니다.</p>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		sessionMap.put(session, roomNo);
	}
	
	@OnMessage
	public void onMessage(String msgData, Session session) {
		
		ChatMessageVO chatMsg = new ChatMessageVO();
		ObjectMapper mapper = new ObjectMapper(); // Message JSON 객체로 받아서 ChatMessageVO 객체로 파싱
		try {
			chatMsg = mapper.readValue(msgData, ChatMessageVO.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String sender = chatMsg.getUserName();
		String message = chatMsg.getMessageContent();
		Integer roomNo = chatMsg.getRoomNo();
		
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText(myChatBox(sender, message));
		} catch (Exception e) {
			e.printStackTrace();
		}
		sendMessageToSession(session, sender, message, roomNo);
		
	}
	
	
	private String myChatBox(String sender, String message) {
		String myChatBox = "<div class='my-chat'><span>";
		myChatBox += "나 : " + message + "</span></div>";
		return myChatBox;
	}
	
	private void sendMessageToSession(Session session, String sender, String message, Integer roomNo) {
		String chatBox = "<div class='not-my-chat'><span>";
		try {
			for (Session sess : ChatHandler.sessionMap.keySet()) {
				if (!session.getId().equals(sess.getId())) {
					if (sessionMap.get(sess) == roomNo) {
						chatBox += sender + " : " + message + "</span></div>";
						sess.getBasicRemote().sendText(chatBox);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@OnClose
	public void onClose(Session session) {
		sessionMap.remove(session);
	}

}
