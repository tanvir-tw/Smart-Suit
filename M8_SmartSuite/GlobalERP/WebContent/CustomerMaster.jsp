<%@page import="org.apache.poi.hssf.record.RefreshAllRecord"%>
<%@page import="com.lowagie.text.Document"%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
   <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Branch Master</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>


<!-- <style>-->
<!--th-->
<!--{-->
<!--background: #C6DEFF;-->
<!--}-->
<!--</style>-->
<!-- 	<script>


window.onload=check;
</script> -->
<script type="text/javascript">
function birt()
{ var queryString=document.getElementById("queryString");
document.getElementById("myIframe").src="http://"+host1+":8080/ERPTestBirt/frameset?__report=CustomerMaster.rptdesign&__showtitle=false&__pageFooterFloatFlag=False"+queryString+"";
}
/* function vali()
{ var x = document.getElementById("customertype").value;
alert(x);
if(x!="Prospect")
	 {
	 document.getElementById("custcategory").style.display="none";
	 document.getElementById("custcategory1").style.display="none";
	 //document.getElementById("CustCategory").style.visibility="hidden";
	 //id=//"custcategory
	 }
else
	 {
	 document.getElementById("custcategory").style.display="";
	 document.getElementById("custcategory1").style.display="";
	 }
	}
function check() {
	 var x = document.getElementById("customertype").value;
	// alert(x);
	 if(x!="Prospect")
		 {
		 document.getElementById("custcategory").style.display="none";
		 document.getElementById("custcategory1").style.display="none";
		 //document.getElementById("CustCategory").style.visibility="hidden";
		 //id=//"custcategory
		 }
	 else
		 {
		 document.getElementById("custcategory").style.display="";
		 document.getElementById("custcategory1").style.display="";
		 }
} */
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.categoryform.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["categoryform"].submit();       // CHANGE FORM NAME HERE

} 
function DeleteRow(id)
{
	// alert(id);
	 var id=id;
	 var agree=confirm("Do You Want To Deactivate This Record?");
	 //alert(agree);
	 if(agree)
	 {
	 	 
	 var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
	    }  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(">>>    "+reslt);
				var data=reslt.split("#");
				//alert("<*****  "+data);
				if(data[1].indexOf('Yes')!=-1)
				{alert("De-activated successfully.....");					
			    	window.location.reload();
			    	
				}
			
			} 
		}
		
		var queryString = "?action=delete&Id="+id;
		
		
		ajaxRequest.open("GET", "opportunityCancel.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 }
	 else
	 	 {
	 	 
	 	  return false;
	 }
	 
	
}  


function getcheckedrow()
{
	//alert("hiiiii");
	var cnt1=0,k=1,flag="t";
	var chklength=document.getElementsByName("chkbx");
//	alert("hiiiii"+chklength);
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chk"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}
	var i=1,j,cnt=0;
	var id="";
	//alert("hiiiii1");
	
	if(flag == "success")
	{
	for(cnt=0;cnt<chklength.length;cnt++)
	{
		//alert("for"+chklength.length);
		
		if(document.getElementById("chk"+i).checked)
		{
			//alert("if");
			id=id+","+document.getElementById("net_id1"+i).innerHTML;
		}
		i++;
	}
	//alert("check"+id);
	DeleteRow(id);
	}
	else
	{
		alert("Please Select Category For Deactivation");
	}
	
}
function getCustomer(customer){
	alert("hi");
	alert(document.getElementById('customer').value=customer);
}

function DeleteConfirm()
{
	var agree=confirm("Do You Want To Delete Branch?");
		if (agree)
			return true ;
		else
			return false ;
}
function InsertConfirm()
{
	var agree=confirm("Do You Want To Edit Company?");
	if (agree)
		return true ;
	else
		return false ;	
}

function assigndrop() {
	var cmptype=document.getElementById("customertype").value;
	alert("COMPANY TYPE IS"+cmptype);
	document.getElementById("type1").value=cmptype;
}

function  selectedvalue() {
	alert("111111111111111111111111111");
	var seltype=document.getElementById("type1").value;
alert("Selected Value"+seltype);

document.getElementById("customertype").value=seltype;
	
}
</script>
</head>
<!-- <input type="text" name="type1" id="type1" value=""> -->
<body>

<% erp.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD); %>
<%!
Connection conn=null;

%>

<%
//////////

System.out.println("Page - CustomerMaster.jsp");

conn=erp.ReturnConnection();
Statement st=conn.createStatement();
Statement st1=conn.createStatement();
Statement st2=conn.createStatement();
Statement st3=conn.createStatement();
Statement st4=conn.createStatement();
Statement st5=conn.createStatement();

%>

<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String sortlist="";
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
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		data2 = request.getParameter("data1");
		
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
try{	
if(null==request.getParameter("sorting")||""==request.getParameter("sorting"))
{
	sortlist="SrNo";
}else
{
	 sortlist=request.getParameter("sorting");
}}catch(Exception ex)
{
	sortlist="SrNo";
}
System.out.println("Sorting Column is====="+sortlist);

String customertype="";
String BranchName="";
String city="";
String cust1="Customer";
String typebusiness="";
String queryString="";

String Type=request.getParameter("customertype");

System.out.println("Type------------->"+Type);

try{
	
if(request.getParameter("customertype").equalsIgnoreCase("Prospect")&& request.getParameter("CustCategory").equalsIgnoreCase("Liaison"))
 {
	 customertype="1";
	 cust1="Liaison";
 }
if(request.getParameter("customertype").equalsIgnoreCase("Prospect")&& request.getParameter("CustCategory").equalsIgnoreCase("Customer"))
{
	 customertype="1";
	 cust1="Customer";
}
if(request.getParameter("customertype").equalsIgnoreCase("Customer")&& request.getParameter("CustCategory").equalsIgnoreCase("Customer"))
 {
	 customertype="0";
	 cust1="Customer";
 }
if(request.getParameter("customertype").equalsIgnoreCase("Customer")&& request.getParameter("CustCategory").equalsIgnoreCase("Liaison"))
{
	 customertype="0";
	 cust1="Liaison";
}
/* if(request.getParameter("customertype").equalsIgnoreCase("Liasion"))
{
	customertype="2";	
} */

/* if(request.getParameter("CustCategory").equalsIgnoreCase("Liasion"))
{  
	cust1="Liasion";
	
}
if(request.getParameter("CustCategory").equalsIgnoreCase("Customer"))
{
	cust1="Customer";
} */

	
 System.out.println("Customer Type IS"+customertype);
 if(request.getParameter("BranchName")==null||request.getParameter("BranchName")=="")
 {
	 BranchName="All";
 }else
 {
	 BranchName=request.getParameter("BranchName");
 }
 System.out.println("Branch Name"+BranchName);
 
 if(request.getParameter("city")==null||request.getParameter("city")=="")
 {
	 city="All";
 }else
 {
	 city=request.getParameter("city");
 }
 
 System.out.println("City IS====="+city);

 if(request.getParameter("typebusiness")==null||request.getParameter("typebusiness")=="")
 {
	 typebusiness="All";
 }else
 {
	 typebusiness=request.getParameter("typebusiness");
 }
  System.out.println("TYpe OF Business====="+typebusiness);
}catch(Exception ex)
{
	customertype="1";
	BranchName="All";
	city="All";
	typebusiness="All";
}
  
queryString="&IsDataValid="+customertype+"&CustCategory="+cust1+"&Branch="+BranchName+"&City="+city+"&Load="+typebusiness+"&CompId="+session.getAttribute("CompanyMasterID").toString()+"&Sort="+sortlist+"";

System.out.println("Query Parameter====="+queryString);

	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); %>
<div align="center" style="font-size: 3;" ><table  align="center" style="width: 70%;"><tr><td align="center" colspan="4"> 
<font><b>Customer Master Report</b></font></td></tr></table></div>
<br>

<form  name="categoryform1"id="categoryform1" action="" method="post" >		
<div id='dept1' align="center" style="font-size: 2;">
			<table>
			<tr>
				<td>
				Customer Type
				</td>
				<td>
				
				<select name="customertype" id="customertype" >
				<%if(customertype.equalsIgnoreCase("Prospect") || customertype=="1"){%><option value="Prospect" selected>Prospect</option><%}else{ %>
   					 <option value="Prospect">Prospect</option>
				    <%}if(customertype.equalsIgnoreCase("Customer")|| customertype=="0"){%><option value="Customer" selected>Customer</option><%}else{%>
				    <option value="Customer">Customer</option>
					<%}
					
				
					
					%>
				<!-- 	<option value="Liasion">Liasion</option> -->
				</select>
				</td>
<td></td>
    <%--   <%if(customertype=="0"){ %> --%>
<%-- <td id="custcategory"  <%if(customertype=="0"){ %>style="display:'none'"<% }else{%>style="display:''" <%} %>> --%>
<%-- <% }else{%> --%>
<!-- <td id="custcategory" style="display:''"> --><%-- <%} %> --%>
<td id="custcategory" style="display:''">
				Customer Category
	</td>			
				<%-- <td id="custcategory1" <%if(customertype=="0"){ %>style="display:'none'"<% }else{%>style="display:''" <%} %> > --%>
				<td>
				<select name="CustCategory" id="CustCategory">
				<%
				
				if(((cust1.equalsIgnoreCase("Customer"))&&((customertype.equalsIgnoreCase("Prospect") || customertype=="1"||customertype=="0"))))
				
				{%>
				
				<option value="Customer" selected>Customer</option>
				
				<%}
				
				else{ 
				%>
   					 <option value="Customer">Customer</option>
				 <%}
				
				if(cust1.equalsIgnoreCase("Liaison")&&((customertype.equalsIgnoreCase("Prospect") || customertype=="1"||customertype=="0")))
				
				{%>
				
				<option value="Liaison" selected>Liaison</option>
				<%}
				else
				{%>
				    <option value="Liaison">Liaison</option>
				<%}
					
				
				////////////////
					
				
					
					%>
				
				
				<!-- <option value="Customer">Customer</option>
				<option value="Liaison">Liaison</option> -->
				
				 </select>		 
				</td>
				

				<td>
				Branch Name
				</td>
				<td>
				<select name="BranchName" id="BranchName">
				<option value="All">All</option>
				<% String sqlDropdownB="SELECT Distinct BranchName  FROM "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster ";
				  ResultSet rsDropdownB=st2.executeQuery(sqlDropdownB);
				  while(rsDropdownB.next()){
				  System.out.println(BranchName+"-----"+rsDropdownB.getString(1));
				  if(BranchName.equalsIgnoreCase(rsDropdownB.getString(1)))
				  {
				  %>
				 	<option value="<%=rsDropdownB.getString(1)%>" selected><%=rsDropdownB.getString(1)%></option>
				 <%}else{
					 %>
					 	<option value="<%=rsDropdownB.getString(1)%>"><%=rsDropdownB.getString(1)%></option>
					 <%
				 
				 }}
				  %> 
				 </select></td>
				<td></td>
				<td>
				City
				</td>
				<td>
			<select name="city" id="city">
				  <option value="All">All</option>
				  <% String sqlDropdown1="SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo ";
				  ResultSet rsDropdown1=st3.executeQuery(sqlDropdown1);
				  while(rsDropdown1.next()){
				  if(city.equalsIgnoreCase(rsDropdown1.getString(1)))
				  {%>
				 	<option value="<%=rsDropdown1.getString(1)%>" selected><%=rsDropdown1.getString(1)%></option>
				 <%}else{
					 %>
					 	<option value="<%=rsDropdown1.getString(1)%>"><%=rsDropdown1.getString(1)%></option>
					 <%}}%> 
				</select>
				</td>
			<td></td>
				<td>
				Load Type
				</td>
				<td>
				<select name="typebusiness" id="typebusiness">
				
				<option value="All">All</option>
				
				<% String sqlDropdownGB="SELECT Distinct loadType  FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster";
				  ResultSet rsDropdownGB=st4.executeQuery(sqlDropdownGB);
				  while(rsDropdownGB.next()){
				 if(typebusiness.equalsIgnoreCase(rsDropdownGB.getString(1)))
				  {%>
				 	<option value="<%=rsDropdownGB.getString(1)%>" selected><%=rsDropdownGB.getString(1)%></option>
				 <%}else{
					 %>
					 	<option value="<%=rsDropdownGB.getString(1)%>"><%=rsDropdownGB.getString(1)%></option>
					 <%}}%>
				
				</select>
				</td>
				<td>
				Sorted By
				</td>
				<td>
	<select name="sorting">
    <!-- <option value="srno">SrNo</option> -->
   <% if(sortlist.equalsIgnoreCase("BranchName")){%><option value="BranchName" selected>BranchName</option><%}else{%>
    <option value="BranchName">BranchName</option>
    <%}if(sortlist.equalsIgnoreCase("CompanyName")){%><option value="CompanyName" selected>CompanyName</option><%}else{%>
    <option value="CompanyName">CompanyName</option>
    <%}if(sortlist.equalsIgnoreCase("CollectionStaffName")){%><option value="CollectionStaffName" selected>CollectionStaffName</option><%}else{%>
    <option value="CollectionStaffName">CollectionStaffName</option>
    <%}if(sortlist.equalsIgnoreCase("City")){%><option value="City" selected>City</option><%}else{%>
    <option value="City">City</option>
    <%}if(sortlist.equalsIgnoreCase("OppCount")){%><option value="OppCount" selected>Valid From</option><%}else{%>
    <option value="OppCount">Opportunity Count</option>
    <%}if(sortlist.equalsIgnoreCase("SrNo")){%><option value="SrNo" selected>SrNo</option><%}else{ %>
    <option value="SrNo">SrNo</option>
    <%-- <%}if(sortlist.equalsIgnoreCase("AddedOnDate")){%><option value="AddedOnDate" selected>AddedOnDate</option><%}else{%>
    <option value="AddedOnDate">AddedOnDate</option> --%>
    <%}%>
	</select>
	 <input id="getstr" type="hidden" name="getstr" value="queryString">
	</td>	
				<td>
				<input type="submit" value="Submit"/>
				</td>
				
			</tr>
			</table>
</div></form>

<div>
<table width ="100%" border="0">
<tr align="left">

<td align="right">
				<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
				<!-- <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('dept','tableHTML');">
	           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			  -->
				</td>					
		</tr></table>
</div>
<%
	
	%>
																																			
<iframe id="myframe" style="width: 99.5%; height: 520px;" src="http://<%= host1 %>/birt/frameset?__report=CustomerMaster.rptdesign&__showtitle=false&__pageFooterFloatFlag=False<%=queryString%>"></iframe>
<%-- <form  name="categoryform"id="categoryform" action="" method="post" name="">
<%
String exportFileName="customer_report.xls"; 
String company= request.getParameter("companyName");


// GIVE YOUR REPORT NAME
%>
		
<div id='dept' align="center" >

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

			
<table align="center" id="reporttbl" class="sortable" border="3" style=" color: black;border-collapse:collapse; width: 100%;" >
<thead>
	<tr>
			<th><b>Edit</b></th>
		<th><b>Sr. No</b></th>
		<th><b>Company Name</b></th>
		<th><b>Type</b></th>
		<th><b> Branch Name</b></th>
		<th><b> Collection Staff</b></th>		
		<th><b> Group of Company     </b></th>
			<th><b>  Contact Person     </b></th>
		<th><b> Mobile No           </b></th>
		<th><b> Phone             </b></th>
	<th><b>  E-Mail             </b></th>
	<th><b>  WebSite                 </b></th>
	<th><b> Address          </b></th>
	<th><b>  City                 </b></th>
	<th><b>  Type of Business </b></th>
	<th><b>  Marketing Rep. Name </b></th>
	<th><b>  Assigned by  </b></th>
	<th><b>  Lead Ref </b></th>
	<th><b>  State </b></th>
	<th><b>  STD Code </b></th>
	<th><b>  Risk Involved  </b></th>
	<th><b>  Weekly Off On  </b></th>
	<th><b> Potential Value </b></th>
	<th><b>  Payment Terms (Days) </b></th>
	<th><b>  ZipCode </b></th>
	<th><b>  Country </b></th>
	<th><b>  Fax No </b></th>
	<th><b>  Interested In Product </b></th>
	<th><b>  Alternate Number </b></th>
	<th><b>  Comments </b></th>
	<th><b>  No Of Units </b></th>
	<th><b>  Opportunity Count </b></th>
	<th><b>  Assigned To </b></th>
	<!-- <th><b>  Who Assign </b></th> -->
	<th><b>  Assigned Date</b></th>
	<th><b>  Product </b></th>
	</tr>
</thead>
<%

String sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and IsDataValid='1'";

if(request.getParameter("customertype")!= null)
{
	String customertype=request.getParameter("customertype");
	String BranchName=request.getParameter("BranchName");
	String city=request.getParameter("city");
	String typebusiness=request.getParameter("typebusiness");

	
	
	if(customertype.equals("Prospect") && BranchName.equals("All") && city.equals("All") && typebusiness.equals("All"))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and IsDataValid='1'";
	}
	
	if(customertype.equals("Prospect") && city.equals("All") && typebusiness.equals("All") && !(BranchName .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and BranchName='"+BranchName +"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Prospect") && BranchName.equals("All") && typebusiness.equals("All") && !(city.equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and city='"+city+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Prospect") && BranchName.equals("All") && !(city .equalsIgnoreCase("All")) && !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and TypeOfBuisness='"+typebusiness+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Prospect") && typebusiness.equals("All") && !(BranchName .equalsIgnoreCase("All")) &&  !(city .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and BranchName='"+BranchName+"' and city='"+city+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Prospect") && BranchName.equals("All") && !(city .equalsIgnoreCase("All")) &&  !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and city='"+city+"' and TypeOfBuisness='"+typebusiness+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Prospect") && city.equals("All") &&  !(BranchName .equalsIgnoreCase("All")) && !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and BranchName='"+BranchName+"' and TypeOfBuisness='"+typebusiness+"' and IsDataValid='1'";
	}
	if(customertype.equals("Prospect") && !(city.equals("All")) &&  !(BranchName .equalsIgnoreCase("All")) && !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode=0 and BranchName='"+BranchName+"' and TypeOfBuisness='"+typebusiness+"'and city='"+city+"' and IsDataValid='1'";
	}
	
	
	if(customertype.equals("Customer") && BranchName.equals("All") && city.equals("All") && typebusiness.equals("All"))	
	{
		
		sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and IsDataValid='1'";
	}
	if(customertype.equals("Customer") && city.equals("All") && typebusiness.equals("All") && !(BranchName .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and BranchName='"+BranchName +"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Customer") && BranchName.equals("All") && typebusiness.equals("All") && !(city.equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and city='"+city+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Customer") && BranchName.equals("All") && !(city .equalsIgnoreCase("All")) && !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and TypeOfBuisness='"+typebusiness+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Customer") && typebusiness.equals("All") && !(BranchName .equalsIgnoreCase("All")) &&  !(city .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and BranchName='"+BranchName+"' and city='"+city+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Customer") && BranchName.equals("All") && !(city .equalsIgnoreCase("All")) &&  !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and city='"+city+"' and TypeOfBuisness='"+typebusiness+"' and IsDataValid='1'";
	}
	
	if(customertype.equals("Customer") && city.equals("All") &&  !(BranchName .equalsIgnoreCase("All")) && !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and BranchName='"+BranchName+"' and TypeOfBuisness='"+typebusiness+"' and IsDataValid='1'";
	}
	if(customertype.equals("Customer") && !(city.equals("All")) &&  !(BranchName .equalsIgnoreCase("All")) && !(typebusiness .equalsIgnoreCase("All")))
	{
		
		sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode Not in (0) and BranchName='"+BranchName+"' and TypeOfBuisness='"+typebusiness+"'and city='"+city+"' and IsDataValid='1'";
	}

}	
 
 ResultSet rs = st1.executeQuery(sql);
 String name="",color="", Type="";
 int j=0;
 int i=0;
 
 while(rs.next())
 {  
	 
	if(rs.getString("SalesCustomerCode").equalsIgnoreCase("0"))
	 {
		 Type="Prospect";
	 }
	 else
	 {
		 Type="Customer";
	 }
	j++; 
 %>
<tr style="background:<%=color%>;">
<td  width="" align="right"><a href="<%if(Type.equalsIgnoreCase("Customer")){%>editCompany.jsp?companyCode=<%=rs.getString("SalesCustomerCode")%><%}else {%>addNewCustomer.jsp?companyName=<%=rs.getString("CustomerCode")%><%}%>" target="_blank"><img src="images/edit.JPG" width ="18px" height="18px"></a></td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= ++i%></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
		<a href="addOpportunityNew.jsp?companyName=<%=rs.getString("CompanyName").replace('&','~') %>">	<%= rs.getString("CompanyName")%></a></td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= Type%></td>

<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("BranchName")%></td>				
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("ColloectionStaffName")%></td>				
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("GroupOfCompany")%></td>	
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= rs.getString("ContactPerson")%></td>	
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("MobileNo")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Phone")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("EMail")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("WebSite")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Address")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("City")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("TypeOfBuisness")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("CustEnteredByRep")%>		</td>			
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Assighnedby")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("leadRef")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("State")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("STDCode")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("RiskInvolved")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("WeeklyOffon")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("PotentialValue")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("PayTerms")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Zip")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Country")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Fax")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("IntrestedProduct")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("MobileNo1")%>		</td>
<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("Comments")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%=rs.getString("NoOfUnits")%>		</td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">		
<%

DateFormat sm = new SimpleDateFormat("dd-MM-yyyy");



String sqlopprtcnt="SELECT count(customer_code) FROM "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster where  customer='"+rs.getString("CompanyName")+"'";

String srt1="";
Date date=null,formatteddate=null;
ResultSet rssqlopprtcnt=st.executeQuery(sqlopprtcnt);
while(rssqlopprtcnt.next())
{
	try{
	srt1=rs.getString("AddedOnDate");
	srt1=sm.format(new SimpleDateFormat("yyyy-MM-dd").parse(srt1));
	}catch(Exception n){
	srt1="-";
	}
	/* date = df.parse(str1);
	formatteddate = df.format(date); */

%>
<%=rssqlopprtcnt.getString(1)%>			
<%}%> 
</td>

<!-- Who created, whom assigned, when created, product -->
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"> <%=rs.getString("CustEnteredByRep")%></td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"> <%=rs.getString("Assighnedby")%></td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"> <%=srt1%></td>
<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"> <%=rs.getString("DealInProduct")%></td>
</tr>
<% } %>
</table></div></form> --%>

<br><br><br><br><br><br><br><br>
<!-- <div id="footer">
	<p><a href="#">
Copyright &copy; 2014 Safe & Secure Logistics Pvt Ltd.
</a></p>
	</div> -->
</body>
</html>
</jsp:useBean>
<%-- <%@include file="footer_new.jsp"%> --%>