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

class PieTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Pie pie;

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
		pie = em.find(Pie.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		pie = null;
	}

	@Test
	void test_Pie_entity_mapping() {
		assertNotNull(pie);
		assertEquals("Apple Pie", pie.getName());
	}

	@Test
	void test_Pie_Recipe_OneToMany_mapping() {
		assertNotNull(pie);
		assertNotNull(pie.getRecipes());
		assertTrue(pie.getRecipes().size()> 0);
	}
	
	@Test
	void test_Pie_PieType_ManyToMany_mapping() {
		assertNotNull(pie);
		assertNotNull(pie.getPieTypes());
		assertTrue(pie.getPieTypes().size()> 0);
	}
	
}
