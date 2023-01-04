package egovframework.fusion.comment.vo;

import java.util.Date;

public class Comment {

	private int commentNo;

	private int boardNo;

	private int userNo;

	private String commentContent;

	private Date commentRegDate;

	private Date commentModDate;

	private int commentParentNo;
	
	private String commentDelyn;

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

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

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentRegDate() {
		return commentRegDate;
	}

	public void setCommentRegDate(Date commentRegDate) {
		this.commentRegDate = commentRegDate;
	}

	public Date getCommentModDate() {
		return commentModDate;
	}

	public void setCommentModDate(Date commentModDate) {
		this.commentModDate = commentModDate;
	}

	public int getCommentParentNo() {
		return commentParentNo;
	}

	public void setCommentParentNo(int commentParentNo) {
		this.commentParentNo = commentParentNo;
	}
	
	public String getCommentDelyn() {
		return commentDelyn;
	}

	public void setCommentDelyn(String commentDelyn) {
		this.commentDelyn = commentDelyn;
	}
	

}
