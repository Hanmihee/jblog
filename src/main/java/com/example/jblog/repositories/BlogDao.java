package com.example.jblog.repositories;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.jblog.vo.BlogVo;

@Repository
public class BlogDao {
	@Autowired
	private SqlSession sqlSession;

	public BlogVo getBlogById(String userId) {
		return sqlSession.selectOne("blog.selectBlogById", userId);
	}

	public boolean saveBlogNameAndLogo(Map<String , String> blogMap) {
		int count = sqlSession.update("blog.updateBlogNameAndLogo",blogMap);
		return count == 1;
	}
}