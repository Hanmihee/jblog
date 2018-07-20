package com.example.jblog.controllers; 
 
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.jblog.services.BlogService;
import com.example.jblog.services.FileUploadService;
import com.example.jblog.vo.BlogVo; 
 
 
@Controller 
@RequestMapping("/blog") 
public class BlogController { 
  @Autowired 
  private BlogService blogService; 
  private FileUploadService fileUploadService;
   
  @RequestMapping(value="/{userId}/admin/basicsetting" , method=RequestMethod.GET) 
  public String basicSettingAction() { 
    return "blog/basicsetting"; 
  } 
  
  @RequestMapping(value="/{userId}/admin/boardwriteFormg", method=RequestMethod.GET)
  public String boardWriteAction() {
	  return "blog/boardWriteForm";
  }
   
  @RequestMapping(value="/{userId}",method=RequestMethod.GET) 
  public String myBlog(@PathVariable("userId") String userId,Model model) { 
     
     
    BlogVo blogvo = blogService.getBlogContent(userId); 
     
    if(blogvo != null) { 
      // 이름이 존재함 
      model.addAttribute("blog",blogvo); 
      return "blog/blogmain"; 
    }else { 
      // 이름이 존재하지 않음. 
      return "blog/blogNotFound"; 
    } 
  } 
  
  @RequestMapping(value="/{userId}/admin/updatesetting",method=RequestMethod.POST)
  public String updateSetting(@PathVariable("userId") String userId,@RequestParam("logo") MultipartFile logoImg ,@RequestParam("blogName") String blogName ,Model model) {
	  if(logoImg == null) {
		  return "redirect:/blog/basicsetting";
	  }
	  System.out.println("update : " +logoImg);
	  
	  // TODO
	  // 파일을 로컬에 저장. 및 이름 지정 ( 서비스가 할 일)
	  String saveFilename = blogService.updateSetting(logoImg);
	  
	 
	  Map<String , String> blogMap= new HashMap<String, String>();
	  blogMap.put("title", blogName);
	  blogMap.put("logo", saveFilename);
	  blogMap.put("id", userId);
	  
	  boolean result = blogService.updateBlogNameAndLogo(blogMap);
	  
	  if(result) {
		  return "blog/updatesuccess";
	  }else {
		  return "blog/updateFail";
	  }
  }
} 