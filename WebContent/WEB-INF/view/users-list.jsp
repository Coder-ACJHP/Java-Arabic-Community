<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Users -Java Arabic Community</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/userList.css">
    <!-- BOOTSTRAP DEPENDENCIES -->
	<script src="resources/jquery/3.2.1/jquery.min.js"></script>
	<script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body style="background-color: white;">
	<c:set var="myUserId" value="loggedInUserId" />
	<c:choose>
		<c:when test="${empty sessionScope[myUserId]}">
                    <jsp:include page="logedOut.jsp" />
		</c:when>
		<c:otherwise>
                     <jsp:include page="logedIn.jsp" />
		</c:otherwise>
	</c:choose>
<div class="container">
	
  <!-- NAVIGATION BAR START -->		
  	<div class="row">
    		<div class="col-lg-10 col-lg-offset-1">
    		<ul class="nav nav-tabs">
			    <li class="active">
                                    <a href="Users-list" title="Refresh the page." style="cursor: pointer;">
						<b><spring:message code="label.users" /> list :</b>
					</a>
			    </li>
			    <li>
			    	<a class="href-link" onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {window.location.href='SignIn'};return false;">
			    		<spring:message code="label.askQuestion" var="LabelAskQues"/>
			    		<span class="glyphicon glyphicon-question-sign" style="color:#cdf02d;"></span> ${LabelAskQues}
			    	</a>
			    </li>
			    <li>
			    	<a href="AllQuestions">
			    		<spring:message code="label.questions" var="LabelQuestions" />
			    		<span class="glyphicon glyphicon-fire" style="color:red;"></span> ${LabelQuestions}
			    	</a>
			    </li>
			     <li>
			    	<a href="Info-page">
			    		<spring:message code="label.info" var="LabelInfo"/>
			    		<span class="glyphicon glyphicon-info-sign"></span> ${LabelInfo}
			    	</a>
			    </li>
			    <li class="keep-inline">
			    	<form:form action="SearchUser" method="POST">
						<div class="input-group" style="margin-top: 4px;">
							<input type="text" name="theSearchUser" class="form-control" placeholder="Type to search users">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit" style="margin-top: 0px;">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form:form>
			    </li>
			  </ul>
			 </div> 
    	</div>
    	<!-- GIVE SOME SPACE -->          	    	
    	<div class="row">
    		<div class="col-lg-9 col-lg-offset-2">
    			<br><br>
    		</div>
    	</div>
    	
	  <!-- NAVIGATION BAR END -->
  
  <div class="row">
	<c:forEach var="map" items="${userList }" varStatus="theCount">
		<div class="col-lg-3 col-md-4">
				<div class="panel panel-default" id="userCard">
					<div class="panel-body" id="panel-card">
						<div class="row">
							<c:forEach var="picture" items="${pictureList }"
								begin="${theCount.index}" end="${theCount.index}">
								<div class="col-sm-3">
									<img class="list-img" align="bottom" alt="No image" src="data:image/jpeg;base64,${picture}">
								</div>
							</c:forEach>
							<c:forEach var="user" items="${userList }"
								begin="${theCount.index}" end="${theCount.index}">
								<c:url var="User" value="/Users">
									<c:param name="answerUserId" value="${user.ID}" />
								</c:url>

								<div class="col-sm-7">
									<div class="row">
										<a class="userLink" href="${User}" style="float: left;">${user.NICKNAME}</a>
										<span style="font-size: 12px; float: right; color: #f442ce;">${user.COUNTRY}</span>
									</div>
									<div class="row">
										<span style="margin-top: 1px;">R.D. :${user.REGISTERDATE}</span>
										<p>
											${user.FAV_PROG_LANG}<span style="float: right">Vote:
												<span class="badge" style="color: gold;">${user.VOTE}</span>
											</span>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
	<footer>
		<jsp:include page="footer.jsp" />
	</footer>
</body>
</html>