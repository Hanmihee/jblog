package com.example.jblog.repositories;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.CategoryVo;

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

	public boolean insertCategory(Map<String, Object> categoryMap) {
		int count = sqlSession.insert("category.insertCategory",categoryMap);
		return count == 1;
	}

	public boolean deleteCategory(Map<String, Object> categoryMap) {
		int count = sqlSession.delete("category.deleteCategory",categoryMap);
		return count == 1;
	}

	public List<CategoryVo> selectCategory(String userId) {
		return sqlSession.selectList("category.selectCategory", userId);
	}

	public boolean insertPost(Map<String, Object> postMap) {
		int count = sqlSession.insert("post.insertPost",postMap);
		return count == 1;
	}
}