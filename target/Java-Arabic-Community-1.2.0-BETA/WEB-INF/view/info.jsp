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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- BOOTSTRAP DEPENDENCIES END-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
<c:set var="myUserId" value="loggedInUserId" />
<div class="wrapper row1">
		<header id="header" class="clear">
			<div id="hgroup">
				<h1>
					<a href="#">Info &amp; About Us</a>
				</h1>
				<h2>Java Arabic Community answer question website.</h2>
			</div>
			<div id="hgroup" style="margin-left: 350px; margin-top: 25px;">

				<spring:message code="label.askQuestion" var="LabelAskQues" />
				<button type="button" class="btn btn-primary" style="width: 150px;"
					onclick="if ('${sessionScope[myUserId]}' > 0){window.location.href='Question-form'} else {window.location.href='SignIn'};return false;">
					<span class="glyphicon glyphicon-question-sign" style="color: #cdf02d;"></span> ${LabelAskQues}
				</button>

				<!--      ANOTHER BUTTON     -->

				<spring:message code="label.questions" var="LabelQuestions" />
				<button type="button" class="btn btn-primary" style="width: 150px;"
					onclick="window.location.href='AllQuestions'; return false;">
					<span class="glyphicon glyphicon-fire" style="color: red;"></span> ${LabelQuestions}
				</button>

			</div>
			<div id="hgroup" style="margin-left: 350px;">
				<button type="button" class="btn btn-info" style="width: 300px;"
					onclick="window.location.href='Suggestion'; return false;">
					<span class="glyphicon glyphicon-exclamation-sign"></span> Say some thing about J.A.C
				</button>
			</div>
		</header>
	</div>
<!-- content -->
<div class="wrapper row2">
  <div id="container" class="clear">
    <!-- Slider -->
    <section id="slider" class="clear">
      <figure><img src="${pageContext.request.contextPath}/resources/images/Logo_1.png" alt="app-logo">
        <figcaption>
          <h2>Learn, Share, Build</h2>
          <p>Founded in 2016, Java Arabic Community is the stable, most trusted online community for developers to learn, share their knowledge, and build their careers. More than 10 professional and aspiring programmers visit Java Arabic Community each month to help solve coding problems, develop new skills, and find job opportunities.</p>
          <footer class="more"><a href="#">Read More &raquo;</a></footer>
        </figcaption>
      </figure>
    </section>
    <!-- main content -->
    <div id="homepage">
      <!-- services area -->
      <section id="services" class="clear">
        <!-- article 1 -->
        <article class="one_third">
          <h2>Maven</h2>
          <img src="https://i1.wp.com/roufid.com/wp-content/uploads/2016/05/eyecatch-maven.png?resize=350%2C200" alt="" width="80px" height="80px">
			<p>Apache Maven bir yazılım proje yönetimi ve anlama aracıdır. Bir proje nesne modeli (POM) kavramına dayanan Maven, bir projenin yapısını, raporlamasını ve belgelerini merkezi bir bilgi parçasından yönetebilir.Maven'ın projenize yardımcı olabileceğini düşünüyorsanız, navigasyonun "Maven Hakkında" bölümünde daha fazla bilgi bulabilirsiniz. </p>
          <footer class="more"><a href="#">Read More &raquo;</a></footer>
        </article>
        <!-- article 2 -->
        <article class="one_third">
          <h2>Spring framework</h2>
          <img src="http://www.unixstickers.com/image/cache/data/stickers/spring/spring-leaf.sh-340x340.png" alt=""  width="80px" height="80px">
			<p>Eklentileri ile birlikte Java Enterprise platform üzerinde web uygulamaları geliştirmek için de kullanılabilir. Spring Framework Java toplulukları arasında Enterprise JavaBean (EJB) modelinin yerine geçebilecek popüler bir alternatif haline gelmiştir.</p>
          <footer class="more"><a href="#">Read More &raquo;</a></footer>
        </article>
        <!-- article 3 -->
        <article class="one_third lastbox">
          <h2>Hibernate ORM</h2>
          <img src="http://www.gpsprogramys.com/icon/hibernate.png" alt=""  width="80px" height="80px">
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
          <figure><img src="http://www.jasypt.org/images/jasypt-small.png" width="215" height="100" alt="">
            <figcaption>
              <h2>Java Simplified Encryption</h2>
              <p>Jasypt is a java library which allows the developer to add basic encryption capabilities to his/her projects with minimum effort, and without the need of having deep knowledge on how cryptography works.</p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
        <article class="one_quarter">
          <figure><img src="https://store.ephox.com/wp-content/uploads/2017/08/tinymce-color-onlight-rgb.svg" width="215" height="100" alt="">
            <figcaption>
              <h2>TinyMCE</h2>
              <p>NTinyMCE (Tiny Moxiecode Content Editor) is a platform-independent, browser-based WYSIWYG editor control, written in JavaScript and released as open-source software under the LGPL by Ephox. It has the ability to convert HTML textarea fields or other HTML elements to editor instances. TinyMCE is designed to easily </p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
        <article class="one_quarter">
          <figure><img src="https://www.google.com/recaptcha/intro/images/hero-recaptcha-invisible.gif" width="215" height="100" alt="">
            <figcaption>
              <h2>GooglereCAPTCHA</h2>
              <p>Since the launch of No CAPTCHA reCAPTCHA, millions of internet users have been able to attest they are human with just a single click. Now we're taking it a step further and making it invisible. Human users will be let through without seeing the "I'm not a robot" checkbox, while suspicious ones and bots still have to solve the challenges. .</p>
              <footer class="more"><a href="#">Read More &raquo;</a></footer>
            </figcaption>
          </figure>
        </article>
        <article class="one_quarter lastbox">
          <figure><img src="http://www.multisoftsystems.com/blog/wp-content/uploads/2014/02/1957730.gif" width="215" height="100" alt="">
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
<!-- Footer -->
<div class="wrapper row3">
  <footer id="footer" class="clear">
    <p class="fl_left">Copyright &copy; 2017 - All Rights Reserved - <a href="https://github.com/Coder-ACJHP/Java-Arabic-Community">Java Arabic Community</a></p>
    <p class="fl_right"><a href="http://www.kariyer.net/ozgecmis/onur-isik">Coder ACJHP </a></p>
  </footer>
</div>
</body>
</html>
