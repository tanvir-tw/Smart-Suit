<%@page import="com.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@ page language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.ResultSet"%><html>
<head>
<title>Receiver's Report</title>
<script src="sorttable.js" type="text/javascript"></script>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="css/style2.css" rel="stylesheet" type="text/css"
	media="screen" />
<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
<script type="text/javascript" src="css/chrome.js"></script>



<style type="text/css">
table {
	font-size: 2;
	font-family: Georgia, "Gill Sans MT", "Gill sans", "Trebuchet ms",
		sans-serif;
	line-height: 1.4em;
	color: #5B0006;
	background-color: #FFEDEF;
	width: 100%;
	border-collapse: collapse;
}

caption {
	color: #F8EFF0;
	background-color: inherit;
	font-size: 25px;
	background-image: url(poetryforbrowser/caption.jpg);
	background-repeat: repeat-x;
	background-position: 0 0;
	padding: 28px 10px 7px 5px;
	text-align: right;
}

tfoot th, tfoot td {
	color: #F8EFF0;
	background-color: inherit;
	font-size: 25px;
	background-image: url(poetryforbrowser/tfoot.jpg);
	background-repeat: repeat-x;
	background-position: 0 -2px;
}

tfoot {
	text-align: right;
}

tfoot td {
	padding: 7px 10px 28px 5px;
}

tfoot th {
	padding: 7px 2px 28px 2px;
}

thead th, tbody th {
	background-color: #FAE5E7;
	color: #5B0006;
	padding: 7px;
	text-align: left;
}

tbody tr:hover, tbody tr th:hover {
	background-color: #FDF9F9;
	color: #000;
}

td {
	padding: 7px;
}

thead th {
	border-bottom: 1px dotted #908F8B;
}

thead th:first-child {
	border: none;
}

tbody th {
	border-right: 1px dotted #908F8B;
}

table a {
	width: 100%;
	display: block;
	color: #5B0006;
	background-color: inherit;
	line-height: 1.5em;
}

table a:visited {
	color: #908F8B;
	background-color: inherit;
}

tbody td+td+td+td a:before {
	content: "\21D3";
	text-align: right;
}

table a:hover {
	color: #C9020F;
	background-color: inherit;
}
</style>


<style type="text/css">
body {
	background-color: #b0c4de;
}
</style>

<style type="text/css">
p {
	font-family: "Times New Roman", font-size : "60%", Times, serif;
}
</style>

<script type="text/javascript">
function addRecvrRemark(refno) 
{
	//alert("=====");
	try
	{
		testwindow1=window.open('inwardRemark.jsp?refno='+refno,'mywindow','width=400, height=200, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=no,left=500, top=200 ');
		testwindow1.focus();
	}
	catch(e)
	{
		alert(e);
	}
} 

function closeAllchildren()
{
	 window.opener=self;
	 window.close(); 
} 

</script>
</head>

<body bgcolor="red">
	<%
	Connection conn =null;
	ConnectionClass connection = new ConnectionClass();
	conn = connection.getConnect("db_leaveapplication");
	Statement st=conn.createStatement();

String refno=request.getParameter("refno");
System.out.println("************"+refno+"***********");

%>
	<form action="remarkUpdate.jsp" method="get">

		<table style="background: #b0c4de;" align="center">
			<tr align="center">
				<td align="center">
					<h1>Receiver's Report</h1>
				</td>
			</tr>
	
		</table>
		<table border="1" cellpadding="3" width="80%"
			style="background: #b0c4de;" align="center">
			<tr background="99CCCC">
				<td align="center"><b>Sn</b></td>
				<td align="center"><b>Reference</b></td>
				<td align="center"><b>Receiver</b></td>
				<td align="center"><b>Sender</b></td>
				<td align="center"><b>Sender Remark</b></td>
				<td align="center"><b>Recvrs Remark</b></td>
				<td align="center"><b>Status</b></td>
				<td align="center"><b>Add Recvrs Remark</b></td>
			</tr>
			<%
	int i=1;
	String sql="select * from db_leaveapplication.t_inwardfollowup where iwrefno='"+refno+"'";
	ResultSet rs1=st.executeQuery(sql);
	while(rs1.next())
	{
		%>
			<tr>
				<td align="right"><%= i++%></td>
				<td align="right"><%= refno%></td>
				<td align="left"><%=rs1.getString("docReceiver") %></td>
				<td align="left"><%= rs1.getString("docSender")%></td>
				<td align="left" style="width: 50px;"><%= rs1.getString("senderRemarks")%></td>
				<td align="left" style="width: 50px;">
					<%String sd1="";
		String sd2=rs1.getString("recvrRemark");
		if( sd2!=null || sd1!="")
		{
			sd1=rs1.getString("recvrRemark");
		}
		else
		{
			sd1="-";
		}
		%> <%=sd1 %>
				</td>
				<td align="left"><%= rs1.getString("checkstatus")%></td>
				<%if(rs1.getString("docReceiver").equals(session.getAttribute("empname"))) 
		{%>
				<td align="left"><div align="left">
						<a href="" onclick="addRecvrRemark('<%= refno%>')" />Add
					</div></td>
				<%}
		else
		{ %>
				<td align="left"><div align="left">-</div></td>
				<%} %>
			</tr>
			<%
	}
	%>
		</table>
	</form>
</body>
<%conn.close(); %>
</html>