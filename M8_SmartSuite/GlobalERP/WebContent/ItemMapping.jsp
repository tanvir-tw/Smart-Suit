<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.io.*" import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
		

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Feid Mapping</title>
<style type="text/css">

.sortable{
margin-right:auto;
margin-left:auto; 
border:3px solid #2aa1cc;
width:40%;
height:auto;
padding:10px 1px 10px 60px; 
}

.sortable label{
display:block;
font-size:15px;
margin:0;
width:90%;
font-weight:bold;
}

.sortable input[type="text"]{

margin-left: 10px;
margin-top: 5px;
height: 17px;
width: 40%;
}

.sortable select{
margin-left: 10px;
margin-top: 5px;
height: 25px;
width: 42%;
 
}
.sortable label>span{
float:left;
width: 30%;
text-align: left;
margin-top: 5px;
}

.sortable button{
width: 91px;
height: 25px;
font-weight:bold;
font-size:15px;
margin-top: 10px;
background-color:#2aa1cc;
color:#FFF;
border-radius:8px;
-moz-border-radius:8px;
-o-border-radius:8px;
-webkit-border-radius:8px;
}

</style>
</head>
<body>
 <%
	 	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
 %>
 <%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null;

		String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		String fromDateCal="",toDateCal="",thegroupname="";
		fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		String id=request.getParameter("id");
		System.out.println("ID IS  "+id);
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			}
			
 %>
 <br>
<div style="font-size: 1.7em; text-align: center; margin-top: 0.2em; margin-bottom: 0.2em;">

<form name="GroupName" class="sortable" method="get" action="insertfield.jsp">
<h4>Field Mapping</h4>

<label><span>Make</span>
<input type="text" id="make" name="make">
</label>

<label><span>Model</span>
<input type="text" id="model" name="model">
</label>

<label><span>Part No</span>
<input type="text" id="part" name="part">
</label>

<label><span>Description</span>
<input type="text" id="desc" name="desc">
</label>

<button type="submit" value="Submit">Submit</button>

</form>
</div>
<div id="footer" style="margin-top: 80%">
<p><a href="#">
Copyright &copy; 2014 Safe & Secure Logistics Pvt Ltd.
</a></p>
</div>
<!-- end #footer -->
</body>
</html>
</jsp:useBean>
