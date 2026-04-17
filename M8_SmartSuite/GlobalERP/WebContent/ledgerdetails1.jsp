<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
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
	<title>Transworld Compressor-Technologies LTD, ERP</title>
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
	<body>

	<script language="JavaScript1.2">

	function getCompanies(prospect)
	{
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
			ajaxRequest.open("GET", "AjaxGetLedgerCompanies.jsp" + queryString, true);
			ajaxRequest.send(null); 
		
	}
function sendSMS(){

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

	
	function hideResult(i,j,k,l,m,n) {
		
		document.getElementById('visitingCard').style.visibility='visible';
		document.ledgerDetails.companyNames.value=i;
		document.getElementById('companyList').style.height = '10px'; 
		document.getElementById('companyList').style.visibility = 'hidden';
		document.ledgerDetails.companyName.value=i;
		
		document.ledgerDetails.companyEmail.value=k;
		document.ledgerDetails.companyPerson.value=j;
		document.ledgerDetails.companyCity.value=l;
		document.ledgerDetails.companyProduct.value=n;
		document.ledgerDetails.companyPhone.value=m;

		 document.getElementById('tabS').style.visibility='hidden';
 
	}
	function newwindow(webadd)
	{ 
		window.open(webadd+'?email='+document.ledgerDetails.companyEmail.value+'&company='+document.ledgerDetails.companyName.value,'jav','width=470,height=400,top=250,left=600,resizable=no');
	}

	 
	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>


	<div id="wrapper">
	<div id="header-wrapper">
	<div id="header">
	<div id="logo">
	<table>
		<tr>
			<td><a href="http://www.transworldcompressor.com/"> <img
				src="images/transworld.jpg"></img> </a></td>
			<td>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>

			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><img src="images/erp.jpeg" height="70" width="220"></img></td>
		</tr>
	</table>
	</div>
	<div id="menu">
	<ul>
		<li><a href="home.jsp">Home</a></li>
		<li><a href="http://blog.transworld-compressor.com/">Blog</a></li>
		<li class="current_page_item"><a href="#" rel="dropmenu1">Reports</a></li>
		<li><a href="logout.jsp"><font color=red>|Logout|<br>
		</font><%=session.getAttribute("EmpName") %></a></li>
	</ul>
	</div>

	</div>
	</div>
	<div id="dropmenu1" class="dropmenudiv"><a
		href="followUpReport.jsp">Follow-Up Report</a> <a
		href="ledgerdetails.jsp">Ledger A/c Details</a> <a
		href="idleTimeReport.jsp?report_name=stopTimeReport">Report3</a> 
		<a href="garbagedisposalreport.jsp?report_name=stopTimeReport">Report 4</a></div>
	<script type="text/javascript">

cssdropdown.startchrome("menu");

</script>
	<!-- end #header --> <!-- end #page --></div>
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
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
	if (!(null == request.getParameter("companyNames"))) 
	{
		companyName=request.getParameter("companyNames");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct");
	}	
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
			} catch (Exception e) {
			}
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>
 

<div
		style="font-size: 1.6em; align:center;"><a> 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  Ledger A/c's Details</a>
 </div>
<form name='ledgerDetails' action="" method="get" >

<table>
<tr>
<td style="width: 20px">

<div id="visitingCard" style="visibility: visible;">
			<table  bgcolor="#C6DEFF">
				<tr>
					<td align="left"><div id="Company"><b>Company</b></div></td>
					<td align="left">
					<div id="companyName"><input type="text" name="companyName"
						id="search-text" value="<%=companyName %>"
						style='border-style: none; width: 200px; height: 12px;' /></div>
					</td>
					<td align="center" style="width: 25%"><div id="Contact"><b>Contact </b></div></td>
					<td valign="top" align="right">
					<div id="companyPerson"><input type="text"
						name="companyPerson" id="search-text" value="<%=contact %>"
						style='border-style: none; width: 200px;' /></div>
					</td>

				</tr>
								<tr>
					<td align="left"><div id="Phone"><b>Phone</b></div></td>
					<td align="left">
					<div id="companyPhone"><input type="text" name="companyPhone"
						id="search-text" value="<%=phone %>"
						style='border-style: none; width: 200px; height: 12px;' /></div>
					</td>
					<td align="center" style="width: 25%"><div id="Email"><b>E-Mail </b></div></td>
					<td valign="top" align="right">
					<div id="companyEmail">
					<textarea
										name="companyEmail" rows="1" id="search-text"  
										style='border-style: none; width: 200px; height: 30px'><%=email %></textarea>
		 </div>
					</td>

				</tr>
								</tr>
								<tr>
					<td align="left"><div id="Product"><b>Product</b></div></td>
					<td align="left">
					<div id="companyProduct"><input type="text" name="companyProduct"
						id="search-text" value="<%=product %>"
						style='border-style: none; width: 200px; height: 12px;' /></div>
					</td>
					<td align="center" style="width: 25%"><div id=City"><b>City </b></div></td>
					<td valign="top" align="right">
					<div id="companyCity"><input type="text"
						name="companyCity" id="search-text" value="<%=city %>"
						style='border-style: none; width: 200px;' /></div>
					</td>

				</tr>
				</table>

</div>

</td><td align="left">
<table><tr><td>
<a href="#"  style="font-weight: bold; color: black; " onClick="sendSMS(); return false">
SMS v.c.</a>
</td></tr>
<tr><td>

 

<a href="#" style="font-weight: bold; color: black;" onclick="newwindow('emailTransactions.jsp');">EMAIL Transactions</a>
<%System.out.println(">>.cmp+  email "+companyName+email); %>
</td></tr>
</table>
</td>
<td>
 

</td>
</tr>
</table>

<table width="100%">
		<tr>
							<td align="right" valign="top">
							<div id="companyNames">Company Name: &nbsp;
							<input type="text" name="companyNames" id="search-text"
								 style="width: 300" value='<%=companyName %>'  
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
 


			<td align="left" valign="top">
			<b>From </b>&nbsp;&nbsp;
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
			<td align="left" valign="top">
			<b>To </b>&nbsp;&nbsp;
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
			</td>
			
			<td colspan=2 align="left" valign="top"><input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO"></input></td>
				<td align="right">
								<div align="right"> <font size="1">&nbsp;&nbsp;&nbsp;<%=new java.util.Date()%></font>
				<a href="#" onclick="javascript:window.open('excel_currentposition_report.jsp?division=d&ward=w&vehicle=y');" title="Export To Excel">
				<img src="images/excel.jpg"	width="15px" height="15px"></img></a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			</div>
				</td>
		</tr>
		
	</table>


</form>

<br></br>



<%
if(null != request.getQueryString())
{
%> 
<%	
String sqlDetails="",companyCode="";;
 
String s1="0",s2="0",s3="0";

			String sql = "SELECT CustomerCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName ='"
					+ request.getParameter("companyNames") + "' ";
			ResultSet rsCode = st1.executeQuery(sql);
			if (rsCode.next()) {

				String sqlTotal = "SELECT sum(DebitAmount),SUM(CreditAmount),SUM(Balance) FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
					+  rsCode.getString(1)
					+ "' and  TransactionDate between '"
					+ fromDate
					+ "' and '"
					+ toDate
					+ "' ORDER BY TransactionDate DESC";
				System.out.println("QRY->> "+sqlTotal);
				ResultSet rsTotal = st2.executeQuery(sqlTotal);
				if (rsTotal.next()) {
					s1=rsTotal.getString(1);
				s2=rsTotal.getString(1);
					s3=rsTotal.getString(1);
					}
%><div id="tabS" style="visibility: visible;">


 <!--  
<table border="1px" width="100%" class="sortable">
 	<tr style="background-color: #C6DEFF;">
		<td style="background-color: #C6DEFF;" width="35%">Total:  
          </td>
 	<td style="background-color: #C6DEFF;" align="left"><div align="left">
 < %=rsTotal.getString(1) %> 
 < %=rsTotal.getString(2) %> 
 < %=rsTotal.getString(3) %> </div></td> 
	</tr>
 
 
	</table> -->
	<table border="1px"  class="sortable">
	<tr>
		<th>Sr.No</th>
		<th>Tr. Date</th>
		<th>Tr. ID</th>
		<th>Debit</th>
		<th>Credit</th>
		<th>Balance</th>
		<th>Voucher No.</th>
		<th>Desc.</th>
		<th>Sign</th>
	</tr>
	<%
	//	}
					companyCode = rsCode.getString(1);

					int i = 1;
					sqlDetails = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
							+ companyCode
							+ "' and  TransactionDate between '"
							+ fromDate
							+ "' and '"
							+ toDate
							+ "' ORDER BY TransactionDate DESC";
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) {
	%>
	<tr>
		<td align="left">
		<div align="left"><%=i++%></div>
		</td>
		<td>
		<div align="right"><%=new SimpleDateFormat(
												"dd-MMM-yyyy")
												.format(new SimpleDateFormat(
														"yyyy-MM-dd")
														.parse(rsDetails
																.getString("TransactionDate")))%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("TransactionDetail")%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("DebitAmount")%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("CreditAmount")%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("Balance")%></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("PaymentVoucherNo")%></div>
		</td>
		<td>
		<div align="left"><%=rsDetails.getString("TransactionType")%></div>
		</td>
		<td>
		<div align="left"><%=rsDetails.getString("EmpName")%></div>
		</td>



	</tr>
	<%
		}
					%>

<tr style="background-color: #C6DEFF;">
		<td colspan="3" style="background-color: #C6DEFF;" >Total:  
          </td>
 	<td style="background-color: #C6DEFF;" align="right"> <div align="right"><%=s1 %></div></td>
 	<td style="background-color: #C6DEFF;" align="right"> <div align="right"><%=s2 %></div></td>
 	<td style="background-color: #C6DEFF;" align="right"> <div align="right"><%=s3 %></div></td>
 	<td colspan="3" style="background-color: #C6DEFF;" align="left"> .</td>  
 
 </tr>
					<%
				}
}
%>
</table>
</div>
	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
		<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>