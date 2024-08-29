<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pet Tinder</title>
<jsp:include page="styles.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<main class="container">
		<h1>Welcome to Pet Tinder</h1>
		<hr>
		<div id="carouselExampleInterval" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<c:forEach var="petImage" items="${petImages}" varStatus="i">
					<c:choose>
						<c:when test="${i.index == 0 }">
							<div class="carousel-item active" data-bs-interval="3000">
						</c:when>
						<c:otherwise>
							<div class="carousel-item" data-bs-interval="3000">
						</c:otherwise>
					</c:choose>
					<img src="${petImage.imageUrl }" class="d-block w-100"
						alt="Pet Image">
			</div>
			</c:forEach>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleInterval" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
		</div>

	</main>


	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>