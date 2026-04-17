<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head>
<script language="JavaScript">
function loadalert (i) 
{
	
    window.self.close();
    alert(i);
	//window.location = 'home.jsp';
}
//if (document.all || document.getElementById)
	//document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>
</head>
<body onLoad="loadalert('<%=request.getParameter("msg") %>')">
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