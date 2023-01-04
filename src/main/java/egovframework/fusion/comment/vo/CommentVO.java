package egovframework.fusion.comment.vo;

public class CommentVO extends Comment {
	
	private int commentLevel;
	
	private Integer commentIsLeaf; 
	
	private String userName;
	
	public int getCommentLevel() {
		return commentLevel;
	}
	public void setCommentLevel(int commentLevel) {
		this.commentLevel = commentLevel;
	}

	public Integer getCommentIsLeaf() {
		return commentIsLeaf;
	}
	public void setCommentIsLeaf(Integer commentIsLeaf) {
		this.commentIsLeaf = commentIsLeaf;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserId(String userName) {
		this.userName = userName;
	}
	
	
}
