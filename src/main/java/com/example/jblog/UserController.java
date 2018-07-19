package com.example.jblog;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class UserController {
	@RequestMapping(value="/join" , method=RequestMethod.GET)
	public String moveJoinForm() {
		return "user/join";
	}
	
	@RequestMapping(value="/login" ,method=RequestMethod.GET)
	public String moveLoginForm() {
		return "user/login";
	}
}
