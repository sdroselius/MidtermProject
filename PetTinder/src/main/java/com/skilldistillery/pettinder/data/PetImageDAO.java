package com.skilldistillery.pettinder.data;

import java.util.List;

import com.skilldistillery.pettinder.entities.PetImage;


public interface PetImageDAO {
	
	List<PetImage> findAll();

}
