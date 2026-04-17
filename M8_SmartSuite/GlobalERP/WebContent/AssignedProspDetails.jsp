<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Prospect Status Detail Report</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>


<!-- <style>-->
<!--th-->
<!--{-->
<!--background: #C6DEFF;-->
<!--}-->
<!--</style>-->
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



function Validation() 

{
//alert("fun ");


//alert(month1);
//alert(year);
var month= document.getElementById("month").value;

var current_year=new Date().getFullYear();


if(month=="Select")
{
	alert("Please Select Month");
	return false;
}
var Year= document.getElementById("year").value;
 if(year=="Select")
{
	alert("Please Select Year ");
	return false;
}


 
  
       
if((year < 1990) || (year > current_year))
            {
            alert("Year should be in range 1990 to current year");
            return false;
            }


}
function birt1()
{
	//alert("HI");
	
	var current_year=new Date().getFullYear();
	var current_month=new Date().getMonth();
	//alert(current_month);
	var Customer= document.getElementById("companyName1").value;
	
	Customer=Customer.replace(/&/g,'%26');
	
	if(Customer=="Select")
	{
		alert("Please Select Customer");
		return false;
		
	}

	
	//alert(Customer);
	
	var month= document.getElementById("month").value;
	
	if(month=="Select")
	{
		alert("Please Select Month ");
		return false;
		
	}
	
	var month1= document.getElementById("month").value;
	
	if(month1=="01")
	{
		month1="Jan";
	}
	if(month1=="02")
	{
		month1="Feb";
	}
	if(month1=="03")
	{
		month1="Mar";
	}
	if(month1=="04")
	{
		month1="Apr";
	}
	if(month1=="05")
	{
		month1="May";
	}
	if(month1=="06")
	{
		month1="Jun";
	}
	if(month1=="07")
	{
		month1="Jul";
	}
	if(month1=="08")
	{
		month1="Aug";
	}
	if(month1=="09")
	{
		month1="Sep";
	}
	if(month1=="10")
	{
		month1="Oct";
	}
	if(month1=="11")
	{
		month1="Nov";
	}
	if(month1=="12")
	{
		month1="Dec";
	}
	
	var Year= document.getElementById("year").value;
	
	if(Year=="Select")
	{
		alert("Please Select Year");
		return false;
		
	}
	//alert("Load---"+Year);
	
	
	if((Year < 2012) || (Year > current_year))
    {
    alert("Year should be in range 2012 to current year");
    return false;
    
    }
	else
		{
		
		
		//alert("inside year");
		
		if(  month > current_month  && Year < current_year)
		{
			//alert("inside year 1");
		}
		else{
		
	   
			if(  month > current_month  && Year==current_year)
			{
				//alert("inside year 2");
				 alert("Please Select Month Before "+month1+" ");
				    return false;
			}
	    }
		
		}
	
	
	
	
	
	
	//alert("Freight---"+month);
	
	//var TableName="db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+Year+"_"+month" ";
	//alert("Table Name------>"+TableName);
	
	document.getElementById("myIframe").src="http://twtech.in:8080/birt/frameset?__report=BilledVehicleReport.rptdesign&Customer="+Customer+"&year="+Year+"&month="+month+"&month1="+month1+"&__showtitle=false";
//	document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
	document.getElementById("reportData").style.display="";
	document.getElementById("footer").style.display="none";
	
	
	return true;
	
		
	
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

conn=erp.ReturnConnection();
Statement st=conn.createStatement();
String fromDate = "", toDate = "",fromDate1="",fromDateCal="",toDateCal="";
String data2="",data1="";
String CustomerCode="";
//String status=request.getParameter("status");
String allocationid=request.getParameter("allocationid");
String name=request.getParameter("name");

System.out.println("name ---->"+name);
System.out.println("allocationid ---->"+allocationid);

%>
<%
String todaysTime = new SimpleDateFormat(" HH:mm").format(new java.util.Date());
int i=1;
int vehid=0;
int k=2000;
	Date tdy = new Date();
	Date tomorrow = new Date();
	//Calendar cal = Calendar.getInstance();
	Calendar now = Calendar.getInstance();
	//cal.setTime(tdy);
	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd").format(tdy);
	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(tdy);
	//cal.add(Calendar.DAY_OF_MONTH, -1);
	//Date YesterdaysDateAsDate = cal.getTime();
	//String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);

	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
%>
<%

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
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); %>

<div align="center">
<!-- <form name="dateform" action="" method="get" onsubmit="return validate();"> -->


<tr align="center">
<br>
<td align="center" colspan="13">
<font size="3"><b> <%=name %>'s Assigned Prospects Details</b></font></td></tr>
<tr></tr>
</table>
<br><br><br>
<!-- <table  align="center"  style="width: 100%;"> -->

</div>


				
<div align="right">
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
</div>		
		

<%
		
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(fromDate1));
		dt=dt+ " 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(dtoday));
		dt1=dt1+ " 23:00:00";
		
		//cmp=cmp.replace("...","&");
		//cmp=cmp.replace("&","%26");
		%>
		
		
<%

		String Bt=request.getParameter("button2");
String companyid=session.getAttribute("CompanyMasterID").toString();
System.out.println("----------In Button-------------"+Bt);
		if(Bt==null)
		{System.out.println("----------In Button-------------");
%>
<div id="reportData1" align="center">		


<iframe id="myIframe" width="100%" height="500px" src="http://<%= host1 %>:8080/birt/frameset?__report=AssignedProspectDetails.rptdesign&CompanyId=<%=companyid %>&name=<%=name %>&allocationid=<%=allocationid %>&__showtitle=false">
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe>
	
	
	
<% 
		}
%>

	
	
</div></body>
</html>
</jsp:useBean>
<%-- <%@include file="footer_new.jsp"%> --%>