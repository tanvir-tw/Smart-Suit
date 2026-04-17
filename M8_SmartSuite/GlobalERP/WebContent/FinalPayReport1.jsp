<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PayRollReport</title>
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
	        	'colvis',
	        	
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Final Pay Report'+$("#month").val()+'-'+$("#year").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'PayFinal PayRoll Report '+$("#month").val()+'-'+$("#year").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	    
	    
	    
	    	
	    } );
	} );

</script>




<script>

function confirmSubmit() {

	var dept = document.getElementById("dept").options[document.getElementById("dept").selectedIndex].value;
	if(dept=="select") {
			
			alert("Please select Department!");
		return false;
	}
	//alert("Hi");
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





<body>


<%

Connection con1=null;
Connection conleave=null;

Class.forName(DB_Driver);
conleave= DriverManager.getConnection(DB_NAMEPAY,DB_USERNAME,DB_PASSWORD);


Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

String Status="",colour="";


Connection conn = null;
//For ERP
Statement st=con1.createStatement();
Statement st1=con1.createStatement();


//For Leaveapplication
Statement st3=conleave.createStatement();


//attandaces
Statement st4=conleave.createStatement();


//IndexReport from ERP
Statement st5=con1.createStatement();
Statement st6=con1.createStatement();

//
Statement st7=con1.createStatement();
Statement st8=con1.createStatement();
Statement st9=con1.createStatement();
Statement st10=con1.createStatement();
Statement st11=con1.createStatement();
Statement st12=con1.createStatement();
Statement st13=con1.createStatement();
Statement st_user_id=con1.createStatement();

String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
int k=2000;



String cname="";
String companyName="select Companyname from db_GlobalERP.CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString()+"";
ResultSet rsc=st10.executeQuery(companyName);
if(rsc.next())
{
	cname=rsc.getString("Companyname");
}



%>







<form name="indexReport" method="get"  onsubmit="return confirmSubmit()" action="">
<table border="0" align="center" width="100%">


<div align="center"><font color="black" size="3"><b>PayRoll Data For <%=cname %></b></font></div>
<tr><td align="center"><font color="black" size="3"><b></b></font></td></tr>

<tr></tr>
<tr>
<td>
<br>
<table border="0" width="800" align="center">
<tr>

<td align="center"><b>Month</b></td>
<td>
	<select class="element select medium" id="month" name="month" style="width: 100px; height: 25px;">
		<option value="Select">Select</option>
<option value="01">JAN</option>
<option value="02">FEB</option>
<option value="03">MAR</option>
<option value="04">APR</option>
<option value="05">MAY</option>
<option value="06">JUN</option>
<option value="07">JLY</option>
<option value="08">AUG</option>
<option value="09">SEP</option>
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
	 
		
		if(request.getParameter("month")!=null)
		{

			%> <option value=<%=request.getParameter("month")%> selected><%=mon %></option><%
		
		}
}%>
</select>

</td>
<td align="center"><b>Year</b></td>
<td><!-- <select name="year" id="year" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" > -->
			<select class="element select medium" id="year" name="year" style="width: 100px; height: 25px;">
			<option value="Select">Select</option>
<%for(k=2016;k<=2050;k++)
{
%>
<option value="<%=k %>"><%=k %></option>
<%} %>


<%
if(request.getParameter("year") != null){
		
		 %><option value=<%=request.getParameter("year")%> selected><%=request.getParameter("year") %></option><%
}
%>
</select></td>

<td><font size="2"><input type="submit" name ="sub" id ="sub" value="View Data" "></input></font></td>
</tr>
</table>
</td>
</tr>
</table>

</form>



<%


String year=request.getParameter("year");
String month1=request.getParameter("month");
String selected1=request.getParameter("dept");


String name=session.getAttribute("EmpName").toString();

String dept = session.getAttribute("department").toString();

System.out.println("----------->"+month1);
System.out.println("------------>"+year);


String mname="",yname="";
String query123="SELECT MONTH(now()) as MonthName,YEAR(now()) as Year";

ResultSet rs123=st11.executeQuery(query123);
if(rs123.next())
{
	mname=rs123.getString("MonthName");
	yname=rs123.getString("Year");
}



System.out.println("Yname:-------------------->"+yname);



System.out.println("Mname--------------------->:"+mname);


if(mname.equals("1"))
{
	mname="01";
}
else if(mname.equals("2"))
{
	mname="02";
}
else if(mname.equals("3"))
{
	mname="03";
}
else if(mname.equals("4"))
{
	mname="04";
}
else if(mname.equals("5"))
{
	mname="05";
}
else if(mname.equals("6"))
{
	mname="06";
}
else if(mname.equals("7"))
{
	mname="07";
}
else if(mname.equals("8"))
{
	mname="08";
}
else if(mname.equals("9"))
{
	mname="09";
}

System.out.println("Month1:===>"+mname);

if(year==null)
{
	year=yname;
}
if(month1==null)
{
	month1=mname;
}

%>
<script>
document.getElementById("month").value = '<% out.print(month1); %>';
document.getElementById("year").value = '<% out.print(year); %>';
</script>

<% 
String fromDate = year+"-"+month1+"-"+"01";
String toDate="";
String toDate1 ="select last_day ('"+fromDate+"') as monthname3";
System.out.println("monthname 1:- "+toDate1);
ResultSet rsmonthname3=st7.executeQuery(toDate1);
rsmonthname3.next();



String mnth3=rsmonthname3.getString("monthname3");
toDate=mnth3;


System.out.println("todate:"+toDate);


String countday="SELECT DAYNAME('"+toDate+"') as DayName1,DAYOFMONTH('"+toDate+"') as DayCnt ,MONTHNAME('"+toDate+"') as MonthName,YEAR('"+toDate+"') as Year";
String dayCount="";
ResultSet rscount=st8.executeQuery(countday);

if(rscount.next())
{
	dayCount=rscount.getString("DayCnt");
	
}


System.out.println(dayCount);


int dCount=Integer.parseInt(dayCount);


System.out.println(dCount);

System.out.println(year);
System.out.println(month1);


String dt1 = new SimpleDateFormat("MMM")
.format(new SimpleDateFormat("MM")
        .parse(month1));

System.out.println("MONTH AFTER:"+dt1);
%>



<script type="text/javascript">
function payroll(month,year)
{
alert(month);
alert(year);
location.assign("AdvanceClaimReport.jsp");
}

</script>
<form method="post" action="PayRollFinal.jsp" >




<!-- <table id="example"  border: 1px; class="display" style="width:100%"> -->  
<br>
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1"> 


<thead>

            



<tr>

<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">SrNo</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">ID</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Status</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Name</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Dept</th>
<!-- <th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Present<br>Days</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Approved<br>Leaves</th> -->
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Paid<br>Days</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Net Pay</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Basic Fee</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">PI<br>Index</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">PI<br>Fee</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">KRA Fee</th>


<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">KRA<br>Index</th>

<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">KRA<br>Fee</th>

<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Incentive<br>+</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Previous Pay<br>+</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Other Pay<br>+</th>

<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;"> Vehicle<br>+</th>

<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Mobile<br>+</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Rent<br>+</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Laptop<br>+</th>




<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Recovery - </th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">SD -</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">PreviousPay - </th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Mobile -</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Other -</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Reason</th>



<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">Total<br>Recoveries</th>

<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">TDS</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">LeaveBalance</th>
<th style="font-size:11px ; background: #1582AB;  color:white;    face:san-serif;">PaySlip</th>
 



</tr>
</thead>
<tbody>

<%



System.out.println(year);
System.out.println(month1);


DecimalFormat df = new DecimalFormat("0.00");


String emp_id="",EmpName="",Basic_Salary="",MediclaimEndDate="";

String present="",Approvedleav="",paiddays="";
double Allowances=0.00;
double Deduction=0.00;
dept = session.getAttribute("department").toString();

String sessionname=session.getAttribute("EmpName").toString();
System.out.println(dept);
String pay_details="";
String user_id1 = "";

int cnt=0;
String sql_active=null;

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


//String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMaster where Status='Yes'";

String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId in ("+user_id1+")";


ResultSet rs1=st1.executeQuery(empdetails);
System.out.println("Query is:"+empdetails);
int i=1;



Statement local=conleave.createStatement();
Statement local1=conleave.createStatement();
Statement local2=conleave.createStatement();
Statement local3=conleave.createStatement();
Statement local4=conleave.createStatement();




while(rs1.next())
{
	System.out.println("Inside while");
String Depart="",Designation="";
	
	emp_id=rs1.getString("ContractorId");
	EmpName=rs1.getString("ContractorName");
	MediclaimEndDate=rs1.getString("MediclaimEndDate");
	
	String techattenddata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+emp_id+"'";
	  ResultSet rstechattenddata=st12.executeQuery(techattenddata);
	  if(rstechattenddata.next())
	  {
		  Depart=rstechattenddata.getString("Department");
		  Designation=rstechattenddata.getString("Designation");
	  }
	//Depart=rs1.getString("Departement");
	
	String MediClaimStatus="";
	
	if(Designation.equalsIgnoreCase("Technician") || Designation.equalsIgnoreCase("Maid") || Designation.equalsIgnoreCase("Driver"))
	{
		MediClaimStatus="Yes";
	}
	else
	{
	String MedExpiry="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId='"+emp_id+"' and MediclaimEndDate >=now()";
	ResultSet rsMedExpiry=st13.executeQuery(MedExpiry);
	if(rsMedExpiry.next())
	{
		MediClaimStatus="Yes";
	}
	else
	{
		MediClaimStatus="No";
	}
	}
	double krasalary=0.00,basisSalary=0.00,FixedSalary=0.00,vehilcelAllw=0.00,Mobile=0.00,Laptop=0.00,Rent=0.00,other=0.00,tds=0.00;
	String nav="";

	
	String cmaster="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMaster where ContractorId='"+emp_id+"'  ";
	
	ResultSet rs9=st9.executeQuery(cmaster);
	
	if(rs9.next())
	{
		//nav=rs9.getString("EmpName");
		krasalary=rs9.getDouble("KRAFee");
		basisSalary=rs9.getDouble("PIFee");
		FixedSalary=rs9.getDouble("FixedFee");
		vehilcelAllw=rs9.getDouble("VehicleAllowance");
		Mobile=rs9.getDouble("MobileAllowance");
		Laptop=rs9.getDouble("LaptopAllowance");
		Rent=rs9.getDouble("ProximityAllowance");
		other=rs9.getDouble("OtherAllowance");
		tds=rs9.getDouble("TDSPercent");
	}
	System.out.println("data from contractor master");
	System.out.println(nav);
	System.out.println(krasalary);
	System.out.println(basisSalary);
	System.out.println(vehilcelAllw);
	System.out.println(Mobile);
	System.out.println("Laptop Allowances:"+Laptop);
	System.out.println(Rent);
	System.out.println(other);
	System.out.println(tds);
	
	String empdetails1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+emp_id+"' and MediclaimEndDate >=now()";
	ResultSet rs=st9.executeQuery(empdetails1);

	//System.out.println("Claim Query :- "+empdetails);
	
	if(rs.next())
	{
		Status="Active";
		colour="Green";
		
		System.out.println("Claim Date :- "+rs.getString("MediclaimEndDate"));
	}
	else
	{
		Status="Hold (Mediclaim Expired)";
		colour="Red";
		
		System.out.println("Claim Date Expired  ");
	}
	
	
	
	
	
	
	//String alldata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummary where ID='"+emp_id+"' and Month='"+dt1+"'and Year='"+year+"' ";
	
	String alldata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusSummaryNew where ID='"+emp_id+"' and Month='"+dt1+"'and Year='"+year+"' ";
	
	System.out.println(alldata);
	ResultSet rsd=st4.executeQuery(alldata);
	while(rsd.next())
	{
	
	double laptop=rsd.getDouble("LaptopAllowance");
	
	System.out.println(laptop);
	
	
	 double basicfee=rsd.getDouble("BasicPi");
	 double krafee=rsd.getDouble("BasicKra");
	 double KRAAmount=rsd.getDouble("KraAmount");
	 double netPay=rsd.getDouble("AmountToPay");
	 double TDSAmt=rsd.getDouble("TDSAmount");
	 
	 double Advance=rsd.getDouble("Advance");
	 double sd=rsd.getDouble("securityDeposit");
	 double previouspay=rsd.getDouble("PreviousPay");
	 
	 String mobileded=rsd.getString("MobileAllowancesdeduction");
	 if(mobileded.equals("0"))
	 {
		 mobileded="0.00";
	 }
	 System.out.println("mobileded:: "+mobileded);
	
	// double other1=rsd.getDouble("other");
	 String other1=rsd.getString("other");
	 if(other1.equals("0"))
	 {
		 other1="0.00";
	 }
	 System.out.println("other1:: "+mobileded);
	 
	// double paidays1=rsd.getDouble("Paiddays");
	 String paidays1=rsd.getString("Paiddays");
	 if(paidays1.equals("0"))
	 {
		 paidays1="0.00";
	 }
	 System.out.println("paidays1:: "+paidays1);
	 
	// double piindex1=rsd.getDouble("PiIndex");
	 String piindex1=rsd.getString("PiIndex");
	 if(piindex1.equals("0"))
	 {
		 piindex1="0.00";
	 }
	 System.out.println("piindex1:: "+piindex1);
	 
	 
	 double PreviousPayPlus=rsd.getDouble("PreviousPayPlus");
	 double Incentive=rsd.getDouble("Incentive");
	 
	 
	 double kraIndex=rsd.getDouble("KraIndex");
	 double PiIndex=rsd.getDouble("PiIndex");
	 


	 int revision=rsd.getInt("ReviseNo");
	 
	 System.out.println("revision is"+revision);
	 
	 double OtherPlus=rsd.getDouble("OtherPlus");
	 
	 double Incentive1=rsd.getDouble("Incentive");
	 double PreviousPayPlus1=rsd.getDouble("PreviousPayPlus");
	 
	 
	 if(revision > 0)
	 {
		 String reviseddata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"0RevisionMasterNew where Month='"+dt1+"' and Year='"+year+"' and ContractorId='"+emp_id+"' order by Revision desc limit 1";
		 ResultSet rsreviseddata=st13.executeQuery(reviseddata);
		 if(rsreviseddata.next())
		 {
			 
			  paidays1=rsreviseddata.getString("newPaiddays");
			  kraIndex=rsreviseddata.getDouble("newKraIndex");
			  PiIndex=rsreviseddata.getDouble("newPiindex");
			 


			 
			 
			 
			 
			  OtherPlus=rsreviseddata.getDouble("Othernew");
			 
			  Incentive1=rsreviseddata.getDouble("IncentiveNew");
			  PreviousPayPlus1=rsreviseddata.getDouble("PreviousNew");
			 
		 }
				 
	 }
	 
	 String qure="select PaySlipName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where  Month='"+dt1+"' and Year='"+year+"' and ID in ('"+emp_id+"') order by PayrollVersion DESC limit 1";
	 String filename="";
		
		System.out.println("Query is:"+qure);
		
		ResultSet rstr=st12.executeQuery(qure);
		
		
		if(rstr.next())
		{
			 filename=rstr.getString("PaySlipName");
			 System.out.println(" filename--------->"+filename);


		}
	 
	 //String str="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMaster where ID='"+emp_id+"' and Month='"+dt1+"' and Year='"+year+"'";
	 
	 String str="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where ID='"+emp_id+"' and Month='"+dt1+"' and Year='"+year+"'";
	 
	 ResultSet rs32=st12.executeQuery(str);
	 
	 int version=0;
	 
	 if(rs32.next())
	 {
		 version=rs32.getInt("PayrollVersion");
	 }
	 

	 System.out.println("PayRoll Version --------->"+version);
	 	
	%>
	
	
	<tr>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=emp_id%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
	
		<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rsd.getString("Name")%></a></td>
		
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Depart%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="#" onclick="return srk2('<%=emp_id%>','<%=year%>','<%=dt1%>')"><%=paidays1%></a></td>   	<!--Paid Days  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(netPay)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(basicfee)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=piindex1%></td>	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rsd.getDouble("PiAmount")) %></td>	
	
	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(krafee) %></td>
		<!--Basic salary  -->
	<!--Pi index  -->
	
	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rsd.getDouble("KraIndex"))%></td>	<!--KRA Index  -->
	<!--PI AMOUNt  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(KRAAmount)%></td>
	
	
	
		<!--KRA Amount  -->
	
	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(Incentive1)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(PreviousPayPlus1)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(OtherPlus)%></td>
	
	
	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(vehilcelAllw)%></td>	<!--Allowances vehicle  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(Mobile)%></td> <!--Mobile  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(Rent)%></td> <!--Rent  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(laptop)%></td>	
	
	<!--Laptop  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(Advance)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(sd)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(previouspay)%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=mobileded%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=other1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rsd.getString("otherReason")%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(rsd.getDouble("TotalDeduction"))%> </a></td>  <!-- Total Deduction -->
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=df.format(TDSAmt)%></td>	<!--TDS  -->
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="#" onclick="leave('<%=rsd.getString("ID")%>','<%=rsd.getString("Name")%>')"> LeaveBalance</a></td>
  	<td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="#" onclick="pdf('<%=filename%>','<%=month1%>','<%=year%>')"><%=filename%></a></td>
 	
		<!--PAy amount  -->
	
	
	
	
	
		</tr>
	
	<% 
	i++;
	}
			
			
	
	
}



%>
</tbody>
</table>


</form>



<%




%>





<script>

function srk2(emp_id,year,month)
{
	/* alert(emp_id);
	alert(month);
	alert(year); */
	var payroll="payroll";
	location.assign("PaidaysReport.jsp?empId="+emp_id+"&month12="+month+"&year12="+year+"&action="+payroll+"");
	
}

function leave(id,name)
{
	/* alert(id);
	
	alert(name);
	 */
	location.assign("LeaveBalanceReport.jsp?id1="+id+"&name="+name+"");
	
}

function approve1()
{
	
 	/* alert("Hello Inside");  */
	
	

 	var emp_id=document.getElementById("emp_id1").value;
	var mon12=document.getElementById("abc1").value;
	var year12=document.getElementById("yr1").value;
	var empname=document.getElementById("EmpName1").value;
	var depart=document.getElementById("depart1").value;
	
	
	/* 
	alert(emp_id);
	alert(mon12);
	alert(year12);
	alert(empname);
	alert(depart); */
	
	
	
	var piindex=document.getElementById('piindexnew').value;
	var kraindex=document.getElementById('kraindexnew').value;
	var paiddays=document.getElementById('paiddaysnew').value; 
 	var oldpaiddays=document.getElementById('paiddays').value; 
	
	var oldpiindex=document.getElementById('piindex').value;
	var oldkraindex=document.getElementById('kraindex').value;
	
	
	var incentiveold=document.getElementById('special').value;
	var incentivenew=document.getElementById('specialnew').value;
	
	var prepayplusold=document.getElementById('Previous').value;
	var prepayplusnew=document.getElementById('Previousnew').value;
	
	
	
	var otherold=document.getElementById('other12').value;
	var othernew=document.getElementById('othernew12').value;
	
	
/* 	alert(incentiveold);
	alert(incentivenew);
	alert(prepayplusold);
	alert(prepayplusnew); */
	
	
	
	
	
	
	
/* 	alert(oldpaiddays);
	alert(paiddays);
	alert(piindex);
	alert(kraindex);
	alert(oldpiindex);
	alert(oldkraindex); */
	var comment=document.getElementById('comments').value;
	var comment1=document.getElementById('comments1').value;
	var comment2=document.getElementById('comments2').value;
	var comment3=document.getElementById('comments3').value;
	var comment4=document.getElementById('comments4').value;
	var comment5=document.getElementById('comments5').value;
	
	
/* 	alert(comment5);
	alert(otherold);
	alert(othernew); */
	
	
/* 	alert(comment);
	alert(comment1);
	alert(comment2);
	alert(comment3);
	alert(comment4); */
	
	
	if(otherold!==othernew)
		{
		if(comment5=="")
			{
			alert("Other Comment is empty");
			return false;
			}
		}
	
	
	 if(oldpaiddays!==paiddays)
		{
		if(comment=="")
			{
			alert("Paid comments is empty");
			return false;
			}
		}
	
	
	if(oldpiindex!==piindex)
		{
		 if(comment1=="")
			{
			alert("PiIndex comments is empty");
			return false;
			} 
		}
		
	
	if(oldkraindex!==kraindex)
		{
		if(comment2=="")
			{
			alert("KRAIndex  comment is empty");
			return false;
			}
		}
	
	if(oldpaiddays==paiddays && oldpiindex==piindex && oldkraindex==kraindex && incentiveold==incentivenew && prepayplusold==prepayplusnew)
		{
		alert("Data not Updated");
		return false;
		
		} 
	
	if(incentiveold!==incentivenew)
	{
	if(comment3=="")
		{
		alert("Incentive Comment are empty");
		return false;
		}
	}
if(prepayplusold!==prepayplusnew)
	{
	if(comment4=="")
		{
		alert("Previous Pay Comment are Empty");
		return false;
		}
	
	}
	
	
	
	
var availability=document.getElementById("paiddaysnew").value;



var invalid=/^[0-9]+[.]{0,1}[0-9]{0,2}$/;

if(availability>31)
	 {
	 alert("Please make valid entry");
	 return false;
	 }


if(!invalid.test(availability))
	 {
	 alert("Please make valid entry for Availability");
	 return false;
	 
	 }




var piindexnew=document.getElementById("piindexnew").value;

var invalid=/^[0-9]+[.]{0,1}[0-9]{0,2}$/;



if(!invalid.test(piindexnew))
	{
	alert("Please Make Valid Entry for PiIndex");
	return false;
	
	}


var kraindexnew=document.getElementById("kraindexnew").value;


if(!invalid.test(kraindexnew))
	{
	alert("Please Make Valid Entry For KraIndex");
	return false;
	}

var specialnew=document.getElementById("specialnew").value;
/* 	alert(specialnew); */

var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
if(!invalid.test(specialnew))
	{
	alert("Please Make Valid Entry for Incentive");
	return false;
	}

var Previousnew=document.getElementById("Previousnew").value;
/* 	alert(Previousnew); */

var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;

if(!invalid.test(Previousnew))
	{
	alert("Please Make Valid Entry for Previous Pay");
	return false;
	}

	
var othernew=document.getElementById("othernew12").value;

var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;

if(!invalid.test(othernew))
	{
	alert("Please Make Valid Entry For Other");
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	location.assign("PayRollmodify.jsp?Empid="+emp_id+"&Name="+empname+"&depart="+depart+"&month="+mon12+"&year="+year12+"&kraindexnew="+kraindex+"&piindexnew="+piindex+"&oldpi="+oldpiindex+"&oldkra="+oldkraindex+"&picmt="+comment1+"&kracmt="+comment2+"&oldpaid="+oldpaiddays+"&paiddaysnew="+paiddays+"&paidcmt="+comment+"&otherold="+otherold+"&othernew="+othernew+"&othercomment="+comment5+"&incentiveold="+incentiveold+"&incentivenew="+incentivenew+"&incentiveComment="+comment3+"&prepayplusold="+prepayplusold+"&prepayplusnew="+prepayplusnew+"&prepaypluscomment="+comment4+"");
	
	
	
	
	//get comments
	
	 
	
	/*var comment3=document.getElementById('comments3').value; */
	 
	

	
	
/* 	alert(comment);
	alert(comment1)
	alert(comment2)
	alert(comment3)
	
	
	alert(paiddays);
	alert(piindex);
	alert(kraindex);
	
	alert(emp_id);
	alert(mon12);
	alert(year12);
	alert(empname);
	
	
	alert(oldpaiddays);
	alert(oldpiindex);
	alert(oldkraindex);
	alert("old data"); */
	
	
	
	
	
	/* location.assign("PayRollmodify.jsp?Empid="+emp_id+"&Name="+empname+"&depart="+depart+"&month="+mon12+"&year="+year12+"&kraindexnew="+kraindex+"&piindexnew="+piindex+"&paiddaysnew="+paiddays+"&oldpi="+oldpiindex+"&oldpaid="+oldpaiddays+"&oldkra="+oldkraindex+"&paidcmt="+comment+"&picmt="+comment1+"&kracmt="+comment2+"&speccmt="+comment3+""); */
	

	/* location.assign("PayRollmodify.jsp?Empid="+emp_id+"&Name="+empname+"&depart="+depart+"&month="+mon12+"&year="+year12+"&kraindexnew="+kraindex+"&piindexnew="+piindex+"&oldpi="+oldpiindex+"&oldkra="+oldkraindex+"&picmt="+comment1+"&kracmt="+comment2+""); */
	
	
	
}



function approve2()
{
	
 	/* alert("Hello Inside");  */
	
	

 	var emp_id=document.getElementById("emp_id11").value;
	var mon12=document.getElementById("abc11").value;
	var year12=document.getElementById("yr11").value;
	var empname=document.getElementById("EmpName11").value;
	var depart=document.getElementById("depart11").value;
	
	

var special1=document.getElementById("special1").value;
	
	var specialnew1=document.getElementById("specialnew1").value;
	
	var Previous1=document.getElementById("Previous1").value;
	var Previousnew1=document.getElementById("Previousnew1").value;
	
	var other=document.getElementById("other1").value;
	var othernew=document.getElementById("othernew").value;
	
/* 	alert(other);
	alert(othernew); */
	
	var comments11=document.getElementById("comments11").value;
	var comments21=document.getElementById("comments21").value;
	var comments31=document.getElementById("comments31").value;
	
	
	
	if(special1!==specialnew1)
		{
		if(comments11=="")
			{
			alert("Incentive Comment is Empty");
			return false;
			
			}
		}
	
	
	
	if(Previous1!==Previousnew1)
		{
		if(comments21=="")
			{
			alert("Previous Pay Comment is Empty");
			return false;
			}
		}
	
	if(other!==othernew)
		{
			if(comments31=="")
				{
				alert("Other Comment is Empty");
				return false;
				}
		}

	
	
	
	var specialnew=document.getElementById("specialnew1").value;
	/* 	alert(specialnew); */
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		if(!invalid.test(specialnew))
			{
			alert("Please Make Valid Entry for Incentive");
			return false;
			}
		
		var Previousnew=document.getElementById("Previousnew1").value;
	/* 	alert(Previousnew); */
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		
		if(!invalid.test(Previousnew))
			{
			alert("Please Make Valid Entry for Previous Pay");
			return false;
			}
		
		
		
		var othernew=document.getElementById("othernew").value;
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		
		if(!invalid.test(othernew))
			{
			alert("Please Make Valid Entry For Other");
			return false;
			}
	
	
	
	
	
	
	
	
	
	
	/* alert(emp_id);
	alert(mon12);
	alert(year12);
	alert(empname);
	alert(depart); */

	/* alert("Validation successfull"); */
	
	location.assign("PayRollmodify1.jsp?Empid="+emp_id+"&Name="+empname+"&depart="+depart+"&month="+mon12+"&year="+year12+"&incentiveold="+special1+"&incentivenew="+specialnew1+"&comment11="+comments11+"&Previousold="+Previous1+"&PreviousNew="+Previousnew1+"&comment21="+comments21+"&other="+other+"&othernew="+othernew+"&comments31="+comments31+"");
	

	
}




function srk3(emp_id,name,year,month,dept,previoudpayplus,Incentive,otherplus)
{
	
	document.getElementById('emp_id11').value = emp_id;
    document.getElementById('EmpName11').value =name;
    document.getElementById('abc11').value =month;
    document.getElementById('yr11').value= year;
    document.getElementById('depart11').value= dept;
    
    document.getElementById('special1').value=Incentive;
    
    
    document.getElementById('specialnew1').value=Incentive;
    
    
    document.getElementById('Previous1').value=previoudpayplus;
    document.getElementById('Previousnew1').value=previoudpayplus;
    
    document.getElementById('other1').value=otherplus;
    document.getElementById('othernew').value=otherplus;
    
    
}


function pdf(filename,month,year)
{
	/* alert(filename);
	alert(month);
	alert(year); */
	location.assign("Dowanloadpayslip.jsp?payslipname="+filename+"&month="+month+"&year="+year+"");
}



function srk1(emp_id,name,paiddays,year,month,dept,kra,pi,Incentive,previoudpayplus,OtherPlus)
{


    

    alert("HELLO");
    
    
	document.getElementById('emp_id1').value = emp_id;
    document.getElementById('EmpName1').value =name;
    document.getElementById('abc1').value =month;
    document.getElementById('yr1').value= year;
    document.getElementById('depart1').value= dept;
    document.getElementById('piindex').value= pi;
    document.getElementById('kraindex').value= kra;
    document.getElementById('paiddays').value= paiddays;
    
    
    
	/* alert(previoudpayplus);
	alert(Incentive); */
	
    
    document.getElementById('special').value=Incentive;
    
   
    document.getElementById('specialnew').value=Incentive;
    
    
    document.getElementById('Previous').value=previoudpayplus;
    document.getElementById('Previousnew').value=previoudpayplus;
    
    
    document.getElementById('kraindexnew').value=kra;
    document.getElementById('piindexnew').value=pi;
    document.getElementById('paiddaysnew').value=paiddays;
    
    
    document.getElementById('other12').value=OtherPlus;
    
    document.getElementById('othernew12').value=OtherPlus;
    
    
	return true;
	
}












function srk(Empid,ak,month,yr,Deprt)
{
	/* alert(ak);
	alert(month);
	alert(Empid);
	alert(yr);
	alert(Deprt); */
	document.getElementById('emp_id').value = Empid;
    document.getElementById('EmpName').value =ak;
    document.getElementById('abc').value= month;
    document.getElementById('yr').value= yr;
    document.getElementById('depart').value= Deprt;
    
    
    
	return true;
	
}


</script>








<script>
function approve()
{

	var advanceamt=document.getElementById("advancemoney").value;
	var sd=document.getElementById("safetyamount").value;
	var mobile=document.getElementById("mobileamount").value;
	
	var perviouspay=document.getElementById("peramount").value;
	
	
	var comments=document.getElementById("mycomments").value;
	
	var otheramt=document.getElementById("otheramount").value;

	
	
	var emp_id=document.getElementById("emp_id").value;
	var mon12=document.getElementById("abc").value;
	var year12=document.getElementById("yr").value;
	var empname=document.getElementById("EmpName").value;
	var depart=document.getElementById("depart").value;
	
	
	
	/* alert(empname);
	alert(depart); */

	


	
	
	if(otheramt>0)
		{
		if(comments=="")
			{
			alert("Comments are mandatory when OtherAmount is greater than Zero");
			return false;
			}
		}
	
	
	
	var invalid=/^\d+(\.\d+)?$/;
	
	
	
	if(!invalid.test(advanceamt))
		{
		alert("Please enter valid amount");
		return false;
		} 

	
	if(!invalid.test(sd))
	{
	alert("Please enter valid amount");
	return false;
	} 

	if(!invalid.test(mobile))
	{
	alert("Please enter valid amount");
	return false;
	} 
	
	
	
	
	location.assign("insertRecoveries.jsp?Empid="+emp_id+"&Name="+empname+"&depart="+depart+"&month="+mon12+"&year="+year12+"&advance="+advanceamt+"&securitydeposite="+sd+"&mobile="+mobile+"&prepay="+perviouspay+"&otheramount="+otheramt+"&comments="+comments+""); 
		
	
}


</script>







<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <div align="center">
          <h4 class="modal-title" style=" background-color: #1582AB;color: white;">Add Recoveries</h4>
        	</div>
        Contractor ID: <input type="text" id="emp_id" name="emp_id" readonly="readonly" style="width: 10%;border: none;font-weight:bold; ">
        Name:<input type="text" id="EmpName" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;&nbsp;
        Department:<input type="text" id="depart" readonly="readonly" style="width: 15%;border: none; font-weight:bold;">&nbsp;&nbsp;<br>
         
      	Month:<input type="text" id="abc" readonly="readonly" style="width: 18%;border: none; font-weight:bold;">&nbsp;&nbsp;
      	Year:<input type="text" id="yr"   readonly="readonly"  style="width: 10%;border: none; font-weight:bold;">
        </div>
        <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
     
        
<div class="container-fluid">
 

 
   <div class="row">
   
   <div class="col-sm-6">
      Advance:
    </div>
    
     <div class="col-sm-4">
       <input type="text" id="advancemoney" name="advancemoney" onblur="valid();"  value="0.00" ></input><br></br>
    </div>
    
    <div class="col-sm-2">
    </div>
    <div class="col-sm-4">
    </div>
    
  </div>
  
  <br>
   <div class="row">
   
   <div class="col-sm-6">
     Security Deposit:
    </div>
    
     <div class="col-sm-4">
     <input type="text" id="safetyamount" name="safetyamount" onblur="valid();"   value="0.00"></input><br></br>
    </div>
    
    <div class="col-sm-2">
    </div>
    <div class="col-sm-4">
    </div>
    
  </div>
  <br>
  
     <div class="row">
   
   <div class="col-sm-6">
      Mobile Allowances
    </div>
    
     <div class="col-sm-4">
      <input type="text" id="mobileamount" name="mobileamount" onblur="valid();"  value="0.00"></input><br></br> 
    </div>
    
    <div class="col-sm-2">
    </div>
    <div class="col-sm-4">
    </div>
    
  </div>
  
  
  
  
     <div class="row">
   
   <div class="col-sm-6">
      Previous Pay:
    </div>
    
     <div class="col-sm-4">
      <input type="text" id="peramount" name="peramount" onblur="valid();"  value="0.00"></input><br></br> 
    </div>
    
    <div class="col-sm-2">
    </div>
    <div class="col-sm-4">
    </div>
    
  </div>
  
  
  
  
  
  <br>
   <div class="row">
   
   <div class="col-sm-6">
        Other:
    </div>
    
     <div class="col-sm-4">
      <input type="text" id="otheramount" name="otheramount" onblur="check();"  value="0.00" ></input><br></br> 
      <textarea id="mycomments"  name="mycomments" rows="4" cols="20"  placeholder="Other Reason"  ></textarea><br></br>
     	
    </div>
    
    <div class="col-sm-2">
    
    </div>
    <div class="col-sm-4">
    
    </div>
    
  </div>
  
  
 
 
 </div>
 </div>
        
 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="return approve();">Submit</button>
          
        </div>
      </div>
      
    </div>
  </div>
  </div>
  
</div>



<script>

function validate1()
{
	
	var special1=document.getElementById("special1").value;
	
	var specialnew1=document.getElementById("specialnew1").value;
	
	var Previous1=document.getElementById("Previous1").value;
	var Previousnew1=document.getElementById("Previousnew1").value;
	
	var other=document.getElementById("other1").value;
	var othernew=document.getElementById("othernew").value;
	
/* 	alert(other);
	alert(othernew); */
	
	var comments11=document.getElementById("comments11").value;
	var comments21=document.getElementById("comments21").value;
	var comments31=document.getElementById("comments31").value;
	
	
	
	if(special1!==specialnew1)
		{
		if(comments11=="")
			{
			alert("Incentive Comment is Empty");
			}
		}
	
	
	
	if(Previous1!==Previousnew1)
		{
		if(comments21=="")
			{
			alert("Previous Pay Comment is Empty");
			}
		}
	
	if(other!==othernew)
		{
			if(comments31=="")
				{
				alert("Other Comment is Empty");
				}
		}
	
	
	
/* 	alert(comments11);
	alert(comments21);
	alert(comments31);
	
	alert(special1);
	alert(specialnew1);
	alert(Previous1);
	alert(Previousnew1);
	alert(other)
	alert(othernew); */
}


</script>



<script>

function validate()
{
	
	
	var piindex=document.getElementById('piindexnew').value;
	var kraindex=document.getElementById('kraindexnew').value;
	 var paiddays=document.getElementById('paiddaysnew').value; 
 	var oldpaiddays=document.getElementById('paiddays').value; 
	
	var oldpiindex=document.getElementById('piindex').value;
	var oldkraindex=document.getElementById('kraindex').value;
	
	
	var incentiveold=document.getElementById('special').value;
	var incentivenew=document.getElementById('specialnew').value;
	
	var prepayplusold=document.getElementById('Previous').value;
	var prepayplusnew=document.getElementById('Previousnew').value;
	
	var otherold=document.getElementById('other12').value;
	var othernew=document.getElementById('othernew12').value;
	
	
	/* alert(otherold);
	alert(othernew); */
	

	
	
	
	
	
	

	var comment=document.getElementById('comments').value;
	var comment1=document.getElementById('comments1').value;
	var comment2=document.getElementById('comments2').value;
	var comment3=document.getElementById('comments3').value;
	var comment4=document.getElementById('comments4').value;
	
	var comment5=document.getElementById('comments5').value;
	
/* 	alert(comment5); */
	

	if(otherold!==othernew)
		{
		if(comment5=="")
			{
			alert("Other commennt is Empty");
			return false;
			}
		}
	
	
	
	 if(oldpaiddays!==paiddays)
		{
		if(comment=="")
			{
			alert("Paid comments is empty");
			return false;
			}
		}
	
	
	if(oldpiindex!==piindex)
		{
		 if(comment1=="")
			{
			alert("PiIndex comments is empty");
			return false;
			} 
		}
		
	
	if(oldkraindex!==kraindex)
		{
		if(comment2=="")
			{
			alert("KRAIndex  comment is empty");
			return false;
			
			}
		}
	
	/* if(oldpaiddays==paiddays && oldpiindex==piindex && oldkraindex==kraindex && incentiveold==incentivenew && prepayplusold==prepayplusnew)
		{
		alert("No Updation In the data");
		return false;
		
		} 
	 */
	if(incentiveold!==incentivenew)
	{
	if(comment3=="")
		{
		alert("Incentive Comment are empty");
		return false;
		}
	}
if(prepayplusold!==prepayplusnew)
	{
	if(comment4=="")
		{
		alert("Previous Pay Comment are Empty");
		return false;
		}
	
	}
	
	
	
	 
	
	
	
	
	
}



</script>


<script>
function chek11()
{
	var specialnew=document.getElementById("specialnew1").value;
	/* 	alert(specialnew); */
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		if(!invalid.test(specialnew))
			{
			alert("Please Make Valid Entry for Incentive");
			}
		
		var Previousnew=document.getElementById("Previousnew1").value;
	/* 	alert(Previousnew); */
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		
		if(!invalid.test(Previousnew))
			{
			alert("Please Make Valid Entry for Previous Pay");
			}
		
		
		
		var othernew=document.getElementById("othernew").value;
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		
		if(!invalid.test(othernew))
			{
			alert("Please Make Valid Entry For Other");
			}
	
}



</script>





<script>
function chek1()
{
	var availability=document.getElementById("paiddaysnew").value;
	

	
	 var invalid=/^[0-9]+[.]{0,1}[0-9]{0,2}$/;
	 
	 if(availability>31)
		 {
		 alert("Please make valid entry");
		 }
	 
	 
	 if(!invalid.test(availability))
		 {
		 alert("Please make valid entry for Availability");
		 }
	
	
	
	
	var piindexnew=document.getElementById("piindexnew").value;
	
	var invalid=/^[0-9]+[.]{0,1}[0-9]{0,2}$/;
	

	
	if(!invalid.test(piindexnew))
		{
		alert("Please Make Valid Entry for PiIndex");
		}
	
	
	var kraindexnew=document.getElementById("kraindexnew").value;
	
	
	if(!invalid.test(kraindexnew))
		{
		alert("Please Make Valid Entry For KraIndex");
		}
	
	var specialnew=document.getElementById("specialnew").value;
/* 	alert(specialnew); */
	
	var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
	if(!invalid.test(specialnew))
		{
		alert("Please Make Valid Entry for Incentive");
		}
	
	var Previousnew=document.getElementById("Previousnew").value;
/* 	alert(Previousnew); */
	
	var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
	
	if(!invalid.test(Previousnew))
		{
		alert("Please Make Valid Entry for Previous Pay");
		}
	
	var other=document.getElementById("othernew12").value;
	
	var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
	
	if(!invalid.test(other))
		{
		alert("Please Enter Valid Entry for Other Pay");
		}
	
	

	
	
}


</script>




<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="myModal1" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         
         <div align="center">
          <h4 class="modal-title" style=" background-color: #1582AB;color: white;">PayRoll Revision</h4>
        	</div>
        Contractor ID: <input type="text" id="emp_id1" name="emp_id" readonly="readonly" style="width: 10%;border: none;font-weight:bold; ">
        Name:<input type="text" id="EmpName1" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;&nbsp;
        Department:<input type="text" id="depart1" readonly="readonly" style="width: 15%;border: none; font-weight:bold;">&nbsp;&nbsp;<br>
         
      	Month:<input type="text" id="abc1" readonly="readonly" style="width: 18%;border: none; font-weight:bold;">&nbsp;&nbsp;
      	Year:<input type="text" id="yr1"   readonly="readonly"  style="width: 10%;border: none; font-weight:bold;">
        </div>
        <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
     
        
<div class="container-fluid">
 
   <div class="row">
   
  
  <div class="col-sm-2">
    <b></b>
    </div>
   
      <div class="col-sm-3">
    <b>Current</b>
    </div>
  	<div class="col-sm-3">
      <b>New</b>
    </div>
    <div class="col-sm-3">
      <b>Comments</b>
    </div>
        <br>
  
   
  
  <br>
  
   <div class="row">
   
    <div class="col-sm-2">
   Availability
    </div>
      <div class="col-sm-3">
    <input type="text" id="paiddays" name="paidays" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="paiddaysnew"  name="paiddaysnew"  style="width: 100%;" onblur="chek1();" required ></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments"  name="comments" rows="2" cols="15" onblur="validate();"  placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div> 
  
  
    <div class="row">
   
    <div class="col-sm-2">
    Pi Index
    </div>
      <div class="col-sm-3">
    <input type="text" id="piindex" name="piindex" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="piindexnew" name="piindexnew" style="width: 100%;" onblur="chek1();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments1"  name="comments1" rows="2" cols="15" onblur="validate();"  placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div>

  
  
  
    <div class="row">
   
    <div class="col-sm-2">
    Kra Index
    </div>
      <div class="col-sm-3">
    <input type="text" id="kraindex" name="kraindex" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="kraindexnew" name="kraindexnew" style="width: 100%;" onblur="chek1();"></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments2"  name="comments2" rows="2" cols="15" onblur="validate();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div>
   
   
   
   
    <div class="row">
   
    <div class="col-sm-2">
   Incentive
    </div>
      <div class="col-sm-3">
    <input type="text" id="special" name="special" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="specialnew" name="specialnew" style="width: 100%;" onblur="chek1();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments3"  name="comments3" rows="2" cols="15" onblur="validate();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div>    
   
   
   
       <div class="row">
   
    <div class="col-sm-2">
    Previous Pay
    </div>
      <div class="col-sm-3">
    <input type="text" id="Previous" name="Previous" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="Previousnew" name="Previousnew" style="width: 100%;" onblur="chek1();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments4"  name="comments4" rows="2" cols="15" onblur="validate();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div> 
   
   
   
     <div class="row">
   
    <div class="col-sm-2">
    Other
    </div>
      <div class="col-sm-3">
    <input type="text" id="other12" name="other12" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="othernew12" name="othernew12" style="width: 100%;" onblur="chek1();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments5"  name="comments5" rows="2" cols="15" onblur="validate();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div>
   
 
    
  </div>

 
 
    
  </div>
  
  
 
 
 </div>
 </div>
        
 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="return approve1();">Submit</button>
          
        </div>
      </div>
      
    </div>
  </div>
  </div>
  
  
  
  
  <!--User Interface get displayed when Revision  is Zero  -->
  
  
  
  <div class="container">

  <!-- Modal -->
  <div class="modal fade" id="myModal2" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         
         <div align="center">
          <h4 class="modal-title" style=" background-color: #1582AB;color: white;">PayRoll Revision</h4>
        	</div>
        Contractor ID: <input type="text" id="emp_id11" name="emp_id" readonly="readonly" style="width: 10%;border: none;font-weight:bold; ">
        Name:<input type="text" id="EmpName11" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;&nbsp;
        Department:<input type="text" id="depart11" readonly="readonly" style="width: 15%;border: none; font-weight:bold;">&nbsp;&nbsp;<br>
         
      	Month:<input type="text" id="abc11" readonly="readonly" style="width: 18%;border: none; font-weight:bold;">&nbsp;&nbsp;
      	Year:<input type="text" id="yr11"   readonly="readonly"  style="width: 10%;border: none; font-weight:bold;">
        </div>
        <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
     
        
<div class="container-fluid">
 
   <div class="row">
   
  
  <div class="col-sm-2">
    <b></b>
    </div>
   
      <div class="col-sm-3">
    <b>Current</b>
    </div>
  	<div class="col-sm-3">
      <b>New</b>
    </div>
    <div class="col-sm-3">
      <b>Comments</b>
    </div>
        <br>
  
   
  
  <br>
 
  
 <div class="row">
   
    <div class="col-sm-2">
   Incentive
    </div>
      <div class="col-sm-3">
    <input type="text" id="special1" name="special" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="specialnew1" name="specialnew" style="width: 100%;" onblur="chek11();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments11"  name="comments11" rows="2" cols="15" onblur="validate1();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div>    
   
   
   
       <div class="row">
   
    <div class="col-sm-2">
    Previous Pay
    </div>
      <div class="col-sm-3">
    <input type="text" id="Previous1" name="Previous" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="Previousnew1" name="Previousnew" style="width: 100%;" onblur="chek11();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments21"  name="comments21" rows="2" cols="15" onblur="validate1();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div> 
   
   
   
   
     <div class="row">
   
    <div class="col-sm-2">
    Other
    </div>
      <div class="col-sm-3">
    <input type="text" id="other1" name="other" style="width: 50%; border: none;" readonly="readonly"></input><br></br> 
    </div>
  	<div class="col-sm-3">
      <input type="text" id="othernew" name="othernew" style="width: 100%;" onblur="chek11();" required></input><br></br>
    </div>
    <div class="col-sm-3">
      <textarea id="comments31"  name="comments31" rows="2" cols="15" onblur="validate1();" placeholder="Comments"  ></textarea><br></br>
    </div>
        
  </div>
   
 
    
  </div>

 
 
    
  </div>
  
  
 
 
 </div>
 </div>
        
 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="return approve2();">Submit</button>
          
        </div>
      </div>
      
    </div>
  </div>
  </div>
  
  
  
  
  
  
</div>













































</jsp:useBean>
</body>
</html>
<%@ include file="footer_new.jsp" %>