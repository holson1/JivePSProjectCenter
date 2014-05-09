package com.hco.app;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Register extends HttpServlet {
	
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
		
		//new session
		HttpSession session = request.getSession();
		
		String message = new String();
		
		//TODO: use regex to make sure spaces aren't entered in usernames/passwords
		//TODO: parse for HTML special chars (using Jsoup jar)
		//get from registration form in index.jsp
		String new_un = request.getParameter("new_un").trim();
		String new_pw = request.getParameter("new_pw").trim();
		String re_pw = request.getParameter("re_pw").trim(); 

		response.setContentType("text/html");
		
		
		//**********
		//DB CONNECT
		//**********
		Connection con = DatabaseOps.dbConnect();
		
		//**************
		//CHECK USERNAME
		//**************
		String query = 	"SELECT * " +
						"FROM user_info " +
						"WHERE username = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, new_un);

			ResultSet rs = pstmt.executeQuery();	
			
			//if the username already exists in the db
			if(rs.next()) {
				
				message = "Sorry, that username is already taken.";
				session.setAttribute("reg_message", message);
				response.sendRedirect("../");
				return;
			}
		
			pstmt.close();
		}
		catch (SQLException e) {
			response.getWriter().println("<p>Fatal SQL Error</p>");
			e.printStackTrace(response.getWriter());
		}
		
		
		//**************
		//CHECK PW MATCH
		//**************
		if(!new_pw.equals(re_pw)) {
			message = "Passwords do not match. Please try again.";
			session.setAttribute("reg_message", message);
			response.sendRedirect("../");
			return;
		}
		
		
		//*************
		//HASH PASSWORD
		//*************
		try {
			new_pw = PasswordHash.createHash(new_pw);
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace(response.getWriter());
		} catch (InvalidKeySpecException e1) {
			e1.printStackTrace(response.getWriter());
		}
		
		
		//***************
		//CREATE NEW USER
		//***************
		query =	"INSERT INTO user_info (username, password) " +
				"VALUES (?,?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, new_un);
			pstmt.setString(2, new_pw);
			
			pstmt.executeUpdate();
			pstmt.close();
		}
		catch (SQLException e) {
			response.getWriter().println("<p>Fatal SQL Error</p>");
			e.printStackTrace(response.getWriter());
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace(response.getWriter());
		}
		
		//***********************
		//DISPLAY SUCCESS MESSAGE
		//***********************
		
		response.getWriter().println("<h1>Registration success!</h1>");
		response.getWriter().println("<p>You have successfully registered as user: " + new_un + "</p>");
		response.getWriter().println("<br/>");
		response.getWriter().println("<a href=\"../\">Please login to continue.</a>");
    }
}