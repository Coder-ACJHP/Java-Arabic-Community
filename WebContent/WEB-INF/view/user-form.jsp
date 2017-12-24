<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<!DOCTYPE html>
<html>
<head>
	<title>User CV - Java Arabic Community</title>
	<!-- GOOGLE RECAPTCHA DEPENDENCIES -->
	<script src='https://www.google.com/recaptcha/api.js'></script>

	<!-- BOOTSTRAP DEPENDENCIES -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- BOOTSTRAP DEPENDENCIES END-->

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>
	
	<!-- SWEET ALERT DEPENDENCIES -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
        <!--show password js -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-show-password/1.0.3/bootstrap-show-password.min.js"></script>
        
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
<c:if test="${not empty message}">
   <script type="text/javascript">
       swal("${message}")
   </script>
</c:if>
	<c:set var="myUserId" value="loggedInUserId" />
	<c:set var="myPicture" value="loggedInUserPicture" />
	<c:set var="myNickname" value="loggedInUserNickname" />
	<c:set var="myRegDate" value="loggedInUserRegDate" />
	<c:set var="myVote" value="loggedInUserVote" />
	<c:choose>
		<c:when test="${sessionScope[myUserId] != user.ID}">
			<c:redirect url="UserCV?privateId=${user.ID}"/>	
		</c:when>
		<c:when test="${sessionScope[myUserId] eq user.ID}">
			<c:set var="status" value="false"/>				
		</c:when>
	</c:choose>	
	<c:choose>
		<c:when test="${empty sessionScope[myUserId]}">
		
				 <jsp:include page="logedOut.jsp" />
		</c:when>
		<c:otherwise>
		
			 <jsp:include page="logedIn.jsp" />
		</c:otherwise>
	</c:choose>
	
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<h2>
			<spring:message code="label.userTitle" />:
		</h2>
		<hr style="margin-bottom: 20px; margin-top: 5px;">
	</div>
	<div class="col-md-3"></div>
</div>	
<div align="center">
	<div class="container">
            <form:form action="UpdateUser" modelAttribute="user" method="POST" enctype="multipart/form-data">
			<!-- need to associate this data with user id -->
			<form:hidden path="ID"/>
			<!-- Check the user is logged in user? -->
			<div class="row">
	           <div class="col-lg-5">
				<c:choose>
					<c:when test="${not empty userImage }">
	                      <img class="bigImg" alt="No image" src="data:image/jpeg;base64,${userImage }">
	                      <br>
	                      <b style="white-space: nowrap; font-size: 3rem;"><label>${user.NICKNAME }</label></b>
					</c:when>	
					<c:otherwise>
	                       <img class="bigImg" alt="No image" src="${pageContext.request.contextPath}/resources/images/nouser.jpg">
	                       <br>
	                       <b style="white-space: nowrap; font-size: 3rem;"><label>${user.NICKNAME }</label></b>
					</c:otherwise>	
				</c:choose>
	        </div>
         	<div class="col-lg-7">
                        
                                <!-- HIDDEN PARAMS -->
				<%String previousUrl = request.getHeader("Referer"); 
						pageContext.setAttribute("previousUrl", previousUrl);%>
				<input type="hidden" name="from" value="${previousUrl}">
				<!-- ---------------------------------------------------------- -->
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="firstname"><spring:message
									code="label.firstName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FIRSTNAME" type="text" class="form-control"
								id="firstname" maxlength="50" required="required" />
						</div>
					</div><br/>
                    <div class="row">
						<div class="col-md-2">
							<label class="control-label" for="lastname"><spring:message
									code="label.lastName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="LASTNAME" type="text" class="form-control"
								id="lastname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="nickname"><spring:message
									code="label.nickName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="NICKNAME" type="text" class="form-control"
								id="nickname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="email"><spring:message
									code="label.email" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="EMAIL" type="email" class="form-control"
								id="email" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="psw">
							<spring:message code="label.password" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="PASSWORD" type="password" class="form-control"
								id="psw" title="Include uppercase and lowercase letter!"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" style="z-index: 0;"
								required="required" placeholder="Must have at least 6 characters" data-toggle="password"/>
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
							<label class="control-label" for="birtdate"><spring:message
									code="label.birthday" />:</label>
						</div>
						<div class="col-md-6">
							<div class='input-group date' id='datepicker'>
								<form:input type='text' path="BIRTHDAY" class="form-control" required="required"
								pattern="\d{1,2}.\d{1,2}.\d{4}" placeholder="dd.mm.yyyy" style="z-index:0;"/>
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-2">
							<label class="control-label" for="lng"><spring:message
									code="label.fav_language" />:</label>
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
					</div> <br>
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
										<span class="glyphicon glyphicon-ok"></span> Update
									</button>
								</div>
							</div>
						</div>
					</div>		
				 	</div>
			 	</div>
			</form:form>
		
                 <div class="row">
					<div class="col-md-8 col-md-offset-2">
						<hr>
					</div>
				</div>

			<div class="row">
				<div class="col-lg-10 col-lg-offset-1">
					<div class="col-lg-6">
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb" style="background-color: #0095ff; color: white;">
								<li>
									<h3>
										<b>Update your password</b>
									</h3>
								</li>
							</ol>
						</nav>
						<hr>
						<form:form action="UpdatePassword" modelAttribute="user" method="POST">
							<form:hidden path="ID" />
							<div class="row">
								<div class="col-md-4">
									<label>Old password:</label>
								</div>
								<div class="col-md-8">
									<form:input path="PASSWORD" type="password" class="form-control" id="psw"
									title="Include uppercase and lowercase letter!"
									pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" style="z-index: 0;"
									required="required" placeholder="Must have at least 6 characters" data-toggle="password"/>
								</div>
							</div> <br>
							<div class="row">
								<div class="col-md-4">
									<label>New <spring:message code="label.password" />:</label>
								</div>
								<div class="col-md-8">
									<input name="newPsw" type="password" class="form-control" 
									title="Include uppercase and lowercase letter!"
									pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" value="${PASSWORD}" style="z-index: 0;"
									required="required" placeholder="Must have at least 6 characters" data-toggle="password"/>
								</div>
							</div> <br>
							<div class="row">
								<div class="col-md-4">
									<label>Cnf. <spring:message code="label.password" />: </label>
								</div>
								<div class="col-md-8">
									<input name="confirmPsw" type="password" class="form-control"
									title="Include uppercase and lowercase letter!"
									pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" style="z-index: 0;"
									required="required" placeholder="Must have at least 6 characters" data-toggle="password"/>
								</div>
							</div> <br>	
							<div class="row">
								<div class="col-md-12" style="text-align: center;">
									<button type="submit" class="btn btn-info btn-block" >
										<span class="glyphicon glyphicon-cog"></span> Update password
									</button>
								</div>
							</div>
						</form:form>
					</div>
					<div class="col-lg-6" id="danger-zone">
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb" style="background-color: #e81070; color: white;">
								<li>
									<h3>
										<b>Delete your account</b>
									</h3>
								</li>
							</ol>
						</nav>
						<hr>
						<c:url var="DeleteAccount" value="/DeleteAccount">
							<c:param name="ID" value="${user.ID}" />
						</c:url>
						<!-- <input type="hidden" name="ID" value="${user.ID}"/> -->
							<div class="row">
								<div class="col-md-12">
									<label>Are you sure ?</label> 
									<p style="font-size: 14px; text-align: left;">
											User deletion is irreversible!
											Deleting your user account or by sending this request, 
											your votes will be revoked, and all
											of your content will be made anonymous.
									</p>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="text-align: center;">
									<button type="button" onclick="deleteAccount();" id="delete-btn" class="btn btn-danger btn-block">
										<span class="glyphicon glyphicon-trash"></span> Delete account
									</button>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div><!-- CONTAINER END -->
	</div>

	<!-- JSUT FOR CLEAR AND GIVE SOME SPACE -->
	<div class="row">
		<div class="col-lg-12">
			<div style="padding-top: 100px;"> </div>
		</div>
	</div> 
	
	<jsp:include page="footer.jsp" />
	<script type="text/javascript">
            $("#password").password('toggle');

		function deleteAccount() {
			swal({
				  title: "Are you sure?",
				  text: "Are you sure you want to delete this account?",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "Yes, delete it!",
				  cancelButtonText: "No, cancel plx!",
				  closeOnConfirm: false,
				  closeOnCancel: false
				},
				function(isConfirm){
				  if (isConfirm) {
					  window.location.href='${DeleteAccount}'; return false;
				  } else {
				    swal("Cancelled", "Your imaginary account is safe :)", "error");
				  }
				});
		}
	</script>
</body>
</html>