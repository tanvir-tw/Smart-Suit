<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Footer</title>
<style type="text/css">
#footer {
height: 36px;
padding: 1px 0px 0px;
background: none repeat scroll 0% 0% #1582AB;
border-top: 1px solid #1885B0;
font-family: Arial,Helvetica,sans-serif;
margin-left: 0px;
margin-right: 3px;
width: 100%;
position:relative ;
bottom: 0;
}


</style>
</head>

<%
Date dft=new Date();
int year=dft.getYear()+1900;

%>
<div id="footer" class="row" >
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009-<%=year%> 
	by Transworld Technologies Ltd. All Rights Reserved.</a></p>
	</div>

</html>