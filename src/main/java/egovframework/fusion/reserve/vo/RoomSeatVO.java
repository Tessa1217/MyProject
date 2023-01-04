package egovframework.fusion.reserve.vo;

public class RoomSeatVO extends RoomSeat {
	
	private String currentDate;
	
	private String currentHour; 
	
	private String openHour;
	
	private String closeHour;
	
	private Integer seatTotalHour;
	
	private Integer totalHour;
	
	private String seatOccupied;
	
	private String locLeft;
	
	private String locTop;
	
	public String getCurrentDate() {
		return currentDate;
	}

	public void setCurrentDate(String currentDate) {
		this.currentDate = currentDate;
	}
	
	public String getCurrentHour() {
		return currentHour;
	}

	public void setCurrentHour(String currentHour) {
		this.currentHour = currentHour;
	}

	public Integer getSeatTotalHour() {
		return seatTotalHour;
	}

	public void setSeatTotalHour(Integer seatTotalHour) {
		this.seatTotalHour = seatTotalHour;
	}
	
	public Integer getTotalHour() {
		return totalHour;
	}

	public void setTotalHour(Integer totalHour) {
		this.totalHour = totalHour;
	}

	public String getSeatOccupied() {
		return seatOccupied;
	}

	public void setSeatOccupied(String seatOccupied) {
		this.seatOccupied = seatOccupied;
	}

	public String getLocLeft() {
		return locLeft;
	}

	public void setLocLeft(String locLeft) {
		this.locLeft = locLeft;
	}

	public String getLocTop() {
		return locTop;
	}

	public void setLocTop(String locTop) {
		this.locTop = locTop;
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
	
}
