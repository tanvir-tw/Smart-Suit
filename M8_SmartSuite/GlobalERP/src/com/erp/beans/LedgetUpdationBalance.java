package com.erp.beans;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LedgetUpdationBalance {
	
	Connection con1=null;
	
	public Connection getConnection()
	{
		
		String DB_Driver="com.mysql.cj.jdbc.Driver";
		
		String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
		String DB_USERNAME="erp";
		String DB_PASSWORD="1@erp";
		
		try {
			Class.forName(DB_Driver);
			con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("Connection Created*******"+con1);
		return con1;
	}
	
	public void closeConnection()
	{
		try {
			
			System.out.println("Inside Close Connection");
			if(con1.isClosed()==false)
			{
				con1.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public void calulation(String customercodes)
	{

	System.out.println("cusotmercodes"+customercodes);
	
	
	
	
	try
	{
			
			Statement st1=con1.createStatement();
			String sql1="";
			ResultSet rs1=null;
			Statement st2=con1.createStatement();
		
			String sql="SELECT * FROM  t_customerledgeraccount where CustomerCode="+customercodes+" order by TransactionDate,transactionid ASC";
			
		//	String sql="SELECT * FROM  t_customerledgeraccount as tc,t_invoicedet as ti  where tc.CustomerCode='"+  customercodes+"' and tc.TransactionDetail=ti.invoicerefno and ti.InvoiceCancelled<>'1'  order by TransactionDate,transactionid ASC";
			System.out.println("sql#@#@#@#@"+sql);
			rs1=st1.executeQuery(sql);
			double balance = 0;
			double debitamount=0;
			double creditamount=0;
			double transactionid=0;
	       	while(rs1.next())
			{
	       		
	       		transactionid=rs1.getDouble("transactionid");
	       		
			    debitamount=rs1.getDouble("debitamount");
			    
			    creditamount=rs1.getDouble("creditamount");
			    
			    balance = balance + debitamount-creditamount;
			    
			    sql1 = "UPDATE t_customerledgeraccount set balance="+balance+" where transactionid="+transactionid;
			    st2.executeUpdate(sql1);
			    System.out.println("sql1##@@#@#@#@#@@##"+sql1);
			    System.out.println("debitamount: "+debitamount+" Creditamount: "+creditamount+" Balance :"+balance);
			}
	}
	catch (Exception e)
	{
		
	}
	
	}//end of function
	
	public void deleteCloseInvoiceCustomerledger()
	{

	
		
		System.out.println("cusotmercodes");
	
	try
	{
			
		LedgetUpdationBalance bConn =new LedgetUpdationBalance();
		Connection con1=bConn.getConnection();
			Statement st1=con1.createStatement();
			
			Statement st2=con1.createStatement();
		
			ResultSet rs1=null;
			String sqlCloseInvoice="",sqlDeleteInvopice="",CloseIvoce="";
			int cnt =0,cnt1 =0;
			sqlCloseInvoice="SELECT invoiceRefNo FROM t_invoicedet where  InvoiceCancelled='1' order by invoiceno desc  ";
			System.out.println("sql#@#@#@#@"+sqlCloseInvoice);
			rs1=st1.executeQuery(sqlCloseInvoice);
		
	       	while(rs1.next())
			{
	       	
	       		CloseIvoce=rs1.getString("invoiceRefNo");
	       		
	       	 System.out.println("Invoice Stt==>"+CloseIvoce);
			    
			    sqlDeleteInvopice = "delete from  t_customerledgeraccount  where transactiondetail='"+CloseIvoce+"'";
			    int s=st2.executeUpdate(sqlDeleteInvopice);
			    if(s==0)
			    {
			    	cnt1++;
			    }else
			    {
			    	cnt++;
			    }
			    System.out.println("Success Status==>"+s);
			    System.out.println("sql1##@@#@#@#@#@@##"+sqlDeleteInvopice);
			}
	       	
	       	System.out.println("invoice Not deleted"+cnt+"invoice  deleted"+cnt1);
	}
	catch (Exception e)
	{
		
	}
	
	}//end of function

	public void getCustomerId()
	{
		LedgetUpdationBalance b =new LedgetUpdationBalance();
		Connection conNew=b.getConnection();
		Statement st1;
		try {
			int cnt=0;
			String customercodes=""; 
			st1 = conNew.createStatement();
			String sqlCustomerCode="select  CustomerCode from twsql_twalldata.t_customerdet";
			System.out.println("sql#@#@#@#@"+sqlCustomerCode);
			ResultSet rsNew=st1.executeQuery(sqlCustomerCode);
			while(rsNew.next())
			{
				customercodes=rsNew.getString("CustomerCode");
				b.calulation(customercodes);
				++cnt;
				
			}
			
			System.out.println("CUSTOMER UPDATION ID=@#%@#@%%@@$%$#%$%$@$@$%#%#==>"+cnt);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	public static void main(String[] args) 
	{
		
		
		LedgetUpdationBalance lb=new LedgetUpdationBalance();
		LedgetUpdationBalance lbDel=new LedgetUpdationBalance();
		
		System.out.println("before deleteing invoice" );
		lbDel.deleteCloseInvoiceCustomerledger();
		System.out.println("After Deleting invoice");
		
		System.out.println("testtt===>");
		lb.getCustomerId();
		
		

	}

}
