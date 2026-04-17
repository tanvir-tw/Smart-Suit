<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""%>
<%@ include file="header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Purchase Quotation List Report</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 
<script src="dropdown.js" type="text/javascript"></script>
<script src="ledgerDetails.js" type="text/javascript"></script>



  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.colVis.min.js"></script>


<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        responsive:true,
	        scrollY:	"500px",
	        scrollX:true,
	        scrollCollapse:true,
	        
	        "columnDefs": [
	            {
	                "targets": [],
	                "visible": false,
	                "searchable": false
	            }],
	     
	        
	        
	        buttons: [
	        	
	        	
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Purchase Quotation List '+$("#fromdate").val()+'-To-'+$("#todate").val() , 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Purchase Quotation List '+$("#fromdate").val()+'-To-'+$("#todate").val() , 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Purchase Quotation List '+$("#fromdate").val()+'-To-'+$("#todate").val() , 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Purchase Quotation List '+$("#fromdate").val()+'-To-'+$("#todate").val() , 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Purchase Quotation List '+$("#fromdate").val()+'-To-'+$("#todate").val() , 
	                   },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	    
	    
	    
	    	
	    } );
	} );

</script>

<style>
th {
    text-align: center;
}
</style>
<script>	
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
             alert("From Date Should be Less Than To Date");
             return false; 
         }

         return true;
 	
 }
 
</script>

<script language="JavaScript1.2">


function showHideAll()
{
	if(document.ledgerDetails.checkAll.checked==true)
	{
		document.ledgerDetails.companyName.value="";
		document.ledgerDetails.companyPerson.value="";
		document.ledgerDetails.companyEmail.value="";
		document.ledgerDetails.companyCity.value="";
		document.ledgerDetails.companyProduct.value="";
		document.ledgerDetails.companyPhone.value="";
		document.getElementById('companyList').style.height = '10px'; 
		document.getElementById('companyList').style.visibility = 'hidden';
	}
	
}
	function getSupliers()
	{
		document.ledgerDetails.checkAll.checked=false;
		document.getElementById('suplierList').style.visibility = 'visible';
			var suplier=document.ledgerDetails.suplierNames.value;



			if(suplier=="")
			{
				document.getElementById('suplierList').style.visibility = 'hidden';
				
			}
			else
			{
				document.getElementById('suplierList').style.visibility = 'visible';
				suplier=suplier.replace(".", "");
				suplier=suplier.replace(",", "");
				suplier=suplier.replace("$", "");
				suplier=suplier.replace("#", "");
				suplier=suplier.replace("?", "");
				suplier=suplier.replace("-", "");
				suplier=suplier.replace("_", "");
				suplier=suplier.replace(" ", "");
				suplier=suplier.replace("(", "");
				suplier=suplier.replace(")", "");
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
					document.getElementById("suplierList").innerHTML=reslt;
				} 
			}
			var queryString = "?suplier=" +suplier;
			ajaxRequest.open("GET", "AjaxGetSuppliersList.jsp" + queryString, true);
			ajaxRequest.send(null);

			}//end of else 
		
	}
	
function sendSMS(){

	var ajaxRequest;  // The variable that makes Ajax possible!
	var company=document.ledgerDetails.companyName.value;
	var contact=document.ledgerDetails.companyPerson.value;
	var phone=document.ledgerDetails.companyPhone.value;
	var email=document.ledgerDetails.companyEmail.value;
	var product=document.ledgerDetails.companyProduct.value;
	var city=document.ledgerDetails.companyCity.value;
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
			//alert(reslt);
		}
	}
	var queryString = "?company=" +company+"&contact="+contact+"&phone="+phone+"&email="+email+"&city="+city+"&product="+product;
	ajaxRequest.open("GET", "AjaxSendSMS.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
	
	function showVisitingCardDetails(companyName) {
		document.getElementById('visitingCard').style.visibility='visible';
		document.ledgerDetails.companyNames.value='';
		document.getElementById('companyList').style.height = '10px'; 
		document.getElementById('companyList').style.visibility = 'hidden';

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

				var data=reslt.split("#");
				document.ledgerDetails.companyName.value=data[1];
				document.ledgerDetails.companyPerson.value=data[2];
				document.ledgerDetails.companyEmail.value=data[3];
				document.ledgerDetails.companyCity.value=data[4];
				document.ledgerDetails.companyProduct.value=data[5];
				document.ledgerDetails.companyPhone.value=data[6];
			}
		}
		var queryString = "?companyName=" +companyName;
		ajaxRequest.open("GET", "AjaxShowVisitingCard.jsp" + queryString, true);
		ajaxRequest.send(null); 

		 document.getElementById('tabS').style.visibility='hidden';
	}
	
	function newwindow(webadd)
	{ 
		if(document.ledgerDetails.companyName.value=="" || document.ledgerDetails.companyName.value==null)
			alert("Please select a company ");
		else
			window.open(webadd+'?email='+document.ledgerDetails.companyEmail.value+'&toDate='+document.ledgerDetails.todate.value+'&fromDate='+document.ledgerDetails.fromdate.value+'&company='+document.ledgerDetails.companyName.value,'jav','width=470,height=500,top=250,left=600,resizable=no');
		
	}
	
	function popUp(webadd,trancactionId,condition)
	{ 
		
			window.open(webadd+'?transactionId='+trancactionId+'&condition='+condition,'jav','width=870,height=500,top=150,left=250,resizable=no');
		
	}

	function newSMSwindow(weba)
	{ 
		if(document.ledgerDetails.companyName.value=='' || document.ledgerDetails.companyName.value==null)
			alert("Please select a company ");
		else
		window.open(weba+'?companyName='+document.ledgerDetails.companyName.value+'&email='+document.ledgerDetails.companyEmail.value+'&contactPerson='+document.ledgerDetails.companyPerson.value+'&companyPhone='+document.ledgerDetails.companyPhone.value+'&companyProduct='+document.ledgerDetails.companyProduct.value+'&companyCity='+document.ledgerDetails.companyCity.value,'jav','width=470,height=350,top=250,left=600,resizable=no');
	}

	function gotoPaymentEntry(webadd)
	{ 
 		
		var company=document.ledgerDetails.companyName.value;
		var companyPerson=document.ledgerDetails.companyPerson.value;
		var companyPhone=document.ledgerDetails.companyPhone.value;
		var companyEmail=document.ledgerDetails.companyEmail.value;
		var companyCity=document.ledgerDetails.companyCity.value;
		var companyProduct=document.ledgerDetails.companyProduct.value;
		
		window.location=webadd+'?companyName='+company+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct;
	}
	function showSelectedSuppliers(SuplierCode,SuplierName)
	{
		//alert(SuplierName);
		//alert(SuplierCode);
		document.ledgerDetails.suplierNames.value=SuplierName;
		//alert(document.ledgerDetails.suplierCode.value='');
		//alert("++++++++");
		document.getElementById('suplierList').style.visibility = 'hidden';
	}

	function gotoExcel (elemId, frmFldId)  
	{  
//		alert("*********** ");

	         var obj = document.getElementById(elemId);  

	         var oFld = document.getElementById(frmFldId); 

	          oFld.value = obj.innerHTML;  

	          document.purchasequo.action ="excel.jsp";     // CHANGE FORM NAME HERE

	          document.forms["purchasequo"].submit();       // CHANGE FORM NAME HERE

	} 
	 
	//if (document.all || document.getElementById)
		//document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>
</head>
<body>

<%!
Connection conn=null;
%>

	<%
	
	Class.forName(DB_Driver);
	conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

	String comid=session.getAttribute("CompanyMasterID").toString();
	
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			
			st = conn.createStatement();
			st1 = conn.createStatement();
			st2 = conn.createStatement();
			
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String companyName="",phone="",contact="",email="",product="",city="";
			
			String id=request.getParameter("id");
			System.out.println("ID CMING IS   ++++++++++++++          "+id);
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
	if (!(null == request.getParameter("fromdate"))) {
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	System.out.println(request.getParameter("checkAll"));
	System.out.println(request.getParameter("checkAll"));
	System.out.println(request.getParameter("checkAll"));
	System.out.println(request.getParameter("checkAll"));
	if (null == request.getParameter("checkAll") && null != request.getParameter("companyName"))
	{
		companyName=request.getParameter("companyName");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct"); 
	}	
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>
 
	
 <div align="center"><font size="4" color="black"><b> Purchase Quotation list</b></font></div>
 
<form name='ledgerDetails' action="" method="get" >
<input type="hidden" name="id" value="<%=id %>">                                                                                                                                                                                                                                                                                           

<table width="100%" border="0">
<tr><td></td>
<td></td><td></td><td colspan="3">
			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

<!-- 	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img> -->
	
<!-- 					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a> -->
			 
				</td>
		</tr></table>
	</td></tr>
		<tr>

							<td align="right" valign="top" width="50%;">
								<table><tr>
										<td align="right" valign="top">
		<input type="checkbox" id="checkAll" name="checkAll" checked="checked" onchange="showHideAll();" value="checkAll"/></td><td >All &nbsp;&nbsp;&nbsp;</td>
		 <td>
									<div id="suplierNames">Suplier Name: &nbsp;
									<input type="text" name="suplierNames" id="search-text" 
										  value=''  
										onkeyup="getSupliers()" /></div>

							</td></tr></table></td>
<!--							<td align="left" style="width: 250px;">-->
<!---->
<!---->
<!--							<div id='suplierList'>-->
<!--							<div style="height: 10px; width: 400px; overflow: auto;">-->
<!--							<table style="display: none;">-->
<!---->
<!--							</table>-->
<!---->
<!--							</div>-->
<!--							</div>-->
<!--							</td>-->

			<td align="left" valign="top" style="width: 50px;">
			 &nbsp;&nbsp;<b>From </b> </td><td align="left" valign="top" style="width: 50px;">
			<input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
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
 </td><td align="left" valign="top" style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left" valign="top" style="width: 80px;">
			 &nbsp;<input type="text" id="todate"
						name="todate" value="<%=toDateCal %>" size="15" readonly
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
			 </td><td align="left" valign="top">&nbsp;&nbsp;
	 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="Submit" onclick="return chk()" ></input></td>
				</tr>
				<tr>
				<div style="position: absolute;" >
	 <table style="margin-left: 38%;">
	 <tr><td>
	 <div id='suplierList'>
	 </div>
	 </td></tr>
	 </table>
	 </div>	
				</tr>
		<!-- 		<tr>
		<td align="right" valign="top">
								<table><tr>

		 <td>

							<div style="position: absolute;width: 400px;" >
	 <table>
	 <tr><td>
	 <div id='suplierList'>
	 </div>
	 </td></tr>
	 </table>
	 </div>				

							</td></tr></table></td>
		
<td></td>
<td></td><td></td></tr> -->
									
				
		
	</table>

</form>

<br></br>

<%
boolean isCheckedAll=false;
if(request.getParameter("suplierNames")!=null )
{
%> 
<%	

isCheckedAll=(request.getParameter("checkAll")!=null ? true : false);
String sqlDetails="",suplierCode="",openingBalance=null;

suplierCode=(request.getParameter("suplierNames")!=null ? request.getParameter("suplierNames") : "-");
 
 
}
%>
<%-- 
<form name="purchasequo" method="post" >

<%
<!-- String exportFileName="PurchaseQuotation_det.xls";   // GIVE YOUR REPORT NAME -->
<!-- %> -->
<!-- <div id='purchase'> -->

<!-- <input type="hidden" id="tableHTML" name="tableHTML" value="" />    -->

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

<!-- <div id="tabS" style="visibility: visible;"> -->
 
<!--  	<table border="1px"  class="sortable"> -->
<!-- 	<tr> -->
<!-- 		<th>Sr.No</th> -->
<!-- 		<th>PurQuo No</th> -->
<!-- 		<th>TW REF NO</th> -->
<!-- 		<th>PurQuoDate</th> -->
<!-- 		<th>Total</th> -->
<!-- 		<th>Currency</th> -->
<!-- 		<th>Supplier</th> -->
		
<!-- 	</tr> -->
	<%
	 


	
<!-- 	int i=1; -->
<!-- 					if(!isCheckedAll) -->
<!-- 							sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchasequo as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where b.SupplierName ='"+suplierCode+"' and a.PurQuoDate BETWEEN '"+fromDate+"' and '"+toDate+"' order by a.PurQuoDate Desc "; -->
<!-- 					else -->
<!-- 							sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchasequo  as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurQuoDate between '"+fromDate+"' and '"+toDate+"' order by a.PurQuoDate Desc "; -->
					
<!-- 					System.out.println(sqlDetails); -->
<!-- 					System.out.println(sqlDetails); -->
<!-- 					ResultSet rsDetails = st.executeQuery(sqlDetails); -->
<!-- 					while (rsDetails.next())  -->
<!-- 					{ -->
						
						
<!-- 	%> -->
<!-- 	<tr> -->
<!-- 		<td align="right"> -->
		<div align="right"> <%=i++ %></div>
<!-- 		</td> -->
				
<!-- 		<td> -->
<!-- 		<div align="right"> -->
		<a href="#" style="font-weight: bold;" onclick="popUp('PQDetails.jsp','<%=rsDetails.getString("PurQuoNo")%>','<%=id %>')">
			<%=rsDetails.getString("PurQuoNo")%></a>
<!-- 		 </div> -->
<!-- 		</td> -->
		<td><div align="right"><%=rsDetails.getString("TWRefNo")%></div></td>
		<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDetails.getString("PurQuoDate")))%></div>
<!-- 		</td> -->
		<td><div align="right"><%=rsDetails.getString("GrandTotal")%></div></td>
		<td><div align="left"><%=rsDetails.getString("CurrType")%></div></td>
		<td><div align="left"><%=rsDetails.getString("SupplierName")%></div></td>
<!-- 	</tr> -->
	<%
<!-- 		}if(i==1){ -->
<!-- 			%> -->
<!-- 			<tr><td colspan="12"> -->
<!-- 			NO DATA AVAILABLE -->
<!-- 			</td></tr>	 -->
			<%}
<!-- } -->
<!-- %> -->
<!-- </table> -->
<!-- </div> -->
<!-- </div> -->
<%if(request.getParameter("suplierNames")!=null && !isCheckedAll){ %>
<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http:// twdb.fleetview.in:8080/birt/frameset?__report=PurchaseQuotationList.rptdesign&fromdate=<%=fromDate %>&todate=<%=toDate %>&supplier=<%=request.getParameter("suplierNames")%>&companyid=<%= comid %>&condition=<%= id %>&__showtitle=false">
</iframe> 
</div>
<%}else{
	%>
	<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http:// twdb.fleetview.in:8080/birt/frameset?__report=PurchaseQuotationList.rptdesign&fromdate=<%=fromDate %>&todate=<%=toDate %>&supplier=All&condition=<%= id %>&companyid=<%= comid %>&__showtitle=false">
</iframe> 
</div>
<%} %>

</form>
	 --%>			
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1"> 

<thead>

<tr>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif; align:center;">SrNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PurQuoNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">TWRefNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SupplierCode</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PurQuoSupRefNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PurQuoDate</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">POGenerated</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GrandTotal</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">CurrType</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">CurrValue</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">ReasonForCancelling</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SupplierName</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">EnteredOn</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">IsDataValid</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">OurSupplier</th>
</tr>
</thead>
<tbody>
		<%
		
		String Bt=request.getParameter("submit");
		System.out.println("----------In Button-------------"+Bt);
				if(Bt==null)
				{}else{
		String Query="";
		String Sname=request.getParameter("suplierNames");
		
		String TWRefNo="",PurQuoSupRefNo="",PurQuoDate="",GrandTotal="";
		String CurrType="",CurrValue="",ReasonForCancelling="",SupplierName="",EnteredOn="";
		
		int PurQuoNo=0,POGenerated=0,SupplierCode=0,IsDataValid=0,OurSupplier=0;
		
		
		if(Sname!=null && !isCheckedAll){
			System.out.println("in if");
		 	Query="SELECT a.PurQuoNo,a.TWRefNo,a.SupplierCode,a.PurQuoSupRefNo,a.PurQuoDate,a.POGenerated,a.QuoReceived,Cast(a.GrandTotal as decimal(10,2)) as GrandTotal,a.CurrType,a.CurrValue,a.ReasonForCancelling,b.SupplierName,b.EnteredOn,b.IsDataValid,b.OurSupplier FROM  db_GlobalERP.100000purchasequo as a INNER JOIN db_GlobalERP.100000supplierdet as b on (a.Suppliercode = b.SupplierCode)  where a.PurQuoDate>='"+fromDate+"' AND a.PurQuoDate<='"+toDate+"' AND b.SupplierName='"+Sname+"' order by a.PurQuoDate desc";
		}

		else{
			System.out.println("in else");

		 	Query="SELECT a.PurQuoNo,a.TWRefNo,a.SupplierCode,a.PurQuoSupRefNo,a.PurQuoDate,a.POGenerated,a.QuoReceived,Cast(a.GrandTotal as decimal(10,2)) as GrandTotal,a.CurrType,a.CurrValue,a.ReasonForCancelling,b.SupplierName,b.EnteredOn,b.IsDataValid,b.OurSupplier FROM  db_GlobalERP.100000purchasequo as a INNER JOIN db_GlobalERP.100000supplierdet as b on (a.Suppliercode = b.SupplierCode)  where a.PurQuoDate>='"+fromDate+"' AND a.PurQuoDate<='"+toDate+"' AND b.SupplierName like '%%' order by a.PurQuoDate desc";

			
		}
			System.out.println("Query :-"+Query);
			
			ResultSet rs=st.executeQuery(Query);
			
			
			
			int i=1;
			if(rs.next())
				{
				PurQuoNo=rs.getInt("PurQuoNo");
				TWRefNo=rs.getString("TWRefNo");
				SupplierCode=rs.getInt("SupplierCode");
				PurQuoSupRefNo=rs.getString("PurQuoSupRefNo");
				PurQuoDate=rs.getString("PurQuoDate");
				POGenerated=rs.getInt("POGenerated");
				GrandTotal=rs.getString("GrandTotal");
				CurrType=rs.getString("CurrType");
				CurrValue=rs.getString("CurrValue");
				ReasonForCancelling=rs.getString("ReasonForCancelling");
				if(ReasonForCancelling==null || ReasonForCancelling.equalsIgnoreCase("null"))
				{
					ReasonForCancelling="-";
				}else{
					ReasonForCancelling=rs.getString("ReasonForCancelling");

				}
				SupplierName=rs.getString("SupplierName");
				EnteredOn=rs.getString("EnteredOn");
				IsDataValid=rs.getInt("IsDataValid");
				OurSupplier=rs.getInt("OurSupplier");

				
		%>
				<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
				<td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="PQDetails.jsp?transactionId=<%=PurQuoNo%>&condition=<%=id%>"><%=PurQuoNo%></a></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=TWRefNo%></td>
               <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=SupplierCode%></td> 
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PurQuoSupRefNo%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PurQuoDate%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=POGenerated%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=GrandTotal%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=CurrType%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=CurrValue%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ReasonForCancelling%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=SupplierName%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=EnteredOn%></td> 
               <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=IsDataValid%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=OurSupplier%></td>

				
				
				<%
				
				} 
				}
%>

	</body>
	</html>
<%-- <%@include file="footer_new.jsp"%>
 --%>