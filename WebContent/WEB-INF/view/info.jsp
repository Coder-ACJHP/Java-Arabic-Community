<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Info - Java Arabic Community</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/info-page.css">
    <!-- BOOTSTRAP DEPENDENCIES -->
    <script src="resources/jquery/3.2.1/jquery.min.js"></script>
    <script src="resources/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body style="background-color: white;">
<c:set var="myUserId" value="loggedInUserId" />
<nav class="navbar navbar-inverse navbar-static-top">
  <div class="container-fluid">
        	<div class="nav navbar-nav navbar-header" id="navHeader" title="Go to Home page">
      			<a href="https://java-arabic-community.herokuapp.com/AllQuestions">
            		<img class="nav-logo" alt="Logo not found!" src="${pageContext.request.contextPath}/resources/images/miniLogo.png"> 
            	</a>
           		<p id="nav-header-p">Java Arabic Commumity<br>Q &amp; A website</p>
        	</div>
			<ul class="nav navbar-nav navbar-center">
				<li class="nav-center-li"></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
         		<li style="float:right;"><a href="SignIn"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        		<li style="float:right;"><a href="SignUp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
			</ul>
	</div>
</nav>
<!-- content -->
<div class="wrapper row2">
  <div id="container" class="clear">
    <!-- Slider -->
      	<div class="row">
	    <section id="slider" class="clear">
	      <figure>
	        <figcaption>
	          <h2>Learn, Share, Build</h2>
	          <p>Founded in 2016, Java Arabic Community is the stable, most trusted online community for developers to learn, share their knowledge, and build their careers. More than 10 professional and aspiring programmers visit Java Arabic Community each month to help solve coding problems, develop new skills.</p>
	          <footer class="more">
	          	<button type="button" class="btn btn-secondary" style="width: 240px;"
					onclick="window.location.href='Suggestion'; return false;" title="Share your suggestions">
					<span class="glyphicon glyphicon-exclamation-sign"></span> Say some thing about J.A.C
				</button>
	          </footer>
	        </figcaption>
	      </figure>
	    </section>
      	</div>
      	<div class="row">
      		<div class="col-lg-12">
      			<label style="font-size: 2rem;">USED TECHNOLOGIES : </label>
      		</div>
      	</div>
    <!-- main content -->
    <div id="homepage">
      <!-- services area -->
      <section id="services" class="clear">
        <!-- article 1 -->
        <article class="one_third">
          <h2>Maven</h2>
          <img src="${pageContext.request.contextPath}/resources/images/maven.png" alt="" width="80px" height="80px">
			<p>Apache Maven bir yazılım proje yönetimi ve anlama aracıdır. Bir proje nesne modeli (POM) kavramına dayanan Maven, bir projenin yapısını, raporlamasını ve belgelerini merkezi bir bilgi parçasından yönetebilir.Maven'ın projenize yardımcı olabileceğini düşünüyorsanız, navigasyonun "Maven Hakkında" bölümünde daha fazla bilgi bulabilirsiniz. </p>
          <footer class="more"><a href="#">Read More &raquo;</a></footer>
        </article>
        <!-- article 2 -->
        <article class="one_third">
          <h2>Spring framework</h2>
          <img src="${pageContext.request.contextPath}/resources/images/spring.svg" alt=""  width="80px" height="80px">
			<p>Eklentileri ile birlikte Java Enterprise platform üzerinde web uygulamaları geliştirmek için de kullanılabilir. Spring Framework Java toplulukları arasında Enterprise JavaBean (EJB) modelinin yerine geçebilecek popüler bir alternatif haline gelmiştir.</p>
          <footer class="more"><a href="#">Read More &raquo;</a></footer>
        </article>
        <!-- article 3 -->
        <article class="one_third lastbox">
          <h2>Hibernate ORM</h2>
          <img src="${pageContext.request.contextPath}/resources/images/hibernate.png" alt=""  width="80px" height="80px">
			<p>Hibernate, Java platformunda yazılmış bir ORM (Object/Relational Mapping) aracıdır. ORM, nesne odaklı (object oriented) dillerdeki nesnelerin, ilişkisel veri tabanlarındaki (relational databases) kayıtlara nasıl karşılık geldiğini yürüten bir teknolojidir. NHibernate adında .NET çatısı için yeniden yazılmış bir türevi bulunur.</p>
          <footer class="more"><a href="#">Read More &raquo;</a></footer>
        </article>
      </section>
      <!-- / services area -->
      <!-- ########################################################################################## -->
      <!-- ########################################################################################## -->
      <!-- ########################################################################################## -->
      <!-- ########################################################################################## -->
      <!-- One Quarter -->
      <section id="latest" class="last clear">
        <article class="one_quarter">
          <figure><img src="${pageContext.request.contextPath}/resources/images/heroku.jpg" width="215" height="100" alt="">
            <figcaption>
              <h2>Heroku app</h2>
              <p>We’re excited to announce our new lineup of Postgres production plans. PGX Plans introduce larger database sizes, more generous resource allocations, and a broader set of options to suit your needs and to help your applications scale more smoothly.</p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
        <article class="one_quarter">
          <figure><img src="${pageContext.request.contextPath}/resources/images/tinymce.jpg" width="215" height="100" alt="">
            <figcaption>
              <h2>TinyMCE</h2>
              <p>NTinyMCE (Tiny Moxiecode Content Editor) is a platform-independent, browser-based WYSIWYG editor control, written in JavaScript and released as open-source software under the LGPL by Ephox. It has the ability to convert HTML textarea fields or other HTML elements to editor instances. TinyMCE is designed to easily </p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
        <article class="one_quarter">
          <figure><img src="${pageContext.request.contextPath}/resources/images/jquery.png" width="215" height="100" alt="">
            <figcaption>
              <h2>JQuery</h2>
              <p>jQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler with an easy-to-use API that works across a multitude of browsers. With a combination of versatility and extensibility, jQuery has changed the way that millions of people write JavaScript.</p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
        <article class="one_quarter lastbox">
          <figure><img src="${pageContext.request.contextPath}/resources/images/java-ee.png" width="215" height="100" alt="">
            <figcaption>
              <h2>Java EE 7</h2>
              <p>Java Platform, Enterprise Edition (Java EE) is the standard in community-driven enterprise software. Java EE is developed using the Java Community Process, with contributions from industry experts, commercial and open source organizations, Java User Groups, and countless individuals. Each release integrates new features that align with industry needs, improves application portability, and increases developer productivity.</p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
      </section>
      <!-- / One Quarter -->
    </div>
    <!-- / content body -->
  </div>
</div>
<div style="margin-bottom: 100px;"></div>
<!-- Footer -->
<jsp:include page="footer.jsp" />
</body>
</html>
