<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
System.out.println("in test");
try
{
	String host = System.getenv("DB_GLOBALERP_HOST");
	String user = System.getenv("DB_GLOBALERP_USER");
	String pass = System.getenv("DB_GLOBALERP_PASS");
	
Connection conn = null, cn = null;
Statement st = null, st1 = null, st3 = null, st4 = null;
String DBDriver="com.mysql.cj.jdbc.Driver";
String DBNAME="jdbc:mysql://"+host+"/db_GlobalERP";
String DBUSERNAME=user;
String DBPASSWORD=pass;
Class.forName(DBDriver);
cn = DriverManager.getConnection(DBNAME,DBUSERNAME,DBPASSWORD);
st = cn.createStatement();
ResultSet rs = st.executeQuery("select invoicedate,terms,annexure from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet");
while(rs.next())
{
	Date invoicedate = rs.getDate("invoicedate");
	System.out.println("Date is '"+invoicedate+"'");
	String terms = rs.getString("terms");
	System.out.println("Terms are"+terms);
	String annexure = rs.getString("annexure");
	System.out.println("Annexure is"+annexure);
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String dt = format.format(invoicedate);
	System.out.println("Date is"+invoicedate);
}
}
catch(Exception e)
{
	System.out.println(e);
}
out.println("Hello");
%>
</body>
</html>