package com.erp.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class LedgerUpdatation {
	

	
	public void calulation(String customercodes,String comid)
	{
	//String customercodes= request.getParameter("customercodes");
	System.out.println("cusotmercodes"+customercodes);
	
	Connection con1=null;
	String DB_Driver="com.mysql.cj.jdbc.Driver";
	 String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
	//String DB_NAME="jdbc:mysql://202.65.131.44:3306/twsql_twalldata";
	//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/twsql_twalldata";
	String DB_USERNAME="erp";
	String DB_PASSWORD="1@erp";
	
	
	try
	{
			Class.forName(DB_Driver);
			con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
			
			System.out.println("Connection Created*******"+con1);
			Statement st1=con1.createStatement();
			String sql1="";
			ResultSet rs1=null;
			Statement st2=con1.createStatement();
			ResultSet rs2=null;
			String sql="SELECT * FROM  "+comid+"customerledgeraccount where CustomerCode="+customercodes+" order by TransactionDate,transactionid ASC";
			
		//	String sql="SELECT * FROM  t_customerledgeraccount as tc,t_invoicedet as ti  where tc.CustomerCode='"+  customercodes+"' and tc.TransactionDetail=ti.invoicerefno and ti.InvoiceCancelled<>'1'  order by TransactionDate,transactionid ASC";
			System.out.println("sql#@#@#@#@"+sql);
			rs1=st1.executeQuery(sql);
			double balance = 0;
			double debitamount=0;
			double creditamount=0;
			double transactionid=0;
	       	while(rs1.next())
			{
	       		//System.out.println("1");
	       		transactionid=rs1.getDouble("transactionid");
	       	//	System.out.println("2");
			    debitamount=rs1.getDouble("debitamount");
			//    System.out.println("3");
			    creditamount=rs1.getDouble("creditamount");
			//    System.out.println("4");
			    balance = balance + debitamount-creditamount;
			//    System.out.println("5");
			    sql1 = "UPDATE "+comid+"customerledgeraccount set balance="+balance+" where transactionid="+transactionid;
			    st2.executeUpdate(sql1);
			//    System.out.println("sql1##@@#@#@#@#@@##"+sql1);
			 //   System.out.println("debitamount: "+debitamount+" Creditamount: "+creditamount+" Balance :"+balance);
			}
	}
	catch (Exception e)
	{
		
	}
	
	}//end of function

}
