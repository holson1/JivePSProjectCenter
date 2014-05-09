package com.hco.app;

import java.io.IOException;
import java.sql.*;

import javax.servlet.http.*;
import javax.servlet.*;

public class DeleteProject extends HttpServlet {

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
		
		int pid = Integer.valueOf(request.getParameter("pid"));
		
		//CONNECT TO DB
		Connection con = DatabaseOps.dbConnect();
		
		//create prepared query
		String query = 	"DELETE FROM project_info " +
						"WHERE pid = " + pid;
		
		try {
			Statement stmt = con.createStatement();
			stmt.execute(query);
			
			stmt.close();
			con.close();
		}
		catch(SQLException e) {
			e.printStackTrace(response.getWriter());
		}
		
		response.sendRedirect("../home/myprojects/");
	}
}
