package com.example.jblog.repositories;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.UserVo;

@Repository
public class UserDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertUser(UserVo vo) {
		int count = sqlSession.insert("user.insert",vo);
		sqlSession.insert("user.insertBlog",vo);
		return count;
	}

	public UserVo getUserById(String id) {
		UserVo uservo = sqlSession.selectOne("user.selectUserById",id);
		System.out.println("vo의 상태? : "+uservo);
		return uservo;
	}

	public UserVo getUserByIdAndPassword(String id, String password) {
		Map<String,String> userMap = new HashMap<String, String>();
		userMap.put("id", id);
		userMap.put("password", password);
		
		UserVo uservo = sqlSession.selectOne("user.selectUserByIdAndPassword",userMap);
		
		return uservo;
	}

	/*public int insertBlogInfo(UserVo vo) {
		// 2. 여기다가 블로그 vo 정보를 담아서 insert에 넘기기
		// 3. blog.xml 코드 작성
		BlogVo blogVo = new BlogVo();
		blogVo.setUserNo(vo.getNo());
		blogVo.setTitle(vo.getName());
		int count = sqlSession.insert("blog.insertInitBloginfo",blogVo);
		return count;
	}*/
}
