package com.skilldistillery.pettinder.data;

import com.skilldistillery.pettinder.entities.User;

public interface UserDAO {
	User authenticateUser(String username, String password);
	User findById(int userId);
}
