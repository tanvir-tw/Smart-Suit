package com.erp.beans;

import java.sql.*;
public class ERP {
	Connection connmain=null;
	Statement stmain=null;

	public void getConnection(String MM_dbConn_DRIVER,String MM_dbConn_STRING,String MM_dbConn_USERNAME, String MM_dbConn_PASSWORD) {
		try{
			Class.forName(MM_dbConn_DRIVER); 
			connmain = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			stmain=connmain.createStatement();
		}catch (Exception e) {
			System.out.print("Connection Error");
		}
		
	}
	public Connection ReturnConnection() 
	{	
			return connmain;
	}
	public void closeConnection()
	{
		try{
			stmain.close();
			connmain.close();
			
		}catch (Exception e) {
			System.out.println("Exception-->"+e);
		}
	}

	
	
	
}
