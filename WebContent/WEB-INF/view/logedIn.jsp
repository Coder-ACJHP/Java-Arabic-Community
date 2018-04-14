<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/customFunctions.js"></script>
<!-- Initialize new variables with c tag -->
<c:set var="myUserId" value="loggedInUserId" />
<c:set var="myPicture" value="loggedInUserPicture" />
<c:set var="myNickname" value="loggedInUserNickname" />
<c:set var="myRegDate" value="loggedInUserRegDate" />
<c:set var="myVote" value="loggedInUserVote" />
<c:url var="User" value="/Users">
<c:param name="answerUserId" value="${sessionScope[myUserId]}" />
</c:url>
<!-- ------------------------------------------------------------------ -->

<nav class="navbar navbar-inverse navbar-static-top" >
    <div class="container-fluid">
        <div class="nav navbar-nav navbar-header" id="navHeader" title="Go to Home page">
            <a href="https://java-arabic-community.herokuapp.com/AllQuestions">
               <img class="nav-logo" alt="Logo not found!" src="${pageContext.request.contextPath}/resources/images/miniLogo.png">
            </a>
            <span id="nav-header-p">Java Arabic Commumity<br>Q &amp; A website</span>
        </div>
        <ul class="nav navbar-nav navbar-center">
            <li class="nav-center-li">
                <form:form id="searchForm" action="Search" method="POST">
                    <div class="input-group ">
                        <spring:message code="label.search" var="LabelSearchQuestion" />
                        <span class="input-group-addon" style="background-color: #333; color: white;">
                            <spring:message code="label.searchQuestion" /> :
                        </span>
                        <input type="text" name="theSearchName" class="form-control">
                        <div class="input-group-btn">
                           <button class="btn btn-default" type="submit" style="margin-top: 0px;">
                               <i class="glyphicon glyphicon-search"></i>
                           </button>
                        </div>
                    </div>
                </form:form>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li style="float:right;">
            	<form action="Logout" id="logout-form" method="POST">
            		<button type="submit" class="logout-btn"><span class="glyphicon glyphicon-log-out"></span> Logout</button>
            	</form>
            </li>
			<li style="float: right;">
				<div class="profile">
					<img class="profile-img" alt="Profile picture" src="data:image/jpeg;base64,${sessionScope[myPicture]}">
					<div class="profile-detail" title="Go to profile">
						<div onclick="window.location.href='${User}'">${sessionScope[myNickname]}</div>
						<div>${sessionScope[myRegDate] }</div>
						<div>&#9813; ${sessionScope[myVote] }</div>
					</div>
					<img src="${pageContext.request.contextPath}/resources/images/inbox.png"
						alt="message-box" class="message-box" title="MESSAGE BOX">
					<div id="popover-content-login" class="hide">
						<ul class="message-box-list">
							<c:forEach items="${loggedInUserMessages}" var="message">
								<li>
								<div class="row">
									 <div class="col-sm-1" style="padding-left: 5px; padding-right: 0px;">
											<c:choose>
												<c:when test="${message.isRead eq true}">
													<span class="read"></span>
												</c:when>
												<c:otherwise>
													<span class="unread"></span>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="col-sm-11" style="padding-left:0px;">
										<div class="upSide">
											<span class="message-header">${message.header}</span>
											<span class="message-date">${fn:substring(message.creationDate, 0, 10)}</span>
										</div><br>
										<div class="content">
											<c:set var="baseUrl" value="${message.link}" />
											<a href="${baseUrl}" onclick="setMessageAsRead('${message.id}', event);" id="message-link">Click here to see the whole message.</a><br>
											<c:out value="${message.detail}"/>
											<hr class="message-hr">
										</div>
									</div>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</li>
        </ul>
    </div>
</nav>
<script>
	$('.message-box').each(function(i, obj) {

		$(this).popover({
			html : true,
			animation : true,
			placement : "bottom",
			title : "MESSAGE BOX",
			content : function() {
				return $('#popover-content-login').html();
			}
		});
	});
	
	function setMessageAsRead(Id, event) {
		event.preventDefault();
		
		$.ajax({
			type : 'post',
			url : 'UserMessageSetAsRead',
			data : "messageId=" + Id,
			success : function(data) {
 				var url = $('#message-link').attr('href');
 				window.location.href = url;
			},
			error : function(ex) {
				swal("Oppss...", "Unknow error!", "error");
			}
		});
	}
</script>