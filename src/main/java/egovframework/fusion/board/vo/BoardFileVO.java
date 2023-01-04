package egovframework.fusion.board.vo;

import java.util.Date;

public class BoardFileVO {
	
	private int fileNo;
	
	private int boardNo;
	
	private String fileOriName;
	
	private String fileStoredName;
	
	private String filePath;
	
	private String fileExtension;
	
	private double fileSize;
	
	private Date fileRegDate;
	
	private int fileOrder;
	
	private String fileDelyn;
	
	private int fileDownCnt;
	
	private String fileIsThumbnail;
	
	private String thumbnailPath;

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getFileOriName() {
		return fileOriName;
	}

	public void setFileOriName(String fileOriName) {
		this.fileOriName = fileOriName;
	}

	public String getFileStoredName() {
		return fileStoredName;
	}

	public void setFileStoredName(String fileStoredName) {
		this.fileStoredName = fileStoredName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileExtension() {
		return fileExtension;
	}

	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}

	public double getFileSize() {
		return fileSize;
	}

	public void setFileSize(double fileSize) {
		this.fileSize = fileSize;
	}

	public Date getFileRegDate() {
		return fileRegDate;
	}

	public void setFileRegDate(Date fileRegDate) {
		this.fileRegDate = fileRegDate;
	}

	public int getFileOrder() {
		return fileOrder;
	}

	public void setFileOrder(int fileOrder) {
		this.fileOrder = fileOrder;
	}

	public String getFileDelyn() {
		return fileDelyn;
	}

	public void setFileDelyn(String fileDelyn) {
		this.fileDelyn = fileDelyn;
	}

	public int getFileDownCnt() {
		return fileDownCnt;
	}

	public void setFileDownCnt(int fileDownCnt) {
		this.fileDownCnt = fileDownCnt;
	}
	
	public String getFileIsThumbnail() {
		return fileIsThumbnail;
	}
	
	public void setFileIsThumbnail(String fileIsThumbnail) {
		this.fileIsThumbnail = fileIsThumbnail;
	}

	public String getThumbnailPath() {
		return thumbnailPath;
	}

	public void setThumbnailPath(String thumbnailPath) {
		this.thumbnailPath = thumbnailPath;
	}
	
	
}
