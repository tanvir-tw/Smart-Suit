<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script >
function Redirect()

{
	var  agree="";
	var action=document.getElementById("action").value;
	if(action=="Approve")
		{
	    agree=confirm("You Want To Approve It !");
		}
	else
		{
		  agree=confirm("You Want To Process It !");
		}
	
	  var Id=document.getElementById("requestid").value;
	  var role=document.getElementById("role").value;
	  var action=document.getElementById("action").value;
	  
	  if(agree)
	  {
		 
		 window.location="indentaction.jsp?Id="+Id+"&role="+role+"&action="+action+" ";
		 return true ;
			 
	  }	  	   
	  else
	  {
		  //alert("D") ;
		 
		 window.location="PurchaseIndentReport.jsp";
	     return false ;
	  }	  	   

	
	
}

function Redirect1()
{
	alert(" Error !! ");
    window.location="PurchaseIndentReport.jsp";
	
}

function Redirect2()
{
	alert(" Not Allowed !!! ");
    window.location="PurchaseIndentReport.jsp";
	
}

function Redirect3()
{
	var  status=document.getElementById("status").value;
	
	alert(" Not Allowed For "+status+" Status !! ");
	
    window.location="PurchaseIndentReport.jsp";
	
}


</script>

<body>


<%!
Connection conn=null;
%>

<%
//////////



//conn=erp.ReturnConnection();
//Statement st=conn.createStatement();
//Statement st1=conn.createStatement();

Connection conn = null, conn1=null;
Statement sterp = null, sterp1 = null, sterp2=null, sterp3=null, sterp4=null, sterp5=null, stqr=null, stsql1=null,stsql2=null;
ResultSet rs = null;
//String DB_NAME="jdbc:mysql://103.8.126.138:3306/db_gps";
//String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_gps";
String DB_NAME123="jdbc:mysql://"+host1+"/db_gps";
//String DB_NAME1="jdbc:mysql://103.8.126.138:3306/twsql_twalldata";
//String DB_NAME1="jdbc:mysql://twdb.fleetview.in/twsql_twalldata";
String DB_NAME11234="jdbc:mysql://"+host1+"/db_GlobalERP";
String DB_USERNAME1=user1;
String DB_PASSWORD1=pass1;
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
conn1=DriverManager.getConnection(DB_NAME11234,DB_USERNAME1,DB_PASSWORD1);
sterp = conn1.createStatement();
sterp1 = conn1.createStatement();
sterp2 = conn1.createStatement();
sterp3 = conn1.createStatement();
sterp4 = conn1.createStatement();
sterp5 = conn1.createStatement();
stsql1= conn1.createStatement();
stsql2= conn1.createStatement();

Statement st=conn1.createStatement();
Statement st1=conn1.createStatement();
String role="";
String Id="";
String Amcfromdate="",Amctodate="",Ownername="",toDate1="",InvoiceNumber="",action="";
String status="";

%>
<%

try{
	
Id=request.getParameter("Id");

role=request.getParameter("role");

action=request.getParameter("action");

status=request.getParameter("status");

System.out.println(" ID :- "+Id+ "  Role :- "+role+" Action :- "+action);

%>

<input type="hidden" id="requestid" name="requestid" value="<%=Id%>" />
<input type="hidden" id="role" name="role" value="<%=role%>" />
<input type="hidden" id="action" name="action" value="<%=action%>" />
<input type="hidden" id="status" name="status" value="<%=status%>" />

<%  

if(action.equals("Approve"))
{
	if (status.equals("Pending"))
	{
			if(role.equals("HOD") || role.equals("AllAdmin"))
			{
				out.println("<script>  Redirect();</script>");
			}
			else
			{
				out.println("<script>  Redirect2();</script>");
			}
	}
	else
	{
		out.println("<script>  Redirect3();</script>");
	}
	
}
else{
		
		if (status.equals("Approved"))
		{
	
				if(role.equals("Purchase"))
				{
					out.println("<script>  Redirect();</script>");
				}
				else
				{
					out.println("<script>  Redirect2();</script>");
				}
		}
		else
		{
			out.println("<script>  Redirect3();</script>");
		}
	}
	

	
//out.println("<script>  Redirect();</script>");


}
catch(Exception e)
{
	e.printStackTrace();
	out.println("<script>  Redirect1();</script>");

}
%>
</body>
</html>
</jsp:useBean>