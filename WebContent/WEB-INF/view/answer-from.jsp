<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Answer - Java Arabic Community</title>
	
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/prism.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweetalert.css">
    
    <!-- BOOTSTRAP DEPENDENCIES -->
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
    <c:if test="${not empty error}">
    <script type="text/javascript">
			sweetAlert("Oops...", "${error}", "error");
    </script>
</c:if>
<c:if test="${not empty error_message}">
    <script type="text/javascript">
                   sweetAlert("Oops...", "${error_message}", "error");
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

<div class="container">
    <div class="col-lg-10 col-lg-offset-1" id="base-row">
        <div class="row" style="margin-top:15px;">
                <div class="col-lg-10 col-lg-offset-1">
                    <div class="row">
                        <div style="text-align: left;">
                            <h2>Update Answer :</h2>
                        </div>
                        <hr style="margin-bottom: 5px; margin-top: 5px;">
                    </div>
                    <div class="row">
                        <div class="col-lg-7 col-md-8">
                            <form:form action="UpdateAnswer" modelAttribute="answer" method="POST" id="theForm">
                                <!-- need to associate this data with customer id -->
                                <form:hidden path="ID"/>    
                                    <div class="row">
                                        <div class="form-group">
                                            <label><b>Question Id:</b></label>
                                            <form:input path="QUESTIONSID" class="form-control" id="psw" 
                                                        title="Cannot change this value!" readonly="true"></form:input>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label><b>Your Id:</b></label>
                                            <form:input path="USERID" class="form-control" id="psw" 
                                                        title="Cannot change this value!" readonly="true"></form:input>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label><b>Answer:</b></label>
                                            <form:textarea path="ANSWER" id="mytextarea" class="qText" required="required"></form:textarea>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label><b>Answer creation date:</b></label>
                                            <form:input path="CREATIONDATE" class="form-control" id="psw" 
                                                        title="Cannot change this value!" readonly="true" ></form:input>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label><b>Acceptance status:</b></label>
                                            <form:input path="ISACCEPTED" class="form-control" id="psw" 
                                                        title="Cannot change this value!" readonly="true"></form:input>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label><b>Answer vote count:</b></label>
                                            <form:input path="VOTE" class="form-control" id="psw" 
                                                        title="Cannot change this value!" readonly="true"></form:input>
                                            </div>
                                        </div>
                                        <div class="row">  
                                        <c:if test="${not empty error}">
											<div class="alert alert-danger alert-dismissible" role="alert">
												<button type="button" class="close" data-dismiss="alert" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
												<strong>Warning!</strong>
												<c:out value="${error}" />.
											</div>
										</c:if>                              
                                        <spring:message code="label.updateAnswer" var="UpdateAnswer" />
                                        <button class="btn btn-primary btn-block" type="submit">
                                            <span class="glyphicon glyphicon-ok"></span> ${UpdateAnswer}
                                        </button>
                                    </div> 
                                </form:form> 
                        </div>
                        <div class="col-lg-1">&nbsp;</div>    
                        <div class="col-lg-4 col-md-4">
                            <div class="row">
                                <div class="how-to-ask-banner">
                                    <h4>How do I write a good answer?</h4>
                                    <h5>Write to the best of your ability</h5>
                                    <p>Read the question carefully. What, specifically, is the question asking for?</p>
                                    <p> Make sure your answer provides that – or a viable alternative. The answer can be “don’t do that”, but it should also include “try this instead”.</p>
                                    <p>
                                        If your question is about this website, ask it on <a
                                            href="https://github.com/Coder-ACJHP/Java-Arabic-Community">Github</a>
                                        instead.
                                    </p>
                                    <p style="font-size: 12px; float: right;">
                                        <a href="mailto:hexa.octabin@gmail.com">Ask Coder ACJHP
                                            &raquo;</a>
                                    </p>
                                </div>
                            </div>
                        </div>    
                    </div>                   
                </div>   <!--MAIN COL (8) END -->  
            <div class="row">
                <div class="col-lg-10 col-md-offset-1" style="text-align: center;">
                    <div class="ex4">
                        Also you can cancel and continue to seeking for different answers from <a href="${pageContext.request.contextPath }/AllQuestions">here</a>. 
                    </div>
                </div>
            </div>
        </div>            
    </div><!--CONTAINER END -->
    <div class="row">
        <div class="col-lg-10">
            <div style="margin-bottom: 150px;"></div>
        </div>    
    </div>        
</div>
<jsp:include page="footer.jsp" />
    <script src="${pageContext.request.contextPath}/resources/js/prism.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/init-tinymce.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <script src="resources/jquery/3.2.1/jquery.min.js"></script>
    <script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>        
</html>