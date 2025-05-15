package com.skilldistillery.zootinder.data;

import java.util.List;

import com.skilldistillery.zootinder.ZooTinderApplication;
import com.skilldistillery.zootinder.entities.Zoo;

public interface ZooDAO {
	
	Zoo findById(int zooId);
	List<Zoo> findAll();

}
