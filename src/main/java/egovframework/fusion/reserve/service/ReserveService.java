package egovframework.fusion.reserve.service;

import java.util.List;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.reserve.vo.ManagementVO;
import egovframework.fusion.reserve.vo.ReservationVO;
import egovframework.fusion.reserve.vo.RoomSeatListVO;
import egovframework.fusion.reserve.vo.RoomSeatVO;
import egovframework.fusion.reserve.vo.SeatInactivationVO;
import egovframework.fusion.reserve.vo.StudyRoomVO;

public interface ReserveService {
	
	List<RoomSeatVO> getRoomSeatList(RoomSeatVO vo);
	
	List<StudyRoomVO> getStudyRoomList(StudyRoomVO vo);
	
	List<ManagementVO> getManagementList(ManagementVO vo);
	
	List<ReservationVO> getReservationList(ReservationVO vo);
	
	List<ReservationVO> getMyReservationList(ReservationVO vo, Criteria cri);
	
	List<SeatInactivationVO> getSeatInactivationList(SeatInactivationVO vo);
	
	Integer getMyReservationTotal(ReservationVO vo);
	
	SeatInactivationVO selSeatInactivation(SeatInactivationVO vo);
	
	StudyRoomVO selStudyRoom(StudyRoomVO vo);
	
	ReservationVO selReservation(ReservationVO vo);
	
	void updStudyRoom(StudyRoomVO vo);
	
	void manageRoomSeat(RoomSeatListVO vo);
	
	void insManagement(ManagementVO vo);
	
	void updManagement(ManagementVO vo);
	
	void delManagement(ManagementVO vo);
	
	void insReservation(ReservationVO vo);
	
	void updReservation(ReservationVO vo);
	
	void insSeatInactivation(SeatInactivationVO vo);
	
	void delSeatInactivation(SeatInactivationVO vo);

}
