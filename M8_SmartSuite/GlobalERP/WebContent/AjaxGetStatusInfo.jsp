<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="conn.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
<%
String name=request.getParameter("name");
String status="";
System.out.println("Ajax Page"+name);

Connection con=null ;
try
{
Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st=null;
 
st=con.createStatement();
String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupName='"+name+"'";
System.out.println(sql);
ResultSet rs=st.executeQuery(sql);
while(rs.next()){
	status=rs.getString("Status");
	if(status.equalsIgnoreCase("Active"))
	{
	out.println(status);
	}else
	{
		out.println("<font color='red'>"+status+"</font>");
	}
	
	}
}catch(Exception e){
	System.out.println(e);
	
}
System.out.println(status);
%>
</body>
</html>