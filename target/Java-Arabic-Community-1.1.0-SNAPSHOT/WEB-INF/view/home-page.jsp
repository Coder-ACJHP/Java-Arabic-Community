<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.apache.commons.codec.binary.Base64"%>
<!DOCTYPE html>
<html>

<head>
    <title>Questions - Java Arabic Community</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
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
<c:if test="${not empty message}">
   <script type="text/javascript">
       swal("${message}")
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

<!-- BIG JOMBOTRON START HERE-->
	<div class="container">
		<div class="row">
			<div class="col-lg-11 col-lg-offset-1" id="fragment">
				<div class="row">
					<div class="d-flex justify-content-end" style="margin-right:10px;">
						<span id="close" onclick="document.querySelector('#fragment').remove();" >Dismiss</span>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-8 col-lg-offset-2" >
						<div class="gredient-text">
							<img src ="${pageContext.request.contextPath}/resources/images/Logo.png" alt="some description"/>
							<label>Welcome to Java Arabic Community<br>Questions &amp; Answers website</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-8 col-lg-offset-2" style="text-align: center; font: 15px verdana;">
						<spring:message code="label.welcomeText"/>
					</div>
				</div>
				<div class="row">
					<br>
					<div class="col-lg-5 col-lg-offset-4">
						<div style="margin-left: 10%;">
							<input class="btn btn-info" type="button" value="Sing Up" 
							onclick="window.location.href = 'SignUp'">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- BIG JOMBOTRON END -->
    
    
    
    	
    	<div class="row">
    		<div class="col-lg-9 col-lg-offset-2">
				<div class="col-sm-2">
					<c:choose>
						<c:when test="${not empty Label}">
							<p style="font-size: 18px; min-width: 150px;">
								<b>${Label} :</b>
							</p>
						</c:when>
						<c:otherwise>
							<p style="font-size: 18px; min-width: 150px;">
								<b><spring:message code="label.allQuestions" /> :</b>
							</p>
						</c:otherwise>
					</c:choose>
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
       

<!-- The main table starting from here!-->	

   <div class="container">
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
								<c:param name="answerUserId" value="${tempQuestionsList.USERID}" />
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
									<label class="card-text" id="question-ex"  >${tempQuestionsList.QEXPLAIN}</label><sup>...</sup>
								</div>
							</div>

							<div class="row"></div>

							<!-------------------- BOTTOM IS O.K.---------------------->
							<div class="row" style="margin-top: 10px;">
								<div class="col-md-8">
									<c:forTokens items="${tempQuestionsList.TAGS}" delims=" " var="tags">
										<a class="tags" target="_blank">${tags}</a>
									</c:forTokens>
								</div>
								<div class="col-md-4">
									<div class="row">
										<c:set var="userCount" value="${0 }" />
										<c:forEach var="map" items="${userMap }">
											<c:if test="${map.key['ID'] eq  tempQuestionsList.USERID}">
												<c:set var="userCount" value="${userCount+1 }" />
												<c:if test="${userCount eq 1 }">
													<div class="col-sm-4">
														<img class="img" alt="No image" src="data:image/jpeg;base64,${map.value}">
													</div>
													<div class="col-sm-8" style="font-size: 11px;">
														<div class="row">
															<a href="${User}" style="font-size: 13px;">${map.key['NICKNAME'] }
															<span class="badge" style="color: gold;">&#9813; ${map.key['VOTE']}</span></a> <span
																style="float: left; width: 120px;">asked : ${tempQuestionsList.CREATIONDATE}</span>
														</div>
													</div>
												</c:if>
											</c:if>
										</c:forEach>
										<c:set var="userCount" value="${0}" />
									</div>
								</div>
							</div>
						</div>
					</div> <!-- CARD BLOCK -->
		        </div> <!-- CARD -->
      </c:forEach> <!-- LOOP -->
    </div><!-- ROW -->
  </div>
  
<!-- main table finished! -->
    <div class="container" style="margin-bottom: 100px; font-family: verdana;">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2" style="font-size: 22px; text-align:center;">
                <p>Total Question(s):  <span class="badge" style="color: #cdf02d; font-size: 22px;">
                <c:out value="${questionCount}"></c:out></span></p>
            </div>
        </div>
    <!--WE NEED TO SOME SPACE-->
        <div class="row"><div class="col-lg-10"></div></div>
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1" style="font-size:20px; text-align:center;">
                <p>
                    Not the question you're looking for? Browse other questions or 
                    <a href="Question-form">ask your own question.</a>
                </p>
            </div>
        </div>
    </div>
<jsp:include page="footer.jsp" />
</body>
</html>