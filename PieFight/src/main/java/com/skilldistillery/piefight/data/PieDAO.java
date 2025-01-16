package com.skilldistillery.piefight.data;

import java.util.List;
import java.util.Map;

import com.skilldistillery.piefight.entities.Pie;
import com.skilldistillery.piefight.entities.User;

public interface PieDAO {
	
	List<Pie> findAll();
	List<Pie> findByPieType(int pieTypeId);
	List<Pie> groupByPieType();
	List<Pie> topNRandom(int howMany);
	Pie findById(int pieId);
	Pie create(Pie pie, User user);
	Pie update(int pieId, Pie updatingPie, User user);
	boolean deleteById(int pieId, User user);
	boolean addPieType(int pieId, int pieTypeId);
	boolean removePieType(int pieId, int pieTypeId);
	Map<String,List<Pie>> mapByPieType();

}
