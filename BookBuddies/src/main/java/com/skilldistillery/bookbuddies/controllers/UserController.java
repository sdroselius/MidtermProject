package com.skilldistillery.bookbuddies.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Controller;

import com.skilldistillery.bookbuddies.data.UserDAO;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;

}
