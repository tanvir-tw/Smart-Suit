 <%@page import="java.util.Date"%>
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
Statement st1 = null, st2 = null, st3 = null, st4 = null,st5=null,st6=null,st7=null,st8=null;
String selectedName,fpreviousmonth="", FollowUpType = "",Group="", strcustomer = "", strgroupname = "";

try {
	conn = connection.getConnect("db_GlobalERP");    
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();
		st5 = conn.createStatement();
	 	st6 = conn.createStatement();
		st7 = conn.createStatement();
		st8 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>
<%
DecimalFormat twoDForm = new DecimalFormat("#.##");
 	String fromDateCal = "", toDateCal = "", sql1 = "",sql2="",sql3="";
 	String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	int ck=0;
	int vehid=0;
	int k=2000;
 	Date tdy = new Date();
 	Date tomorrow = new Date();
 	Calendar cal = Calendar.getInstance();
 	Calendar now = Calendar.getInstance();
 	cal.setTime(tdy);
 	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd").format(tdy);
 	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(tdy);
 	cal.add(Calendar.DAY_OF_MONTH, -1);
 	Date YesterdaysDateAsDate = cal.getTime();
 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);

 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
 	
 	String billstatus = request.getParameter("billstatus");
 	String BillStatus = "";
%>
<%
String month="",month1="",year1="";

if(null==request.getQueryString())
{
String MonthYear="select MONTHNAME(LAST_DAY(NOW() - INTERVAL 1 Month)) as MonthName,Year(LAST_DAY(NOW() - INTERVAL 1 Month)) as Year,MONTH(LAST_DAY(NOW() - INTERVAL 1 Month)) as Month";
ResultSet rsyear=st1.executeQuery(MonthYear);
if(rsyear.next())
{
	 month1=rsyear.getString("MonthName");
	 month=rsyear.getString("Month");
	 if(Integer.parseInt(month) <10)
	 {
		 month="0"+month;
	 }
	 else
	 {
		 month=""+month;
	 }
	 year1=rsyear.getString("Year");
}

}
else{
	year1=request.getParameter("year");
	 month=request.getParameter("month");
	 if(month.equals("01"))
	 {
		 month1="JAN";
	 }else if(month.equals("02"))
	 {
		 month1="FEB";
	 }else if(month.equals("03"))
	 {
		 month1="MAR";
		 
	 }else if(month.equals("04"))
	 {
		 month1="APR";
	 }else if(month.equals("05"))
	 {
		 month1="MAY";
	 }else if(month.equals("06"))
	 {
		 month1="JUN";
	 }else if(month.equals("07"))
	 {
		 month1="JUL";
	 }else if(month.equals("08"))
	 {
		 month1="AUG";
	 }else if(month.equals("09"))
	 {
		 month1="SEP";
	 }else if(month.equals("10"))
	 {
		 month1="OCT";
	 }else if(month.equals("11"))
	 {
		 month1="NOV";
	 }else if(month.equals("12"))
	 {
		 month1="DEC";
	 }
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637">Vehicle Bill Summary</h5>
    </div>
</div>
<form name="data1" id="data1" method="get" onsubmit="return validate();">
<div class="row col-12">
		    <div class="col-md-2"></div>
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
                        <% String selectedYear = request.getParameter("year"); %>
                          <option value="Select" <%= (selectedYear == null || selectedYear.isEmpty()) ? "selected" : "" %>>Select</option>
                         	 <%
    int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

        for (int year11 = currentYear; year11 >= 1990 ; year11--) {
            boolean isSelected = Integer.toString(year11).equals(selectedYear);
    %>
    <option value="<%= year11 %>" <%= isSelected ? "selected" : "" %>><%= year11 %></option>
    <%
        }
    %>
								</select>
                           
                          
		                </div>
			</div>
			<div class="col-md-2">
				  <label for="dropdown"><b>Bill Status</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="billstatus" name="billstatus">
                            <option value="Select">Select</option>
<%
             String sqldd = "select distinct (BillTransporter) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month ;   
                ResultSet rsdd = st.executeQuery(sqldd);
                while(rsdd.next()){
                	String value = rsdd.getString("BillTransporter");
                 
            %>
                <option value="<%=value%>" <%if(value.equalsIgnoreCase(billstatus)){  %> selected <%} %>  ><%=value%></option>
                
            <%
                }
            %>
</select>     
 </div>
			</div>
			
							
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="view" value="View Data"  onclick="return confirmSubmit()">
				</div>
				<div class="col-md-2 mt-4">
				<input type="button" class="btn btn-primary" id="button" name="button" value="Download Invoices" onclick="fun()">
			</div>
			<div class="col-md-2"></div>
		</div>
   <div class="row col-12">
   		<div class="col-md-2 mt-4" style="width: 160px;">
<!-- 			<input type="button" class="btn btn-primary" id="button" name="CreateInvoice" value="Create Invoices" onclick="getcheckedrow()">
 -->	
 <input type="button" class="btn btn-primary" id="CreateInvoice" name="CreateInvoice" value="Create Invoice" style="background-color: #1582AB;" onclick="getcheckedrow()">
 	</div>
   		<div class="col-md-2 mt-4">
<!-- 			<input type="button" class="btn btn-primary" id="button" name="SendMail" value="Send Mail" onclick="getcheckedrow1()">
 -->	
 <input type="button" class="btn btn-primary" id="SendMail" name="button" value="Send Mail" style="background-color: #1582AB;" onclick="getcheckedrow1()">
 
 	</div>
   </div>
</form>
<br>
<%
if(null!=request.getQueryString())
{
	 year1=request.getParameter("year");
	 month=request.getParameter("month");
	
System.out.println(year1+"  "+month);
int monthdays=0;
if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") )
	{monthdays=31;}

if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
{monthdays=30;}

if(month.equals("02"))
{monthdays=28;}

 int smonth = Integer.parseInt(month);
 System.out.println("Selected month in int is "+smonth);
 int syear = Integer.parseInt(year1);
 System.out.println("Selected year in int is "+syear);
 int spreviousyear, spreviousmonth;
 if(smonth==1)
 {
  System.out.println("Selected month is 1"); 	 
  spreviousyear=syear-1;
  spreviousmonth=12;
  System.out.println("Selected previous year "+spreviousyear+"Selected previous month"+spreviousmonth);
 }
 else 
 {
	 spreviousyear=syear;
     System.out.println("selected month  is "+smonth);
     spreviousmonth = smonth-1;
     System.out.println("Selected previous year is "+spreviousyear+"selected previous month is "+spreviousmonth);
 }
int currentmonthcount=0,currentyearcount=0;
int previousmonth=0, ppreviousmonth=0;
int previousyear=0, ppreviousyear=0;
String finalmonth="";
String currentyear="", fppreviousmonth = "";

String currentmonth="select MONTH('"+todaysDate1+"')";
System.out.println(currentmonth);
ResultSet rsMonth=st2.executeQuery(currentmonth);
rsMonth.next();
currentmonthcount=rsMonth.getInt(1);
System.out.println("current month "+currentmonthcount);

if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
{
finalmonth="0"+currentmonthcount;
}
else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
{
finalmonth=Integer.toString(currentmonthcount);
}		
currentyear="select YEAR('"+todaysDate1+"')";
ResultSet rsYear=st3.executeQuery(currentyear);
rsYear.next();
currentyearcount=rsYear.getInt(1);
if(currentmonthcount==1)
{
previousyear=currentyearcount-1;
previousmonth=12;
}
else 
{
previousyear=currentyearcount;
System.out.println("abcd  "+finalmonth);
previousmonth=Integer.parseInt(finalmonth)-1;
System.out.println("abcd  "+previousmonth);
}
if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
	{
		fpreviousmonth="0"+Integer.toString(previousmonth);
	}
	else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
	{
		fpreviousmonth=Integer.toString(previousmonth);
	}
if(previousmonth==1)
{
	ppreviousyear=previousyear-1;
	ppreviousmonth=12;
}
else 
{
	ppreviousyear=previousyear;
	System.out.println("final previous month is  "+fpreviousmonth);
	ppreviousmonth=Integer.parseInt(fpreviousmonth)-1;
	System.out.println("pprevious month is  "+ppreviousmonth);
}
if(ppreviousmonth==1 || ppreviousmonth==2 || ppreviousmonth==3 || ppreviousmonth==4 || ppreviousmonth==5 || ppreviousmonth==6 || ppreviousmonth==7 || ppreviousmonth==8 || ppreviousmonth==9 )
	//if(previousmonth==1)
	{
		fppreviousmonth="0"+Integer.toString(ppreviousmonth);
	}
	else if(ppreviousmonth==10 || ppreviousmonth==11 || ppreviousmonth==12)
	{
		fppreviousmonth=Integer.toString(ppreviousmonth);
	}




String checktb = "show tables like '"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year1+"_"+month+"'";
System.out.println("Query is"+checktb);
ResultSet rschk=st4.executeQuery(checktb);
System.out.println("After rschk");
if(rschk.next())
{
       String sqldata="Select ERPCustName as Customer,ERPCode as CustomerCode,SLAPer,Rate,Rate/"+monthdays+" as ChargeperDay,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+".BillTransporter,"+
			   "count(distinct("+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year1+"_"+month+".vehID)) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,"+
			   "sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,"+
			   "sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays ,"+
			   "GroupName,BillType,sum(jrm) as jrmvehcount,InvoiceRefNo from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+" ,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year1+"_"+month+" "+
			   "where month1='"+year1+"-"+month+"-01' and  "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+".vehID = "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year1+"_"+month+".VehID  and "+
			   ""+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+".BillTransporter='"+billstatus+"' and ERPCode in (select distinct(ERPCode) from db_gps.t_transporter where OperationalStatus='Active') group by   "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+".ERPCode,GroupName,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+".ERPCustName order by "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year1+"_"+month+".ERPCustName"; 
			   
			     
               System.out.println("sqldata--->"+sqldata);
               ResultSet rsData=st5.executeQuery(sqldata);
%>


           <div align="center" id="result" ></div>
           <div id="purchase">
           
     <table id="example" class="display" style="width:100%;">        
       <thead>
           <tr>
           	<th class="col-width-4">SrNo.</th>
           <th style="width: 125px;">
	<a href="#" onclick="checkAll()"> 
	<input type="hidden" name="check" id="check" value="">
	<font color="white">Check/</font></a> 
	 <a href="#" onclick="unCheckAll()">
	<font color="white">UnCheck </font></a>
	</th>
			
           <th>Customer</th>
           <th>CustomerCode</th>
           <th>InvoiceRefNo</th>
           <th>Bill Status</th>
           <th>SLA</th>
           <th>Rate</th>
           <th>Charges Per Day </th>
           <th>No of Vehicles</th>
           <th>Vehicle Added</th>
           <th>Vehicle Removed</th>
           <th>Captured Days</th>
           <th>Disconnected Days</th>
           <th>NotCaptured</th>
           <th>Total Days</th>
           <th>Total BilledDays</th>
           <th>GroupName</th>
           <th>BillType</th>
           <th>Jrm Veh count</th>
           </tr>
           </thead>
           <tbody>
<%

int srno=1;
int vehadded=0,vehremoved=0;

   while(rsData.next())
   {	
	   
   String addedveh="SELECT count(VehAddedThisMonth) as VehAddedThisMonth FROM db_gps.t_billingdetails WHERE month1 = '"+year1+"-"+month+"-01' AND transporter='"+rsData.getString("Customer")+"' and VehAddedThisMonth!='No'";
   ResultSet rsaddedveh=st6.executeQuery(addedveh);
   if(rsaddedveh.next())
   {
	   vehadded=rsaddedveh.getInt("VehAddedThisMonth");
   }else
   {
	   vehadded=0;
   }
   
String removedveh="SELECT count(vehRemovedThisMonth) as vehRemovedThisMonth FROM db_gps.t_billingdetails WHERE month1 = '"+year1+"-"+month+"-01' AND transporter='"+rsData.getString("Customer")+"' and vehRemovedThisMonth!='No'";
   ResultSet rsremovedveh=st7.executeQuery(removedveh);
   if(rsremovedveh.next())
   {
	   vehremoved=rsremovedveh.getInt("vehRemovedThisMonth");
   }else
   {
	   vehremoved=0;
   }
	   ck++;
	   strcustomer = rsData.getString("Customer");
	   strcustomer = strcustomer.replace("&","^");
	   strgroupname = rsData.getString("GroupName");
	   strgroupname = strgroupname.replace("&","^");
	String InvoiceRefNo="",invoiceno="";
	InvoiceRefNo=rsData.getString("InvoiceRefNo");
	BillStatus = rsData.getString("BillTransporter");
	System.out.println("srno:"+srno);
	System.out.println("ck:"+ck);
%>
<tr>
<td class="text-center"><%=srno%></td>
<%if(InvoiceRefNo.equals("-"))
	{ %>
<td class="text-center" ><input type="checkbox"  name="chkbx"   id="chkbx<%=ck %>"  /></td>

<td class="text-center"><font size="2" color="black"><%=rsData.getString("Customer") %></font></td>

<td class="text-center" id="net_id1<%=ck %>"><%=rsData.getString("CustomerCode") %></td>
<%}else{ 
String invoice="select distinct(invoiceRefNo),invoiceno from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where  invoiceRefNo='"+InvoiceRefNo+"' and TWEmpName='Autogenerated' and InvoiceCancelled='0' limit 1";
ResultSet rsinvoice=st8.executeQuery(invoice);
if(rsinvoice.next())
{
	InvoiceRefNo=""+InvoiceRefNo;
	invoiceno=rsinvoice.getString("invoiceno");
}else
{
	InvoiceRefNo="-";
}

%>
<td class="text-center"><input type="checkbox"  name="chkbx"   id="chkbx<%=ck %>"  /></td>
<td class="text-center"><font size="2" color="black"><%=rsData.getString("Customer") %></font></td>
<td class="text-center" id="net_id1<%=ck %>"><%=rsData.getString("CustomerCode") %></td>
<%} %>
<%if(InvoiceRefNo.equals("-"))
	{%>
<td class="text-center" id="net_id3<%=ck %>"><%=InvoiceRefNo %>
<input type="hidden" name="net_id5<%=ck %>" id="net_id5<%=ck %>" value="<%=InvoiceRefNo %>">
</td>	
	<%} else{ %>
	<td>
	<input type="hidden" name="net_id5<%=ck %>" id="net_id5<%=ck %>" value="<%=InvoiceRefNo %>">
	<div align="left" id="net_id3<%=ck%>"><b></b><a href="detailForProInvoice.jsp?InvoiceRefNo=<%=InvoiceRefNo%>&Invoiceno=<%=invoiceno%>&condition=View"target="_blank"><%=InvoiceRefNo%></b></a></div></td>
	<%} %>


<td class="text-center"><%=BillStatus%></td>
<td class="text-center"><%=rsData.getString("SLAPer") %></td>
<td class="text-center"><%=rsData.getString("Rate") %></td>
<td class="text-center"><%=twoDForm.format(rsData.getDouble("ChargeperDay"))  %></td>
<td class="text-center"><%=rsData.getString("NoofVehicles") %></td>
<td class="text-center"><%=vehadded %></td>
<td class="text-center"><%=vehremoved %></td>
<td class="text-center"><%=rsData.getString("CapturedDays") %></td>
<td class="text-center"><%=rsData.getString("DisconnectedDays") %></td>
<td class="text-center"><%=rsData.getString("NotCaptured") %></td>
<td class="text-center"><%=rsData.getString("TotalDays") %></td>
<td class="text-center"><%=rsData.getString("TotalBilledDays") %></td>
<td class="text-left" id="net_id2<%=ck %>"><%=rsData.getString("GroupName") %></td>
<td class="text-left"><%=rsData.getString("BillType") %></td>
<td class="text-center"><%=rsData.getString("jrmvehcount") %></td>

</tr>
<%
srno++;
    }//while
   }//if
  else
  {
     %>
</tbody>     
     
         <script type="text/javascript">
     		window.location="alertGoTo.jsp?msg=There are no records to display.&goto=autogeneratedbillreport.jsp";
     	</script>
     
     <%}%>
</table>
</div>
<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
<input type="hidden" name="billYear" id="billYear" value="<%=year1%>"/>
<input type="hidden" name="billMonth" id="billMonth" value="<%=month%>"/>

<%
}
%>
<script type="text/javascript">
function validate()
{
var month1=document.getElementById("month").value;
var year=document.getElementById("year").value;
if(month1=="Select")
{
	alert("Please Select Month");
	return false;
}

if(year=="Select")
{
	alert("Please Select Year ");
	return false;
}
}
</script>



<script language="JavaScript1.2">
function checkAll()
{
	var field = document.getElementById("checkedNumber").value;
	var i, chk=1;
	try{
	for (i = 0; i < field; i++)
	{
		 if(document.getElementById("chkbx"+chk).checked == false)
		 {
			 document.getElementById("chkbx"+chk).checked = true;
		 }

		 chk++;
		
	}
}catch(e){alert(e);}
}

function unCheckAll()
{
var field = document.getElementById("checkedNumber").value;
var kj=1,i;
try{
for (i = 0; i < field; i++)
{
	 if(document.getElementById("chkbx"+kj).checked == true )
	 {
		 document.getElementById("chkbx"+kj).checked = false;
	 }
	 kj++;
}
}catch(e){alert(e);}
}
function DeleteRow(id,id1)
{
	var year = document.getElementById("billYear").value;
	var month = document.getElementById("billMonth").value;
	var agree=confirm("Do You Want To Create Invoice ?");
	    if(agree)
	    {
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {	// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{	// Internet Explorer Browsers
				try
				{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{	try
					{
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch (e)
					{	// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function()
			{	//alert("ddddddddddddddddddddddd");
				if(ajaxRequest.readyState == 4 )
				{	var reslt=ajaxRequest.responseText;
				  var data=reslt;
				  data=data.replace(/^\s+|\s+$/g,"");
				  var z=data.split("#");
					if(data=="Yes")
					{					
                        alert("Invoice Created Successfully.");
				    	window.location.reload();
					}
					if(data=="NO")
					{					
                       alert("Error In Creating Invoice .");
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=approve&id="+id+"&id1="+id1+"&year="+year+"&month="+month;
			ajaxRequest.open("GET", "AjaxGeneratePdf.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
 }	
function getcheckedrow()
{
	//alert("in getcheckedrow() fn")
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var id1="";
	var b="";
	var c="";
	var d="";
	var a="";
	var chklength=document.getElementsByName("chkbx");
	//alert("chklength:"+chklength.length);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}
	
	//alert("flag:"+flag);
	
	if(flag == "success")
	{
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		c=document.getElementById("CreateInvoice").value;
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			if(document.getElementById("chkbx"+i).checked)
			{
				a=document.getElementById("net_id5"+i).value;
				//alert("a:"+a+" i:"+i);;
				if(a=="-" || a==" " || a==null || a=="")
				{
					b="-";
				}else{
					b="Invoice"
				}
				//alert("b:"+b+" i:"+i);
				if(b=="Invoice" && c=="Create Invoice")
					{
					alert("Please UnCheck AlReady Created Invoices");
					return false;
					
					}
					
				else{
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
				id1=id1+","+document.getElementById("net_id2"+i).innerHTML;
				}
			}
			i++;
		}
		//alert(id);
		//alert(id1);
		DeleteRow(id,id1);
	}
	else
	{
		alert("Please Select Customer for select generating PDF");
	}	
}

function DeleteRow1(id, id1)
{
    //alert("in DeleteRow1: " + id + " " + id1);

    var year = document.getElementById("billYear").value;
    var month = document.getElementById("billMonth").value;

    var agree = confirm("Do You Want To Send Mail ?");
    if (!agree) return false;

    var ajaxRequest = new XMLHttpRequest();

    ajaxRequest.onreadystatechange = function()
    {
        if (ajaxRequest.readyState == 4 && ajaxRequest.status == 200)
        {
            var data = ajaxRequest.responseText.trim();

            if (data == "Yes")
            {
                alert("Mail Data Inserted Successfully.");
                window.location.reload();
            }
            else if (data == "NO")
            {
                alert("Error In Mail Data Insertion");
                window.location.reload();
            }
            else
            {
                alert("Unexpected response: " + data);
            }
        }
    };

    var queryString = "?action=approve&id=" + id +
                      "&id1=" + id1 +
                      "&year=" + year +
                      "&month=" + month;

    var url = "AutoInvoiceSendMail.jsp" + queryString;

   //alert("URL: " + url);

    ajaxRequest.open("GET", url, true);
    ajaxRequest.send();
}

 
function getcheckedrow1()
{
	//alert("in getcheckedrow1() fn")
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var id1="";
	var chklength=document.getElementsByName("chkbx");
	
	//alert("chklength:"+chklength.length);
	
	for(cnt1=0; cnt1< chklength.length; cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
			break;
		}
		k++;
	}

	//alert("flag:"+flag);
	
	if(flag == "success")
	{
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		id1="";
		var b="";
		var c="";
		var d="";
		var a="";
		c=document.getElementById("SendMail").value;
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			if(document.getElementById("chkbx"+i).checked)
			{
				 a=document.getElementById("net_id5"+i).value;
					if(a=="-")
					{
						b="-";
					}else{
						b="Invoice"
					}
				if(b=="-" && c=="Send Mail")
					{
					alert("Please UnCheck Non-Created Invoices");
					return false;
					}
					
				else{
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
				id1=id1+","+document.getElementById("net_id5"+i).value;
				}
			}
			i++;
		}
		//alert("id:"+id);
		//alert("id1:"+id1);
		DeleteRow1(id,id1);
	}
	else
	{
		alert("Please Select Customer for select generating PDF");
	}
}
</script>

 <script type="text/javascript">
function fun(){
	validate();
	
	document.getElementById("purchase").style.visibility="hidden";
	var year=document.getElementById("year").value;
	var month=document.getElementById("month").value;
	var xmlhttp;    
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    document.getElementById("result").innerHTML=xmlhttp.responseText;
	    }
	  }
	xmlhttp.open("GET","ListOfMonthlyInvoices.jsp?month="+month+"&year="+year,true);
	xmlhttp.send();
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
		                        title: 'Auto Generated Bill Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Auto Generated Bill Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Auto Generated Bill Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Auto Generated Bill Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Auto Generated Bill Report '+$("#data").val()+' to ' +$("#data1").val(),
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