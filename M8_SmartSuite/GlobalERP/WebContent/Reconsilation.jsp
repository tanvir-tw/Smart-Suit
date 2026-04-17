<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>
	</head>
	
	<script type="text/javascript">

	function hideCompanyName(){
		document.data.companyNames.value='';
	}

	function getCompanies()
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
		var queryString = "?company=" +company+"&getCompanyName=true";
		ajaxRequest.open("GET", "AjaxGetLedgerCompanies.jsp" + queryString, true);
		ajaxRequest.send(null); 
		
	}

	
	function showVisitingCardDetails(customerCode,companyName){
		document.data.companyNames.value=companyName;
		//alert(companyName);
		document.data.customerCode.value=customerCode;
		//alert(customerCode);
		document.getElementById("companyList").style.display='none';
		document.data.isCheckedAll.checked=false;
	}


	function showdetails()
	{
		document.getElementById("secondform").style.visibilty="visible";
	}
	</script>
<body>

<%
	 	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null;
		Statement st2 = null;
		String selectedName;
		String FollowUpType = "";
%>
<%
		String fromDateCal = "", toDateCal = "", sqlShow = "";
		String fromDate="",toDate="",customerCode="";
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
			
			System.out.println("**********          "+request.getParameter("custCode"));
		
%>

	<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >
	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Reconciliation form</a></div>
	
	<form name="data" action="" >
	<div align="center">
	<table align="top"  >
	<tr> 
	 
	 <td align="right">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <b> Enter Company :</b></td>
	 <td><input type="text" name="companyNames" id="search-text" style="width:230px;" value="" autocomplete="off" onkeyup="getCompanies()" /> 
	 &nbsp;&nbsp;&nbsp;<br>
	 <input type="hidden" name="customerCode"/>
	 <div style="position: absolute;"  >
	 <table><tr><td>
		
	 </td></tr>
	 <tr><td>
	 <div id='companyList'>
	 </div>
	 </td></tr>
	 </table>
	 </div>
	 </td>
     <td><input type="submit" name="submit" id="submit" style="border: outset;" value="Go" onclick="showdetails();" /></td>
	</tr>
	 
	</table></div>
	</form>
	<br>
<%
	if(null != request.getQueryString())
	{
%>  
	<div
		style="font-size: 1.5em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Reconciliation History of :<%=request.getParameter("companyNames") %></a></div>
	

	<table align="center" class='sortable'> 
	<tr>
	<th>Sr No</th>
	<th>Reconciliation Upto</th>
	<th>Reconciliation On</th>
	<th>Sign</th>
	<th>Comments</th>
	</tr>	
	
<%
	sqlShow="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"reconsilationdet WHERE CompanyName in ('"+request.getParameter("companyNames")+"') "; 
	System.out.println(sqlShow);			
	ResultSet rsShow=st.executeQuery(sqlShow);
	int i=1;
	while(rsShow.next())
	  {
	customerCode=rsShow.getString("CustomerCode");	
%>	
	
	<tr>
	<td><div align="right"><%=i++%></div></td>
		<td><div align="right"><%=new SimpleDateFormat(  
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsShow.getString("ReconsiledUpto")))%></div></td>
	<td><div align="right"><%=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsShow.getString("ReconsiledOn")))%></div></td>
	<td><div align="left"><%=rsShow.getString("ReconsiledBy")%></div></td>
	<td><div align="left"><%=rsShow.getString("Comments")%></div></td>
	</tr>
		
<%    }
	
	if(i==1){
		%>
	<tr><td colspan="5">
	NO DATA FOUND
	</td></tr>	
		
		
		<%
	}
	}	
	%>		
	</table>
	<br>
	<br>
	<br>


<form name="reconsile" method="get" action="insertReconsilation.jsp">
<div id="secondform">


	<div style="font-size: 1.5em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>New Reconciliation of :<%=request.getParameter("companyNames") %></a></div>
	<table align="center">
	<tr>
	<td>Reconciliation UPTO :</td>
	<td>
	<div id="">
		<input type="text" id="fromdate"
		 name="reconsiledate" value="<%=fromDateCal %>" size="15" readonly style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
		<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
		<script type="text/javascript">
				  Calendar.setup(
				    {
				      inputField  : "fromdate",         // ID of the input field
				      ifFormat    : "%d-%b-%Y",     // the date format
				      button      : "fromdate"       // ID of the button
				    }
				  );
		
	</script></div>
	</td>
	<td>COMMENTS :</td>
	<td>
	<input textarea name="comments" id="search-text" style='width: 230px; height:40px;'></textarea>
	</td>
	<td>
	<input type="submit" value="Submit" style="border: outset; background-copurchalor: #C6DEFF; width: 165p" />
	</td>
	</tr>
	</table>
	
	<input type="hidden" name="custCode" value="<%=request.getParameter("customerCode") %>">
	<input type="hidden" name="company" value="<%=request.getParameter("companyNames") %>">
	<input type="hidden" name="employee" value="<%=session.getAttribute("EmpName") %>">
	</form>
</div>
<%if(request.getQueryString()== null){ %>
<script>document.getElementById("secondform").style.visibility="hidden";</script>
<%} %>


	<br><br><br><br><br>
	<br><br><br><br><br>
	<br><br><br><br><br>
	<br><br><br><br><br>
	

	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>