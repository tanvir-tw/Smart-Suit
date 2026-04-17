<!DOCTYPE html>
<html>
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
 
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.1/css/responsive.dataTables.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
 --><link rel="stylesheet" href="css/styleMakePlan.css">
<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script type="text/javascript" src="//cdn.datatables.net/plug-ins/1.10.19/sorting/date-dd-MMM-yyyy.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/plug-ins/1.10.19/sorting/datetime-moment.js"></script>

 
<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
  	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        responsive:true,
	        scrollY:	"500px",
	        scrollX:true,
	        scrollCollapse:true,
	        
	        
	        
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Billing Profile Summary of '+$("#custname").val(), 
	                        
	                        
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Billing Profile Summary of '+$("#custname").val(),
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Billing Profile Summary of '+$("#custname").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Billing Profile Summary of '+$("#custname").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Billing Profile Summary of '+$("#custname").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1,10, 25, 50, 100], ["All",10, 25, 50, 100 ]],
	        
	    	
	    	
	    	
	    } );
	} );


</script>

<script type="text/javascript">
function showVisitingCardDetails(companyName,customerCode){
	alert(companyName);
	document.getElementById("companyNames").value=companyName;
	document.getElementById("companyList").style.display='none';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	/* document.data.companyNames.value=''; */
	document.getElementById("companyNames").value='';
}

function getCompanies(type)
{
	//document.getElementById("companyList").style.display='block';
	var company=document.getElementById("companyNames").value;
	company=company.replace("...","&");
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
		//document.getElementById("companyList").style.visibility="hidden";
		//document.getElementById("comlist").style.display="none";
		//alert("NM"+document.getElementById("Name").value);
		
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
				//document.getElementById("cctype").value=cctype;
				//alert(document.getElementById("cctype").value);
		var company=document.addFolloUp.companyCode.value;
		var companyName=document.addFolloUp.companyNames.value;
		companyName=companyName("...","&");
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
				
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				var mySplitResult = reslt.split("#");
				/* alert(mySplitResult[0]);
				alert(mySplitResult[1]); */
				var tr=mySplitResult[0];
				var fl=mySplitResult[1];
				
				document.getElementById("tr").innerHTML=tr;
				document.getElementById("fl").innerHTML=fl;
				//document.getElementById("companydocuments").innerHTML=mySplitResult[2];
				//alert(reslt);
				//alert(document.getElementById("ContactCount").innerHTML=mySplitResult[3]);
			    document.getElementById("CompanyCount").innerHTML = mySplitResult[3];
				//document.getElementById("CompanyCount").value = mySplitResult[3];
				} 
		}
			
		var queryString = "?company="+company+"&companyName="+companyName+"&cctype="+cctype;
		ajaxRequest.open("GET", "AjaxGetTransactionDetails.jsp" + queryString, true);
		ajaxRequest.send(null); 

	}
function getfollowup()
{
	/* alert("hiiiiiiiiii"); */
	var a=chk();
	if(a==true)
	{
		
	
	var compId=document.getElementById("compId").value;
	var companyNme=document.getElementById("companyNames").value;
	companyNme=companyNme.replace("...","&");
	
	if(companyNme==" " || companyNme==null || companyNme=="")
		{
		companyNme="All";
		}
	
	/* alert("Company"+companyNme); */
	var fromdt=document.getElementById("from").value;
	var todt=document.getElementById("to").value;
	var dt=document.getElementById("fromdate").value;
	var dt1=document.getElementById("todate").value;
	/* alert("To Date"+todt); */
	var queryString ="&fromdate="+fromdt+"&todate="+todt+"&CompId="+compId;
	/* alert("Query String Is"+queryString); */
	if(companyNme=="" || companyNme==" " ) 
	{
		companyNme="All";
		/* alert("compnay Name==============="+companyNme); */
		/* document.getElementById("myframe").src="http://twtech.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString+"&companyname="+companyNme+"&dt="+dt+"&dt1="+dt1+"&__showtitle=false";	
		 *///alert("compnay Name==============="+companyNme);
	}else
	{
		/* document.getElementById("myframe").src="http://twtech.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString+"&companyname="+companyNme+"&dt="+dt+"&dt1="+dt1+"&__showtitle=false";	
 */	}
	
	//var queryString ="?companyname="+companyNme+"&fromdate="+from+"&todate="+to+"";
	document.getElementById("footer").style.display="none";
	/* 	//document.getElementById("reportData").style.display="";

if(companyNme==""){
	document.getElementById("myframe").src="http:// twdb.fleetview.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString;
	return false;
}else{
//http:// twdb.fleetview.in:8080/birt/frameset?__report=payment_report.rptdesign 
 document.getElementById("myframe").src="http:// twdb.fleetview.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign"+queryString;
//document.getElementById('myIframe').src = "http:// twdb.fleetview.in:8080/birt/frameset?__report=payment_report.rptdesign&_title='My Viewer'&date1="+date1+"&date2="+date2+"&cmpName="+supname+"&id="+id;
 document.getElementById("reportData").style.display=""; 
	} */

return true;
	
	}

else
	{
		return false;
	}

}


 function chk()
 {

 	
 	
 	var chkf="";
 	var chkt="";
 	var objFromDate = document.getElementById("fromdate").value;
 	
 	
 	var fdate=objFromDate.split("-");
 	if(fdate[1]=="Jan")
 	{
 		chkf="01";
 	}
 	if(fdate[1]=="Feb")
 	{
 		chkf="02";
 	}
 	if(fdate[1]=="Mar")
 	{
 		chkf="03";
 	}
 	if(fdate[1]=="Apr")
 	{
 		chkf="04";
 	}
 	if(fdate[1]=="May")
 	{
 		chkf="05";
 	}
 	if(fdate[1]=="Jun")
 	{
 		chkf="06";
 	}
 	if(fdate[1]=="Jul")
 	{
 		chkf="07";
 	}
 	if(fdate[1]=="Aug")
 	{
 		chkf="08";
 	}
 	if(fdate[1]=="Sep")
 	{
 		chkf="09";
 	}
 	if(fdate[1]=="Oct")
 	{
 		chkf="10";
 	}
 	if(fdate[1]=="Nov")
 	{
 		chkf="11";
 	}
 	if(fdate[1]=="Dec")
 	{
 		chkf="12";
 	}
 	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
     var objToDate = document.getElementById("todate").value;
     var tdate=objToDate.split("-");
     if(tdate[1]=="Jan")
 	{
     	chkt="01";
 	}
 	if(tdate[1]=="Feb")
 	{
 		chkt="02";
 	}
 	if(tdate[1]=="Mar")
 	{
 		chkt="03";
 	}
 	if(tdate[1]=="Apr")
 	{
 		chkt="04";
 	}
 	if(tdate[1]=="May")
 	{
 		chkt="05";
 	}
 	if(tdate[1]=="Jun")
 	{
 		chkt="06";
 	}
 	if(tdate[1]=="Jul")
 	{
 		chkt="07";
 	}
 	if(tdate[1]=="Aug")
 	{
 		chkt="08";
 	}
 	if(tdate[1]=="Sep")
 	{
 		chkt="09";
 	}
 	if(tdate[1]=="Oct")
 	{
 		chkt="10";
 	}
 	if(tdate[1]=="Nov")
 	{
 		chkt="11";
 	}
 	if(tdate[1]=="Dec")
 	{
 		chkt="12";
 	}
     var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
    // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
      
     var date1 = new Date(objFromDate1);
     var date2 = new Date(objToDate1);
     
     //alert("from > "+date1+" Todate > "+date2);
     
     var date3 = new Date();
     var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
     var currentDate = new Date(date4);
      
         if(date1 > date2)
         {
             swal("From Date Should be Less Than To Date");
             return false; 
         }
//          else if(date1 > currentDate)
//          {
//              alert("From Date should be less than current date");
//              return false; 
//          }
//          else if(date2 > currentDate) 
//          {
//              alert("To Date should be less than current date");
//              return false; 
//          }

         return true;
 	
 }
 
</script>
<script type="text/javascript">

function Redirect()
{
	alert("CustomerCode Not Matches With Diary System ERP Code  ");
    window.location="home.jsp";
	
}
</script>

 <style>
/* visited link */
a:visited {
	color: #660066;
}
</style>       
 
   
</head>
<style type="text/css">
td.details-control {
    background: url('images/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('images/details_close.png') no-repeat center center;
}
</style>


 <body style="background-color: #FFFFFF;">
	                	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<% 

	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null,stcollect=null,stbranch=null;
	Statement st2 = null;
	String FollowUpType="",status="",sqlGroup="", collector="",branch="" ;
	 Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
 	  String fromDate="",toDate="",fromDateCal="",toDateCal="";
	
	String id="";
	String companyName="",customerType=" ",companyCode=" ";
	if (null == request.getParameter("companyName"))
		companyName = "";
		else
			companyName = request.getParameter("companyName").replace("~","&");
			customerType = request.getParameter("type");
			companyCode =  request.getParameter("companyCode");

			System.out.println("Company Name =======>"+companyName);
			System.out.println("customerType  =======>"+customerType);
			System.out.println("companyCode  =======>"+ companyCode);
	
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
	
	if (!(null == request.getParameter("fromdate"))) {
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3= conn.createStatement();
	stcollect= conn.createStatement();
	String name=request.getParameter("companyNames");
	
	int i=1;
	if(name=="" || name==" " || name==null)
	{
		name="All";
	}
	
	name=name.replace("...","&");

/* String Bt=request.getParameter("button");
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
	data1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data")));
data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data1")));




datex1 = request.getParameter("data");
datex2 = request.getParameter("data1");
}

System.out.println(" datex1 "+datex1+" datex2 "+datex2);


String dt = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(datex1));

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(datex2));

System.out.println(" dt :-  "+dt+" dt1 :-  "+dt1);

 */

/* String name=session.getAttribute("EmpName").toString();
String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
String dept = session.getAttribute("department").toString();
 */


/* String selected1=request.getParameter("dept"); */


%>

 <body onload=" return loading();" onkeydown="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >
  <div style="font-size:16px; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;"><font face="san-serif" color="#036" size="3">
	<a><b>Billing Profile Summary - <%=companyName%></b> </a></font></div>
<input type="hidden" id="custname" name="custname"  value="<%=companyName%>" readonly/>
<%-- <form name="data" method="" action="" >
 <input type="hidden" name="id" value="<%=id %>">
 	
 <div style="margin-top:0.2%;margin-left: 5%; ">
<table align="center"style="width:66%" cellspacing="10"> 
	<tr>
	
	<td >&nbsp; &nbsp;<b>Enter Company:</b>&nbsp;
	<input type="text" name="companyNames" id="companyNames" value="<%=name %>"style="width:250px; border-radius:0px;"  onkeyup="getCompanies('quotation');" /> 
	<div style="position: absolute;" >
	  <table>
	  	<tr><td></td>
	  	</tr>
		<tr><td>
			<div id='companyList' style="display: block; background-color: aliceblue;">
			</div></td>
		</tr>
	</table>
   </div>
</td> 

 <td align="left">
<b>From:</b>&nbsp;&nbsp;
<input type="text" id="fromdate" name="fromdate" value="<%=fromDateCal %>" size="15" readonly="readonly"
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 				
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
	<script type="text/javascript">
		Calendar.setup(
		{
		inputField  : "fromdate",         // ID of the input field
		ifFormat    : "%d-%b-%Y",     // the date format
		button      : "fromdate"       // ID of the button
		}
		);
	</script>
<b>To:</b>&nbsp;&nbsp;
<input type="text" id="todate" name="todate" value="<%=toDateCal %>" size="15" readonly="readonly"
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
<script type="text/javascript">
		Calendar.setup(
		{
		inputField  : "todate",         // ID of the input field
		ifFormat    : "%d-%b-%Y",    // the date format
		button      : "todate"       // ID of the button
		}
		);
</script>
</td>
<td style="font-size: 10px; face:san-serif; color:black" ><input type="submit" name="button" value="Submit" onclick="return chk(); getfollowup();" style="width: 78px;font-size: 12px; height: 24px; color:black"></td>
</tr>
 </table> 

</div>



</form> --%>

<input type="hidden" id="compId" value=<%=session.getAttribute("CompanyMasterID").toString()%>>
<input type="hidden" id="from" value=<%=fromDate%>>
<input type="hidden" id="to" value=<%=toDate%>>
<div align="right">
<tr><td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		</tr></div>

<div id='tempList' align="center" style="display: none;">						
</div>
<div id="reportData">	
<%
String compName="";

if(null!=request.getParameter("companyNames")&&""!=request.getParameter("companyNames"))
{
	compName=request.getParameter("companyNames");
	//compName=compName.replace("&","...");
	compName=compName.replace("...","&");

	compName=compName.replace("&","%26");
	
%>
<%-- <iframe id="myframe" style="width: 1295px; height: 500px;" src="http://twtech.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign&fromdate=<%=fromDate%>&todate=<%=toDate%>&companyname=<%=compName%>&CompId=<%=session.getAttribute("CompanyMasterID").toString()%>&dt=<%=fromDateCal %>&dt1=<%=toDateCal%>&__showtitle=false"></iframe>	

 --%>
 
 <%}else{
	
	if(compName=="" || compName==" ")
	{
		compName="All";
	}
	System.out.println("*******************************************");
%>
<%-- <iframe id="myframe" style="width: 1295px; height: 500px;" src="http://twtech.in:8080/birt/frameset?__report=Followup_Master_Report.rptdesign&fromdate=<%=fromDate%>&todate=<%=toDate%>&companyname=<%=compName%>&CompId=<%=session.getAttribute("CompanyMasterID").toString()%>&dt=<%=fromDateCal %>&dt1=<%=toDateCal%>&__showtitle=false"></iframe>
 --%>
<%}%>
</div>

<div class="form">

<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">
        <thead style="background-color: #8596FA;" align="center">
            <tr>
                <th style="font-size: 12px; color: white; align:center;">Sr.No</th>
            	
            	<th style="font-size: 12px; color: white; align:center;">Customer</th>
            	<th style="font-size: 12px; color: white; align:center;">ERPCode</th>
                <th style="font-size: 12px; color: white; align:center;">category</th>
                <th style="font-size: 12px; color: white; align:center;">CustomerType</th>
        		
                <th style="font-size: 12px; color: white; align:center;">Rate </th>
                 <th style="font-size: 12px; color: white; align:center;">Frequency </th>
                   <th style="font-size: 12px; color: white; align:center;">BillType </th>
                     <th style="font-size: 12px; color: white; align:center;">ToId </th>
                       <th style="font-size: 12px; color: white; align:center;">ToCc</th>
                       <th style="font-size: 12px; color: white; align:center;">BillStatus</th>
                       <th style="font-size: 12px; color: white; align:center;">OperationalStatus </th>
                        <th style="font-size: 12px; color: white; align:center;">Edit </th>
                                     
            <!-- 	<th <th style="font-size: 12px; color: white; align:center;">NextFollowUpType   </th>
                       style="font-size: 12px;">Status</th> -->
                
                    
            </tr>
            
        </thead>
        <tbody>
      
	<%
	
	String data="";
    
	/* String data="select a.opportunityname,a.ProspCustName,date_format(a.FollowUpDate,'%d-%b-%Y') as FollowUpDate, a.Status, a.FollowUpType, a.FollowUpSubject, a.Comments, a.ContactPerson, a.SpokenTo, a.ColloectionStaffName, a.Remarks,date_format(a.NextFollowUpDate,'%d-%b-%Y') as NextFollowUpDate, a.NextFollowUpType, b.MarketingRepName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup as a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster as b on b.MarketingRepCode=a.MarketingRepcode where a.FollowUpDate between '2018-01-01 00:00:00' and '2018-02-01 00:00:00'  and a.ProspCustName like '%%'"; 
 */
	 if(fromDateCal==null)
     { 
   	   data = "select TypeValue as Customer,ERPCode,category,CustomerType,ERPTransporterRate as Rate ,BillFrequency as Frequency,BillType,ToId,ToCc,BillStatus,OperationalStatus from db_gps.t_transporter  where ERPCode="+companyCode+"";

   	  }
	 else
   	  {
      	   data = "select TypeValue as Customer,ERPCode,category,CustomerType,ERPTransporterRate as Rate ,BillFrequency as Frequency,BillType,ToId,ToCc,BillStatus,OperationalStatus from db_gps.t_transporter  where ERPCode="+companyCode+"";

   		  }
	
String Customer1=" ";
String ERPCode1=" ";
String category1=" ";
String CustomerType1=" ";
String Rate1=" ";
String Frequency1=" ";
String BillType1=" ";
String ToId1=" ";
String ToCc1=" ";
String BillStatus1=" ";
String OperationalStatus1=" ";

	System.out.println("check-------->"+data);
	Statement st21=conn.createStatement();
	ResultSet rs21=st21.executeQuery(data);
	if(rs21.next())
	{
	try{
		
		Customer1=rs21.getString("Customer");
		ERPCode1=rs21.getString("ERPCode");
		category1=rs21.getString("category");
		CustomerType1=rs21.getString("CustomerType");
		Rate1=rs21.getString("Rate");
		Frequency1=rs21.getString("Frequency");
		BillType1=rs21.getString("BillType");
		ToId1=rs21.getString("ToId");
		ToCc1=rs21.getString("ToCc");
		BillStatus1=rs21.getString("BillStatus");
		OperationalStatus1=rs21.getString("OperationalStatus");
			%>
	
			<tr>		          
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Customer1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ERPCode1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=category1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=CustomerType1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Rate1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Frequency1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=BillType1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=ToId1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=ToCc1%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=BillStatus1%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=OperationalStatus1%></td>
	  <td style="font-size: 11px; face:san-serif; color:black" align="left"><a href="EditbillingDetails.jsp?companyCode=<%=companyCode%>"  style="font-size: 11px; face:san-serif; color:blue" target="_blank"><%="Edit Details"%></a></td>    
            </tr>
            
   <%
i++;

	
%>  
    
   <%
	}catch (Exception e) {
	e.printStackTrace();
} 
	}
	else
	{
		out.println("<script>  Redirect();</script>");
	}
		
%>      
        </tbody>
      
    </table>
   
  
    </div>
    
    


<!-- </table> -->

<!--  </div> -->



<%
	}catch (Exception e) {
	e.printStackTrace();
}
%>
</body>
</body>
</jsp:useBean>
</html>
<!-- <div id="footer" class="row" style="margin-top: 35; ">
	<p><a href="http://www.myfleetview.com">Copyright &copy; 2009-15 By Transworld Technologies Ltd. All Rights Reserved.</a></p>
	</div> -->
<%-- <div id="footer" style="margin-top: 35%"> 

<%@include file="footer_new.jsp" %>
</div> --%>