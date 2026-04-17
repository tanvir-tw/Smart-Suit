<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-blue.css);
</style>
<style>
	
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
			<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">

</script>
	</head>
	<body onLoad="resetAll();">

	<script language="JavaScript1.2">

var initialAmountAgainstInvoice=0;
var amountAgainstInvoice=0;
function resetAll()
{
	document.paymentDetails.reset();
	initialAmountAgainstInvoice=0;
	amountAgainstInvoice=0;
	flag=false;
}
	 function tallyInvoice(i)
	 {
		 if(!(amountAgainstInvoice<=0) || document.getElementById('check'+i).checked==false)
			 {
			 var flag=0;
				 if(document.getElementById('check'+i).checked==false)
				 {
					 amountAgainstInvoice=initialAmountAgainstInvoice;
					
					 for(j=1;j<document.getElementById('checktotal').value;j++)
					 {
						 if(document.getElementById('check'+j).checked==true)
						 {
								if(parseFloat(document.getElementById('invoiceValue'+j).value)<parseFloat(amountAgainstInvoice))
								{
									document.getElementById('tdAmountAgainstInvoice'+j).innerHTML=document.getElementById('invoiceValue'+j).value;
									document.getElementById('amt'+j).value=parseFloat(document.getElementById('invoiceValue'+j).value);		
								}
								else
								{
								 	document.getElementById('tdAmountAgainstInvoice'+j).innerHTML=amountAgainstInvoice;
								 	document.getElementById('amt'+j).value=parseFloat(amountAgainstInvoice);
								}
							 amountAgainstInvoice=parseFloat(amountAgainstInvoice)-parseFloat(document.getElementById('invoiceValue'+j).value);
							 document.paymentDetails.availBal.value=parseFloat(amountAgainstInvoice).toFixed(2);

							 if(document.paymentDetails.availBal.value<0)
							 		document.paymentDetails.availBal.value=0;
						 	flag=1;
						 }
					 } 
					document.getElementById('tr'+i).style.background='white';
					document.getElementById('tdAmountAgainstInvoice'+i).innerHTML='';
					document.getElementById('amt'+i).value=0;
					//alert(amountAgainstInvoice);
					if (flag==0)
					{
						amountAgainstInvoice=initialAmountAgainstInvoice;
						document.paymentDetails.availBal.value=parseFloat(amountAgainstInvoice).toFixed(2);
					}
				 }
				 else
				 {
						if(parseFloat(document.getElementById('invoiceValue'+i).value)<parseFloat(amountAgainstInvoice))
						{
							document.getElementById('tdAmountAgainstInvoice'+i).innerHTML=document.getElementById('invoiceValue'+i).value;
							document.getElementById('amt'+i).value=parseFloat(document.getElementById('invoiceValue'+i).value);		
						}
						else
						{
						 	document.getElementById('tdAmountAgainstInvoice'+i).innerHTML=amountAgainstInvoice;
						 	document.getElementById('amt'+i).value=parseFloat(amountAgainstInvoice);
						}
					 	document.getElementById('tr'+i).style.background='#C6DEFF';
					 	amountAgainstInvoice=parseFloat(amountAgainstInvoice)-parseFloat(document.getElementById('invoiceValue'+i).value);
					 	
					 	document.paymentDetails.availBal.value=parseFloat(amountAgainstInvoice).toFixed(2);
					 	if(document.paymentDetails.availBal.value<0)
					 		document.paymentDetails.availBal.value=0;
				 }
		 	}
		 else
		{
			 alert("Payable amount not available");
			 document.getElementById('check'+i).checked=false;
		}	
	 }

function resetPaymentAmount()
{
	var amount=document.paymentDetails.paymentAmount.value;
	 var numericExpression = /^[0-9]+$/;
	  	if(!(amount.match(numericExpression))) 
	  	{
		  	alert("Payment value has to be Numeric");
	  		document.paymentDetails.paymentAmount.value=document.paymentDetails.paymentAmount.value.substring(0, document.paymentDetails.paymentAmount.value.length-1);
			return false;
		} 
	  	for(j=1;j<document.getElementById('checktotal').value;j++)
		 {
			 if(document.getElementById('check'+j).checked==true)
			 {
				 document.getElementById('check'+j).checked=false;
				 document.getElementById('tr'+j).style.background='white';
				 document.getElementById('tdAmountAgainstInvoice'+j).innerHTML='';
				 document.getElementById('amt'+j).value=0;
			 }
		 } 
		 initialAmountAgainstInvoice=amount;
	  	 amountAgainstInvoice=initialAmountAgainstInvoice;
		 document.paymentDetails.availBal.value=parseFloat(amountAgainstInvoice);
}
		
function showPaymentModeDetails(){
	if(document.paymentDetails.paymentMode.value=='Cash')
	{
		document.paymentDetails.ddNumber.style.visibility='hidden';
		document.paymentDetails.bankName.style.visibility='hidden';
		document.paymentDetails.branchName.style.visibility='hidden';
		document.paymentDetails.city.style.visibility='hidden';
		document.paymentDetails.ddDate.style.visibility='hidden';
	}
	else
	{
		document.paymentDetails.ddNumber.style.visibility='visible';
		document.paymentDetails.bankName.style.visibility='visible';
		document.paymentDetails.branchName.style.visibility='visible';
		document.paymentDetails.city.style.visibility='visible';
		document.paymentDetails.ddDate.style.visibility='visible';
	}
		var paymentMode=document.paymentDetails.paymentMode.value;
}
	
	function validate()
	 {

	     var mode=document.paymentDetails.paymentMode.value;
	     var comments=document.paymentDetails.comments.value;
	     var amount=document.paymentDetails.paymentAmount.value;
	     var ddNumber = document.paymentDetails.ddNumber.value;
	     var bank=document.paymentDetails.bankName.value;
	     var branch=document.paymentDetails.branchName.value;
	     var voucherNumber=document.paymentDetails.voucherNumber.value; 
	     
	      if(amount=="")
	      {
	          alert("Please enter Payment Amount");
	          return false;
	      }

	      var numericExpression = /^[0-9]+$/;
	  	  if(amount.match(numericExpression)){
	  	  }else{
	  	  	  alert("Payment Should Be Numeric");
	  	  	  return false;
	  	  }

		  var agree=confirm("Payment Mode: "+mode+"\nAmount : "+amount+"\nDD/Ch No: "+ddNumber+"\nBank: "+bank+"\n Branch: "+branch+"\nVoucherNumber: "+voucherNumber+"\n\nAre you sure you want to continue with these values?");
		  if (agree)
			  return true ;
		  else
			  return false ;
	}

	 
	function showInvoiceTable()
	{
	//	alert("+++++++++++===");
		amountAgainstInvoice=document.paymentDetails.paymentAmount.value;
		initialAmountAgainstInvoice=document.paymentDetails.paymentAmount.value;
		document.paymentDetails.availBal.value=amountAgainstInvoice;
		document.getElementById('invoiceTable').innerHTML='<table> <tr><td>.</td></tr><tr><td><b>GETTING DATA...</b></td></tr></table>';
			
			var company=document.ledgerDetails.companyName.value;
			//alert("COMPANY    "+company);
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
					document.getElementById("invoiceTable").innerHTML=reslt;
				} 
			}
			var queryString = "?company=" +company;
			ajaxRequest.open("GET","AjaxGetPurchaseInvDet.jsp" + queryString, true);
			ajaxRequest.send(null); 

			document.getElementById('invoiceTable').style.display='block';
	}
	
	function hideInvoiceTable()
	{
			document.getElementById('invoiceTable').style.display='none';
	}

function showTextBox(){
	if(document.getElementById('deduction').checked==false)
	{
	 	document.getElementById('deductionOptions').style.visibility='hidden';
	 	document.getElementById('deductionType').style.visibility='hidden';
	}
	else
	{
		 document.getElementById('deductionOptions').style.visibility='visible';
		 document.getElementById('deductionType').style.visibility='visible';
	}
}
	
function showCalender()
{
	if(document.getElementById('backDatedEntry').checked==false)
	{
	 	document.getElementById('fromdate').style.visibility='hidden';
	}
	else
	{
		 document.getElementById('fromdate').style.visibility='visible';
	}
}


function getCompanies()
{
		document.paymentDetails.reset();
		initialAmountAgainstInvoice=0;
		amountAgainstInvoice=0;
		document.getElementById('invoiceTable').style.display='none';
		
		document.getElementById('paymentDetailsTable').style.display='none';
		document.getElementById('companyList').style.visibility = 'visible';
			var company=document.ledgerDetails.companyNames.value;
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

function sendSMS()
{

	var ajaxRequest;  // The variable that makes Ajax possible!
	var company=document.ledgerDetails.companyNames.value;
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
			alert(reslt);
		}
	}
	var queryString = "?company=" +company+"&contact="+contact+"&phone="+phone+"&email="+email+"&city="+city+"&product="+product;
	ajaxRequest.open("GET", "AjaxSendSMS.jsp" + queryString, true);
	ajaxRequest.send(null); 
}

function showVisitingCardDetails(companyName) 
{
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
			document.paymentDetails.companyNameSelected.value=data[1];
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

	 document.getElementById('paymentDetailsTable').style.display='block';
}
	
function newwindow(webadd)
{ 
		window.open(webadd+'?email='+document.ledgerDetails.companyEmail.value+'&toDate='+document.ledgerDetails.todate.value+'&fromDate='+document.ledgerDetails.fromdate.value+'&company='+document.ledgerDetails.companyName.value,'jav','width=470,height=400,top=250,left=600,resizable=no');
}

	//  if (document.all || document.getElementById)
	//	document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>


	<!-- end #header --> <!-- end #page --></div>
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String companyName="",phone="",contact="",email="",product="",city="";
	%>
	<%
    Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){ 
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	if (!(null == request.getParameter("companyName"))) 
	{
		companyName=request.getParameter("companyName");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct");
		System.out.println("cmp>>>>>>>>>."+companyName+phone+email+companyName+city+product);
	}	
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
			} catch (Exception e) {
			}
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>
 

<div
		style="font-size: 1.6em;" align="center"><a> 
 
		  Add Payment Details</a>
 </div>
<form name='ledgerDetails' action="" method="get" >

<table width="100%">
<tr>
<td style="width: 20px">

<div id="visitingCard" style="visibility: visible;">
			<table  bgcolor="#C6DEFF">
				<tr>
					<td align="left" ><div id="Company"><b>Company</b></div></td>
					<td align="left">
					<div id="companyName"><input type="text" name="companyName" 
						id="search-text" value="<%=companyName %>"
						style='border-style: none; width: 200px; height: 12px; background-color: #C6DEFF;'' readonly="readonly" /></div>
					</td>
					<td align="center" style="width: 25%"><div id="Contact"><b>Contact </b></div></td>
					<td valign="top" align="right">
					<div id="companyPerson"><input type="text"
						name="companyPerson" id="search-text" value="<%=contact %>"
						style='border-style: none; width: 200px; background-color: #C6DEFF;'' /></div>
					</td>

				</tr>
								<tr>
					<td align="left"><div id="Phone"><b>Phone</b></div></td>
					<td align="left">
					<div id="companyPhone"><input type="text" name="companyPhone"
						id="search-text" value="<%=phone %>"
						style='border-style: none; width: 200px; height: 12px; background-color: #C6DEFF;'' readonly="readonly"/></div>
					</td>
					<td align="center" style="width: 25%" valign="middle"><div id="Email"><b>E-Mail </b></div></td>
					<td valign="top" align="right" style="">
					<div id="companyEmail">
					<textarea
										name="companyEmail" rows="1" id="search-text"   readonly="readonly"
										style='border-style: none; width: 200px; height: 30px; background-color: #C6DEFF;''><%=email %></textarea>
		 </div>
					</td>

				</tr>
								 
								<tr>
					<td align="left"><div id="Product"><b>Product</b></div></td>
					<td align="left">
					<div id="companyProduct"><input type="text" name="companyProduct"
						id="search-text" value="<%=product %>"
						style='border-style: none; width: 200px; height: 12px; background-color: #C6DEFF;'' readonly="readonly"/></div>
					</td>
					<td align="center" style="width: 25%"><div id=City"><b>City </b></div></td>
					<td valign="top" align="right">
					<div id="companyCity"><input type="text" readonly="readonly"
						name="companyCity" id="search-text" value="<%=city %>"
						style='border-style: none; width: 200px; background-color: #C6DEFF;'' /></div>
					</td>

				</tr>
				</table>

</div>

</td><td align="left">
 </td></tr>

</table>
 
 

 
 

<table width="50%" border="0" >
		<tr>
							<td align="center" valign="top">
							<div id="companyNames">Enter Company Name: &nbsp;
							<input type="text" name="companyNames" id="search-text"  
								  value='<%=companyName %>'  
								onkeyup="getCompanies()" /></div>

							</td>
							<td align="left">
							<div id='companyList'>
							<div style="height: 10px; width: 250px; overflow: auto;">
							<table style="display: none;">

							</table>

							</div>
							</div>
							</td>
 



		</tr>
		
	</table>
<%

System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
%>

</form>
<br>
<div>
<form name="paymentDetails" method="get" action="insertPurchasePayment.jsp" onSubmit="return validate();">
<% if(request.getParameter("companyName")==null || request.getParameter("companyName").equalsIgnoreCase("")){ 


%>
<div name ="paymentDetailsTable" id="paymentDetailsTable" style="display: none;">
<%}else{ %>
<div name ="paymentDetailsTable" id="paymentDetailsTable" style="display: block;">
<%} %>
	<table border="0" style="background-color: white;">
		<tr>
			<td valign="top">
				Payment Mode:
			</td>
			<td valign="top">
				<select name="paymentMode" onchange="showPaymentModeDetails()" style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				<option value="Cheque">Cheque</option>
				<option value="DD">DD</option>
				<!-- <option value="Cash">Cash</option>
				<option value="Credit Note">Credit Note</option>
				<option value="Debit Note">Debit Note</option> -->
				<option value="NEFT">NEFT</option>
				</select>
				 
			</td>
								<td align="left">
		<b>Select The Payment Sepcification
		</b>

		</td>
 


	
						<td rowspan="8" align="center" valign="top">
						<div  id="availBal" align="left" >  &nbsp;&nbsp;&nbsp;Avail amount: 
 <input type="text" name="availBal" id="availBal" style="border: none;" value="0" readonly="readonly"></input>
 </div>
						<div id="invoiceTable" style="display:none; overflow:auto; height: 190px; ">
			 <table> <tr><td>.</td></tr>
			 <tr><td><b>GETTING DATA...</b></td></tr>
			 </table></div>
		</td>
								<td rowspan="8" align="center" valign="middle">
						<div id="invoiceChecked" style="display:none; height: 220px; overflow: auto;">
			 <table> <tr><td>.</td></tr>
			 <tr><td><b>GETTING DATA...</b></td></tr>
			 </table>
		</div></td>
		</tr>
		<tr>
		<td>
			Payment Amount:
		</td>
		<td>
		<input type="text" name="paymentAmount" value="" id="search-text" onkeyup="resetPaymentAmount();" />&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		
		</td>
				<td>
		<input type="radio" name="invoice" value="invoice" onchange="showInvoiceTable()"><b>Invoice Number Will Be Specified </b></input>
		
		</td>
		</tr>
		
				<tr>
		<td>
			DD/Ch no.:
		</td>
		<td>
		<input type="text" name="ddNumber" value="" id="search-text" />
		
		</td>
				 		<td rowspan="2"  valign="baseline">
			Payment Details : <br>
			<textarea
								wrap="virtual" rows="2" cols="25" name="paymentdetails"  
								style="height: 50px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :                       normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 70; max-width: 70;">
					</textarea>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 </td>

		</tr>
				<tr><td>Ch/DD Date</td><td>
								<input type="text" id="ddDate"
						name="ssDate" value="<%=toDateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "ddDate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "ddDate"       // ID of the button
			    }
			  );
			</script>
			</td>
		
			</td>
		</tr>
						<tr>
		<td>
			Bank Name:
		</td>
		<td>
		<input type="text" name="bankName" value="" id="search-text" />
		
		</td>
				 		<td rowspan="2"  valign="baseline">
			Comments : <br>
			<textarea
								wrap="virtual" rows="2" cols="25" name="comments"  
								style="height: 50px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :                       normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 70; max-width: 70;">
					</textarea>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 </td>
		</tr>
						<tr>
		<td>
			Branch Name:
		</td>
		<td>
		<input type="text" name="branchName" value="" id="search-text" />
		
		</td>
<td >
	<div id="deductionType" style="visibility: hidden;">
	&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
	Amount :&nbsp; &nbsp;
&nbsp;  
<input type="text" name="deductionValue" value="" id="deductionValue" style="width: 80px;padding: 4px 5px 2px 5px;
	border: 1px solid black;
	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000; " />
	</div>
</td>

		
		</tr>
						<tr>
		<td>
			City :
		</td>
		<td>
		<input type="text" name="city" value="" id="search-text" />
		
		</td>
	

			
			
		  <td colspan="2" style="display: none;" >
		<input type="hidden" name="companyNameSelected" id ="companyNameSelected" value="<%=companyName %>" />
		</td>  
		</tr>
		<%
		
		%>
						<tr>
		<td valign="top">
			 
		</td>
		<td valign="top"> 
		<input type="text" name="voucherNumber"   id="search-text" readonly="readonly" style="border: none; font-weight: bold" />
		
		</td>

		</tr>
 
		<tr>
		<td colspan="5" align="center">
		<table><tr><td>
			<input type="submit" name="Submit" value="Go" class="formElement" style="border: outset;"/>&nbsp;
			&nbsp;&nbsp;&nbsp;
			</td>
			<td><input type="reset" name="Clear" value="Clear" class="formElement" style="border: outset;" onclick="resetPaymentAmount()"/>
			&nbsp;&nbsp;&nbsp;&nbsp; </td>
	
			<td><input type="button" value="Cancel"
	onclick="window.location.reload()" style="border: outset;" /></td>
			</tr></table>
			</td>
  	</tr> 
				
				
				
 
	</table>
  </div>
</form>
</div>
<br></br>



<%
System.out.println("&&&^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^&&&&&");
 
%>
</table>
</div>
<!-- 	<br><br> <br><br> <br><br> <br><br> -->
<!-- 	<br><br> <br><br> <br><br> <br><br> -->
<!-- 		<br><br> <br><br> <br><br> <br><br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@ include file="footer_new.jsp"%>