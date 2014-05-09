<%@ page import="com.hco.app.*" %>
<%@ page import="java.sql.*" %>

<%!
	String name = "";
	String query = "";
	String message = "";
	String[] params = new String[8];
	int i;
	String selected = "";	
	String status = "";
	String referrer = "";
	ResultSet rs = null;
%>

<%

	if((name = (String) session.getAttribute("username")) == null) {
		response.sendRedirect("../../");		
		return;
	}

	//get the referrer
	referrer = request.getHeader("referer");

	//CLEAR PARAMETERS (so they don't remain after we navigate away)
	if(! referrer.endsWith("createnew/")) {

		for(i=0; i<8; i++) {
			session.removeAttribute("params[" + i + "]");
			params[i] = null;	
		}
		status = " ";
	}
	
	//fill in param array
	for(i=0; i<8; i++) {

		if(session.getAttribute("params[" + i + "]") != null) {	
		
			//for owner/details, we only want the value
			if(i == 1 || i == 7) {
				params[i] = (String) session.getAttribute("params[" + i + "]");
				continue;
			}

			//for status, we want the value and the additional string
			if(i == 2)	
				status = (String) session.getAttribute("params[" + i + "]");

			//everything else gets this string
			params[i] = "value='" + (String) session.getAttribute("params[" + i + "]") + "'";
		
		}
		//we don't want to see null, so replace it with this
		if(params[i] == null) params[i] = " ";

	}
	
%>

<html>
<head>
	<title>Project Center Login</title>
	<link rel = "stylesheet" type="text/css" href="../../styles/home.css">
	<link rel = "stylesheet" type="text/css" href="../../styles/createnew.css">
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
			<a class="menuitem" href="../myaccount/">My Account</a>
			<a id="logout" href="../../servlets/Logout">|  Logout</a>
			<p id="namedisp">Logged in as <%= name %></p>
		</div>

		<div id="newbanner">
			<a id="selected" class="menuitem">New Project</a>
			<a id="close" class="menuitem" href="../myprojects/">(close)</a>
		</div>
		<form id="newproj" action="../../servlets/NewProject" method="post">

			<br/>
			<input id="projectname" name="projectname" type="text" size="60" placeholder="Project title*" <%= params[0] %> />
			<p class="err_msg">
			<%
				//DISPLAY ERROR MSG
				if((message = (String) session.getAttribute("message")) !=null) {	
					session.removeAttribute("message");
					out.println(message);
				}
			%>
			 </p>
			<label>Owner*</label>
			<label>Status*</label>
			<label>Start date*</label>
			<select name="owner">
				<%
					//GET USER NAMES AND STORE THE LAST SELECTED
					query = "SELECT username FROM user_info";
					rs = DatabaseOps.selectQuery(query);

					try {
						while(rs.next()) {
							
							selected = "";

							name = rs.getString("username");

							if(name.equals(params[1]))
								selected = "selected";

							out.println("<option " + selected + " value=\"" + name + "\">" + name + "</option>");
						}
					}
					catch (SQLException e) {
					}
				%>
			</select>
			<select name="status">
				<option <%= params[2] %> > <%= status %> </option>
				<option value="newly created">newly created</option>
				<option value="active">active</option>
				<option value="completed">completed</option>
			</select>
			<input name="startdate" type="date" <%= params[3] %> />

			<br/>
			<br/>
			<label>Client*</label>
			<label>Sale amount*</label>
			<label>End Date*</label>
			<input name="client" type="text" size="50" <%= params[4]  %> />
			<input name="amount" type="text" size="8" <%= params[5] %> />
			<input name="enddate" type="date" <%= params[6] %> />

			<br/>
			<br/>
			<label>Project details</label>
			<br/>
			<textarea id="details" name="details" maxlength="5000"> <%= params[7] %> </textarea>
			<br/>
			<br/>
			<input class="submit" type="submit" value="Create"/><label>* = required</label>	
		</form>

	</div>
	
	<hr/>

	<div id="footer">
		<p><i>Created by Henry Olson, 2014</i></p>
	</div>
</body>
</html>
