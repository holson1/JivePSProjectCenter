<%@ page import="com.hco.app.*" %>
<%@ page import="java.sql.*" %>

<%!
	String name = "";
	String query = "";
	String message = "";
	String pidString;
	String[] params = new String[8];
	String[] values = new String[8];
	String status = "";
	int i, pid;
	String selected = "";	
	ResultSet rs = null;
%>

<%
	//GRAB PROJECT INFO

	//get pid
	pidString = (String) request.getParameter("pid");
	pid = Integer.valueOf(pidString);	

	//query
	query = "SELECT username, project_name, client, sale_amount, start_date, end_date, details, status " +
		"FROM project_info p, user_info u " +
       		"WHERE u.uid = p.uid AND pid = " + pid; 
	rs = DatabaseOps.selectQuery(query);

	try {
		rs.next();
		values[0] = "value=\"" + rs.getString("project_name") + "\"";
		values[1] = rs.getString("username");
		status = rs.getString("status");
		values[2] = "value=\"" + rs.getString("status") + "\"";
		values[3] = "value=\"" + String.valueOf(rs.getDate("start_date")) + "\"";
		values[4] = "value=\"" + rs.getString("client") + "\"";
		values[5] = "value=\"" + String.valueOf(rs.getInt("sale_amount")) + "\"";
		values[6] = "value=\"" + String.valueOf(rs.getDate(6)) + "\"";
		values[7] = rs.getString(7);
	}
	catch(SQLException e) {
	}
%>

<html>
<head>
	<title>Project Center Login</title>
	<link rel = "stylesheet" type="text/css" href="../../styles/home.css">
	<link rel = "stylesheet" type="text/css" href="../../styles/createnew.css">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
	<script type="text/javascript" src="../../javascript/functions.js"></script>
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
			<a id="selected" class="menuitem">Project view</a>
			<a id="close" class="menuitem" href="../myprojects/">(close)</a>
		</div>

		<form id="newproj" action="../../servlets/UpdateProject" method="post">

			<br/>
			<input id="projectname" name="projectname" type="text" size="60" <%= values[0] %> />
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

							if(name.equals(values[1]))
								selected = "selected";

							out.println("<option " + selected + " value=\"" + name + "\">" + name + "</option>");
						}
					}
					catch (SQLException e) {
					}
				%>
			</select>
			<select name="status">
				<option <%= values[2] %> selected> <%= status %></option> 
				<option value="newly created">newly created</option>
				<option value="active">active</option>
				<option value="completed">completed</option>
			</select>
			<input name="startdate" type="date" <%= values[3] %> >

			<br/>
			<br/>
			<label>Client*</label>
			<label>Sale amount*</label>
			<label>End Date*</label>
			<input name="client" type="text" size="50" <%= values[4]  %> >
			<input name="amount" type="text" size="8" <%= values[5] %> >
			<input name="enddate" type="date" <%= values[6] %> >

			<br/>
			<br/>
			<label>Project details</label>
			<br/>
			<textarea id="details" name="details" maxlength="5000" > <%= values[7] %></textarea>
			<br/>
			<br/>
			<input type="hidden" name="pid" value=<%=pid%> />
			<input class="submit" type="submit" value="Update"/>
			<button id="delete" class="submit" type="button" >Delete</button><label>* = required</label>
			<div id="warning">
				<p><b>Are you sure you want to delete?</b></p>
				<button class="submit" formaction="../../servlets/DeleteProject">Yes</button>
				<button id="del_no" type="button" class="submit">No</button>
			</div>
		</form>

		<script>
		/*	$('#delete').click(function() {
				$('#warning').toggle();   	
			});

			$('#del_no').click(function() {
				$('#warning').toggle();
			});*/
		</script>
	</div>
	
	<hr/>

	<div id="footer">
		<p><i>Created by Henry Olson, 2014</i></p>
	</div>
<%
	//CLEAR PARAMETERS (so they don't remain after we navigate away)
	for(i=0; i<params.length; i++) {
		session.removeAttribute("params[" + i + "]");
	}
%>
</body>
</html>
