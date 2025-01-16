package com.skilldistillery.piefight.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.piefight.data.RecipeDAO;
import com.skilldistillery.piefight.entities.Recipe;
import com.skilldistillery.piefight.entities.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class RecipeController {

	@Autowired
	private RecipeDAO recipeDao;
	
	@GetMapping("showRecipe.do")
	public String showRecipe(Model model, @RequestParam("recipeId") Integer recipeId) {
		model.addAttribute("recipe", recipeDao.findById(recipeId));
		return "recipeDetails";
	}
	
	@GetMapping("addRecipe.do")
	public String goToAddRecipe(Model model, HttpSession session) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			return "recipeForm";
		}
		return "redirect:home.do";
	}
	
	@GetMapping("editRecipe.do")
	public String goToEditRecipe(Model model, HttpSession session, @RequestParam("recipeId") int recipeId) {
		User user = (User) session.getAttribute("loggedInUser");
		if (user != null) {
			Recipe recipeToEdit = recipeDao.findById(recipeId);
			model.addAttribute("recipe", recipeToEdit);
			return "recipeForm";
		}
		return "redirect:home.do";
	}
}
