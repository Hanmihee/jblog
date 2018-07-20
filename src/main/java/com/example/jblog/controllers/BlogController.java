package com.example.jblog.controllers; 
 
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.PathVariable; 
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod; 
 
import com.example.jblog.services.BlogService; 
import com.example.jblog.vo.BlogVo; 
 
 
@Controller 
@RequestMapping("/blog") 
public class BlogController { 
  @Autowired 
  private BlogService blogService; 
   
  @RequestMapping(value="/{userId}/admin/basicsetting" , method=RequestMethod.GET) 
  public String BasicSettingAction() { 
    return "blog/basicsetting"; 
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
} 