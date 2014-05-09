<%@ page import="com.hco.app.*" %>

<%!
	String msg = "";
%>

<html>
<head>
	<title>Project Center</title>
	<link rel="stylesheet" type="text/css" href="styles/login.css">
	<link rel="stylesheet" type="text/css" href="styles/basic.css">
</head>
<body>
	<%
		//check for user login here
		if((session.getAttribute("uid")) != null)
			response.sendRedirect("home/myprojects/");
	%>

	<div id="title">	
		<h1>Jive PS Project Center</h1>	
	</div>

	<hr/>
	<div id="content">	
		<aside>	
			<h2>Sign up, it's simple!</h2>

			<%
			//check for message
			if((msg = (String) session.getAttribute("reg_message")) != null) {
				session.removeAttribute("reg_message");
				out.println("<p class=\"err_msg\">" + msg + "</p>");
			}
			%>

			<form action="./servlets/Register" method="post">
				<label>Username:</label>
				<input type="text" name="new_un">
				<br/>
				<label>Password:</label>
				<input type="password" name="new_pw">
				<br/>
				<label>Re-enter:</label>
				<input type="password" name="re_pw">
				<br/>
				<input type="submit" class="submit" value="Register >>">
			</form>	
		</aside>

		<div class="vr">
		</div>

		<div id="login">
			<h2>Login</h2>
		
			<%
			//check for message
			if((msg = (String) session.getAttribute("message")) != null) {
				session.removeAttribute("message");
				out.println("<p class=\"err_msg\">" + msg + "</p>");
			}
			%>
	
			<form action="./servlets/Login" method="post">
				<label>Username:</label>
				<input type="text" name="username">
				<br/>
				<label>Password:</label>
				<input type="password" name="password">
				<br/>
				<input type="submit" class="submit" value="Go >>">
			</form>
		</div>

	</div>

	<hr/>

	<div id="footer">
		<p><i>Created by Henry Olson, 2014</i></p>
	</div>

</body>
</html>
