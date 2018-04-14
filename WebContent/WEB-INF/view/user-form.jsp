<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>User CV - Java Arabic Community</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.datetimepicker.css">
	<!-- BOOTSTRAP DEPENDENCIES -->
	<script src="resources/jquery/3.2.1/jquery.min.js"></script>
	<script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<!-- BOOTSTRAP DEPENDENCIES END-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <!--show password js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-show-password.min.js"></script>
    <style type="text/css">.col-md-3 {text-align: right;}</style>    
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
<!-- HANDLE ALL MESSAGES COMING FROM BACKEND -->
<c:if test="${not empty error}">
	<script type="text/javascript">
		sweetAlert("${headerError}", "${error}", "error");
	</script>
</c:if>
<c:if test="${not empty message}">
	<script type="text/javascript">
		sweetAlert('Excellent!','${message}', 'success');
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
		<!-- NAVIGATIONBAR STARTED -->
	<div class="container">  
		<div class="col-lg-10 col-lg-offset-1" id="base-row">
			<div class="row" style="margin-top:15px;">
				<div class="row">
		    		<div class="col-lg-10 col-lg-offset-1">
		    		<ul class="nav nav-tabs">
					    <li class="active">
                                <a class="href-link" onclick="location.reload();" title="Refresh the page." style="cursor: pointer;">
								<b>Member profile :</b>
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
    			<div class="col-xm-10 col-sm-10 col-md-10 col-lg-10 col-md-offset-1">
    				<div class="alert alert-info">
    					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					  	<strong>New feature!</strong> Create your own <a href="ResumeBuilder" class="alert-link">resume</a>. and download it.
					</div>
    			</div>
    		</div>
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<h2>
						<spring:message code="label.userTitle" />:
						<span style="float: right;"><button class="btn btn-default" onclick="window.location.href='ResumeBuilder'"
						>J.A.C. Resume builder</button> </span>
					</h2>
					<hr style="margin-bottom: 20px; margin-top: 5px;">
				</div>
			</div>	
	<div align="center">
            <form:form action="UpdateUser" modelAttribute="user" method="POST" enctype="multipart/form-data">
			<!-- need to associate this data with user id -->
			<form:hidden path="ID"/>
			<form:hidden path="PASSWORD"/>
			<!-- Check the user is logged in user? -->
			<div class="row">
	           <div class="col-lg-3 col-lg-offset-1">
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
         	<div class="col-lg-8">
                        
                <!-- HIDDEN PARAMS -->
				<%String previousUrl = request.getHeader("Referer"); 
						pageContext.setAttribute("previousUrl", previousUrl);%>
				<input type="hidden" name="from" value="${previousUrl}">
				<!-- ---------------------------------------------------------- -->
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="firstname"><spring:message
									code="label.firstName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FIRSTNAME" type="text" class="form-control"
								id="firstname" maxlength="50" required="required" />
						</div>
					</div><br/>
                    <div class="row">
						<div class="col-md-3">
							<label class="control-label" for="lastname"><spring:message
									code="label.lastName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="LASTNAME" type="text" class="form-control"
								id="lastname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="nickname"><spring:message
									code="label.nickName" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="NICKNAME" type="text" class="form-control"
								id="nickname" maxlength="50" required="required" />
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="email">
							<spring:message code="label.email" />:</label>
						</div>
						<div class="col-md-6">
							<div class='input-group'>
								<form:input path="EMAIL" type="email" class="form-control" id="email" style="z-index:0;"/>
								<span class="input-group-addon"> 
										<span class="glyphicon glyphicon-envelope"></span>
								</span>
							</div>
						</div>
					</div><br/>
					<div class="row">
						<div class="col-md-3">
							<label class="control-label" for="birtdate"><spring:message
									code="label.birthday" />:</label>
						</div>
						<div class="col-md-6">
							<div class='input-group date' id='datepicker'>
								<form:input type='text' path="BIRTHDAY" class="form-control" id="datetimepicker" style="z-index:0;"/>
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
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
							<label class="control-label" for="lng"><spring:message
									code="label.fav_language" />:</label>
						</div>
						<div class="col-md-6">
							<form:input path="FAV_PROG_LANG" type="text" class="form-control"
								id="lng" placeHolder="Java,C++,Python" required="required" />
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
							<form:textarea class="form-control" path="ABOUT" id="comment" required="required"/>
						</div>
					</div>
                 </div>
                </div> 
                 <div class="row" style="margin: 10px;">
				 	 <div class="col-lg-8 col-lg-offset-2" style="float: none;">
						<div class="row">
							<div class="col-md-8">
								<button class="btn btn-info" type="reset" style="width:150px;">
											<span class="glyphicon glyphicon-trash"></span> Clear
								</button>
								<button class="btn btn-success" type="submit" style="width:150px;">
									<span class="glyphicon glyphicon-ok"></span> Update
								</button>
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

			<div class="row" style="margin-bottom:20px;">
				<div class="col-lg-12">
					<div class="col-lg-6">
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb" style="background-image: linear-gradient(#31b0d5, #269abc); color: white;">
								<li>
									<h3>
										<b>Update your password</b>
									</h3>
								</li>
							</ol>
						</nav>
						<hr>
						<form action="UpdatePwdForm" method="POST">

							<div class="row">
								<div class="col-md-4">
									<label>New <spring:message code="label.password" />:</label>
								</div>
								<div class="col-md-8">
									<input name="newPsw" type="password" class="form-control" 
									title="Include uppercase and lowercase letter!"
									pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" style="z-index: 0;"
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
						</form>
					</div>
					<div class="col-lg-6" id="danger-zone">
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb" style="background-image: linear-gradient(#c9302c, #ac2925); color: white;">
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
									<p class="danger-paragraph">
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
			</div>
		</div>
	</div>
	<!-- JSUT FOR CLEAR AND GIVE SOME SPACE -->
		<div class="row">
			<div class="col-lg-12">
				<div style="padding-top: 100px;"> </div>
			</div>
		</div> 
	<jsp:include page="footer.jsp" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.datetimepicker.full.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
    		 
    		 $("#password").password('toggle');  
    		 
    		 $("#datetimepicker").datetimepicker({format: 'd.m.Y'},{timepicker:false},{closeOnDateSelect:true});

		});

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