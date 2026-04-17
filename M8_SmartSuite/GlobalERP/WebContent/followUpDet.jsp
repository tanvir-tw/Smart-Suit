<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

	<script language="JavaScript1.2">

	function popUp()
	{
		//alert("IN popup");
		document.getElementById("showdocuments").style.visibility="visible";
	}

	function cancelentryform()
	{
		document.getElementById("showdocuments").style.visibility="hidden";
	}
	
	 
	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>


	 
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
			String fromDate="",toDate="",fromDateCal="",toDateCal="",date1="",date2="";
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
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	if (!(null == request.getParameter("companyName"))) 
	{
		companyName=request.getParameter("companyName");
		System.out.println(">>>>>>>>>>     "+companyName);
		date1=request.getParameter("date1");
		System.out.println(">>>>>>>>>>     "+date1);
		date2=request.getParameter("date2");
		System.out.println(">>>>>>>>>>     "+date2);
	}	
try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
		 
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>
 
	<div
		style="font-size: 1.5em; text-align: center; margin-top: 5px; margin-bottom: 5px;"><a> 

		  FollowUp Report for <%=request.getParameter("companyName") %></a>
 </div>
<form name='ledgerDetails' action="" method="get" >
</form>

<br></br>


<br><br>

<%	
String sqlDetails="",companyCode="",openingBalance=null;
double sumDebit=0,sumCredit=0;

%><div id="tabS" style="visibility: visible;">

	<table border="1px"  class="sortable" width="75%">
	<tr>
	<th>Sr.No</th>
	<th>Sign</th> 
	<th>Follow-Up Date</th>
	<th>Status</th>
	<th>Comments</th>
	<th>Follow-Up Type</th>
	<th>Next Follow Up Date</th>
	<th>Preparation For Next FollowUp</th>
	<th>Payment Follow-Up</th>
	<th>Expected Amount</th>
	<th>Spoken To</th>
	<th>Reply</th>
	<th>Remarks</th>
	<th>File Attched</th>
	</tr>
 <% 
 
					int i = 1;
					sqlDetails = " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup AS a LEFT OUTER JOIN   "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
					"  AS b ON ( a.MarketingRepCode = b.MarketingRepCode )			"+
					"where a.ProspCustName='"+request.getParameter("companyName")+"'  and followupdate between '"+date2+"' and "+
					" '"+date1+"'  ORDER BY  a.followupdate DESC ";
					System.out.println(sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) {
						%>
						<tr>
						<td align="left"><div align ="right"><%=i++ %></div></td>
							<td align="left"><div align ="left"><%=rsDetails.getString("MarketingRepName") %></div></td>
						<td><div align ="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
									(rsDetails.getString("FollowUpDate")))%></div></td>
						<td><div align ="left"><%=rsDetails.getString("Status") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("Comments") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("FollowUpType") %></div></td>
						<td><div align ="left"><%=new SimpleDateFormat(
																"dd-MMM-yyyy")
																.format(new SimpleDateFormat(
																		"yyyy-MM-dd")
																		.parse(rsDetails
																				.getString("NextFollowUpDate")))%></div></td>
						<td><div align ="left"><%=((rsDetails.getString("Preparation")!=null ) && (rsDetails.getString("Preparation")!="" ) ? rsDetails.getString("Preparation") : "-") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("PaymentFollowup") %></div></td>
						<td><div align ="right"><%=((rsDetails.getString("AmountExpected")!=null ) && (rsDetails.getString("AmountExpected")!="" ) ? rsDetails.getString("AmountExpected") : "-") %></div></td>
						<td><div align ="left"><%=((rsDetails.getString("SpokenTo")!=null ) && (rsDetails.getString("SpokenTo")!="" ) ? rsDetails.getString("SpokenTo") : "-") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("Reply") %></div></td>
						<td><div align ="left"><%=((rsDetails.getString("Remarks")!=null ) && (rsDetails.getString("Remarks")!="" ) ? rsDetails.getString("Remarks") : "-") %></div></td>
						
						<td><a href="ftp://sumedh:789&*(medh@202.38.172.58/ERPDocuments/<%=rsDetails.getString("DocumentName")%>"><%=rsDetails.getString("DocumentName")%></a></td>
						
						</tr>
						<%
					}
 
					if(i==1){
%><tr><td colspan="14">***</td></tr>
<tr><td colspan="14"><b><%=request.getParameter("companyName") %>
 &nbsp;&nbsp;is not followed up since <u><%=fromDateCal %></u> &nbsp;to&nbsp;  <%=toDateCal %></u></b></td></tr>

<%}
} catch (Exception e) {
out.print("!!!Connection Lost!!!");
}
finally{
	conn.close();
}%>
</table>
</div>
	 
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