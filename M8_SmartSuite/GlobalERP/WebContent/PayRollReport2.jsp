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
Connection conleave = null;
Connection con1 = null;
Statement st4 = null,st1=null,st3=null, st10=null,st13=null,st12=null,st7=null,st8=null,st9=null,st710=null,st11=null;
try {
	con1 = connection.getConnect("db_GlobalERP"); 
	conleave = connection.getConnect("db_leaveapplication"); 
	
		 st=con1.createStatement();
		 st1=con1.createStatement();
		 st3=con1.createStatement();
		 st4=con1.createStatement();	
		  st7=con1.createStatement();
		  st8=con1.createStatement();
		  st9=con1.createStatement();
		  st10=con1.createStatement();
		  st11=con1.createStatement();
		  st12=con1.createStatement();
		  st13=con1.createStatement();
		
	
} catch (Exception e) {
    e.printStackTrace();
} 

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
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">PayRoll Data For <%=cname %></h5>
    </div>
</div>

<form name="indexReport" method="get"  onsubmit="return confirmSubmit()"  action="">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2">
				  <label for="dropdown"><b>Month</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="month" name="month">
                            <option value="Select">Select</option>
                            <%
                String[][] months = {
                    {"01","JAN"}, {"02","FEB"}, {"03","MAR"},
                    {"04","APR"}, {"05","MAY"}, {"06","JUN"},
                    {"07","JUL"}, {"08","AUG"}, {"09","SEP"},
                    {"10","OCT"}, {"11","NOV"}, {"12","DEC"}
                };
                
                String selectedMonth = request.getParameter("month"); // e.g. "03"
                
                for(String[] m : months){
                    String value = m[0];
                    String label = m[1];
                    String selectedmon = (value.equals(selectedMonth)) ? "selected" : "";
            %>
                <option value="<%=value%>" <%=selectedmon%>><%=label%></option>
            <%
                }
            %>
</select>          
 <script>
                            const mySel = document.getElementById("month");

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
                            const mySel = document.getElementById("year");

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
<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1">
			</div>			
		</div>
</form> 




<%

String year=request.getParameter("year");
String month1=request.getParameter("month");
System.out.println("----------->"+month1);
System.out.println("------------>"+year);
String mname="",yname="";
String query123="SELECT (MONTH(NOW()) - 1) as MonthName,YEAR(now()) as Year";
ResultSet rs123=st11.executeQuery(query123);
if(rs123.next())
{
	mname=rs123.getString("MonthName");
	yname=rs123.getString("Year");
}

System.out.println("Yname:-------------------->"+yname);
System.out.println("Mname--------------------->:"+mname);
//Add leading zero if needed
if (mname != null && mname.length() == 1) {
 mname = "0" + mname;
}

System.out.println("Month1:===> " + mname);

//Set year and month1 if null
if (year == null) {
 year = yname;
}
if (month1 == null) {
 month1 = mname;
}

%>
<script>
document.getElementById("month").value = '<% out.print(month1); %>';
document.getElementById("year").value = '<% out.print(year); %>';
</script>

<% 
String fromDate = year+"-"+mname+"-"+"01";
System.out.println("fromDate fromDate"+fromDate);
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
String dt1 = new SimpleDateFormat("MMM").format(new SimpleDateFormat("MM").parse(month1));


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

<form method="post" action="PayRollRecalculation.jsp" >

		<div>		
		   <a href="PayGeneration.jsp" style="color:green; text-decoration: none;">Generate Payroll</a>
		   </div>
  
<br>
<table id="example"  class="display"   style="width:100%"> 
<thead>
<tr>
<th><input type="checkbox" id="checkAll"></th>
<th class="col-width-4">SrNo.</th>
<th>ID</th>
<th>Name</th>
<th>Dept</th>
<th>Monthly Pay</th>
<th>PI<br>Fee</th>
<th>KRA Fee</th>
<th>PI<br>Index%</th>
<th>KRA<br>Index%</th>
<th>Paid<br>Days</th>
<th>Net<br>PI</th>
<th>Net<br>KRA</th>
<th>Other<br>Allowances</th>
<th>Gross Pay</th>
<th>TDS</th>
<th>Total<br>Recoveries</th>
<th>Net Pay</th>
<th>Incentive<br>+</th>
<th>Previous Pay<br>+</th>
<th>Other Pay<br>+</th>
<th>Vehicle<br>+</th>
<th>Mobile<br>+</th>
<th>Rent<br>+</th>
<th>Laptop<br>+</th>
<th>Recovery - </th>
<th>SD -</th>
<th>PreviousPay - </th>
<th>Mobile -</th>
<th>Other -</th>
<th>Reason</th>
</tr>
</thead>
<tbody>

<%
DecimalFormat df = new DecimalFormat("0.00");
String emp_id="",EmpName="",Basic_Salary="",MediclaimEndDate="";
String present="",Approvedleav="",paiddays="";
double Allowances=0.00;
double Deduction=0.00;
String pay_details="";
String ViewLink="";
String empdetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active'";

ResultSet rs1=st1.executeQuery(empdetails);
System.out.println("Query is:"+empdetails);
int i=1;

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
	double GrossPay=0.00;

	ResultSet rs9=st9.executeQuery(cmaster);
	
	if(rs9.next())
	{
		krasalary=rs9.getDouble("KRAFee");
		basisSalary=rs9.getDouble("PIFee");
		FixedSalary=rs9.getDouble("FixedFee");
		vehilcelAllw=rs9.getDouble("VehicleAllowance");
		Mobile=rs9.getDouble("MobileAllowance");
		Laptop=rs9.getDouble("LaptopAllowance");
		Rent=rs9.getDouble("ProximityAllowance");
		other=rs9.getDouble("OtherAllowance");
		tds=rs9.getDouble("TDSPercent");
		GrossPay=rs9.getDouble("ContractFeePerMonth");

	}	
	
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
	 double mobileded=rsd.getDouble("MobileAllowancesdeduction");
	 double other1=rsd.getDouble("other");
	 String  paidays2=rsd.getString("Paiddays");
	 if(paidays2.equalsIgnoreCase("-"))
	 {
		 paidays2="0";
	 }
	 
	 double paidays1=Double.parseDouble(paidays2);
	 double piindex1=rsd.getDouble("PiIndex");
	 double PreviousPayPlus=rsd.getDouble("PreviousPayPlus");
	 double Incentive=rsd.getDouble("Incentive");
	 double kraIndex=rsd.getDouble("KraIndex");
	 double PiIndex=rsd.getDouble("PiIndex");
	 int revision=rsd.getInt("ReviseNo");
	 double OtherPlus=rsd.getDouble("OtherPlus");
	 double Incentive1=rsd.getDouble("Incentive");
	 double PreviousPayPlus1=rsd.getDouble("PreviousPayPlus");
	 
		 String reviseddata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"RevisionMasterNew where Month='"+dt1+"' and Year='"+year+"' and ContractorId='"+emp_id+"' and Revision =0 order by Revision desc limit 1";
		 ResultSet rsreviseddata=st13.executeQuery(reviseddata);
		 System.out.println("reviseddata  is "+reviseddata);
		 if(rsreviseddata.next())
		 {
			 ViewLink="Yes";
			  paidays1=rsreviseddata.getDouble("oldPaiddays");
			  kraIndex=rsreviseddata.getDouble("oldPiindex");
			  PiIndex=rsreviseddata.getDouble("oldKraindex");
			 
			  String otherStr = rsreviseddata.getString("OtherOld");
			  if (otherStr == null || otherStr.trim().equals("-") || otherStr.trim().isEmpty()) {
			      OtherPlus = 0.0;
			  } else {
			      OtherPlus = Double.parseDouble(otherStr);
			  }

			  
			 // Incentive1=rsreviseddata.getDouble("IncentiveOld");
			  
			  String otherStr1 = rsreviseddata.getString("IncentiveOld");
			  if (otherStr1 == null || otherStr1.trim().equals("-") || otherStr1.trim().isEmpty()) {
				  Incentive1 = 0.0;
			  } else {
				  Incentive1 = Double.parseDouble(otherStr1);
			  }
			  
			//  PreviousPayPlus1=rsreviseddata.getDouble("PreviousOld");
			 
			  String otherStr2 = rsreviseddata.getString("PreviousOld");
			  
			  if (otherStr2 == null || otherStr2.trim().equals("-") || otherStr2.trim().isEmpty()) {
				  PreviousPayPlus1 = 0.0;
			  } else {
				  PreviousPayPlus1 = Double.parseDouble(otherStr2);
			  }
			  
		 }
	 String str="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PayRollMasterNew where ID='"+emp_id+"' and Month='"+dt1+"' and Year='"+year+"'";
	 ResultSet rs32=st12.executeQuery(str);
	 int version=0;
	 if(rs32.next())
	 {
		 version=rs32.getInt("PayrollVersion");
	 }
	 System.out.println("PayRoll Version --------->"+version);
	 
	 double payableamt=rsd.getDouble("PiAmount")+KRAAmount+laptop+vehilcelAllw+Mobile+Rent;
	 double arrears=laptop+vehilcelAllw+Mobile+Rent;
	 	
	%>
	
	
	<tr>
	<td  class="text-center"><input type="checkbox"  name="chkbx"   id="chkbx" value="<%=emp_id%>"/></td>
	<td  class="text-center"><%=i%></td>
	<td  class="text-center"><%=emp_id%></td>
	
	<%
	
	/* if(revision!=0 ) */
	
	//Check Whether version generated in payrollmaster if generated then Revison with six field are allowed
	
	
	
	%>
	
	
		
		<%if(ViewLink.equals("Yes"))
		{%>
	<td  class="text-left"><a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#myModal1" onclick="return srk1('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=rsd.getString("Paiddays")%>','<%=year%>','<%=dt1 %>','<%=Depart%>','<%=kraIndex%>','<%=PiIndex%>','<%=Incentive%>','<%=PreviousPayPlus%>','<%=OtherPlus%>')"><%=rsd.getString("Name")%></a></td>
	
	<%}
	else{
	%>
	<td  class="text-left"><a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#myModal1" onclick="return srk1('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=rsd.getString("Paiddays")%>','<%=year%>','<%=dt1 %>','<%=Depart%>','<%=kraIndex%>','<%=PiIndex%>','<%=Incentive%>','<%=PreviousPayPlus%>','<%=OtherPlus%>')"><%=rsd.getString("Name")%></a></td>
	
	<%} %>
		
	<td  class="text-left"><%=Depart%></td>
	<td  class="text-center"><%=df.format(GrossPay)%></td>
	<td  class="text-center"><%=df.format(basicfee)%></td>
	<td  class="text-center"><%=df.format(krafee) %></td>
	<td  class="text-center"><%=df.format(piindex1) %></td>
	<td  class="text-center"><%=df.format(rsd.getDouble("KraIndex"))%></td>	<!--KRA Index  -->
	<td  class="text-center"><a href="#" onclick="return srk2('<%=emp_id%>','<%=year%>','<%=dt1%>')"><%=df.format(paidays1) %></a></td>   	<!--Paid Days  -->
	<td  class="text-center"><%=df.format(rsd.getDouble("PiAmount")) %></td>
	<td  class="text-center"><%=df.format(KRAAmount)%></td>
	<td  class="text-center"><%=df.format(arrears)%></td>	<!--TDS  -->
	<td  class="text-center"><%=df.format(payableamt)%></td>
	<td  class="text-center"><%=df.format(TDSAmt)%></td>	<!--TDS  -->
	<%if(ViewLink.equals("Yes"))
		{%>
	<td  class="text-center"><a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#myModal" onclick="return srk('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=dt1%>','<%=year%>','<%=Depart%>')"><%=df.format(rsd.getDouble("TotalDeduction"))%> </a></td>  <!-- Total Deduction -->
	<%}
	else{
	%>
	<td  class="text-center"><a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#myModal" onclick="return srk('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=dt1%>','<%=year%>','<%=Depart%>')"><%=df.format(rsd.getDouble("TotalDeduction"))%> </a></td>  <!-- Total Deduction -->
	<%} %>
		
	<td  class="text-center"><%=df.format(netPay)%></td>
	<td  class="text-center"><%=df.format(Incentive1)%></td>
	<td  class="text-center"><%=df.format(PreviousPayPlus1)%></td>
	<td  class="text-center"><%=df.format(OtherPlus)%></td>
	
	<td  class="text-center"><%=df.format(vehilcelAllw)%></td>	<!--Allowances vehicle  -->
	<td  class="text-center"><%=df.format(Mobile)%></td> <!--Mobile  -->
	<td  class="text-center"><%=df.format(Rent)%></td> <!--Rent  -->
	<td  class="text-center"><%=df.format(laptop)%></td>	
	
	<!--Laptop  -->
	<td  class="text-center"><%=df.format(Advance)%></td>
	<td  class="text-center"><%=df.format(sd)%></td>
	<td  class="text-center"><%=df.format(previouspay)%></td>
	<td  class="text-center"><%=df.format(mobileded)%></td>
	<td  class="text-center"><%=df.format(other1)%></td>
	<td  class="text-center"><%=rsd.getString("otherReason")%></td>
		</tr>
	<% 
	i++;
	}
	
}
%>
</tbody>
</table>
</form>
</div>
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
      <div class="modal-body">
        <h4 class="text-center" style="background-color: #1582AB; color: white; font-size: 16px; font-family: sans-serif;">
          <b>Add Recoveries</b>
        </h4>

        <!-- Contractor Info -->
        <div class="row">
          <!-- Contractor ID -->
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-6">
                <label for="emp_id" class="control-label"><b>Contractor ID : </b></label>
              </div>
              <div class="col-md-6">
                <input type="text" id="emp_id" name="emp_id" readonly class="form-control">
              </div>
            </div>
          </div>

          <!-- Name -->
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-4">
                <label for="EmpName" class="control-label"><b>Name : </b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="EmpName" name="EmpName" readonly class="form-control">
              </div>
            </div>
          </div>

          
        </div>

        <!-- Month / Year -->
        <div class="row mt-2">
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-6">
                <label for="abc" class="control-label"><b>Month:</b></label>
              </div>
              <div class="col-md-6">
                <input type="text" id="abc" name="abc" readonly class="form-control">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-4">
                <label for="yr" class="control-label"><b>Year :</b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="yr" name="yr" readonly class="form-control">
              </div>
            </div>
          </div>
        </div>
 <div class="row mt-2">
          <div class="col-md-6">
          
            <div class="row">
              <div class="col-md-6">
                <label for="depart" class="control-label"><b>Department : </b></label>
              </div>
              <div class="col-md-6">
                <input type="text" id="depart" name="depart" readonly class="form-control">
              </div>
            </div>
          </div>
            </div>
         
        <hr>
<div class="container" style="margin-left: 50px;">
        <!-- Recovery Inputs -->
        <div class="row">
          <div class="col-md-3">
            <label><b>Advance: </b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="advancemoney" name="advancemoney" onblur="valid();" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-3"></div>
        </div>

        <div class="row mt-3">
          <div class="col-md-3">
            <label><b>Security Deposit: </b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="securityamount" name="securityamount" onblur="valid();" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-3"></div>
        </div>

        <div class="row mt-3">
          <div class="col-md-3">
            <label><b>Mobile Allowances: </b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="mobileamount" name="mobileamount" onblur="valid();" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-3"></div>
        </div>

        <div class="row mt-3">
          <div class="col-md-3">
            <label><b>Previous Pay:</b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="peramount" name="peramount" onblur="valid();" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-3"></div>
        </div>

        <div class="row mt-3">
          <div class="col-md-3">
            <label><b>Other:</b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="otheramount" name="otheramount" onblur="check();" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          
          
        </div>
        <div class="row mt-3">
         <div class="col-md-3"></div>
        <div class="col-md-3">
      			<textarea id="mycomments"  name="mycomments" rows="2" cols="20"  placeholder="Other Reason"  ></textarea><br></br>
     	
    </div>
    </div>
      </div>
</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm" onclick="return approve();">Submit</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="myModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="max-width: 700px;">
    <div class="modal-content" id="content" style="width: 700px;">
      <div class="modal-body">
        <h4 class="text-center" style="background-color: #1582AB; color: white; font-size: 16px; font-family: sans-serif;">
          <b>PayRoll Revision</b>
        </h4>

        <!-- Contractor Info -->
        <div class="row">
          <!-- Contractor ID -->
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-4">
                <label for="emp_id" class="control-label"><b>Contractor ID : </b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="emp_id1" name="emp_id" readonly class="form-control">
              </div>
            </div>
          </div>

          <!-- Name -->
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-4">
                <label for="EmpName" class="control-label"><b>Name : </b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="EmpName1" name="EmpName" readonly class="form-control">
              </div>
            </div>
          </div>

          
        </div>

        <!-- Month / Year -->
        <div class="row mt-2">
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-4">
                <label for="abc" class="control-label"><b>Month:</b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="abc1" name="abc" readonly class="form-control">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-4">
                <label for="yr" class="control-label"><b>Year :</b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="yr1" name="yr" readonly class="form-control">
              </div>
            </div>
          </div>
        </div>
 <div class="row mt-2">
          <div class="col-md-6">
          
            <div class="row">
              <div class="col-md-4">
                <label for="depart" class="control-label"><b>Department : </b></label>
              </div>
              <div class="col-md-8">
                <input type="text" id="depart1" name="depart" readonly class="form-control">
              </div>
            </div>
          </div>
            </div>
<hr>
<div class="row mb-2">
  <div class="col-sm-2"></div>
  <div class="col-sm-3"><b>Current</b></div>
  <div class="col-sm-3"><b>New</b></div>
  <div class="col-sm-3"><b>Comments</b></div>
</div>

<!-- Availability -->
<div class="row mb-2">
  <div class="col-sm-2">
  <label for="depart" class="control-label"><b>Availability</b></label>
  </div>
  <div class="col-sm-3">
  
    <input type="text" id="paiddays" name="paidays" class="form-control-plaintext" style="border: 1px solid #ced4da;" readonly>
  </div>
  <div class="col-sm-3">
    <input type="text" id="paiddaysnew" name="paiddaysnew" class="form-control" onblur="chek1();" style="border: 1px solid #ced4da;" required>
  </div>
  <div class="col-sm-3">
    <textarea id="comments" name="comments" rows="1" class="form-control" onblur="validate();" placeholder="Comments" style="border: 1px solid #ced4da;font-size: 13px;"></textarea>
  </div>
</div>

<!-- Pi Index -->
<div class="row mb-2">

  <div class="col-sm-2"><label for="piindex" class="control-label"><b>Pi Index</b></label></div>
  <div class="col-sm-3">
    <input type="text" id="piindex" name="piindex" class="form-control" readonly style="border: 1px solid #ced4da;">
  </div>
  <div class="col-sm-3">
    <input type="text" id="piindexnew" name="piindexnew" class="form-control" onblur="chek1();" required style="border: 1px solid #ced4da;">
  </div>
  <div class="col-sm-3">
    <textarea id="comments1" name="comments1" rows="1" class="form-control" onblur="validate();" placeholder="Comments" style="border: 1px solid #ced4da;font-size: 13px;"></textarea>
  </div>
</div>

<!-- Kra Index -->
<div class="row mb-2">
  <div class="col-sm-2"><label for="depart" class="control-label"><b>Kra Index</b></label></div>
  <div class="col-sm-3">
    <input type="text" id="kraindex" name="kraindex" class="form-control" style="border: 1px solid #ced4da;" readonly>
  </div>
  <div class="col-sm-3">
    <input type="text" id="kraindexnew" name="kraindexnew" class="form-control" style="border: 1px solid #ced4da;" onblur="chek1();">
  </div>
  <div class="col-sm-3">
    <textarea id="comments2" name="comments2" rows="1" class="form-control" onblur="validate();" style="border: 1px solid #ced4da;font-size: 13px;" placeholder="Comments"></textarea>
  </div>
</div>

<!-- Incentive -->
<div class="row mb-2">
  <div class="col-sm-2"><label for="depart" class="control-label"><b>Incentive</b></label></div>
  <div class="col-sm-3">
    <input type="text" id="special" name="special" class="form-control" style="border: 1px solid #ced4da;" readonly>
  </div>
  <div class="col-sm-3">
    <input type="text" id="specialnew" name="specialnew" class="form-control" style="border: 1px solid #ced4da;" onblur="chek1();" required>
  </div>
  <div class="col-sm-3">
    <textarea id="comments3" name="comments3" rows="1" class="form-control" style="border: 1px solid #ced4da;font-size: 13px;" onblur="validate();" placeholder="Comments"></textarea>
  </div>
</div>

<!-- Previous Pay -->
<div class="row mb-2">
  <div class="col-sm-2"><label for="depart" class="control-label"><b>Previous Pay</b></label></div>
  <div class="col-sm-3">
    <input type="text" id="Previous" name="Previous" class="form-control" style="border: 1px solid #ced4da;" readonly>
  </div>
  <div class="col-sm-3">
    <input type="text" id="Previousnew" name="Previousnew" class="form-control" onblur="chek1();"  style="border: 1px solid #ced4da;" required>
  </div>
  <div class="col-sm-3">
    <textarea id="comments4" name="comments4" rows="1" class="form-control" onblur="validate();" style="border: 1px solid #ced4da;font-size: 13px;" placeholder="Comments"></textarea>
  </div>
</div>

<!-- Other -->
<div class="row mb-2">
  <div class="col-sm-2"><label for="depart" class="control-label"><b>Other</b></label></div>
  <div class="col-sm-3">
    <input type="text" id="other12" name="other12" class="form-control" style="border: 1px solid #ced4da;" readonly>
  </div>
  <div class="col-sm-3">
    <input type="text" id="othernew12" name="othernew12" class="form-control" onblur="chek1();" style="border: 1px solid #ced4da;" required>
  </div>
  <div class="col-sm-3">
    <textarea id="comments5" name="comments5" rows="1" class="form-control" onblur="validate();" style="border: 1px solid #ced4da;font-size: 13px;" placeholder="Comments"></textarea>
  </div>
</div>

       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm" onclick="return approve1();">Submit</button>
      </div>
    </div>
  </div>
</div>

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
	    //    keys: true,  //Keytable
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
	                         title: 'PayRoll Report '+$("#month").val()+' to '+$("#year").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'PayRoll Report '+$("#month").val()+' to '+$("#year").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A0',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'PayRoll Report '+$("#month").val()+' to '+$("#year").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'PayRoll Report '+$("#month").val()+' to '+$("#year").val(), 
	  	                      orientation: 'landscape',
	                            pageSize: 'A0'
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	  	                        title: 'PayRoll Report '+$("#month").val()+' to '+$("#year").val(), 
	  	                        
							},
 
					],
				},
				
           ], 
       
       });

   });
   
</script>  
<script>
function srk2(emp_id,year,month)
{	
	var payroll="payroll";
	location.assign("PaidaysReport.jsp?empId="+emp_id+"&month12="+month+"&year12="+year+"&action="+payroll+"");
}

function approve1()
{

 	var emp_id=document.getElementById("emp_id1").value;
	var mon12=document.getElementById("abc1").value;
	var year12=document.getElementById("yr1").value;
	var empname=document.getElementById("EmpName1").value;
	var depart=document.getElementById("depart1").value;
		
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
		
	var comment=document.getElementById('comments').value;
	var comment1=document.getElementById('comments1').value;
	var comment2=document.getElementById('comments2').value;
	var comment3=document.getElementById('comments3').value;
	var comment4=document.getElementById('comments4').value;
	var comment5=document.getElementById('comments5').value;	
	
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

var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
if(!invalid.test(specialnew))
	{
	alert("Please Make Valid Entry for Incentive");
	return false;
	}

var Previousnew=document.getElementById("Previousnew").value;

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
}

function approve2()
{

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
		
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		if(!invalid.test(specialnew))
			{
			alert("Please Make Valid Entry for Incentive");
			return false;
			}
		
		var Previousnew=document.getElementById("Previousnew1").value;
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

function srk1(emp_id,name,paiddays,year,month,dept,kra,pi,Incentive,previoudpayplus,OtherPlus)
{
	document.getElementById('emp_id1').value = emp_id;
    document.getElementById('EmpName1').value =name;
    document.getElementById('abc1').value =month;
    document.getElementById('yr1').value= year;
    document.getElementById('depart1').value= dept;
    document.getElementById('piindex').value= pi;
    document.getElementById('kraindex').value= kra;
    document.getElementById('paiddays').value= paiddays;
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
	document.getElementById('emp_id').value = Empid;
    document.getElementById('EmpName').value =ak;
    document.getElementById('abc').value= month;
    document.getElementById('yr').value= yr;
    document.getElementById('depart').value= Deprt;
	return true;
}

</script>

<script type="text/javascript">
function approve()
{
  //  alert("Submit clicked");

    var advanceamt = document.getElementById("advancemoney").value;
    var sd = document.getElementById("securityamount").value; // FIXED
    var mobile = document.getElementById("mobileamount").value;
    var perviouspay = document.getElementById("peramount").value;
    var otheramt = document.getElementById("otheramount").value;

    var emp_id = document.getElementById("emp_id").value;
    var mon12 = document.getElementById("abc").value;
    var year12 = document.getElementById("yr").value;
    var empname = document.getElementById("EmpName").value;
    var depart = document.getElementById("depart").value;

    var commentsEl = document.getElementById("mycomments");
    var comments = commentsEl ? commentsEl.value : "";

    // Validation
    if(otheramt > 0 && comments == "")
    {
        alert("Comments are mandatory when OtherAmount is greater than Zero");
        return false;
    }

    var invalid = /^\d+(\.\d+)?$/;

    if(!invalid.test(advanceamt) || !invalid.test(sd) || !invalid.test(mobile))
    {
        alert("Please enter valid amount");
        return false;
    }

    location.assign(
        "insertRecoveries.jsp?Empid="+emp_id+
        "&Name="+empname+
        "&depart="+depart+
        "&month="+mon12+
        "&year="+year12+
        "&advance="+advanceamt+
        "&securitydeposite="+sd+
        "&mobile="+mobile+
        "&prepay="+perviouspay+
        "&otheramount="+otheramt+
        "&comments="+comments
    );
}
</script>
<script>

function validate1()
{
	var special1=document.getElementById("special1").value;
	var specialnew1=document.getElementById("specialnew1").value;
	var Previous1=document.getElementById("Previous1").value;
	var Previousnew1=document.getElementById("Previousnew1").value;
	var other=document.getElementById("other1").value;
	var othernew=document.getElementById("othernew").value;
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
	var comment=document.getElementById('comments').value;
	var comment1=document.getElementById('comments1').value;
	var comment2=document.getElementById('comments2').value;
	var comment3=document.getElementById('comments3').value;
	var comment4=document.getElementById('comments4').value;
	var comment5=document.getElementById('comments5').value;

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
		var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
		if(!invalid.test(specialnew))
			{
			alert("Please Make Valid Entry for Incentive");
			}
		
		var Previousnew=document.getElementById("Previousnew1").value;		
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
	
	var invalid=/^[0-9]+[.]{0,1}[0-9]+$/;
	if(!invalid.test(specialnew))
		{
		alert("Please Make Valid Entry for Incentive");
		}
	
	var Previousnew=document.getElementById("Previousnew").value;
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
<script type="text/javascript">
$(document).ready(function() {
     $("#checkAll").click(function () {
    	 
    	 
    	 
         $('input:checkbox').not(this).prop('checked', this.checked);
     });
});
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
 <%@ include file="footer.jsp" %>
</body>
</html>  