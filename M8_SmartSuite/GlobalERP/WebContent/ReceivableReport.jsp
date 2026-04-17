<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<script src="dropdown.js" type="text/javascript"></script>
<script src="ledgerDetails.js" type="text/javascript"></script>

<script language="JavaScript1.2">
function gotoExcel (elemId, frmFldId)  
{  
	//alert("*********** ");

         var obj = document.getElementById(elemId);  
         var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  

          document.addfollowup2.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["addfollowup2"].submit();       // CHANGE FORM NAME HERE

} 
</script>

<%
	 erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
String sort="SrNo";
try{
	 sort=request.getParameter("sort");
	 if(sort==null)
			sort="SrNo";
}catch(Exception e){
	sort="SrNo";
}
String str="";
	String comid=session.getAttribute("CompanyMasterID").toString();
%>
<%
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null ,s5=null;
			Statement st2 = null;
			String selectedName,emp="";
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String companyName="",phone="",contact="",email="",product="",city="",status="";
			String repcode="",repname="";
			int i=1;
%>
<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, 30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) 
	{
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate")))
	{
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	try
	{
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		s5 = conn.createStatement();
	}
	catch (Exception e)
	{
	}
		
%>
 
<div style="font-size: 1.7em; text-align: center;">
		<a>Payment Expected In Next 1 Month </a>
</div>
 <br>
 <div id="dashboard">
 <form name="addfollowup2" method="post" action="" ">	  	
	<%
	String exportFileName="Receviable_Report.xls";  // GIVE YOUR REPORT NAME
	%>
<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%=exportFileName%>" />

	<table align="right"><tr>	
				<td>
<!-- 				<select name="sort"> -->
<%-- 	<% if(sort.equalsIgnoreCase("SrNo")){ --%>
<%-- 	%><option value="SrNo" selected="selected">SrNo</option><% --%>
<%-- 	}else{%> --%>
<!-- 	<option value="SrNo">SrNo</option> -->
<%-- 	<%} if(sort.equalsIgnoreCase("ProspCustName")){%><option value="ProspCustName" selected>Party Name</option><%}else{ %> --%>
<!-- 	<option value="ProspCustName">Party Name</option> -->
<%-- 	<%}if(sort.equalsIgnoreCase("AmountExpectedOn")){%><option value="AmountExpectedOn" selected>Excepted On</option><%}else{%> --%>
<!-- 	<option value="AmountExpectedOn">Expected On</option> -->
<%-- 	<%}if(sort.equalsIgnoreCase("AmountExpected")){%><option value="AmountExpected" selected>Excepted Amount(Rs.)</option><%}else{%> --%>
<!-- 	<option value="AmountExpected">Excepted Amount(Rs.)</option> -->
<%-- 	<%}if(sort.equalsIgnoreCase("FollowUpDate")){%><option value="FollowUpDate" selected>Entry By</option><%}else{%> --%>
<!-- 	<option value="FollowUpDate">Entry By</option> -->
<%-- 	<%}if(sort.equalsIgnoreCase("Comments")){%><option value="Comments" selected>Comments</option><%}else{%> --%>
<!-- 	<option value="Comments">Comments</option> -->
<%-- 	<%}%> --%>
	
<!-- 	</select> -->
				<select name="sort">
	<% if(sort.equalsIgnoreCase("SrNo")){
	%><option value="SrNo" selected="selected">SrNo</option><%
	}else{%>
	<option value="SrNo">SrNo</option>
	<%} if(sort.equalsIgnoreCase("ProspCustName")){%><option value="ProspCustName" selected>Party Name</option><%}else{ %>
	<option value="ProspCustName">Party Name</option>
	<%}if(sort.equalsIgnoreCase("Comments")){%><option value="Comments" selected>Comments</option><%}else{%>
	<option value="Comments">Comments</option>
	<%}if(sort.equalsIgnoreCase("EmpName")){%><option value="EmpName" selected>Entry By</option><%}else{%> --%>
 	<option value="EmpName">Entry By</option> 
 	<%}%>
	
	</select>


	<input type="submit" value="Go"/>			
				</td>
				<td align="right">
				
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
<!-- 				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('dashboard','tableHTML');"> -->

<!-- 	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img> -->
	
<!-- 					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a> -->
			 
				</td>
	</tr></table>
	
 <br>
 
<!-- <table class="sortable"> -->
<!-- <tr> -->
<!-- <th>Sr No</th> -->
<!-- <th>Party Name</th> -->
<!-- <th>Excepted On </th> -->
<!-- <th>Excepted Amount(Rs.)</th> -->
<!-- <th>Entry On</th> -->
<!-- <th>Entry By</th> -->
<!-- <th>Comments</th> -->
<!-- </tr> -->
<%

String sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"followup where PaymentFollowup='Yes' and AmountExpectedOn between '"+toDate+"' and '"+fromDate+"'";
//ResultSet  rs=st.executeQuery(sql);
System.out.println(sql);
//out.println(sort);

%>
<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http://twtech.in:8080/birt/frameset?__report=ReceivableReport.rptdesign&fromdate=<%=toDate %>&todate=<%= fromDate %>&Sort=<%=sort %>&companyid=<%=comid %>&__showtitle=false">
</iframe> 
</div>
<%
// while(rs.next())
// {

// 	repcode=rs.getString("MarketingRepcode");
// 	String sql1="select EmpName from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpCode='"+repcode+"'";
// 	ResultSet rs1=st1.executeQuery(sql1);
// 	System.out.println(sql1);
// 	rs1.next();
// 	repname=rs1.getString(1);
%>
<!-- <tr> -->
<%-- <td><div align="right"><%=i++ %></div></td> --%>
<%-- <td><div align="left"><%=rs.getString("ProspCustName") %></div></td> --%>
<%-- <td><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("AmountExpectedOn"))) %></div></td> --%>
<%-- <td><div align="right"><%=rs.getString("AmountExpected") %></div></td> --%>
<%-- <td><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("FollowUpDate")))%></div></td> --%>
<%-- <td><div align="left"><%=repname %></div></td> --%>
<%-- <td><div align="left"><%=rs.getString("Comments") %></div></td> --%>
<!-- </tr> -->


<%	
//}
%> 
</table>
</form>
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
<%-- <%@include file="footer_new.jsp"%> --%>