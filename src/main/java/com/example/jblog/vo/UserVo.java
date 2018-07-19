package com.example.jblog.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

public class UserVo {
	private Long no;

	@NotEmpty
	@Length(min = 2, max = 5)
	private String name;
	@NotEmpty
	@Length(min = 2, max = 20)
	private String id;
	@NotEmpty
	@Pattern(regexp = "^[0-9a-zA-Z]{4,10}$")
	private String password;

	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "UserVo [no=" + no + ", name=" + name + ", id=" + id + ", password=" + password + "]";
	}
}
