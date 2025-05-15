<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zoo Tinder</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<main class="container">
		<c:choose>
			<c:when test="${empty user}">
				<h1>User not found.</h1>
			</c:when>
			<c:otherwise>
				<h1>User: ${user.username}</h1>
				<div>
					<img class="speciesMainImage" alt="${user.imageUrl}" src="${species.imageUrl}">
				</div>
				<h4>${user.firstName} ${user.lastName}</h4>
				<blockquote>${user.aboutMe}</blockquote>
			</c:otherwise>
		</c:choose>
	</main>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>