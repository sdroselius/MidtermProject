package com.skilldistillery.zootinder.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.zootinder.data.SpeciesDAO;
import com.skilldistillery.zootinder.data.UserDAO;
import com.skilldistillery.zootinder.entities.Species;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class SpeciesController {

	@Autowired
	private SpeciesDAO speciesDao;

	@RequestMapping("searchBySpecies.do")
	public String searchBySpecies(@RequestParam("speciesId") int speciesId, Model model) {
		Species species = speciesDao.findById(speciesId);
		String viewName = "";
		if (species != null) {
			model.addAttribute("species", species);
			viewName = "speciesDetail";
		} else {
			viewName = "home";
		}
		return viewName;
	}

}
