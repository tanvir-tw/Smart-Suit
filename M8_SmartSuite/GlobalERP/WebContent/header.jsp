
<meta http-equiv="Context-Type" content="text/html; charset=UTF-8">

<meta http-equiv="Context-Type" content="text/html; charset=UTF-8">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.io.*"%>
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset='utf-8'>
   		<meta http-equiv="X-UA-Compatible" content="IE=edge">
   			<meta name="viewport" content="width=device-width, initial-scale=1">
   				<link rel="stylesheet" href="css/stylesnew.css">
   				<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   				<script src="js/script.js"></script>
				<style type="text/css">
					@import url(jscalendar-1.0/calendar-blue.css);
				</style>
				<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
				<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
				<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
				<script src="sorttable.js" type="text/javascript"></script>
			<meta name="keywords" content="" />
			<meta name="description" content="" />
			<meta http-equiv="content-type" content="text/html; charset=utf-8" />
			<link href="css/style2.css" rel="stylesheet" type="text/css" media="screen" />
			<link href="css/footer.css" rel="stylesheet" type="text/css" media="screen" />
			<style type="text/css">
			</style>
			<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
			<script type="text/javascript" src="css/chrome.js">
			</script>
		<link href="css/table.css" rel="stylesheet" type="text/css" media="screen" />
	<title>Transworld Technologies LTD, ERP</title>
  <link rel="icon" href="images/logoTW.jpg" type="image/jpg" />
</head>
<body>
<script type="text/javascript">
function openpopup(PageName)
{
	try
	{
		testwindow=window.open("RegisterComplaint.jsp?PageName="+PageName,"Register Complaint","width=700,height=400,scrollbars=yes");
	 	testwindow.moveTo(200,200);
	}
	catch(e)
	{
		alert(e);
	}
}

function openpopup1(PageName)
{
	try
	{
		window.open("PendingPurchaseOrderList.jsp");
	 //	testwindow.moveTo(200,200);
	}
	catch(e)
	{
		alert(e);
	}
}
</script>
<%
String SesmUsername=session.getAttribute("EmpName").toString();
String SesmLevel=session.getAttribute("userLevel").toString();
String Sesrole=session.getAttribute("role").toString();
String Sesdepartment=session.getAttribute("department").toString();
String comsessionid=session.getAttribute("CompanyMasterID").toString();

Connection sessionconn=null;
try
{
	Class.forName(DB_Driver);
	sessionconn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement strno = sessionconn.createStatement();
	Statement st = sessionconn.createStatement();
	String PageName=this.getClass().getName();
	String reportno = "",logoname="";
	PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
	System.out.println(PageName);
	PageName=PageName.replace("_",".");
	PageName=PageName.replace(".005f","_");
	PageName = PageName.replace(".0020"," ");
	System.out.println("PageName   "+PageName);
	String sqlreport = "select ReportNo from t_reportnumber where PageName = '"+PageName+"'";
	ResultSet rsreport = strno.executeQuery(sqlreport);
	if(rsreport.next())
	{
		reportno = rsreport.getString("ReportNo");
	}
	
	String logo="select distinct(companymid),Companyname,logoname from db_GlobalERP.CompanyMaster where companymid='"+session.getAttribute("CompanyMasterID").toString()+"'";
	ResultSet rslogo = strno.executeQuery(logo);
	if(rslogo.next())
	{
		logoname=rslogo.getString("logoname");
	}else{
		logoname="";
	}
	
	System.out.println("Report Number Above Session Id------->"+reportno);
	String SuperAdmin="", Admin="", Sales="", Purchase="", Claim="",HRModule="", Account="", Collection="", SalesAdmin="", PurchaseAdmin="", ClaimAdmin="", AccountAdmin="",CollectionAdmin="";
	SuperAdmin=session.getAttribute("SuperAdmin").toString();
	Admin=session.getAttribute("Admin").toString();
	Sales=session.getAttribute("Sales").toString();
	Purchase=session.getAttribute("Purchase").toString();
	Claim=session.getAttribute("Claim").toString();
	Account=session.getAttribute("Account").toString();
	Collection=session.getAttribute("Collection").toString();
	SalesAdmin=session.getAttribute("SalesAdmin").toString();
	PurchaseAdmin=session.getAttribute("PurchaseAdmin").toString();
	ClaimAdmin=session.getAttribute("ClaimAdmin").toString();	
	AccountAdmin=session.getAttribute("AccountAdmin").toString();
	CollectionAdmin=session.getAttribute("CollectionAdmin").toString();
	HRModule=session.getAttribute("HRModule").toString();
	
	
	System.out.println("Report Number Below Session Id------->"+reportno);
	
	
	System.out.println("Report Number-------1>"+SuperAdmin);
	System.out.println("Report Number-------2>"+Admin);
	System.out.println("Report Number-------3>"+Sales);
	
	System.out.println("Report Number-------4>"+Purchase);
	System.out.println("Report Number-------5>"+Claim);
	System.out.println("Report Number-------6>"+Account);
	
	System.out.println("Report Number-------7>"+Collection);
	System.out.println("Report Number-------8>"+SalesAdmin);
	System.out.println("Report Number-------9>"+PurchaseAdmin);
	
	System.out.println("Report Number-------10>"+ClaimAdmin);
	System.out.println("Report Number-------11>"+AccountAdmin);
	System.out.println("Report Number-------12>"+CollectionAdmin);
%>
<div id='cssmenu'>
<%-- 	<img src="DatabaseAccess?id=<%=session.getAttribute("CompanyMasterID").toString() %>" align="left" height="50" width="200"></img>
 --%>		
 <img src="images/<%=logoname %>" align="left" height="50" width="200"></img>
	
		<ul>
   			<li><a href='home.jsp'>Home</a></li>
  			 <li class='active'><a href='#'>Modules</a>
      			<ul>
      			
      						<% 
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
         			{		
						%>	
      			
      			     <%if(HRModule.equalsIgnoreCase("Yes") || HRModule.equalsIgnoreCase("Yes") || comsessionid.equalsIgnoreCase("100052"))
{ %>
                    
         			<li><a href="#">HR</a>
         			
         			
         			
         			<ul>
         					<li><a href="#">Performance</a>
         					
         					<ul>
         					
         					              
         					                       
<li><a href="AdvanceMoneyForm.jsp">Advance Entry</a></li>		           									
<li><a href="TaskIndexCalculation.jsp">Index</a></li>
<li><a href="KRACalculation.jsp">KRA Index</a></li>
<li><a href="TaskApprovalReport.jsp">Task Status</a></li>
<li><a href="KRATaskStatusReport.jsp">KRA Status</a></li> 

													<%
													String role=session.getAttribute("role").toString();
		           									if(role.equals("AllAdmin") || role.equals("HOD") || role.equalsIgnoreCase("HR")) 
		           									{
		           									%>
		           									<li><a href="TaskAllocationReport.jsp">Task Allocation </a></li>
		           									<%} %>

		           									<%
		           									
		           									if(role.equals("AllAdmin") || role.equals("HOD")) 
		           									{
		           									%>
		           									<li><a href="TaskMailDownLodedDataReport.jsp">Task Approval</a></li>
		           									<%} %>
		           									
		           				
<%
role=session.getAttribute("role").toString();

if(role.equals("HOD") || role.equals("Admin") || role.equals("AllAdmin"))
	{%>
<li><a href="uploadTask.jsp">Task Upload</a></li>

<% } %>	 




<li>           		   <a href="#">Score Card</a>
         					              
         					              <ul><li><a href="ViewScores.jsp">View Emp Scores</a></li>
		           									<% role=session.getAttribute("role").toString();

		           									role=session.getAttribute("role").toString();
		           									if(!role.equals("-"))
		           									{
		           										%>
		           										 <li><a href="ScoreCardReport.jsp">Score Card</a></li>
		           										<%
		           									}
		           									
		           									else if(role.equals("AllAdmin") || role.equals("HOD")) 
		           									{
		           									%>
		           									<li><a href="ScoreCardReport.jsp">Emp Score Report</a></li>
		           									 <li><a href="ViewScores.jsp">View Emp Scores</a></li>
		           									<%} %>
		           								</ul>
         					              
         					              </li>
         					              
								<li><a href="#">Project Summary</a>
								
								<ul><li><a href="TaskSummaryReport.jsp">PI</a></li>
		           					<li><a href="KRASummaryReport.jsp">KRA</a></li>
		           				</ul>
				
								</li>
		           			</ul>
		           			
           		       	</li>
           		       	
           		       	
           		       	<!-- Open Project  -->
           		       	<li><a href="#">Open Project</a>
         					
         					<ul>
         					
         					              
         					                       
		           									
<li><a href="OPTaskIndexCalculation.jsp">Index</a></li>
<li><a href="OPKRACalculation.jsp">KRA Index</a></li>
<li><a href="OPTaskApprovalReport.jsp">Task Status</a></li>
<li><a href="OPKRATaskStatusReport.jsp">KRA Status</a></li> 

													<%
													 role=session.getAttribute("role").toString();
		           									if(role.equals("AllAdmin") || role.equals("HOD") || role.equalsIgnoreCase("HR")) 
		           									{
		           									%>
		           									<li><a href="OPTaskAllocationReport.jsp">Task Allocation </a></li>
		           									<%} %>

		           									<%
		           									
		           									if(role.equals("AllAdmin") || role.equals("HOD")) 
		           									{
		           									%>
		           									<li><a href="OPTaskMailDownLodedDataReport.jsp">Task Approval</a></li>
		           									<%} %>
		           									
		           				
<%if((session.getAttribute("EmpName").toString().equals("Washim") || 
session.getAttribute("EmpName").toString().equalsIgnoreCase("Poonam Dixit") ))
{   %>
<li><a href="UploadOpenProjectSheet.jsp">Task Upload</a></li>

<% } %>	 

<li><a href="UploadOpenProjectSheet.jsp">Task Upload</a></li>



<%-- <li>           		   <a href="#">Score Card</a>
         					              
         					              <ul><li><a href="ViewScores.jsp">View Emp Scores</a></li>
		           									<% role=session.getAttribute("role").toString();

		           									role=session.getAttribute("role").toString();
		           									if(!role.equals("-"))
		           									{
		           										%>
		           										 <li><a href="ScoreCardReport.jsp">Score Card</a></li>
		           										<%
		           									}
		           									
		           									else if(role.equals("AllAdmin") || role.equals("HOD")) 
		           									{
		           									%>
		           									<li><a href="ScoreCardReport.jsp">Emp Score Report</a></li>
		           									 <li><a href="ViewScores.jsp">View Emp Scores</a></li>
		           									<%} %>
		           								</ul>
         					              
         					              </li> --%>
         					              
								<!-- <li><a href="#">Project Summary</a>
								
								<ul><li><a href="TaskSummaryReport.jsp">PI</a></li>
		           					<li><a href="KRASummaryReport.jsp">KRA</a></li>
		           				</ul>
				
								</li> -->
		           			</ul>
		           			
           		       	</li>
         					                      
         					                       
		           			 
<%if((session.getAttribute("EmpName").toString().equals("Washim") || session.getAttribute("EmpName").toString().equals("Parineeta Tepale") ))
	{%>
<li><a href="uploadTask.jsp">Task Upload</a></li>

<% } %>	 
		           			
           		       	
           		       	
           		       	<%/* String role1=session.getAttribute("role").toString();
if(role1.equals("Hr") || role1.equals("-"))
{ */
	
	if(role.equalsIgnoreCase("HR")){ %>	
		<li><a href="UploadAttendance.jsp">Upload Attendance</a></li>
	<%}
	
	
	%>
	
	<li><a href="AttendanceReport.jsp">Attendance Report</a></li>
	<li><a href="HolidayMaster1.jsp">Holiday Master</a></li>
	
	<% 
	
	if(role.equals("AllAdmin"))
	{	
		
	%>
	<li><a href="RevisePayApproval.jsp">Revise Pay Approval</a></li>
	<li><a href="RevisePayReport.jsp">Revise Pay Report</a></li>
	
	<%} %>
	<li><a href="PaidaysReport.jsp">Payroll Days Status</a></li>
	<% 
	
	if(role.equals("Hr"))
	{
%>
<li><a href="#">Email Template</a>
<ul>
<li><a href="template.jsp">Create Template</a></li>
<li><a href="ContractMasterSendmail.jsp">Send Email</a></li>
<li><a href="SendmailReport.jsp">Send Email Reports</a></li>
</ul>
</li>
<li><a href="TaskFinalStatus.jsp">Task Final Status</a></li>
<li><a href="ContractMasterReport.jsp">Contract Master</a></li>
<li><a href="RevisePayReport.jsp">Revise Pay Report</a></li>
<li><a href="PayRollReport2.jsp">Pay Roll Generation</a></li>

<%} %>
	<li><a href="FinalPayReport.jsp">Final Pay Report</a></li>

	<% 
		 if(role.equals("HOD") || role.equals("AllAdmin")) 
		     { 
		   %>
		  
		   <li><a href="#">Open Issue</a>
		    <ul>
				   <li><a href="#">Dashboard</a>
				   
				   <ul><li><a href="OpenIssueDashBoard.jsp">Priority wise Dashboard</a></li>
		           	  <li><a href="OpenIssueDashBoard1.jsp">Developer Wise Dashboard</a></li>
		           </ul>
				   </li>

				   <li><a href="OpenIssueTrackerEdit.jsp">Report</a></li>
            </ul>
            </li>
		   
		   								
		   <% } else{
			   %>
			   <li><a href="#">Open Issue</a>
			    <ul>

					   <li><a href="OpenIssueTracker.jsp">Report</a></li>
	            </ul>
	            </li>
			   <% 
		   }%>
		  
	<% 
/* }
 */
%></li>
         			</ul>
         			</li>
         			
         		 			
        			
<%}%>
<%}%>  			
<%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes"))
{ %>
         			<li><a href="#">Sales</a>
         				<ul>
         		 			<li><a href="#">File</a>
           						<ul>
	           						<li><a href="#">New</a>
		           						<ul>
		           							<li><a href="#">Enquiry</a>
		           								<ul>
		           									<li><a href="sales.jsp">Domestic</a></li>
		           									<li><a href="Exportsales.jsp">Export</a></li>
												</ul>
		           							</li>
		           							<li><a href="salesenq.jsp">Quotation</a></li>
		           							<li><a href="salesorder.jsp">Order</a></li>
		           							<li><a href="invoiceReport.jsp?id=proforma">Proforma Invoice</a></li>
		           							<li><a href="#">Invoice</a>
		            							<ul>
		           									<li><a href="ProformaInvcList.jsp">From Proforma</a></li>
		         									<li><a href="invoiceReport.jsp?id=main">From Order</a></li>
		           								</ul>
		           							</li>
		      					     	</ul>
	           						</li>
	           						<li><a href="#">Close</a>
		          						<ul>
		           							<li><a href="salesEnqReport.jsp?id=close">Enquiry</a></li>
		           							<li><a href="showquotationlist.jsp?id=close">Quotation</a></li>
		           							<li><a href="showorderlist.jsp?id=close">Order</a></li>
		           							<li><a href="showinvoicelist.jsp?id=proformaclose">Proforma Invoice</a></li>
		           							<li><a href="showinvoicelist.jsp?id=close">Invoice </a></li>
		           						</ul>
	           						</li>    
	           						<li><a href="#">Revision</a>
	           	 						<ul>
	             							<li><a href="salesEnqReport.jsp?id=revise">Enquiry</a></li>
		        							<li><a href="showquotationlist.jsp?id=revise">Quotation</a></li>
		        							<li><a href="showorderlist.jsp?id=revise">Order </a></li>
		         							<li><a href="showinvoicelist.jsp?id=proformarevise">Proforma Invoice </a></li>
		         							<li><a href="showinvoicelist.jsp?id=revise">Invoice</a></li>
		         						</ul>
               						</li>
               						<li><a href="#">View</a>
	           	 						<ul>
	             							<li><a href="salesEnqReport.jsp?id=View">Enquiry</a></li>
		         							<li><a href="showquotationlist.jsp?id=View">Quotation</a></li>
		         							<li><a href="showorderlist.jsp?id=View">Order</a></li>
		         							<li><a href="showProformaInvoice.jsp?id=View">Proforma Invoice</a></li>
		          							<li><a href="showinvoicelist.jsp?id=View">Invoice</a></li>
		         						</ul>
               						</li>
            					</ul>
        					</li>
          					<li><a href="#">Edit</a>
           						<ul>
           							<li><a href="#">Under Construction</a></li>
           						</ul>
        					</li>
        					<li><a href="#">View</a>
           						<ul>
           							<li><a href="ReceivableReport.jsp">Receivable Report</a></li>
           							<li><a href="transporterInstallationReport.jsp">Transporter Report</a></li>
           						</ul>
        					</li>
        					
        					<%
        					
        					try
         		{
         			
         			String comType=session.getAttribute("CompanyType").toString();
         			System.out.println("Session Com Type Value ---------"+comType);
         				%>
        					
        					   <li><a href="#">Tools</a>
           						<ul>
           						        						
           			
           						<% 
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
         			{		
						%>	
							        <li><a href="BillingDetailsReport.jsp">Vehicle Bill Status</a></li> 
           							<li><a href="transporterData.jsp">Update Transporter</a></li>
          							<li><a href="TotalNotAddedVehicles.jsp">Add New Vehicles</a></li> 
         							<li><a href="vehiclebillreport.jsp">Billing Report</a></li> 
         							
         							<li><a href="autogeneratedbillreport.jsp">Vehicle Billing</a></li>
         							<li><a href="AutoSendMail.jsp">Auto Billing Mail Report</a></li>
         							
         							<li><a href="physicaldamagereport.jsp">Damage Billing</a></li>
         							<li><a href="MonthlyInvoiceDetails.jsp">Monthly Service Invoice Report</a></li>
									<li><a href="MonthlyBillingStatusReport.jsp">Monthly Billing Status</a></li>
               						<li><a href="ASCSummaryReport.jsp">ASC Summary</a></li>
         							<li><a href="ASCPendingInvoiceReport.jsp">ASC Invoice</a></li>
               		<%}
               		else
               		{
               		%>
               		
               		<%} 
           						
         		}catch(Exception e){e.printStackTrace();}%>
               		
               		
         							
           						</ul>
        					</li>
       						<li><a href="#">Help</a>
           						<ul>
           							<li><a href="">Under Construction</a></li>
           						</ul>
        					</li>	
         				</ul>
         			</li>
<%}%>
<%if(Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")) 
{ %> 
			<li><a href="#">Purchase PRN</a>
         		 <ul>
         		 	<li><a href="PurchasePRNEnquiry.jsp">Purchase PRN Enquiry</a></li>
         		 	<li><a href="PurchaseRequisitionEnquiryReport.jsp">Purchase PRN Report</a></li>
         		 </ul>
         	</li>
			
			
					<li><a href="#">Purchase</a>
         				<ul>
         					<li><a href="#">File</a>
           						<ul>
	           						<li><a href="#">New </a>
		           						<ul>
		           							<li><a href="#">Enquiry</a>
		           								<ul>
		           									<li><a href="PurchaseEnquiry.jsp">Enquiry</a></li>
		           									<li><a href="ExportPurchaseEnquiry.jsp">Export Enquiry</a></li>
												</ul>
		           							</li>
		           							<li><a href="purchaseQuotation.jsp">Quotation</a></li>
		           							<li><a href="purchaseOrder.jsp">Order </a></li>
		           							<li><a href="purchaseInvoice.jsp">Invoice</a></li>
		           							<li><a href="addNewSupplier.jsp">Add Supplier</a></li>
		         						</ul>
	           						</li>
	           						<li><a href="#">Close</a>
		         						<ul>
		           							<li><a href="PurchaseEnqList.jsp?id=close">Enquiry</a></li>
		           							<li><a href="PurchaseQuatationList.jsp?id=close">Quotation</a></li>
		           							<li><a href="PurchaseOrderList.jsp?id=close">Order </a></li>
		           							<li><a href="PurchaseInvoiceList.jsp?id=close">Invoice </a></li>
		           						</ul>  
	           						</li>    
	           						<li><a href="#">Revise</a>
	     	 							<ul>
	             							<li><a href="PurchaseEnqList.jsp?id=revise">Enquiry</a></li>
		         							<li><a href="PurchaseQuatationList.jsp?id=revise">Quotation</a></li>
		         							<li><a href="PurchaseOrderList.jsp?id=revise">Order </a></li>
		          							<li><a href="PurchaseInvoiceList.jsp?id=revise">Invoice</a></li>
		         						</ul> 
             						</li>  
             						<li><a href="#">View</a>
	           	 						<ul>
	             							<li><a href="PurchaseEnqList.jsp">Enquiry</a></li>
		         							<li><a href="PurchaseQuatationList.jsp">Quotation</a></li>
		        							<li><a href="PurchaseOrderList.jsp">Order </a></li>
		          							<li><a href="PurchaseInvoiceList.jsp">Invoice</a></li>
		         						</ul>
            						</li>
           						</ul>
        					</li>
       						<li><a href="#">Edit</a>
           						<ul> 
           							<li><a href="editSupplier.jsp">Edit Supplier</a></li>
           						</ul>
        					</li>
    		    			<li><a href="#">Reports</a>
        						<ul>
         							<li><a href="#">All Enquiry </a>
		           						<ul>
		           							<li><a href="PurchaseEnqList.jsp">By Date Range</a></li>
		           						</ul>
	    							</li>
	    							<li><a href="purchaseClosedEnquries.jsp">Closed Enquiry </a></li>
	    							<li><a href="PurchaseQuatationList.jsp">Purchase Quotation </a></li>
	    							<li><a href="PurchaseOrderReport.jsp">Purchase Order </a></li>
	    							<li><a href="PurchaseInvoiceList.jsp">Purchase Invoice </a></li> 
	    							<li><a href="purchaseGRN report.jsp">Purchase GRN </a></li>
	    							<li><a href="paymentAccDet.jsp">Payment Report </a></li>
	      							<li><a href="PaymnetRepForAllSupp.jsp">Vendor's Payments</a></li>
	      							<li><a href="ItemwisedetailsP.jsp">Purchase Orders</a></li>
	      							
	    						</ul>
        					</li>
        					<li><a href="#">Tools</a>
           						<ul>
           							<li><a href="#">Add Items</a>
           								<ul>
		           							<li><a href="GroupMaster.jsp?id=group">Group</a></li>
		           							<li><a href="GroupMaster.jsp?id=make">Make</a></li>
		        						</ul>
          	          				</li>
            		 				<li><a href="stockdet.jsp">Stock Update</a></li>
           						</ul>
        					</li>
        					<li><a href="purchase.jsp">Search</a></li>
       						<li><a href="#">Help</a>
           						<ul>
           							<li><a href="">Under Construction</a></li>
           						</ul>
        					</li> 
         				</ul>
         			</li>
<%}%>
					<li><a href='#'>Claims</a>
      					<ul>
         					<li><a href="claimReport.jsp?action=view">My Claim</a></li>
         					<li><a href="AdvanceClaimReport.jsp">Advance Report</a></li>
						<%if(Sesrole.equals("AllAdmin") || Sesrole.equals("HOD")) 	
						{%>
     					<li><a href="claimReport.jsp?action=check">Check Claim</a></li>
     				<%}%>
     				<%/* if(Account.equalsIgnoreCase("Yes") || AccountAdmin.equalsIgnoreCase("Yes")) */
     				if(Sesdepartment.equals("Accounts")){ %>
     					<li><a href="AccountClaimReport.jsp?action=approve">Approved Claim</a></li>
     					<li><a href="claimReport.jsp?action=sanction">Sanction Claim</a></li>
    				 <%}%>
    					</ul>
   					</li>
    			<%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
         			<li><a href='#'>Merge</a>
         				<ul>
         					<li><a href="Mergeprocpect.jsp">Prospect</a></li>
         					<li><a href="MergeCustomer.jsp">Customer</a></li>
	        				<li><a href="itemmerging.jsp">Item</a></li>
						</ul>
         			</li>
     			<%}%>
         		<%try
         		{
         			
         			String comType=session.getAttribute("CompanyType").toString();
         			System.out.println("Session Com Type Value ---------"+comType);
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport")) && (session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")||session.getAttribute("userLevel").toString().equalsIgnoreCase("level4")))
					{
					%>
         			<li><a href='#'>Transport</a>
         				<ul>
						<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
							<li><a href="CustomerMaster.jsp">Customer Master</a></li>
         					<li><a href="FollowupMaster.jsp">Follow-up Master</a></li>
         				<%}%>
         				<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes") || Account.equalsIgnoreCase("Yes") || AccountAdmin.equalsIgnoreCase("Yes")){%>
         					<li><a href="BranchMaster.jsp">Branch Master</a></li>
         					<li><a href="loadTypeMaster.jsp">Business/Load Type</a></li>
         				<%}%>
         				<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
         					<li><a href="productMaster.jsp">Product Master</a></li>
         				<%}%>
         				<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
         					<li><a href="freightMaster.jsp">Freight Master</a></li>
						<%}%>
         				<%if(Admin.equalsIgnoreCase("Yes")){%>
         					<li><a href="riskInvMaster.jsp">Risk Involved Master</a></li>
         					<li><a href="companyReport.jsp">Company Master</a></li>
         				<%}%>
         				<%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")){%>
         					<li><a href="OpportunityReport.jsp">Opportunity Report</a></li>				         	         	         	         
         				<%}%>	
						</ul>
         			</li>
         		<%}%>
         	<%
         	String comType2=session.getAttribute("CompanyType").toString();
 			System.out.println("Session Com Type Value ---------"+comType2);
 			
         		}catch(Exception e){e.printStackTrace();}
         		
         		
        // System.out.println("COMPANY TYPE ====="+session.getAttribute("CompanyType").toString());
         
         %>
         		<%if(Account.equalsIgnoreCase("Yes") || AccountAdmin.equalsIgnoreCase("Yes")){%>
        	 		<li><a href="#">Accounts</a>
        	 			<ul>
							<li><a href="#">Data Entry</a>
   								<ul>
   									<li><a href="vouchers.jsp">Vouchers</a></li>
   									<li><a href="bankreco.jsp">Bank Reconciliation</a></li>
   									<li><a href="epayments.jsp">e-Payments</a></li>
   									<li><a href="paymentEntryForm.jsp">Payments Entry</a></li>
   									<li><a href="Reconsilation.jsp">Reconsilation</a></li>
   									<%if(AccountAdmin.equalsIgnoreCase("Yes")){%>
   									<li><a href="#">Net Banking </a>
   										<ul>
   										    <li><a href="#">Master</a>
      											<ul>
      												<li><a href="accountReport.jsp">Account Master</a></li>
   													<li><a href="categoryMasterReport.jsp">Category Master</a></li>
      											</ul>
      										</li>
      										<li><a href="#">Transaction</a>
      											<ul>
      												<li><a href="netBankingEntry.jsp">Entry</a></li>
      												<li><a href="netBankingApprove.jsp">Approve</a></li>
     												<li> <a href="netBankingCreateFile.jsp">Create File</a></li>
     											</ul>
      										</li>
      										<li><a href="#">Reports</a>
      											<ul>
      												<li> <a href="accountEnteredbyReport.jsp">Account Entry</a></li>
      												<li> <a href="FileApprovedbyreport.jsp">File Approve</a></li>
      												<li> <a href="FileCreatedbyreport.jsp">File creation</a></li>
      												
      											</ul>
      										</li>
      									</ul>
									</li>
									<%}%>
									<li><a href="Netbankfilestatus.jsp">NetBank File Status</a></li>
    								<li><a href="RepeatEntry.jsp">Repeat Payment</a></li>
    								<li><a href="TallyInterface.jsp">Sync.Tally Customer</a></li>
    								<li><a href="TallySupInterface.jsp">Sync.Tally Supplier</a></li>
   								</ul> 
							</li>
							<li><a href="#">Reports</a>
   								<ul>
  									<li><a href="tallycompare.jsp">Tally Comparison</a></li>
   									<li><a href="cheques.jsp">Cheque Payments</a></li>
   									<li><a href="allReports.jsp">Day Book</a></li>
   									<li><a href="paymentReport.jsp">Approval Payments</a></li>
   									<li><a href="AllPaymentReport.jsp">All Payments</a></li>
   									<li><a href="TallyInterface.jsp">Sync.Customer(T & E)</a></li>
   									<li><a href="TallySupInterface.jsp">Sync.Supplier(T & E)</a></li>
    								<li><a href="netbankreport.jsp">Net Banking</a></li>
         							<li><a href="RepeatEntryDet.jsp">Repeat Payment</a></li>
         							<li><a href="InvoiceDetailsReport.jsp">Invoice GST Detail</a></li>
         							
         							
         							
   								</ul>
							</li>
							<li><a href="#">Export to Tally</a>
   								<ul>
   									<li><a href="tally_custmst.jsp">Customer Master</a></li>
   									<li><a href="tally_invoice.jsp">Invoices</a></li>
   									<li><a href="tally_GSTinvoice.jsp">GST Invoices</a></li>
   									<li><a href="tally_receipts.jsp">Receipts</a></li>
   									<li><a href="tally_creditnote.jsp">Credit Note</a></li>
   									<li><a href="tally_debitnote.jsp">Debit Note</a></li> 
   									<li><a href="tally_supmst.jsp">Supplier Masters</a></li>
   									<li><a href="tally_purchases.jsp">Purchases</a></li>
   									<li><a href="tally_payments.jsp">Payments</a></li>
   								</ul>
   							</li>
							<li><a href="#">Tally Reports</a>
								<ul>
  									<li><a href="Tally_reports.jsp?Trial_balance">Trial Balance</a></li>
  									<li><a href="Tally_reports.jsp?Balance_sheet">Balance Sheet</a></li>
   									<li><a href="Tally_reports.jsp?Day_book">Day Book</a></li>
   									<li><a href="Tally_reports.jsp?Ratio_analysis">Ratio Analysis</a></li>
   									<li><a href="tally_banks.jsp">Bank Balances</a></li>
   								</ul>
   							</li>
								<li><a href="#">Setup Masters</a>
   									<ul>
   										<li><a href="accountmst.jsp">Account Master</a></li>
  										<li><a href="groupmst.jsp">Group Master</a></li>
   										<li><a href="costcenter.jsp">Cost Center</a></li>
   										<li><a href="productmst.jsp">Product Master</a></li>
   									</ul>
								</li>
						</ul>
					</li>
       			<%}if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")){%>
<!--        		  		<li><a href="collection.jsp">Collection</a></li> -->
							<li><a href="#">Collection</a>
								<ul>
  									<li><a href="collection.jsp">Collection</a></li>
  									<li><a href="PaymentReport.jsp">Payment Report</a></li>
  									<li><a href="deductionreport.jsp">Payment Deduction</a></li>
  									<li><a href="followupMarketingRep.jsp">Follow-Up Report</a></li>
				<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
					{%>
               		<li><a href="TransactionReport.jsp">Transaction Report</a></li> 
               		<%}
               		else
               		{
               		%>
               		
               		<%} %>
   								</ul>
   							</li>
       		  		<li><a href="collectionStaffReport.jsp">Collection Staff</a></li>
		 		<%}%>
		 			<li><a href="Reconsilation.jsp">Reconciliation</a></li>
		 			<li><a href="Emaildetails.jsp">Email Template</a></li>
		 			<%if(SalesAdmin.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
		 				<li><a href="GlobalSearch_1.jsp">Global Search</a></li>
		 			<%} %>
				</ul>
   			</li>
   			<li><a href='#'>Reports</a>
   				<ul>
   				<!-- <li><a	href="PurchaseIndentReport.jsp">Purchase Indent Report</a></li> -->
   						<%
   				
   				if(session.getAttribute("CompanyMasterID").toString().equalsIgnoreCase("100039")){
   					
   					//System.out.println("in if item master");
   				%>
     			
     			<li><a href="ItemMaster.jsp">Item Master</a></li> 
     			<li><a href="SupplierMaster.jsp">Supplier Master</a></li> 
     			
     		<%}%>
   				
   				<li><a	href="CustomerMaster1.jsp">Customer Master</a></li>
   				<li><a	href="FunnelReportNew.jsp">Funnel Report</a></li>
   				<%
   				
   				if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5") && PurchaseAdmin.equalsIgnoreCase("Yes")) || session.getAttribute("userLevel").toString().equalsIgnoreCase("level6") ||(Admin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")) ){%>
     			
     			<li><a	href="PendingPurchaseOrderList.jsp">Pending Order Report</a></li> 
     		<%}
   				if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){ %>
   			  		<li><a href="marketingCustomerReportDateWise.jsp">Follow-Up</a></li>
              		<li><a href="customer_wise_ledger.jsp">Aging</a></li>
              		<li><a href="salesEnqReport.jsp?id=">Sales Enquiry</a></li>
               		<li><a href="ledgerdetails.jsp">Ledger A/c Details</a></li>
               		<li><a href="marketingReport.jsp">Marketing</a></li>
               		<li><a href="ShowEnquiry.jsp">Sales Master</a></li>
               		<li><a href="InvoiceDetailsReport.jsp">Invoice GST Detail</a></li>
               		
         		<%}%>
         		<% if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")){%>
         		<li><a href="customer_wise_ledger.jsp">Aging</a></li>
         		<%} %>
         		<%if(session.getAttribute("isMarketingRepresentive")!=null){%> 
               		<li><a href="DashBoardForMarkt.jsp">Dash Board</a></li>
               		<li><a href="ProspectStatusReport.jsp">Prospects Detail</a></li>
          		<%}%>
          		<%if(Admin.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")){ %>
               		<li><a href="addNewMarketingRep.jsp?type=new">New Marketing Rep</a></li>
               		<li><a href="Marketingeditreport.jsp">Master Marketing</a></li>
               		<li><a href="followupMarketingRep.jsp">Customer Follow-Up</a></li>
          		<%}%>
               		<li><a href="ComplaintReport.jsp">My Complaints</a></li>
               		<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) && 
               				(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")) )
					{%>
               		<li><a href="TransactionReport.jsp">Transaction Report</a></li> 
               		<%}
               		else
               		{
               		%>
               		
               		<%} %>
               		
               		<li><a	href="ASCInvoiceDetails.jsp">ASC Invoice Details</a></li>
               			      					    	<li><a href="contractdetails.jsp">Contract Report</a></li>
               			      					    	
               			      					    	               			      	<li><a href="MonthBillReport.jsp">Invoice Monthly Report</a></li>
               			      					    	               			      	         							<li><a href="customerwiseledger.jsp">Ledger Summary Report</a></li>
               			      					    	               			      	
               			      					    	
               		
   				</ul>
   			</li>
   			<li><a href='#'>Tools</a>
   				<ul>
   					<li><a href="ChangePassword.jsp">Change Password</a></li>
   				</ul>
   			</li>
   			<%if(Admin.equalsIgnoreCase("Yes") || SuperAdmin.equalsIgnoreCase("Yes")){%>
   			<li><a href='#'>Admin</a>
   				<ul>
   		 		<%if(Admin.equalsIgnoreCase("Yes")){%>
         			<li><a	href="AdminModule.jsp">User Master</a></li>
         		<%}%>
         		<%if((SuperAdmin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level6"))){ %>
		  	    	
		  	    	
		  	    	<!-- <li><a	href="AdminModuleMaster.jsp">Company Master</a></li> -->
		  	    	<li><a	href="companyReport.jsp">Company Master</a></li>
		  	    	<li><a	href="createComp.jsp">Add New Company</a></li>
		  	    	<li><a	href="UserAccessControl.jsp">Role Management</a></li>
     			<%}%>
   				</ul>
   			</li>
   			<%}%>
   			<li><a href="logout.jsp"><font color=red>[ Logout ] : &nbsp; </font><%=session.getAttribute("EmpName")%></a></li>
		</ul>
</div>
<div id="enqMenu" class="dropmenudiv">
	<a href="sales.jsp">new enquiry</a>
</div>
<script type="text/javascript">
	cssdropdown.startchrome("menu");
</script></div>
<div style="background-color: #1582AB;">
<a href="#" onclick="openpopup('<%=PageName%>')"><font size="2" style="color: white;font-family: Montserrat, sans-serif;"><b>Register Complaint</a>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 Report No.: <%=reportno %></b>
		 
		 </font>
</div>

<%}
catch(Exception e)
{
	e.printStackTrace();
	//String comType2=session.getAttribute("CompanyType").toString();
		//System.out.println("Session Com Type Value ---------"+comType2);
	//System.out.println(" Exception    ******* "+e);
}
finally
{
	if(sessionconn!=null)
	{
	sessionconn.close();
	}
}
%>
</body>
</html><html><head></head><body></body></html><html><head></head><body></body></html>