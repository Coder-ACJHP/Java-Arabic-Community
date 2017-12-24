<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<!DOCTYPE html>
<html>
<head>
	<title>Register - Java Arabic Community</title>
	<script src='https://www.google.com/recaptcha/api.js'></script>
	
	<!-- BOOTSTRAP DEPENDENCIES -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- BOOTSTRAP DEPENDENCIES END-->
    
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
	<jsp:include page="logedOut.jsp" />
        
<c:if test="${not empty message}">
   <script type="text/javascript">
       swal("${message}")
   </script>
</c:if>
<c:if test="${! empty error}">
 	<script type="text/javascript">
 		sweetAlert("Oops...", "${error}", "error");
 	</script>
</c:if>
<!-- NAVIGATIONBAR STARTED -->
   			<div class="row">
    			<div class="col-lg-10 col-lg-offset-2">
				<div class="col-sm-2">
					<p style="font-size: 18px; min-width: 150px;"><b>New member :</b></p>
				</div>
				<div class="col-sm-2">
	    			<spring:message code="label.askQuestion" var="LabelAskQues"/>
                    <button type="button" class="btn btn-primary" style="width: 150px;"
                    	onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {window.location.href='SignIn'};return false;">
                           <span class="glyphicon glyphicon-question-sign" style="color:#cdf02d;"></span> ${LabelAskQues}
                    </button>       
	    		</div>
	    		<div class="col-sm-2">
	    			<spring:message code="label.top" var="LabelTop"/>
                    <button type="button" class="btn btn-primary" style="width: 150px;" 
                    	onclick="window.location.href='TopQuestions'; return false;">
                    	 <span class="glyphicon glyphicon-fire" style="color:red;"></span> ${LabelTop}
                    </button>	 
	    		</div>
	    		<div class="col-sm-2">
	    			<spring:message code="label.users" var="LabelUsers"/>
                    <button type="button" class="btn btn-primary" style="width: 150px;"
                        onclick="window.location.href = 'Users-list'; return false;" >
                        <span class="glyphicon glyphicon-th-list" style="color: gold;"></span> ${LabelUsers}
                     </button>   
	    		</div>
	    		<div class="col-sm-2">
	    			<spring:message code="label.info" var="LabelInfo"/>
                    <button type="button" class="btn btn-primary" style="width: 150px;"
                        onclick="window.location.href = 'Info-page'; return false;" >
                        <span class="glyphicon glyphicon-info-sign"></span> ${LabelInfo}
                    </button>    
	    		</div>
	    		<div class="col-sm-2"></div>
    		</div>
    	</div>
    	<div class="row">
    		<div class="col-lg-8 col-lg-offset-2">
    			<hr>
    		</div>
    	</div>
    	
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<h2>
			<spring:message code="label.register" /> :
		</h2>
		<hr style="margin-bottom: 20px; margin-top: 5px;">
	</div>
	<div class="col-md-3"></div>
</div>
<div align="center">
	<div class="container">
	  <form:form action="RegisterUser" modelAttribute="user" method="POST" enctype="multipart/form-data">
		<div class="row">
			<div class="col-lg-5">
			<!-- need to associate this data with user id -->
			<form:hidden path="ID" value="${user.ID}" />

			<!-- Check the user is logged in user? -->
				<img class="bigImg" alt="No image"
					src="${pageContext.request.contextPath}/resources/images/nouser.jpg">
				<br> <b style="white-space: nowrap;"><label>${user.NICKNAME }</label></b>
			</div>
			
			<div class="col-lg-7">
				<!-- ---------------------------------------------------------- -->
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="firstname"><spring:message code="label.firstName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FIRSTNAME" type="text" class="form-control"
								id="firstname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="lastname"><spring:message code="label.lastName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="LASTNAME" type="text" class="form-control"
								id="lastname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="nickname"><spring:message code="label.nickName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="NICKNAME" type="text" class="form-control"
								id="nickname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="email"><spring:message code="label.email" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="EMAIL" type="email" class="form-control"
								id="email" required="required"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="psw"><spring:message code="label.password" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="PASSWORD" type="password" class="form-control" id="psw" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="country"><spring:message code="label.country" />:</label>
						</div>
						<div class="col-md-6">
							<form:select path="COUNTRY" class="form-control" required="required">
								<form:options items="${countriesOption}"/>
							</form:select>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="birtdate">
								<spring:message code="label.birthday" />:
							</label>
						</div>
						<div class="col-md-6">
							<div class='input-group date' id='datepicker'>
								<form:input type='text' path="BIRTHDAY" class="form-control" pattern="\d{1,2}.\d{1,2}.\d{4}" 
										placeholder="dd.mm.yyyy" style="z-index:0;" required="required"/>
								<span class="input-group-addon"> 
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="lng"><spring:message code="label.fav_language" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FAV_PROG_LANG" type="text" class="form-control"
								id="lng" placeHolder="Java,C++,Python" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label><spring:message code="label.picture" />:</label>
						</div>
						<div class="col-md-6">
							<input type="file" name="fileUpload" class="btn btn-default btn-file" style="width: 311px;"/>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label><spring:message code="label.about" />:</label>
						</div>
						<div class="col-md-6">
							<form:textarea class="form-control" path="ABOUT" id="comment" required="required"/>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-md-8">
							<div class="g-recaptcha" data-sitekey="6LcWfzsUAAAAABio3CXBPD8l9jeOaWkeToBNOUEP"></div>
						</div>
					</div>
				</div>
			 </div>
			 <div class="row">
			 	<div class="col-lg-8 col-lg-offset-2" style="float: none;">
			 		<div class="row">
						<div class="col-md-8">
							<hr>
						</div>
					</div>
					<div class="row">
						<div class="col-md-8">
							<div class="btn-group btn-group-justified">
								<div class="btn-group">
									<button class="btn btn-primary" type="button" onclick="window.location.href='AllQuestions'">
										<span class="glyphicon glyphicon-home"></span> Go back
									</button>
								</div>
								<div class="btn-group">
									<button class="btn btn-info" type="reset">
										<span class="glyphicon glyphicon-trash"></span> Clear
									</button>
								</div>
								<div class="btn-group">
									<button class="btn btn-success" type="submit">
										<span class="glyphicon glyphicon-ok"></span> Register
									</button>
								</div>
							</div>
						</div>
					</div>		
			 	</div>
			 </div>
		</form:form>
  </div>
</div>
	<div class="row" style="margin-top: 150px;"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>