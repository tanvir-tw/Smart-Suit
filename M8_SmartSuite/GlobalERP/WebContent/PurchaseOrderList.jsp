<%--  --%>

<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
 
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<html>
<head>

<%@ include file="header.jsp"%>

<script src="dropdown.js" type="text/javascript"></script>
<script src="ledgerDetails.js" type="text/javascript"></script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css ">
	
<script type="text/javascript" src="datatablejs/bootstrap.js"></script>

<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js "></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js "></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js "></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js "></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js "></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>

<script type="text/javascript" src="datatablejs/buttons.colVis.min.js"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#example')
								.DataTable(
										{
											//	"pagingType": "full_numbers",

											dom : 'Blfrtip',
											"bLengthChange" : false,
											buttons : [

													{
														extend : 'collection',

														text : 'Export',
														buttons : [
																{
																	extend : 'excel',
																	title : 'Purchase Order List Report '+ $("#fromdate").val()+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'pdf',
																	orientation : 'landscape',
																	pageSize : 'LEGAL',
																	title : 'Purchase Order List Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'csv',
																	title : 'Purchase Order List Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'print',
																	title : 'Purchase Order List Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'copy',
																	title : 'Purchase Order List Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},

														/* 'copy', 'csv', 'excel', 'pdf', 'print' */

														]
													},

													'colvis', 'pageLength' ],

											"oLanguage" : {
												"sSearch" : "Search"
											},

											lengthMenu : [
													[ 10, 25, 50, -1 ],
													[ '10 Rows', '25 Rows',
															'50 Rows',
															'Show all' ],

											],

											"aoColumns" : [ null, null, {
												"sType" : "date-uk"
											}, null, null, null, null

											]
										});
					});
	jQuery.extend(jQuery.fn.dataTableExt.oSort, {
		"date-uk-pre" : function(a) {
			var ukDatea = a.split('/');
			return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
		},

		"date-uk-asc" : function(a, b) {
			return ((a < b) ? -1 : ((a > b) ? 1 : 0));
		},

		"date-uk-desc" : function(a, b) {
			return ((a < b) ? 1 : ((a > b) ? -1 : 0));
		}
	});
</script>

<script>

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

	function gotoExcel (elemId, frmFldId)  
	{  
         //alert("*********** ");
	         var obj = document.getElementById(elemId);  

	         var oFld = document.getElementById(frmFldId); 

	          oFld.value = obj.innerHTML;  

	          document.purchaseord.action ="excel.jsp";     // CHANGE FORM NAME HERE

	          document.forms["purchaseord"].submit();       // CHANGE FORM NAME HERE
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
	 
	if (document.all || document.getElementById)
		document.body.style.background = "  white top no-repeat "
</script>
</head>

<% 
Connection con=null ;
	//erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			Class.forName(DB_Driver);
			con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			st3=con.createStatement();
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
		try {
				/* conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement(); */
			} catch (Exception e) {
			}
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>

<body>
<br>
<br>
<div
		style="font-size: 1.7em; text-align: center;"><a> 

		 Purchase Order list </a>
 </div><br></br>
<form name='ledgerDetails' action="" method="get" >
<input type="hidden" name="id" value="<%=id %>">


                                                                                                                                                                                                                                                                                              

<table width="100%" border="0">

		<tr>

							<td align="right" valign="top" >
								<table><tr>
										<td align="right" valign="top">
		<input type="checkbox" id="checkAll" name="checkAll" checked="checked" onchange="showHideAll();" value="checkAll"/></td><td >All &nbsp;&nbsp;&nbsp;</td>
		 <td>
									<div id="suplierNames">Suplier Name: &nbsp;
									<input type="text" name="suplierNames" id="search-text" 
										  value=''  
										onkeyup="getSupliers()" /></div>

							</td></tr></table></td>

			<td align="left" valign="top" style="width: 50px;">
			 &nbsp;<b>From </b> </td><td align="left" valign="top" style="width: 50px;">
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
 	</td>
 	<td align="left" valign="top" style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left" valign="top" style="width: 80px;">
			 <input type="text" id="todate"
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
			 </td><td align="left" valign="top" style="width: 250px;">&nbsp;&nbsp;
	 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="submit"></input></td>
		
		
		</tr>
		
		<tr>
		<td align="right" valign="top">
								<table><tr>
										<td align="right" valign="top">
		</td><td></td>
		 <td>
<!--					<div id='suplierList'>-->
<!--							<div style="height: 100px; width: 400px; overflow: auto;">-->
<!--							<table style="display: none;">-->
<!---->
<!--							</table>-->
<!---->
<!--							</div>-->
<!--							</div>-->
							
							<div style="position: absolute;">
	 <table><tr><td>
	 	
	 </td></tr>
	 <tr><td>
	 <div id='suplierList'>
	 </div>
	 </td></tr>
	 </table>
	 </div>				

							</td></tr></table></td>
			
</tr>
		</table>
<br></br>

<%
if(request.getParameter("suplierNames")!=null )
{
%> 
<%	
boolean isCheckedAll=false;
isCheckedAll=(request.getParameter("checkAll")!=null ? true : false);
String sqlDetails="",suplierCode="",openingBalance=null;

suplierCode=(request.getParameter("suplierNames")!=null ? request.getParameter("suplierNames") : "-");
 

 
%>

<br>
<br>
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">
		<thead>
			<tr>
			<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;" >Sr.No</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO No</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO Date</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Total</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Currency</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sign</th>
                
			</tr>
		</thead>
		<tbody>
		<%
	 
	int i=1;
					if(!isCheckedAll)
							sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where b.SupplierName ='"+suplierCode+"' and a.PODate BETWEEN '"+fromDate+" 00:00:00' and '"+toDate+"  23:59:59' Order by  a.PODate Desc ";
					else
							sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PODate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'  Order by  a.PODate Desc";
					
					System.out.println(sqlDetails);
					System.out.println(sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) 
					{
						
						
	%>
	<tr>
		<td align="right">
		<div align="right"> <%=i++ %></div>
		</td>
				
		<td>
		<div align="right">
		<a href="#" style="font-weight: bold;" onclick="popUp('PODetails.jsp','<%=rsDetails.getString("PONo")%>','<%=id %>')">
			<%=rsDetails.getString("PONo")%></a>
		 </div>
		</td>
		<td>
		<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsDetails.getString("PODate")))%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("Total")%></div>
		</td>
		<td><div align="left"><%=rsDetails.getString("CurrType")%></div></td>
		<td><div align="left"><%=rsDetails.getString("SupplierName")%></div></td>
		<td><div align="left"><%=rsDetails.getString("SentBy")%></div></td>
				

	</tr>
	<%
		}if(i==1){
			%>
			<tr><td colspan="12">
			NO DATA AVAILABLE
			</td></tr>	
			<%}
			
}else{
	

%> 
<%	
boolean isCheckedAll=false;
isCheckedAll=(request.getParameter("checkAll")!=null ? true : false);
String sqlDetails="",suplierCode="",openingBalance=null;

suplierCode=(request.getParameter("suplierNames")!=null ? request.getParameter("suplierNames") : "-");
 

 
%>

<br>
<br>
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">
		<thead>
			<tr>
			<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;" >Sr.No</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO No</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO Date</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Total</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Currency</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sign</th>
                
			</tr>
		</thead>
		<tbody>
		<%
	 
	int i=1;
					
							sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PODate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'  Order by  a.PODate Desc";
					
					System.out.println(sqlDetails);
					System.out.println(sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) 
					{
						
						
	%>
	<tr>
		<td align="right">
		<div align="right"> <%=i++ %></div>
		</td>
				
		<td>
		<div align="right">
		<a href="#" style="font-weight: bold;" onclick="popUp('PODetails.jsp','<%=rsDetails.getString("PONo")%>','<%=id %>')">
			<%=rsDetails.getString("PONo")%></a>
		 </div>
		</td>
		<td>
		<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsDetails.getString("PODate")))%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("Total")%></div>
		</td>
		<td><div align="left"><%=rsDetails.getString("CurrType")%></div></td>
		<td><div align="left"><%=rsDetails.getString("SupplierName")%></div></td>
		<td><div align="left"><%=rsDetails.getString("SentBy")%></div></td>
				

	</tr>
	<%
		}if(i==1){
			%>
			<tr><td colspan="12">
			NO DATA AVAILABLE
			</td></tr>	
			<%}
			

	
}
%>
		</tbody>
	</table>
</form>
<%@ include file="footer_new.jsp"%>

</body>
</html>
</jsp:useBean>