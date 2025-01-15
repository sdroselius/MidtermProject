<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>

<main class="container">
<c:choose>
	<c:when test="${empty user}">
	<h1>No Such User</h1>
	</c:when>
	<c:otherwise>
	<h1>${user.username } Profile</h1>
	<c:choose>
	<c:when test="${empty user.imageUrl}">
	<img alt="${user.username profile image}" src="images/defaultProfile.jpg" class="profileImage">
	</c:when>
	<c:otherwise>
	<img alt="${user.username profile image}" src="${user.imageUrl }" class="profileImage">
	</c:otherwise>
	</c:choose>
		
		
		
	</c:otherwise>
	
</c:choose>
	
</main>
<jsp:include page="bootstrapFoot.jsp"/>
</body>
</html>