package com.skilldistillery.pettinder.controllers;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.pettinder.data.PetImageDAO;
import com.skilldistillery.pettinder.data.UserDAO;
import com.skilldistillery.pettinder.entities.PetImage;
import com.skilldistillery.pettinder.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private PetImageDAO petImageDao;
	
	@RequestMapping(path = {"/", "home.do"} )
	public String home(Model model) {
		List<PetImage> images = petImageDao.findAll();
		model.addAttribute("petImages", images);
		return "home";
	}
	
	@RequestMapping(path="login.do", method = RequestMethod.POST)
	public String login(User user, HttpSession session) {
		user = userDao.authenticateUser(user.getUsername(), user.getPassword());
		if (user == null) {
			return "redirect:home.do";
		}
		else {
			session.setAttribute("loggedInUser", user);
			session.setAttribute("loginTime", LocalDateTime.now());
			return "redirect:profile.do";
		}
	}
	
	@RequestMapping(path="logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home.do";
	}
	
	@RequestMapping(path="profile.do")
	public String profile(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:home.do";			
		}
		else {
			user = userDao.findById(user.getId());
			model.addAttribute("user", user);
			return "profile";
		}
	}

}
