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
			<c:when test="${empty species}">
				<h1>Species not found.</h1>
			</c:when>
			<c:otherwise>
				<h1>Species Details for ${species.commonName}</h1>
				<div>
					<img class="speciesMainImage" alt="${species.imageUrl}" src="${species.imageUrl}">
				</div>
				<h4>${species.genus} ${species.species}</h4>
				<blockquote>${species.description}</blockquote>
				
				<hr>
		<table class="table table-striped table-hover">
		<thead class="table-dark"> 
			<tr>
				<th>Species</th>
				<th>Name</th>
				<th>Zoo</th>
			</tr>
		</thead>
		<tbody>
	
		<c:forEach var="animal" items="${species.animals}">
			<tr>
				<td><img class="zooImageThumbnail" src="${animal.species.imageUrl}" alt="${animal.species.commonName} image"></td>
				<td>
					<a href="showAnimal.do?animalId=${animal.id}"> ${animal.name} </a>
				</td>
				<td>${animal.zoo.name }</td>
			</tr>
		</c:forEach>

		</tbody>
	</table>
				
				
				
			</c:otherwise>
		</c:choose>
	</main>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>