<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>Login - Java Arabic Community</title>
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
    
<!-- HANDLE ALL MESSAGES COMING FROM BACKEND ON URL -->
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
        	
        	<h2>
                <spring:message code="label.signIn" /> :
            </h2>
            <hr style="margin-bottom: 20px; margin-top: 5px;">
            
            <form:form action="LoginForm" modelAttribute="user" method="POST">
                
                    <div class="form-group">
                        <form:input type="email" path="email" class="form-control" value="${email}" id="email"
                        	title="We'll never share your email with anyone else." placeholder="Email address"/>
                        <form:errors path="email" cssClass="error" id="emailError" />	
                    </div>
                    <div class="form-group">
                        <form:input type="password" path="password" id="psw" class="form-control" placeholder="Password" data-toggle="password"/>
                    	<form:errors path="password" cssClass="error" id="passwordError" />
                    </div>
                    <div class="row">
	                <div class="col-lg-12" style="text-align:center;">
	                    <button type="submit" class="btn btn-primary btn-block" style="height:50px; font-size:1.5em; font-weight:bold;">
	                    	<i class="glyphicon glyphicon-log-in"></i> LOG IN
	                    </button>
	                </div>
                    </div>
                </form:form> 

                <div class="row"><div class="col-lg-12">&nbsp;&nbsp;</div></div>
                
                <div class="row">
                	<div class="col-lg-12" style="text-align:center;">
                		<p style="font-weight: bold; font-size: 20px; float:left;">
				            <a href="${pageContext.request.contextPath }/SignUp"><font style="color:#6897bb;">Don't have an <font style="color:#DD062E;">account</font>?</font></a>
				            <a href="${pageContext.request.contextPath}/ForgotPassword" style="margin-left:84px; color:black;">Forgot password?</a>
				        </p>
                	</div>
                </div>
		        
        </div>
    </div>
</div>
<br>
	<jsp:include page="footer.jsp" />
<script type="text/javascript">
     $("#password").password('toggle');

	  $('#email').focus(function() {
		$("#emailError").remove();
	  });      	
        
	  $('#psw').focus(function() {
		$('#passwordError').remove();
	});
        
</script>
</body>
</html>