<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
    <!-- BOOTSTRAP DEPENDENCIES -->
    <script src="resources/jquery/3.2.1/jquery.min.js"></script>	
    <script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/resume-cv.css">         
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <title>Resume Builder - Java Arabic Community</title>
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
        <div class="spaces">
            <div class="row" id="base-row">
                <div class="row">
                    <div id="customJumbotron">
                    	<div class="jumbotron-header">Create your own resume with J.A.C.</div>
                    	<p style="font-size: 16px;"><strong style="font-size: 1.5em;">Resume</strong> provides a summary of your education, work history, credentials, 
                    		and other accomplishments and skills. There are also optional sections, including 
                    		a resume objective and career summary statement. Resumes are the most common 
                    		document requested of applicants in job applications.A resume should be as 
                    		concise as possible.Typically, a resume is one page long, although sometimes 
                    		it can be as long as two pages. Often resumes include bulleted lists to keep 
                    		information concise.Resumes come in a few types, including chronological, 
                    		functional, and combination formats. Select a format that best fits the type 
                    		of job you are applying for like this.
                    	</p>
                    	<div class="row">
                    		<div class="col-lg-5 col-md-5 col-sm-5 col-xm-5">
                    			 <p><a href="#" data-toggle="tooltip" data-placement="bottom">How to use J.A.C. Resume Builder?</a></p>
                    		</div>
                    	</div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xm-12">
                    	<hr> 
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="form-group">
                        <label for="name">Profile Picture:</label>
                        <input type="file" class="form-control" id="picture">
                    </div>
                    <div class="form-group">
                        <label for="name">Headers:
                            <small style="color:lightgray;">exmp : languages, frameworks, skills.</small>
                        </label>
                        <br>
                        <button type="button" class="btn btn-primary" id="headerOne" onclick="showPopOver(this);">Header one</button>
                        <button type="button" class="btn btn-primary" id="headerTwo" onclick="showPopOver(this);">Header two</button>
                        <button type="button" class="btn btn-primary" id="headerThree" onclick="showPopOver(this);">Header three</button>
                        <div id="popover-content" class="hide">
                            <input type="text" class="form-control" id="headerOneText" placeholder="Ex: LANGUAGES">
                            <input type="text" class="form-control" id="firstSkill" placeholder="Ex: JAVA 100">
                            <input type="text" class="form-control" id="secondSkill" placeholder="Ex: PYTHON 70">
                            <input type="text" class="form-control" id="thirdSkill" placeholder="Ex: JAVASCRIPT 40">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="name" maxlength="14" placeholder="Enter name and surname">
                    </div>
                    <div class="form-group">
                        <label for="job">Your job:</label>
                        <input type="text" class="form-control" id="job" maxlength="30" placeholder="Enter your current job">
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="text" class="form-control" id="phone" placeholder="Enter phone number">
                    </div>
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" class="form-control" id="address" placeholder="Enter address">
                    </div>
                    <div class="form-group">
                        <label for="about-me">About me:</label>
                        <textarea class="form-control" id="about-me" placeholder="Enter something about you"></textarea>

                    </div>
                    <div class="form-group">
                        <label for="work-experience">Work experience:</label>
                        <textarea class="form-control" id="work-experience" placeholder="Enter your work experiences"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="education">Education:</label>
                        <textarea class="form-control" id="education" placeholder="Enter your education"></textarea>
                    </div>
                    <div class="form-group" id="link-div">
                        <label class="input-inline" for="links">Reference link(s):</label>
                        <div class="row">
                            <div class="col-sm-1">
                                <input type="checkbox" class="checkbox-inline" checked id="first-check">
                            </div>
                            <div class="col-sm-11">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="addressOne" placeholder="Enter first link" style="z-index: 0;">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-remove" onclick="deleteLink(1);" title="Delete the link."></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-1">
                                <input type="checkbox" class="checkbox-inline" value="" id="second-check">
                            </div>
                            <div class="col-sm-11">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="addressTwo" placeholder="Enter second link" disabled="disabled" style="z-index: 0;">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-remove" onclick="deleteLink(2);" title="Delete the link."></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-1">
                                <input type="checkbox" class="checkbox-inline" value="" id="third-check">
                            </div>
                            <div class="col-sm-11">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="addressThree" placeholder="Enter third link" disabled="disabled" style="z-index: 0;">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-remove" onclick="deleteLink(3);" title="Delete the link."></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8" id="print-object">
                    <div class="paper">
                        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4" id="left-side">
                            <div class="row">
                                <div class="photo-container">
                                    <div class="photo">
                                        <img class="photo-img" src="${pageContext.request.contextPath}/resources/images/nouser.jpg" alt="Picture">
                                    </div>
                                </div>
                                <section>
                                    <div class="headers-label" id="first-header-label">
                                    </div>
                                    <div class="skills-div"></div>
                                </section>
                            </div>
                        </div>
                        <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8" id="right-side">
                            <div class="user-name"></div>
                            <div class="current-job"></div>
                            <hr>
                            <label for="contact" class="topic-label">CONTACT :</label>
                            <br>
                            <div class="contact">
                                <span style="float: left;">
                                    <img src="${pageContext.request.contextPath}/resources/images/email.png" alt="email-icon" id="icons">
                                    <span class="email"></span>
                                </span>
                                <span style="margin-left: 80px;">
                                    <img src="${pageContext.request.contextPath}/resources/images/phone-call.png" alt="phone-icon" id="icons">
                                    <span class="phone"></span>
                                </span>
                            </div>
                            <p class="contact">
                                <img src="${pageContext.request.contextPath}/resources/images/placeholder.png" alt="location-icon" id="icons">
                                <span class="address"></span>
                            </p>
                            <hr>
                            <label for="about-me" class="topic-label">ABOUT ME :</label>
                            <p class="about-me"></p>
                            <hr>
                            <label for="work-experience" class="topic-label">WORK EXPERIENCE :</label>
                            <p class="work-experience"></p>
                            <hr>
                            <label for="education" class="topic-label">EDUCATION :</label>
                            <p class="education"></p>
                            <hr>
                            <label for="link" class="topic-label">REFRANCE LINKS :</label>
                            <div class="links-div"></div>
                        </div>
               	 	</div>
                </div>
                <div class="row">
                	 <div class="col-lg-12 col-md-12 col-sm-12 col-xm-12">
                    	<hr> 
                    </div>
                	<div class="col-lg-12">
                		<div class="well">
                			<p>Thank you for using Java Arabic Community Resume Builder.
							<button class="btn btn-default btn-md" id="btnPrint">
								<i class="glyphicon glyphicon-print"></i> 
								PRINT&nbsp;or&nbsp;<i class="glyphicon glyphicon-download-alt"></i> DWNLD
							</button> 
							</p>                  
                    	</div>
                	</div>
                </div>	
            </div>
        </div>
    </div>
     <div class="row">
        <div class="col-lg-10">
            <div style="margin-bottom: 100px;"></div>
        </div>    
    </div> 
    <jsp:include page="footer.jsp" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/resume-cv.js"></script>
    <script type="text/javascript">
    
	    $(document).ready(function(){
	        $('[data-toggle="tooltip"]').tooltip({
	             title: '<li>Press "Enter" to apply on resume after filling the blanks.</li><li>You can erase last inputs in headers and write new value.</li><li>For downloading as ".pdf" you have to change the target to "Save as PDF".</li>',  
	             html: true
	        });   
	    });
    
		$(function () {
		    $("#btnPrint").click(function () {
		        var contents = $("#print-object").html();
		        var frame1 = $('<iframe />');
		        frame1[0].name = "frame1";
		        frame1.css({ "position": "absolute", "top": "-1000000px" });
		        $("body").append(frame1);
		        var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
		        frameDoc.document.open();
		        //Create a new HTML document.
		        frameDoc.document.write('<html><head><title>J.A.C CV</title>');
		      	//Append the external CSS file.
		        frameDoc.document.write('<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/resume-cv.css">');
		        frameDoc.document.write('<link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">');
		        frameDoc.document.write('</head><body>');
		        //Append the DIV contents.
		        frameDoc.document.write(contents);
		        frameDoc.document.write('</body></html>');
		        frameDoc.document.close();
		        setTimeout(function () {
		            window.frames["frame1"].focus();
		            window.frames["frame1"].print();
		            frame1.remove();
		        }, 500);
		    });
		});
</script>
</body>

</html>