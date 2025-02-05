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

class RecipeRatingTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private RecipeRating rating;

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
		rating = em.find(RecipeRating.class, new RecipeRatingId(1,1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		rating = null;
	}

	@Test
	void test_RecipeRating_entity_mapping() {
		assertNotNull(rating);
		assertEquals(5, rating.getRating());
	}

	@Test
	void test_RecipeRating_Recipe_ManyToOne_mapping() {
		assertNotNull(rating);
		assertNotNull(rating.getRecipe());
		assertEquals(1, rating.getRecipe().getId());
	}
	
}
