<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<!-- Initialize new variables with c tag -->
<c:set var="myUserId" value="loggedInUserId" />
<c:set var="myPicture" value="loggedInUserPicture" />
<c:set var="myNickname" value="loggedInUserNickname" />
<c:set var="myRegDate" value="loggedInUserRegDate" />
<c:set var="myVote" value="loggedInUserVote" />
<c:url var="User" value="/Users">
	<c:param name="answerUserId" value="${sessionScope[myUserId]}" />
</c:url>
<!-- ------------------------------------------------------------------ -->

<nav class="navbar navbar-inverse" >
    <div class="container-fluid">
        
        <ul class="nav navbar-nav navbar-header" id="navHeader" title="Go to Home page">
            <a href="https://java-arabic-community.herokuapp.com/AllQuestions">
               <img class="nav-logo" alt="Logo not found!" src="${pageContext.request.contextPath}/resources/images/miniLogo.png">
            </a>
            <span id="nav-header-p">Java Arabic Commumity<br>Q &amp; A website</span>
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
            <li style="float:right;">
            	<form action="j_spring_security_logout" id="logout-form" method="POST">
            		<button type="submit" class="logout-btn"><span class="glyphicon glyphicon-log-out"></span> Logout</button>
            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            	</form>
            </li>
            <li title="Go to profile" style="float:right;">
                <div class="nav-img-div">
                    <img class="nav-prof-img" alt="Profile picture" src="data:image/jpeg;base64,${sessionScope[myPicture]}"> 
                </div>
                <div style="float: left; padding: 0; width:90px; color: white; font-size: 11px; cursor: pointer;">
                    <span onclick="window.location.href='${User}'">${sessionScope[myNickname] } </span><br> 
                    <span>${sessionScope[myRegDate] }</span><br> 
                    <span>&#9813; ${sessionScope[myVote] }</span>
                </div>	
            </li>
        </ul>
    </div>
</nav>
</body>
</html>