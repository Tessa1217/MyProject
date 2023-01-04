package egovframework.fusion.reserve.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.fusion.cmmn.vo.Criteria;
import egovframework.fusion.cmmn.vo.PageDTO;
import egovframework.fusion.reserve.service.ReserveService;
import egovframework.fusion.reserve.vo.ManagementVO;
import egovframework.fusion.reserve.vo.ReservationVO;
import egovframework.fusion.reserve.vo.RoomSeatListVO;
import egovframework.fusion.reserve.vo.RoomSeatVO;
import egovframework.fusion.reserve.vo.SeatInactivationVO;
import egovframework.fusion.reserve.vo.SeatStatusVO;
import egovframework.fusion.reserve.vo.StudyRoomVO;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class ReserveController {
	
	private Logger logger = Logger.getLogger(ReserveController.class);
	
	@Autowired
	ReserveService reserveService;
	
	@RequestMapping(value="/reserve/roomList.do", method=RequestMethod.GET)
	public String getRoomList(StudyRoomVO studyRoomVO, Model model) {
		try {
			List<StudyRoomVO> rList = reserveService.getStudyRoomList(studyRoomVO);
			model.addAttribute("rList", rList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "views/reserve/roomList";
	}
	
	@RequestMapping(value="/reserve/reserveList.do", method=RequestMethod.GET)
	public String getReserveList(StudyRoomVO studyRoomVO, Model model) {
		try {
			StudyRoomVO room = reserveService.selStudyRoom(studyRoomVO);
			model.addAttribute("room", room);
		} catch (Exception e) {
			logger.error("Exception");
		}
		return "views/reserve/reserveList";
	}
	
	@RequestMapping(value="/reserve/reserveManage.do", method=RequestMethod.GET)
	public String getReserveManage() {
		return "views/reserve/reserveManage";
	}
	
	@RequestMapping(value="/reserve/roomManage.do", method=RequestMethod.POST)
	public ModelAndView roomManage(StudyRoomVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("views/reserve/manage/totalManage");
		try {
			mv.addObject("room", reserveService.selStudyRoom(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="/reserve/selStudyRoom.do", method=RequestMethod.POST)
	public ModelAndView selStudyRoom(StudyRoomVO vo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("views/reserve/manage/roomManage");
		try {
			mv.addObject("room", reserveService.selStudyRoom(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	 
	@RequestMapping(value="/reserve/reserveCalendar.do", method=RequestMethod.GET)
	public String getReserveCalendar() {
		return "views/reserve/page/reserveCalendar";
	}
	
	@RequestMapping(value="/reserve/adminSeatCalendar.do", method=RequestMethod.GET)
	public String getAdminSeatCalendar() {
		return "views/reserve/manage/seatCalendar";
	}
	
	@RequestMapping(value="/reserve/adminCalendar.do", method=RequestMethod.GET)
	public String getAdminCalendar() {
		return "views/reserve/manage/dateManage";
	}
	
	private PageDTO setPagination(Criteria cri, ReservationVO vo) {
		PageDTO paginationInfo = new PageDTO();
		paginationInfo.setCurrentPageNo(cri.getPageIndex());
		paginationInfo.setRecordCountPerPage(cri.getRecordCountPerPage());
		paginationInfo.setPageSize(cri.getPageSize());
		paginationInfo.setTotalRecordCount(reserveService.getMyReservationTotal(vo));
		return paginationInfo;
	}
	
	@RequestMapping(value="/reserve/myReserveList.do", method=RequestMethod.POST)
	public ModelAndView getReserveCalendar(HttpSession session, Criteria cri, ReservationVO vo) {
		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("user") == null) {
			mv.setViewName("redirect:/notAuthorized.do");
			return mv;
		} else {
			UserVO user = (UserVO) session.getAttribute("user");
			if ("MEMBER".equals(user.getUserAuth())) {
				vo.setUserNo(user.getUserNo());
			}
		}
		mv.setViewName("views/reserve/page/myReserveList");
		try {
			List<ReservationVO> myReserveList = reserveService.getMyReservationList(vo, cri);
			mv.addObject("myReserveList", myReserveList);
			mv.addObject("cri", cri);
			mv.addObject("paginationInfo", setPagination(cri, vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="/reserve/getStudyRoomList.do", method=RequestMethod.GET)
	public String getStudyRoomList(Model model) {
		try {
			StudyRoomVO vo = new StudyRoomVO();
			List<StudyRoomVO> sList = reserveService.getStudyRoomList(vo);
			model.addAttribute("sList", sList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "views/reserve/manage/studyRoomList";
	}
	
	@RequestMapping(value="/reserve/getManagementList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<ManagementVO> getManagementList(ManagementVO managementVO) {
		List<ManagementVO> mList = new ArrayList<ManagementVO>();
		try {
			mList = reserveService.getManagementList(managementVO);
		} catch (Exception e) {
			logger.error("Exception");
			return null;
		}
		return mList;
	}
	
	@RequestMapping(value= "/reserve/getRoomSeatList.do", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getRoomSeatList(RoomSeatVO roomSeatVo, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("views/reserve/page/roomSeat");
		mv.addObject("roomSeat", roomSeatVo);
		try {
			List<RoomSeatVO> seatList = reserveService.getRoomSeatList(roomSeatVo);
			for (RoomSeatVO seat : seatList) {
				if (seat.getSeatLoc() != null) {
					String[] locations = seat.getSeatLoc().split(", ");
					seat.setLocLeft(locations[0]);
					seat.setLocTop(locations[1]);
				}
			}
			mv.addObject("seatList", seatList);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return mv;
	}
	
	@RequestMapping(value="/reserve/getAdminRoomSeatList.do", method=RequestMethod.GET)
	public String getAdminRoomSeatPage() {
		return "views/reserve/manage/seatManage";
	}
	
	@RequestMapping(value="/reserve/getAdminRoomSeatList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<RoomSeatVO> getAdminRoomSeat(RoomSeatVO roomSeatVo) {
		List<RoomSeatVO> seatList = new ArrayList<RoomSeatVO>();
		try {
			seatList = reserveService.getRoomSeatList(roomSeatVo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return seatList;
	}
	
	@RequestMapping(value="/reserve/getReservationList.do", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getReservationList(ReservationVO reservationVo) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("views/reserve/page/seatReserve");
		StudyRoomVO studyRoomVo = new StudyRoomVO();
		studyRoomVo.setRoomNo(reservationVo.getRoomNo());
		mv.addObject("room", reserveService.selStudyRoom(studyRoomVo));
		mv.addObject("reserveInfo", reservationVo);
		return mv;
	}
	
	@RequestMapping(value="/reserve/getReservedList.do", method=RequestMethod.POST)
	@ResponseBody
	public SeatStatusVO getReservedList(ReservationVO reservationVo) {
		SeatStatusVO status = new SeatStatusVO();
		try {
			status.setReservationList(reserveService.getReservationList(reservationVo));
			SeatInactivationVO inactiveVo = new SeatInactivationVO();
			inactiveVo.setRoomNo(reservationVo.getRoomNo());
			inactiveVo.setSeatNo(reservationVo.getSeatNo());
			inactiveVo.setInactiveChkTime(reservationVo.getReserveDate());
			status.setInactiveList(reserveService.getSeatInactivationList(inactiveVo));
		} catch (Exception e) {
			logger.error("Exception");
			return null;
		}
		return status;
	}
	
	@RequestMapping(value="/reserve/selReservation.do", method=RequestMethod.POST)
	@ResponseBody
	public ReservationVO selReservation(ReservationVO reservationVo) {
		ReservationVO reservation = new ReservationVO();
		try {
			reservation = reserveService.selReservation(reservationVo);
		} catch (Exception e) {
			e.printStackTrace();
			return new ReservationVO();
		}
		return reservation;
	}
	
	@RequestMapping(value="/reserve/insReservation.do", method=RequestMethod.POST)
	@ResponseBody
	public String insReservation(ReservationVO reservationVo, HttpSession session) {
		
		if (session.getAttribute("user") == null) {
			return "failed";
		} else {
			UserVO user = (UserVO) session.getAttribute("user");
			reservationVo.setUserNo(user.getUserNo());
		}
		
		try {
			
			/*
			 * 예약 관련 유효성 검사 
			 */
			
			// 1. 예약 시간이 현재 시간보다 전인지 확인
			Date chkDate = checkPassedTime(reservationVo.getReserveDate(), reservationVo.getReserveInTime());
			if (chkDate == null) {
				return "failed";
			} else if (chkDate.before(new Date())) {
				return "passed";
			}
			
			// 2. 해당 시간에 이미 예약이 있는지 확인
			ReservationVO chkVo = reserveService.selReservation(reservationVo);
			if (chkVo != null) {
				return "occupied";
			}
			
			// 3. 해당 기간이 관리자가 휴무로 지정한 일자인지 확인 
			ManagementVO managementVo = new ManagementVO();
			String currentDate = reservationVo.getReserveDate() + " " + reservationVo.getReserveInTime();
			managementVo.setCurrentDate(currentDate);
			managementVo.setRoomNo(reservationVo.getRoomNo());
			List<ManagementVO> manageList = reserveService.getManagementList(managementVo);
			
			if (manageList.size() > 0) {
				return "managed";
			}
			
			SeatInactivationVO inactiveVo = new SeatInactivationVO();
			inactiveVo.setRoomNo(reservationVo.getRoomNo());
			inactiveVo.setSeatNo(reservationVo.getSeatNo());
			inactiveVo.setInactiveChkTime(reservationVo.getReserveDate());
			inactiveVo.setInactiveStartTime(reservationVo.getReserveInTime());
			inactiveVo.setInactiveEndTime(reservationVo.getReserveOutTime());
			
			if (reserveService.selSeatInactivation(inactiveVo) != null) {
				return "managed";
			}
			
			reserveService.insReservation(reservationVo);
			
			/*
			 * 좌석 비활성화 추가
			 */
			
			// 좌석을 예약하는 날이 오늘자가 아닌 경우/좌석을 예약하는 날이 오늘자인 경우
			reservationVo.setReserveInTime("");
			reservationVo.setReserveOutTime("");
			
			int totalReservedHour = 0;
			List<ReservationVO> reservedList = reserveService.getReservationList(reservationVo);
			
			Date reservingDate = checkPassedTime(reservationVo.getReserveDate(), reservationVo.getCurrentHour());
			Date openDate = checkPassedTime(reservationVo.getReserveDate(), reservationVo.getOpenHour());
			if (reservingDate != null && reservingDate.after(openDate)) {
				for (ReservationVO r : reservedList) {
					Date inTime = checkPassedTime(reservationVo.getReserveDate(), r.getReserveInTime());
					Date outTime = checkPassedTime(reservationVo.getReserveDate(), r.getReserveOutTime());
					if (reservingDate.after(inTime) && reservingDate.before(outTime)) {
						totalReservedHour += parseHourToString(reservationVo.getCurrentHour(), r.getReserveOutTime());
					} else {
						totalReservedHour += parseHourToString(r.getReserveInTime(), r.getReserveOutTime());
					}
				}
			} else {
				System.out.println();
				for (ReservationVO r : reservedList) {
					totalReservedHour += parseHourToString(r.getReserveInTime(), r.getReserveOutTime());
				}
			}
			
			System.out.println("=-===================================");
			System.out.println(reservationVo.getTotalHour());
			System.out.println(totalReservedHour);
			
			if (reservationVo.getTotalHour() == totalReservedHour) {
				insSeatStatus(reservationVo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception");
			return "failed";
		}
		
		return "success";
		
	}
	
	private Date checkPassedTime(String date, String time) {
		if (time == null || "".equals(time)) {
			return null;
		}
		String fullDate = date + " " + time;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date parsedDate = null;
		try {
			parsedDate = format.parse(fullDate);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
		return parsedDate;
	}
	
	private Integer parseHourToString(String startTime, String endTime) {
		Integer hour = 0;
		Integer startHour = Integer.parseInt(startTime.substring(0, 2));
		Integer endHour = Integer.parseInt(endTime.substring(0, 2));
		if (endHour > startHour) {
			hour = endHour - startHour;
		}
		return hour;
	}
	
	private void insSeatStatus(ReservationVO reservationVo) {
		SeatInactivationVO vo = new SeatInactivationVO();
		try {
			vo.setRoomNo(reservationVo.getRoomNo());
			vo.setSeatNo(reservationVo.getSeatNo());
			if (reservationVo.getCurrentHour() == null) {
				vo.setInactiveStartTime(reservationVo.getReserveDate() + " " + reservationVo.getCurrentHour());
			} else {
				vo.setInactiveStartTime(reservationVo.getReserveDate() + " " + reservationVo.getOpenHour());
			}
			if ("24:00".equals(reservationVo.getCloseHour())) {
				reservationVo.setCloseHour("23:59:59");
			}
			vo.setInactiveEndTime(reservationVo.getReserveDate() + " " + reservationVo.getCloseHour());
			vo.setInactiveType("FULL");
			reserveService.insSeatInactivation(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/reserve/getSeatInactivationList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<SeatInactivationVO> getInactiveList(SeatInactivationVO vo) {
		List<SeatInactivationVO> inactiveList = new ArrayList<SeatInactivationVO>();
		try {
			inactiveList = reserveService.getSeatInactivationList(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return inactiveList;
	}
	
	@RequestMapping(value="/reserve/insSeatInactivation.do", method=RequestMethod.POST)
	@ResponseBody
	public String insSeatInactivation(SeatInactivationVO vo) {
		try {
		 	reserveService.insSeatInactivation(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/reserve/updRoomSeat.do", method=RequestMethod.POST)
	@ResponseBody
	public String updRoomSeat(@RequestBody RoomSeatListVO listVo) {
		try {
			reserveService.manageRoomSeat(listVo);
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		} 
		return "success";
	}
	
	@RequestMapping(value="/reserve/updStudyRoom.do", method=RequestMethod.POST)
	@ResponseBody
	public String updStudyRoom(StudyRoomVO studyRoomVo) {
		try {
			reserveService.updStudyRoom(studyRoomVo);
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/reserve/updReservation.do", method=RequestMethod.POST)
	@ResponseBody
	public String updReservation(ReservationVO reservationVo) {
		try {
			reserveService.updReservation(reservationVo);
			SeatInactivationVO sVo = new SeatInactivationVO();
			sVo.setInactiveStartTime(reservationVo.getReserveDate());
			sVo.setRoomNo(reservationVo.getRoomNo());
			sVo.setSeatNo(reservationVo.getSeatNo());
			reserveService.delSeatInactivation(sVo);
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/reserve/insManagement.do", method=RequestMethod.POST)
	@ResponseBody
	public String insManagement(ManagementVO managementVo) {
		try {
			reserveService.insManagement(managementVo);
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/reserve/updManagement.do", method=RequestMethod.POST)
	@ResponseBody
	public String updManagement(ManagementVO managementVo) {
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value="/reserve/delManagement.do", method=RequestMethod.POST)
	@ResponseBody
	public String delManagement(ManagementVO managementVo) {
		try {
			reserveService.delManagement(managementVo);
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
		return "success";
	}
}
