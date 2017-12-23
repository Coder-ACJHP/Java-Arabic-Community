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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- GRADIENT BACKGROUN DEPENDENCIES-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
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
        	
        	<h2>
                <spring:message code="label.signIn" /> :
            </h2>
            <hr style="margin-bottom: 20px; margin-top: 5px;">
            
            <form:form action="LoginForm" modelAttribute="user" method="POST">
                <!-- need to associate this data with customer id -->
                <form:hidden path="ID" />
                <input type="hidden" name="from" value="${previousUrl}">
                    <div class="form-group">
                        <form:input type="email" path="EMAIL" class="form-control" value="${email}" 
                        	title="We'll never share your email with anyone else." placeholder="Enter email" required="required"/>
                    </div>
                    <div class="form-group">
                        <form:input type="password" path="PASSWORD" class="form-control" placeholder="Password" required="required"/>
                    </div>
                    <div class="row">
	                	<div class="col-sm-8 col-sm-offset-3">
	                    	<button type="reset" class="btn btn-info" style="width:150px;"><i class="glyphicon glyphicon-trash"></i> Clear</button>
	                   		<button type="submit" class="btn btn-primary" style="width:150px;"><i class="glyphicon glyphicon-log-in"></i> Login</button>
	                    </div>
                    </div>
                </form:form> 

                <div class="row"><div class="col-lg-12">&nbsp;&nbsp;</div></div>
                
                <div class="row">
                	<div class="col-sm-8 col-sm-offset-3">
                		<p>
				            <a href="${pageContext.request.contextPath }/AllQuestions">Back to questions page</a>
				            <b style="color:black;">||</b> 
				            <a href="${pageContext.request.contextPath}/ForgotPassword">I forgot my password</a>
				        </p>
                	</div>
                </div>
		        
        </div>
    </div>
</div>
<br>
	<jsp:include page="footer.jsp" />
</body>
</html>