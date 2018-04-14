<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Error - Java Arabic Community</title>
    <!-- BOOTSTRAP DEPENDENCIES -->
    <script src="resources/jquery/3.2.1/jquery.min.js"></script>
    <script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
 <div class="container">
 	<div class="col-lg-8 col-lg-offset-2">
 		<div class="row">
			<div class="col-md-12">
				<div class="page-header" style="text-align: center;">
					<small style="color:black; font-size: 2em;">Error code :</small><span style="color: red; font-size: 5em;">${headerError}</span>
				</div>
			</div>
		</div>	
		<div class="row">
			<div class="col-md-12">
				<div class="page-header" style="text-align: center;">
					<h3>${error}</h3>
				</div>
			</div>
		</div>		
		<div class="row">	
			<div class="col-lg-12 col-md-12 col-sm-12 col-xm-12" style="text-align: center;">
				<button type="button" class="btn btn-primary" style="width: 150px; margin-bottom: 100px;"
						onclick="window.location.href='${pageContext.request.contextPath }/AllQuestions'">
						<i class="glyphicon glyphicon-arrow-left"></i> Go Back
				</button>
				<button type="button" class="btn btn-info" style="margin-bottom: 100px;"
						onclick="window.location.href='${pageContext.request.contextPath }/Suggestion'">
						<i class="glyphicon glyphicon-info-sign"></i> Report the problem
				</button>
			</div>
		</div>
 	</div>
</div>
</body>
<jsp:include page="footer.jsp" />
</html>