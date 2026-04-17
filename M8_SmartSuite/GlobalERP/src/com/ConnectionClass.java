package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionClass 
{

	 Connection con1=null;
	 Connection con2=null;
	 Connection con3=null;
	 Connection con4=null;
	
		String host1 = System.getenv("DB_GLOBALERP_HOST");
		String user1 = System.getenv("DB_GLOBALERP_USER");
		String pass1 = System.getenv("DB_GLOBALERP_PASS");
	 
	public  Connection getConnect(String DB) throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		if(DB.equals("db_GlobalERP"))
		{
			System.out.println("*********Raw Data********Connection Status:"+con1);
			if(con1 == null)
			{
				System.out.println("Connection null call");
				
				con1=DriverManager.getConnection("jdbc:mysql://"+host1+"/"+DB,user1,pass1);

				}
				
		return con1;
		}
	else if(DB.equals("db_leaveapplication"))
		{
		System.out.println("********GPS*********Connection Status:"+con2);
				if(con2 == null)
				{
					System.out.println("Connection null call");
					con2=DriverManager.getConnection("jdbc:mysql://"+host1+"/"+DB,user1,pass1);
				}
			
			return con2;
		}
	else
		{
					
		con4=DriverManager.getConnection("jdbc:mysql://"+host1+"/"+DB,user1,pass1);

		return con4;
		}
	}
}