package com.skilldistillery.bookbuddies.data;

import com.skilldistillery.bookbuddies.entities.User;

public interface UserDAO {
	User authenticateUser(String username, String password);
}
