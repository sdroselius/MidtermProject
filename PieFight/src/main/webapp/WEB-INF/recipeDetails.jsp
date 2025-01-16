<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pie Fight</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<main class="container">
		<c:choose>
			<c:when test="${empty recipe }">
				<h1>Recipe not found</h1>
			</c:when>
			<c:otherwise>

				<img alt="${recipe.name } image" src="${recipe.imageUrl }"
					class="pie-image">
				<h1>${recipe.name}</h1>
				<p>${recipe.description }</p>
				<div style="clear: left;"></div>
				<h3>Prep time: ${recipe.prepTimeMinutes } minutes</h3>
				<h3>Cook time: ${recipe.cookTimeMinutes } minutes</h3>

				<div class="accordion" id="recipeSections">
					<div class="accordion-item">
						<h2 class="accordion-header">
							<button class="accordion-button" type="button"
								data-bs-toggle="collapse" data-bs-target="#panelIngredients"
								aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
								Ingredients</button>
						</h2>
						<div id="panelIngredients" class="accordion-collapse collapse ">
							<div class="accordion-body">
							<pre>
${recipe.ingredients }
							</pre>
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header">
							<button class="accordion-button" type="button"
								data-bs-toggle="collapse" data-bs-target="#panelInstructions"
								aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
								Instructions</button>
						</h2>
						<div id="panelInstructions" class="accordion-collapse collapse ">
							<div class="accordion-body">
							<pre>
${recipe.instructions }
							</pre>
							</div>
						</div>
					</div>
				</div>


				<footer>Added by ${recipe.user.username },
					${recipe.createDate.getMonth()} ${pie.createDate.getYear()}</footer>

			</c:otherwise>
		</c:choose>


	</main>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>