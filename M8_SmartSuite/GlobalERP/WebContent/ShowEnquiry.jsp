 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
  <%@ page import="java.util.Date"%>
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
// Variable Declaration
String monthFirstDate = session.getAttribute("onemonthback").toString();
String todaysDate = session.getAttribute("today").toString();

String datex1 = "", datex2 = "", bt = "", data1 = "", data2 = "", dt = "", dt1 = "", dttime = "", dt1time = "";
String selectedName="",reportname="",typesname="";
String reports = request.getParameter("reports");
String types = request.getParameter("types");
String group = request.getParameter("group");
int total=0,sum=0;
// Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");
	st = conn.createStatement();
} catch (Exception e) {
	e.printStackTrace();
}
%>
<%
try {
	bt = request.getParameter("button");

	if (bt == null || bt.equals("null")) {
		datex1 = monthFirstDate;
		datex2 = todaysDate;

	} else {
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");

	}

	dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
	dttime = "" + dt + " 00:00:00";

	dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
	dt1time = "" + dt1 + " 23:59:59";
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> <!-- Added text-center class -->
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637">All ENQUIRIES Reports</h5>
    </div>
</div>

			<form name="formreport" id="formreport" method="get">
				<div class="row col-12">
				<div class="col-md-1"></div>
					<div class="col-md-2">
						<label for="dropdown"><b>Types of Reports</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="reports" name="reports">				
								<option value='select' selected
									<%=(reports == null) ? "selected='selected'" : ""%>>Select</option>
								<option value='enquiryall'
									<%=(reports != null && reports.equals("enquiryall")) ? "selected='selected'" : ""%>>All
									Enquiries</option>
								<option value='pendingenquiries'
									<%=(reports != null && reports.equals("pendingenquiries")) ? "selected='selected'" : ""%>>Pending
									Enquiry</option>
								<option value='allquotations'
									<%=(reports != null && reports.equals("allquotations")) ? "selected='selected'" : ""%>>Quotations</option>
								<option value='pendingquotations'
									<%=(reports != null && reports.equals("pendingquotations")) ? "selected='selected'" : ""%>>Pending
									Quotations</option>
								<option value='cancelledquotations'
									<%=(reports != null && reports.equals("cancelledquotations")) ? "selected='selected'" : ""%>>Quotations
									Cancelled</option>
								<option value='allorders'
									<%=(reports != null && reports.equals("allorders")) ? "selected='selected'" : ""%>>Order</option>
								<option value='pendingorders'
									<%=(reports != null && reports.equals("pendingorders")) ? "selected='selected'" : ""%>>Pending
									Orders</option>
								<option value='cancelledorders'
									<%=(reports != null && reports.equals("cancelledorders")) ? "selected='selected'" : ""%>>Cancelled
									Orders</option>
								<option value='allinvoices'
									<%=(reports != null && reports.equals("allinvoices")) ? "selected='selected'" : ""%>>Invoices</option>
								<option value='cancelledinvoices'
									<%=(reports != null && reports.equals("cancelledinvoices")) ? "selected='selected'" : ""%>>Cancelled
									Invoices</option>
							</select>
							<script>
                             const mySel = document.getElementById("reports");
                             const savedValue = localStorage.getItem("selValue");
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
						</div>
					</div>

					<div class="col-md-2">
						<label for="dropdown"><b>Select Type</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="types" name="types">
								<option value='alltypes' <%= (types == null) ? "selected='selected'" : "" %>>All</option>
        <option value='domestic' <%= (types != null && types.equals("domestic")) ? "selected='selected'" : "" %>>Domestic</option>
        <option value='export' <%= (types != null && types.equals("export")) ? "selected='selected'" : "" %>>Export</option>
							</select>
							<script>
                            const mySel = document.getElementById("types");
                             const isBtNull = <%=bt == null%>;
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
						</div>
					</div>


					<div class="col-md-2">
						<label for="dropdown"><b>Select Group</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="group" name="group">
								<%
			
		String sqlGroup="SELECT distinct(TheGroupName),TheGroupCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster ";
		ResultSet rsGroup=st.executeQuery(sqlGroup);
		
		if(group != null) { 	
				%><option value='All' >All</option><%
			}else{
				 %><option value='All' selected="selected">All</option><%
						 
				while(rsGroup.next()){ %>
 				<option value="<%=rsGroup.getString(1) %>"><%=rsGroup.getString(1) %></option>
		<%
		}
			}
			if(group != null)
			{
				while(rsGroup.next())
				{
					if(group.equals(rsGroup.getString(1))) 
					{	
						%><option value="<%=rsGroup.getString(1) %>" selected="selected"><%=rsGroup.getString(1) %></option><%
					}else
					{
						%><option value="<%=rsGroup.getString(1) %>"><%=rsGroup.getString(1) %></option><%
					}
				}
							
			}	
		     %>     
							</select>
							<script>
                            const mySel = document.getElementById("group");
                             const isBtNull = <%=bt == null%>;
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
						</div>
					</div>



					<div class="col-md-2" id="fromdate">
						<label for="from"><b>From</b></label>
						<div class="input-group input-group-merge">
							<input type="text" name="data" id="data" class="form-control" value="<%=datex1%>"> <span class="input-group-text">
								<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
						</div>
					</div>

					<div class="col-md-2" id="todate">
						<label for="to"><b>To</b></label>
						<div class="input-group input-group-merge">
							<input type="text" id="data1" name="data1" class="form-control" value="<%=datex2%>" /> 
							<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect> <line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line> <line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
						</div>
					</div>

					<div class="col-md-1 mt-4">
						<input type="submit" class="btn btn-primary" id="button"
							name="button" value="Submit"
							onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
					</div>

				</div>
			</form>
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>

<%
String[] areport =null;
if(!(request.getParameterValues("reports")==null))
{
	areport=request.getParameterValues("reports");
	if(areport[0].equalsIgnoreCase("enquiryall"))
	reportname="enquiryall";	
	else if(areport[0].equalsIgnoreCase("pendingenquiries"))
	reportname="pendingenquiries";
	else if(areport[0].equalsIgnoreCase("allquotations"))
	reportname="allquotations";
	else if(areport[0].equalsIgnoreCase("pendingquotations"))
	reportname="pendingquotations";
	else if(areport[0].equalsIgnoreCase("cancelledquotations"))
	reportname="cancelledquotations";
	else if(areport[0].equalsIgnoreCase("allorders"))
	reportname="allorders";
	else if(areport[0].equalsIgnoreCase("pendingorders"))
	reportname="pendingorders";
	else if(areport[0].equalsIgnoreCase("cancelledorders"))
	reportname="cancelledorders";
	else if(areport[0].equalsIgnoreCase("allinvoices"))
	reportname="allinvoices";
	else if(areport[0].equalsIgnoreCase("cancelledinvoices"))
	reportname="cancelledinvoices";
	
	else
	{
	for(int i=0;i<areport.length;i++) 
	reportname+="'"+areport[i]+"',";
	reportname = reportname.substring(0, reportname.length() - 1);
	}
	for(int i=0;i<areport.length;i++)
	System.out.println("REPORT NAME***********"+areport[i]);		
}
if(!reportname.equalsIgnoreCase("enquiryall")){ %>
			 <%
String ReportName=request.getParameter("reports");
%>
	<input type="hidden" id="Reportname" name="Reportname" value="<%=ReportName%>" /> 		
		<%
}
String arr1[]=null;
if(!(request.getParameterValues("types")==null))
{
	typesname="";	
	arr1=request.getParameterValues("types");
	if(arr1[0].equalsIgnoreCase("alltypes"))
	typesname="alltypes";
	else if(arr1[0].equalsIgnoreCase("domestic"))
	typesname="domestic";
	else if(arr1[0].equalsIgnoreCase("export"))
	typesname="export";
	else
	{
	for(int j=0;j<arr1.length;j++)
	typesname+="'"+arr1[j]+"',";
	
	typesname = typesname.substring(0, typesname.length() - 1);
	}
	for(int j=0;j<arr1.length;j++)
		System.out.println("type name***********"+arr1[j]);
}	
	
String[] arr=null;
if(!(request.getParameterValues("group")==null))
{
	selectedName="";
	arr=request.getParameterValues("group");
	if(arr[0].equalsIgnoreCase("All"))
	selectedName="All";	
	else if(arr[0].equalsIgnoreCase("Compressor"))
	selectedName="Compressor";
	else if(arr[0].equalsIgnoreCase("DGSet"))
	selectedName="DGSet";
	else if(arr[0].equalsIgnoreCase("DigitalEquipment"))
	selectedName="DigitalEquipment";
	else if(arr[0].equalsIgnoreCase("Endoscope"))
	selectedName="Endoscope";
	
	else
	{
	for(int i=0;i<arr.length;i++) 
	selectedName+="'"+arr[i]+"',";
	
	selectedName = selectedName.substring(0, selectedName.length() - 1);
	}
	for(int i=0;i<arr.length;i++)
	System.out.println("Sel name***********"+arr[i]);		
}

%>

			<%
//******************************************************* FOR ENQUIRY (ALL) STARTS HERE***************************************************************************



if("enquiryall".equalsIgnoreCase(reportname))                             //for selection of report
{	System.out.println("in if of enquiry all");
System.out.println("query string "+request.getQueryString() );
if( request.getQueryString() != null)
	{
	System.out.println("in if of enquiry all inner if");
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0" style="color: #060637">All ENQUIRIES</h5></div>
		<br>
		<div class="container" style="width: 80%">
	<table id="example" class="display" style="width: 100%">
	<thead>
			<tr>
				<th class="col-width-4">SrNo.</th>
				<th>SalesEnqNo</th>
				<th>SalesEnqRefNo</th>
				<th>SalesEnqDate</th>
				<th>CompanyName</th>
				<th>City</th>                
			</tr>
	</thead>
		<tbody>
		<%if(!reportname.equalsIgnoreCase("enquiryall")){ %>
		
		<%}
		String condition="";
		String condition1="";
		String SqlEnquiry="";
		//int i=1;
		boolean flag=false;
		if("alltypes".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName)){	//for selection of group
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY SalesEnqNo,SalesEnqRefNo, SalesEnqDate,  CompanyName, City ";
					condition="WHERE SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY SalesEnqNo,SalesEnqRefNo, SalesEnqDate,  CompanyName, City ";
					flag=true;
			}else  if("Compressor".equalsIgnoreCase(selectedName)){
			SqlEnquiry="SELECT  a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b  ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else if("DGSet".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=2 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else if("DigitalEquipment".equalsIgnoreCase(selectedName)){
			}else if("Endoscope".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=4 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else{
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup >=5 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}
		}	
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName)){	                                  //for selection of group
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' AND SalesEnqType=0 GROUP BY SalesEnqNo,SalesEnqRefNo, SalesEnqDate,  CompanyName, City";
			condition="WHERE SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' AND SalesEnqType=0 GROUP BY SalesEnqNo,SalesEnqRefNo, SalesEnqDate,  CompanyName, City";
			flag=true;
			}else if("Compressor".equalsIgnoreCase(selectedName)){
			SqlEnquiry="SELECT  a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b  ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=1 AND  a.SalesEnqType=0 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City  ";
			}else if("DGSet".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=2 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else if("DigitalEquipment".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=3 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else if("Endoscope".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=4 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City";
			}else{
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup >=5 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City LIMIT 10";
			}
		}	
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName)){	                                  //for selection of group
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' AND SalesEnqType=1 GROUP BY SalesEnqNo,SalesEnqRefNo, SalesEnqDate,  CompanyName, City LIMIT 10 ";
					condition="WHERE SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' AND SalesEnqType=1 GROUP BY SalesEnqNo,SalesEnqRefNo, SalesEnqDate,  CompanyName, City LIMIT 10 ";
					flag=true;
			}else if("Compressor".equalsIgnoreCase(selectedName)){
			SqlEnquiry="SELECT  a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b  ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=1 AND  a.SalesEnqType=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City";
			}else if("DGSet".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.CityFROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=2 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else if("DigitalEquipment".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=3 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else if("Endoscope".equalsIgnoreCase(selectedName)){
			SqlEnquiry=	"SELECT a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=4 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}else{
			SqlEnquiry=	"SELECT a.SalesEnqNo as SalesEnqNo,a.SalesEnqRefNo as SalesEnqRefNo, SalesEnqDate, a.CompanyName as CompanyName, a.City FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup >=5 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"'  GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City ";
			}
		}
		String condition3="";
		if(flag){
			condition1=condition;
			condition3="condition";
		}else{
			condition1=SqlEnquiry;
			condition3="conditionAll";
		}
		System.out.println(SqlEnquiry);
		System.out.println(condition1);
		ResultSet rsEnq=st.executeQuery(SqlEnquiry);
		int i=1;
		
 		while(rsEnq.next())
 			
 		{
 			String SalesEnqRefNo=rsEnq.getString("SalesEnqRefNo");
 			String CompanyName=rsEnq.getString("CompanyName");
 			String city  = rsEnq.getString("City");
		%>
		<tr>
		<td class="text-center"><%=i%></td>
		<td class="text-center"><%=rsEnq.getString("SalesEnqNo")%></td>
		<td class="text-center"><a href="#" onclick="viewDetails('SEDetails.jsp', '<%= SalesEnqRefNo %>', '<%=CompanyName %>')"><%= SalesEnqRefNo %></a></td>
		<td class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnq.getString("SalesEnqDate")))%></td>
		<td class="text-left"><%=CompanyName%></td>
		<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
            <td class="text-left"><%=city%></td>
	</tr>
<%
i++;
}
%>

</tbody>
</table>
</div>
<%	}
else
{
	
}
}
%>


<%// *************************************************************  ENQUIRY(ALL) ENDS HERE************************************************************ %>
	
	
<%
// *************************************************   FOR ENQUIRY (PENDING) STARTs HERE  *******************************************************
if("pendingenquiries".equalsIgnoreCase(reportname))
{	
  //if(null != request.getQueryString() && !typesname.equalsIgnoreCase("alltypes"))
	
		%>
	
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0" style="color: #060637">PENDING ENQUIRIES</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
			<th class="col-width-4">Sr.No</th>
			<th>SQ NO</th>
			<th>Sales Enq Ref No</th>
			<th>Generated Date</th>
			<th>Company</th>
			<th>City</th>
		</tr>
		
		</thead>
		<tbody>
		<%
		String SqlEnquiry="";
		
		if("alltypes".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=1 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=2 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("DigialEquipment".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=3 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup=4 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else	
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE b.TheGroup>=5 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE  a.SalesEnqType=0 AND b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=1 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=2 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("DigialEquipment".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=3 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup=4 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else	
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=0 AND b.TheGroup>=5 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE  a.SalesEnqType=1 AND b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=1 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=2 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("DigialEquipment".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=3 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup=4 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
			else	
			SqlEnquiry="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items as b ON(a.SalesEnqNo=b.SalesEnqNo) WHERE a.SalesEnqType=1 AND b.TheGroup>=5 AND  b.PriceQuoted=1 AND a.SalesEnqDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesEnqNo,a.SalesEnqRefNo, a.SalesEnqDate, a.CompanyName, a.City   ";
		}		
		System.out.println(SqlEnquiry);
		System.out.println("IN THE LOOP");
		%>
			
		<%
ResultSet rsEnq = null; 
try {
    rsEnq = st.executeQuery(SqlEnquiry);
int i=1;
    while (rsEnq.next()) {
        String transactionId = rsEnq.getString("SalesEnqRefNo");
        String company = rsEnq.getString("CompanyName");
        String city  = rsEnq.getString("City");
%>
        <tr>
        	<td class="text-center"><%=i%></td>
            <td class="text-center"><%=rsEnq.getString("SalesEnqNo") %></td>
            <td class="text-center"><a href="#" onclick="viewDetails('SEDetails.jsp','<%=transactionId%>','<%=company %>')"><%=transactionId %></a></td>
            <td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnq.getString("SalesEnqDate")))%></td>
            <td class="text-left"><%=company %></td>
            <%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
            <td class="text-left"><%=city%></td>
        </tr>
<%
i++;
    }
} catch (Exception e) {
    e.printStackTrace();
} 
%>		
	</tbody>
</table>
</div>
<%
}

%>
<%// ********************************************************  ENQUIRY(PENDING) ENDS HERE************************************************************* %>
	<% 			
		// *************************************************   FOR QUATAIONS (ALL) STARTs HERE  *******************************************************
if("allquotations".equalsIgnoreCase(reportname))
{	
if(null != request.getQueryString())
	{
		%>
		<br>
		<div class="text-center"><h5 class="content-header-title text-center mb-0" style="color: #060637">QUOTATIONS</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
			<th class="col-width-4">Sr.No</th>
			<th>SQ NO</th>
			<th>Customer Code</th>
			<th>Total Rs</th>
			<th>Generated On</th>
			<th>Company</th>
			<th>City</th>
		</tr>
		</thead>
		<tbody>
		<%
		String SqlQuotation="";
		
		if("alltypes".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=1 AND  a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode,a.Total, a.SalesQuoDate, a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=2 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode,a.Total, a.SalesQuoDate, a.CompanyName, a.city   ";
			else if("DigialEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=3 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode,a.Total, a.SalesQuoDate, a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=4  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode,a.Total, a.SalesQuoDate, a.CompanyName, a.city   ";
			else	
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup>=5  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode,a.Total, a.SalesQuoDate, a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=1 AND a.CurrType='Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=2 AND a.CurrType='Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=3 AND a.CurrType='Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=4 AND a.CurrType='Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup>=5 AND a.CurrType='Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  a.CurrType <> 'Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  b.TheGroup=1 AND a.CurrType <> 'Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  b.TheGroup=2 AND a.CurrType <> 'Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  b.TheGroup=3 AND a.CurrType <> 'Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  b.TheGroup=4 AND a.CurrType <> 'Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE  b.TheGroup>=5 AND a.CurrType <> 'Rupees' AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		System.out.println(SqlQuotation);
		System.out.println("IN THE LOOP");
		
		ResultSet rsQuo=st.executeQuery(SqlQuotation);
		int i=1;
		while(rsQuo.next())
			{
			String salesquono=rsQuo.getString("SalesQuoNo");
			String company=rsQuo.getString("CompanyName");
			String city  = rsQuo.getString("city");
		%>
			<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-center"><a href="#" onclick="viewQuotation('viewQuotation.jsp','<%=company %>','<%= salesquono%>')"><%=salesquono %></a></td>
			<td class="text-center"><%=rsQuo.getString("CustomerCode") %></td>
			<td class="text-center"><%=rsQuo.getString("Total") %></td>
			<td  class="text-center"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsQuo.getString("SalesQuoDate")))%></td>
			<td class="text-center"><%=company%></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			<td class="text-center"><%=city %></td>
			</tr>
		<%
		i++;
			}
	}
%>
</tbody>
</table>
</div>
<% 
	}
%>

<%
// ********************************************************  QUOTATIONS(All) ENDS HERE************************************************************* %>
	
<%
// *************************************************   FOR PENDING QUoTATIONS  STARTs HERE  *******************************************************
if("pendingquotations".equalsIgnoreCase(reportname))
{
if(null != request.getQueryString())
	{
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0"
						style="color: #060637">PENDING ENQUIRIES</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>SQ NO</th>
		<th>Customer Code</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		<%
		String SqlQuotation="";
		
		if("alltypes".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND b.TheGroup=1 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND b.TheGroup=2 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND b.TheGroup=3 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND b.TheGroup=4 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND b.TheGroup>=5 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=1 AND a.CurrType='Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=2 AND a.CurrType='Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=3 AND a.CurrType='Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=4 AND a.CurrType='Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup>=5 AND a.CurrType='Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <>'Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=1 AND a.CurrTyp <> 'Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=2 AND a.CurrType <> 'Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=3 AND a.CurrType <> 'Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup=4 AND a.CurrType <> 'Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE b.TheGroup>=5 AND a.CurrType <> 'Rupees' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		System.out.println(SqlQuotation);
		ResultSet rsQuo=st.executeQuery(SqlQuotation);
		int i=1;
		while(rsQuo.next())
			{
			
			String salesquono=rsQuo.getString("SalesQuoNo");
			String company=rsQuo.getString("CompanyName");
			String city  = rsQuo.getString("city");
		%>
			<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-center"><a href="#" onclick="viewQuotation('viewQuotation.jsp','<%= company%>','<%= salesquono%>')"><%= salesquono %></a></td>
			<td class="text-center"><%=rsQuo.getString("CustomerCode") %></td>
			<td class="text-center"><%=rsQuo.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsQuo.getString("SalesQuoDate")))%></td>
			<td class="text-left"><%=company %></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			<td class="text-left"><%=city%></td>
			</tr>
		<%
		i++;
			}
	} 

%>
</tbody>
</table>
</div>
<% 
}
%>


<%// ******************************************************** PENDING QUOTATIONS ENDS HERE************************************************************* %>

<%
// *************************************************   FOR CANCELLED QUOTATIONS STARTs HERE  *******************************************************

if("cancelledquotations".equalsIgnoreCase(reportname))
{
if(null != request.getQueryString())
	{
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0"
						style="color: #060637">CANCELLED QUOTATIONS</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>SQ NO</th>
		<th>Customer Code</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		
		<%
		String SqlQuotation="";
		
		if("alltypes".equalsIgnoreCase(typesname))                                    //for selection of types
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=1  AND b.TheGroup=1 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=1  AND b.TheGroup=2 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=1  AND b.TheGroup=3 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=1  AND b.TheGroup=4 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.SalesQuoCancelled=1  AND b.TheGroup>=5 AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND b.TheGroup=1 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND b.TheGroup=2 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND b.TheGroup=3 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND b.TheGroup=4 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType='Rupees' AND b.TheGroup>=5 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <> 'Rupees' AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=1 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=2 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=3 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(typesname))
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=4 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
			else
			SqlQuotation="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items as b ON(a.SalesQuoNo=b.SalesQuoNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup>=5 AND a.SalesQuoCancelled=1  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesQuoNo,a.CustomerCode, a.Total,a.SalesQuoDate,a.CompanyName, a.city   ";
		}
		System.out.println(SqlQuotation);
		ResultSet rsQuo=st.executeQuery(SqlQuotation);
		int i=1;
		while(rsQuo.next())
			{
			
			String salesquono=rsQuo.getString("SalesQuoNo");
			String company=rsQuo.getString("CompanyName");
			String city  = rsQuo.getString("city");
		%>
			<tr>
			<td class="text-center"><%=i %></td>
			<td class="text-center"><a href="#" onclick="viewQuotation('viewQuotation.jsp','<%= company%>','<%= salesquono%>')"><%=salesquono %></a></td>
			<td class="text-center"><%=rsQuo.getString("CustomerCode") %></td>
			<td class="text-center"><%=rsQuo.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsQuo.getString("SalesQuoDate")))%></td>
			<td class="text-left"><%=company %></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			<td class="text-left"><%=city%></td>
			</tr>
		<%
		i++;
			}
	} 
%>
</tbody>
</table>
</div>
<%
}
%>


<%// ******************************************************** CANCELLED QUOTATIONS ENDS HERE************************************************************* %>

<%
// *************************************************   FOR ORDER(ALL) STARTs HERE  *******************************************************

if("allorders".equalsIgnoreCase(reportname))
{	
if(null != request.getQueryString())
	{
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0" style="color: #060637">ORDERS</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>Sales Order NO</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		<%
		String SqlOrder="";
		
		
		if("alltypes".equalsIgnoreCase(typesname))
		{	
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=1 AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=2 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=3  AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=4 AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup>=5 AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.CurrType='Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=1 AND  a.CurrType='Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=2 AND  a.CurrType='Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=3 AND  a.CurrType='Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=4 AND  a.CurrType='Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup>=5 AND  a.CurrType='Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.CurryType <> 'Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=1 AND  a.CurrType <> 'Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=2 AND  a.CurrType <> 'Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=3 AND  a.CurrType <> 'Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup=4 AND  a.CurrType <> 'Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.TheGroup>=5 AND  a.CurrType <> 'Rupees' AND a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		ResultSet rsOrder=st.executeQuery(SqlOrder);
		System.out.println(SqlOrder);
		int i=1;
		while(rsOrder.next())
			{
			
			String salesorder=rsOrder.getString("SalesOrderNo");
			String company= rsOrder.getString("CompanyName");
			String city  = rsOrder.getString("city");
		%>
			<tr>
			<td class="text-center"><%=i %></td>
			<td class="text-center"><a href="#" onclick="viewOrder('viewOrder.jsp','<%= company%>','<%=salesorder%>')"><%=salesorder%></a></td>
			<td class="text-center"><%=rsOrder.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsOrder.getString("SalesOrderDate")))%></td>
			<td class="text-left"><%=company %></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			<td class="text-left"><%=city %></td>
			</tr>
		<%
		i++;
			}
	}	
%>
</tbody>
</table>
</div>
<%
}
%>


<%// ******************************************************** ORDER(All) ENDS HERE************************************************************* %>

<%
// *************************************************   FOR PENDING ORDER STARTs HERE  *******************************************************

if("pendingorders".equalsIgnoreCase(reportname))
{
if(null != request.getQueryString())
	{
		%>
		
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0" style="color: #060637">PENDING ORDERS</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>Sales Order NO</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		<%
		String SqlOrder="";
		 
		if("alltypes".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";	
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=1 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=2 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=3 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup=4 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE b.TheGroup>=5 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND b.TheGroup=1 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND b.TheGroup=2 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND b.TheGroup=3 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND b.TheGroup=4 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND b.TheGroup>=5 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=1 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=2 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=3 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup=4 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND b.TheGroup>=5 AND  a.InvoiceGenerated=0  AND a.SOCancelled=0 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		ResultSet rsOrder=st.executeQuery(SqlOrder);
		System.out.println(SqlOrder);	
		int i=1;
		while(rsOrder.next())
			{
			
			String salesorder=rsOrder.getString("SalesOrderNo");
			String company= rsOrder.getString("CompanyName");
			String city  = rsOrder.getString("city");
		%>
			<tr>
			<td class="text-center"><%=i %></td>
			<td class="text-center"><a href="#" onclick="viewOrder('viewOrder.jsp','<%=company%>','<%=salesorder%>')"><%=salesorder %></a></td>
			<td class="text-center"><%=rsOrder.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsOrder.getString("SalesOrderDate")))%></td>
			<td class="text-left"><%=company%></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			
			<td class="text-left"><%=city %></td>
			</tr>
		<%
		i++;
			}
	}

%>
</tbody>
</table>
</div>
<%
}
%>


<%// ********************************************************PENDING ORDERs ENDS HERE************************************************************* %>

<%
// *************************************************   FOR CANCELLED ORDER STARTs HERE  *******************************************************

if("cancelledorders".equalsIgnoreCase(reportname))
{	
if(null != request.getQueryString())
	{
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0"
						style="color: #060637">CANCELLED ORDERS</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>Sales Order NO</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		<%
		String SqlOrder="";
		
		if("alltypes".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.Thegroup=1 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.Thegroup=2 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.Thegroup=3 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.Thegroup=4 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else 
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.Thegroup>=5 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND a.Thegroup=1 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND a.Thegroup=2 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND a.Thegroup=3 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND a.Thegroup=4 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else 
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType='Rupees' AND a.Thegroup>=5 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{	
			if("All".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND a.Thegroup=1 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND a.Thegroup=2 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND a.Thegroup=3 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND a.Thegroup=4 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
			else 
			SqlOrder="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items as b ON(a.SalesOrderNo=b.SalesOrderNo) WHERE a.CurrType <> 'Rupees' AND a.Thegroup>=5 AND a.SOCancelled=1 AND  a.SalesOrderDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.SalesOrderNo, a.Total,a.SalesOrderDate,a.CompanyName, a.city   ";
		}
		System.out.println(SqlOrder);
		ResultSet rsOrder=st.executeQuery(SqlOrder);
		int i=1;
		while(rsOrder.next())
			{
			
			String salesorder=rsOrder.getString("SalesOrderNo");
			String company= rsOrder.getString("CompanyName");
			String city  = rsOrder.getString("city");
		%>
			<tr>
			<td class="text-center"><%=i %></td>
			<td class="text-center"><a href="#" onclick="viewOrder('viewOrder.jsp','<%= company%>','<%=salesorder%>')"><%=salesorder %></a></td>
			<td class="text-center"><%=rsOrder.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsOrder.getString("SalesOrderDate")))%></td>
			<td class="text-left"><%=company %></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			
			<td class="text-left"><%=city%></td>
			</tr>
		<%
		i++;
	}
} 
%>
</tbody>
</table>
</div>
<%
}
%>


<%// ********************************************************CANCELLED ORDER ENDS HERE************************************************************* %>
	
	
	
	<%
// *************************************************   FOR INVOICES(ALL) STARTs HERE  *******************************************************

if("allinvoices".equalsIgnoreCase(reportname))
{
	int i=1;
if(null != request.getQueryString())
	{
	
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0" style="color: #060637">INVOICES</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>Sales Invoice Ref NO</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		<%
		String SqlInvoice="";
	
		if("alltypes".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.TheGroup=1 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))	
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.TheGroup=2 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.TheGroup=3 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.TheGroup=4 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.TheGroup>=5 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE  a.CurrType='Rupees' AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.TheGroup=1 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))	
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.TheGroup=2 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.TheGroup=3 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.TheGroup=4 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.TheGroup>=5 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE  a.CurrType <> 'Rupees' AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.TheGroup=1 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))	
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.TheGroup=2 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.TheGroup=3 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.TheGroup=4 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.TheGroup>=5 AND  a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
		}
		ResultSet rsInvoice=st.executeQuery(SqlInvoice);
		System.out.println(SqlInvoice);
		
		while(rsInvoice.next())
		{
			String salesinvoiceno=rsInvoice.getString("invoiceRefNo");
			String city  = rsInvoice.getString("city");
			String company=rsInvoice.getString("CompanyName");
			sum=rsInvoice.getInt("Total");
			System.out.println("SUM IS**************   "+sum );
			total=total+sum;
			System.out.println("Total is    "+total);
		%>
			<tr>
			<td class="text-center"><%=i %></td>
			<td class="text-center"><a href="#" onclick="viewInvoices('transactionDetails.jsp','<%=company %>','<%= salesinvoiceno%>')"><%=salesinvoiceno %></a></td>
			<td class="text-center"><%=rsInvoice.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsInvoice.getString("InvoiceDate")))%></td>
			<td class="text-left"><%=company%></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			<td class="text-left"><%=city%></td>
			</tr>
			
			
					<%
					i++;
	}
}	
%>

	<tr>
			<td class="text-center"><%=i %></td>
			<td style="font-size: 14px; face:san-serif; color:black" align="right">Total : </td>
			<td style="font-size: 14px; face:san-serif; color:black" align="right"><%=total %> Rs.</td>
			
			<td></td>
			<td></td>
			<td></td>
</tr>


</tbody>
 </table>
 </div>
<%
}
%>

<%// ******************************************************** INVOICES(All) ENDS HERE************************************************************* %>

<%
// *************************************************   FOR CANCELLED INVOICES STARTs HERE  *******************************************************

if("cancelledinvoices".equalsIgnoreCase(reportname))
{
if(null != request.getQueryString())
	{
	String condition="";
		%>
		<br>
		<div align="center"><h5 class="content-header-title text-center mb-0"
						style="color: #060637">CANCELLED INVOICES</h5></div>
		<br>
		<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
		<thead>
		<tr>
		<th class="col-width-4">Sr.No</th>
		<th>Sales Invoice REF NO</th>
		<th>Total Rs</th>
		<th>Generated On</th>
		<th>Company</th>
		<th>City</th>
		</tr>
		</thead>
		
		<tbody>
		<%
		String SqlInvoice="";
		
		if("alltypes".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.InvoiceCancelled=1 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.InvoiceCancelled=1 AND a.TheGroup=1 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.InvoiceCancelled=1 AND a.TheGroup=2 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.InvoiceCancelled=1 AND a.TheGroup=3 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.InvoiceCancelled=1 AND a.TheGroup=4 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.InvoiceCancelled=1 AND a.TheGroup>=5 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
		}
		
		else if("domestic".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.InvoiceCancelled=1 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=1 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=2 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=3 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=4 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType='Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup>=5 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
		}
		
		else if("export".equalsIgnoreCase(typesname))
		{
			if("All".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.InvoiceCancelled=1 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Compressor".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=1 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DGSet".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=2 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("DigitalEquipment".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=3 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else if("Endoscope".equalsIgnoreCase(selectedName))
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup=4 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
			else
			SqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b ON(a.InvoiceNo=b.InvoiceNo) WHERE a.CurrType <> 'Rupees' AND a.InvoiceCancelled=1 AND a.TheGroup>=5 AND a.InvoiceDate BETWEEN '"+dt+"' AND '"+dt1+"' GROUP BY a.InvoiceNo, a.Total,a.InvoiceDate,a.CompanyName, a.city   ";
		}	
		System.out.println(SqlInvoice);	
		ResultSet rsInvoice=st.executeQuery(SqlInvoice);
		int i=1;
		while(rsInvoice.next())
			{
			String city  = rsInvoice.getString("city");
			String salesinvoiceno=rsInvoice.getString("invoiceRefNo");
			String company=rsInvoice.getString("CompanyName");
		%>
			<tr>
			<td class="text-center"><%=i %></td>
			<td class="text-center"><a href="#" onclick="viewInvoices('transactionDetails.jsp','<%= company%>','<%=salesinvoiceno%>')"><%=salesinvoiceno %></a></td>
			<td class="text-center"><%=rsInvoice.getString("Total") %></td>
			<td  class="text-right"><%=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsInvoice.getString("InvoiceDate")))%></td>
			<td class="text-left"><%=company %></td>
			<%
			if(city.contains("null")|| city.isEmpty() || city.contains("Select")){
				city= "-";
			}
			%>
			<td class="text-left"><%=city %></td>
			</tr>
		<%
		i++;
	}
}	
%>
</tbody>
 </table>
 </div>
<%
}
%>


<%// ******************************************************** CANCELLED INVOICES ENDS HERE************************************************************* %>
	
	
	<br>
	<%
	} catch (Exception e) {
	System.out.println("Exception " + e);
	}

	%>
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
	                         title: 'the <%=reportname %> from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'the <%=reportname %> from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'the <%=reportname %> from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'the <%=reportname %> from '+$("#data").val()+ ' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'the <%=reportname %> from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script type="text/javascript" >
	function viewDetails(Address,transactionId,company,condition)
	{ 
		if(Address=="SEDetails.jsp")
			window.open(Address+'?transactionId='+transactionId+'&company='+company+'&condition=view','jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		else	
	    	window.open(Address+'?transactionId='+transactionId+'&company='+company+'&condition='+null,'jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
	}

	function viewQuotation(Address,company,salesquono)
	{ 
	    window.open(Address+'?company='+company+'&salesQuotation='+salesquono+'&condition=View','jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
	}

	function viewOrder(Address,company,salesorderno)
	{ 
		if(Address=="viewOrder.jsp")
			window.open(Address+'?salesOrder='+salesorderno+'&condition=View','jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		else
			window.open(Address+'?company='+company+'&salesOrder='+salesorderno+'&condition=view','jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
	}

	function viewInvoices(Address,company,salesinvoiceno)
	{ 
	    window.open(Address+'?company='+company+'&transactionId='+salesinvoiceno,'jav','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
	}	
</script>

	<%@ include file="footer.jsp"%>
</body>
</html>