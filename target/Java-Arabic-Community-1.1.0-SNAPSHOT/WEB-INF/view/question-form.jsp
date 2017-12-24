<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<!DOCTYPE html>
<html>
<head>
	<title>Ask Question - Java Arabic Community</title>
	<script src='https://www.google.com/recaptcha/api.js'></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	
	<script type="text/javascript" src='//cloud.tinymce.com/stable/tinymce.min.js?apiKey=l03xfookfa0t5658pstpggnkx50dqemaqz491cd5pfrih29o'></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/init-tinymce.js"></script>
	
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
	
<div class="container">	

	<div class="row">
		<div class="col-lg-11 col-lg-offset-1">
		
			<div class="col-md-7">
				<form:form action="SaveQuestion" modelAttribute="question" method="POST" id="theForm">
					<!-- need to associate this data with customer id -->
					<form:hidden path="ID" />
			
				
					<div class="row">
						
								<% 	String previousUrl = request.getHeader("Referer");
 									pageContext.setAttribute("previousUrl", previousUrl); %> 
							<form:hidden path="USERID" value="${sessionScope[myUserId]}" /> 
							<input type="hidden" name="from" value="${previousUrl}">
					</div>
					
					<div class="row">
                           <div class="form-group">
                                <label><b><spring:message code="label.title" />:</b></label>
                                <form:input path="QUESTIONS" class="form-control" placeholder=" What's your programming question?" required="required" />
                           </div>
                                <label></label>
                    </div>
					
					<div class="row">
                          <div class="form-group">
                               <label><b><spring:message code="label.explain" />:</b></label>
                               <form:textarea path="QEXPLAIN" id="mytextarea" class="qText" required="required"></form:textarea>
                          </div>
                    </div>
					
					<div class="row">
                          <div class="form-group">
                              <label><b><spring:message code="label.tags" />:</b></label>
                              <form:input path="TAGS" class="form-control" placeholder=" Language, classes tags, max 5 tags" required="required" />
                          </div>
                    </div>     
					<div class="row">
							<hr style="opacity: 0.0">
							<div class="g-recaptcha" data-sitekey="6LcWfzsUAAAAABio3CXBPD8l9jeOaWkeToBNOUEP"></div>
							<c:if test="${not empty error}">
								<script type="text/javascript">
									sweetAlert("Oops...", "${error}", "error");
							   </script>
							</c:if>
					</div>
					<div class="row">
						<spring:message code="label.postQuestion" var="labelSubmit" />
						<button type="submit" class="btn btn-primary" onclick="if('${sessionScope[myUserId]}' > 0){document.getElementById('theForm').submit();}else{window.location.href='SignIn'};" >
							<span class="glyphicon glyphicon-send"></span> ${labelSubmit}
						</button>
						<button class="btn btn-info" type="button" onclick="window.location.href='AllQuestions'">
							<span class="glyphicon glyphicon-arrow-left"></span> Go back
						</button>
                  </div>
			</form:form>
		</div>
		<div class="col-sm-1">&nbsp;</div>
		<div class="col-md-4">
			
				<div class="row">
						<div class="how-to-ask-banner">
							<h4>How to ask?</h4>
							<h5>Is your question about programming?</h5>
							<p>We prefer questions that can be
								answered, not just discussed.</p>
							<p>Provide details. Share your
								research.</p>
							<p>
								If your question is about this website, ask it on <a
									href="https://github.com/Coder-ACJHP/Java-Arabic-Community">Github</a>
								instead.
							</p>
							<p style="font-size: 12px; float: right;">
								<a href="mailto:hexa.octabin@gmail.com">Ask Coder ACJHP
									&raquo;</a>
							</p>
						</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div style="margin-bottom: 100px;"></div>
		</div>
	</div>
</div>	
	<jsp:include page="footer.jsp" />
</body>
</html>