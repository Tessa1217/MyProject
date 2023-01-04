package egovframework.fusion.board.vo;

import java.util.Date;

public class Board {
	
    private int boardNo;
	
	private int userNo;
	
	private String boardTypeNo;
	
	private String boardTitle;
	
	private String boardContent;
	
	private int boardViewCnt;
	
	private Date boardRegDate;
	
	private Date boardModDate;
	
	private String boardDelyn;
	
	private int boardParentNo;
	
	private String boardPopupyn;
	
	private Integer bulletinNo;

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getBoardTypeNo() {
		return boardTypeNo;
	}

	public void setBoardTypeNo(String boardTypeNo) {
		this.boardTypeNo = boardTypeNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public int getBoardViewCnt() {
		return boardViewCnt;
	}

	public void setBoardViewCnt(int boardViewCnt) {
		this.boardViewCnt = boardViewCnt;
	}

	public Date getBoardRegDate() {
		return boardRegDate;
	}

	public void setBoardRegDate(Date boardRegDate) {
		this.boardRegDate = boardRegDate;
	}

	public Date getBoardModDate() {
		return boardModDate;
	}

	public void setBoardModDate(Date boardModDate) {
		this.boardModDate = boardModDate;
	}

	public String getBoardDelyn() {
		return boardDelyn;
	}

	public void setBoardDelyn(String boardDelyn) {
		this.boardDelyn = boardDelyn;
	}

	public int getBoardParentNo() {
		return boardParentNo;
	}

	public void setBoardParentNo(int boardParentNo) {
		this.boardParentNo = boardParentNo;
	}

	public String getBoardPopupyn() {
		return boardPopupyn;
	}

	public void setBoardPopupyn(String boardPopupyn) {
		this.boardPopupyn = boardPopupyn;
	}

	public Integer getBulletinNo() {
		return bulletinNo;
	}

	public void setBulletinNo(Integer bulletinNo) {
		this.bulletinNo = bulletinNo;
	}
	
}
