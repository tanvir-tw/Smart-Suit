<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<head>
<style type="text/css">
	    html, body, div, span, ol, ul, li
		{
			border: 0;
			margin: 0;
			padding: 0;
			vertical-align: baseline;
		}

		.clear{clear:both;}

		#mymenu 
		{ /* the menu container */
			margin-left:22%;
			font-family:verdana;
			width: 100%;
			height:22px;
			font-size: 14px;
			text-align:center;
			background:#2AA1CC
			/*border:thin solid;
			border-color:red;
			background: aqua;
			*/
		}

		#mymenu ul
		{ /* menu ul style */
			list-style: none;
			margin: 0;
			height:22px;
			
		
		}

		#mymenu li
		 { /* horizontal menu */
			float: left;
			position: relative;
			height:22px;
			
	
	     }
	     #mymenu ul li a:hover
		 {
	        background-color:#2EAFDA;
	     }
	     
	     
	     
	     
		#mymenu a 
		{ /* the link style of menu */
			color: white;
			display: block;
			line-height: 22px;
			/*padding: 10px;*/
			text-decoration: none;
			border:1px solid #99E7F9;
			width:120px;
			height:22px;
			/*background:#596ABF;*/
			background-color:#2AA1CC;
			
		}
		 /* The sub menu is hidden by default and its position is places right under the parent menu*/
		#mymenu ul ul
		 {
			display: none;
			position: absolute;
			top: 24px;
			left: 0;
			float: left;
			width: 160px;
/*			z-index: 99999;*/
			height:22px;
		}

		/* The sub menu list element is given a minimum width */
		#mymenu ul ul li
		 {
			/*min-width: auto;*/
	        height:22px;
			color:#E0F3F7;
			/*background-color:white;*/
		  }

		/* the third level menu (sub sub menu) is placed to the left side of its parent*/
		#mymenu ul ul ul 
		{
			left: 80%;
			height:22px;
			top: 40%;
		}

		#mymenu ul ul a
		{
			/*background-color: #6883F1;*/
			line-height: 1em;
			/*padding: 10px;*/
			width: 160px;
			/*height: auto;*/
			background-color:white;
			color:black;
			
		}
		#mymenu ul li:hover > ul
		{
			display: block;
		}

		/* Styles the anchor (a) tag when mouse over */
		#mymenu li:hover > a,
		#mymenu ul ul :hover > a
		{
			background: #EDF8FB;
			color: black;
		}
		
		
</style>
</head>

<body>
        		<div align="left" style="background-color:#C6DEFF;margin-left: 0%;height: 374px;width: 150px;position: absolute;">
	</div>
	<div align="right" style="background-color:#C6DEFF;margin-left:90%;margin-right:0%;  height:374px;width: 150px;position: absolute;">
	</div>
<table width="100%">
<div>
<tr>
<td align="center" style="font-size: 1.9em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;" > <a>Accounts Menu</a> </td>
</tr>
<tr>
<td>
<%
//String ipAddress =request.getRemoteAddr(); //  request.getHeader("X-FORWARDED-FOR");
//out.println(ipAddress);//getRemoteAddr();
//String responsereceived = tally.connectTallyserver(ipAddress);
String mUsername=session.getAttribute("EmpName").toString();
String mLevel=session.getAttribute("userLevel").toString();
String role=session.getAttribute("role").toString();
String department=session.getAttribute("department").toString();
//out.println(mUsername+mLevel+ipAddress);

//if (responsereceived=="Not Connected !!!")
//{
%>
<!-- <h3>Please Start your Tally ERP 9 Software First and Reload this page .... </h3> -->
 	
<% 
//}
%>
</td>
</tr>
</div>
</table>


<table>
<tr>
<td>
<div id="mymenu" style="width:100%;background-color: white;">
<ul>
<li><a href="#" style="background-color:#3399FF">Data Entry</a>
   <ul>
   <li style="background-color: white;"><a href="vouchers.jsp" style="color: black">Vouchers</a></li>
   <li style="background-color: white;"><a href="bankreco.jsp" style="color: black">Bank Reconciliation</a></li>
   <li style="background-color: white;"><a href="epayments.jsp" style="color: black">e-Payments</a></li>
   <li style="background-color: white;"><a href="paymentEntryForm.jsp" style="color: black">Payments Entry</a></li>
   <li style="background-color: white;"><a href="Reconsilation.jsp" style="color: black">Reconsilation</a></li>
   <%if(role.equalsIgnoreCase("ALLADMIN")|| role.equalsIgnoreCase("HRADMIN")|| role.equalsIgnoreCase("ACCOUNTSADMIN") ||department.equalsIgnoreCase("Accounts") ||department.equalsIgnoreCase("HR")){ %>
   <li style="background-color: white;"><a href="#" style="color: black">Net Banking </a>
   <ul>
   
      <li style="background-color:blue;"> <a href="#" style="color: black">Master</a>
      <ul>
      <li style="background-color:blue;"> <a href="accountReport.jsp" style="color: black">Account Master</a>
      </li>
      
      <li style="background-color:blue;"> <a href="categoryMasterReport.jsp" style="color: black">Category Master</a>
      </li>
      </ul>
      </li>
      <li style="background-color:blue;"> <a href="#" style="color: black">Transaction</a>
      <ul>
      <li style="background-color:blue;"> <a href="netBankingEntry.jsp" style="color: black">Entry</a></li>
      <li style="background-color:blue;"> <a href="netBankingApprove.jsp" style="color: black">Approve</a></li>
      <li style="background-color:blue;"> <a href="netBankingCreateFile.jsp" style="color: black">Create File</a></li>
      </ul>
      </li>
      <li style="background-color:blue;"> <a href="#" style="color: black">Reports</a>
      <ul>
      <li style="background-color:blue;"> <a href="accountEnteredbyReport.jsp" style="color: black">Account Entry Report</a></li>
      <li style="background-color:blue;"> <a href="FileApprovedbyreport.jsp" style="color: black">File Approve Report</a></li>
      <li style="background-color:blue;"> <a href="FileCreatedbyreport.jsp" style="color: black">File creation report</a></li>
      </ul>
      </li>
      <li>
      </li>
      
   </ul>
	</li>
	<%} %>
	
	<!--   <li style="background-color:blue;"> <a href="netbankingentryform.jsp" style="color: black">Transaction</a>
	</li>   
   
   <li style="background-color: white;"><a href="editnetbankdata.jsp" style="color: black">Deactivate Account</a></li>  
   <li style="background-color: white;"><a href="netBanking.jsp" style="color: black">Payment Ent.(Net Bank)</a></li>
    -->
   <li style="background-color: white;"><a href="Netbankfilestatus.jsp" style="color: black">NetBank File Status</a></li>
    <li style="background-color: white;"><a href="RepeatEntry.jsp" style="color: black">Repeat Payment Entry</a></li>
    <li style="background-color: white;"><a href="TallyInterface.jsp">Sync.Tally Customer</a></li>
    <li style="background-color: white;"><a href="TallySupInterface.jsp">Sync.Tally Supplier</a></li>
   </ul> 
</li>

<li><a href="#" style="background-color:#3399FF">Reports</a>
   <ul>
   <li style="background-color: white;"><a href="tallycompare.jsp" style="color: black">Tally/ERP Comparison</a></li>
   <li style="background-color: white;"><a href="cheques.jsp" style="color: black">Cheques Payments</a></li>
   <li style="background-color: white;"><a href="allReports.jsp" style="color: black">Day Book</a></li>
   
   <%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
   <li style="background-color: white;"><a href="paymentReport.jsp" style="color: black">Approval Payment Report</a></li>
   <%} %>
   <li style="background-color: white;"><a href="AllPaymentReport.jsp" style="color: black">All PaymentReport</a></li>
   <li style="background-color: white;"><a href="TallyInterface.jsp" style="color: black">Sync.Customer(T & E)</a></li>
   <li style="background-color: white;"><a href="TallySupInterface.jsp" style="color: black">Sync.Supplier(T & E)</a></li>
     <li style="background-color: white;"><a href="netbankreport.jsp" style="color: black">Net Banking</a></li>
         <li style="background-color: white;"><a href="RepeatEntryDet.jsp" style="color: black">Repeat Payment</a></li>
   </ul>
</li>
<li><a href="#" style="background-color:#3399FF">Export to Tally</a>
   <% if (mLevel.contains("LEVEL5")  || mLevel.contains("Level5"))
   {
	   %>
   <ul>
   <li style="background-color: white;"><a href="tally_custmst.jsp" style="color: black">Customer Masters</a></li>
   <li style="background-color: white;"><a href="tally_invoice.jsp" style="color: black">Invoices</a></li>
   <li style="background-color: white;"><a href="tally_receipts.jsp" style="color: black">Receipts</a></li>
   <li style="background-color: white;"><a href="tally_creditnote.jsp" style="color: black">Credit Note</a></li>
   <li style="background-color: white;"><a href="tally_debitnote.jsp" style="color: black">Debit Note</a></li> 
   <li style="background-color: white;"><a href="tally_supmst.jsp" style="color: black">Supplier Masters</a></li>
   <li style="background-color: white;"><a href="tally_purchases.jsp" style="color: black">Purchases</a></li>
   <li style="background-color: white;"><a href="tally_payments.jsp" style="color: black">Payments</a></li>
   </ul>
   <%
   }
   %> 
</li>
<li><a href="#" style="background-color:#3399FF">Tally Reports</a>
   
   <%if (mLevel.contains("LEVEL5")  || mLevel.contains("Level5"))
   {
	   %>
   <ul>
   <li style="background-color: white;"><a href="Tally_reports.jsp?Trial_balance" style="color: black">Trial Balance</a></li>
   <li style="background-color: white;"><a href="Tally_reports.jsp?Balance_sheet" style="color: black">Balance Sheet</a></li>
   <li style="background-color: white;"><a href="Tally_reports.jsp?Day_book" style="color: black">Day Book</a></li>
   <li style="background-color: white;"><a href="Tally_reports.jsp?Ratio_analysis" style="color: black">Ratio Analysis</a></li>
   <li style="background-color: white;"><a href="tally_banks.jsp" style="color: black">Bank Balances</a></li>
   </ul>
   <%
   }
   %>
</li>
<li><a href="#" style="background-color:#3399FF">Setup Masters</a>
   <ul>
   <li style="background-color: white;"><a href="accountmst.jsp" style="color: black">Account Master</a></li>
   <li style="background-color: white;"><a href="groupmst.jsp" style="color: black">Group Master</a></li>
   <li style="background-color: white;"><a href="costcenter.jsp" style="color: black">Cost Center</a></li>
   <li style="background-color: white;"><a href="productmst.jsp" style="color: black">Product Master</a></li>
   </ul>
</li>

<li><a href="home.jsp" style="background-color:#3399FF">Exit</a>
</li>
</ul>
</div>
</td>
</tr> 
</table>




    <div>
        &nbsp;&nbsp;&nbsp;
        </div>
        
  		<div style="font-size: 1.5em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
  		<div>&nbsp;&nbsp;&nbsp;</div>
  		<table align="center" >
  		<tr>
  		<td style="text-align: justify;">
  		<a>
  	
		An Accounting software solution model embeds modules like General Ledger, Accounts Payable,<br></br>
		 Accounts Receivable, Payroll, Inventory, Job and Project Costing, Fixed Assets, Order Entry, Budgeting,<br></br> 
		 Manufacturing, Multinational Accounting, General Accounting, and Technology.
</a>
		</td>
		</tr>
		</table>
		</div> 

<br><br> <br>
<br><br> <br><br> <br><br> <br><br>
<div id="footer">
<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
</div>

</body>
</html>

