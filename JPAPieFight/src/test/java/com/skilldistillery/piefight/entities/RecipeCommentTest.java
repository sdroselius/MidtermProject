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

class RecipeCommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private RecipeComment comment;

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
		comment = em.find(RecipeComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}

	@Test
	void test_RecipeComment_entity_mapping() {
		assertNotNull(comment);
		assertEquals("Warning: pie birds don't work", comment.getContent());
	}

	@Test
	void test_RecipeComment_Recipe_mapping() {
		assertNotNull(comment);
		assertNotNull(comment.getRecipe());
		assertEquals(1, comment.getRecipe().getId());
	}
	
	@Test
	void test_RecipeComment_User_mapping() {
		assertNotNull(comment);
		assertNotNull(comment.getUser());
		assertEquals(2, comment.getUser().getId());
	}
	
	@Test
	void test_RecipeComment_RecipeComment_ManyToOne_mapping() {
		comment = em.find(RecipeComment.class, 2);
		assertNotNull(comment);
		assertNotNull(comment.getParentComment());
		assertEquals(1, comment.getParentComment().getId());
	}
	
	@Test
	void test_RecipeComment_RecipeComment_OneToMany_mapping() {
		assertNotNull(comment);
		assertNotNull(comment.getRecipeCommentReplies());
		assertTrue(comment.getRecipeCommentReplies().size()>0);
	}
	
}
