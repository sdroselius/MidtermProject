package com.skilldistillery.zootinder.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.zootinder.data.SpeciesDAO;
import com.skilldistillery.zootinder.data.UserDAO;
import com.skilldistillery.zootinder.data.ZooDAO;
import com.skilldistillery.zootinder.entities.Species;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private ZooDAO zooDao;

	@RequestMapping(path = { "/", "home.do" })
	public String home(Model model, HttpServletRequest req) {
		model.addAttribute("zoos", zooDao.findAll());
		return "home";
	}

}
