<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
 <!-- BOOTSTRAP DEPENDENCIES -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>
    <!-- BOOTSTRAP DEPENDENCIES END-->
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
      
        <ul class="nav navbar-nav navbar-header" id="navHeader" title="Go to Home page">
      		<a href="https://java-arabic-community.herokuapp.com/AllQuestions">
            	<img class="nav-logo" alt="Logo not found!" src="${pageContext.request.contextPath}/resources/images/miniLogo.png"> 
            </a>
           	<p id="nav-header-p">Java Arabic Commumity<br>Q &amp; A website</p>
        </ul>
        <ul class="nav navbar-nav navbar-center">
          <li class="nav-center-li">
              <form:form action="Search" method="POST">
                  <div class="input-group ">
                      <spring:message code="label.search" var="LabelSearchQuestion" />
                      <span class="input-group-addon" style="background-color: #333; color: white;">
                          <spring:message code="label.searchQuestion" /> :
                      </span>
                      <input type="text" name="theSearchName" class="form-control">
                          <div class="input-group-btn">
                              <button class="btn btn-default" type="submit" style="margin-top: 0px;">
                                  <i class="glyphicon glyphicon-search"></i>
                              </button>
                          </div>
                  </div>
              </form:form>
          </li>
        </ul>
       <ul class="nav navbar-nav navbar-right">
         <li style="float:right;"><a href="SignIn"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        <li style="float:right;"><a href="SignUp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
       </ul>
  </div>
</nav>
</body>
</html>