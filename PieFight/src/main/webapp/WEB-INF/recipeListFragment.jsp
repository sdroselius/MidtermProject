<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="recipe-list">
	<c:choose>
	<c:when test="${empty recipeList }">
	<h3>No recipes found.</h3>
	</c:when>
	<c:otherwise>
		<table class="table table-striped table-hover">
		<thead class="table-primary">
			<tr>
				<th></th>
				<th>Name</th>
				<th>Created By</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="recipe" items="${recipeList}">
				<tr>
					<td><img alt="${recipe.name } image" src="${recipe.imageUrl}" class="pie-thumbnail-image"> </td>
					<td><a href="showRecipe.do?recipeId=${recipe.id}"> ${recipe.name }
					</a>
					<c:if test="${recipe.user.id == loggedInUser.id }">
					<a href="editRecipe.do?recipeId=${recipe.id}" class="btn btn-outline-success">Edit</a>
					<a href="deleteRecipe.do?recipeId=${recipe.id}" class="btn btn-outline-danger">Delete</a>
					</c:if>
					</td>
					<td>${recipe.user.username }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:otherwise>
	</c:choose>
</div>