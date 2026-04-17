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
 // Connection Initialization
Connection conn = null;
Statement st1=null,st2=null,st3=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
 	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
}  

 %>
<%
DecimalFormat twoDForm = new DecimalFormat("#.##");
	int i=1,ck=0;
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Physical Damage Bill Summary</h5>
    </div>
</div>
<form name="data1"  method="get" onsubmit="return validate();"> 
 <div class="row col-12">
		    <div class="col-md-3"></div>
				
				<div class="col-md-2">
				  <label for="month"><b>Month</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="month" name="month">
    <%
        String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
        String selectedMonth = request.getParameter("month");

        if (selectedMonth == null || selectedMonth.isEmpty()) {
        }
    %>
    <option value="Select">Select</option>
    <%
        for (String month : months) {
            boolean isSelected = month.equals(selectedMonth);  // Check if the current month is selected
    %>
    <option value="<%= month %>" <%= isSelected ? "selected" : "" %>><%= month %></option>
    <%
        }
    %>
</select>
			
		                  <script>
                            const mySel = document.getElementById("month");

                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localSorage.settItem("selValue", this.value); // 
                              });
                             </script>			
		  		       </div>              
			</div>	
			<div class="col-md-2">
				  <label for="year"><b>Year</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="year" name="year">
    <%
        String selectedYear = request.getParameter("year");
        if (selectedYear == null || selectedYear.isEmpty()) {
    %>
    <option value="Select">Select</option>
    <%
        }
        for (int year = 2018; year <= 2050; year++) {
            boolean isSelected = Integer.toString(year).equals(selectedYear);
    %>
    <option value="<%= year %>" <%= isSelected ? "selected" : "" %>><%= year %></option>
    <%
        }
    %>
</select>
		                  <script>
                            const mySel = document.getElementById("year");

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
						
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="view" value="View Data">
			</div>
			<div class="col-md-2 mt-4">
				<input type="button" class="btn btn-primary" id="button" value="Download Invoices" onclick="fun()">
			</div>
			<div class="col-md-3"></div>
			
		</div>
</form>

	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		
		  <input type="button" name="Create Invoice" class="btn btn-primary" id="button" value="Create Invoice" onclick="getcheckedrow()">
	    </div>
	
		<div class="col-8"></div>
	</div>

<br>
<%
if(null!=request.getQueryString())
{

	String year=request.getParameter("year");
	String month=request.getParameter("month");

String checktb = "show tables like 'PhysicalDamage"+year+"_"+month+"'";
System.out.println("Query is"+checktb);
ResultSet rschk=st1.executeQuery(checktb);
System.out.println("After rschk");
if(rschk.next())
{
       String sqldata="select * from PhysicalDamage"+year+"_"+month+"";
               System.out.println(sqldata);
               ResultSet rsData=st2.executeQuery(sqldata);
%>

 <br> 
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
           <th style="width: 125px;"><a href="#" onclick="checkAll()">
           		<input type="hidden" name="check" id="check" value="">
				<font color="white">Chk All &nbsp;&nbsp;/&nbsp;&nbsp;</font></a><a href="#" onclick="unCheckAll()"> <font color="white">UnChk all</font></a>
			</th>
           <th>Code</th>											
           <th>RefNo</th>
           <th>ERP Code</th>
           <th>ERP Cust Name</th>
           <th>Group Name</th>
           <th>QTDate</th>
           <th>UnitId</th>
           <th>VehRegNo</th>
           <th>Transporter</th>
           <th>PhysicalDamage</th>
           <th>RepUnit</th>
           <th>Invoice Ref No</th>
           <th>Invoice Raised</th>
           </tr>
           </thead>
           <tbody>
		<tr>
<%

int srno=1;
   while(rsData.next())
   {	
	   ck++;
	   
%>

<td class="text-center"><%=srno%></td>
<td class="text-center"><%if(rsData.getString("InvoiceRefNo").equalsIgnoreCase("No") || rsData.getString("InvoiceRefNo").equalsIgnoreCase("No") ){ %><input type="checkbox"  name="chkbx"   id="chkbx<%=ck %>" /><%}else{%><input type="checkbox"  name="chkbx"   id="chkbx<%=ck %>" style="display:none" /><%} %></td>
<td class="text-center">id="net_id1<%=ck %>"><%=rsData.getString("SrNo") %></td>
<td class="text-center"><%=rsData.getString("RefNo") %></td>

<%
String sqldata123="select * from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" where Transporter='"+rsData.getString("Transporter")+"' order by Vehid desc ";

ResultSet rsData123=st3.executeQuery(sqldata123);
if(rsData123.next()){
%>
<td class="text-center"><%=rsData123.getString("ERPCode") %></td>
<td class="text-left"><%=rsData123.getString("ERPCustName") %></td>
<td class="text-left"><%=rsData123.getString("GroupName") %></td>
<%}else{ %>
<td>-</td>
<td>-</td>
<td>-</td>
<%} %>

<td class="text-right"><%=rsData.getString("QTDate") %></td>
<td class="text-right"><%=twoDForm.format(rsData.getDouble("UnitId"))  %></td>
<td class="text-center"><%=rsData.getString("VehRegNo") %></td>
<td class="text-left"><%=rsData.getString("Transporter") %></td>
<td class="text-left"><%=rsData.getString("PhysicalDamage") %></td>
<td class="text-center"><%=rsData.getString("RepUnit") %></td>
<td class="text-center"><%=rsData.getString("InvoiceRefNo") %></td>
<td class="text-left"><%=rsData.getString("InvoiceRaised") %></td>
<%
i++;
srno++;
  }
   %>
   
</tr>

</tbody>
</table>
 <%
 }
else
{
     System.out.println("In else");
     %>
     <%
    String gotoPage = "physicaldamagereport.jsp";
%>

<script type="text/javascript">
alert("<%= "There are no records to display"%>");
window.location = "<%= gotoPage %>";
</script>
     <%
  }
%>

<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
<input type="hidden" name="billYear" id="billYear" value="<%=year%>"/>
<input type="hidden" name="billMonth" id="billMonth" value="<%=month%>"/>

<%
}
%>
</div>
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

function gotoExcel (elemId, frmFldId)  
{  
         	var obj = document.getElementById(elemId);  
         	var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.data.action ="excel.jsp";     // CHANGE FORM NAME HERE
          document.forms["data"].submit();       // CHANGE FORM NAME HERE
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
function DeleteRow(id)
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
			var queryString = "?action=approve&id="+id+"&year="+year+"&month="+month;
			ajaxRequest.open("GET", "AjaxGeneratePHDPdf.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
 }	
	
function getcheckedrow()
{
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}

	if(flag == "success")
	{
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";
		for(cnt=0;cnt<chklength.length;cnt++)
		{
			if(document.getElementById("chkbx"+i).checked)
			{
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			}
			i++;
		}
		DeleteRow(id);
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
	xmlhttp.open("GET","ListOfMonthlyInvoices1.jsp?month="+month+"&year="+year,true);
	xmlhttp.send();
}
</script>

 <%@ include file="footer.jsp" %>
 </body>
</html>