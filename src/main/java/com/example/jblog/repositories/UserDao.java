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
		int count = sqlSession.insert("user.insert", vo);

		if (count == 1) {
			Map<String, Object> blogMap = new HashMap<String, Object>();
			blogMap.put("id", vo.getId());
			blogMap.put("blogName", vo.getName() + "의 블로그 입니다.");
			sqlSession.insert("user.insertBlog", blogMap);
			
			Map<String,Object> categoryMap = new HashMap<String,Object>();
			categoryMap.put("name", "미분류");
			categoryMap.put("id", vo.getId()); // 아이디를 통해서 user_no을 가져옴
			categoryMap.put("description", "미분류 카테고리");
			// 카테고리 추가
			sqlSession.insert("user.insertDefaultCategory",categoryMap);
		}
		return count;
	}

	public UserVo getUserById(String id) {
		UserVo uservo = sqlSession.selectOne("user.selectUserById", id);
		return uservo;
	}

	public UserVo getUserByIdAndPassword(String id, String password) {
		Map<String, String> userMap = new HashMap<String, String>();
		userMap.put("id", id);
		userMap.put("password", password);

		UserVo uservo = sqlSession.selectOne("user.selectUserByIdAndPassword", userMap);
		return uservo;
	}
}
