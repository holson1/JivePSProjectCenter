package com.hco.app;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NewProject extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	//servlet should not be accessible by GET, so send the correct redirect if the user tries to
	//navigate here
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
			
		HttpSession session = request.getSession();
		if(session.getAttribute("uid") == null)
			response.sendRedirect("../");
		else
			response.sendRedirect("../home/myprojects/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String message = "";
		String query = "";
		int userid = 0, amount;
		
		//regex for removing HTML tags
		String regex = "\\<.*?>";
		
		String[] params = new String[8];
		
		//get POST parameters and sanitize
		params[0] = request.getParameter("projectname").trim().replaceAll(regex, "");
		params[1] = request.getParameter("owner");
		params[2] = request.getParameter("status");
		params[3] = request.getParameter("startdate");
		params[4] = request.getParameter("client").trim().replaceAll(regex, "");
		params[5] = request.getParameter("amount").trim().replaceAll(regex, "");
		params[6] = request.getParameter("enddate");
		params[7] = request.getParameter("details").trim().replaceAll(regex, "");
		
		//check for empty parameters and save entered parameters in the session
		for(int i=0; i<params.length-1; i++) {
			if(params[i].isEmpty())
				message = "Please fill in all required fields. ";
		}
		
		//regex amount (numbers only)
		if(!params[5].matches("^[0-9]*$"))
			message += "Sale amount may only include digits 0-9.";
		
		//if there's an error message, send the user back to the form w/ params
		if(! message.isEmpty()) {
			
			//set session attributes
			for(int i=0; i<params.length; i++)
				session.setAttribute("params[" + i + "]", params[i]);
		
			session.setAttribute("message", message);
			response.sendRedirect("../home/createnew/");
			return;
		}
		
		//convert sale amount to int
		amount = Integer.valueOf(params[5]);
		
		//convert date strings to dates
		Date start_date = Date.valueOf(params[3]);
		Date end_date = Date.valueOf(params[6]);
		
		//get user id from username
		query = "SELECT uid FROM user_info WHERE username='" + params[1] + "'";
		ResultSet rs = DatabaseOps.selectQuery(query);
		
		try {
			rs.next();
			userid = rs.getInt(1);
		}
		catch(SQLException e) {
		}
		
		//CONNECT TO DB
		Connection con = DatabaseOps.dbConnect();
		
		//create prepared query
		query = "INSERT INTO project_info (uid, project_name, client, sale_amount, start_date, end_date, details, status) " +
				"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, userid);
			pstmt.setString(2, params[0]);
			pstmt.setString(3, params[4]);
			pstmt.setInt(4, amount);
			pstmt.setDate(5, start_date);
			pstmt.setDate(6, end_date);
			pstmt.setString(7, params[7]);
			pstmt.setString(8, params[2]);
			
			pstmt.execute();
			
			pstmt.close();
		}
		catch(SQLException e) {
			e.printStackTrace(response.getWriter());
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace(response.getWriter());
		}
		
		response.sendRedirect("../home/myprojects/");
	}
}