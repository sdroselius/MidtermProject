package com.skilldistillery.piefight.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.piefight.entities.Pie;
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
		String jpql = "SELECT r FROM Recipe r WHERE r.enabled = true";
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
			recipe.setEnabled(true);
			em.persist(recipe);
			return recipe;
		}
		return null;
	}

	@Override
	public Recipe update(int recipeId, Recipe updatingRecipe, User user) {
		Recipe managedRecipe = em.find(Recipe.class, recipeId);
		if (managedRecipe != null) {
			if (managedRecipe.getUser().getId() == user.getId()
					|| user.getRole().equals("ADMIN")) {
				managedRecipe.setCookTimeMinutes(updatingRecipe.getCookTimeMinutes());
				managedRecipe.setPrepTimeMinutes(updatingRecipe.getPrepTimeMinutes());
				managedRecipe.setDescription(updatingRecipe.getDescription());
				managedRecipe.setIngredients(updatingRecipe.getIngredients());
				managedRecipe.setInstructions(updatingRecipe.getInstructions());
				managedRecipe.setName(updatingRecipe.getName());
				em.flush();
				return managedRecipe;
			}
		}
		return null;
	}

	@Override
	public boolean deleteById(int recipeId, User user) {
		Recipe managedRecipe = em.find(Recipe.class, recipeId);
		if (managedRecipe != null) {
			if (managedRecipe.getUser().getId() == user.getId()
					|| user.getRole().equals("ADMIN")) {
				managedRecipe.setEnabled(false);
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean enableRecipe(int recipeId, User user) {
		Recipe managedRecipe = em.find(Recipe.class, recipeId);
		if (managedRecipe != null) {
			if (managedRecipe.getUser().getId() == user.getId()
					|| user.getRole().equals("ADMIN")) {
				managedRecipe.setEnabled(true);
				return true;
			}
		}
		return false;
	}

	@Override
	public List<Recipe> findByPieId(int pieId) {
		String jpql = "SELECT r FROM Recipe r WHERE r.pie.id = :pid";
		return em.createQuery(jpql, Recipe.class)
				 .setParameter("pid", pieId)
				 .getResultList();
	}

}
