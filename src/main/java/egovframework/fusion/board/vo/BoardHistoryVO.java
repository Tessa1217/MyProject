package egovframework.fusion.board.vo;

import java.util.Date;

public class BoardHistoryVO {
	
	private Date visitDate;
	
	private int visitUserNo;
	
	private int visitBoardNo;
	
	public BoardHistoryVO() {
		super();
	}

	public BoardHistoryVO(int visitUserNo, int visitBoardNo) {
		super();
		this.visitUserNo = visitUserNo;
		this.visitBoardNo = visitBoardNo;
	}

	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

	public int getVisitUserNo() {
		return visitUserNo;
	}

	public void setVisitUserNo(int visitUserNo) {
		this.visitUserNo = visitUserNo;
	}

	public int getVisitBoardNo() {
		return visitBoardNo;
	}

	public void setVisitBoardNo(int visitBoardNo) {
		this.visitBoardNo = visitBoardNo;
	}

}
