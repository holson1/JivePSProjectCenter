<%@ page import="com.hco.app.*" %>
<%@ page import="java.sql.*" %>

<%!
	String name = "";
	String query = "";
	String projName = "";
	String client = "";
	String status = "";
	int pid = 0;
	ResultSet rs = null;
%>

<html>
<head>
	<title>Project Center Login</title>
	<link rel="stylesheet" type="text/css" href="../../styles/home.css">
	<link rel="stylesheet" type="text/css" href="../../styles/myprojects.css">
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
			<a id="selected" class="menuitem" href="./">My Team</a>
			<a class="menuitem" href="../myaccount/">My Account</a>
			<a id="logout" href="../../servlets/Logout">|  Logout</a>
			<p id="namedisp">Logged in as <%= name %></p>
		</div>
			
		<p>Welcome, <%= name %>!</p>


		<h3 id="mystats">Team stats</h3>
		<a id="createnew" href="../createnew/">Create new project</a>
		<h3>All PS projects</h3>

		<div id="stats" class="myprojects">
			<% 
				//projects completed
				query = "SELECT COUNT(pid) " +
			       		"FROM project_info p " +
					"WHERE p.status = 'completed'"; 
				rs = DatabaseOps.selectQuery(query);

				try {
					while(rs.next()) {
						pid = rs.getInt(1);
						
						out.println("<h1 class=\"statnum\">" + pid + "</h1>");
						out.println("<p>total projects completed</p>");
					}
				}
				catch (SQLException e) {
				}
			%>
		</div>

		<div id="projects" class="myprojects">
			<%
				query = "SELECT pid, username, project_name, client, status " +
					"FROM project_info p, user_info u " +
					"WHERE p.uid = u.uid " +
					"ORDER BY status, project_name"; 
					
				rs = DatabaseOps.selectQuery(query);

				try {
					while(rs.next()) {
						pid = rs.getInt("pid");
						name = rs.getString("username");	
						projName = rs.getString("project_name");
						client = rs.getString("client");
						status = rs.getString("status");

						out.println("<a class=\"project_link\" href=\"../project/?pid=" + pid + "\">" + projName + "</a>");

						if(status.equals("active"))
							out.println("<p class=\"project_active\">" + client + " | Owner: " + name + " | Status: " + status + "</p>");
						else if(status.equals("completed"))
							out.println("<p class=\"project_comp\">" + client + " | Owner: " + name + " | Status: " + status + "</p>");
						else
							out.println("<p class=\"project_new\">" + client + " | Owner: " + name + " | Status: " + status + "</p>");
					}
				}
				catch (SQLException e) {
				}
			%>
		</div>

	</div>
	
	<hr/>

	<div id="footer">
		<p><i>Created by Henry Olson, 2014</i></p>
	</div>
</body>
</html>
