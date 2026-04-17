<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head>
<script language="JavaScript">
function loadalert (msg,gotoPage) 
{
	//alert(gotoPage);
	alert(msg);
	window.location = gotoPage;
	window.opener.location.reload();
    setTimeout('self.close()',5);
	
}
if (document.all || document.getElementById)
	document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
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
System.out.println("msg coming on alertgoto page   "+msg);

%>
</body>
</html>