package com.skilldistillery.piefight.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.piefight.data.UserDAO;
import com.skilldistillery.piefight.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping( path={"/", "home.do"} )
	public String home(Model model) {
		return "home";
	}

	@GetMapping("register.do")
	public String goToRegister(Model model) {
		return "register";
	}
	
	@PostMapping("register.do")
	public String register(Model model, HttpSession session, User newUser) {
		newUser = userDao.registerUser(newUser);
		if (newUser == null) {
			return "register";
		}
		else {
			session.setAttribute("loggedInUser", newUser);
			return "profile";
		}
	}
	
	@PostMapping("login.do")
	public String login(Model model, HttpSession session, User user) {
		return "profile";
	}
	
}
