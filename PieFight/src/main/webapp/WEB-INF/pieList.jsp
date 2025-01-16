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
		<h1>What kind of pie do you like?</h1>

<%-- 		<table class="table table-striped table-hover">
			<thead class="table-primary">
				<tr>
					<th></th>
					<th>Name</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pie" items="${allPies}">
					<tr>
						<td><img alt="${pie.name } image" src="${pie.imageUrl}"
							class="pie-thumbnail-image"></td>
						<td><a href="showPie.do?pieId=${pie.id}"> ${pie.name } </a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table> --%>

		<div class="accordion" id="piesByCategory">
			<c:forEach var="pieEntry" items="${pieMapByCategory }">
				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseOne${pieEntry.key }"
							aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
							${ pieEntry.key }</button>
					</h2>
					<c:forEach var="pie" items="${pieEntry.value }">
						<div id="panelsStayOpen-collapseOne${pieEntry.key }"
							class="accordion-collapse collapse ">
							<div class="accordion-body">
								<img alt="${pie.name } image" src="${pie.imageUrl}"
							class="pie-thumbnail-image">
								<a href="showPie.do?pieId=${pie.id}"> <strong>${pie.name }</strong> </a>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>

	</main>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>