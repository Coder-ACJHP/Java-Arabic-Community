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
	<title>Edit Answer - Java Arabic Community</title>
	<script src='https://www.google.com/recaptcha/api.js'></script>
	
	<script src="${pageContext.request.contextPath}/resources/js/prism.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/prism.css">
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    
	<script type="text/javascript" src='//cloud.tinymce.com/stable/tinymce.min.js?apiKey=l03xfookfa0t5658pstpggnkx50dqemaqz491cd5pfrih29o'></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/init-tinymce.js"></script>
	<!-- BOOTSTRAP DEPENDENCIES -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- BOOTSTRAP DEPENDENCIES END-->
    
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>

	<c:if test="${not empty error}">
		<script type="text/javascript">
			sweetAlert("Oops...", "${error}", "error");
		</script>
	</c:if>

	<c:set var="myUserId" value="loggedInUserId" />
	<c:choose>
		<c:when test="${empty sessionScope[myUserId]}">
				 <jsp:include page="logedOut.jsp" />
		</c:when>
		<c:otherwise>
			 <jsp:include page="logedIn.jsp" />
		</c:otherwise>
	</c:choose>
	
 <div align="center">	
	<div class="container">
		
		<div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div style="text-align: left;">
                <h2>Update Answer :</h2>
            </div>
            <hr style="margin-bottom: 5px; margin-top: 5px;">
        </div>
        <div class="col-md-3"></div>
    	</div>
		
		<form:form action="UpdateAnswer" modelAttribute="answer" method="POST" id="theForm">
			<!-- need to associate this data with customer id -->
			<form:hidden path="ID"/>
			<div style="float: center; padding-right: 0px; margin-top:50px; margin-bottom:100px; width: %70;">
			<table>
				<tbody>
					<tr>
						<td>
							<%String previousUrl = request.getHeader("Referer"); 
							pageContext.setAttribute("previousUrl", previousUrl);%>
							<input type="hidden" name="from" value="${previousUrl}">
						</td>
					</tr>
					<tr>
						 <td>
						 	<div class="form-group">
                               <label><b>Question Id:</b></label>
                               <form:input path="QUESTIONSID" class="form-control" id="psw" 
                               			title="Cannot change this value!" readonly="true"></form:input>
                         	</div>
						 </td>
					</tr>
					<tr>
						<td>
						 	<div class="form-group">
                               <label><b>Your Id:</b></label>
                               <form:input path="USERID" class="form-control" id="psw" 
                               				title="Cannot change this value!" readonly="true"></form:input>
                        	 </div>
						 </td>
					</tr>
					<tr>
						<td>
                          <div class="form-group">
                               <label><b>Answer:</b></label>
                               <form:textarea path="ANSWER" id="mytextarea" class="qText" required="required"></form:textarea>
                          </div>
                        </td>
					</tr>
					<tr>
						<td>
						 	<div class="form-group">
                               <label><b>Answer creation date:</b></label>
                               <form:input path="CREATIONDATE" class="form-control" id="psw" 
                               				title="Cannot change this value!" readonly="true" ></form:input>
                        	 </div>
						 </td>
					</tr>
					<tr>
						<td>
						 	<div class="form-group">
                               <label><b>Acceptance status:</b></label>
                               <form:input path="ISACCEPTED" class="form-control" id="psw" 
                               		title="Cannot change this value!" readonly="true"></form:input>
                        	 </div>
						 </td>
					</tr>
					<tr>
						<td>
						 	<div class="form-group">
                               <label><b>Answer vote count:</b></label>
                               <form:input path="VOTE" class="form-control" id="psw" 
                               		title="Cannot change this value!" readonly="true"></form:input>
                        	 </div>
						 </td>
					</tr>
					<tr>
						<spring:message code="label.updateAnswer" var="labelUpdateAnswer" />
						<td style="width: 550px; max-width: 550px;">
							<div class="g-recaptcha" data-sitekey="6LcWfzsUAAAAABio3CXBPD8l9jeOaWkeToBNOUEP"></div>
							<c:if test="${not empty error_message}">
								<script type="text/javascript">
									sweetAlert("Oops...", "${error_message}", "error");
								</script>
							</c:if>
							<hr style="margin-bottom: 5px; margin-top: 5px;">
							<div class="btn-group btn-group-justified">
								<div class="btn-group">
									<button class="btn btn-primary" type="button" onclick="window.location.href='AllQuestions'">
										<span class="glyphicon glyphicon-arrow-left"></span> Back to
										home
									</button>
								</div>
								<div class="btn-group">
									<button class="btn btn-success" type="submit" onclick="if('${sessionScope[myUserId]}' > 0){document.getElementById('theForm').
										submit();}else{window.location.href='SignIn'}; return false;">
										<span class="glyphicon glyphicon-ok"></span> Update Answer
									</button>
								</div>
							</div>
						</td>	
					</tr>
				</tbody>
			</table>
		</div>	
		</form:form>
		<div style="clear; both;"></div>
			<p>
				<a href="${pageContext.request.contextPath }/AllQuestions">Back to home</a>
			</p>
		</div>
	</div>	
	<jsp:include page="footer.jsp" />
</html>