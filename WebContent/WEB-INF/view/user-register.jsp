<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Java Arabic Community</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.datetimepicker.css">
	
	<!-- BOOTSTRAP DEPENDENCIES -->
	<script src="resources/jquery/3.2.1/jquery.min.js"></script>
	<script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<!-- BOOTSTRAP DEPENDENCIES END-->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!--show password js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-show-password.min.js"></script>
    <style type="text/css">.col-md-3 {text-align: right;}</style>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
	<style type="text/css">.col-md-3 {text-align: right;}</style>
</head>
<body>
	<jsp:include page="logedOut.jsp" />
<c:if test="${not empty error}">
	<script type="text/javascript">
		sweetAlert("Oops...", "${error}", "error");
	</script>
</c:if>
<c:set var="myUserId" value="loggedInUserId" />
<!-- NAVIGATIONBAR STARTED -->
	<div class="container">  
		<div class="col-lg-10 col-lg-offset-1" id="base-row">
			<div class="row" style="margin-top:15px;">
	
			<div class="row">
	    		<div class="col-lg-10 col-lg-offset-1">
	    		<ul class="nav nav-tabs">
				    <li class="active">
                     	<a href="SignUp" title="Refresh the page." style="cursor: pointer;">
                           <b>New member :</b>
						</a>
				    </li>
				    <li>
				    	<a class="href-link" onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {window.location.href='SignIn'};return false;">
				    		<spring:message code="label.askQuestion" var="LabelAskQues"/>
				    		<span class="glyphicon glyphicon-question-sign" style="color:#cdf02d;"></span> ${LabelAskQues}
				    	</a>
				    </li>
				    <li>
				    	<a href="TopQuestions">
				    		<spring:message code="label.top" var="LabelTop"/>
				    		<span class="glyphicon glyphicon-fire" style="color:red;"></span> ${LabelTop}
				    	</a>
				    </li>
				    <li>
				    	<a href="Users-list">
				    		<spring:message code="label.users" var="LabelUsers"/>
				    		<span class="glyphicon glyphicon-th-list" style="color: gold;"></span> ${LabelUsers}
				    	</a>
				    </li>
				     <li>
				    	<a href="Info-page">
				    		<spring:message code="label.info" var="LabelInfo"/>
				    		<span class="glyphicon glyphicon-info-sign"></span> ${LabelInfo}
				    	</a>
				    </li>
				  </ul>
				 </div> 
	    	</div>
	    	
	    	<div class="row">
	    		<div class="col-lg-8 col-lg-offset-2">
	    			<br>
	    		</div>
	    	</div>
    </div>
<div class="row">
	<div class="col-md-9 col-md-offset-1">
		<h2>
			<spring:message code="label.register" /> :
		</h2>
		<hr style="margin-bottom: 20px; margin-top: 5px;">
	</div>
</div>
<div align="center">
	  <form:form action="RegisterUser" modelAttribute="user" method="POST" enctype="multipart/form-data">
		<div class="row">
			<div class="col-lg-4">
			<!-- need to associate this data with user id -->
			<form:hidden path="ID" value="${user.ID}" />

			<!-- Check the user is logged in user? -->
				<img class="bigImg" alt="No image" src="${pageContext.request.contextPath}/resources/images/nouser.jpg">
				<br> <b style="white-space: nowrap; font-size: 3rem;"><label id="user-nickName">${user.NICKNAME }</label></b>
				<div style="margin-top:10px;" id="errorMsgFields">
					<spring:bind path="*">
						<ol>
						<c:forEach items="${status.errorMessages}" var="errormessage">
							<li class="error">${errormessage}</li>
						</c:forEach>
						</ol>
					</spring:bind>
				</div>
			</div>
			<div class="col-lg-8">
				<!-- ---------------------------------------------------------- -->
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="firstname"><spring:message code="label.firstName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FIRSTNAME" type="text" class="form-control" id="firstname"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="lastname"><spring:message code="label.lastName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="LASTNAME" type="text" class="form-control" id="lastname"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="nickname"><spring:message code="label.nickName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="NICKNAME" type="text" class="form-control" id="nickname" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="email"><spring:message code="label.email" />:</label>
						</div>
						<div class="col-md-6">
							<div class='input-group'>
								<form:input path="EMAIL" type="email" class="form-control" id="email"/>
								<span class="input-group-addon"> 
										<span class="glyphicon glyphicon-envelope"></span>
								</span>
							</div>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="psw"><spring:message code="label.password" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="PASSWORD" type="password" class="form-control" id="psw" data-toggle="password" style="z-index:0;"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="birtdate">
								<spring:message code="label.birthday" />:
							</label>
						</div>
						<div class="col-md-6">
 							<div class='input-group date'>
								<form:input type='text' path="BIRTHDAY" class="form-control" id="datetimepicker" style="z-index:0;"/>
								<span class="input-group-addon"> 
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="country"><spring:message code="label.country" />:</label>
						</div>
						<div class="col-md-6">
							<form:select path="COUNTRY" class="form-control" required="required">
								<form:options items="${countriesOption}"/>
							</form:select>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="lng"><spring:message code="label.fav_language" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FAV_PROG_LANG" type="text" class="form-control" id="lng" placeHolder="Java,C++,Python"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label><spring:message code="label.picture" />:</label>
						</div>
						<div class="col-md-6">
							<input type="file" name="fileUpload" class="btn btn-default btn-file" style="width: 290px;"/>
							<div class="error" id="error" accesskey="fileError" style="text-align:left;"></div>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label><spring:message code="label.about" />:</label>
						</div>
						<div class="col-md-6">
							<form:textarea class="form-control" path="ABOUT" id="comment"/>
						</div>
					</div>
				</div>
			 </div>
			 <div class="row" style="margin: 10px;">
			 	<div class="col-lg-8 col-lg-offset-2" style="float: none;">
					<div class="row">
						<div class="col-md-8">
							<button class="btn btn-info" type="button" onclick="clearForm();" style="width:150px;">
                                <span class="glyphicon glyphicon-trash" ></span> Clear
							</button>
							<button class="btn btn-success" type="submit" style="width:150px;">
								<span class="glyphicon glyphicon-ok"></span> Register
							</button>
						</div>
					</div>		
			 	</div>
			 </div>
		</form:form>
</div>
</div>
</div>
	<div class="row" style="margin-top: 100px;"></div>
	<jsp:include page="footer.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.datetimepicker.full.min.js"></script>
     <script type="text/javascript">
    	 $(document).ready(function() {
    		 
    		 $("#password").password('toggle');  
    		 
    		 $("#datetimepicker").datetimepicker({format: 'd.m.Y'},{timepicker:false},{closeOnDateSelect:true});

		});
    	    	
    	$('#nickname').keyup(function() {
    		$('label[id="user-nickName"]').html($(this).val());
		});
    	
    	
    	var errorFields = $("div[id='errorMsgFields']");
    	var childrenLi = $('ol');
    	var submitButton = $('button[type="submit"]');
    	
    	if(childrenLi.find('li').length > 0) {
    		errorFields.prepend('<h4 class="error"><b>REGISTER ERROR(S)!</b></h4>');
    		submitButton.prop('disabled', true); //disable
    		submitButton.attr('title', 'Clear error messages to enable this.');
    	} 
    	
    	
        function clearForm() {
        	errorFields.hide();
        	submitButton.prop('disabled', false); //disable
        	submitButton.attr('title', 'Click to register.');
           
        }        
        
        //this function for disallow upload file that bigger than 1 mb.
        $('input[name="fileUpload"]').change(function() {
        	var uploadedFile = this.files[0];
        	var errorField = $('div[accesskey="fileError"]');
        	if(uploadedFile.size > 1048576) {
        		errorField.html('Uploaded image too large!');
        		$(this).val('');
        	} else {
        		errorField.html('');
        	}
        });
     </script>
</body>
</html>