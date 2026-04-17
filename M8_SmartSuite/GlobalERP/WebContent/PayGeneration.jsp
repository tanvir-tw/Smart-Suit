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
<form name="formreport" id="formreport" method="get">
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
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit"  onclick="return confirmSubmit()">
			</div>
			<div class="col-md-2"></div>
		</div>
</form> 
<%
String year=request.getParameter("year");
String month1=request.getParameter("month");

String mname="",yname="";
String query123="SELECT MONTH(now()) as MonthName,YEAR(now()) as Year";

ResultSet rs123=st11.executeQuery(query123);
if(rs123.next())
{
	mname=rs123.getString("MonthName");
	yname=rs123.getString("Year");
}

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
try{
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

<form method="get" action="PayRollFinal.jsp">
<input type="hidden" name="month" id="month" value=<%=dt1 %>>
<input type="hidden" name="Year" id="Year" value=<%=year %>>
    <button type="submit" class="btn btn-link" style="color:green; text-decoration:none;">
        Generate Payroll
    </button>

<table id="example" class="display" style="width:100%">

<thead>

	<tr>
		<th><input type="checkbox" id="checkAll"></th>
		<th class="col-width-4">SrNo.</th>
		<th>ID</th>
		<th>Name</th>
		<th>Dept</th>
		<th>Paid<br>Days</th>
		<th>Net Pay</th>
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
		<th>Total<br>Recoveries</th>
		<th>TDS</th>

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

String pay_details="";
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
			 
			  paidays1=rsreviseddata.getDouble("oldPaiddays");
			  kraIndex=rsreviseddata.getDouble("oldPiindex");
			  PiIndex=rsreviseddata.getDouble("oldKraindex");
			  /* OtherPlus=rsreviseddata.getDouble("OtherOld");
			  Incentive1=rsreviseddata.getDouble("IncentiveOld");
			  PreviousPayPlus1=rsreviseddata.getDouble("PreviousOld");
			   */
			   
			   String otherStr = rsreviseddata.getString("OtherOld");
				  if (otherStr == null || otherStr.trim().equals("-") || otherStr.trim().isEmpty()) {
				      OtherPlus = 0.0;
				  } else {
				      OtherPlus = Double.parseDouble(otherStr);
				  }

				  				  
				  String otherStr1 = rsreviseddata.getString("IncentiveOld");
				  if (otherStr1 == null || otherStr1.trim().equals("-") || otherStr1.trim().isEmpty()) {
					  Incentive1 = 0.0;
				  } else {
					  Incentive1 = Double.parseDouble(otherStr1);
				  }
				  				 
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
	%>
	
	<tr>
		<td class="text-center"><input type="checkbox"  name="chkbx" id="chkbx" value="<%=emp_id%>"/></td>
		<td class="text-center"><%=i%></td>
		<td class="text-center"><%=emp_id%></td>
		<td class="text-left"><%=rsd.getString("Name")%></td>
		<td class="text-left"><%=Depart%></td>
		<td class=text-center><a href="#" onclick="return srk2('<%=emp_id%>','<%=year%>','<%=dt1%>')"><%=df.format(paidays1) %></a></td>   	<!--Paid Days  -->
		<td class="text-center"><%=df.format(netPay)%></td>
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
		<td class="text-left"><%=rsd.getString("otherReason")%></td>
		<td class="text-center"><%=df.format(rsd.getDouble("TotalDeduction"))%> </td>  <!-- Total Deduction -->
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
<%}catch(Exception e) {
	e.printStackTrace();
}
%>
<script>
function srk2(emp_id,year,month)
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
	var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
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
document.getElementById("month").value = '<% out.print(month1); %>';
document.getElementById("year").value = '<% out.print(year); %>';
</script>
 <%@ include file="footer.jsp" %>
</body>
</html> 