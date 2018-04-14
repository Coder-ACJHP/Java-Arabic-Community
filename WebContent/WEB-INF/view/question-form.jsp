<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Ask Question - Java Arabic Community</title>
        <!-- TINYMCE CODE COLORING LIBRARY PRISM CSS+JS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/prism.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

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
    <c:set var="myUserId" value="loggedInUserId" />
        <c:choose>
        <c:when test="${empty sessionScope[myUserId]}">
            <jsp:include page="logedOut.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="logedIn.jsp" />
    </c:otherwise>
</c:choose>
	<c:if test="${not empty error}">
		<script type="text/javascript">
			sweetAlert("Oops...", "${error}", "error");
		</script>
	</c:if>
    <div class="container">	
        <div class="col-lg-10 col-lg-offset-1" id="base-row">
            <div class="row" style="margin-top:15px;">
                <div class="row">
                    <div class="col-lg-10 col-lg-offset-1">
                        <div class="row">
                            <div style="text-align: left;">
                                <h2>Ask Question :</h2>
                            </div>
                            <hr style="margin-bottom: 15px; margin-top: 5px;">
                        </div>
                       <form:form action="SaveQuestion" modelAttribute="question" method="POST">
                        <div class="col-md-7">
                                <!-- need to associate this data with customer id -->
                                <form:hidden path="ID" />
                                <form:hidden path="USERID" value="${sessionScope[myUserId]}" />

                                <div class="row">
                                    <div class="form-group">
                                        <label><b><spring:message code="label.title" />:</b></label>
                                        <form:input path="QUESTIONS" class="form-control" placeholder=" What's your programming question?" accesskey="field"/>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group">
                                        <label><b><spring:message code="label.explain" />:</b></label>
                                        <form:textarea path="QEXPLAIN" id="mytextarea" class="qText" accesskey="field"></form:textarea>
                                     </div>
                                 </div>
                                 <div class="row">
                                   <div class="form-group">
                                        <label><b><spring:message code="label.tags" />:</b></label>
                                        <form:input path="TAGS" class="form-control" placeholder=" Language, classes tags, max 5 tags" accesskey="field"/>
                                    </div>
                                </div>     
                                <div class="row">
                                    <spring:message code="label.postQuestion" var="labelSubmit" />
                                    <button type="submit" class="btn btn-primary btn-block" onclick="if ('${sessionScope[myUserId]}' > 0) {document.getElementById('theForm').submit();} else {window.location.href = 'SignIn'};" >
                                        <span class="glyphicon glyphicon-send"></span> ${labelSubmit}
                                    </button>
                                </div>     
                        	</div>
                        <div class="col-sm-1">&nbsp;</div>
                        <div class="col-md-4">

                            <div class="row">
                                <div class="how-to-ask-banner">
                                    <h4>How to ask?</h4>
                                    <h5>Is your question about programming?</h5>
                                    <p>We prefer questions that can be
                                        answered, not just discussed.</p>
                                    <p>Provide details. Share your
                                        research.</p>
                                    <p>
                                        If your question is about this website, ask it on <a
                                            href="https://github.com/Coder-ACJHP/Java-Arabic-Community">Github</a>
                                        instead.
                                    </p>
                                    <p style="font-size: 12px; float: right;">
                                        <a href="mailto:hexa.octabin@gmail.com">Ask Coder ACJHP &raquo;</a>
                                    </p>
                                </div>
                                <!-- SHOW FORM ERRORS -->
                                <div style="margin-top:10px;" id="errorMsgFields">
									<spring:bind path="*">
										<ol>
										<c:forEach items="${status.errorMessages}" var="errormessage">
											<li class="error">${errormessage}</li>
										</c:forEach>
										</ol>
									</spring:bind>
								</div>
                            </div>
                        </div>
                       </form:form>   
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-10 col-md-offset-1" style="text-align: center;">
                        <div class="ex4">
                            Also you can cancel and continue to seeking for different questions from <a href="${pageContext.request.contextPath }/AllQuestions">here</a>. 
                        </div>
                    </div>
                </div>
            </div>	
        </div>
    </div> 
    <div style="margin-top:100px;"></div> 
    <jsp:include page="footer.jsp" />
    <script src="${pageContext.request.contextPath}/resources/js/prism.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/init-tinymce.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sweetalert.min.js"></script>
    <script type="text/javascript">
    
    	var errorFields = $("div[id='errorMsgFields']");
		var childrenLi = $('ol');
		var submitButton = $('button[type="submit"]');
		
		if(childrenLi.find('li').length > 0) {
			errorFields.prepend('<h4 class="error"><b>QUESTION ERROR(S)!</b></h4>');
			submitButton.prop('disabled', true); //disable
			submitButton.attr('title', 'Fill the blanks to enable this button.');
		} 
		
		$('input[accesskey="field"]').focus(function() {
			clearForm();
		});
		
	    function clearForm() {
	    	errorFields.hide();
	    	submitButton.prop('disabled', false); //disable
	    	submitButton.attr('title', 'Click to register.');
	       
	    }  
    </script>
</body>
</html>