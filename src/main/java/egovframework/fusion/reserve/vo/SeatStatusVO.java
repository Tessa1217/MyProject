package egovframework.fusion.reserve.vo;

import java.util.List;

public class SeatStatusVO {
	
	private List<ReservationVO> reservationList;
	
	private List<SeatInactivationVO> inactiveList;

	public List<ReservationVO> getReservationList() {
		return reservationList;
	}

	public void setReservationList(List<ReservationVO> reservationList) {
		this.reservationList = reservationList;
	}

	public List<SeatInactivationVO> getInactiveList() {
		return inactiveList;
	}

	public void setInactiveList(List<SeatInactivationVO> inactiveList) {
		this.inactiveList = inactiveList;
	}
	
}
