package com.example.jblog.vo;

public class BlogVo {
	private Long no;
	private Long userNo;
	private String title;
	private String logo;

	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public Long getUserNo() {
		return userNo;
	}

	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	@Override
	public String toString() {
		return "BlogVo [no=" + no + ", userNo=" + userNo + ", title=" + title + ", logo=" + logo + "]";
	}
}
