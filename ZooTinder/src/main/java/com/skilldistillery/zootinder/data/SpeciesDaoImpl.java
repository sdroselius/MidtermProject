package com.skilldistillery.zootinder.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.zootinder.entities.Species;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class SpeciesDaoImpl implements SpeciesDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Species findById(int speciesId) {
		return em.find(Species.class, speciesId);
	}

	@Override
	public List<Species> findAll() {
		String jpql = "SELECT sp FROM Species sp ORDER BY commonName";
		return em.createQuery(jpql, Species.class).getResultList();
	}

}
