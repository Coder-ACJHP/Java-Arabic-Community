<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>

<nav class="navbar navbar-inverse navbar-static-top">
  <div class="container-fluid">
      
        <div class="nav navbar-nav navbar-header" id="navHeader" title="Go to Home page">
      		<a href="https://java-arabic-community.herokuapp.com/AllQuestions">
            	<img class="nav-logo" alt="Logo not found!" src="${pageContext.request.contextPath}/resources/images/miniLogo.png"> 
            </a>
           	<p id="nav-header-p">Java Arabic Commumity<br>Q &amp; A website</p>
        </div>
        <ul class="nav navbar-nav navbar-center">
          <li class="nav-center-li">
              <form action="Search" method="POST">
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
              </form>
          </li>
        </ul>
       <ul class="nav navbar-nav navbar-right">
        <li style="float:right;"><a href="SignIn"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        <li style="float:right;"><a href="SignUp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
       </ul>
  </div>
</nav>