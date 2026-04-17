<DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

 
<script language="JavaScript1.2">

function showVisitingCardDetails(companyName,customerCode){
	document.data.companyNames.value=companyName;
	document.getElementById("companyList").style.display='none';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	document.data.companyNames.value='';
}

function getCompanies(type)
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
	var queryString = "?company=" +company+"&type="+type;
	ajaxRequest.open("GET", "GenericAjaxSearch.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
function popUp(Address,companyName,SalesEnqNo,SalesEnqRefNo)
{ 
    window.open(Address+'?companyName='+companyName+'&SalesEnqNo='+SalesEnqNo+'&SalesEnqRefNo='+SalesEnqRefNo);
}

</script>
                                 	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;
    String selectedName;
	String FollowUpType="",status="";
	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";
	int j=1;int i=1;
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
	DecimalFormat nf = new DecimalFormat("0.00");
	
//	Date today = new Date();
//	Calendar cal = Calendar.getInstance();
//	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -1);
	Date yesterday = cal.getTime();
	String yesterdaysDate=new SimpleDateFormat("yyyy-MM-dd").format(yesterday);
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today);
	
	
	if (!(null == request.getParameter("fromdate"))) {
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	if (null == request.getParameter("customer"))
	selectedName = "All";
	else
	selectedName = request.getParameter("customer");
 		
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();

	if (null == request.getParameter("customer"))
	selectedName = "All";
	else
	selectedName = request.getParameter("customer");
	
	String id=request.getParameter("id");
	System.out.println("PARAMETER COMING IS     "+id);
	
%>

<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >
	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>All Reports</a></div>
	
	<form name="data" action="" method="get">
	<div align="center">
	<table border="0">
	<tr> 

     
	<td align="left">
	<b> </b>&nbsp;&nbsp;
	<input type="text" id="fromdate"
	name="fromdate" value="<%=fromDateCal %>" size="15" readonly
	style="width: 80px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 				
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
			
	<b>To </b>&nbsp;&nbsp;
	<input type="text" id="todate"
	name="todate" value="<%=toDateCal %>" size="15" readonly
	style="width: 80px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "todate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",    // the date format
	button      : "todate"       // ID of the button
	}
	);
	</script>
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" /></td>
	</tr>
	
	</table></div>
	</form>
	<br>
		
<% if(null != request.getQueryString())
	{%>
	<div
	style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Invoice Details</a></div>
	<br>
	<table border="1px" class="sortable">
	<tr>
	<th>Sr No</th>
	<th>Company</th>
	<th>Inv Ref No</th>
	<th>Grand Total</th>
	<th>City</th>
	<th>Inv Cancelled</th>
	<th>Updated In Tally</th>
	
	</tr>
	
	
	<%
			double grandTotal=0;
			String sql ="SELECT a.CustomerCode ,a.InvoiceNo , a.invoiceRefNo , a.GrandTotal , a.CurrValue ,a.TotalInWords, a.InvoiceDate , b.CompanyName, b.BillingCity , a.InvoiceCancelled, a.UpdatedinTally FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet AS a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet AS b ON(a.CustomerCode = b.CustomerCode) WHERE a.InvoiceDate between '"+fromDate+"' and '"+toDate+"'  AND a.TheGroup >0 ORDER BY a.Invoiceno  ";
			System.out.println(sql);
			ResultSet rsCode = st1.executeQuery(sql);
			while(rsCode.next())
			{
				try{
					String isInvoiceCanclled="No";
					if(rsCode.getInt("InvoiceCancelled")==1)
						isInvoiceCanclled="Yes";
		%>	
		<tr><td align=right> <%=i %> </td>
					<td align=left><%=rsCode.getString("CompanyName") %></td> 
					<td align=right><%=rsCode.getString("invoiceRefNo") %></td> 
					<td align=right><%=rsCode.getString("GrandTotal") %></td> 
					<td align=left><%=rsCode.getString("Billingcity") %></td> 
					<td align=left><%= isInvoiceCanclled%></td>
					<td align=left><%= rsCode.getString("Updatedintally")%></td>
		</tr> 
			<%		if(isInvoiceCanclled.equals("No"))
						grandTotal+=rsCode.getInt("GrandTotal");
					i++;
				}catch (Exception e) {
					System.out.println(e);
				}
			}
			 
			if(i!=1){
			%>
		<tr>
				<td style='background-color: #C6DEFF;' >Total: </td><td style='background-color: #C6DEFF;' colspan=2>*Cancelled Invoices are not considered in Total*</td>
				<td style='background-color: #C6DEFF;' align=right > <%=nf.format(grandTotal) %></div></td>
				<td style='background-color: #C6DEFF;' align=right colspan=5 ></td></tr>
		</table>
		<%		
			}
			else{
				 %>
				<table><tr><td style='background-color: #C6DEFF;' colspan=8>No Invoice was generated</td></tr></table>
	<%}
	
			%>
<br>
<br>
<br>
<br>
			<div
				style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
				<a>Invoice Details(Debits)</a></div>	
				<br>
			<table border="1px" class="sortable">	
			<tr>
			<th>Sr No</th>
			<th>Customer</th>
			<th>Inv No</th>
			<th>Amount</th>
			<th>City</th>
			<th>Cancelled</th>
			<th>Tally</th>
			</tr>
				
						
<%		/*

htmlString = htmlString+"<table width='90%' style='font-family:verdana;' border=1 align=center cellpadding=0 cellspacing=0><tr><td align=center colspan=10><b>"+headerString +"</b>" +
"<div align='right'>"+yesterdaysDateInMMMFromat+"</div></td></tr>";
*/

				
		String sqlDebit="select * from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails as a inner join "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on(a.CustomerCode=b.CustomerCode) where a.PaymentDetails='Debit Note' and a.PaymentDate between '"+fromDate+"' and '"+toDate+"' ";
		System.out.println("DEBIT bnOTE    KKJKL  "+sqlDebit);
		ResultSet rsdebit=st1.executeQuery(sqlDebit);
		while(rsdebit.next())
		{
			
%>					
		<tr>
		<td align=right> <%= j%></td>
		<td align=left><%=rsdebit.getString("CompanyName") %></td> 
		<td align=right><%=rsdebit.getString("PaymentVoucherNo") %></td> 
		<td align=right><%=rsdebit.getString("AmountPaid") %></td> 
		<td align=left><%=rsdebit.getString("BillingCity") %></td> 
		<td align=left>-</td> 
		<td align=left>-</td>
		</tr> 
		
	<%
	j++;	
	}
	if(j!=1)
	{
	%>
	<tr>
	 <td style='background-color: #C6DEFF;' >Total: </td><td style='background-color: #C6DEFF;' colspan=2>*Cancelled Invoices are not considered in Total*</td>
	 <td style='background-color: #C6DEFF;' align=right > <%=nf.format(grandTotal) %></div></td>
	 <td style='background-color: #C6DEFF;' align=right colspan=5 ></td></tr>
				<% //	flagIdData=true;%>

	<% 				
				} 
				
				else{
%>
	<tr><td style='background-color: #C6DEFF;' colspan=7>NO DATA</td></tr></table>
				<% }%>
<br>
<br>

<!-- 
		<div
				style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
				<a>Submit Following Cheques Today</a></div>	
			<br>
			<br>
			<table border="1px" class="sortable">
			<tr>
				<th>Sr No</th>
				<th>Customer</th>
				<th>Amount</th>
				<th>Date</th>
				<th>Check Id </th>
				<th>City</th>
				<th>Bank</th>
				<th>Branch</th>
			</tr>	
			
	 -->	


				<div
				style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
				<a>Payment Details</a></div>
	<br>
	<br>
<table border="1px" class="sortable">
<tr>
		<th>Sr No</th>
		<th>Customer</th>
		<th>VoucherNo</th>
		<th>Amount Paid</th>
		<th>Date</th>
		<th>Mode</th>
		<th>ID</th>
		<th>Cheque Date</th>
		<th>PDC</th>
		<th>Tally</th>
		<th>Bank</th>
		<th>Branch</th>
		<th>City</th>
	</tr>	
		<%		
			int k=1;i=1;double sumOfPayment=0;
			//for payment
			
		/*	htmlString = htmlString+"<table width='90%' border=1 style='font-family:verdana;' align=center  cellpadding=0 cellspacing=0><tr><td align=center colspan=13><b>"+headerString +"</b><div align='right'>"+yesterdaysDateInMMMFromat+"</div></td></tr>";
	*/		
			
			String x="";
			
			String sqlPayment=" SELECT DISTINCT a . * , b.CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails AS a "+
			" INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet AS b ON ( a.CustomerCode = b.CustomerCode ) "+
			"  WHERE (date(a.inserdt) between '"+fromDate+"' and '"+toDate+"'   OR a.PaymentDate='"+fromDate+"' and '"+toDate+"')  AND a.PaymentMode <> 'Debit Note' " +
			"  ORDER BY a.PaymentDate ";
			
			ResultSet rsPayment=st1.executeQuery(sqlPayment);
			System.out.println(sqlPayment);
			while(rsPayment.next())
			{
				System.out.println("IN WHILE   ");
				try{
					String isPDC="-";
					try{
					if(rsPayment.getString("ChOrDDEncashedStatus").equalsIgnoreCase("PDC"))
						isPDC="Yes";}catch (Exception e) {
						}
						
					String paymentMode=rsPayment.getString("PaymentMode");
					if(rsPayment.getString("PaymentMode").equalsIgnoreCase("Cash"))
					paymentMode="NEFT";	
			%>			
				<tr>
					<td align=right><%= k%></td> 
					<td align=left><%=rsPayment.getString("CompanyName") %></td> 
					<td align=right><%=rsPayment.getString("PaymentVoucherNo") %></td> 
					<td align=right><%=rsPayment.getString("AmountPaid") %></td> 
					<td align=left><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsPayment.getString("PaymentDate"))) %></td> 
					<td align=left><%=paymentMode%></td> 
					<td align=right><%=(null==rsPayment.getString("ChOrDDorCreditNoteNo")?"-":rsPayment.getString("ChOrDDorCreditNoteNo")) %></td> 
					<td align=right><%=new SimpleDateFormat("dd-MMM-yyyy")
					.format(new SimpleDateFormat("yyyy-MM-dd")
					.parse(rsPayment.getString("ChOrDDorCreditNoteDate"))) %></td> 
					<td align=left><%=isPDC %></td> 
					<td align=left><%=(null==rsPayment.getString("Tallyrefno")?"-":rsPayment.getString("Tallyrefno")) %></td> 
					<td align=left><%=(null==rsPayment.getString("BankName")?"-":rsPayment.getString("BankName")) %></td> 
					<td align=left><%=(null==rsPayment.getString("BranchName")?"-":rsPayment.getString("BranchName")) %></td> 
					<td align=left><%=(null==rsPayment.getString("City")?"-":rsPayment.getString("City")) %></td> 
					</tr>
					
				<%	if(!rsPayment.getString("PaymentMode").equals("Credit Note") || !rsPayment.getString("ChOrDDEncashedStatus").equals("PDC") || rsPayment.getString("ChOrDDorCreditNoteDate").equals(yesterdaysDate))
					{sumOfPayment+=rsPayment.getDouble("AmountPaid");
					System.out.println(">>>  AMMIUNHU   "+sumOfPayment);}
			     	else {sumOfPayment=0;}
					System.out.println(">>>>>>>>>>    "+k);
					k++;
					
				}catch (Exception e) {
					System.out.println(e);
					e.printStackTrace();
				}			
			}

			if(k!=1)
			{
				System.out.println("VALUE *********    "+k);
			 %>
			<tr>
				<td style='background-color: #C6DEFF;' >Total:"+  
				</td><td style='background-color: #C6DEFF;' colspan=2 ></td>
				<td style='background-color: #C6DEFF;' align=right ><%=nf.format(sumOfPayment) %></div>&nbsp;</td>
				<td style='background-color: #C6DEFF;' align=left colspan=10  >   *Credit Notes,PDC ,PreDated Entries are not considered in total*  </div></td>
				</tr>
				
				<%//flagIdData=true;
			}
			else
			{
				System.out.println("VALUE OF KK    "+k);%>
		<tr><td style='background-color: #C6DEFF;' colspan=13>NO DATA</td></tr></table>
	<%		} %>
	
				
	<br>
	<br>
<%}	
	} catch(Exception e)
	{
	e.printStackTrace();
	}

%>


	
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <br><br><br><br><br><br><br><br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
<!-- end #footer -->
</body>
</html>
</jsp:useBean>