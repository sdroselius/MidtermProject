package com.skilldistillery.zootinder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletContextInitializer;

import com.skilldistillery.zootinder.data.SpeciesDAO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

@SpringBootApplication
public class ZooTinderApplication implements ServletContextInitializer {

	@Autowired
	private SpeciesDAO speciesDao;
	
	public static void main(String[] args) {
		SpringApplication.run(ZooTinderApplication.class, args);
	}

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		servletContext.setAttribute("speciesList", speciesDao.findAll());
	}
	
}
