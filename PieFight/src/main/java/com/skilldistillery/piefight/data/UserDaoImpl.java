package com.skilldistillery.piefight.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.piefight.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Transactional
@Service
public class UserDaoImpl implements UserDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public User authenticateUser(String username, String password) {
		String jpql = "SELECT u FROM User u WHERE u.username = :un AND u.password = :pw AND u.enabled = true";
		User authenticatedUser = null;
		
		try {
			authenticatedUser = em.createQuery(jpql, User.class)
					              .setParameter("un", username)
					              .setParameter("pw", password)
					              .getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid user: " + username);
			e.printStackTrace();
		}
		
		return authenticatedUser;
	}

}
