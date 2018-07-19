package com.example.jblog.controllers;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		if(result) {
			return "redirect:/user/joinsuccess";
		}else {
			return "redirect:/user/joinfail";
		}
	}
	
	@RequestMapping("/joinsuccess")
	public String joinsuccess(){
		return "user/joinsuccess";
	}

	@RequestMapping("/joinfail")
	public String joinfail(){
		return "user/joinfail";
	}
	
	@RequestMapping(value="/checkid" ,method=RequestMethod.GET)
	@ResponseBody
	public Object exist(@RequestParam("id") String id) {
		boolean exist = userService.exist(id);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", exist);
		
		return map;
	}
}
