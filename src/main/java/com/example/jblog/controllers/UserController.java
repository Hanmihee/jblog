package com.example.jblog.controllers;


import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.jblog.services.UserService;
import com.example.jblog.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/join" , method=RequestMethod.GET)
	public String moveJoinForm(@ModelAttribute UserVo vo) {
		return "user/join";
	}
	
	@RequestMapping(value="/login" ,method=RequestMethod.GET)
	public String moveLoginForm() {
		return "user/login";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinAction(@ModelAttribute @Valid UserVo vo, BindingResult bResult, Model model) {
		if(bResult.hasErrors()) {
			List<ObjectError> errors = bResult.getAllErrors();
			for(ObjectError e : errors) {
				System.out.println("ObjectError : "+e);
			}
			model.addAllAttributes(bResult.getModel());
			return "/user/join";
		}
		
		boolean result = userService.join(vo);
		
		return "redirect:/user/joinsuccess";
	}
	
	@RequestMapping("/joinsuccess")
	public String joinsuccess(){
		return "user/joinsuccess";
	}
}
