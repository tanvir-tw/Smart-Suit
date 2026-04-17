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
		String fromDateCal = "", toDateCal = "",SupplierName="",tallyname="",customercode="",company="";
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
	<a>Tally Customer List</a>
	</div>
	
	<form name="tally" method="get" action="TallySupInterface.jsp">
	
	<table align="center" class='sortable' border="0" >
	<tr>
	
	<th>COMPANY NAME</th>
	<th>Tally Supplier Name</th>
	
	</tr>
	<%
			String sql1 = "Select SupplierName,TallyName,SupplierCode from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet WHERE TallyName IS NOT NULL AND TransactionExisted='yes'";
			ResultSet rs1 = st.executeQuery(sql1);
			while(rs1.next()){
		%>
	<tr>
	<td><input type="hidden" name="supplier" value="<%=rs1.getString("SupplierName") %>"/><a href="#" onclick="window.open('TallySupInterface.jsp?SupplierName=<%=rs1.getString("SupplierName")%>&erpsupplier=<%=rs1.getString("SupplierCode")%>')"><%=rs1.getString("SupplierName") %></a></td>
	<td><%=rs1.getString("TallyName") %></td>
	</tr>
	<%} %>
	</table>
	
	<br>
	<br>
		
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