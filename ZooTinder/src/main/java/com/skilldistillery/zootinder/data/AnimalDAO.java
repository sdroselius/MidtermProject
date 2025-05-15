package com.skilldistillery.zootinder.data;

import java.util.List;

import com.skilldistillery.zootinder.entities.Animal;

public interface AnimalDAO {
	
	Animal findById(int animalId);
	List<Animal> findAll();
	List<Animal> findBySpeciesId();
	List<Animal> findByZooId();

}
