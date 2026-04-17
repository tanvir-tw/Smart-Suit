<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">


	<script src="dropdown.js" type="text/javascript"></script>

	</head>
	<body>

	<script language="JavaScript1.2">

	var arSelected = new Array(); 

	function conformAll() {
		alert("CONFRM");
		alert(document.getElementByName(repNameSel.options[1].value));/*
		while (ob.selectedIndex != -1) {
			if (ob.selectedIndex != 0)
				arSelected.push(ob.options[ob.selectedIndex].value);
			ob.options[ob.selectedIndex].selected = false;
		}*/
	}

	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>


	<!-- end #header --> <!-- end #page --> 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
	
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String sqlDetails="";
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
	
	if (null == request.getParameter("repName"))
		selectedName = "All";
	else
		selectedName = request.getParameter("repName");
		
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();

			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>

	<div
		style="font-size: 1.7em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Follow Up Report</a></div>


<form action="" method="get" ">



<table border="0" width="100%">
		<tr>
					<td valign="top" align="right" width="20%">
					<div id='repName'>
<%if(!(session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
<b>Marketing Representative Name :</b>&nbsp; 
									<input type="text" name="customerEnteredBy" readonly="readonly" id="search-text"
										value='<%=session.getAttribute("EmpName") %>' style='width: 120px; height: 12px; border: none;' /> 
				 <%} else{%>
					
										 <b>Marketing Rep. Name :</b></td><td valign="top" align="left" width="25%"><select
						name="repNameSel" id="repNameSel"  multiple='multiple'   size="5" style="width: 220px;"
						 >
						<%
							String sql = "select MarketingRepName ,MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
							" WHERE Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1  order by MarketingRepName";
								ResultSet rs = st.executeQuery(sql);
								%>
								<option value="All">All</option>
								<%
								while (rs.next()) {
						%>
						<option value="<%=rs.getString(2)%>">
							<%=rs.getString(1)%></option>
						<%
							}
						%>
					</select>
					<%} %></div>
					</td>


			<td align="left">
			<b> </b>&nbsp;&nbsp;
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
			<input type="submit" name="submit" id="submit" style="border: outset;"
				value="Go" /></td>
			 <td>
			 	<table>
			 		<tr><td>Pending</td></tr>
			 		<tr><td>Approved</td></tr>
			 		<tr><td>Checked</td></tr>
			 		<tr><td>Sanctioned</td></tr>
			 		<tr><td>Paid</td></tr>
			 	</table>
			 </td>
		</tr>
		
	</table>

</form>

<br></br>



<%
  if(null != request.getQueryString()) 
 {
%>
	<table border="1px"  class="sortable">
	<tr>
	<th>Sr.No</th>
	<%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
	<th>Sign</th><%} %>
	<th>Company</th>
	<th>Contact Person</th>
	<th>Follow-Up Date</th>
	<th>Status</th>
	<th>Comments</th>
	<th>Follow-Up Type</th>
	<th>Next Follow Up Date</th>
	<th>Payment Follow-Up</th>
	<th>Reply</th>
	
	</tr>
	
<%	
String[] arr=null;
if(!(request.getParameterValues("repNameSel")==null))
{
	selectedName="";
	 arr=request.getParameterValues("repNameSel");
	if(arr[0].equalsIgnoreCase("All"))
		selectedName="All";		
	else
	{
		for(int i=0;i<arr.length;i++) 
			selectedName+="'"+arr[i]+"',";
 
	 selectedName = selectedName.substring(0, selectedName.length() - 1);
	}
	for(int i=0;i<arr.length;i++)
	 	System.out.println("Sel name***********"+arr[i]);		
}

 
	 sqlDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup  WHERE MarketingRepCode='"+session.getAttribute("EmpCode")+"' AND FollowUpDate BETWEEN '"+fromDate+"' AND '"+toDate+"' order by FollowUpDate Asc";
	 
	 
int i=1;
	ResultSet rsDetails=st1.executeQuery(sqlDetails);
	while(rsDetails.next()){
%>
		<tr>
		<td align="left"><div align ="left"><%=i++ %></div></td>
		<%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
			<td align="left"><div align ="left"><%=rsDetails.getString("MarketingRepName") %></div></td>
		<%} %>
		<td align="left"><div align ="left"><%=rsDetails.getString("ProspCustName") %></div></td>
		<td><div align ="left"><%=rsDetails.getString("ContactPerson") %></div></td>
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
		<td><div align ="left"><%=rsDetails.getString("PaymentFollowup") %></div></td>
		<td><div align ="left"><%=rsDetails.getString("Reply") %></div></td>
		
		</tr>
		<%
	}
	if(i==1){
		%>
		<tr><td colspan="11" align="center"><b></b></td></tr>
		<tr><td colspan="11" align="center"><b>--- NO DATA ---</b></td></tr>
		<%
	}	
  }
} catch (Exception e) {
	out.print("!!!Connection Lost!!!");
	}
	finally{
		conn.close();
	}
%>
</table>

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