package com.skilldistillery.piefight.entities;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class RecipeTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recipe recipe;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAPieFight");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		recipe = em.find(Recipe.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipe = null;
	}

	@Test
	void test_Recipe_entity_mapping() {
		assertNotNull(recipe);
		assertEquals("Alton Brown's Apple Pie", recipe.getName());
	}

	@Test
	void test_Recipe_User_ManyToOne_mapping() {
		assertNotNull(recipe);
		assertNotNull(recipe.getUser());
		assertEquals(2, recipe.getUser().getId());
	}
	
	@Test
	void test_Recipe_Pie_ManyToOne_mapping() {
		assertNotNull(recipe);
		assertNotNull(recipe.getPie());
		assertEquals(1, recipe.getPie().getId());
	}
	
	@Test
	void test_Recipe_RecipeComment_OneToMany_mapping() {
		assertNotNull(recipe);
		assertNotNull(recipe.getRecipeComments());
		assertTrue(recipe.getRecipeComments().size() > 0);
	}
	
}
