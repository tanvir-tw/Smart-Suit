<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
try
{
Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st=null;
 
st=con.createStatement();

String grpname="", grpstatus="";
grpname=request.getParameter("thegroup");
System.out.println("GROUP NAME IS"+grpname);
grpstatus=request.getParameter("status");
System.out.println("GROUP STATUS IS"+grpstatus);

String grpsql="update "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster set Status='"+grpstatus+"' where TheGroupName='"+grpname+"'";
System.out.println("UPDATE GROUP"+grpsql);
int rs=st.executeUpdate(grpsql);
System.out.println("UPDATED QUERY"+rs);
if(rs>0){
	response.sendRedirect("GroupMaster.jsp?id=group");
}
}catch(Exception e)
{
	
}

%>
