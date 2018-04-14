<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password - Java Arabic Community</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    <!-- BOOTSTRAP DEPENDENCIES -->
	<script src="resources/jquery/3.2.1/jquery.min.js"></script>
	<script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<!-- BOOTSTRAP DEPENDENCIES END-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-show-password.min.js"></script>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body style="background-color: white;">
	<jsp:include page="logedOut.jsp" />
	
<!-- HANDLE ALL MESSAGES COMING FROM BACKEND -->
<c:if test="${not empty error}">
	<script type="text/javascript">
		sweetAlert("${headerError}", "${error}", "error");
	</script>
</c:if>
<c:if test="${not empty message}">
	<script type="text/javascript">
		sweetAlert('Excellent!','${success}', 'success');
	</script>
</c:if>
	
 <div class="container">
 	<div class="row">
 		<div class="col-md-6 col-lg-offset-3">
 			
 			<h2>Reset your password :</h2>
 			<hr style="margin-bottom: 20px; margin-top: 5px;">
 			
			<form:form action="UpdatePwdWithUdid" modelAttribute="user" method="POST">
				<form:hidden path="ID"/>
								
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="uuid">Unique key:</label>
						</div>
						<div class="col-md-8">
							<input name="UUID" type="text" id="uuid" class="form-control" 
								required="required" placeholder="########-####-####-####-############"
								pattern="[0-9a-z]{8}[\-][0-9a-z]{4}[\-][0-9a-z]{4}[\-][0-9a-z]{4}[\-][0-9a-z]{12}"
								title="Copy your unique key from the email!" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="newPsw">New password:</label>
						</div>
						<div class="col-md-8">
							<input name="newPsw" type="password" id="newPsw" class="form-control" style="z-index: 0;"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Include uppercase and lowercase letter!"
								required="required" placeholder="Must have at least 6 characters" data-toggle="password"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="cnfPsw">Confirm psw:</label>
						</div>
						<div class="col-md-8">
							<input name="confirmPsw" type="password" id="cnfPsw" class="form-control" style="z-index: 0;"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Include uppercase and lowercase letter!"
							 	required="required" placeholder="Must have at least 6 characters" data-toggle="password"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<button type="submit" class="btn btn-info" onclick="window.location.href='AllQuestions'" ><i class="glyphicon glyphicon-arrow-left"></i> Back to home</button>
                    		<button type="submit" class="btn btn-success" ><i class="glyphicon glyphicon-ok"></i> Update password</button>
						</div>
					</div>
			</form:form>	
		</div>	
	</div>
</div><!-- CONTAINER END -->		

	<jsp:include page="footer.jsp" />
	<script type="text/javascript">
		$("#password").password('toggle');
	</script>
</body>
</html>