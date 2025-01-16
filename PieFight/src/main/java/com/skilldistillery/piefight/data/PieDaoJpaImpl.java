package com.skilldistillery.piefight.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public boolean addPieType(int pieId, int pieTypeId) {
		Pie pie = em.find(Pie.class, pieId);
		PieType pieType = em.find(PieType.class, pieTypeId);
		if (pie != null && pieType != null) {
			return pie.addPieType(pieType);
		}
		return false;
	}

	@Override
	public boolean removePieType(int pieId, int pieTypeId) {
		Pie pie = em.find(Pie.class, pieId);
		PieType pieType = em.find(PieType.class, pieTypeId);
		if (pie != null && pieType != null) {
			return pie.removePieType(pieType);
		}
		return false;
	}

	@Override
	public List<Pie> findByPieType(int pieTypeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Pie> groupByPieType() {
		String jpql = "SELECT pie FROM Pie pie JOIN pie.pieTypes pieTypes WHERE pie.enabled = true ORDER BY pieTypes.name, pie.name";
		List<Pie> pies = em.createQuery(jpql, Pie.class).getResultList();
		return pies;
	}

	@Override
	public Map<String,List<Pie>> mapByPieType() {
		String jpql = "SELECT pieTypes.name, pie FROM Pie pie JOIN pie.pieTypes pieTypes WHERE pie.enabled = true ORDER BY pieTypes.name, pie.name";
		List<Object[]> result = em.createQuery(jpql, Object[].class).getResultList();
		System.out.println(result);
		Map<String,List<Pie>> pieMap = new HashMap<>();
		for (Object[] objects : result) {
			String typeName = (String) objects[0];
			if (! pieMap.containsKey(typeName)) {
				pieMap.put(typeName, new ArrayList<>());
			}
			pieMap.get(typeName).add((Pie)objects[1]);
		}
		return pieMap;
	}
	
}
