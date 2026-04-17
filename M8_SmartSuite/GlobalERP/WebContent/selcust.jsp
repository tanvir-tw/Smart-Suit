<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

 
<script language="JavaScript1.2">
</script>
                                	                                                                                                              
 	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null;
		Statement st2 = null;
		
	%>
	<%
		String fromDateCal = "", toDateCal = "",CompanyName="",tallyname="",customercode="",customer="";
		fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new java.util.Date());
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
	<div
		style="font-size: 1.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
	<a>Customer's With Transaction's in last 6 Months</a>
	</div>
	
	<form name="tally" method="get" action="">
	
	<table align="center" class='sortable' border="0" >
	<tr>
	
	<th>COMPANY NAME</th>
	
	<%
			String sql1 = "Select CompanyName as customer from "+session.getAttribute("CompanyMasterID").toString()+"customerdet ";
			ResultSet rs1 = st.executeQuery(sql1);
			while(rs1.next()){
				
			String cust=rs1.getString(1);	
		
			String sqlInvoice="Select  CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet Where CompanyName='"+cust+"' and InvoiceDate BETWEEN '2000-04-01' AND '2011-09-30' ";	
			System.out.println(sqlInvoice);
			ResultSet rsInvoice=st1.executeQuery(sqlInvoice);
			while(rsInvoice.next())
			{
				
			String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"customerdet SET TransactionExisted='yes' WHERE  CompanyName='"+cust+"' ";	
			System.out.println(sqlUpdate);
			st2.executeUpdate(sqlUpdate);
		%>
	<tr>
	<td><%=rsInvoice.getString("CompanyName") %></td>
	
	</tr>
	<%}} %>
	</table>
	</form>
	
	<form name="tally1" method="get" action="">
	
	<table align="center" class='sortable' border="0" >
	<tr>
	
	<th>COMPANY NAME</th>
	
	<%
			String sqlSupplier = "Select SupplierCode as code  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet ";
			ResultSet rsSupplier = st.executeQuery(sqlSupplier);
			while(rsSupplier.next()){
				
			//String cust1=rsSupplier.getString(1);	
			String code=rsSupplier.getString(1);
			
			String sqlInvoice="Select SupplierCode from "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice  Where SupplierCode='"+code+"' and PurInvoiceDate BETWEEN '2000-04-01' AND '2011-09-30' ";	
			System.out.println(sqlInvoice);
			ResultSet rsInvoice=st1.executeQuery(sqlInvoice);
			while(rsInvoice.next())
			{
				
			String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"supplierdet SET TransactionExisted='yes' WHERE  SupplierCode='"+code+"' ";	
			System.out.println(sqlUpdate);
			st2.executeUpdate(sqlUpdate);
		%>
	<tr>
	<td><%=rsInvoice.getString(1) %></td>
	
	</tr>
	<%}} %>
	</table>
	</form>
	
	
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