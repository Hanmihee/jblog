package com.example.jblog.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.jblog.repositories.UserDao;
import com.example.jblog.vo.UserVo;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;

	public boolean join(UserVo vo) {
		return userDao.insertUser(vo) == 1;
	}

	public boolean exist(String id) {
		boolean exist;
		UserVo vo = userDao.getUserById(id);
		
		if(vo == null) {
			exist = false;
			System.out.println("아이디 사용가능 : "+exist);
		} else {
			exist = true;
			System.out.println("아이디 중복 : "+exist);
		}
		return exist;
	}

	public UserVo getUserByIdAndPassword(String id, String password) {
		return userDao.getUserByIdAndPassword(id,password);
	}
}
