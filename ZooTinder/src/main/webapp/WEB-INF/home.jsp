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

<h1>Welcome to Zoo Tinder</h1>

<table class="table table-striped table-hover">
		<thead class="table-dark"> 
			<tr>
				<th></th>
				<th>Zoo</th>
			</tr>
		</thead>
		<tbody>
	
		<c:forEach var="zoo" items="${zoos}">
			<tr>
				<td><img class="zooImageThumbnail" src="${zoo.imageUrl}" alt="${zoo.name} logo image"></td>
				<td>
					<a href="showZoo.do?zooId=${zoo.id}"> ${zoo.name} </a>
				</td>
			</tr>
		</c:forEach>

		</tbody>
	</table>

</main>

<jsp:include page="bootstrapFoot.jsp"/>
</body>
</html>