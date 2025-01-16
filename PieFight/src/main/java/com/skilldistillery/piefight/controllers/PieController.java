package com.skilldistillery.piefight.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.piefight.data.PieDAO;
import com.skilldistillery.piefight.data.RecipeDAO;
import com.skilldistillery.piefight.entities.Pie;

import jakarta.servlet.http.HttpSession;

@Controller
public class PieController {

	@Autowired
	private PieDAO pieDao;
	
	@Autowired
	private RecipeDAO recipeDao;
	
	@GetMapping("pieList.do")
	public String getPies(Model model) {
		model.addAttribute("allPies", pieDao.findAll());
		
		model.addAttribute("pieListByCategory", pieDao.groupByPieType());
		model.addAttribute("pieMapByCategory", pieDao.mapByPieType());
		return "pieList";
	}
	
	@GetMapping("showPie.do")
	public String showPie(Model model, @RequestParam("pieId") Integer pieId) {
		Pie pie = pieDao.findById(pieId);
		if (pie == null) {
			return "redirect:pieList.do";
		}
		model.addAttribute("pie", pie);
		model.addAttribute("recipeList", recipeDao.findByPieId(pieId));
		return "pieDetails";
	}
	
	@GetMapping("addPie.do")
	public String goToAddPie(Model model, HttpSession session) {
		return "redirect:home.do";
	}
	
	@PostMapping("addPie.do")
	public String addPie(Model model, HttpSession session) {
		return "redirect:home.do";
	}
	
	
}
