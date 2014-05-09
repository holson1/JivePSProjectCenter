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

public class Login extends HttpServlet {
	
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
		
		//get from user login form in index.jsp
		String name = request.getParameter("username");
		String pw = request.getParameter("password");

		response.setContentType("text/html");
		
		Connection con = DatabaseOps.dbConnect();
		
		//login query
		String query = 	"SELECT * " +
						"FROM user_info " +
						"WHERE username = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, name);
			
			ResultSet rs = pstmt.executeQuery();	
			
			//if the username isn't there, redirect w/ error message
			if(!rs.next()) {
				
				message = "Login failed. Please try again.";
				session.setAttribute("message", message);
				response.sendRedirect("../");
				return;
			}
			
			//if password isn't valid, redirect w/ error message
			if(!PasswordHash.validatePassword(pw, rs.getString("password"))) {
				
				message = "Login failed. Please try again.";
				session.setAttribute("message", message);
				response.sendRedirect("../");
				return;
			}
			
			//logged in successfully
			//store the user id and username in the session
			session.setAttribute("uid", rs.getInt(1));
			session.setAttribute("username", name);
		
			pstmt.close();
		} 
		catch (SQLException e) {
			response.getWriter().println("<p>Fatal SQL Error</p>");
			e.printStackTrace(response.getWriter());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace(response.getWriter());
		} catch (InvalidKeySpecException e) {
			e.printStackTrace(response.getWriter());
		}
		
		//send to home page
		response.sendRedirect("../home/myprojects/");
    }
}
