package com.example.jblog.services; 
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.jblog.repositories.BlogDao;
import com.example.jblog.vo.BlogVo; 
 
@Service 
public class BlogService { 
 
  @Autowired 
  private BlogDao blogdao; 
   
  public BlogVo getBlogContent(String userId) { 
    return blogdao.getBlogById(userId); 
  } 
} 