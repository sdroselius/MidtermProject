package com.skilldistillery.piefight.data;

import java.util.List;

import com.skilldistillery.piefight.entities.Pie;
import com.skilldistillery.piefight.entities.User;

public interface PieDAO {
	
	List<Pie> findAll();
	List<Pie> topNRandom(int howMany);
	Pie findById(int pieId);
	Pie create(Pie pie, User user);
	Pie update(int pieId, Pie updatingPie, User user);
	boolean deleteById(int pieId, User user);
	void addPieType(int pieId, int pieTypeId);
	void removePieType(int pieId, int pieTypeId);

}
