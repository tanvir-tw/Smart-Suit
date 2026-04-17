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
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Final Pay Roll of <%=cname %></h5>
    </div>
</div>
<form name="indexReport" method="get"  onsubmit="return confirmSubmit()" action="">
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
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			<div class="col-md-1">
			</div>			
		</div>
</form> 



<%


String year=request.getParameter("year");
String month1=request.getParameter("month");
String mname="",yname="";
String query123="SELECT (MONTH(NOW()) - 1) as MonthName,YEAR(now()) as Year";

ResultSet rs123=st11.executeQuery(query123);
if(rs123.next())
{
	mname=rs123.getString("MonthName");
	yname=rs123.getString("Year");
}
System.out.println("Month1:===>"+mname);
if (mname != null && mname.length() == 1) {
	 mname = "0" + mname;
	}

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
int dCount=Integer.parseInt(dayCount);

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
<form method="post" action="PayRollRecalculation.jsp" >

<input type="hidden" name="month" id="month" value=<%=dt1 %>>
<input type="hidden" name="Year" id="Year" value=<%=year %>>

<br>
<table id="example"  class="display"   style="width:100%"> 
<thead>        
<tr>
		<th class="col-width-4">SrNo.</th>
		<th>ID</th>
		<th>Name</th>
		<th>Dept</th>
		<th>Paid<br>Days</th>
		<th>Net Pay</th>
		<th>GrossPay</th>
		<th>Total<br>Recoveries</th>
		<th>Basic Fee</th>
		<th>PI<br>Index</th>
		<th>PI<br>Fee</th>
		<th>KRA Fee</th>
		<th>KRA<br>Index</th>
		<th>KRA<br>Fee</th>
		<th>Incentive<br>+</th>
		<th>Previous Pay<br>+</th>
		<th>Other Pay<br>+</th>
		<th> Vehicle<br>+</th>
		<th>Mobile<br>+</th>
		<th>Rent<br>+</th>
		<th>Laptop<br>+</th>
		<th>Recovery - </th>
		<th>SD -</th>
		<th>PreviousPay - </th>
		<th>Mobile -</th>
		<th>Other -</th>
		<th>Reason</th>
		<th>TDS</th>

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
	 double paidays1=rsd.getDouble("Paiddays");
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
			  OtherPlus=rsreviseddata.getDouble("OtherOld");
			  Incentive1=rsreviseddata.getDouble("IncentiveOld");
			  PreviousPayPlus1=rsreviseddata.getDouble("PreviousOld");
		 }
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
			<td class="text-center"><%=i%></td>
			<td class="text-center"><%=emp_id%></td>
			
				<%if(ViewLink.equals("Yes"))
				{%>
			<td class="text-left"><a style="color: #0d6efd;" data-bs-toggle="modal" data-bs-target="#myModal" onclick="return srk1('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=rsd.getString("Paiddays")%>','<%=year%>','<%=dt1 %>','<%=Depart%>','<%=kraIndex%>','<%=PiIndex%>','<%=Incentive%>','<%=PreviousPayPlus%>','<%=OtherPlus%>')"><%=rsd.getString("Name")%></a></td>
			
			<%}
			else{
			%>
			<td class="text-left"><%=rsd.getString("Name")%></td>
			<%} %>
				
				
			<td class="text-left"><%=Depart%></td>
			<td class="text-center"><a href="#" onclick="return srk2('<%=emp_id%>','<%=year%>','<%=dt1%>')"><%=df.format(paidays1) %></a></td>   	<!--Paid Days  -->
			
			<td class="text-center"><%=df.format(netPay)%></td>
			<td class="text-center"><%=df.format(GrossPay)%></td>
			<%if(ViewLink.equals("Yes"))
				{%>
			<td class="text-center"><a style="color: #0d6efd;" data-bs-toggle="modal" data-bs-target="#myModal" onclick="return srk('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=dt1%>','<%=year%>','<%=Depart%>')"><%=df.format(rsd.getDouble("TotalDeduction"))%> </a></td>  <!-- Total Deduction -->
			<%}
			else{
			%>
			<td class="text-center"><a style="color: #0d6efd;" data-bs-toggle="modal" data-bs-target="#myModal" onclick="return srk('<%=emp_id%>','<%=rsd.getString("Name")%>','<%=dt1%>','<%=year%>','<%=Depart%>')"><%=df.format(rsd.getDouble("TotalDeduction"))%> </a></td>  <!-- Total Deduction -->
			<%} %>
			<td class="text-center"><%=df.format(basicfee)%></td>
			<td class="text-center"><%=df.format(piindex1) %></td>	
			<td class="text-center"><%=df.format(rsd.getDouble("PiAmount")) %></td>	
			
			<td class="text-center"><%=df.format(krafee) %></td>	
			<td class="text-center"><%=df.format(rsd.getDouble("KraIndex"))%></td>	<!--KRA Index  -->
			<td class="text-center"><%=df.format(KRAAmount)%></td>		
			<td class="text-center"><%=df.format(Incentive1)%></td>
			<td class="text-center"><%=df.format(PreviousPayPlus1)%></td>
			<td class="text-center"><%=df.format(OtherPlus)%></td>
				
			<td class="text-center"><%=df.format(vehilcelAllw)%></td>	<!--Allowances vehicle  -->
			<td class="text-center"><%=df.format(Mobile)%></td> <!--Mobile  -->
			<td class="text-center"><%=df.format(Rent)%></td> <!--Rent  -->
			<td class="text-center"><%=df.format(laptop)%></td>		
			<td class="text-center"><%=df.format(Advance)%></td>
			<td class="text-center"><%=df.format(sd)%></td>
			<td class="text-center"><%=df.format(previouspay)%></td>
			<td class="text-center"><%=df.format(mobileded)%></td>
			<td class="text-center"><%=df.format(other1)%></td>
			<td class="text-center"><%=rsd.getString("otherReason")%></td>
			<td class="text-center"><%=df.format(TDSAmt)%></td>	<!--TDS  -->
	
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
<!-- Modal Popup -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
      <div class="modal-body">
        <h4 class="text-center" style="background-color: #1582AB; color: white; font-size: 16px; font-family: sans-serif;"> <b>Add Recoveries</b> </h4>

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
	<div class="container" style="margin-left: 30px;">
        <!-- Recovery Inputs -->
        <div class="row">
          <div class="col-md-4">
            <label><b>Advance: </b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="advancemoney" name="advancemoney" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-2"></div>
        </div>

        <div class="row mt-2">
          <div class="col-md-4">
            <label><b>Security Deposit: </b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="safetyamount" name="safetyamount" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-2"></div>
        </div>     
     
     	<div class="row mt-2">
          <div class="col-md-4">
            <label><b>Mobile Allowances: </b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="mobileamount" name="mobileamount" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-2"></div>
        </div>

        <div class="row mt-2">
          <div class="col-md-4">
            <label><b>Previous Pay:</b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="peramount" name="peramount" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          </div>
          <div class="col-md-2"></div>
        </div>
        
     	<div class="row mt-2">
          <div class="col-md-4">
            <label><b>Other:</b></label>
          </div>
          <div class="col-md-6">
            <input type="text" id="otheramount" name="otheramount" value="0.00" class="form-control" style="border: 1px solid #ced4da;">
          	<textarea id="mycomments"  name="mycomments" rows="2" cols="30"  placeholder=" Other Reason"  style="border: 1px solid #ced4da;font-size: 13px;"></textarea>
          </div>
          <div class="col-md-2"></div>
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

<script>

function srk2(emp_id,year,month)
{
	var payroll="payroll";
	location.assign("PaidaysReport.jsp?empId="+emp_id+"&month12="+month+"&year12="+year+"&action="+payroll+"");
	
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

 <%@ include file="footer.jsp" %>
</body>
</html>  