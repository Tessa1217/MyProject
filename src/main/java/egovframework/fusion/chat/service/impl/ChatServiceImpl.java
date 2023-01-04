package egovframework.fusion.chat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.chat.service.ChatMapper;
import egovframework.fusion.chat.service.ChatService;
import egovframework.fusion.chat.vo.ChatLogVO;
import egovframework.fusion.chat.vo.ChatMessageVO;
import egovframework.fusion.chat.vo.ChatRoomVO;
import egovframework.fusion.cmmn.vo.Criteria;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	ChatMapper chatMapper;
	
	@Override
	public List<ChatRoomVO> getChatRoomList(ChatRoomVO vo) {
		return chatMapper.getChatRoomList(vo);
	}

	@Override
	public ChatRoomVO selChatRoom(ChatRoomVO vo) {
		return chatMapper.selChatRoom(vo);
	}
	
	@Override
	public ChatLogVO selChatLog(ChatLogVO vo) {
		return chatMapper.selChatLog(vo);
	}

	@Override
	public List<ChatMessageVO> getChatMessageList(ChatLogVO vo, Criteria cri) {
		return chatMapper.getChatMessageList(vo, cri);
	}
	
	@Override
	public void insChatLog(ChatLogVO vo) {
		chatMapper.insChatLog(vo);
	}

	@Override
	public void insChatMessage(ChatMessageVO vo) {
		chatMapper.insChatMessage(vo);
	}

}
