<%@ page import="com.hco.app.*" %>
<%@ page import="java.sql.*" %>

<%!
	String name = "";
	String query = "";
	String projName = "";
	String client = "";
	String status = "";
	Integer uid;
	int pid = 0;
	int truncatedOwnership = 0;
	double myActive;
	double ownership;
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
		
		uid = (Integer) session.getAttribute("uid");
	%>

	<div id="title">
		<h1>Jive PS Project Center</h1>
	</div>

	<hr/>

	<div id="content">

		<div id="banner">
			<a id="selected" class="menuitem" href="./">My Projects</a>
			<a class="menuitem" href="../myteam/">My Team</a>
			<a class="menuitem" href="../myaccount/">My Account</a>
			<a id="logout" href="../../servlets/Logout">|  Logout</a>
			<p id="namedisp">Logged in as <%= name %></p>
		</div>
			
		<p>Welcome, <%= name %>!</p>


		<h3 id="mystats">My stats</h3>
		<a id="createnew" href="../createnew/">Create new project</a>
		<h3>My projects</h3>

		<div id="stats" class="myprojects">
			<% 
				//projects completed
				query = "SELECT COUNT(pid) " +
			       		"FROM project_info p, user_info u " +
					"WHERE u.uid = p.uid " +
					"AND p.uid = " + uid + " AND p.status = 'completed'";
				rs = DatabaseOps.selectQuery(query);

				try {
					while(rs.next()) {
						pid = rs.getInt(1);
						
						out.println("<h1 class=\"statnum\">" + pid + "</h1>");
						out.println("<p>Lifetime projects completed</p>");
					}
				}
				catch (SQLException e) {
				}

				//percent of active projects
				query = "SELECT COUNT(pid) " +
					"FROM project_info p, user_info u " +
					"WHERE u.uid = p.uid " +
					"AND p.uid = " + uid + " AND p.status = 'active'";
				rs = DatabaseOps.selectQuery(query);

				try {
					rs.next();
					myActive = rs.getInt(1);
				}
				catch (SQLException e) {
				}

				query = "SELECT COUNT(pid) " +
					"FROM project_info p " +
					"WHERE p.status = 'active'";
				rs = DatabaseOps.selectQuery(query);

				try {
					rs.next();
					ownership = rs.getInt(1);
				}
				catch (SQLException e) {
				}

				ownership = (myActive / ownership) * 100;
				truncatedOwnership = (int) ownership;
				out.println("<h1 class=\"statnum\">" + truncatedOwnership + "%</h1>");
				out.println("<p>ownership of all active projects</p>"); 
						
			%>
		</div>

		<div id="projects" class="myprojects">
			<%
				query = "SELECT pid, project_name, client, status " +
					"FROM project_info p, user_info u " +
					"WHERE u.uid = p.uid " +
					"AND p.uid = " + uid + " " +  
					"ORDER BY status, project_name";
					
				rs = DatabaseOps.selectQuery(query);

				try {
					while(rs.next()) {
						pid = rs.getInt("pid");
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
