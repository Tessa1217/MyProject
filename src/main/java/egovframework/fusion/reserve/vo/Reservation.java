package egovframework.fusion.reserve.vo;

public class Reservation {
	
	private Integer reserveNo;
	
	private Integer userNo;
	
	private Integer roomNo;
	
	private Integer seatNo;
	
	private String reserveDate;
	
	private String reserveInTime;
	
	private String reserveOutTime;
	
	private String reserveDelyn;
	
	private String reserveReason;

	public Integer getReserveNo() {
		return reserveNo;
	}

	public void setReserveNo(Integer reserveNo) {
		this.reserveNo = reserveNo;
	}

	public Integer getUserNo() {
		return userNo;
	}

	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}

	public Integer getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Integer roomNo) {
		this.roomNo = roomNo;
	}

	public Integer getSeatNo() {
		return seatNo;
	}

	public void setSeatNo(Integer seatNo) {
		this.seatNo = seatNo;
	}

	public String getReserveDate() {
		return reserveDate;
	}

	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}

	public String getReserveInTime() {
		return reserveInTime;
	}

	public void setReserveInTime(String reserveInTime) {
		this.reserveInTime = reserveInTime;
	}

	public String getReserveOutTime() {
		return reserveOutTime;
	}

	public void setReserveOutTime(String reserveOutTime) {
		this.reserveOutTime = reserveOutTime;
	}

	public String getReserveDelyn() {
		return reserveDelyn;
	}

	public void setReserveDelyn(String reserveDelyn) {
		this.reserveDelyn = reserveDelyn;
	}

	public String getReserveReason() {
		return reserveReason;
	}

	public void setReserveReason(String reserveReason) {
		this.reserveReason = reserveReason;
	}

}
