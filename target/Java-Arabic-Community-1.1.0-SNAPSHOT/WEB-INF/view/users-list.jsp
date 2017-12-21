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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
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
    		<div class="col-lg-8">
				<div class="col-sm-3" style="text-align: center;">
					<p style="font-size: 18px; min-width: 150px;">
						<b><spring:message code="label.users" /> :</b>
					</p>
				</div>
				<div class="col-sm-3">
	    			<spring:message code="label.askQuestion" var="LabelAskQues"/>
                    <button type="button" class="btn btn-primary" style="width: 150px;"
                    	onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {window.location.href='SignIn'};return false;">
                           <span class="glyphicon glyphicon-question-sign" style="color:#cdf02d;"></span> ${LabelAskQues}
                    </button> 
	    		</div>
	    		<div class="col-sm-3">
	    			<spring:message code="label.questions" var="LabelQuestions" />
                    <button type="button" class="btn btn-primary" style="width: 150px;" 
                    	onclick="window.location.href='AllQuestions'; return false;">
                    	 <span class="glyphicon glyphicon-fire" style="color:red;"></span> ${LabelQuestions}
                    </button>	
	    		</div>
	    		<div class="col-sm-3">
	    			<spring:message code="label.info" var="LabelInfo"/>
                    <button type="button" class="btn btn-primary" style="width: 150px;"
                        onclick="window.location.href = 'Info-page'; return false;" >
                        <span class="glyphicon glyphicon-info-sign"></span> ${LabelInfo}
                    </button> 
	    		</div>
    		</div>
			<div class="col-lg-3">
				<form:form action="SearchUser" method="POST">
					<div class="input-group" style="margin-top: 4px;">
						<input type="text" name="theSearchUser" class="form-control" placeholder="Type to search">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit" style="margin-top: 0px;">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
    	<div class="row">
    		<div class="col-lg-10 col-lg-offset-1">
    			<hr>
    		</div>
    	</div>
  <!-- NAVIGATION BAR END -->
  <div class="row">
	<c:forEach var="map" items="${userList }" varStatus="theCount">
		<div class="col-md-3">
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
										<span style="margin-top: 1px;">R.D.
											:${user.REGISTERDATE}</span>
										<p>
											${user.FAV_PROG_LANG}<span style="float: right">Vote:
												<span class="badge" style="color: gold;">${user.VOTE}</span>
											</span>
										</p>
									</div>
								</div>
								<div class="col-sm-2"></div>
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