<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>${question.QUESTIONS }</title>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    
    <script src="${pageContext.request.contextPath}/resources/js/prism.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/prism.css">
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    
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
 <c:if test="${not empty question_error}">
    <script type="text/javascript">
        swal("${message}");
    </script>
</c:if>  
<c:if test="${not empty error}">
		<script type="text/javascript">
			sweetAlert("${headerError}", "${error}", "error");
		</script>
</c:if>

	<!-- GET USER ID FROM SESSION-->
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


	<div class="container">            	    	
    	<div class="row">
    		<div class="col-lg-10 col-lg-offset-1">
				<div class="col-sm-2">
					<p style="font-size: 18px; min-width: 150px;"><b>Question : ${question.ID}</b></p>
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
    		<div class="col-lg-11 col-lg-offset-2">
    			<hr>
    		</div>
    	</div>


		<!--  NAVIGATION BUTTONS FINISHED HERE...  -->
		<c:url var="User" value="/Users">
			<c:param name="answerUserId" value="${question.USERID}" />
		</c:url>
		<c:url var="Question" value="/UpdateQuestion">
			<c:param name="questionId" value="${question.ID}" />
		</c:url>
		<c:url var="deleteQuestion" value="/DeleteQuestion">
			<c:param name="questionId" value="${question.ID}" />
		</c:url>
		<c:url var="upVote" value="/UpVoteQuestion">
			<c:param name="questionId" value="${question.ID}" />
			<c:param name="qUserId" value="${question.USERID}" />
		</c:url>
		<c:url var="downVote" value="/DownVoteQuestion">
			<c:param name="questionId" value="${question.ID}" />
			<c:param name="qUserId" value="${question.USERID}" />
		</c:url>



	<div class="row">	
       <div class="col-lg-8 col-lg-offset-2">
           <div class="row">	
				<div class="col-sm-1">
                    <input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/upVote.png" id="vote" onclick="if ('${sessionScope[myUserId]}' <= 0) { window.location.href = 'SignIn'} else {  window.location = '${upVote}';  }"/>
					<br>
					<label style="float: left; margin-left: 17px;"><c:out value="${question.VOTE }" /></label>
					<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/downVote.png" id="vote" onclick="if ('${sessionScope[myUserId]}' <= 0) {window.location.href = 'SignIn' } else {  window.location = '${downVote}'; }"/>
				</div><!-- END OF VOTE BUTTONS -->
				<div class="col-sm-11">
					 <label style="font-size: 2rem;">${question.QUESTIONS }</label>
                     <p style="max-width: 700px;">${question.QEXPLAIN }</p>
				</div>
           </div> 
           <div class="row"> <!--EDIT & DELETE BUTTONS-->
           		<div class="col-md-10">
           			<div class="question-td">
                        <c:if test="${question.USERID==sessionScope[myUserId]}">
                            <a class="editlink" href="${Question }">Edit</a>
                        </c:if>
                	</div>
                </div>	
           </div>         
           <div class="row">
           	   <div class="col-md-10">
                    <div class="question-td">
                        <c:if test="${question.USERID==sessionScope[myUserId]}">
                            <a class="editlink" id="delete-qstn" >Delete</a>
                        </c:if>
                    </div>
           		</div>
           </div>
           <div class="row">
	           <div class="col-sm-12">
	           		&nbsp;
	           </div>
           </div>
           <div class="row">
           		<!-- CREATE LINK FOR USE IT WITH ATTRIBUTE -->
           		<%String address = "http://java-arabic-community.herokuapp.com/Question" + "?" + request.getQueryString();
                  pageContext.setAttribute("address", address);
               	%>
           		<!------------------------------------------->
           		<!-- SHARING BUTTONS -->
           	    <div class="col-lg-1">
           	    	<a href="https://plus.google.com/share?url=${address}" target="_blank"> 
                       <img src="https://simplesharebuttons.com/images/somacro/google.png" alt="Google" class="share-link"/> 
                    </a><br>
                    <a href="http://www.linkedin.com/shareArticle?mini=true&amp;url=${address}" target="_blank">
                       <img src="https://simplesharebuttons.com/images/somacro/linkedin.png" alt="LinkedIn" class="share-link"/>
                    </a><br>
                    <a href="http://www.facebook.com/sharer.php?u=${address}" target="_blank">
                       <img src="https://simplesharebuttons.com/images/somacro/facebook.png" alt="Facebook" class="share-link"/>
                    </a>
           	    </div>
           	    <!-- TAG BUTTONS -->
           	    <div class="col-lg-7">
           	    	<c:forTokens items = "${question.TAGS}" delims = " " var = "tags">
                        <a class="tags" target="_blank">${tags}</a>
                    </c:forTokens>
           	    </div>	
           	    <!-- USER DETAILS -->
           	    <div class="col-lg-4">
           	    	<div class="row">
           	    		<div class="col-sm-3" >
                        <img class="img" alt="No image" src="data:image/jpeg;base64,${askerImage}">
                    </div>
                    <div class="col-sm-9" style="font-size: 11px;">
                        <div class="row">
                        	<div class="col-sm-10">
                                <a href="${User}" style="font-size: 13px;">${askerUser.NICKNAME }<span class="badge" style="color: gold;">&#9813; ${askerUser.VOTE}</span></a>
                        	</div>
                        </div>
                        <div class="row">
                        	<div class="col-sm-9">
                        	  <span>asked : ${question.CREATIONDATE}</span>
                        	</div>  
                        </div>
                     </div>
           	    	</div>
           	    </div>	
            </div>                 
		    <hr class="all">
			<div class="row">
				<c:forEach var="comments" items="${commentList }">
                    <div class="col-sm-10 col-sm-offset-1">
						<p class="commentPre">
                       		 ${comments.COMMENT}-<a class="userLink" target="_blank">${comments.USERNICKNAME }</a> ${comments.CREATIONDATE}
                    	</p>
                    	<hr class="all">                    
                    </div>
                </c:forEach>
			</div>	           
   		</div><!-- END OF FIRST COL LG 8 -->                     
    </div><!-- END OF FIRST ROW -->   
    <!-- ADD COMMAND TO QUESTION -->
	<form:form action="questionComment" modelAttribute="qcomment" method="POST">
		<form:hidden path="QUESTIONID" value="${question.ID }" />
		<form:hidden path="USERNICKNAME" value="${sessionScope[myNickname] }" />
		<div class="col-lg-6 col-lg-offset-3">
			<div class="input-group input-group-lg" style="z-index: 0;">
				<form:input type="text" path="COMMENT" class="form-control"
					rows="5" placeHolder="Entry your comment here." required="required" />
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit"
							onclick="if ('${sessionScope[myUserId]}' > 0) { document.getElementById('theForm').submit();} else {window.location.href = 'SignIn'}; return false;"
							style="margin-top: 0px;">
						<i class="glyphicon glyphicon-send"></i>
					</button>
				</div>
			</div>
		</div>
	</form:form>
	<!-- JUST FOR SOME WHITE SPACE -->
    <div class="row"><div class="col-lg-12"><br/>&nbsp;<br/>&nbsp;&nbsp;</div></div>
<!--------- ANSWERS STARTING HERE ----------->
		<c:set var="counter" value="0"/>
		<c:forEach var="tempAnswerList" items="${answerList}" varStatus="loop">
			<c:if test="${tempAnswerList.ISACCEPTED eq true}">
				<c:set var="counter" value="${counter + 1}" />
			</c:if>
			<c:url var="Answer" value="/EditAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
			</c:url>
			<c:url var="DeleteAnswer" value="/DeleteAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
				<c:param name="questionId" value="${question.ID}" />
			</c:url>
			<c:url var="AnswerUser" value="/Users">
				<c:param name="answerUserId" value="${tempAnswerList.USERID}" />
			</c:url>
			<c:url var="upVoteAnswer" value="/UpVoteAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
				<c:param name="questionId" value="${question.ID}" />
				<c:param name="respondedId" value="${tempAnswerList.USERID}" />
			</c:url>
			<c:url var="downVoteAnswer" value="/DownVoteAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
				<c:param name="questionId" value="${question.ID}" />
				<c:param name="respondedId" value="${tempAnswerList.USERID}" />
			</c:url>
			<c:url var="acceptAnswer" value="/AcceptAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
				<c:param name="questionId" value="${question.ID}" />
				<c:param name="answerOwnerId" value="${sessionScope[myUserId]}" />
			</c:url>
	<div class="row">
    	<div class="col-lg-8 col-lg-offset-2">
    		<h4> Answer : <c:out value="${loop.index +1 }" /></h4>
			<hr>
			<div class="row">
				<div class="col-lg-1" style="margin-top:30px;">
					<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/upVote.png"
						id="vote" onclick="if ('${sessionScope[myUserId]}' <= 0) {window.location.href = 'SignIn'} else {window.location = '${upVoteAnswer}'}" />
					<br> 
					<label style="float: left; margin-left: 18px;"><c:out value="${tempAnswerList.VOTE }" /></label> 
					<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/downVote.png" id="vote"
						onclick="if ('${sessionScope[myUserId]}' <= 0) {window.location.href = 'SignIn'} else {window.location = '${downVoteAnswer}';}" />
					<c:choose>
						<c:when test="${tempAnswerList.ISACCEPTED}">
							<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/Correct.png" id="vote" />
						</c:when>
					<c:otherwise>
						<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/Gray-correct.png" id="vote"
							onclick="if ('${sessionScope[myUserId]}' <= 0) { if (swal('You must be logged In for doing this!'))
                            {  window.location.href = 'SignIn' } else { return false; } } else { window.location = '${acceptAnswer}' }" />
					</c:otherwise>
					</c:choose>
						<c:if test="${! empty errorOne}">
							<script type="text/javascript">
                                 swal("Oops!", "This is not your own question!", "error");
                            </script>
						</c:if>
						<c:if test="${! empty errorTwo}">
							<script type="text/javascript">
                                  sweetAlert('Every question can only be one correct answer!');
                             </script>
						</c:if>
				</div>
				<div class="col-lg-11">
					<p>${tempAnswerList.ANSWER}</p>
				</div>
			</div>
			<div class="row">
				<div class="col-md-10">
					<div class="question-td">
						<c:if test="${tempAnswerList.USERID==sessionScope[myUserId]}">
							<a class="editlink" href="${Answer }">Edit</a>
						</c:if>
					</div>
				</div>
			</div>	
			<div class="row">		
				<div class="question-td">
					<div class="col-md-10">
						<c:if test="${tempAnswerList.USERID==sessionScope[myUserId]}">
							<a class="editlink" id="delete-answr">Delete</a>
						</c:if>
					</div>		
				</div>
			</div>	
		</div>
	</div>
	<div class="row">
		<div class="col-lg-8"></div>
		<div class="col-lg-3">
			<div class="row">
				<c:forEach var="userInfoMap" items="${userMap}" varStatus="status">
				<c:if test="${userInfoMap.key['ID'] == tempAnswerList.USERID}">
					<div class="col-sm-3">
						<img class="img" alt="No image" src="data:image/jpeg;base64,${userInfoMap.value }">
					</div>
					<div class="col-sm-8" style="font-size: 11px;">
						<div class="row">
							<a href="${AnswerUser}" style="font-size: 13px;">${userInfoMap.key['NICKNAME']  }
							<span class="badge" style="color: gold;">&#9813; ${userInfoMap.key['VOTE']}</span>
							</a> <span style="float: left; max-width: 200px; width: 150px;">answered : ${tempAnswerList.CREATIONDATE}</span>
						</div>
					</div>
				</c:if>
				</c:forEach>
			</div>
		</div>	
	</div>
	<div class="row">
		<div class="col-sm-10 col-sm-offset-3">
			<hr>
			<c:forEach var="map" items="${acommentList }" >
				<c:if test="${ tempAnswerList.ID == map.key}">
					<c:forEach var="item" items="${ map.value}" varStatus="loop">
						<p class="commentPre">${item.COMMENT}-
							<a class="userLink" href="${User}">${item.USERNICKNAME }</a> ${item.CREATIONDATE}
						</p>
					</c:forEach>
				</c:if>
			</c:forEach>
		</div>
	</div>
		<form:form action="answerComment" modelAttribute="acomment" method="POST">
			<form:hidden path="ANSWERID" value="${tempAnswerList.ID}" />
			<form:hidden path="USERNICKNAME" value="${sessionScope[myNickname] }" />
		<div class="col-lg-6 col-lg-offset-3">
			<div class="input-group input-group-lg" style="z-index: 0;">
				<form:input type="text" path="COMMENT" class="form-control" rows="5" placeHolder="Entry your comment here." required="required" />
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit"
						onclick="if ('${sessionScope[myUserId]}' > 0) { document.getElementById('theForm').submit();
		                                         } else {window.location.href = 'SignIn'}; return false;"
						style="margin-top: 0px;">
						<i class="glyphicon glyphicon-send"></i>
					</button>
				</div>
			</div>
		</div>
			<c:if test="${not empty answer_error}">
				<div class="alert alert-danger alert-dismissible" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<strong>Warning!</strong>
					<c:out value="${answer_error}" />.
				</div>
			</c:if>
		</form:form>
	</c:forEach>
	<!-- JUST FOR SOME WHITE SPACE -->
    <div class="row"><div class="col-lg-12">&nbsp;&nbsp;&nbsp;</div></div>
	<c:choose>
		<c:when test="${not empty sessionScope[myUserId]}">
				<div class="row">
					<div class="col-lg-5 col-lg-offset-3">
						<h4 style="color: #0c5790">Your Answer :</h4>
						<hr>
					</div>
					<div class="row">
						<div class="col-lg-6 col-lg-offset-3">
							<form:form action="AddAnswer" modelAttribute="answer"
								method="POST">
								<form:hidden path="USERID" value="${sessionScope[myUserId]}" />
								<form:hidden path="QUESTIONSID" value="${question.ID }" />

								<textarea id="mytextarea" name="ANSWER">Write your answer here!</textarea>

								<hr
									style="border: none; border-top: 1px dotted #808285; color: #808285; background-color: #fff; height: 1px; opacity: 0.4;">

								<div class="row">
									<div class="col-lg-4">
										<div class="g-recaptcha"
											data-sitekey="6LcWfzsUAAAAABio3CXBPD8l9jeOaWkeToBNOUEP"></div>
										<button type="submit" class="btn btn-primary"
											onclick="if('${sessionScope[myUserId]}' > 0){document.getElementById('theForm').submit();}else{window.location.href='SignIn'};return false;">
											<span class="glyphicon glyphicon-send"></span> Post your
											answer
										</button>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</c:when>
		<c:otherwise>
			<div align="center" class="ex4">
				<h3>
					<input type="hidden" name="from" value="${previousUrl}">
					Please <a href="SignIn">Login</a> or <a href="SignUp">Sign up</a>
					to be able to answer the question!
				</h3>
			</div>
		</c:otherwise>
	</c:choose>
    <div align="center">
         <p style="font-size:18px; margin-bottom: 40px;">
            Not the answer you're looking for? Browse other questions or 
            <a href="Question-form">ask your own question.</a>
         </p>
     </div> 
     <!-- JUST FOR SOME WHITE SPACE -->
     <div class="row"><div class="col-lg-12">&nbsp;&nbsp;&nbsp;</div></div>
</div><!-- CONTAINER -->                

</body>
<jsp:include page="footer.jsp" />
</html>