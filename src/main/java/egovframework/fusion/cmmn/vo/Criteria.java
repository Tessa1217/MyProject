package egovframework.fusion.cmmn.vo;

import org.springframework.web.util.UriComponentsBuilder;

public class Criteria {

	private int pageIndex = 1;
	
	private int pageUnit = 10;
	
	private int pageSize = 10;
	
	private int firstIndex = 1;
	
	private int lastIndex = 1;
	
	private int recordCountPerPage = 10;
	
	private int rowNo = 0;
	
	private String searchKeyword = "";
	
	private String searchCnd = "";
	
	private String command;
	
	private int startRow;
	
	private int endRow;
	
	private String searchCategory;
	
	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getRowNo() {
		return rowNo;
	}

	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchCnd() {
		return searchCnd;
	}

	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}
	
	public String getCommand() {
		return command;
	}
	
	public void setCommand(String command) {
		this.command = command;
	}
	
	public int getStartRow() {
		startRow = (getPageIndex() - 1) * getRecordCountPerPage() + 1;
		return startRow;
	}

	public int getEndRow() {
		endRow = (getPageIndex() * getRecordCountPerPage());
		return endRow;
	}

	public String getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}

	public String queryString() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageIndex", pageIndex)
				.queryParam("recordCountPerPage", recordCountPerPage)
				.queryParam("searchCnd", searchCnd)
				.queryParam("searchKeyword", searchKeyword);
		return builder.toUriString();
	}

}
