package egovframework.fusion.reserve.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Management {
	
	private Integer manageNo;
	
	private Integer roomNo;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date manageStartDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date manageEndDate;
	
	private String manageReason;
	
	private String manageDelyn;

	public Integer getManageNo() {
		return manageNo;
	}

	public void setManageNo(Integer manageNo) {
		this.manageNo = manageNo;
	}

	public Integer getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Integer roomNo) {
		this.roomNo = roomNo;
	}

	public Date getManageStartDate() {
		return manageStartDate;
	}

	public void setManageStartDate(Date manageStartDate) {
		this.manageStartDate = manageStartDate;
	}

	public Date getManageEndDate() {
		return manageEndDate;
	}

	public void setManageEndDate(Date manageEndDate) {
		this.manageEndDate = manageEndDate;
	}

	public String getManageReason() {
		return manageReason;
	}

	public void setManageReason(String manageReason) {
		this.manageReason = manageReason;
	}

	public String getManageDelyn() {
		return manageDelyn;
	}

	public void setManageDelyn(String manageDelyn) {
		this.manageDelyn = manageDelyn;
	}
	
}
