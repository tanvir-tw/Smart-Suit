<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

	</head>
	<body>

	<script type="text/javascript">
 
	function validate()
	{
		 var numericExpression = /^[0-9]+$/;
		 
		var duration=document.demoRequest.duration.value;
		var numberOfUnits=document.demoRequest.numberOfUnits.value;
		var amount=document.demoRequest.amount.value;

		if(duration=='')
		{	
			alert("Please Enter duration");
			return false;
		}	
		if(numberOfUnits=='')
		{	
			alert("Please Enter number of units");
			return false;
		}	
		if(amount=='')
		{	
			alert("Please Enter amount");
			return false;
		}	
    	if(!(duration.match(numericExpression)) && duration!=""){
	    	alert("Duration should be a Numeric value ");
    		return false;
    	}
    	if(!(numberOfUnits.match(numericExpression)) && numberOfUnits!=""){
	    	alert("*Number Of Units*  should be a Numeric value ");
    		return false;
    	}
    	if(!(amount.match(numericExpression)) && amount!=""){
	    	alert(" Amount sshould be a Numeric value ");
    		return false;
    	}
	    	return true ;
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
			String FollowUpType = "";
	%>
	<%
		if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");

			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			}
			if (null == request.getParameter("division"))
				selectedName = "All";
			else
				selectedName = request.getParameter("division");
	%>


	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
	<a>Demo Request Form </a> for <%=request.getParameter("companyName").toString().replace("~~","&") %></div>
	<form name="demoRequest" method="post" action="generateDemoRequest.jsp"
		onSubmit="return validate();">
	<table border="0" cellpadding="3" width="65%"
		style="background: white;">

		<tr>
			<td valign="top" align="left">Location :
			<input type="hidden" name="companyName" value="<%=request.getParameter("companyName") %>" />
			 </td>
			<td>
			<div id="city"><input type="text" name="location"
				id="search-text" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">From :</td>
			<td align="left" valign="top"><input type="text" id="fromdate"
				name="fromdate" value='' size="15" readonly
				style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" />
			<script type="text/javascript">
						Calendar.setup( {
							inputField : "fromdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "fromdate" // ID of the button
						});
					</script></td>
		</tr>

		<tr>
			<td valign="top" align="left">Durations :<br> (No of Days)</td>
			<td>
			<div id="duration"><input type="text" name="duration"
				id="search-text" style='height: 12px;' /></div>
			</td>

			
			<td valign="top" align="left">Type of Unit :</td>
			<td align="left">
			 <select name="unitType" style="
				  	width: 95px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "
						>
			 	<option>Select</option>
			 	<option>AVL Lite</option>
			 	<option>AVL 2000</option>
			 	<option>Multiple</option>
			 </select>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left">No of Demo Units :</td>
			<td align="left">
			<div id="numberOfUnits"><input type="text" name="numberOfUnits"
				id="search-text" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Amount per Unit:</td>
			<td align="left">
			<div id="amount"><input type="text" name="amount"
				id="search-text" style='height: 12px; width: 80px; ' /></div>
			</td>
		</tr>
		<tr>
			<td valign="bottom" align="center" colspan="6">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
		</tr>

	</table>
	</form>

	<br><br><br><br><br><br><br><br> <br> <br>
	<br> <br> <br> <br> <br> <br><br> <br>  
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>