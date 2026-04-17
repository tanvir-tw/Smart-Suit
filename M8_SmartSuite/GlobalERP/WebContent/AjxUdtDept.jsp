<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.ConnectionClass"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
Connection con = null;
Statement  st1=null,st2=null;
try {
	ConnectionClass connection = new ConnectionClass();
	 con = connection.getConnect("db_leaveapplication");
	System.out.println("con :::::::::::::::::: " + con);   
    st1 = con.createStatement();
    st2 = con.createStatement();


} catch (Exception e) {
    e.printStackTrace();
}
%>
<%
try
{
	String buffer="";
	String DeptCode="",CompCode="";
	String deptCode=request.getParameter("deptCode");
	String drop1="",drop2="";
	
	System.out.println("deptCode====================>>>>>"+deptCode);
	
	int ct=0;
	String delims12 = "[,]";
	String[] tokensEmail = deptCode.split(delims12);
	for(String t : tokensEmail)
	{
		if(ct==0)
		{
			DeptCode=t;
		}
		else
		{
			CompCode=t;
		}
		ct++;
	}
	buffer="#"+DeptCode+"#"+CompCode;
	//out.print("#"+DeptCode+"#"+CompCode);
	String DeptName="", hodName="",EmpName="",UnderDeptName="",status="";
	int UnderDeptCode=0,HODId=0;
	try
	{
		String sqlTst="select * from t_department where ComapanyCode="+CompCode+" and DeptCode="+DeptCode+"";
		ResultSet rs12=st1.executeQuery(sqlTst);
		if(rs12.next())
		{
			DeptName=rs12.getString("DeptName");
			UnderDeptCode=rs12.getInt("UnderDeptCode");
			HODId=rs12.getInt("HODId");
			status=rs12.getString("Status");
		}
		buffer=buffer+"#"+DeptName+"#"+UnderDeptCode+"#"+HODId;
		
		String sqlTst1="select * from t_department where ComapanyCode="+CompCode+" and DeptCode="+UnderDeptCode+"";
		System.out.println(sqlTst1);
		ResultSet rsTst=st1.executeQuery(sqlTst1);
		if(rsTst.next())
		{
			UnderDeptName=rsTst.getString("DeptName");
			System.out.println(UnderDeptName);
		}
		buffer=buffer+"#"+UnderDeptName;
		
		System.out.println(buffer);
		String sql123="select * from t_employee where CompanyCode="+CompCode+" and EmpID="+HODId+"";
		System.out.println(sql123);
		ResultSet rs123=st1.executeQuery(sql123);
		if(rs123.next())
		{
			hodName=rs123.getString("EmpName");
		}
		
		//============================================================
		drop1="<select name='undDept' id='undDept' class='formElement' style='width:100px;height: 20px; border: 1px solid black; border-color: activeborder;'>"+
		"<option value='Select'>Select</option>";
		String sqlUD="select * from t_department where ComapanyCode="+CompCode+" and DeptCode<>"+DeptCode+"";
		ResultSet rsUD=st2.executeQuery(sqlUD);
		while(rsUD.next())
		{
			drop1=drop1+" <option value='"+rsUD.getInt("DeptCode")+"'>"+rsUD.getString("DeptName")+"</option>";
		}
		drop1=drop1+"</select>";
		//============================================================
			
			
		//============================================================
		drop2="<select name='h1' id='h1' class='formElement' style='width:100px;height: 20px; border: 1px solid black; border-color: activeborder;'>"+
		"<option value='Select'>Select</option>";
		String sqlhd="select * from t_employee where CompanyCode="+CompCode+" and designation='HOD'";
		ResultSet rshd=st2.executeQuery(sqlhd);
		while(rshd.next())
		{
			drop2=drop2+" <option value='"+rshd.getInt("EmpID")+"'>"+rshd.getString("EmpName")+"</option>";
		}
		drop2=drop2+"</select>";
		//============================================================
		
		
		
		buffer=buffer+"#"+hodName+"#"+status+"#"+drop1+"#"+drop2;
		out.print(buffer);
	}
	catch(Exception e1)
	{
		System.out.println("Exception------------->>"+e1);
	}
	
}
catch(Exception e)
{
	System.out.println("Exception------------->>"+e);
}
%>