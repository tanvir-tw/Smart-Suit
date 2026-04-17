<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>
<html>
<head>
<script language="JavaScript">
function loadalert (msg,gotoPage) 
{
	alert(msg);
	window.location = gotoPage;
}
/* if (document.all || document.getElementById)
	document.body.style.background = "url('images/bg.jpg')  white top no-repeat " */
</script>
</head>
<body onLoad="loadalert('<%=request.getParameter("msg") %>','<%=request.getParameter("goto") %>')">
<table>
<tr><td>.</td></tr>
</table>
<% 
String msg="";
%>
<%
msg=request.getParameter("msg");
%>
</body>
</html>