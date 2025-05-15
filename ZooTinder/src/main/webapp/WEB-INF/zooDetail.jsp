<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zoo Tinder</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navbar.jsp"/>

<main class="container">

<c:choose>
<c:when test="${empty zoo }"><h1>Zoo not found.</h1></c:when>
<c:otherwise>
	<div>
	<img class="zooImage" src="${zoo.imageUrl}" alt="${zoo.name} logo image">
	</div>
	
	<h1>${zoo.name}</h1>
	<blockquote>${zoo.description}</blockquote>
	<hr>
	<div>
	Zookeeper: ${zoo.zookeeper.firstName }  ${zoo.zookeeper.lastName } <br>
	<img class="zooKeeperImage" src="${zoo.zookeeper.imageUrl}" alt="Zookeeper ${zoo.zookeeper.firstName} image">
	
	</div>
	<hr>
		<table class="table table-striped table-hover">
		<thead class="table-dark"> 
			<tr>
				<th></th>
				<th>Species</th>
				<th>Name</th>
			</tr>
		</thead>
		<tbody>
	
		<c:forEach var="animal" items="${zoo.animals}">
			<tr>
				<td><img class="zooImageThumbnail" src="${animal.species.imageUrl}" alt="${animal.species.commonName} image"></td>
				<td>${animal.species.genus } ${animal.species.species }</td>
				<td>
					<a href="showAnimal.do?animalId=${animal.id}"> ${animal.name} </a>
				</td>
			</tr>
		</c:forEach>
	
</c:otherwise>
</c:choose>



</main>

<jsp:include page="bootstrapFoot.jsp"/>
</body>
</html>