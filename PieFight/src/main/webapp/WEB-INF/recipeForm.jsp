<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pie Fight</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>

<main class="container">
<c:choose>
<c:when test="${empty recipe }">
	<h1>Add New Recipe</h1>
</c:when>
<c:otherwise>
	<h1>Edit Recipe ${recipe.name}</h1>
</c:otherwise>
</c:choose>
	
	<div class="recipeForm container">
<c:choose>
	<c:when test="${empty recipe }">
	<form method="POST" action="addRecipe.do">
	</c:when>
	<c:otherwise>
	<form method="POST" action="updateRecipe.do">
	</c:otherwise>
</c:choose>

		<div class="row">
			<label for="name" class="form_label col">Name</label>
			<input name="name" class="form-control col" type="text" value="${recipe.name }">
		</div>

		<div class="row">
			<label for="description" class="form_label col">Description</label>
			<textarea name="description" class="form-control col" cols="40" rows="3">${recipe.description }</textarea>
		</div>
		
		<div class="row">
			<label for="prepTimeMinutes" class="form_label col">Prep Time Minutes</label>
			<input name="prepTimeMinutes" class="form-control col" type="number" value="${recipe.prepTimeMinutes }">
		</div>

		<div class="row">
			<label for="cookTimeMinutes" class="form_label col">Cook Time Minutes</label>
			<input name="cookTimeMinutes" class="form-control col" type="number" value="${recipe.cookTimeMinutes }">
		</div>

		<div class="row">
			<label for="ingredients" class="form_label col">Ingredients</label>
			<textarea name="ingredients" class="form-control col" cols="40" rows="12">${recipe.ingredients }</textarea>
		</div>

		<div class="row">
			<label for="instructions" class="form_label col">Description</label>
			<textarea name="instructions" class="form-control col" cols="40" rows="12">${recipe.instructions }</textarea>
		</div>
		
		<c:choose>
			<c:when test="${empty recipe }">
				<button class="btn btn-primary">Add Recipe</button>
			</c:when>
			<c:otherwise>
				<button class="btn btn-primary">Update Recipe</button>
			</c:otherwise>
		</c:choose>

			</form>
	</div>
	
</main>
<jsp:include page="bootstrapFoot.jsp"/>
</body>
</html>