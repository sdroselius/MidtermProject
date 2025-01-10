package com.skilldistillery.piefight.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.piefight.data.UserDAO;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping( path={"/", "home.do"} )
	public String home(Model model) {
		model.addAttribute("SMOKETEST", userDao.authenticateUser("admin", "test")); // DELETE LATER
		return "home";
	}

}
