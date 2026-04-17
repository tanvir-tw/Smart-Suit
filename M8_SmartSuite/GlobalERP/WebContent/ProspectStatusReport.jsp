<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""%>
<%@ include file="header.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Opportunity Report</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.colVis.min.js"></script>

<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        responsive:true,
	        scrollY:	"500px",
	        scrollX:true,
	        scrollCollapse:true,
	        
	        "columnDefs": [
	            {
	                "targets": [],
	                "visible": false,
	                "searchable": false
	            }],
	     
	        
	        
	        buttons: [
	        	
	        	
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Prospect Status Report', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Prospect Status Report', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Prospect Status Report', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Prospect Status Report', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Prospect Status Report', 
	                   },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	    
	    
	    
	    	
	    } );
	} );

</script>

<style>
th {
    text-align: center;
}
</style>
<script type="text/javascript">

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

<%!
Connection conn=null;
%>

<%
Class.forName(DB_Driver);
conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

Statement st=conn.createStatement();
String fromDate = "", toDate = "",fromDate1="",fromDateCal="",toDateCal="";
String data2="",data1="",Query="";
String All="",Prospect="",Customer="",AssignedProspect="",MissedProspect="",AssignedCustomer="",MissedCustomer="";
String CustomerCode="";
String cmp=request.getParameter("OwnerName");
System.out.println("CompanyName ---->"+cmp);

%>
<%
String todaysTime = new SimpleDateFormat(" HH:mm").format(new java.util.Date());
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

<br><br>
<div align="center"><font size="4" color="black"><b>Prospect Status Report</b></font></div>
<br>
<br>

<%-- <div align="center">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
 --%>
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
		{
			System.out.println("----------In Button-------------");
%>

<%-- <div id="reportData1" align="center">		

<iframe id="myIframe" width="52.5%" height="500px" src="http:// twdb.fleetview.in:8080/birt/frameset?__report=ProspectStatus.rptdesign&companyid=<%=companyid %>&__showtitle=false">
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe>
	
</div> --%>
				
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1"> 

<thead>

<tr>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif; align:center;">SrNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">All</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Prospect</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Assigned Prospect</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Missed Prospect</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Customer</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Assigned Customer</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Missed Customer</th>
</tr>
</thead>
<tbody>
		<%
		 	Query="SELECT SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' THEN 1 ELSE 0 END) AS total,SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' AND SalesCustomerCode = '0' THEN 1 ELSE 0 END) AS Prospect,SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' AND SalesCustomerCode = '0' AND m.MarketingRepCode IS NOT NULL THEN 1 ELSE 0 END) AS AssignedProspect,SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' AND SalesCustomerCode = '0' AND m.MarketingRepCode IS NULL THEN 1 ELSE 0 END) AS MissedProspect, SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' AND SalesCustomerCode <> '0' THEN 1 ELSE 0 END) AS Customer, SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' AND SalesCustomerCode <> '0' AND m.MarketingRepCode IS NOT NULL THEN 1 ELSE 0 END) AS AssignedCustomer, SUM(CASE WHEN IsDataValid = 1 AND CustomerCode <> '0' AND SalesCustomerCode <> '0' AND m.MarketingRepCode IS NULL THEN 1 ELSE 0 END) AS MissedCustomer FROM db_GlobalERP. "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster p LEFT JOIN ( SELECT DISTINCT a.MarketingRepCode FROM db_GlobalERP. "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a JOIN db_GlobalERP.UserMaster c ON a.MarketingRepCode = c.EmpCode AND c.ActiveStatus = 'Yes' AND CompanyMasterID = "+session.getAttribute("CompanyMasterID").toString()+" ) m ON p.AllocatedTo = m.MarketingRepCode";
		
			System.out.println("Query :-"+Query);
			
			ResultSet rs=st.executeQuery(Query);
			
			String Custtype="",city="";
			
			int i=1;
			if(rs.next())
				{
				All=rs.getString("total");
				Prospect=rs.getString("Prospect");
				AssignedProspect=rs.getString("AssignedProspect");
				MissedProspect=rs.getString("MissedProspect");
				Customer=rs.getString("Customer");
				AssignedCustomer=rs.getString("AssignedCustomer");
				MissedCustomer=rs.getString("MissedCustomer");
				
				
		%>
				<td align="right"><div align="center"><%=i%></div></td>
				<td align="left"><div align="center"><%=All%></div></td>
				<td align="left"><div align="center"><%=Prospect%></div></td>
				<td align="left"><div align="center"><%=AssignedProspect%></div></td>
				<td align="left"><div align="center"><%=MissedProspect%></div></td>
				<td align="left"><div align="center"><%=Customer%></div></td>
				<td align="left"><div align="center"><%=AssignedCustomer%></div></td>
				<td align="left"><div align="center"><%=MissedCustomer%></div></td>
				
				
				<%
				
				} 
		}
%>
</body>
<%-- <%@include file="footer_new.jsp"%> --%>
</html>

