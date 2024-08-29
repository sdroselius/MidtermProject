package com.skilldistillery.pettinder.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.pettinder.entities.PetImage;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class PetImageDaoImpl implements PetImageDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<PetImage> findAll() {
		String jpql  = "SELECT img FROM PetImage img";
		return em.createQuery(jpql, PetImage.class).getResultList();
	}

}
