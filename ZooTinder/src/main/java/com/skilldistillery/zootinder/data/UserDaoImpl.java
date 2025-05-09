package com.skilldistillery.zootinder.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.zootinder.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserDaoImpl implements UserDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public User authenticateUser(String username, String password) {
		User user = null;
		try {
			String jpql = "SELECT u FROM User u WHERE u.username = :un AND u.password = :pw AND u.enabled = true";
			user = em.createQuery(jpql, User.class)
					 .setParameter("un", username)
					 .setParameter("pw", password)
					 .getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid login: " + username);
			e.printStackTrace();
		}
		return user;
	}

}
