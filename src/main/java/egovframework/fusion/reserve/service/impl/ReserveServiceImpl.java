package egovframework.fusion.reserve.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.reserve.service.ReserveMapper;
import egovframework.fusion.reserve.service.ReserveService;
import egovframework.fusion.reserve.vo.ManagementVO;
import egovframework.fusion.reserve.vo.ReservationVO;
import egovframework.fusion.reserve.vo.RoomSeatListVO;
import egovframework.fusion.reserve.vo.RoomSeatVO;
import egovframework.fusion.reserve.vo.SeatInactivationVO;
import egovframework.fusion.reserve.vo.StudyRoomVO;

@Service
public class ReserveServiceImpl implements ReserveService {
	
	@Autowired
	ReserveMapper reserveMapper;
	
	@Override
	public List<StudyRoomVO> getStudyRoomList(StudyRoomVO vo) {
		return reserveMapper.getStudyRoomList(vo);
	}
	
	@Override
	public List<RoomSeatVO> getRoomSeatList(RoomSeatVO vo) {
		return reserveMapper.getRoomSeatList(vo);
	}
	
	@Override
	public List<ManagementVO> getManagementList(ManagementVO vo) {
		return reserveMapper.getManagementList(vo);
	}
	
	@Override
	public List<ReservationVO> getReservationList(ReservationVO vo) {
		return reserveMapper.getReservationList(vo);
	}
	
	@Override
	public List<ReservationVO> getMyReservationList(ReservationVO vo, Criteria cri) {
		return reserveMapper.getMyReservationList(vo, cri);
	}
	
	@Override
	public List<SeatInactivationVO> getSeatInactivationList(SeatInactivationVO vo) {
		return reserveMapper.getSeatInactivationList(vo);
	}
	
	@Override
	public Integer getMyReservationTotal(ReservationVO vo) {
		return reserveMapper.getMyReservationTotal(vo);
	}
	
	@Override
	public SeatInactivationVO selSeatInactivation(SeatInactivationVO vo) {
		return reserveMapper.selSeatInactivation(vo);
	}
	
	@Override
	public StudyRoomVO selStudyRoom(StudyRoomVO vo) {
		return reserveMapper.selStudyRoom(vo);
	}
	
	@Override
	public ReservationVO selReservation(ReservationVO vo) {
		return reserveMapper.selReservation(vo);
	}
	
	@Override
	public void updStudyRoom(StudyRoomVO vo) {
		reserveMapper.updStudyRoom(vo);
	}
	
	@Override
	@Transactional
	public void manageRoomSeat(RoomSeatListVO vo) {
		if (vo != null) {
			if (vo.getInsList() != null && vo.getInsList().size() != 0) {
				reserveMapper.insRoomSeat(vo.getInsList());
			}
			if (vo.getUpdList() != null && vo.getUpdList().size() != 0) {
				reserveMapper.updRoomSeat(vo.getUpdList());
			}
		}
	}
	
	@Override
	public void insManagement(ManagementVO vo) {
		reserveMapper.insManagement(vo);
	}

	@Override
	public void updManagement(ManagementVO vo) {
		reserveMapper.updManagement(vo);
	}

	@Override
	public void delManagement(ManagementVO vo) {
		reserveMapper.delManagement(vo);
	}

	@Override
	public void insReservation(ReservationVO vo) {
		reserveMapper.insReservation(vo);
	}
	
	@Override
	public void updReservation(ReservationVO vo) {
		reserveMapper.updReservation(vo);
	}

	@Override
	public void insSeatInactivation(SeatInactivationVO vo) {
		reserveMapper.insSeatInactivation(vo);
	}

	@Override
	public void delSeatInactivation(SeatInactivationVO vo) {
		reserveMapper.delSeatInactivation(vo);
	}


}