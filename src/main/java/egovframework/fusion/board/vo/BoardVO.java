package egovframework.fusion.board.vo;

import java.util.List;

public class BoardVO extends Board {
	
	private String userName;
	
	private int boardLevel;
	
	private List<BoardFileVO> boardFiles;
	
	private List<BoardTagVO> boardTags;
	
	private String tagString;
	
	private String thumbnailIdx;
	
	private String thumbnailPath;
	
	private int boardLikeCnt;
	
	private Integer boardLikeYn;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getBoardLevel() {
		return boardLevel;
	}

	public void setBoardLevel(int boardLevel) {
		this.boardLevel = boardLevel;
	}

	public List<BoardFileVO> getBoardFiles() {
		return boardFiles;
	}

	public void setBoardFiles(List<BoardFileVO> boardFiles) {
		this.boardFiles = boardFiles;
	}

	public List<BoardTagVO> getBoardTags() {
		return boardTags;
	}

	public void setBoardTags(List<BoardTagVO> boardTags) {
		this.boardTags = boardTags;
	}
	
	public String getTagString() {
		return tagString;
	}
	
	public void setTagString(String tagString) {
		this.tagString = tagString;
	}
	
	public String getThumbnailIdx() {
		return thumbnailIdx;
	}
	
	public void setThumbnailIdx(String thumbnailIdx) {
		this.thumbnailIdx = thumbnailIdx;
	}
	
	public String getThumbnailPath() {
		return thumbnailPath;
	}
	
	public void setThumbnailPath(String thumbnailPath) {
		this.thumbnailPath = thumbnailPath;
	}

	public int getBoardLikeCnt() {
		return boardLikeCnt;
	}

	public void setBoardLikeCnt(int boardLikeCnt) {
		this.boardLikeCnt = boardLikeCnt;
	}

	public Integer getBoardLikeYn() {
		return boardLikeYn;
	}

	public void setBoardLikeYn(Integer boardLikeYn) {
		this.boardLikeYn = boardLikeYn;
	}
	
}
