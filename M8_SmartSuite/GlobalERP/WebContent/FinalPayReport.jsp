 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">
<%
Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;

try {

	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    st10 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
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
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637">Final Pay Detail</h5>
    </div>
</div>

<form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2">
				  <label for="dropdown"><b>Month</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="month" name="month">
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
	
		
		
	if(request.getParameter("month")!=null)
	{

		%> <option value=<%=request.getParameter("month")%> selected><%=mon %></option><%
	
	}}
%>
</select>
 <script>
                            const mySel = document.getElementById("month");
							const isBtNull = false;
                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>			
</div>
</div>
<div class="col-md-2">
				  <label for="dropdown"><b>Year</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="year" name="year">
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
</select>
 <script>
                            const mySel1 = document.getElementById("year");
							const isBtNull = false;
                            // On page load
                             const savedValue1 = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel1.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue1) {
                              mySel1.value = savedValue1; // Restore saved value
                               }

                             // Add change event listener
                              mySel1.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>	
</div>
</div>
<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit"  onclick="return confirmSubmit()">
			</div>
			<div class="col-md-2"></div>
		</div>
						
</form>	
<%

String year=request.getParameter("year");
String month1=request.getParameter("month");


System.out.println("----------->"+month1);
System.out.println("------------>"+year);

dept = session.getAttribute("department").toString();

String sessionname=session.getAttribute("EmpName").toString();
System.out.println(dept);

String mname="",yname="";
String query123="SELECT (MONTH(NOW()) - 1) as MonthName,YEAR(now()) as Year";

ResultSet rs123=st1.executeQuery(query123);
if(rs123.next())
{
	mname=rs123.getString("MonthName");
	yname=rs123.getString("Year");
}
if (mname.equalsIgnoreCase("0"))
{System.out.println("INNNNNNNNNNNNNNNNNNN");
mname="01";
	
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


String dt11 = new SimpleDateFormat("MMM")
.format(new SimpleDateFormat("MM")
        .parse(month1));

System.out.println("MONTH AFTER:"+dt11);



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
	
}
else
{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes'  and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}


System.out.println("The EmpCode Id query is ==>>"+sql_active);

ResultSet rs_active = st2.executeQuery(sql_active);

while(rs_active.next()){
++cnt;
if(cnt == 1)
{
	user_id1 = rs_active.getString("user_id");
	user_id1="\'"+user_id1+"\'";
}
else
{
	user_id1 = user_id1 +",\'"+rs_active.getString("user_id")+"\'";
}

}

System.out.println("-------->"+user_id1);

ResultSet rs=null;
String Status="",colour="";
String year1=request.getParameter("year");
year1=year;


System.out.println("Selected Month :- "+month1);
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

 role=session.getAttribute("role").toString();


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

<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
				<th>SrNo</th>
				<th>Status</th>
				<th>Name</th>
				<th>ID</th>
				<th>Department</th>
				<th>PaidDays</th>
				<th>LastVersion</th>
				<th>Last Pay</th>
				<th>CurrentVersion</th>
				<th>Net Pay</th>
				<th>Difference Pay</th>
				<th>LeaveBalance</th>
				<th>PIIndex</th>
				<th>PI Amount</th>
				<th>KRAIndex</th>
				<th>KRA Amount</th>
				<th>Total Deduction</th>
				<th>Total Allowances</th>
				<th>PayRoll Version</th>
				<th>PaySlip</th>
				<th>TDS</th>
				<th>Entry Date</th>
				<th>Entry By</th>
			</tr>
</thead>
<tbody>
<%
String query1="select distinct(ID) as ID from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where  Month='"+month1+"' and Year='"+year1+"' and ID in ("+user_id1+")";

System.out.println(query1);

ResultSet rs21=st3.executeQuery(query1);
int i=1;
while(rs21.next())
{
try
{
	String query="";
	String id123=rs21.getString("ID");
	String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+id123+"' and MediclaimEndDate >=now()";
	ResultSet rsempdetails=st2.executeQuery(empdetails);
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
	ResultSet rs12=st4.executeQuery(query);
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
			String PrevPayVersion="select ID,Name,Department,Paiddays,PiIndex,PiAmount,KraIndex,KraAmount,TotalDeduction,(VehicleAllowance+MobileAllowance+LaptopAllowance) As TotalAllowances,Advance,securityDeposit,PreviousPay,other,PayrollVersion,PaySlipName,TDSAmount,AmountToPay,EntryDate,EntryBy from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where  Month='"+month1+"' and Year='"+year1+"' and ID in ('"+id123+"') and  PayrollVersion='1'";
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
			DifferenceInPay=AmtToPay-AmoutToPay;	
		String Entrydate = new SimpleDateFormat("dd-MMM-yyyy")
		        .format(new SimpleDateFormat("yyyy-MM-dd")
		                .parse(Edate)); 
		
		System.out.println("Date is:"+Edate);
		double piAmount=rs12.getDouble("PiAmount");
		double KraAmount=rs12.getDouble("KraAmount");
		double totalAllowance=rs12.getDouble("TotalAllowances");
		
		String filename=rs12.getString("PaySlipName");
		
		System.out.println("filename: "+filename);
		
		%>
		 <tr>
			<td class="text-center"><%=i%></td>
			<td style="color:<%=colour %>" class="text-left"><b><%=Status%></b></td>
			<td class="text-left"><%=rs12.getString("Name")%></td>
			
			<td class="text-center"><%=rs12.getString("ID")%></td>
			<td class="text-left"><%=rs12.getString("Department")%></td>
			<td class="text-center"><a href="#" onclick="srk('<%=rs12.getString("ID")%>','<%=month1%>','<%=year1%>')"><%=df.format(rs12.getDouble("Paiddays"))%></a></td>
			<td class="text-center"><%=PayrollVersionNew%></td>
			<td class="text-center"><%=df.format(AmtToPay)%></td>
			<td class="text-center"><%=PayrollVersion%></td>
			
			
			<%
	
	if(Status.endsWith("Hold (Mediclaim Expired)"))
			{  		colour="Red";
			Status="Hold";


		%>
		
	<td style="color:<%=colour %>" class="text-left"><b><%=Status%></b></td>
		
			<%}else
			{ %>
			
			<td class="text-center"><%=df.format(rs12.getDouble("AmountToPay"))%></td>
			
			
			<%} %>
	<%	double diffpay=rs12.getDouble("AmountToPay")-AmtToPay;
 %>
				<td class="text-center"><%=df.format(diffpay)%></td>
			
			<td class="text-left"><a href="#" onclick="leave('<%=rs12.getString("ID")%>','<%=rs12.getString("Name")%>')"> LeaveBalance</a></td>
			<td class="text-center"><%=df.format(rs12.getDouble("PiIndex"))%></td>
			<td class="text-center"><%=df.format(piAmount)%></td>
			<td class="text-center"><%=df.format(rs12.getDouble("KraIndex"))%></td>
			<td class="text-center"><%=df.format(KraAmount)%></td>	
			<td class="text-center"><%=df.format(rs12.getDouble("TotalDeduction"))%></td>
			<td class="text-center"><%=df.format(totalAllowance)%></td>	
			<td class="text-center"><%=rs12.getString("PayrollVersion")%></td>
		 	<td class="text-center"><a href="#" onclick="pdf('<%=filename%>','<%=month1%>','<%=year1%>')"><%=rs12.getString("PaySlipName")%></a></td> 
			<td class="text-center"><%=df.format(rs12.getDouble("TDSAmount"))%></td>
			<td class="text-right"><%=Entrydate%></td>
			<td class="text-left"><%=rs12.getString("EntryBy")%></td>
		 </tr>
		 
		 <%
		 System.out.println("month1: "+month1);
		 System.out.println("year1: "+year1);
		 System.out.println("PaySlipName : "+rs12.getString("PaySlipName"));
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
i++;
}

String payslipPath = System.getenv("TWPayslips_FilePath");
System.out.println("payslipPath "+ payslipPath);

if(payslipPath != null){
    payslipPath = payslipPath.replace("/var/www/html/", "https://twtech.in/");
}
%>
</tbody>
</table>

<script>
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
function leave(id,name)
{
	location.assign("LeaveBalanceReport.jsp?id1="+id+"&name="+name+"");
}

function pdf(filename, month, year)
{
    var basePath = "<%=payslipPath%>";
    var folder = "PaySlip-" + month + "-" + year;
    var fileURL = basePath + folder + "/" + filename + ".pdf";
    window.open(fileURL, "_blank");
}
function srk(emp_id,month,year)
{
	var payroll="payroll";
	location.assign("PaidaysReport.jsp?empId="+emp_id+"&month12="+month+"&year12="+year+"&action="+payroll+"");
}
</script>
<script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         fixedColumns: { 
	            left: 4      //To freeze two columns
	        }, 
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Final Pay Report '+$("#month").val()+'-'+$("#year").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>