<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%><%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<body onLoad="resetAll();">	
<script type="text/javascript">
</script>
 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType = "";
			String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
			String fromDateCal="",toDateCal="",fromDate="",toDate="";
			
			
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
			 String paymentno=request.getParameter("PaymentEntryNo");
			 System.out.println(paymentno);
	%>
	<%
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			}
		
	%>
	
	
		<div style="font-size: 1.5em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
	<a>Payment Entry</a> </div>
	<div id="entryform" style="width:98%; position:absolute; background-color: #E1F3F3; ">
	<form name="paymentapproval" method="post" action="insertPaymentEntry.jsp?id=Update" >
	
	<input type="hidden" name="paymentno" id="paymentno" value="<%=paymentno %>"/>
	<%
	String sqlData="Select * from "+session.getAttribute("CompanyMasterID").toString()+"paymentEntryDet where PaymentEntryNo='"+paymentno+"'";
	System.out.println(")()(()(      "+sqlData);
	ResultSet rsData=st.executeQuery(sqlData);
	if(rsData.next())
	{	
	%>
	
	<table align="center" class="sortable">
	<tr>
	<td><b>Payment Entry On:</b></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsData.getString("EntryDate")))%></td>
	<td><b>Company:</b></td>
	<td><%=rsData.getString("PartyName") %></td>
	</tr>
	<tr>
	<td><b>Bill No:</b></td>
	<td><%=rsData.getString("BillNo") %></td>
	<td><b>Bill Date:</b></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsData.getString("BillDate"))) %></td>
	
	</tr>
	<tr>
	<td><b>Amount:</b></td>
	<td><%=rsData.getString("Amount") %></td>
	<td><b>Due Date:</b></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsData.getString("DueDate"))) %></td>
	
	</tr>
	<tr>
	<td align="left"><b>Approve Amount:</b></td>
	<td align="right"><input type="text" name="approveamount" id="search-text"  style="width:170px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; "/></td>
	<td align="left"><b>Comments By HOD :</b></td>
	<td align="right"><input type="text" name="commentsbyhod" id="search-text"  style="width:170px;height:25px;   padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; "/></td>
	
	</tr>
	<tr>
	
	</tr>
	<%} %>
	</table>
	<br>
	<div align="center">
	<input type="submit" value="Submit" style="border: outset; background-color: #C6DEFF" />
	</div>
	</form>
	</div>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	
	</body>
	</html>
</jsp:useBean>