package com.example.jblog.repositories;

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
		return count;
	}

	public UserVo getUserById(String id) {
		UserVo uservo = sqlSession.selectOne("user.selectUserById",id);
		System.out.println("vo의 상태? : "+uservo);
		return uservo;
	}
}
