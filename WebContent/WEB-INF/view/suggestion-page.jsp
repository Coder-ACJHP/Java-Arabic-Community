<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Suggestion - Java Arabic Community</title>
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
<body style="background-color: #ededed;">
    <c:set var="myUserId" value="loggedInUserId" />
    <c:choose>
        <c:when test="${empty sessionScope[myUserId]}">
            <jsp:include page="logedOut.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="logedIn.jsp" />
        </c:otherwise>
    </c:choose>
    <c:if test="${not empty success}">
    <script type="text/javascript">
        sweetAlert("Excellent!", "${success}", "success");
    </script>
    </c:if>

    <div class="container">
        <div class="col-lg-10 col-lg-offset-1" id="base-row">
            <div class="row" style="margin-top:15px;">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <h2>
                            Send us : <small>your feedback, comments, and suggestions!</small>
                        </h2>
                        <hr style="margin-bottom: 20px; margin-top: 5px;">
                    </div>
                    <div class="col-md-2"></div>
                </div>	

                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <form:form action="SendSuggest" modelAttribute="suggestion" method="POST">
                                <div class="row">
                                    <label class="control-label" for="firstname">First and last name: <b style="color:red;">*</b></label>
                                    <form:input path="name" type="text" class="form-control" id="firstname"/>
                                    <form:errors path="name" cssClass="error"/>
                                </div><br>
                                <div class="row">
                                    <label class="control-label" for="email">E-mail Address: <b style="color:red;">*</b></label>
                                    <form:input path="email" type="email" class="form-control" id="email"/>
                                    <form:errors path="email" cssClass="error"/>	
                                </div><br>
                                <div class="row">
                                    <label class="control-label" for="country">Country: <b style="color:red;">*</b></label>
                                    <form:select path="country" class="form-control">
                                        <c:forEach items="${countriesOption}" var="country">
                                            <option value="${country.key}">${country.value}</option>
                                        </c:forEach>
                                    </form:select>
                                    <form:errors path="country" cssClass="error"/>
                                </div><br>
                                <div class="row">
                                    <label class="control-label" for="category">Category: <b style="color:red;">*</b></label>
                                    <form:select path="category" class="form-control" >
                                        <option value="Feedback">Feedback</option>
                                        <option value="Suggest something">Suggest something</option>
                                        <option value="Help about website">Help about website</option>
                                        <option value="Report a problem">Website issue</option>
                                        <option value="All categories">All categories</option>
                                    </form:select>
                                    <form:errors path="category" cssClass="error"/>
                                </div><br>
                                <div class="row">
                                    <label class="control-label" for="subject">Subject: <b style="color:red;">*</b></label>
                                    <form:input path="subject" type="text" class="form-control" id="subject"/>
                                    <form:errors path="subject" cssClass="error"/>
                                </div><br>
                                <div class="row">
                                    <label class="control-label" for="message">Message: <b style="color:red;">*</b></label>
                                    <form:textarea path="message" class="form-control" id="message"></form:textarea>
                                    <form:errors path="message" cssClass="error"/>	
                                </div>
                                <br>
                                <div class="row">
                                    <button type="submit" class="btn btn-info btn-block" title="Send your feedback">
                                        <span class="glyphicon glyphicon-send"></span> Send it
                                    </button>
                                </div><br>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12" style="text-align: center;">
                    <div class="ex4">
                        To continue looking for questions return to <a href="${pageContext.request.contextPath }/AllQuestions">questions page</a>. 
                    </div>
                </div>
            </div>
        </div>
        <div class="row"><div class="col-lg-10">&nbsp;</div></div>
    </div>
</body>
</html>