package com.skilldistillery.piefight.data;

import com.skilldistillery.piefight.entities.User;

public interface UserDAO {

	User authenticateUser(String username, String password);
	User registerUser(User user);
	User findById(int userId);
	boolean disableUserById(int userId);
	boolean enableUserById(int userId);
	
}
