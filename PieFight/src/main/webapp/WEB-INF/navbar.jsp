<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<nav class="navbar navbar-expand-sm bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.do">
    	<img alt="PieFight logo image" src="images/logoImage.png" class="logo-image">
	</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <c:if test="${not empty sessionScope.loggedInUser }">
        <li class="nav-item">
          <a class="nav-link" href="profile.do">Profile</a>
        </li>
        </c:if>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Actions
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="pieList.do">List Pies</a></li>
      <c:if test="${not empty sessionScope.loggedInUser }">
            <li><a class="dropdown-item" href="addRecipe.do">Add a Recipe</a></li>
      </c:if>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
      </ul>
      
      <c:if test="${empty sessionScope.loggedInUser }">
      <form class="d-flex" role="login" action="login.do" method="POST">
        <input name="username" class="form-control me-2" type="text" placeholder="Username" aria-label="Username">
        <input name="password" class="form-control me-2" type="password" placeholder="Password" aria-label="Password">
        <button class="btn btn-outline-success" type="submit">Log In</button>
      </form>
      </c:if>
      <c:if test="${not empty sessionScope.loggedInUser }">
        <a href="logout.do" class="btn btn-outline-success">Log Out</a>
      </c:if>
    </div>
  </div>
</nav>