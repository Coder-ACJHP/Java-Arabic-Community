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
    <meta name="google-site-verification" content="vjquXGHU5w7_zLfYmh_Tuf72NlhSsOHxOBi9upztR_A" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    <!-- BOOTSTRAP DEPENDENCIES -->
    <script src="resources/jquery/3.2.1/jquery.min.js"></script>
    <script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
    <c:if test="${not empty message}">
    <script type="text/javascript">
           swal("${message}");
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
    <div class="row" id="base-row">
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1" id="fragment">
                <div class="row">
                    <div class="d-flex justify-content-end" style="margin-right:10px;">
                        <span id="close" onclick="document.querySelector('#fragment').remove();" >Dismiss</span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-lg-offset-4" >
                        <img src ="${pageContext.request.contextPath}/resources/images/Logo.png" alt="some description"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2" style="text-align: center; font: 15px verdana; color: gray;">
                        <spring:message code="label.welcomeText"/>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-6 col-sm-offset-3" style="text-align: center;">
                        <input class="btn-outline" type="button" value="Sing Up" onclick="window.location.href = 'SignUp'">
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <span><br></span>
                    </div>
                </div>
            </div>
        </div>
        <!-- BIG JOMBOTRON END -->

        <div class="row" style="margin-top:15px;">
            <div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="AllQuestions" title="Refresh the page." style="cursor: pointer;">
                            <c:choose>
                                <c:when test="${not empty Label}">
                                    <b>${Label} :</b>
                                </c:when>
                                <c:otherwise>
                                    <b><spring:message code="label.allQuestions" /> :</b>
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </li>
                    <li>
                        <a class="href-link" onclick="if ('${sessionScope[myUserId]}' > 0) { window.location.href = 'Question-form'
                                                        } else {window.location.href = 'SignIn'};return false;">
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

        <!-- The main table starting from here!-->	
        <div class="row">
            <c:if test="${not empty info}">
                <div class="col-lg-8 col-lg-offset-2 col-sm-9 col-sm-offset-2" id="no-Result">
                    <p>${info}</p>
                    <label for="p">Suggestions:</label>
                    <ol>
                        <c:forEach var="suggestion" items="${suggestions}">
                            <li>${suggestion}</li>
                            </c:forEach>
                    </ol>
                </div>
            </c:if>
            <c:set var="count" value="${0}" />
            <c:forEach var="tempQuestionsList" items="${questionList}">
                <div class="col-lg-8 col-lg-offset-2 col-sm-9 col-sm-offset-2" id="questionCardRow">
                    <div class="card-block">

                        <div class="col-lg-1 col-md-1 col-sm-2" style="margin-top: 15px;">
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
                        <div class="col-lg-11 col-md-11 col-sm-10">

                            <div class="row">
                                <div class="col-lg-12">
                                    <!-- INITIALIZE COUNTER -->
                                    <c:set var="count" value="${0 }" />

                                    <!-- SET THE QUESTION HEADER OF THE CARD -->
                                    <div class="card-header">
                                        <a class="question-a" href="${Question}">${tempQuestionsList.QUESTIONS}</a>
                                    </div>

                                    <!-- CARD QUESTION EXPLANATION -->
                                    <div id="question-ex">${tempQuestionsList.QEXPLAIN}</div>
                                </div>
                            </div>

                            <div class="row"></div>

                            <!-------------------- BOTTOM IS O.K.---------------------->
                            <div class="row" style="margin-top: 10px;">
                                <div class="col-md-8 col-sm-6" style="margin-top:15px;">
                                    <c:forTokens items="${tempQuestionsList.TAGS}" delims=" " var="tags">
                                        <a class="tags" target="_blank">${tags}</a>
                                    </c:forTokens>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div id="user-rect">
                                        <c:set var="userCount" value="${0 }" />
                                        <c:forEach var="map" items="${userMap }">
                                            <c:if test="${map.key['ID'] eq  tempQuestionsList.USERID}">
                                                <c:set var="userCount" value="${userCount+1 }" />
                                                <c:if test="${userCount eq 1 }">
                                                    <img class="img" alt="No image" src="data:image/jpeg;base64,${map.value}">
                                                        <div class="user-title"><a href="${User}">${map.key['NICKNAME']}</a></div><br>
                                                        <div class="user-detail">asked : ${fn:substring(tempQuestionsList.CREATIONDATE, 0,10)}</div>
                                                        <div id="badge-vote">&#9813; <font style="color:black;">${map.key['VOTE']}</font></div>
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
        </div>

        <!-- main table finished! -->
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <div id="bottom-line-text">Total Question(s):  <span class="badge" style="color: white; font-size: 22px;">
                        <c:out value="${questionCount}" /></span></div>
            </div>
        </div>        
        <div class="row">        
            <div class="col-lg-10 col-lg-offset-1">
                <p id="bottom-line-text">
                    Not the question you're looking for? Browse other questions or 
                    <a href="Question-form">ask your own question.</a>
                </p>
            </div>
        </div>
    </div><!-- ROW -->            
    <div class="row">
        <div class="col-lg-10">
            <div style="margin-bottom: 100px;"></div>
        </div>    
    </div> 
</div><!--CONTAINER FINISHED -->                    
<jsp:include page="footer.jsp" />
</body>
</html>