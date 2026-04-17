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
Statement  st1=null, st2=null;
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

	String cmpCode=request.getParameter("cmpCode");
	String cmpCd="";

	// Handle both "1" and "17,1" format
	if(cmpCode.contains(",")) {
	    cmpCd = cmpCode.split(",")[1].trim();  // take CompanyCode part
	} else {
	    cmpCd = cmpCode.trim();
	}
	String sqlDept="select * from t_department where ComapanyCode="+cmpCd+" and DeptName not in('MD', 'Devlopment') ORDER BY `DeptName` ASC";
	ResultSet rsDept=st1.executeQuery(sqlDept);
	%><option value="select">Select</option>
	<%
	while(rsDept.next())
	{ 
		%>
	<option value="<%=rsDept.getInt("DeptCode")+","+cmpCd %>">
		<%=rsDept.getString("DeptName") %>
	</option>
	<%
	}
	
}
catch(Exception e)
{
	System.out.println("Exception------------->>"+e);
}
%>
</body>
</html>