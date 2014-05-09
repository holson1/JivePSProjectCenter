<%!
	String name = "";
%>

<html>
<head>
	<title>Project Center Login</title>
	<link rel = "stylesheet" type="text/css" href="../../styles/home.css">
</head>
<body>
	<%
		if((name = (String) session.getAttribute("username")) == null) {
			response.sendRedirect("../../");		
		}
	%>

	<div id="title">
		<h1>Jive PS Project Center</h1>
	</div>

	<hr/>

	<div id="content">

		<div id="banner">
			<a class="menuitem" href="../myprojects/">My Projects</a>
			<a class="menuitem" href="../myteam/">My Team</a>
			<a id="selected" class="menuitem" href="./">My Account</a>
			<a id="logout" href="../../servlets/Logout">|  Logout</a>
			<p id="namedisp">Logged in as <%= name %></p>
		</div>

		<p>Under construction :)</p>
	</div>
	
	<hr/>

	<div id="footer">
		<p><i>Created by Henry Olson, 2014</i></p>
	</div>
</body>
</html>
