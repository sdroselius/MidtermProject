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

class PieTypeTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private PieType pieType;

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
		pieType = em.find(PieType.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		pieType = null;
	}

	@Test
	void test_PieType_entity_mapping() {
		assertNotNull(pieType);
		assertEquals("Fruit", pieType.getName());
	}

	@Test
	void test_PieType_Pie_ManyToMany_mapping() {
		assertNotNull(pieType);
		assertNotNull(pieType.getPies());
		assertTrue(pieType.getPies().size() > 0);
	}
	
}
