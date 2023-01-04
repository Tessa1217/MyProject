package egovframework.fusion.manage.vo;

import java.util.List;

public class MenuVO extends Menu {
	
	private String fullPath;
	
	private String userAuthCode;
	
	private List<String> userAuthList;
	
	public String getFullPath() {
		return fullPath;
	}

	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}

	public String getUserAuthCode() {
		return userAuthCode;
	}

	public void setUserAuthCode(String userAuthCode) {
		this.userAuthCode = userAuthCode;
	}

	public List<String> getUserAuthList() {
		return userAuthList;
	}

	public void setUserAuthList(List<String> userAuthList) {
		this.userAuthList = userAuthList;
	}
	
}
