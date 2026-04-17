<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="headConn.jsp" %>
<%

String CompanyMasterId ="";
String postgresDriver = "org.postgresql.Driver";
String postgresString = "";
String postgresUser = "";
String postgresPass = "";

String APIBaseURL = "";
String APIUser = "";
String APIToken = "";

try {
CompanyMasterId = session.getAttribute("CompanyMasterID").toString();

Statement stop = conn.createStatement();
String sqlop = "select * from db_GlobalERP."+CompanyMasterId+"t_OpenProjectCredentials where status='Active' order by EntryDateTime desc limit 1";
ResultSet rsop = stop.executeQuery(sqlop);
if(rsop.next()){

	 postgresDriver = rsop.getString("Conn_Driver");
	 postgresString = rsop.getString("Conn_String");
	 postgresUser = rsop.getString("Conn_User");
	 postgresPass = rsop.getString("Conn_Password");
	 APIBaseURL = rsop.getString("API_URL");
	 APIUser = rsop.getString("API_Key");
	 APIToken = rsop.getString("API_Token");
}

	//String abc = session.getAttribute("user").toString();
} catch (Exception ee) {
	response.sendRedirect("index.jsp?err=err2");
	return;
}
%>