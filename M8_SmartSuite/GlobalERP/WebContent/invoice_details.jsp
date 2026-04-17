<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
 <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">


	<script src="dropdown.js" type="text/javascript"></script>

	</head>
	<body>

	<script language="JavaScript1.2">

	function popUp(webadd,repName,action,fromDate,toDate)
	{ 
			window.open(webadd+'?fromDate='+fromDate+'&toDate='+toDate+'&repName='+repName+'&action='+action,'jav');
		
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
			Statement st = null, st1 = null ;
			Statement st2 = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String sqlDetails="";
			String visits="",phoneCalls="",letters="",meetings="",email="",numberOfprospects="",numberOfSQ="",numberOfSO="",sumOfSO="";
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
	if(!(session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")))
		selectedName = session.getAttribute("EmpName").toString();
		
try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
		 
 
	%>

	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.2em; margin-bottom: 0.2em;">
	<a>Marketing Representatives Performance Report</a></div>


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
		</tr>
		
	</table>


</form>

<br></br>

<%
if(null != request.getQueryString())
{
%>
	<table border="1px" width="80%"   class="sortable">
	<tr>
	<th>Sr.No</th>
	<%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
	<th>Sign</th><%} %>
	<th>Visits</th>
	<th>Calls</th>
	<th>Letters</th>
	<th>E-mails</th>
	<th>Meetings</th>
	<th>Sales Quotations</th>
	<th>New Prospects</th>
	<th>No of SO</th>
	<th>Total SO Value</th>
	
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

 
	 sqlDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  WHERE MarketingRepCode='"+selectedName+"'  ";
	 
	 if ("All".equalsIgnoreCase(selectedName) && session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))
		 sqlDetails="   SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster   WHERE "+
		 			" Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1 order by MarketingRepName";
	 
	 else if (session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))
		 sqlDetails="   SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster   WHERE "+
			" ( Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1   )  and  MarketingRepCode =  '"+selectedName.replaceAll("'","")+"'   ORDER BY  MarketingRepName ";
	 
	 else
		 sqlDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  WHERE MarketingRepCode='"+selectedName+"'  ";

	 System.out.println(sqlDetails);
int i=1;
	ResultSet rsDetails=st1.executeQuery(sqlDetails);
	while(rsDetails.next()){
		
		 String sqlCount="SELECT    count(*) , 'PhoneCall'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where			 FollowUpType   "+
			                         "       in('phoneCall','Ph Call') and MarketingRepcode			 "+
			                         "       ='"+rsDetails.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
			                         "       '"+fromDate+"' and '"+toDate+"'			 "+
			                         "        union			 "+
			                         "       SELECT    count(*) , 'Visit'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
			                         "       in('Visit') and MarketingRepcode 			 "+
			                         "       ='"+rsDetails.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
			                         "       '"+fromDate+"' and '"+toDate+"'			 "+
			                         "       union			 "+
			                         "       SELECT    count(*) , 'Letter'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
			                         "       in('Letter') and MarketingRepcode 			 "+
			                         "       ='"+rsDetails.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
			                         "       '"+fromDate+"' and '"+toDate+"'			 "+
			                         "       union			 "+
			                         "       SELECT count(*) , 'Meeting' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
			                         "       in('Meeting') and MarketingRepcode"+
			                         "       ='"+rsDetails.getString("MarketingRepCode")+"' and FollowUpDate between			 "+
			                         "       '"+fromDate+"' and '"+toDate+"'			 "+
			                         "       union			 "+
			                         "       SELECT count(*) , 'Email' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
			                         "       in('E-mail','E mail','Mail','Email') and MarketingRepcode 			 "+
			                         "       ='"+rsDetails.getString("MarketingRepCode")+"' and FollowUpDate between			 "+
			                         "       '"+fromDate+"' and '"+toDate+"'			 "+
			                         "       union			 "+
			                         "       SELECT    count(*) , 'NoOfProspects'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where			 "+
			                         "       MarketingRepcode ='"+rsDetails.getString("MarketingRepCode")+"' and			 "+
			                         "       FollowUpDate  between '"+fromDate+"' and '"+toDate+"' "+
			                         "		 UNION "+
			                         "		 SELECT count(*) ,'NoOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsDetails.getString("MarketingRepName")+"' "+
			                         "		 and SalesOrderDate between '"+fromDate+"' and '"+toDate+"' and SOCancelled=0"+
			                         "    		 UNION "+
			                         "		 SELECT count(*) ,'NoOfSQ' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where TWEmpName='"+rsDetails.getString("MarketingRepName")+"' "+
			                         "		 and SalesQuoDate between '"+fromDate+" 00:00:00  	' and '"+toDate+" 00:00:00  	' and SalesQuoCancelled=0"+
			                         "		 UNION "+
			                         "		 SELECT SUM(Total) ,'SumOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsDetails.getString("MarketingRepName")+"' "+
			                         "		 and SalesOrderDate between '"+fromDate+"' and '"+toDate+"' and SOCancelled=0";
			                         
			
		 		ResultSet rsCount=st2.executeQuery(sqlCount);
		 			phoneCalls=(rsCount.next()?rsCount.getString(1):"0");
		 			visits=(rsCount.next()?rsCount.getString(1):"0");
		 			letters=(rsCount.next()?rsCount.getString(1):"0");
		 			meetings=(rsCount.next()?rsCount.getString(1):"0");
		 			email=(rsCount.next()?rsCount.getString(1):"0");
		 			numberOfprospects=(rsCount.next()?rsCount.getString(1):"0");
		 			numberOfSO=(rsCount.next()?rsCount.getString(1):"0");
		 			numberOfSQ=(rsCount.next()?rsCount.getString(1):"0");
		 			sumOfSO=(rsCount.next()?rsCount.getString(1):"0");
		 			sumOfSO=(sumOfSO==null?"0":sumOfSO);
%>

		<tr>
		<td align="left"><div align ="left"><%=i++ %></div></td>
		<%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
		
			<td align="left"><div align ="left">
			<a href="#" style="font-weight: bold;" onclick="popUp('marketingReportLevel2.jsp','<%=rsDetails.getString("MarketingRepName")%>','repDetails','<%=fromDate %>','<%=toDate %>')">
			<%=rsDetails.getString("MarketingRepName") %></a></div></td>
		<%} %>
		<td align="left"><div align ="left"><%=visits %></div></td>
		<td><div align ="left"><%=phoneCalls %></div></td>
		<td><div align ="left"><%=letters%></div></td>
		<td><div align ="left"><%=email%></div></td>
		<td><div align ="left"><%=meetings %></div></td>
		<td><div align ="left"><%=numberOfSQ %></div></td>
		<td><div align ="left"><%=numberOfprospects%></div></td>
		<td><div align ="left"><%=numberOfSO %></div></td>
		<td><div align ="left"><%=sumOfSO %></div></td>
	 
		
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