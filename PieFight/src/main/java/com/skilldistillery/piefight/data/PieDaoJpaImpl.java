package com.skilldistillery.piefight.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.piefight.entities.Pie;
import com.skilldistillery.piefight.entities.PieType;
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
		String jpql = "SELECT pie FROM Pie pie WHERE pie.enabled = true ORDER BY pie.name";
		return em.createQuery(jpql, Pie.class).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Pie> topNRandom(int howMany) {
		String sql = "SELECT * FROM pie WHERE pie.enabled = true ORDER BY RAND()";
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
		pie.setEnabled(true);
		em.persist(pie);
		return pie;
	}

	@Override
	public Pie update(int pieId, Pie updatingPie, User user) {
		Pie managedPie = em.find(Pie.class, pieId);
		if (managedPie != null) {
			if (managedPie.getAddedBy().getId() == user.getId()
					|| user.getRole().equals("ADMIN")) {
				managedPie.setDescription(updatingPie.getDescription());
				managedPie.setName(updatingPie.getName());
				managedPie.setImageUrl(updatingPie.getImageUrl());
			}
		}
		return null;
	}

	@Override
	public boolean deleteById(int pieId, User user) {
		Pie managedPie = em.find(Pie.class, pieId);
		if (managedPie != null) {
			if (managedPie.getAddedBy().getId() == user.getId()
					|| user.getRole().equals("ADMIN")) {
				managedPie.setEnabled(false);
				return true;
			}
		}
		return false;
	}

	@Override
	public void addPieType(int pieId, int pieTypeId) {
		Pie pie = em.find(Pie.class, pieId);
		PieType pieType = em.find(PieType.class, pieTypeId);
		if (pie != null && pieType != null) {
			//FIXME
		}
		
	}

	@Override
	public void removePieType(int pieId, int pieTypeId) {
		// TODO Auto-generated method stub
		
	}

}
