package com.skilldistillery.zootinder.data;

import java.util.List;

import com.skilldistillery.zootinder.entities.Species;

public interface SpeciesDAO {
	
	Species findById(int speciesId);
	List<Species> findAll();
	

}
