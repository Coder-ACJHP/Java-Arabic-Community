<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>User CV - Java Arabic Community</title>
	<!-- BOOTSTRAP DEPENDENCIES -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <!-- BOOTSTRAP DEPENDENCIES END-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css" media="all" />

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
	<c:set var="myUserId" value="loggedInUserId" />
	<c:set var="myNickname" value="loggedInUserNickname" />
	<c:choose>
		<c:when test="${empty sessionScope[myUserId]}">
		
				 <jsp:include page="logedOut.jsp" />
		</c:when>
		<c:otherwise>
		
			 <jsp:include page="logedIn.jsp" />
		</c:otherwise>
	</c:choose>
	
	<!-- NAVIGATIONBAR STARTED -->
   			<div class="row">
    			<div class="col-lg-10 col-lg-offset-2">
				<div class="col-sm-2">
					<p style="font-size: 18px; min-width: 150px;"><b>Member profile :</b></p>
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
		<div class="col-lg-7 col-lg-offset-3">
			<div class="row">
				<div class="col-md-12">
					<h2>
						Profile :
					</h2>
					<hr style="margin-bottom: 20px; margin-top: 5px;">
				</div>
			</div>	
			
			<div class="row">
				<div class="col-md-3">
					<img class="cvImg" alt="No image" src="data:image/jpeg;base64,${profilePicture }">
					<h5><span class="badge" style="color: gold;">${users.VOTE}</span> <b>REPUTATION</b></h5>
				</div>
				<div class="col-md-5">
					<div class="col-lg-12">
						<div class="row">
							<label style="font-size: 25px;"><b>${users.NICKNAME}</b></label>
							<p style="color:rgb(145,153,161); font-size: 15px;">${users.ABOUT}</p>
						</div>
						<div class="row">
							<div style="margin-top: 60px;"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<form:form action="AddUserComment" modelAttribute="userComment" method="POST">
								<form:hidden path="USERID" value="${users.ID}" />								
								 <form:hidden path="COMMENTEDBY" value="${sessionScope[myNickname] }" />
								 
								<div class="input-group">
									<form:input type="text" path="COMMENT" class="form-control" placeHolder="Write something about ${users.NICKNAME}" required="required" />
									<div class="input-group-btn">
										<button class="btn btn-default" type="submit" title="Send comment" style="margin-top: 0px;"
											onclick="if ('${sessionScope[myUserId]}' > 0) { document.getElementById('theForm').submit();
		                                                       } else {window.location.href = 'SignIn'}; return false;">
											<i class="glyphicon glyphicon-send"></i>
										</button>
									</div>
								</div>
							</form:form>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12" style="margin-top: 5px;">
							<button class="btn btn-info" type="button" data-toggle="modal" data-target="#myModal">
								<span class="glyphicon glyphicon-th-list"></span> Show all comments
							</button>
							<div class="container">
								<!-- Modal -->
							  <div class="modal fade" id="myModal" role="dialog">
							    <div class="modal-dialog">
							    
							      <!-- Modal content-->
							      <div class="modal-content">
							        <div class="modal-header">
							          <button type="button" class="close" data-dismiss="modal">&times;</button>
							          <h4 class="modal-title">${users.NICKNAME}'s comments</h4>
							        </div>
							        <div class="modal-body">
							          <c:forEach items="${ucommentsList}" var="item">
							          	<p><span class="glyphicon glyphicon-star" style="color:gold;"></span> ${item.COMMENT}<span style="color:#c96295;"><b><i> ${item.COMMENTEDBY}</i></b></span></p>
							          </c:forEach>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4" style="text-align: center;">
					<div class="row">
						<div class="col-sm-4">
							<span class="badge" style="color: #cdf02d;">${users.ANSWERCOUNT }</span>
						</div>
						<div class="col-sm-4">
							<span class="badge" style="color: #cdf02d;">${users.QUESTIONCOUNT }</span>
						</div>
						<div class="col-sm-4">
							<b>${users.REGISTERDATE }</b>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							answer(s)
						</div>
						<div class="col-sm-4">
							question(s)
						</div>
						<div class="col-sm-4">
							since
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4>
						Top post(s) :
					</h4>
					<hr style="margin-bottom: 20px; margin-top: 5px;">
				</div>
			</div>
			<div class="row">
				<c:set var="count" value="${0}" />
				<c:forEach var="tempQuestionsList" items="${questionList}">
					<div class="col-lg-8 col-lg-offset-2" id="questionCardRow">
						<div class="card-block">
							<div class="col-md-1 center-block" style="margin-top: 20px;">
								<c:url var="Question" value="/Question">
									<c:param name="questionId" value="${tempQuestionsList.ID}" />
								</c:url>
								<c:url var="User" value="/Users">
									<c:param name="answerUserId"
										value="${tempQuestionsList.USERID}" />
								</c:url>
								<div class="counter">
									<br>
									<c:out value="${tempQuestionsList.VOTE }" />
									<br>
									<spring:message code="label.votes" />
								</div>
								<c:forEach var="answeres" items="${answerList}">
									<c:if test="${tempQuestionsList.ID eq answeres.QUESTIONSID }">
										<c:set var="count" value="${count+1 }" />
									</c:if>
								</c:forEach>
								<c:choose>
									<c:when test="${tempQuestionsList.ISANSWERED }">
										<div class="counter1">
											<br>
											<c:out value="${count }" />
											<br>
											<spring:message code="label.answers" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="counter2">
											<br>
											<c:out value="${count }" />
											<br>
											<spring:message code="label.answers" />
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<!-- ---------------------------------------UP IS O.K.---------------------------------------------------- -->
							<div class="col-md-11 center-block">

								<div class="row">
									<div class="col-lg-12">
										<!-- INITIALIZE COUNTER -->
										<c:set var="count" value="${0 }" />

										<!-- SET THE QUESTION HEADER OF THE CARD -->
										<div class="card-header">
											<a class="question-a" href="${Question}">${tempQuestionsList.QUESTIONS}</a>
										</div>

										<!-- CARD QUESTION EXPLANATION -->
										<label class="card-text" id="question-ex">${tempQuestionsList.QEXPLAIN}</label><sup>...</sup>
									</div>
								</div>

								<div class="row"></div>

								<!-------------------- BOTTOM IS O.K.---------------------->
								<div class="row" style="margin-top: 10px;">
									<div class="col-md-8">
										<c:forTokens items="${tempQuestionsList.TAGS}" delims=" "
											var="tags">
											<a class="tags" target="_blank">${tags}</a>
										</c:forTokens>
									</div>
								</div>
							</div>
						</div>
						<!-- CARD BLOCK -->
					</div>
					<!-- CARD -->					
				</c:forEach>
				<!-- LOOP -->
			</div>
			<!-- ROW -->
		</div><!-- MAIN COL END -->
	</div><!-- ROW COL END -->
	<div style="margin-top: 150px;">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>

