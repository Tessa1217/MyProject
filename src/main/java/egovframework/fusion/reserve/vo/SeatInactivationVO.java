package egovframework.fusion.reserve.vo;

public class SeatInactivationVO {
	
	private Integer inactiveNo;
	
	private Integer seatNo;
	
	private Integer roomNo;
	
	private String inactiveStartTime;
	
	private String inactiveEndTime;
	
	private String inactiveType;
	
	private String inactiveChkTime;

	public Integer getInactiveNo() {
		return inactiveNo;
	}

	public void setInactiveNo(Integer inactiveNo) {
		this.inactiveNo = inactiveNo;
	}

	public Integer getSeatNo() {
		return seatNo;
	}

	public void setSeatNo(Integer seatNo) {
		this.seatNo = seatNo;
	}

	public Integer getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Integer roomNo) {
		this.roomNo = roomNo;
	}

	public String getInactiveStartTime() {
		return inactiveStartTime;
	}

	public void setInactiveStartTime(String inactiveStartTime) {
		this.inactiveStartTime = inactiveStartTime;
	}

	public String getInactiveEndTime() {
		return inactiveEndTime;
	}

	public void setInactiveEndTime(String inactiveEndTime) {
		this.inactiveEndTime = inactiveEndTime;
	}

	public String getInactiveType() {
		return inactiveType;
	}

	public void setInactiveType(String inactiveType) {
		this.inactiveType = inactiveType;
	}

	public String getInactiveChkTime() {
		return inactiveChkTime;
	}

	public void setInactiveChkTime(String inactiveChkTime) {
		this.inactiveChkTime = inactiveChkTime;
	}
	
}