package com.skilldistillery.piefight.data;

import org.springframework.stereotype.Service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Transactional
@Service
public class UserDaoImpl implements UserDAO {
	
	@PersistenceContext
	private EntityManager em;

}
