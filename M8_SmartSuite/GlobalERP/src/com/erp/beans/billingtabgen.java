package com.erp.beans;
import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.*;


public class billingtabgen 
{

	public billingtabgen() 
	{
		
	}

	
	public static void main(String[] args) 
	{
		try
		{
		Connection conn = null, conn1=null;
		Statement sterp = null, sterp1 = null, sterp2=null, sterp3=null, sterp4=null, sterp5=null, stqr=null, stsql1=null,stsql2=null;
		ResultSet rs = null;
		//String DB_NAME="jdbc:mysql://103.8.126.138:3306/db_gps";
		//String DB_NAME="jdbc:mysql://192.168.2.55:3306/db_gps";
		String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_gps";
		//String DB_NAME1="jdbc:mysql://103.8.126.138:3306/twsql_twalldata";
		//String DB_NAME1="jdbc:mysql://192.168.2.55:3306/twsql_twalldata";
		String DB_NAME1="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
		String DB_USERNAME="erp";
		String DB_PASSWORD="1@erp";
		Class.forName("com.mysql.cj.jdbc.Driver");
		//conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		conn1=DriverManager.getConnection(DB_NAME1,DB_USERNAME,DB_PASSWORD);
		sterp = conn1.createStatement();
		sterp1 = conn1.createStatement();
		sterp2 = conn1.createStatement();
		sterp3 = conn1.createStatement();
		sterp4 = conn1.createStatement();
		sterp5 = conn1.createStatement();
		stsql1= conn1.createStatement();
		stsql2= conn1.createStatement();
		
		int currentmonthcount=0,currentyearcount=0;
		int previousmonth=0, ppreviousmonth=0;
		int previousyear=0, ppreviousyear=0;
		String finalmonth="";
		String currentyear="", fppreviousmonth = "";
		String sql = null;
		String fpreviousmonth="";
		
		Date tdy = new java.util.Date();
		String todaysDate = new SimpleDateFormat("yyyy-MM-dd").format(tdy);
		System.out.println("todaysdate is"+todaysDate);
		String currentmonth="select MONTH('"+todaysDate+"')";
		System.out.println(currentmonth);
		ResultSet rsMonth=stsql1.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);
		System.out.println("currentmonthcount is"+currentmonthcount);

		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
		//if(currentmonthcount==1)
		{
		finalmonth="0"+currentmonthcount;
		}
		else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
		{
		finalmonth=Integer.toString(currentmonthcount);
		}		

		System.out.println("final month is "+finalmonth);

		currentyear="select YEAR('"+todaysDate+"')";
		System.out.println(currentyear);
		ResultSet rsYear=stsql2.executeQuery(currentyear);
		rsYear.next();
		currentyearcount=rsYear.getInt(1);

		System.out.println("currentyearcount is "+currentyearcount);  

		if(currentmonthcount==1)
		{
		previousyear=currentyearcount-1;
		previousmonth=12;

//			currentmonthcount=12;
		}
		else 
		{
		previousyear=currentyearcount;
		System.out.println("finalmonth is "+finalmonth);
		previousmonth=Integer.parseInt(finalmonth)-1;
		System.out.println("previousmonth is  "+previousmonth);
		}
		if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
			//if(previousmonth==1)
			{
				fpreviousmonth="0"+Integer.toString(previousmonth);
			}
			else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
			{
				fpreviousmonth=Integer.toString(previousmonth);
			}

		/************************************************************************/
		if(previousmonth==1)
		{
			ppreviousyear=previousyear-1;
			ppreviousmonth=12;
		    
			//	currentmonthcount=12;
		}
		else 
		{
			ppreviousyear=previousyear;
			System.out.println("final previous month is  "+fpreviousmonth);
			ppreviousmonth=Integer.parseInt(fpreviousmonth)-1;
			System.out.println("pprevious month is  "+ppreviousmonth);
		}
		if(ppreviousmonth==1 || ppreviousmonth==2 || ppreviousmonth==3 || ppreviousmonth==4 || ppreviousmonth==5 || ppreviousmonth==6 || ppreviousmonth==7 || ppreviousmonth==8 || ppreviousmonth==9 )
			//if(previousmonth==1)
			{
				fppreviousmonth="0"+Integer.toString(ppreviousmonth);
			}
			else if(ppreviousmonth==10 || ppreviousmonth==11 || ppreviousmonth==12)
			{
				fppreviousmonth=Integer.toString(ppreviousmonth);
			}
		
		
		  String createbillingdetails = "CREATE TABLE  twsql_twalldata.t_billingdetails"+previousyear+"_"+fpreviousmonth+" like twsql_twalldata.t_billingdetails"+ppreviousyear+"_"+fppreviousmonth;		
		  System.out.println("before executing createbillingdetails "+createbillingdetails);
		  sterp.executeUpdate(createbillingdetails);
		  System.out.println("after executing createbillingdetails "+createbillingdetails);
		  
		  String insertbillingdetails="insert into twsql_twalldata.t_billingdetails"+previousyear+"_"+fpreviousmonth+" (select * from db_gps.t_billingdetails where month1 = '"+previousyear+"-"+fpreviousmonth+"-01')";
		  System.out.println("before executing insertbillingdetails : "+insertbillingdetails);
		  sterp1.executeUpdate(insertbillingdetails);
		  System.out.println("after executing insertbillingdetails : "+insertbillingdetails);
		  
		  String createtfverp="CREATE TABLE twsql_twalldata.t_fv_erp_relation"+previousyear+"_"+fpreviousmonth+" like twsql_twalldata.t_fv_erp_relation"+ppreviousyear+"_"+fppreviousmonth;
		  System.out.println("before executing tfverp "+createtfverp);
		  sterp2.executeUpdate(createtfverp);
		  System.out.println("after executing tfverp "+createtfverp);

		  String inserttfverp="insert into twsql_twalldata.t_fv_erp_relation"+previousyear+"_"+fpreviousmonth+" (select * from twsql_twalldata.t_fv_erp_relation"+ppreviousyear+"_"+fppreviousmonth+")";
		  System.out.println("before executing inserttfverp"+inserttfverp);
		  sterp3.executeUpdate(inserttfverp);
		  System.out.println("after executing inserttfverp"+inserttfverp);
		  
		  System.out.println("This step needs to be done after billing is completed, because new vehicles are yet to be added");
		  //db_gps.t_fv_erp_relation
		  String deletegpstfverp = "delete from db_gps.t_fv_erp_relation";
		  System.out.println("before executing deletegpstfverp"+deletegpstfverp);
		  sterp5.executeUpdate(deletegpstfverp);
		  System.out.println("after executing deletegpstfverp"+deletegpstfverp);
		  
		  String insertgpstfverp="insert into db_gps.t_fv_erp_relation (select * from twsql_twalldata.t_fv_erp_relation"+previousyear+"_"+fpreviousmonth+")";
		  System.out.println("before executing insertgpstfverp"+insertgpstfverp);
		  sterp4.executeUpdate(insertgpstfverp);
		  System.out.println("after executing insertgpstfverp"+insertgpstfverp);
		  System.out.println("operation done successfully");
		  
		}
				
		
		catch(Exception e)
		{
			System.out.println(e);
		}

	}

}
