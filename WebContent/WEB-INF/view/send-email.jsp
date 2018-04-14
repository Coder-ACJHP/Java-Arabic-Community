<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
	<title>Send Email - Java Arabic Community</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
	<!-- BOOTSTRAP DEPENDENCIES -->
	<script src="resources/jquery/3.2.1/jquery.min.js"></script>
	<script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body style="background-color: white;">
		
	<jsp:include page="logedOut.jsp" />
<!-- HANDLE ALL MESSAGES COMING FROM BACKEND -->
    <c:if test="${not empty error}">
		<script type="text/javascript">
			sweetAlert("Oops...", "${error}", "error");
		</script>
	</c:if>      
	<c:if test="${not empty success}">
		<script type="text/javascript">
			sweetAlert('Excellent!', "${success}", "success");
		</script>
	</c:if>
<div class="container">
		<div class="row">
			<div class="col-md-6 col-lg-offset-3">
				<h2>Reset Password:</h2>
				<hr style="margin-bottom: 20px; margin-top: 5px;">
				<form:form action="SendEmail" modelAttribute="user" method="POST">
					<div class="form-group">
							
						<div class="alert alert-info alert-dismissable" role="alert">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							We will send your password to the following email address.
						</div>	
						<form:input type="email" path="EMAIL" class="form-control"
							title="We'll never share your email with anyone else."
							placeholder="Enter your email" required="required" />
					</div>
					<div class="row">
	                	<div class="col-lg-12" style="text-align:center;">
							<button type="button" class="btn btn-info" style="width: 150px;" onclick="window.location.href='AllQuestions'">
								<i class="glyphicon glyphicon-arrow-left"></i> Back to home
							</button>	  
							<button type="submit" class="btn btn-primary" style="width: 150px;">
								<i class="glyphicon glyphicon-send"></i> Send me e-mail
							</button>                 		
	                    </div>
                    </div>
				</form:form>
			</div>
		</div>
	</div>			
<jsp:include page="footer.jsp" />
</body>
</html>