package com.skilldistillery.piefight.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.piefight.entities.Pie;
import com.skilldistillery.piefight.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Transactional
@Service
public class PieDaoJpaImpl implements PieDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<Pie> findAll() {
		String jpql = "SELECT pie FROM Pie pie ORDER BY pie.name";
		return em.createQuery(jpql, Pie.class).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Pie> topNRandom(int howMany) {
		String sql = "SELECT * FROM pie ORDER BY RAND()";
		return em.createNativeQuery(sql, Pie.class)
		         .setMaxResults(howMany)
		         .getResultList();	
	}
	
	@Override
	public Pie findById(int pieId) {
		return em.find(Pie.class, pieId);
	}

	@Override
	public Pie create(Pie pie, User user) {
		pie.setAddedBy(user);
		em.persist(pie);
		return null;
	}

	@Override
	public Pie update(int pieId, Pie updatingPie, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteById(int pieId, User user) {
		// TODO Auto-generated method stub
		return false;
	}

}
