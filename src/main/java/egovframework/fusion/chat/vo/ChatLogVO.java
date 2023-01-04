package egovframework.fusion.chat.vo;

import java.util.Date;

public class ChatLogVO {
	
	private Integer roomNo;
	
	private Integer userNo;
		
	private Date roomEnterDate;

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

	public Date getRoomEnterDate() {
		return roomEnterDate;
	}

	public void setRoomEnterDate(Date roomEnterDate) {
		this.roomEnterDate = roomEnterDate;
	}
	
}
