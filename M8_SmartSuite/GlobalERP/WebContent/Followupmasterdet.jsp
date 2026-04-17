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
    <style>
a:visited {
    color:  #FFFFFF;
}
</style>
</head>
<body style="background-color:azure;">  	                                                                                                             
<%
	Connection conn = null;
	Statement st1 = null, st2 = null;
	
	try {

		conn = connection.getConnect("db_GlobalERP");    
		st1 = conn.createStatement();
	    st2 = conn.createStatement();	    
	   
	} catch (Exception e) {
	    e.printStackTrace();
	} 
	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="";
%>
<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	System.out.println("FROM DATE IS"+fromDate);
	System.out.println("Target DATE IS"+toDate);
	 
	if (!(null == request.getParameter("from"))) {
		fromDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("from")));
		fromDateCal=request.getParameter("from");
	}
	if (!(null == request.getParameter("to"))){
		toDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("to")));
		toDateCal=request.getParameter("to");
	}
	System.out.println("AAAAAAAAAAAAAAAAA");	
	
try {
	
	String compName="";
	String collectstf="";
	String from="";
	String to="";
	String ftype="";
	System.out.println("aaaaaaaaaaaaaaaaa");
		if(request.getParameter("collect")==null)
		{
			collectstf="";		
		}else
		{
		collectstf=request.getParameter("collect");
		}
		
		if(request.getParameter("cmpName")==null)
		{
			compName="All";
		}else
		{
			compName=request.getParameter("cmpName");
		}
	
	from=request.getParameter("from").trim();
	to=request.getParameter("to");
	ftype=request.getParameter("ftype");
	%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
    <%if(collectstf!=null && collectstf!=""){%>
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Follow-Up Report For <%=collectstf%> From <%=fromDateCal%> To <%=toDateCal%></h5>
    <%}else{%>      
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Follow-Up Report For <%=compName%> From <%=fromDateCal%> To <%=toDateCal%></h5>
   <%}%>
    </div>
</div>
<input type="hidden" id="compId" value=<%=session.getAttribute("CompanyMasterID").toString()%>>
<input type="hidden" id="from" value=<%=fromDate%>>
<input type="hidden" id="to" value=<%=toDate%>>
<br>

<form  name="data1"id="data1" method="post" name="">
<%
 if(null != request.getQueryString())
{
%>
<table id="example" class="display" style="width:100%;">
	<thead>
	<tr>
		<th class="col-width-4">SrNo.</th>
		<th>Company Name</th>
		<th>Date</th>
		<th>Status</th>
		<th>Type</th>
		<th>Subject</th>
		<th>Comments</th>
		<th>Marketing Representative</th>
		<th>Contact Person</th>
		<th>Spoken To</th>
		<th>Collection Staff</th>
		<th>Remark</th>
		<th>Next Follow-up</th>
		<th>Next Follow-up Type
		<th>Docs</th>
	</tr>
	</thead>
	<tbody>
	<%
	int k=1;
	String RepName="";
	PreparedStatement pst=null;
	if(collectstf!=null && collectstf!="" && compName=="All")
	{
	pst=conn.prepareStatement("SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE ColloectionStaffName='"+collectstf+"' and FollowUpDate between '"+from+"' and '"+to+"' and FollowUpType='"+ftype+"'");
	}else
	{
		pst=conn.prepareStatement("SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE ProspCustName='"+compName+"' and FollowUpDate between '"+from+"' and '"+to+"' and FollowUpType='"+ftype+"'");	
	}
	
	ResultSet rs=pst.executeQuery();
	System.out.println("Followup Query Is"+pst.toString());
	while(rs.next())
	{
		PreparedStatement pst1=conn.prepareStatement("SELECT  EmpName  FROM  "+session.getAttribute("CompanyMasterID").toString()+"security   WHERE EmpCode='"+rs.getString("MarketingRepcode")+"' ");	
		System.out.println("while loop ::: "+pst1.toString());
		ResultSet rs1=pst1.executeQuery();
	if(rs1.next())
	{
		RepName=rs1.getString(1);
		%>
		
	<tr>
	<td class="text-center"><%=k%></td>
	<td class="text-left"><%=rs.getString("ProspCustName")%></td>
	<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("FollowUpDate")))%></td>
	<td class="text-left"><%=rs.getString("Status") %></td>
	<td class="text-left"><%=rs.getString("FollowUpType") %></td>
	<td class="text-left"><%=rs.getString("FollowUpSubject")%></td>
	<td class="text-left"><%=rs.getString("Comments")%></td>		
	<td class="text-left"><%=RepName%></td>
	<td class="text-left"><%=rs.getString("ContactPerson")%></td>
	<td class="text-left"><%=rs.getString("SpokenTo") %></td>
	<td class="text-left"><%=rs.getString("ColloectionStaffName")%></td>			
	<td class="text-left"><%=rs.getString("Remarks") %></td>
	<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("NextFollowUpDate")))%></td>			
	<td class="text-left"><%=rs.getString("NextFollowUpType") %></td>
	<%
	
	
	String Docs = rs.getString("DocumentName");
	String DocPath = System.getenv("FollowUp_FilePath");
	//String DocPath="/home/javaprg/followup/";
	System.out.println("DocPath::: "+DocPath);
	if(Docs == null || Docs.trim().isEmpty()) {
	%>
	    <td class="text-center">-</td>
	<%
	} else {

	    if(Docs.length() > 1){
	        Docs = Docs.substring(1);
	    }

	    DocPath = DocPath + Docs;
	    System.out.println("path:-"+DocPath);
	    
	    String publicURL = DocPath.replace("/var/www/html", "https://twtech.in");
	%>
	    <td class="text-center">
	    <a href="<%=publicURL + java.net.URLEncoder.encode(Docs,"UTF-8")%>" target="_blank"><%=Docs%>
</a>
	       <%--  <a href="Downloadfollowupattachment.jsp?filename=<%=Docs%>"><%=Docs%></a> --%>
	    </td>
	<%
	}
	}
	k++;
	}
%>	
	</tr>
	</tbody>
	</table>	
<%}
else{ %>

	 <div id="message" style="display:none; color: red;">Data Is Loading Please Wait..... </div>
	<div id="data"></div> 
	
<%
}
}catch (Exception e) {
	e.printStackTrace();
}
%>
</form>
</div>

<script>  
function showVisitingCardDetails(companyName,customerCode){
	alert(companyName);
	document.getElementById("companyNames").value=companyName;
	document.getElementById("companyList").style.display='none';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	document.getElementById("companyNames").value='';
}

function getCompanies(type)
{
	document.getElementById("companyList").style.display='block';
	var company=document.getElementById("companyNames").value;
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
	var queryString = "?company=" +company+"&type="+type+"&limitcount=20";
	ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}


function openInvoice(Address,InvoiceRefNo,Invoiceno,condition,status,name)
 {//alert("ssss"+status+"  "+name+""); 
    
	if(status=="Closed")
	{alert("This Invoice is closed by "+name);	
	}	
	window.open(Address+'?InvoiceRefNo='+InvoiceRefNo+'&Invoiceno='+Invoiceno+'&condition='+condition+" ");
	
}

function getCustomerInfo(type, code) 
{
	
	if(type == "" || type==null)
	{
		alert("Error  ");
	}
	else
	{

	document.getElementById("companyList").style.visibility="hidden";
/* 	document.getElementById("comlist").style.display="none"; */
	
	
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

	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			
			var reslt = ajaxRequest.responseText;

			reslt=reslt.replace(/^\s+|\s+$/g,""," ");
			
			if(reslt == "NO")
			{
				alert(" Data Not Available");
				 document.getElementById("CompanyCount").innerHTML = "";
				 document.addFolloUp.companyNames.value="";
				 document.addFolloUp.companyNames.value=""; 
					document.addFolloUp.companyCode.value="";
					document.addFolloUp.companyEnteredBy.value="";
					document.addFolloUp.companyCity.value="";
					document.addFolloUp.oct.value="--";
					document.addFolloUp.companyPhoneNumber.value="";
					document.addFolloUp.companyProduct.value="";
					document.addFolloUp.companyContactPerson.value="";
					document.addFolloUp.companyEmail.value="";
					document.addFolloUp.companyfax.value="";
					document.addFolloUp.companyWebSite.value="";
					document.addFolloUp.companyProduct.value=""; 
					document.addFolloUp.customerWeeklyOff.value="";
					document.addFolloUp.custType.value="";
					document.addFolloUp.assignedBy.value="";
					document.addFolloUp.leadRef.value="";
					document.addFolloUp.addedOnDate.value="";
			}else
			{
				
			document.getElementById("tempList").innerHTML = reslt;
			getCustomerDetails();
			
			}
			
			
		}
		
	}
	var queryString = "?code=" +code+"&type="+type;
	ajaxRequest.open("GET", "AjaxGetCustomerInfo.jsp" + queryString, true);
	 
	ajaxRequest.send(null);
	}//end of else
}


function getCustomerDetails() 
{
	
	try{
		
		document.getElementById("companyNames").innerHTML=document.getElementById("Name").value;
		document.getElementById("companyNames").value =document.getElementById("Name").value; 
		document.addFolloUp.companyCode.value=document.getElementById("Code").value;
		document.addFolloUp.companyEnteredBy.value=document.getElementById("RepName").value;
		document.addFolloUp.companyCity.value=document.getElementById("City").value;
		/* alert(document.getElementById("oct1").value); */
		document.addFolloUp.oct.value=document.getElementById("oct1").value;
		
		document.addFolloUp.companyPhoneNumber.value=document.getElementById("MobileNo").value;
		document.addFolloUp.companyProduct.value=document.getElementById("IntrestedProduct").value;
		document.addFolloUp.companyContactPerson.value=document.getElementById("ContactPerson").value;
		document.addFolloUp.companyEmail.value=document.getElementById("Email").value;
		document.addFolloUp.companyfax.value=document.getElementById("Fax").value;
		document.addFolloUp.companyWebSite.value=document.getElementById("WebSite").value;
		document.addFolloUp.companyProduct.value=document.getElementById("IntrestedProduct").value; 
		document.addFolloUp.customerWeeklyOff.value=document.getElementById("WeeklyOff").value;
		document.addFolloUp.custType.value=document.getElementById("custtype").value;
		
		document.addFolloUp.assignedBy.value=document.getElementById("assignby").value;
		document.addFolloUp.leadRef.value=document.getElementById("leadref").value;
		document.addFolloUp.addedOnDate.value=document.getElementById("addedondate").value;
		
	}catch(e)
	{
		//alert(e);
	}
		
		var cctype=document.addFolloUp.custType.value;
		var company=document.addFolloUp.companyCode.value;
		var companyName=document.addFolloUp.companyNames.value;
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
				var mySplitResult = reslt.split("#");
				/* alert(mySplitResult[0]);
				alert(mySplitResult[1]); */
				var tr=mySplitResult[0];
				var fl=mySplitResult[1];
				
				document.getElementById("tr").innerHTML=tr;
				document.getElementById("fl").innerHTML=fl;
			    document.getElementById("CompanyCount").innerHTML = mySplitResult[3];
				} 
		}
			
		var queryString = "?company="+company+"&companyName="+companyName+"&cctype="+cctype;
		ajaxRequest.open("GET", "AjaxGetTransactionDetails.jsp" + queryString, true);
		ajaxRequest.send(null); 

	}
	
	function getfollowup()
	{
		var compId=document.getElementById("compId").value;
		var companyNme=document.getElementById("companyNames").value;
		var fromdt=document.getElementById("from").value;
		var todt=document.getElementById("to").value;
		var queryString ="&fromdate="+fromdt+"&todate="+todt+"&CompId="+compId;
		if(companyNme=="")
		{
			companyNme="All";
			document.getElementById("myframe").src="http://164.68.105.216:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString+"&companyname="+companyNme+"&__showtitle=false";	
		}else
		{
			document.getElementById("myframe").src="http://164.68.105.216:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString+"&companyname="+companyNme+"&__showtitle=false";	
		}
	document.getElementById("footer").style.display="none";
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
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
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