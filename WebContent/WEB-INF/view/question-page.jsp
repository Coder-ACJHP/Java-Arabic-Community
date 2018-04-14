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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/prism.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    <script src="resources/jquery/3.2.1/jquery.min.js"></script>
    <script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
 <c:if test="${not empty message}">
    <script type="text/javascript">
        swal("${message}");
    </script>
</c:if>  
<c:if test="${not empty error}">
    <script type="text/javascript">
   	swal("Opss..", "${error}", "error");
    </script>
</c:if>

<!-- GET USER ID FROM SESSION-->
<c:set var="myUserId" value="loggedInUserId" />
<c:set var="myNickname" value="loggedInUserNickname" />

<c:choose>
    <c:when test="${empty sessionScope[myUserId]}">
        <jsp:include page="logedOut.jsp" />
        <jsp:include page="login-modal.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="logedIn.jsp" />
    </c:otherwise>
</c:choose>
<div class="container">  
    <div class="row">
	<div class="col-lg-10 col-lg-offset-1" id="base-row">
            <div class="row" style="margin-top:15px;">
    		<div class="col-lg-10 col-lg-offset-1">
    		<ul class="nav nav-tabs">
			    <li class="active">
                    <a href="Question?questionId=${question.ID}" title="Refresh the page." style="cursor: pointer;">
						<b>Question : ${question.ID}</b>
					</a>
			    </li>
			    <li>
			    	<a class="href-link" onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {openModal();};return false;">
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
    		<div class="col-lg-9 col-lg-offset-2">
    			<br><br>
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
			<c:param name="currentUserId" value="${sessionScope[myUserId]}" />
			<c:param name="questionOwnerId" value="${question.USERID}" />
		</c:url>
		<c:url var="downVote" value="/DownVoteQuestion">
			<c:param name="questionId" value="${question.ID}" />
			<c:param name="currentUserId" value="${sessionScope[myUserId]}" />
			<c:param name="questionOwnerId" value="${question.USERID}" />
		</c:url>
		<c:url var="addToFav" value="/AddToFav">
			<c:param name="questionId" value="${question.ID}" />
			<c:param name="userId" value="${sessionScope[myUserId]}" />
		</c:url>
		<c:url var="removeFromFav" value="/RemoveFromFav">
			<c:param name="questionId" value="${question.ID}" />
			<c:param name="userId" value="${sessionScope[myUserId]}" />
		</c:url>


	<div class="row">	
       <div class="col-lg-8 col-lg-offset-2">
           <div class="row">	
				<div class="col-md-1 col-sm-1" style="max-width: 60px;">
                    <input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/upVote.png"
                    		 id="vote" onclick="upVoteQuestion('${sessionScope[myUserId]}','${upVote}');" title="This question is useful"/>
					<br>
					<div class="question-vote-div"><c:out value="${question.VOTE }" /></div>
					<br>
					<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/downVote.png"
							 id="vote" onclick="downVoteQuestion('${sessionScope[myUserId]}','${downVote}');" title="This question is useless"/>
					<br><br>
					<div id="Star"></div>
				</div><!-- END OF VOTE BUTTONS -->
				<div class="col-lg-11">
					 <label style="font-size: 2rem;">${question.QUESTIONS }</label>
                     <p style="max-width: 700px;">${question.QEXPLAIN }</p>
				</div>
           </div> 
           <div class="row"> <!--EDIT & DELETE BUTTONS-->
           		<div class="col-md-10">
           			<div class="question-td">
                        <c:if test="${question.USERID == sessionScope[myUserId]}">
                            <a class="editlink" href="${Question }">Edit</a>
                        </c:if>
                	</div>
                </div>	
           </div>         
           <div class="row">
           	   <div class="col-md-10">
                    <div class="question-td">
                        <c:if test="${question.USERID == sessionScope[myUserId]}">
                            <a class="editlink" onclick="deleteQuestion('${deleteQuestion}');" id="delete-qstn">Delete</a>
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
           	    <div class="col-lg-2 col-md-1">
           	    	<a href="https://plus.google.com/share?url=${address}" target="_blank"> 
                       <img src="${pageContext.request.contextPath}/resources/images/google-plus.png" alt="Google" class="share-link"/> 
                    </a><br>
                    <a href="http://www.linkedin.com/shareArticle?mini=true&amp;url=${address}" target="_blank">
                       <img src="${pageContext.request.contextPath}/resources/images/linkedin.png" alt="LinkedIn" class="share-link"/>
                    </a><br>
                    <a href="http://www.facebook.com/sharer.php?u=${address}" target="_blank">
                       <img src="${pageContext.request.contextPath}/resources/images/facebook.png" alt="Facebook" class="share-link"/>
                    </a>
           	    </div>
           	    <!-- TAG BUTTONS -->
           	    <div class="col-lg-6 col-md-7">
           	    	<c:forTokens items = "${question.TAGS}" delims = " " var = "tags">
                        <a class="tags" target="_blank">${tags}</a>
                    </c:forTokens>
           	    </div>	
           	    <!-- USER DETAILS -->
           	    <div class="col-lg-4 col-md-3">
           	    	<div id="user-rect">
           	    		<img class="img" alt="No image" src="data:image/jpeg;base64,${askerImage}">
					  	<div class="user-title"><a href="${User}">${askerUser.NICKNAME }</a></div><br>
					  	<div class="user-detail">asked : ${fn:substring(question.CREATIONDATE, 0,10)}</div>
					 	<div id="badge-vote">&#9813; <font style="color:black;">${askerUser.VOTE}</font></div>
					</div>
           	    </div>	
            </div>                 
		    <hr class="all">
			<div class="row">
				<c:forEach var="comments" items="${commentList }">
                    <div class="col-sm-11 col-sm-offset-1">
						<p class="commentPre">
                            ${comments.COMMENT}<a class="userLink"><font class="user-detail-comment">${fn:substring(comments.CREATIONDATE, 0,10)} </font>${comments.USERNICKNAME }</a>
                    	</p>
                    </div>
                </c:forEach>
			</div>           
   		</div><!-- END OF FIRST COL LG 8 -->                     
    </div><!-- END OF FIRST ROW -->   
    <!-- ADD COMMAND TO QUESTION -->
	<form:form action="questionComment" modelAttribute="qcomment" method="POST">
		<form:hidden path="QUESTIONID" value="${question.ID }" />
		<form:hidden path="USERNICKNAME" value="${sessionScope[myNickname] }" />
		<div class="col-lg-8 col-lg-offset-2">
			<div class="input-group input-group-lg" style="z-index: 0;">
				<form:input type="text" path="COMMENT" class="form-control" rows="5" placeHolder="Add comment" required="required" />
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit"
							onclick="if ('${sessionScope[myUserId]}' > 0) { document.getElementById('theForm').submit();} else {openModal();}; return false;"
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
				<c:param name="answerOwnerId" value="${tempAnswerList.USERID}" />
				<c:param name="currentUserId" value="${sessionScope[myUserId]}" />
			</c:url>
			<c:url var="downVoteAnswer" value="/DownVoteAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
				<c:param name="answerOwnerId" value="${tempAnswerList.USERID}" />
				<c:param name="currentUserId" value="${sessionScope[myUserId]}" />
			</c:url>
			<c:url var="acceptAnswer" value="/AcceptAnswer">
				<c:param name="answerId" value="${tempAnswerList.ID}" />
				<c:param name="questionId" value="${question.ID}" />
				<c:param name="answerOwnerId" value="${tempAnswerList.USERID}" />
				<c:param name="currentUserId" value="${sessionScope[myUserId]}" />
			</c:url>
	<div class="row">
    	<div class="col-lg-8 col-lg-offset-2">
    		<h4> Answer : <c:out value="${loop.index +1 }" /></h4>
			<hr>
			<div class="row">
				<div class="col-md-1 col-sm-1" style="max-width: 60px;">
					<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/upVote.png"
						id="vote" onclick="upVoteAnswer('${sessionScope[myUserId]}','${upVoteAnswer}')" title="This answer is useful" />
					<br> 
					<div class="answer-vote-div"><c:out value="${tempAnswerList.VOTE}"/></div>
					<br>					
					<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/downVote.png"
					 	id="vote" onclick="downVoteAnswer('${sessionScope[myUserId]}','${downVoteAnswer}')" title="This answer is useless" />
					<c:choose>
						<c:when test="${tempAnswerList.ISACCEPTED}">
							<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/correct.png" id="vote" />
						</c:when>
						<c:otherwise>
						<input class="vote-img" type="image" src="${pageContext.request.contextPath}/resources/images/incorrect.png" id="vote"
							onclick="if ('${sessionScope[myUserId]}' <= 0) {openModal();} else { window.location = '${acceptAnswer}' }" />
						</c:otherwise>
					</c:choose>
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
							<a class="editlink" onclick="deleteAnswer('${DeleteAnswer}');" id="delete-answr">Delete</a>
						</c:if>
					</div>		
				</div>
			</div>	
			<div class="row">
				<div class="pull-right">				
	           	    <div class="col-lg-4 col-md-3">
	           	    	<div id="user-rect">
	           	    		<c:forEach var="userInfoMap" items="${userMap}" varStatus="status">
	           	    			<c:if test="${userInfoMap.key['ID'] == tempAnswerList.USERID}">
			           	    		<img class="img" alt="No image" src="data:image/jpeg;base64,${userInfoMap.value}">
								  	<div class="user-title"><a href="${AnswerUser}">${userInfoMap.key['NICKNAME']}</a></div><br>
								  	<div class="user-detail">answrd :${fn:substring(tempAnswerList.CREATIONDATE, 0,10)}</div>
								 	<div id="badge-vote">&#9813; <font style="color:black;">${userInfoMap.key['VOTE']}</font></div>
						 		</c:if>
						 	</c:forEach>
						</div>
	           	    </div>
				</div>	
			</div>	
			<hr class="all">
                        <div class="row">
		<div class="col-sm-11 col-sm-offset-1">
			<c:forEach var="map" items="${acommentList }" >
				<c:if test="${ tempAnswerList.ID == map.key}">
					<c:forEach var="item" items="${ map.value}" varStatus="loop">
						<p class="commentPre">
                           ${item.COMMENT}<a class="userLink"><font class="user-detail-comment">${fn:substring(item.CREATIONDATE, 0,10)} </font>${item.USERNICKNAME }</a>
						</p>
					</c:forEach>
				</c:if>
			</c:forEach>
		</div>
	</div>
		</div>
	</div>
	
		<form:form action="answerComment" modelAttribute="acomment" method="POST" id="${loop.index}">
			<form:hidden path="ANSWERID" value="${tempAnswerList.ID}" id="${loop.index}" />
			<form:hidden path="USERNICKNAME" value="${sessionScope[myNickname] }" id="${loop.index}" />
		<div class="col-lg-8 col-lg-offset-2">
			<div class="input-group input-group-lg" style="z-index: 0;">
				<form:input type="text" id="${loop.index}" path="COMMENT" class="form-control" rows="5" placeHolder="Add comment" required="required" />
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit"
						onclick="if ('${sessionScope[myUserId]}' > 0) { document.getElementById('theForm').submit();
		                                         } else {openModal();}; return false;"
						style="margin-top: 0px;">
						<i class="glyphicon glyphicon-send"></i>
					</button>
				</div>
			</div>
		</div>
		</form:form>
	</c:forEach>
	<!-- JUST FOR SOME WHITE SPACE -->
    <div class="row"><div class="col-lg-12">&nbsp;&nbsp;&nbsp;</div></div>
	<c:choose>
		<c:when test="${not empty sessionScope[myUserId]}">
				<div class="row">
					<div class="col-lg-5 col-lg-offset-2">
						<h4 style="color: #0c5790">Your Answer :</h4>
					</div>
					<div class="row">
						<div class="col-lg-8 col-lg-offset-2">
							<form:form action="AddAnswer" modelAttribute="answer" method="POST">
								<form:hidden path="USERID" value="${sessionScope[myUserId]}" />
								<form:hidden path="QUESTIONSID" value="${question.ID }" />

								<textarea id="mytextarea" name="ANSWER" required="required">Write your answer here!</textarea>
								<c:if test="${not empty emptyField}">
									<div class="alert alert-danger alert-dismissible" role="alert">
										<button type="button" class="close" data-dismiss="alert" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<strong>Warning!</strong>
										<c:out value="${emptyField}" />.
									</div>
								</c:if>
								<div class="row">
									<div class="col-lg-12">
										<button type="submit" class="btn btn-primary btn-block">
											<span class="glyphicon glyphicon-send"></span> Post your answer
										</button>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</c:when>
		<c:otherwise>
			<div class="ex4">
				<h3>
					<input type="hidden" name="from" value="${previousUrl}">
					Please <a href="SignIn">Login</a> or <a href="SignUp">Sign up</a>
					to be able to answer the question!
				</h3>
			</div>
		</c:otherwise>
	</c:choose>
    <div class="ex4">
         <p>
            Not the answer you're looking for? Browse other questions or 
            <a href="Question-form">ask your own question.</a>
         </p>
     </div> 
     </div><!-- BASE COLUMN -->
</div><!-- BASE ROW -->
<!-- JUST FOR SOME WHITE SPACE -->
<div class="row"><div class="col-lg-12"><div style="margin-bottom:20px; margin-top:100px;"></div></div></div>
</div><!-- CONTAINER -->   
<jsp:include page="footer.jsp" />

<!-- IMPORT JAVASCRIPT FILES -->
	<script src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/prism.js"></script>
	<script src="${pageContext.request.contextPath}/resources/tinymce/tinymce.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/init-tinymce.js"></script>
<script type="text/javascript">
var starredSpan = $("<span/>").attr('class', 'glyphicon glyphicon-star')
.attr('id', 'icon-button-icon').attr('style', 'color: gold;').attr('accesskey', 'Gold')
.attr('title', 'Remove from favorite').click(function() {removeFavorite();});

var unStarredSpan = $("<span/>]").attr('class', 'glyphicon glyphicon-star-empty')
.attr('id', 'icon-button-icon').attr('accesskey', 'Silver')
.attr('title', 'Add to favorite').click(function() {addToFavorite();});

if ('${isFavorite}' === "true") {
	$('#Star').append(starredSpan);
} else {
	$('#Star').append(unStarredSpan);
}	
	

function removeFavorite() {

	if ('${sessionScope[myUserId]}' <= 0) {
		openModal();
	} else {

		$.ajax({
			type : 'post',
			url : '${removeFromFav}',
			success : function(data) {

				$("span[accesskey='Gold']").remove();
				$('#Star').append(unStarredSpan).fadeIn("slow");

			},
			error : function(ex) {
				swal("Error !", ex, "error");
			}
		});
	}
}

function addToFavorite() {

	if ('${sessionScope[myUserId]}' <= 0) {
		openModal();
	} else {

		$.ajax({
			type : 'post',
			url : '${addToFav}',
			success : function(data) {

				$("span[accesskey='Silver']").remove();
				$('#Star').append(starredSpan).fadeIn("slow");

			},
			error : function(ex) {
				swal("Error !", ex, "error");
			}
		});
	}
}
</script>
</body>
</html>