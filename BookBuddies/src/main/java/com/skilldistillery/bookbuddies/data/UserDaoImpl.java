package com.skilldistillery.bookbuddies.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.bookbuddies.entities.User;

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
		String jpql = "SELECT u FROM User u WHERE u.username = :un AND u.password = :pw AND u.enabled = true";
		User user = null;		
		try {
			user = em.createQuery(jpql, User.class)
					 .setParameter("un", username)
					 .setParameter("pw", password)
					 .getSingleResult();
		} catch (Exception e) {
//			e.printStackTrace();
			System.err.println("Invalid user: " + username);
		}		
		return user;
	}

}
