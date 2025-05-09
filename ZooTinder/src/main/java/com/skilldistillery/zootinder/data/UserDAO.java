package com.skilldistillery.zootinder.data;

import com.skilldistillery.zootinder.entities.User;

public interface UserDAO {
	User authenticateUser(String username, String password);
}
