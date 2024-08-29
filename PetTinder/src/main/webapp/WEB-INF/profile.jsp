<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Profile for ${user.username }</title>
<jsp:include page="styles.jsp" />

</head>
<body>
	<jsp:include page="navbar.jsp" />

	<main class="container">
		<h2>${user.firstName }${user.lastName }</h2>

		<div>
			<h3>Your Pets</h3>
			<div class="userPetList row row-cols-3 row-cols-md-2 g-4">
				<c:forEach var="pet" items="${user.pets}">
					<div class="col">
						<div class="card">
							<img alt="${pet.imageUrl} image" src="${pet.imageUrl}"
								class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">${pet.name }</h5>
								<div class="card-text">${pet.description }</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>

	<c:if test="${false }">
		<div class="myChart">
			<hr>
			<div style="width: 800px;">
				<canvas id="someChart"></canvas>
			</div>

			<script type="text/javascript">
				window.addEventListener('load', function() {
					(function() {

						const labels = [ 'Jan', 'Feb', 'Mar', 'Apr', 'May',
								'Jun', 'Jul' ];
						new Chart(document.getElementById('someChart'), {
							type : 'line',
							data : {
								labels : labels,
								datasets : [ {
									label : 'My First Dataset',
									data : [ 65, 59, 80, 81, 56, 55, 40 ],
									fill : false,
									borderColor : 'rgb(75, 192, 192)',
									tension : 0.1
								} ]
							}
						});
					})();
				});
			</script>
			<hr>
		</div>
	</c:if>


	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>