package com.skilldistillery.piefight.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.piefight.entities.Recipe;
import com.skilldistillery.piefight.entities.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Transactional
@Service
public class RecipeDaoJpaImpl implements RecipeDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<Recipe> findAll() {
		String jpql = "SELECT r FROM Recipe r";
		return em.createQuery(jpql, Recipe.class).getResultList();
	}

	@Override
	public List<Recipe> findByUserId(int userId) {
		String jpql = "SELECT r FROM Recipe r WHERE r.user.id = :uid";
		return em.createQuery(jpql, Recipe.class)
				 .setParameter("uid", userId)
				 .getResultList();
	}

	@Override
	public Recipe findById(int recipeId) {
		return em.find(Recipe.class, recipeId);
	}

	@Override
	public Recipe create(Recipe recipe, User user) {
		User creatingUser = em.find(User.class, user.getId());
		if (creatingUser != null) {
			recipe.setUser(creatingUser);
			em.persist(creatingUser);
			return recipe;
		}
		return null;
	}

	@Override
	public Recipe update(int recipeId, Recipe updatingRecipe, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteById(int recipeId, int userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
