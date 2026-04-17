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
// Variable Declaration
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String id=request.getParameter("id");
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String sql1="",sql2="",sql3="",filename="",accountType="",status="",color="";

int pendingcount=0,Uploadedcount=0,cancelledcount=0;

 // Connection Initialization
Connection conn = null;
Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
Statement st2 = null;
ResultSet rsdata=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	   st = conn.createStatement();
	st1 = conn.createStatement();
	
	
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>                      	                                                                                                              

 <div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Net Banking Report</h5>
    </div>
</div>
 <form name="formreport" id="formreport" method="get">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				 <input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			 </div>
		<div class="col-md-2"></div>
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
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
	<br>
<div>
		
		<%
	String sqlCount="select sum(b.Amount) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles as a,"+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords as b where a.FileName1=b.FileName1 and  b.CreationDate between '"+dt+" 00:00:00' and '"+dt1+" 23:59:59' and a.UploadStatus='Pending'"+
	"UNION "+
	"select sum(b.Amount) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles as a,"+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords as b where a.FileName1=b.FileName1 and b.CreationDate between '"+dt+" 00:00:00' and '"+dt1+" 23:59:59' and a.UploadStatus='Uploaded'"+
	"UNION "+
	"select sum(b.Amount) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles as a,"+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords as b where a.FileName1=b.FileName1 and b.CreationDate between '"+dt+" 00:00:00' and '"+dt1+" 23:59:59' and a.UploadStatus='Cancelled'";
	ResultSet rscount=st1.executeQuery(sqlCount);
	System.out.println(sqlCount);
	if(rscount.next())
	pendingcount=rscount.getInt(1);
	if(rscount.next())
	Uploadedcount=rscount.getInt(1);
	if(rscount.next())
	cancelledcount=rscount.getInt(1);
			
	%>

		<div class="d-flex justify-content-start gap-4 fw-bold">
		  <span class="text-danger"> ● Pending - <%=pendingcount %> Rs</span>
		  <span class="text-success">● Uploaded - <%=Uploadedcount %> Rs</span>
		  <span class="text-warning">● Cancelled - <%=cancelledcount %> Rs</span>
	  </div>
</div>

<table id="example" class="display" style="width:100%;">  
<thead>
	<tr>
	<th >File Name</th>
	<th >Transaction Type</th>
	<th >Beneficiary Name</th>
	<th >Amount(In Rs.)</th>
	<th >Tally RefNo</th>
	<th >Created By</th>
	<th >Comments</th>
	<th >Status</th>
	</tr>
	</thead>
	<tbody>
<%   

try
{
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where CreationDate between '"+dt+" 00:00:00' and '"+dt1+" 23:59:59'";
	
}
catch(Exception e)
{
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where CreationDate between '"+dt+" 00:00:00' and '"+dt1+" 23:59:59'";
}
System.out.println(sql1);
rsdata=st.executeQuery(sql1);
while(rsdata.next())
{
	filename=rsdata.getString("FileName1") ;
	sql2="Select AccoutType,UploadStatus from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where FileName1='"+filename+"'";
	ResultSet rs2=st1.executeQuery(sql2);
	if(rs2.next())
	{
		accountType=rs2.getString("AccoutType");
		status=rs2.getString("UploadStatus");
	}
	else 
	{
		accountType="-";
		status="Pending";
	}

	if(status.equals("Pending")) {
	    color = "style='background-color:#FAAFBE !important;'";
	} else if(status.equals("Uploaded")) {
	    color = "style='background-color:#AEF8B1 !important;'";
	} else if(status.equals("Cancelled")) {
	    color = "style='background-color:#FFFF00 !important;'";
	} else {
	    color = "";
	}

%>
<tr <%=color %>>

<td class="text-left"><%=rsdata.getString("FileName1") %></td>
<td class="text-left"> <%=accountType %></td>
<td class="text-left"><%=rsdata.getString("BeneficiaryName") %></td>
<td class="text-center"><%=rsdata.getString("Amount") %></td>
<td class="text-center"><%=rsdata.getString("TallyRefNo") %></td>
<td class="text-left"><%=rsdata.getString("Createdby") %></td>
<td class="text-left"><%=rsdata.getString("Comments") %></td>
<td class="text-left"><%=status %></td>
</tr>

<%

}   // end of while  
%>
</tbody>
</table>
</div>
 <%

 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
<script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
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
								title: 'Net Bank Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Net Bank Report from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Net Bank Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Net Bank Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Net Bank Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script >
function showSelectedSuppliers(customerCode,companyName){
	document.data.companyNames.value=companyName;
	document.getElementById("companyList").style.display='none';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	document.data.companyNames.value='';
}

function getCompanies()
{
	document.getElementById("companyList").style.display='block';
	var company=document.data.companyNames.value;
	var ajaxRequest;  // The variable that makes Ajax possible!

	try{
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

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("companyList").innerHTML=reslt;
		} 
	}
	var queryString = "?company=" +company;
	ajaxRequest.open("GET", "AjaxGetSupplierForEnquiry.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
function popUp(Address,supplierCode,PONo,GRNNo)
{ 
    window.open(Address+'?supplierCode='+supplierCode+'&PONo='+PONo+'&GRNNo='+GRNNo);
}
</script>

<%@ include file="footer.jsp" %>
 </body>
</html>