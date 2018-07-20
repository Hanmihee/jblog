package com.example.jblog.repositories;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
		return uservo;
	}

	public UserVo getUserByIdAndPassword(String id, String password) {
		Map<String,String> userMap = new HashMap<String, String>();
		userMap.put("id", id);
		userMap.put("password", password);
		
		UserVo uservo = sqlSession.selectOne("user.selectUserByIdAndPassword",userMap);
		
		return uservo;
	}
}
