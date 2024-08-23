package com.skilldistillery.pettinder.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.pettinder.data.UserDAO;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;

}
