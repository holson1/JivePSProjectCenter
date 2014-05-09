package com.hco.app;

import java.sql.*;

public class DatabaseOps {
	
	public static Connection dbConnect() {
		
		//check for JDBC driver
		try {
			Class.forName("org.postgresql.Driver");
		} 
		catch (ClassNotFoundException e) {
		}
		
		//remote, jetty
		//String url = "jdbc:postgresql://broncoswap.csproject.org/jive_project";
		//home, jetty
		String url = "jdbc:postgresql://10.0.0.253/jive_project";
		//tomcat deploy
		//String url = "jdbc:postgresql:jive_project";
		
		Connection con = null;
		try {
			con = DriverManager.getConnection(url, "demo", "hpw93");
		} 
		catch (SQLException e) {
		}
		return con;
	}
	
	public static ResultSet selectQuery(String query) {
		
		Connection con = null;
		
		//connect to DB
		con = DatabaseOps.dbConnect();
		
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
		}
		catch(SQLException e) {
		}
		
		try {
			con.close();
		} catch (SQLException e) {
		}
		
		return rs;
		
	}
}