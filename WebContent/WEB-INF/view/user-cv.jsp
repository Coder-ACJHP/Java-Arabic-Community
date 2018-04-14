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
	<script src="resources/jquery/3.2.1/jquery.min.js"></script>
	<script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
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
			<jsp:include page="login-modal.jsp" />
		</c:when>
		<c:otherwise>
			 <jsp:include page="logedIn.jsp" />
		</c:otherwise>
	</c:choose>
	
<!-- NAVIGATIONBAR STARTED -->
<div class="container">
    <div class="row">
        <div class="col-lg-11" id="base-row">
            <div class="row" style="margin-top:15px;">
                <div class="col-lg-10 col-lg-offset-1">
                    <ul class="nav nav-tabs">
                        <li class="active"><a class="href-link"
                                              onclick="location.reload();" title="Refresh the page."
                                              style="cursor: pointer;"> <b>Member profile :</b>
                            </a></li>
                        <li><a class="href-link"
                               onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {openModal();};return false;">
                                <spring:message code="label.askQuestion" var="LabelAskQues" /> <span
                                    class="glyphicon glyphicon-question-sign"
                                    style="color: #cdf02d;"></span> ${LabelAskQues}
                            </a></li>
                        <li><a href="TopQuestions"> <spring:message
                                    code="label.top" var="LabelTop" /> <span
                                    class="glyphicon glyphicon-fire" style="color: red;"></span>
                                ${LabelTop}
                            </a></li>
                        <li><a href="Users-list"> <spring:message
                                    code="label.users" var="LabelUsers" /> <span
                                    class="glyphicon glyphicon-th-list" style="color: gold;"></span>
                                ${LabelUsers}
                            </a></li>
                        <li><a href="Info-page"> <spring:message
                                    code="label.info" var="LabelInfo" /> <span
                                    class="glyphicon glyphicon-info-sign"></span> ${LabelInfo}
                            </a></li>
                    </ul>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <br>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1">
                    <div class="row">
                        <div class="col-md-11">
                            <h2>Profile :</h2>
                            <hr style="margin-bottom: 20px; margin-top: 5px;">
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="row">
                        <div class="col-md-4" style="text-align: center;">
                            <img class="cvImg" alt="No image"
                                 src="data:image/jpeg;base64,${profilePicture }">
                                <h5>
                                    <span class="badge" style="color: gold;">${users.VOTE}</span> <b>REPUTATION</b>
                                </h5>
                        </div>
                        <div class="col-md-5">
                            <div class="col-lg-12">
                                <div class="row">
                                    <label style="font-size: 25px;">${users.NICKNAME}</label>
                                    <p style="color: grey; font-size: 13px;">${users.ABOUT}</p>
                                </div>
                                <div class="row">
                                    <div style="margin-top: 5%;"></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <form:form action="AddUserComment" modelAttribute="userComment" method="POST">
                                        <form:hidden path="COMMENTEDBY" value="${sessionScope[myNickname] }" />
                                        <input type="hidden" name="userId" value="${sessionScope[myUserId] }">
                                            <div class="input-group" style="z-index:0;">
                                                <form:input type="text" path="COMMENT" class="form-control"
                                                            placeHolder="Write something about ${users.NICKNAME}" required="required" />
                                                <div class="input-group-btn">
                                                    <button class="btn btn-default" type="submit" title="Send comment" style="margin-top: 0px;"
                                                            onclick="if ('${sessionScope[myUserId]}' > 0){document.getElementById('theForm').submit();} else {openModal();};return false;">
                                                        <i class="glyphicon glyphicon-send"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </form:form>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12" style="margin-top: 5px;">
                                    <button class="btn btn-info btn-block" type="button" data-toggle="modal" data-target="#commentModal">
                                        <span class="glyphicon glyphicon-th-list"></span> Show all comments
                                    </button>
                                    <div class="container">
                                        <!-- Modal -->
                                        <div class="modal fade" id="commentModal" role="dialog">
                                            <div class="modal-dialog" style="width: 650px;">
                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        <h4 class="modal-title">${users.NICKNAME}'s comments</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <c:if test="${not empty ucommentsList}">
                                                            <c:forEach items="${ucommentsList}" var="item">
                                                                <p>
                                                                    <span class="glyphicon glyphicon-star" style="color: gold;"></span>${item.COMMENT}
                                                                    <span style="color: #c96295; float: right;"><b><i> ${item.COMMENTEDBY}</i></b></span>
                                                                </p>
                                                            </c:forEach>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" style="text-align: left;">
                            <div class="row">
                                <p>Total answer(s) : <label>${users.ANSWERCOUNT }</label></p>
                            </div>
                            <div class="row">
                                <p>Total question(s):<label>${users.QUESTIONCOUNT }</label></p>
                            </div>
                            <div class="row">
                                <p>Reg. date :<label>${fn:substring(users.REGISTERDATE, 0, 10)}</label></p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-10">
                            <br> <br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Top post(s) :</h4>
                            <hr style="margin-bottom: 20px; margin-top: 5px;">
                        </div>
                    </div>

                    <div class="row">
                        <c:set var="count" value="${0}" />
                        <c:forEach var="tempQuestionsList" items="${questionList}">
                            <!--------------- SET IRL PARAMATERS ------------------->
                            <c:url var="Question" value="/Question">
                                <c:param name="questionId" value="${tempQuestionsList.ID}" />
                            </c:url>
                            <c:url var="User" value="/Users">
                                <c:param name="answerUserId" value="${tempQuestionsList.USERID}" />
                            </c:url>
                            <!------------------------------------------------------->
                            <!-- ANSWER COUNT AND VOTE BOXES -->
                            <div class="col-lg-1 col-lg-offset-1" style="margin-top:15px;">
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
                            </div>
                            <div class="col-lg-1" style="margin-top:15px;">
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
                            <!--------------INITIALIZE COUNTER ------------------>  
                            <c:set var="count" value="${0 }" />
                            <div class="col-lg-8">
                                <div class="row" style="margin-left:1px;">
                                    <a class="question-a" href="${Question}">${tempQuestionsList.QUESTIONS}</a>
                                </div>
                                <div class="row">
                                    <div class="col-lg-8">
                                        <c:forTokens items="${tempQuestionsList.TAGS}" delims=" " var="tags">
                                            <a class="cv-tags" target="_blank">${tags}</a>
                                        </c:forTokens>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="user-detail">
                                            asked :<c:out value="${tempQuestionsList.CREATIONDATE}"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr class="top-posts-line">
                        </c:forEach>
                    </div>                

                </div>
                <!-- MAIN COL END -->
            </div>
            <div class="row">
                <div class="col-lg-10 col-md-offset-1" style="text-align: center;">
                    <div class="ex4">
                        Also you can look for different users from <a href="${pageContext.request.contextPath }/Users-list">here</a>. 
                    </div>
                </div>
            </div>
        </div><!-- ROW COL END -->
    </div>
</div>
	<div style="margin-top: 150px;">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>

