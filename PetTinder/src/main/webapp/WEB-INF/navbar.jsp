<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<nav class="navbar navbar-expand-sm bg-body-tertiary">
	<div class="container-fluid">
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarTogglerDemo01"
			aria-controls="navbarTogglerDemo01" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
			<a class="navbar-brand" href="home.do"> <img id="brandLogo"
				alt="Pet Tinder Logo" src="/images/petTinderLogo.jpeg">
			</a>
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/">Home</a></li>
				<c:if test="${not empty sessionScope.loggedInUser }">
					<li class="nav-item"><a class="nav-link" href="profile.do">My Profile</a></li>
				</c:if>
				<li class="nav-item"><a href="/aboutus.html" class="nav-link" aria-disabled="true">About Us</a></li>
			</ul>
			<c:choose>
				<c:when test="${empty sessionScope.loggedInUser }">
					<div class="container">
						<form class="d-flex" role="login" action="login.do" method="post">
							<div class="row">
								<input class="form-control me-2 col" name="username" type="text"
									placeholder="Username" aria-label="Username"> <input
									class="form-control me-2 col" name="password" type="password"
									placeholder="Password" aria-label="Password">
								<button class="btn btn-outline-success col-auto" type="submit">Log
									In</button>
							</div>
						</form>
					</div>
				</c:when>
				<c:otherwise>
					<form action="logout.do">
						<button class="btn btn-outline-danger">Log Out</button>
					</form>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>