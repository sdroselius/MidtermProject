package com.skilldistillery.piefight.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.piefight.data.PieDAO;
import com.skilldistillery.piefight.data.RecipeDAO;
import com.skilldistillery.piefight.data.UserDAO;
import com.skilldistillery.piefight.entities.Pie;
import com.skilldistillery.piefight.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private PieDAO pieDao;
	
	@Autowired
	private RecipeDAO recipeDao;
	
	@RequestMapping( path={"/", "home.do"} )
	public String home(Model model) {
		List<Pie> pieList = pieDao.topNRandom(3);
		System.out.println(pieList);
		model.addAttribute("pieList", pieList);
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
			model.addAttribute("user", newUser);
			return "profile";
		}
	}
	
	@PostMapping("login.do")
	public String login(Model model, HttpSession session, User user) {
		user = userDao.authenticateUser(user.getUsername(), user.getPassword());
		if (user != null) {
			session.setAttribute("loggedInUser", user);
			model.addAttribute("user", user);
			model.addAttribute("recipeList", recipeDao.findByUserId(user.getId()));
			return "profile";
		}
		return "redirect:home.do";
	}
	
	@GetMapping("profile.do")
	public String myProfile(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			model.addAttribute("user", user);
			model.addAttribute("recipeList", recipeDao.findByUserId(user.getId()));
			return "profile";
		}
		return "redirect:home.do";
	}
	
	@GetMapping(path="profile.do", params="userId")
	public String viewProfile(Model model, @RequestParam("userId") Integer userId) {
		User user = userDao.findById(userId);
		if (user != null) {
			model.addAttribute("user", user);
			return "profile";
		}
		return "redirect:home.do";
	}
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "redirect:home.do";
	}
	
}
