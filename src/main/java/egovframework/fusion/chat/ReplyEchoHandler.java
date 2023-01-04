/*****************************************************************
 * 파 일 명: ReplyEchoHandler.java
 * 업 무 명: 사용자 채팅
 * 설     명: 사용자의 채팅 기능을 처리하는데 사용.
 * 작 성 자: 권유진
 * 작 성 일: 2022-12-26
 ******************************************************************
 * $Author : 권유진 $
 * $Revision : $
 * $Date : $
 ******************************************************************
 * Copyright 2022. Fusionsoft Co., Ltd. all rights reserved 
 ******************************************************************/
package egovframework.fusion.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.fusion.chat.service.ChatService;
import egovframework.fusion.chat.service.impl.ChatServiceImpl;
import egovframework.fusion.chat.vo.ChatLogVO;
import egovframework.fusion.chat.vo.ChatMessageVO;
import egovframework.fusion.user.vo.UserVO;

@Component
public class ReplyEchoHandler extends TextWebSocketHandler {
	
	Map<Integer, List<WebSocketSession>> sessionMap = new HashMap<Integer, List<WebSocketSession>>();
	
	private ObjectMapper objectMapper = new ObjectMapper();
	
	@Autowired
	ChatService chatService;
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 사용자 채팅방 입장
	 * 작 성 일 : 2022.12.26.
	 * @param session 웹 소켓 세션
	 * @throws Exception
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String msg = "<p class='enter-text'>채팅방에 입장하셨습니다.</p>";
		Integer roomNo = getRoomNo(session);
		if (sessionMap.containsKey(roomNo)) {
			sessionMap.get(roomNo).add(session);
		} else {
			List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
			sessionList.add(session);
			sessionMap.put(roomNo, sessionList);
		}
		session.sendMessage(new TextMessage(msg));
		UserVO user = getChatUser(session);
		String enterMsg = "<p class='enter-text'>" + user.getUserName() + "님이 채팅방에 입장하셨습니다.</p>";
		sendMsgToRoom(roomNo, enterMsg, session);
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 사용자 채팅 메세지 처리
	 * 작 성 일 : 2022.12.27.
	 * @param session 웹 소켓 세션, message 메세지 객체
	 * @throws Exception
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// BroadCasting (담겨있는 모든 세션의 유저에게 메세지 전송)
		String jsonData = message.getPayload();
		ChatMessageVO chat = objectMapper.readValue(jsonData, ChatMessageVO.class);
		session.sendMessage(new TextMessage(myChat(chat.getMessageContent())));
		try {
			chatService.insChatMessage(chat);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (sessionMap.get(chat.getRoomNo()) != null) {
			String msg = notMyChat(chat.getUserName(), chat.getMessageContent());
			sendMsgToRoom(chat.getRoomNo(), msg, session);
		}
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 채팅방 연결 종료
	 * 작 성 일 : 2022.12.26.
	 * @param session 웹 소켓 세션, status 연결 상태
	 * @throws Exception
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Integer roomNo = getRoomNo(session);
		UserVO user = getChatUser(session);
		sessionMap.get(roomNo).remove(session);
		if (sessionMap.get(roomNo) != null) {
			String exitMsg = "<p class='enter-text'>" + user.getUserName() + "님이 채팅방 연결을 종료하셨습니다.</p>";
			sendMsgToRoom(roomNo, exitMsg, session);
		}
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : HandshakeInterceptor에서 저장한 유저 정보 웹 소켓에서 받아오는 메소드
	 * 작 성 일 : 2022.12.28.
	 * @param session 웹 소켓 세션
	 * @return user 유저
	 */
	private UserVO getChatUser(WebSocketSession session) {
		UserVO user = (UserVO) session.getAttributes().get("user");
		if (user != null) {
			return user;
		}
		return null;
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 채팅방 번호 
	 * 작 성 일 : 2022.12.26.
	 * @param session 웹 소켓 세션
	 * @throws Exception
	 * @return roomNo 채팅방 번호 
	 */
	private Integer getRoomNo(WebSocketSession session) {
		String queryString = session.getUri().getQuery();
		Integer roomNo = Integer.parseInt(queryString.substring(queryString.indexOf("=") + 1));
		return roomNo;
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 사용자의 채팅
	 * 작 성 일 : 2022.12.27.
	 * @param content 사용자의 채팅 내용
	 * @throws Exception
	 * @return chatBox 사용자의 채팅 내용 HTML 형식으로 변환
	 */
	private String myChat(String content) {
		String chatBox = "<div class='my-chat'><span>";
		chatBox += "나: " + content;
		chatBox += "</span></div>";
		return chatBox;
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 타사용자에게 전송할 사용자의 채팅
	 * 작 성 일 : 2022.12.26.
	 * @param sender 채팅을 보낸 사용자명, content 사용자의 채팅 내용
	 * @throws Exception
	 * @return chatBox 타사용자에게 보낼 사용자의 채팅 내용 HTML 형식으로 변환
	 */
	private String notMyChat(String sender, String content) {
		String chatBox = "<div class='not-my-chat'><span>";
		chatBox += sender + ": " + content;
		chatBox += "</span></div>";
		return chatBox;
	}
	
	/**
	 * 작 성 자 : 권유진
	 * 설     명 : 사용자 채팅방 입장 동일 채팅방 다른 유저에게 전송
	 * 작 성 일 : 2022.12.28.
	 * @param roomNo 채팅방 번호, msg 전송할 메세지, session 웹 소켓 세션
	 * @throws Exception
	 */
	private void sendMsgToRoom(Integer roomNo, String msg, WebSocketSession session) {
		for (WebSocketSession sess : sessionMap.get(roomNo)) {
			if (!session.getId().equals(sess.getId())) {
				try {
					sess.sendMessage(new TextMessage(msg));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
