<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Admin Module Master</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>
<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.categoryform.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["categoryform"].submit();       // CHANGE FORM NAME HERE

} 
function DeleteConfirm()
{
	var agree=confirm("Do You Want To Delete User?");
		if (agree)
			return true ;
		else
			return false ;
}
function InsertConfirm()
{
	var agree=confirm("Do You Want To Edit User?");
	if (agree)
		return true ;
	else
		return false ;	
}
</script>
</head>
<body>

<% erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD); %>
<%!
Connection conn=null;
%>

<%
//////////

Class.forName(DB_Driver);
sessionconn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement strno = sessionconn.createStatement();


conn=erp.ReturnConnection();
Statement st=conn.createStatement();
Statement st1=conn.createStatement();
%>

<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";

	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	
	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	
	%>
	 

<div align="center"><table  align="center" style="width: 70%;"><tr><td align="center" colspan="4"><font size="3"><b>Company Master Report </b></font></td></tr></table></div>

<div><table width ="100%" border="0"><tr align="left"><td><a href="AddNewUser.jsp"><b>Add New</b></a></td>	</tr></table></div>
<table width ="100%" border="0">	
<tr align="left">

<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>			 
				</td>					
		</tr></table>



<iframe src="http://twtech.in:8080/birt/frameset?__report=MasterAdmModule.rptdesign&__showtitle=false" width="100%" height="70%">
</iframe>



<%-- <iframe src="http://twtech.in:8080/birt/frameset?__report=AdminModuleMaster.rptdesign&__showtitle=false&CompID=<%=session.getAttribute("CompanyMasterID").toString()%>" width="100%" height="70%">
</iframe> --%>

</body>
</html>
</jsp:useBean>
<%-- <%@include file="footer_new.jsp"%> --%>