package com.skilldistillery.pettinder.data;

import org.springframework.stereotype.Service;

import com.skilldistillery.pettinder.entities.User;

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
		String jpql = "SELECT u FROM User u WHERE u.username = :un AND u.password = :pw AND enabled = true";
		try {
			user = em.createQuery(jpql, User.class)
					 .setParameter("un", username)
					 .setParameter("pw", password)
					 .getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid user");
		}
		return user;
	}

	@Override
	public User findById(int userId) {
		return em.find(User.class, userId);
	}
}
