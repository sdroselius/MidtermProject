package com.skilldistillery.piefight.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.piefight.data.UserDAO;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;

}
