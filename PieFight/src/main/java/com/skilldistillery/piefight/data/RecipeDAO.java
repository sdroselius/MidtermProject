package com.skilldistillery.piefight.data;

import java.util.List;

import com.skilldistillery.piefight.entities.Recipe;
import com.skilldistillery.piefight.entities.User;

public interface RecipeDAO {
	
	List<Recipe> findAll();
	List<Recipe> findByUserId(int userId);
	List<Recipe> findByPieId(int pieId);
	Recipe findById(int recipeId);
	Recipe create(Recipe recipe, User user);
	Recipe update(int recipeId, Recipe updatingRecipe, User user);
	boolean deleteById(int recipeId, User user);
	boolean enableRecipe(int recipeId, User user);

}
