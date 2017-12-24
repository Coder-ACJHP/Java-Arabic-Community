<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Suggestion - Java Arabic Community</title>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
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
	<c:if test="${not empty error}">
		<script type="text/javascript">
			sweetAlert("Oops...", "${error}", "error");
		</script>
	</c:if>
	<c:if test="${not empty success}">
		<script type="text/javascript">
			sweetAlert("Excellent!", "${success}", "success");
		</script>
	</c:if>
	
	<div class="container">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<h2>
					Send us your feedback, comments, and suggestions!
				</h2>
				<hr style="margin-bottom: 20px; margin-top: 5px;">
			</div>
			<div class="col-md-2"></div>
		</div>	
		
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<form:form action="SendSuggest" method="POST">
						<div class="row">
							<label class="control-label" for="firstname">First and last name: <b style="color:red;">*</b></label>
							<input name="name" type="text" class="form-control"
								id="firstname" maxlength="50" required="required" />
						</div><br>
						<div class="row">
								<label class="control-label" for="email">E-mail Address: <b style="color:red;">*</b></label>
								<input name="email" type="email" class="form-control"
									id="email" maxlength="50" required="required" />
						</div><br>
						<div class="row">
								<label class="control-label" for="country">Country: <b style="color:red;">*</b></label>
								<select name="country" class="form-control" required="required">
									<c:forEach items="${countriesOption}" var="country">
										<option value="${country.key}">${country.value}</option>
									</c:forEach>
								</select>
						</div><br>
						<div class="row">
								<label class="control-label" for="category">Category: <b style="color:red;">*</b></label>
								<select name="category" class="form-control" required="required">
										<option value="Feedback">Feedback</option>
										<option value="Suggest something">Suggest something</option>
										<option value="Help about website">Help about website</option>
										<option value="Report a problem">Website issue</option>
										<option value="All categories">All categories</option>
								</select>
						</div><br>
						<div class="row">
								<label class="control-label" for="subject">Subject: <b style="color:red;">*</b></label>
								<input name="subject" type="text" class="form-control"
									id="subject" maxlength="5000" required="required" />
						</div><br>
						<div class="row">
								<label class="control-label" for="message">Message: <b style="color:red;">*</b></label>
								<textarea name="message" class="form-control"
									id="message" maxlength="10000" required="required" ></textarea>
						</div><br>
						<div class="row">
							<button type="submit" class="btn btn-info btn-block" title="Send your feedback">
								<span class="glyphicon glyphicon-send"></span> Send it
							</button>
						</div><br>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>