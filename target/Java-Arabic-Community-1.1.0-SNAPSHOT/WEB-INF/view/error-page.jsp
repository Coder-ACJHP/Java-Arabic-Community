<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Error - Java Arabic Community</title>
<!-- BOOTSTRAP DEPENDENCIES -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
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
			<div class="col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-primary" style="width: 150px; margin-bottom: 100px;"
						onclick="window.location.href='${pageContext.request.contextPath }/AllQuestions'">
						<i class="glyphicon glyphicon-arrow-left"></i> Back</button>
			</div>
		</div>
 	</div>
</div>
</body>
<jsp:include page="footer.jsp" />
</html>