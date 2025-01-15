package com.skilldistillery.piefight.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Pie {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	@Column(name = "image_url")
	private String imageUrl;
	private String description;
	private boolean enabled;

	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate;

	@Column(name = "last_update")
	@UpdateTimestamp
	private LocalDateTime lastUpdate;

	@OneToMany(mappedBy = "pie")
	private List<Recipe> recipes;
	
	@ManyToMany(mappedBy = "pies")
	private List<PieType> pieTypes;
	
	@ManyToOne
	@JoinColumn(name = "added_by_id")
	private User addedBy;

	public Pie() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public List<Recipe> getRecipes() {
		return recipes;
	}

	public void setRecipes(List<Recipe> recipes) {
		this.recipes = recipes;
	}

	public List<PieType> getPieTypes() {
		return pieTypes;
	}

	public void setPieTypes(List<PieType> pieTypes) {
		this.pieTypes = pieTypes;
	}
	
	public boolean addPieType(PieType pieType) {
		if (pieTypes == null) { pieTypes = new ArrayList<>(); }
		if (! pieTypes.contains(pieType)) {
			pieTypes.add(pieType);
			pieType.addPie(this);
			return true;
		}
		return false;
	}

	public boolean removePieType(PieType pieType) {
		if (pieTypes != null && pieTypes.contains(pieType)) {
			pieTypes.remove(pieType);
			pieType.removePie(this);
			return true;
		}
		return false;
	}
	
	public User getAddedBy() {
		return addedBy;
	}

	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Pie other = (Pie) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Pie [id=").append(id).append(", name=").append(name).append(", imageUrl=").append(imageUrl)
				.append(", description=").append(description).append("]");
		return builder.toString();
	}

}
