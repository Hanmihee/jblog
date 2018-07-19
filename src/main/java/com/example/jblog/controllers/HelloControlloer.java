package com.example.jblog.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloControlloer {
	@RequestMapping("/")
	public String hello() {
		return "home"; 
	}
}
