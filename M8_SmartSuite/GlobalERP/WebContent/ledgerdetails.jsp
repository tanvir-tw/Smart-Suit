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
    <script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>
</head>
 <body style="background-color:azure;">

<%
    NumberFormat nf = NumberFormat.getInstance();
    nf.setMaximumFractionDigits(2);
    nf.setMinimumFractionDigits(2);
    
    String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
    String todaysDate = session.getAttribute("today").toString(); 
    
	String selectedName;
	String FollowUpType="";

	String companyName="",phone="",contact="",email="",product="",city="",customercode="";
%>
<%
Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String bal="NA";	
try {
	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
}
		

	%>
	<%
	bt=request.getParameter("button");
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");

	}
	
	 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
	 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
	 
	if (!(null == request.getParameter("companyName"))) 
	{
		companyName=request.getParameter("companyName").replace("...","&");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct");
		customercode=request.getParameter("customercode");
		
		%>
		
		<% 
	}	
		try {
		
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>
 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Ledger A/c's Details</h5>
    </div>
</div>


 <form name='ledgerDetails' action="" method="get" >
<div class="container-fluid">

  <div class="card p-3 shadow-sm" id="visitingCard">

    <div class="row">

      <!-- Company -->
      <div class="col-md-6 d-flex align-items-start">
        <strong class="me-2" style="width:130px;">Company:</strong>
        <input type="text" 
               name="companyName"
               id="search-text"
               value="<%=companyName %>"
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
        <input type="hidden" name="customercode" id="customercode" value="<%=customercode%>"/>
      </div>

      <!-- Contact + SMS -->
      <div class="col-md-5 d-flex align-items-start">
        <strong class="me-2" style="width:130px;">Contact:</strong>
        <input type="text" 
               name="companyPerson" 
               id="search-text"
               value="<%=contact %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>

      <div class="col-md-1 d-flex align-items-center">
        <a href="javascript:void(0)" onclick="newSMSwindow('smsvc.jsp');">
          <img src="images/sms.png" width="28" height="24">
        </a>
      </div>

      <!-- Phone -->
      <div class="col-md-6 d-flex align-items-start">
        <strong class="me-2" style="width:130px;">Phone:</strong>
        <input type="text" 
               name="companyPhone"
               id="search-text"
               value="<%=phone %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>

      <!-- Email -->
      <div class="col-md-5 d-flex align-items-start">
        <strong class="me-2" style="width:130px;">E-Mail:</strong>
        <textarea name="companyEmail"
                  rows="1"
                  id="search-text"
                  readonly
                  class="form-control form-control-sm bg-light border-0 p-0 shadow-none"><%=email %></textarea>
      </div>
      
       <div class="col-md-1 d-flex align-items-start">
        <div class="mb-3">
          <a href="javascript:void(0)" onclick="newwindow('emailTransactions.jsp');">
            <img src="images/email.png" width="28" height="24">
          </a>
        </div>
        
      </div>

      <!-- Product -->
      <div class="col-md-6 d-flex align-items-start">
        <strong class="me-2" style="width:130px;">Product:</strong>
        <input type="text" 
               name="companyProduct"
               id="search-text"
               value="<%=product %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>

      <!-- City -->
      <div class="col-md-3 d-flex align-items-start">
        <strong class="me-2" style="width:130px;">City:</strong>
        <input type="text" 
               name="companyCity"
               id="search-text"
               value="<%=city %>" 
               readonly
               class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
      </div>
      <div class="col-md-3 d-flex align-items-start">
         <button type="button"
                onclick="gotoPaymentEntry('addPayment.jsp');"
                class="btn btn-info btn-sm w-100 text-dark">
          Payment Entry
        </button>
      </div>

    </div>
  </div>
</div>



<br>

 <div class="row col-12">
		    <div class="col-md-2"></div>
             <div class="col-md-3">
                <label for="input"><b>Company Name</b></label>
                	<div class="input-group input-group-merge" >
                <input class="form-control" type="text" id="companyNames" name="companyNames" onkeyup="getCompanies()" placeholder="Enter Input">
               
			    <div id="companyList"></div>
			 </div>
			  </div>
			 
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
			<div class="col-md-1">
	</div>			
</div>

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
</form>

<br>
<form name='ledgerDetails1' action="" method="post" >
<%
if(null != request.getQueryString() )
{
%> 
<%	
String sqlDetails="",companyCode="";
double sumDebit=0,sumCredit=0,openingBalance=0;
			String sql = "SELECT CustomerCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode ='"
					+ customercode + "' ";
			ResultSet rsCode = st1.executeQuery(sql);
 System.out.println(sql);

            if (rsCode.next())
			{
     %>

      <%
        
				ResultSet rsBalance=st.executeQuery("SELECT Balance,TransactionDate  FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"+ rsCode.getString(1)+"'"+
						 " and  TransactionDate <'"+dt+"' order by concat(TransactionDate , TransactionId ) desc limit 1");
            	 System.out.println("SELECT Balance,TransactionDate  FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"+ rsCode.getString(1)+"'"+
						 " and  TransactionDate <'"+dt+"' order by concat(TransactionDate , TransactionId ) desc limit 1");
				if (rsBalance.next())
				{
					openingBalance=rsBalance.getFloat(1);
					 System.out.println("OPENING BALANCE ------------========"+openingBalance);
				}
				
%>
<input type="hidden" name="customercodes" id="customercodes" value="<%=rsCode.getString(1)%>"/>
<input type="hidden" name="openingBalance" id="openingBalance" value="<%=openingBalance %>"/>
<div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Ledger Details: <%=request.getParameter("companyName")%> From <%= datex1%> &nbsp;To <%=datex2%></h5>
</div>
<div class="row">
<div class="col-10"></div>
		<div class="col-2 ms-5" style="max-width:10%;">		
		<a href="excelinvoicedet.jsp?company=<%=request.getParameter("companyName") %>&fromdate=<%=datex1 %>&todate=<%= datex2%>"></a>
<!-- 		<input type="button" name="regenerate" id="regenerate" value="Re-Calculate Balance" onclick="updatebalance()"></input>
 -->		  <input type="submit" class="btn btn-primary" id="button" name="button" onclick="updatebalance()" value="Re-Calculate Balance">
	    </div>
		
		
</div>

<table id="example" class="display" style="width:100%;">  
<thead>
	<tr>
		<th>Sr.No</th>
		<th>Tr. Date</th>
		<th style="width: 140px;">Tr. ID</th>
		<th>Debit</th>
		<th>Credit</th>
		<th>Balance(o/s)</th>
		<th>Desc.</th>
		<th>Desc. Id</th>
		<th>Sign</th>
	</tr>
	</thead>
	<tbody>
	<% if(openingBalance != 0.00) { 
   double credit = 0.00, debit = 0.00;
   if (openingBalance < 0) credit = openingBalance;
   else if (openingBalance > 0) debit = openingBalance;
%>

<tr>
   <td style="background-color:#C6DEFF;" align="right">1</td>
   <td style="background-color:#C6DEFF;" align="right"><%=datex1%></td>
   <td style="background-color:#C6DEFF;" align="right">Opening Balance</td>
   <td style="background-color:#C6DEFF;" align="right"><%=nf.format(debit)%></td>
   <td style="background-color:#C6DEFF;" align="right"><%=nf.format(credit)%></td>
   <td style="background-color:#C6DEFF;" align="right">0.00</td>
   <td style="background-color:#C6DEFF;" align="right">---</td>
   <td style="background-color:#C6DEFF;" align="right">---</td>
   <td style="background-color:#C6DEFF;" align="right">---</td>
</tr>

<% } else{ %>

<%
					companyCode = rsCode.getString(1);
					sumDebit=sumDebit+openingBalance;
					int i = 2;
					String id="",trDetails="";
					sqlDetails = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
							+ companyCode
							+ "' and  TransactionDate between '"
							+ dt
							+ "' and '"
							+ dt1
							+ "' ORDER BY  concat(TransactionDate , TransactionId ) ASC";
					System.out.println(sqlDetails);
					System.out.println(sqlDetails);
					PreparedStatement pstmt = conn.prepareStatement(sqlDetails, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );

					ResultSet rsDetails = pstmt.executeQuery();
					System.out.println("OPENING BALANCE ------------========"+openingBalance);
					while (rsDetails.next()) {
						id="";
						sumDebit=sumDebit+rsDetails.getDouble("DebitAmount");
						
						sumCredit+=rsDetails.getDouble("CreditAmount");
						if(!rsDetails.getString("TransactionDetail").startsWith("S")){
							
							id=rsDetails.getString("TransactionDetail");
							trDetails=rsDetails.getString("PaymentVoucherNo");
						}
						else{
							trDetails=rsDetails.getString("TransactionDetail");
							id=rsDetails.getString("PaymentVoucherNo");
						}
						
						if(rsDetails.getString("TransactionDetail").startsWith("SPC") || rsDetails.getString("TransactionDetail").startsWith("SIC"))
						{
							
							//id=trDetails;
							
							trDetails=rsDetails.getString("PaymentVoucherNo");
							
							String TrVoucherInv="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
									+ companyCode
							        + "' and PaymentVoucherNo='"+trDetails+"' ORDER BY  concat(TransactionDate , TransactionId ) ASC";
							ResultSet rsTrVoucherInv=st3.executeQuery(TrVoucherInv);
							
							if(rsTrVoucherInv.next())
							{
								id=rsTrVoucherInv.getString("TransactionDetail");
							}
									
							System.out.println("OPENING BALANCE -----------ffffffffffffff-========"+TrVoucherInv);
						} 
	%>
<%
	
	
	rsDetails.last();
	bal=rsDetails.getString("Balance");			
				
					%>	
	<tr>
    <td class="text-center"><%=i++%></td>
    <td class="text-right"><%= new SimpleDateFormat("dd-MMM-yyyy")
            .format(new SimpleDateFormat("yyyy-MM-dd")
            .parse(rsDetails.getString("TransactionDate"))) %></td>

    <td class="text-center">
        <a href="javascript:void(0)" style="font-weight: bold;"
           onclick="popUp('transactionDetails.jsp','<%=trDetails%>')">
           <%=trDetails%>
        </a>
    </td>

    <td class="text-center"><%=rsDetails.getString("DebitAmount")%></td>

    <% if (rsDetails.getString("CreditAmount") != null) { %>
        <td class="text-center"><%=rsDetails.getString("CreditAmount")%></td>
    <% } else { %>
        <td>0.00</td>
    <% } %>

    <td class="text-center"><%=rsDetails.getString("Balance")%></td>


    <td class="text-left"><%=rsDetails.getString("TransactionType")%></td>

    <td class="text-center"><%=id%></td>
    <td class="text-left"><%=rsDetails.getString("EmpName")%></td>
</tr>
<%
					}%>
	
	
	</tbody>
	
	<tfoot>
	
	
 <tr style="background-color: #C6DEFF;" class="sortbottom">
		<td colspan="3" style="background-color: #C6DEFF;" >Total:  
          </td>
 	<td class="text-center"><%=new DecimalFormat("0.00").format(sumDebit) %></td>
 	<td class="text-center"><%=new DecimalFormat("0.00").format(sumCredit) %></td>
 	<td class="text-center"><%=bal%></td>
 	<td colspan="3" style="background-color: #C6DEFF;" align="left"> .</td>  
 </tr> 
	
	<%} %>
	
	</tfoot>
	
	 
	</table>
<% } %>
 
 
					<%
					

} }catch (Exception e) {
	e.printStackTrace();
	System.out.println(e);
	}
	
%>

</form>
</div>


<script language="JavaScript1.2">
	function getCompanies()
	{
		document.getElementById('companyList').style.visibility = 'visible';
			var company=document.ledgerDetails.companyNames.value;

			if(company=="")
			{
				document.getElementById('companyList').style.visibility = 'hidden';
			}else
			{
				company=company.replace(".", "");
				company=company.replace(",", "");
				company=company.replace("$", "");
				company=company.replace("#", "");
				company=company.replace("?", "");
				company=company.replace("-", "");
				company=company.replace("_", "");
				company=company.replace(" ", "");
				company=company.replace("(", "");
				company=company.replace(")", "");
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
			ajaxRequest.open("GET", "AjaxGetLedgerCompanies.jsp" + queryString, true);
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
			alert(reslt);
		}
	}
	var queryString = "?company=" +company+"&contact="+contact+"&phone="+phone+"&email="+email+"&city="+city+"&product="+product;
	ajaxRequest.open("GET", "AjaxSendSMS.jsp" + queryString, true);
	ajaxRequest.send(null); 
}

	
	function showVisitingCardDetails(companyName) {
		document.getElementById('visitingCard').style.visibility='visible';
		//document.ledgerDetails.companyNames.value='';
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
				document.ledgerDetails.companyNames.value=data[1];
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
	function popUp(webadd,trancactionId)
	{ 
		var company=document.ledgerDetails.companyName.value;
			window.open(webadd+'?company='+company+'&transactionId='+trancactionId,'jav','width=870,height=500,top=150,left=250,resizable=yes');
		
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

	function updatebalance()
	{  
		
		var customercodes=document.getElementById("customercodes").value;
		document.ledgerDetails1.action ="updatebalance.jsp?customercodes="+customercodes;
		document.forms["ledgerDetails1"].submit();
		window.reload();
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
<%@ include file="footer.jsp"%>
</body>
</html>