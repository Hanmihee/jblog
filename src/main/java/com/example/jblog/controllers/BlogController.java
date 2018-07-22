package com.example.jblog.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.jblog.services.BlogService;
import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.CategoryVo;
import com.example.jblog.vo.PostVo;

@Controller
@RequestMapping("/blog")
public class BlogController {
	@Autowired
	private BlogService blogService;

	@RequestMapping(value = "/{userId}/admin/basicsetting", method = RequestMethod.GET)
	public String moveBasicSetting() {
		return "blog/basicsetting";
	}

	@RequestMapping(value = "/{userId}/admin/boardwriteform", method = RequestMethod.GET)
	public String moveBoardWrite(Model model, @PathVariable("userId") String userId) {
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		model.addAttribute("categoryVo",categoryVo);
		return "blog/boardwriteform";
	}

	@RequestMapping(value = "/{userId}/admin/categorysetting", method = RequestMethod.GET)
	public String moveCategorySetting(Model model,@PathVariable("userId") String userId) {
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId); 
		model.addAttribute("categoryVo",categoryVo);
		return "blog/categorysetting";
	}

	@RequestMapping(value = "/{userId}/admin/boardwrite", method = RequestMethod.POST)
	public String boardWriteAction(@PathVariable("userId") String userId,@ModelAttribute PostVo vo) {
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("title", vo.getTitle());
		System.out.println("title : "+vo.getTitle());
		postMap.put("content", vo.getContent());
		System.out.println("content : "+vo.getContent());
		postMap.put("categoryNo", vo.getCategoryNo());
		System.out.println("categoryNo : "+vo.getCategoryNo());
		postMap.put("id", userId);
		
		boolean result = blogService.writePost(postMap);
		
		if(result) {
		return "blog/postsuccess";
		}else {
			return "blog/postfail";
		}
	}
	
	@RequestMapping(value="/{userId}/admin/getCategoryList",method=RequestMethod.GET)
	@ResponseBody
	public List<CategoryVo> getCategoryList(@PathVariable("userId") String userId) {
	        return blogService.getCategoryList(userId);
	}

	@RequestMapping(value ="/{userId}/admin/categoryadd", method = RequestMethod.POST)
	@ResponseBody
	public Object addCategory(@PathVariable("userId") String userId, @RequestParam("name") String name,
			@RequestParam("description") String description) {
		
		Map<String, Object> categoryMap = new HashMap<String, Object>();
		categoryMap.put("name", name);
		categoryMap.put("description", description);
		categoryMap.put("id", userId);

		boolean result = blogService.addCategory(categoryMap);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", result);
		
		return map;
	}

	@RequestMapping(value = "/{userId}/admin/categorydelete", method = RequestMethod.POST)
	@ResponseBody
	public Object deleteCategory(@PathVariable("userId") String userId, @RequestParam("no") String no) {
		Map<String, Object> categoryMap = new HashMap<String, Object>();
		categoryMap.put("no", no);
		categoryMap.put("id", userId);

		boolean result = blogService.deleteCategory(categoryMap);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", result);

		return map;
	}

	@RequestMapping(value = "/{userId}", method = RequestMethod.GET)
	public String myBlog(@PathVariable("userId") String userId, Model model) {

		BlogVo blogvo = blogService.getBlogContent(userId);

		if (blogvo != null) {
			// 이름이 존재함
			model.addAttribute("blog", blogvo);
			return "blog/blogmain";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}

	@RequestMapping(value = "/{userId}/admin/updatesetting", method = RequestMethod.POST)
	public String updateSetting(@PathVariable("userId") String userId, @RequestParam("logo") MultipartFile logoImg,
			@RequestParam("blogName") String blogName, Model model) {
		if (logoImg == null) {
			return "redirect:/blog/basicsetting";
		}
		System.out.println("update : " + logoImg);

		String saveFilename = blogService.updateSetting(logoImg);

		Map<String, String> blogMap = new HashMap<String, String>();
		blogMap.put("title", blogName);
		blogMap.put("logo", saveFilename);
		blogMap.put("id", userId);

		boolean result = blogService.updateBlogNameAndLogo(blogMap);

		if (result) {
			return "blog/updatesuccess";
		} else {
			return "blog/updateFail";
		}
	}
}