package com.example.jblog.vo;

import javax.validation.constraints.NotEmpty;

public class UserVo {
	private Long no;

	@NotEmpty
	private String name;
	@NotEmpty
	private String id;
	@NotEmpty
	private String password;
}
