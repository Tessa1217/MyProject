package egovframework.fusion.chat.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.chat.service.ChatService;
import egovframework.fusion.chat.vo.ChatLogVO;
import egovframework.fusion.chat.vo.ChatMessageVO;
import egovframework.fusion.chat.vo.ChatRoomVO;
import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping(value="/chat/chatRoomList.do", method=RequestMethod.GET)
	public String getChatRoomList(ChatRoomVO vo, Model model) {
		try {
			List<ChatRoomVO> roomList = chatService.getChatRoomList(vo);
			model.addAttribute("roomList", roomList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "views/chat/chatRoomList";
	}
	
	@RequestMapping(value="/chat/chatRoom.do", method=RequestMethod.GET)
	public String getChatRoom(ChatRoomVO vo, Model model, HttpSession session) {
		try {
			ChatRoomVO chatRoom = chatService.selChatRoom(vo);
			model.addAttribute("chatRoom", chatRoom);
			UserVO user = (UserVO) session.getAttribute("user");
			if (user != null) {
				ChatLogVO logVo = new ChatLogVO();
				logVo.setRoomNo(vo.getRoomNo());
				logVo.setUserNo(user.getUserNo());
				try {
					if (chatService.selChatLog(logVo) == null) {
						chatService.insChatLog(logVo);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "views/chat/chatRoom";
	}
	
	@RequestMapping(value="/chat/getChatMessageList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<ChatMessageVO> getChatMessageList(ChatLogVO vo, @RequestParam Integer pageIdx) {
		List<ChatMessageVO> msgList= new ArrayList<ChatMessageVO>();
		try {
			if (chatService.selChatLog(vo) != null) {
				Criteria cri = getCriteria(pageIdx);
				msgList = chatService.getChatMessageList(vo, cri);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msgList;
	}
	
	@RequestMapping(value="/chat/chattingRoom.do", method=RequestMethod.GET)
	public String getReplyEcho(ChatRoomVO vo, Model model, HttpSession session) {
		try {
			ChatRoomVO chatRoom = chatService.selChatRoom(vo);
			model.addAttribute("chatRoom", chatRoom);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "views/chat/replyEcho";
	}
	
	private Criteria getCriteria(Integer pageIdx) {
		Criteria cri = new Criteria();
		cri.setRecordCountPerPage(20);
		cri.setPageIndex(pageIdx);
		return cri;
	}


}
