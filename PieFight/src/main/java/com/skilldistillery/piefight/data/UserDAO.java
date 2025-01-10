package com.skilldistillery.piefight.data;

import com.skilldistillery.piefight.entities.User;

public interface UserDAO {

	User authenticateUser(String username, String password);
	
}
