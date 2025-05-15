package com.skilldistillery.zootinder.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.zootinder.data.ZooDAO;
import com.skilldistillery.zootinder.entities.Zoo;

@Controller
public class ZooController {

	@Autowired
	private ZooDAO zooDao;
	
	@GetMapping("showZoo.do")
	public String showZoo(Model model,@RequestParam("zooId") int zooId) {
		String viewName = "zooDetail";
		Zoo zoo = zooDao.findById(zooId);
		model.addAttribute("zoo", zooDao.findById(zooId));
		return viewName;
	}
	
}
