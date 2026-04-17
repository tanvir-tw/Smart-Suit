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
		String fromDateCal = "", toDateCal = "",CompanyName="",tallyname="",customercode="",company="";
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
	
	<form name="tally" method="get" action="TallyInterface.jsp">
	
	<table align="center" class='sortable' border="0" >
	<tr>
	
	<th>COMPANY NAME</th>
	<th>Tally Customer Name</th>
	
	</tr>
	<%
			String sql1 = "Select CompanyName,TallyName,CustomerCode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet WHERE TallyName IS NOT NULL ";
			ResultSet rs1 = st.executeQuery(sql1);
			while(rs1.next()){
		%>
	<tr>
	<td><input type="hidden" name="company" value="<%=rs1.getString("CompanyName") %>"/><a href="#" onclick="window.open('TallyInterface.jsp?CompanyName=<%=rs1.getString("CompanyName")%>&erpcustomer=<%=rs1.getString("CustomerCode")%>')"><%=rs1.getString("CompanyName") %></a></td>
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