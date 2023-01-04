package egovframework.fusion.chat.service;

import java.util.List;

import egovframework.fusion.chat.vo.ChatLogVO;
import egovframework.fusion.chat.vo.ChatMessageVO;
import egovframework.fusion.chat.vo.ChatRoomVO;
import egovframework.fusion.cmmn.vo.Criteria;

public interface ChatService {
	
	public List<ChatRoomVO> getChatRoomList(ChatRoomVO vo);
	
	public List<ChatMessageVO> getChatMessageList(ChatLogVO vo, Criteria cri);
	
	public ChatRoomVO selChatRoom(ChatRoomVO vo);
	
	public ChatLogVO selChatLog(ChatLogVO vo);
	
	public void insChatLog(ChatLogVO vo);
	
	public void insChatMessage(ChatMessageVO vo);
	
}
