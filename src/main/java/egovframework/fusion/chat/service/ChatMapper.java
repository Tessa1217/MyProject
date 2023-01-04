package egovframework.fusion.chat.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.chat.vo.ChatLogVO;
import egovframework.fusion.chat.vo.ChatMessageVO;
import egovframework.fusion.chat.vo.ChatRoomVO;
import egovframework.fusion.cmmn.vo.Criteria;

@Mapper
public interface ChatMapper {
	
	public List<ChatRoomVO> getChatRoomList(ChatRoomVO vo);
	
	public List<ChatMessageVO> getChatMessageList(@Param("chat") ChatLogVO vo, @Param("cri") Criteria cri);
	
	public ChatRoomVO selChatRoom(ChatRoomVO vo);
	
	public ChatLogVO selChatLog(ChatLogVO vo);
	
	public void insChatLog(ChatLogVO vo);
	
	public void insChatMessage(ChatMessageVO vo);

}
