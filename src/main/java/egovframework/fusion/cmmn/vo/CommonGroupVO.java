package egovframework.fusion.cmmn.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class CommonGroupVO {
	
	private String oriGpCode;
	
	private String gpCode;
	
	private String gpNm;
	
	private String gpDesc;
	
	private Date gpRegDate;

	private Date gpModDate;
	
	private String gpDelyn;
	
	private List<CommonCodeVO> codeList;
	
	private Integer cdCount;
	
	public String getOriGpCode() {
		return oriGpCode;
	}

	public void setOriGpCode(String oriGpCode) {
		this.oriGpCode = oriGpCode;
	}

	public String getGpCode() {
		return gpCode;
	}

	public void setGpCode(String gpCode) {
		this.gpCode = gpCode;
	}

	public String getGpNm() {
		return gpNm;
	}

	public void setGpNm(String gpNm) {
		this.gpNm = gpNm;
	}

	public String getGpDesc() {
		return gpDesc;
	}

	public void setGpDesc(String gpDesc) {
		this.gpDesc = gpDesc;
	}

	public Date getGpRegDate() {
		return gpRegDate;
	}

	public void setGpRegDate(Date gpRegDate) {
		this.gpRegDate = gpRegDate;
	}

	public Date getGpModDate() {
		return gpModDate;
	}

	public void setGpModDate(Date gpModDate) {
		this.gpModDate = gpModDate;
	}

	public String getGpDelyn() {
		return gpDelyn;
	}

	public void setGpDelyn(String gpDelyn) {
		this.gpDelyn = gpDelyn;
	}

	public List<CommonCodeVO> getCodeList() {
		return codeList;
	}

	public void setCodeList(List<CommonCodeVO> codeList) {
		this.codeList = codeList;
	}

	public Integer getCdCount() {
		return cdCount;
	}

	public void setCdCount(Integer cdCount) {
		this.cdCount = cdCount;
	}

}
