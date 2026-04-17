<%@page import="java.sql.*"%>
<%@ page language="java"%>
<%@page import="com.ConnectionClass"%> 

<%
Connection conn=null;
Statement st=null, st2= null;
ConnectionClass connection= new ConnectionClass();

try
{
		conn = connection.getConnect("db_leaveapplication");
		 st=conn.createStatement();
		 st2 = conn.createStatement();
	String deptid="-",hodid="-",unamemailid="";
	String empid=request.getParameter("empid");	
	System.out.println("-------empid-->>"+empid);
	
	String buffer="#";
	String dt="";
	int a=0;
	String s="select ReportingtoHod   from  t_leaveadmin  where empid='"+empid+"'  and status='Yes'  ";
	ResultSet rs=st.executeQuery(s);
	System.out.println("-------s->>"+s);
	if(rs.next())
	{
		deptid=rs.getString("ReportingtoHod");
	}
	
	System.out.println("-------deptid->>"+deptid);
	System.out.println("-------hodid->>"+hodid);
	
	String s2="select UName   from t_leaveadmin  where EmpID='"+deptid+"' ";
	ResultSet rs2=st2.executeQuery(s2);
	System.out.println("-------s2->>"+s2);
	if(rs2.next())
	{
		unamemailid=rs2.getString("UName");
	}
	
	System.out.println("-------unamemailid->>"+unamemailid);
	
	out.print(unamemailid+"#");
	System.out.println("--------->>"+buffer);
}
catch(Exception e)
{
	System.out.println("Excepton---AjxChkInOutDept--->>"+e);
}
%>