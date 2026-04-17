<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>

<%@page import="sun.security.util.Password"%>
<jsp:useBean id="erp" class="com.ConnectionClass" scope="page"/>

<%
//Connection Initialization
Connection conn = null;
Statement st= null,st1=null;

try {
    conn = erp.getConnect("db_GlobalERP");
    st = conn.createStatement();
    st1 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>

<%
try{
	
	String logoutdet=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	System.out.println(" IN THIS PAGE  ");

	String sql1="update "+session.getAttribute("CompanyMasterID").toString()+"logindetails set ActiveStatus='No' ,LogOutDetails='"+logoutdet+"' ,Updated='"+logoutdet+"' 	where SessionId='"+session.getId().toString()+"'";
	st.executeUpdate(sql1);
	
	System.out.println(">>>  >>>  >>  "+sql1);

}
catch(Exception e)
{
	out.print("Logout Exception--->"+e);
} 

session.invalidate();
response.sendRedirect("index.jsp");
%>