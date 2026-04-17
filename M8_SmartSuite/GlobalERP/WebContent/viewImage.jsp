<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="conn.jsp"%>
<%
try {
	String UserName=request.getParameter("UserName");
	System.out.println("UserName "+UserName);
	Connection connection=null;
	Class.forName(DB_Driver);
	connection = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement ps=null;
	//Class.forName("com.mysql.cj.jdbc.Driver");
	//connection = DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_GlobalERP", "erp", "1@erp");
	
	ps=connection.createStatement();
	ResultSet resultSet = ps.executeQuery("select signature from UserMaster where UserName='"+UserName+"'"); 
    if (resultSet.next()) {
    	byte[] content = resultSet.getBytes("signature");
    	
        response.setContentType(getServletContext().getMimeType("image/jpeg"));
        try{
        response.setContentLength(content.length);
        response.getOutputStream().write(content);
        System.out.println(content);
        }catch(Exception e){
        	out.print("<br><br><br><br><br><br><center><font color='red'>No Images</font></center>");
       // 	System.out.println("No Images");
        }
        
    	
    } else {
    	out.println("No Images");
    	System.out.println("No Images");
        response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
    }
    
 /* out.clear(); 
out.flush(); */ 
 out=pageContext.pushBody(); 
} catch (Exception e) {
out.println("No Images");
System.out.println("No Images");
throw new ServletException("Something failed at SQL/DB level.", e);
}


%>
</body>
</html>