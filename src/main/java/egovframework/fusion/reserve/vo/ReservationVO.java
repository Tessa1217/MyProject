package egovframework.fusion.reserve.vo;

import java.util.Date;

public class ReservationVO extends Reservation {
	
	// 총 운영시간 
	
	private Integer totalHour;
	
	private String currentHour;
	
	private String openHour;
	
	private String closeHour;
	
	private String userName;
	
	private Date reserveFullDate;
	
	private String reserveChkStart;
	
	private String reserveChkEnd;
	

	public Integer getTotalHour() {
		return totalHour;
	}

	public void setTotalHour(Integer totalHour) {
		this.totalHour = totalHour;
	}
	
	public String getCurrentHour() {
		return currentHour;
	}

	public void setCurrentHour(String currentHour) {
		this.currentHour = currentHour;
	}
	
	public String getOpenHour() {
		return openHour;
	}

	public void setOpenHour(String openHour) {
		this.openHour = openHour;
	}
	
	public String getCloseHour() {
		return closeHour;
	}

	public void setCloseHour(String closeHour) {
		this.closeHour = closeHour;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getReserveFullDate() {
		return reserveFullDate;
	}

	public void setReserveFullDate(Date reserveFullDate) {
		this.reserveFullDate = reserveFullDate;
	}

	public String getReserveChkStart() {
		return reserveChkStart;
	}

	public void setReserveChkStart(String reserveChkStart) {
		this.reserveChkStart = reserveChkStart;
	}

	public String getReserveChkEnd() {
		return reserveChkEnd;
	}

	public void setReserveChkEnd(String reserveChkEnd) {
		this.reserveChkEnd = reserveChkEnd;
	}
	
}
