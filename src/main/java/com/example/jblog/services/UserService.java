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
}
