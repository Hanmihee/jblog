package com.example.jblog.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloControlloer {
	
	@RequestMapping("/")
	public String hello() {
		return "home"; 
	}
	
	/*@RequestMapping("/blog/myblog")
	public String blog() {
		return "blog/blogmain"; 
	}
	@RequestMapping("/blog/basicsetting")
	public String basicsetting() {
		return "blog/basicsetting"; 
	}*/
}
