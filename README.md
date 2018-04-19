<div align="center">
  <img src="https://github.com/Coder-ACJHP/Java-Arabic-Community/blob/master/WebContent/resources/images/Logo.png">
   <h3> 
    J.A.C (BETA) is free, open source Q&amp;A web application<br/> via Java EE</h3>
</div>
<p>Founded in 2016, Java Arabic Community is the stable, fast, secure online community for developers to learn, share their knowledge, and build their resumes. More than 100 professional and aspiring programmers visit Java Arabic Community each month to help solve coding problems, develop new skills.</p><br>
<h3>How to setup an instance or how to run ? </h3>
<p>First of all, you need to setup an MySQL databse and create schema named <code>java_arabic_community</code>.</p>
<ol>
 <li> Clone or download the sources from this page.</li>
 <li> Import <a>this .sql</a> file into your database.</li>
 <li> Import the project in your IDE and go to <code>/WebContent/WEB-INF/propfiles/connections.properties</code> and change property values with yours like db url, user, pwd etc..</li>
  <li>Save all changes then right click on project choose -> Run -> Maven built and write this command : <code>clean install package</code>.</li>
 <li> In terminal or command line go into project root folder and copy this line to deploy and run :
   <code>java -jar target/dependency/webapp-runner.jar target/*.war</code>
 </li>
</ol>
<div>
<h2>Test it in live demo site : </h2> 
<label><b>Important note : </b>It may work slow because it's working on free plan (Heroku dynos sleeping in 30 min) so if you get "Application error" just refresh the page and it will work.</label>
<a href="https://java-arabic-community.herokuapp.com">java-arabic-community.herokuapp.com/</a>
</div> 

<h2>Goals :</h2> 
Training, learning, and developing real application with Java and it's technologies.

<h2> Used technologies :</h2> 
So far following technologies are used :<a href="https://blogs.oracle.com/java/java-ee-8-overview">Java EE 7</a>, <a href="https://www.javascript.com/">Javascript</a>, <a href="https://spring.io/">Spring Framework 5.0.1</a>, <a href="http://hibernate.org/orm/documentation/5.0/">Hibernate 5.2.7</a>, <a href="https://github.com/jsimone/webapp-runner">Webapp runner (Tomcat 8.5)</a>, HTML5, CSS3, Maven, Bootsrap3,
<a href="https://www.tinymce.com/">TinyMCE</a> and JQuery 3.2.1</a>

<h2> Any question(s) ?</h2> 
For any question please email me at : <a href="mailto:hexa.octabin@gmail.com">hexa.octabin@gmail.com</a>

<h2> Finally : </h2> 
<label style="font-style: oblique; color:#ffa500; float:left;"> This project is being carried out by Coder ACJHP.</label><br>
<p>Thank you for reading...I hope this example project will help you</p>
<p>If you want to improve yourself and helping me join to project and commit!</p>

