/**
 * 
 */

function moveMyReservePage(idx) {
	$("#reserve-list-main").load("/reserve/myReserveList.do", {
		pageIndex : idx
	});
}

function makeEventObject(list) {
	let newList = [];
	list.forEach((val, idx) => {
		let endDay = new Date(val.manageEndDate);
		endDay.setDate(endDay.getDate() + 1);
		newList.push({title:val.manageReason, 
					  start: val.manageStartDate, 
					  end: endDay,
					  allDay:true, 
					  id:'m-event-' + idx,
					  display:'background',
					  backgroundColor:'#111',
					  textColor:'red'});
	});
	return newList;
}


function makeAdminEventObject(list) {
	let newList = [];
	list.forEach((val, idx) => {
		let endDay = new Date(val.manageEndDate);
		endDay.setDate(endDay.getDate() + 1);
		newList.push({title:val.manageReason, 
					  start: val.manageStartDate, 
					  end: endDay,
					  allDay:true, 
					  id:val.manageNo,
					  backgroundColor:'#111',
					  textColor:'red'});
	});
	return newList;
}

function calcStartDay(date) {
	let calcDate = new Date(date);
	calcDate.setHours(0);
	calcDate.setMinutes(0);
	calcDate.setSeconds(0);
	return calcDate;
}

function calcEndDay(date) {
	let calcDate = new Date(date);
	calcDate.setHours(23);
	calcDate.setMinutes(59);
	calcDate.setSeconds(59);
	return calcDate;
}

function calcDay(date) {
	let calcDate = new Date(date);
	calcDate.setDate(calcDate.getDate() - 1);
	calcDate.setHours(23);
	calcDate.setMinutes(59);
	calcDate.setSeconds(59);
	return calcDate;
}

function dateFormatting(date) {
	const TIME_ZONE = 3240 * 10000;
	return new Date(+date + TIME_ZONE).toISOString().replace('T', ' ').replace(/\..*/, '');
}

function dateShortFormatting(date) {
	const TIME_ZONE = 3240 * 10000;
	return new Date(+date + TIME_ZONE).toISOString().split('T')[0];
}

class Management {
	constructor(roomNo, manageStartDate, manageEndDate, manageReason) {
		this.roomNo = roomNo;
		this.manageStartDate = manageStartDate;
		this.manageEndDate = manageEndDate;
		this.manageReason = manageReason;
	}
}

class RoomSeat {
	constructor(roomNo, seatNo, seatLoc) {
		this.roomNo = roomNo;
		this.seatNo = seatNo;
		this.seatLoc = seatLoc;
	} 
}

function makeManagementObject(arg) {
	return new Management(arg.roomNo, dateFormatting(arg.start), dateFormatting(calcDay(arg.end)), arg.title);
}