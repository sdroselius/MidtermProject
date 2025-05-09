package com.skilldistillery.zootinder.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.zootinder.data.UserDAO;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
}
