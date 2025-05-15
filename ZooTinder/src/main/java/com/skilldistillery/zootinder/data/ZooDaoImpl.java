package com.skilldistillery.zootinder.data;

import java.util.List;
import java.util.logging.ErrorManager;

import org.springframework.stereotype.Service;

import com.skilldistillery.zootinder.entities.Zoo;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class ZooDaoImpl implements ZooDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Zoo findById(int zooId) {
		return em.find(Zoo.class, zooId);
	}

	@Override
	public List<Zoo> findAll() {
		String jpql = "SELECT z FROM Zoo z ORDER BY z.name";
		return em.createQuery(jpql, Zoo.class).getResultList();
	}

}
