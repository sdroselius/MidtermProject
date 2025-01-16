<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pie Recipe - ${pie.name}</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<main class="container">
		<c:choose>
			<c:when test="${empty pie }">
				<h1>Pie not found.</h1>
			</c:when>
			<c:otherwise>
				<img alt="${pie.name } image" src="${pie.imageUrl }"
					class="pie-image">
				<h1>${pie.name }</h1>
				<p>${pie.description }</p>

				<footer>Added by ${pie.addedBy.username },
					${pie.createDate.getMonth()} ${pie.createDate.getYear()}</footer>

				<div>
					<jsp:include page="recipeListFragment.jsp" />
				</div>
			</c:otherwise>
		</c:choose>


	</main>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>