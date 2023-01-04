package egovframework.fusion.chat.vo;

import java.util.Date;

public class ChatMessageVO {
	
	private Integer messageNo;
	
	private Integer roomNo;
	
	private Integer userNo;
	
	private String userName;
	
	private String messageContent;
	
	private Date messageRegDate;

	public Integer getMessageNo() {
		return messageNo;
	}

	public void setMessageNo(Integer messageNo) {
		this.messageNo = messageNo;
	}

	public Integer getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Integer roomNo) {
		this.roomNo = roomNo;
	}

	public Integer getUserNo() {
		return userNo;
	}

	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public Date getMessageRegDate() {
		return messageRegDate;
	}

	public void setMessageRegDate(Date messageRegDate) {
		this.messageRegDate = messageRegDate;
	}

	@Override
	public String toString() {
		return "ChatMessageVO [messageNo=" + messageNo + ", roomNo=" + roomNo + ", userNo=" + userNo + ", userName="
				+ userName + ", messageContent=" + messageContent + ", messageRegDate=" + messageRegDate + "]";
	}
	
}
