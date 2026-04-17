
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<html> 
<head>
<style>

</style>

<%@ include file="header.jsp"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<title></title>
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







 
<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		
	        		buttons: [
	  	        			{
	  	                        extend: 'excel',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
	  	                    },
	  	                    {
	  	                        extend: 'pdf',
	  	                        orientation: 'landscape',
	  	                        pageSize: 'LEGAL',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(), 
	  	                    },
	  	                    {
	  	                        extend: 'csv',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(),
	  	                    },
	  	                    {
	  	                        extend: 'print',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(),
	  	                    },
	  	                    {
	  	                        extend: 'copy',
	  	                        title: 'Paid Days Status Report '+$("#month").val()+'-'+$("#year").val(),
	  	                    },
	  	                    
	  	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	  	            			]
	        		
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     
	    
	    
	    
	    	
	    } );
	} );

</script>









 <script type="text/javascript">
 function chk()
 {

 	
 	
 	var chkf="";
 	var chkt="";
 	var objFromDate = document.getElementById("data").value;
 	var fdate=objFromDate.split("-");
 	
 	if(fdate[1]=="Jan")
 	{
 		chkf="01";
 	}
 	if(fdate[1]=="Feb")
 	{
 		chkf="02";
 	}
 	if(fdate[1]=="Mar")
 	{
 		chkf="03";
 	}
 	if(fdate[1]=="Apr")
 	{
 		chkf="04";
 	}
 	if(fdate[1]=="May")
 	{
 		chkf="05";
 	}
 	if(fdate[1]=="Jun")
 	{
 		chkf="06";
 	}
 	if(fdate[1]=="Jul")
 	{
 		chkf="07";
 	}
 	if(fdate[1]=="Aug")
 	{
 		chkf="08";
 	}
 	if(fdate[1]=="Sep")
 	{
 		chkf="09";
 	}
 	if(fdate[1]=="Oct")
 	{
 		chkf="10";
 	}
 	if(fdate[1]=="Nov")
 	{
 		chkf="11";
 	}
 	if(fdate[1]=="Dec")
 	{
 		chkf="12";
 	}
 	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
     var objToDate = document.getElementById("data1").value;
     var tdate=objToDate.split("-");
     if(tdate[1]=="Jan")
 	{
     	chkt="01";
 	}
 	if(tdate[1]=="Feb")
 	{
 		chkt="02";
 	}
 	if(tdate[1]=="Mar")
 	{
 		chkt="03";
 	}
 	if(tdate[1]=="Apr")
 	{
 		chkt="04";
 	}
 	if(tdate[1]=="May")
 	{
 		chkt="05";
 	}
 	if(tdate[1]=="Jun")
 	{
 		chkt="06";
 	}
 	if(tdate[1]=="Jul")
 	{
 		chkt="07";
 	}
 	if(tdate[1]=="Aug")
 	{
 		chkt="08";
 	}
 	if(tdate[1]=="Sep")
 	{
 		chkt="09";
 	}
 	if(tdate[1]=="Oct")
 	{
 		chkt="10";
 	}
 	if(tdate[1]=="Nov")
 	{
 		chkt="11";
 	}
 	if(tdate[1]=="Dec")
 	{
 		chkt="12";
 	}
     var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
    // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
      
     var date1 = new Date(objFromDate1);
     var date2 = new Date(objToDate1);
     
     //alert("from > "+date1+" Todate > "+date2);
     
     var date3 = new Date();
     var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
     var currentDate = new Date(date4);
      
         if(date1 > date2)
         {
             alert("From Date Should be Less Than To Date");
             return false; 
         }
//          else if(date1 > currentDate)
//          {
//              alert("From Date should be less than current date");
//              return false; 
//          }
//          else if(date2 > currentDate) 
//          {
//              alert("To Date should be less than current date");
//              return false; 
//          }

         return true;
 	
 }
 
 function confirmSubmit() {

		
		var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
		//alert(month);
		if(month=="Select")
			{
			alert("Please select Month!");
			return false;
			}
		var year=document.getElementById("year").options[document.getElementById("year").selectedIndex].value;
		if(year=="Select")
		{
		alert("Please select Year!");
		return false;
		}
		
			
		
		
	}
 
</script>





</head>


<%!
Connection con1;


%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=con1.createStatement();
Statement st=con1.createStatement();
Statement st2=con1.createStatement();
Statement st3=con1.createStatement();
Statement st4=con1.createStatement();
Statement st_user_id=con1.createStatement();
Statement st12=con1.createStatement();
Statement st13=con1.createStatement();



%>
<% 

int k=2000;
String selected=request.getParameter("status");

System.out.println("--------"+selected);

String datex1, datex2, data1, data2;
String ddx = request.getQueryString();

if (ddx == null) {
	
	System.out.println(" In First If  " );
	
	datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new java.util.Date());
	
		
	data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new java.util.Date());

	Calendar c = Calendar.getInstance();   // this takes current date
    c.set(Calendar.DAY_OF_MONTH, 1);
    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());


} else {
	
	System.out.println(" In First Else  " );
	
	data1 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data")));
	data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data1")));
	
	
	

	datex1 = request.getParameter("data");
	datex2 = request.getParameter("data1");
	
}

String Bt=request.getParameter("button");
System.out.println(" Button :- " +Bt);

if(Bt==null || Bt==" " || Bt=="")
{
	datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
	.format(new java.util.Date());
data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new java.util.Date());

Calendar c = Calendar.getInstance();   // this takes current date
c.set(Calendar.DAY_OF_MONTH, 1);
System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
	
}
else
{
	/* data1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data")));
data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data1"))); */




//datex1 = request.getParameter("data");
//datex2 = request.getParameter("data1");
}

System.out.println(" datex1 "+datex1+" datex2 "+datex2);


String dt = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(datex1));

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(datex2));

System.out.println(" dt :-  "+dt+" dt1 :-  "+dt1);



String name=session.getAttribute("EmpName").toString();
String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
String dept = session.getAttribute("department").toString();



String selected1=request.getParameter("dept");


%>












<body>
<form name="custreport" id="custreport" method="post">
<div class="form" align="center" style="font-size: 13px;">

<font face="Arial" color="black" size="4"><b>Final Pay Detail</b></font><br></br>
</div>

<div class="form" style="margin-left: 24%;">
	<table border="0" width=800 align="center">
		
	
	
		<tr align="left">
		
	<td>

<td><font face="Arial" color="black" size="2"><b>Month</b></font></td>
<td><!-- <select name="month" id="month" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" > -->
			<select class="element select medium" id="month" name="month" style="width: 100px; font-size: 12px; height: 25px;">
<option value="Select">Select</option>
<option value="01">JAN</option>
<option value="02">FEB</option>
<option value="03">MAR</option>
<option value="04">APR</option>
<option value="05">MAY</option>
<option value="06">JUN</option>
<option value="07">JUL</option>
<option value="08">AUG</option>
<option value="09">SEPT</option>
<option value="10">OCT</option>
<option value="11">NOV</option>
<option value="12">DEC</option>

<%
if(request.getParameter("month") != null){
	String mon=request.getParameter("month");
	System.out.println("Month :-"+mon);
	if(mon.equals("01"))
	{
		mon="JAN";
	}else if(mon.equals("02"))
	{
		mon="FEB";
	}else if(mon.equals("03"))
	{
		mon="MAR";
	}
	else if(mon.equals("04"))
	{
		mon="APR";
	}
	else if(mon.equals("05"))
	{
		mon="MAY";
	}
	else if(mon.equals("06"))
	{
		mon="JUN";
	}
	else if(mon.equals("07"))
	{
		mon="JUL";
	}
	else if(mon.equals("08"))
	{
		mon="AUG";
	}
	else if(mon.equals("09"))
	{
		mon="SEP";
	}
	else if(mon.equals("10"))
	{
		mon="OCT";
	}
	else if(mon.equals("11"))
	{
		mon="NOV";
	}
	
	
	else if(mon.equals("12"))
	{
		mon="DEC";
	}
	
		
		
		 %><option value=<%=mon%> selected><%=mon %></option><%
}
%>
</select></td>
<td><font face="Arial" color="black" size="2"><b>Year</b></font></td>
<td><!-- <select name="year" id="year" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" > -->
			<select class="element select medium" id="year" name="year" style="width: 100px; font-size: 12px; height: 25px;">
			<%if(Bt==null || Bt==" " || Bt=="")
			{ %>
			<option value="Select"><font face="Arial" color="black" size="2">Select</font></option>
			<% 
			for(k=2018;k<=2050;k++)
			
			    {
				%>
				<option value="<%=k %>"><%=k %></option>
				<%}
			}
			else{ 
			
				
					%>
				<option value="<%=request.getParameter("year") %>"><%=request.getParameter("year") %></option>
				<% 
				for(k=2018;k<=2050;k++)
				  {
				%>
				<option value="<%=k %>"><%=k %></option>
				<%}
			}%>
			
			
			
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
			<td style="font-size: 11px; face:san-serif; color:black" >&nbsp;&nbsp;<input type="submit" name="button" value="Submit" onclick="return confirmSubmit()" style="width: 80px;font-size: 12px; height: 29px; color:black"></td>
			
			
			
				
	

	</table>
	</div>
	

<%
dept = session.getAttribute("department").toString();

String sessionname=session.getAttribute("EmpName").toString();
System.out.println(dept);

int cnt=0;
String sql_active=null;
String user_id1 = "";

/* if (Sesrole1.equals("HOD"))
{
	dept="%%";
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept like  '"+dept+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}else */ 
if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("Hr") )
{
	dept="%%";
	
	//sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	
	sql_active = "select ContractorId as user_id from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status = 'Active' ";
	
}else{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes'  and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}


System.out.println("The EmpCode Id query is ==>>"+sql_active);

ResultSet rs_active = st_user_id.executeQuery(sql_active);

while(rs_active.next()){
++cnt;
if(cnt == 1)
{
	user_id1 = rs_active.getString("user_id");
	user_id1="\'"+user_id1+"\'";
}else
{
	user_id1 = user_id1 +",\'"+rs_active.getString("user_id")+"\'";
}

}

System.out.println("-------->"+user_id1);

ResultSet rs=null;
Statement stmt=null;
stmt=con1.createStatement();
Statement stmt1=con1.createStatement();
Statement stmt3=con1.createStatement();
Statement stmt4=con1.createStatement();
System.out.println(dt);
System.out.println(dt1);

String Status="",colour="";
String year1=request.getParameter("year");

if(year1==null)
{
	year1="1999";
	
}
else 
{
	 year1=request.getParameter("year");
}
String month1=request.getParameter("month");
if(month1==null)
	
{
	month1="13";
	
}
else
{
	month1=request.getParameter("month");
}
 

System.out.println("Selected Month :- "+month1);
System.out.println("Selected Year :- "+year1);
DecimalFormat df = new DecimalFormat("0.00");


if(month1.equals("01"))
	{
		month1="JAN";
	}else if(month1.equals("02"))
	{
		month1="FEB";
	}else if(month1.equals("03"))
	{
		month1="MAR";
	}
	else if(month1.equals("04"))
	{
		month1="APR";
	}
	else if(month1.equals("05"))
	{
		month1="MAY";
	}
	else if(month1.equals("06"))
	{
		month1="JUN";
	}
	else if(month1.equals("07"))
	{
		month1="JUL";
	}
	else if(month1.equals("08"))
	{
		month1="AUG";
	}
	else if(month1.equals("09"))
	{
		month1="SEP";
	}
	else if(month1.equals("10"))
	{
		month1="OCT";
	}
	else if(month1.equals("11"))
	{
		month1="NOV";
	}
	
	
	else if(month1.equals("12"))
	{
		month1="DEC";
	}
System.out.println("Selected Month :- "+month1);

String role=session.getAttribute("role").toString();


%>





<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="">  
<thead>


<tr>

<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">SrNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">Status</th>
<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">Name</th>
<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">ID</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Department</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">PaidDays</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">LastVesrion</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Last Pay</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">CurrentVersion</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Net Pay</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">LeaveBalance</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">PIIndex</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">PI Amount</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">KRAIndex</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">KRA Amount</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Total Deduction</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Total Allowances</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">PayRoll Version</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">PaySlip</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">TDS</th>

<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Entry Date</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Entry By</th>






</tr>
</thead>
<tbody>
<%


//String query1="select distinct(ID) as ID from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMaster where  Month='"+month1+"' and Year='"+year1+"' and ID in ("+user_id1+")";

String query1="select distinct(ID) as ID from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where  Month='"+month1+"' and Year='"+year1+"' and ID in ("+user_id1+")";

System.out.println(query1);

ResultSet rs21=st12.executeQuery(query1);
int i=1;
while(rs21.next())
{
try
{
	String query="";

	
	String id123=rs21.getString("ID");
	
	//query="select ID,Name,Department,Paiddays,PiIndex,PiAmount,KraIndex,KraAmount,TotalDeduction,(VehicleAllowance+MobileAllowance+LaptopAllowance) As TotalAllowances,Advance,securityDeposit,PreviousPay,other,PayrollVersion,PaySlipName,TDSAmount,AmountToPay,EntryDate,EntryBy from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMaster where  Month='"+month1+"' and Year='"+year1+"' and ID in ("+id123+") order by PayrollVersion DESC limit 1";
	
	String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+id123+"' and MediclaimEndDate >=now()";
	ResultSet rsempdetails=st2.executeQuery(empdetails);
	
	//System.out.println("Claim Query :- "+empdetails);
	
	if(rsempdetails.next())
	{
		Status="Active";
		colour="Green";
		
		System.out.println("Claim Date :- "+rsempdetails.getString("MediclaimEndDate"));
	}
	else
	{
		Status="Hold (Mediclaim Expired)";
		colour="Red";
		
		System.out.println("Claim Date Expired  ");
	}
	
			
	
	query="select ID,Name,Department,Paiddays,PiIndex,PiAmount,KraIndex,KraAmount,TotalDeduction,(VehicleAllowance+MobileAllowance+LaptopAllowance) As TotalAllowances,Advance,securityDeposit,PreviousPay,other,PayrollVersion,PaySlipName,TDSAmount,AmountToPay,EntryDate,EntryBy from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where  Month='"+month1+"' and Year='"+year1+"' and ID in ('"+id123+"') order by PayrollVersion DESC limit 1";
	
	
	System.out.println("Query is:"+query);
	
	ResultSet rs12=stmt3.executeQuery(query);
	
	
	while(rs12.next())
	{
		double AmtToPay=0.00,AmoutToPay=0.00,PayrollVersion=0.00,PayrollVersionNew=0.00,DifferenceInPay=0.00;
		String Edate=rs12.getString("EntryDate");
		
		 PayrollVersion=rs12.getDouble("PayrollVersion");
		 AmoutToPay=rs12.getDouble("AmountToPay");
		
		System.out.println("Pay Roll Version Latest :- "+PayrollVersion);
		System.out.println("Pay Roll "+PayrollVersion+" Amount To Pay  :- "+rs12.getDouble("AmountToPay"));
		if(PayrollVersion > 1)
		{
			
			PayrollVersionNew=PayrollVersion-1;
			
			System.out.println("Pay Roll Version After  :- "+PayrollVersionNew);
			
			String PrevPayVersion="select ID,Name,Department,Paiddays,PiIndex,PiAmount,KraIndex,KraAmount,TotalDeduction,(VehicleAllowance+MobileAllowance+LaptopAllowance) As TotalAllowances,Advance,securityDeposit,PreviousPay,other,PayrollVersion,PaySlipName,TDSAmount,AmountToPay,EntryDate,EntryBy from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where  Month='"+month1+"' and Year='"+year1+"' and ID in ('"+id123+"') and  PayrollVersion='"+PayrollVersionNew+"'";
			ResultSet rsPrevPayVersion=st2.executeQuery(PrevPayVersion);
			
			if(rsPrevPayVersion.next())
			{
				AmtToPay=rsPrevPayVersion.getDouble("AmountToPay");
			}
		}
		else
		{
			AmtToPay=0.00;
			PayrollVersionNew=1;
		}
		
		
		
		System.out.println("Pay Roll "+PayrollVersion+" Amount To Pay  :- "+AmtToPay);
		
		
			DifferenceInPay=AmtToPay-AmoutToPay;	
		
		
		
		String Entrydate = new SimpleDateFormat("dd-MMM-yyyy")
		        .format(new SimpleDateFormat("yyyy-MM-dd")
		                .parse(Edate)); 
		
		System.out.println("Date is:"+Edate);
		
		
		double piAmount=rs12.getDouble("PiAmount");
		double KraAmount=rs12.getDouble("KraAmount");
		double totalAllowance=rs12.getDouble("TotalAllowances");
		
		String filename=rs12.getString("PaySlipName");
		
		%>
		 <tr>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
			<td style="font-size: 11px; face:san-serif; color:<%=colour %>" align="left"><b><%=Status%></b></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs12.getString("Name")%></td>
			
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs12.getString("ID")%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs12.getString("Department")%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="#" onclick="srk('<%=rs12.getString("ID")%>','<%=month1%>','<%=year1%>')"><%=df.format(rs12.getDouble("Paiddays"))%></a></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PayrollVersionNew%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(AmtToPay)%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PayrollVersion%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rs12.getDouble("AmountToPay"))%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="#" onclick="leave('<%=rs12.getString("ID")%>','<%=rs12.getString("Name")%>')"> LeaveBalance</a></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rs12.getDouble("PiIndex"))%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(piAmount)%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rs12.getDouble("KraIndex"))%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(KraAmount)%></td>	
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rs12.getDouble("TotalDeduction"))%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(totalAllowance)%></td>	
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs12.getString("PayrollVersion")%></td>
			
			
			
		 	<td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="#" onclick="pdf('<%=filename%>','<%=month1%>','<%=year1%>')"><%=rs12.getString("PaySlipName")%></a></td> 
			
			<!--PaySlip without hyperlink  -->
			<%-- <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs12.getString("PaySlipName")%></td> --%>
			
			
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rs12.getDouble("TDSAmount"))%></td>
			
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Entrydate%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs12.getString("EntryBy")%></td>
			
		 </tr>
		 
		 <%
		
	}
	


}

catch(Exception e)
{
	e.printStackTrace();
}

i++;
}
%>
</tbody>
</table>


</form>



<script>


function leave(id,name)
{
	/* alert(id);
	
	alert(name);
	 */
	location.assign("LeaveBalanceReport.jsp?id1="+id+"&name="+name+"");
	
}


function pdf(filename,month,year)
{
	/* alert(filename);
	alert(month);
	alert(year); */
	location.assign("Dowanloadpayslip.jsp?payslipname="+filename+"&month="+month+"&year="+year+"");
}



function srk(emp_id,month,year)
{
	/* alert(emp_id);
	alert(month);
	alert(year); */
	var payroll="payroll";
	location.assign("PaidaysReport.jsp?empId="+emp_id+"&month12="+month+"&year12="+year+"&action="+payroll+"");
}


</script>









 









</jsp:useBean>


</body>
<%@ include file="footer_new.jsp"%>
</html>