<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

	<script type="text/javascript">

	function validate()
	{
		//alert("IN IN  IN  INM    ");
		var numericExpression = /^[0-9]+$/;

		var company=document.paymententry.companyNames.value;
		if(company=="")
		{
			alert("Please Enter Company Name");
			return false;
		}

		var amount=document.paymententry.amount.value;
		if(amount=="" || amount==null)
		{
			alert("Please Enter Amount");
			return false;
		}
		
		if(!(amount.match(numericExpression)))
		{
			alert("Amount Should Be Numeric Value");
			return false;
		}

		
		var billno=document.paymententry.billno.value;
		if(billno=="" )
		{
			alert("Please Enter Bill NO");
			return false;
		}

		
		var mail=document.paymententry.mailto.value;
		if(mail=="select")
		{
			alert("Please select Mail Id");
			return false;
		}


		
		var acctcomm=document.paymententry.accountcomments.value;
		if(acctcomm=="" || acctcomm==null)
		{
			alert("Please Enter Comments");
			return false;
		}
		
		
	}



	
	function getSuppliers()
	{
		// alert("***********************  ");
		document.getElementById("companyList").style.visibility='visible';
		var prospect=document.paymententry.companyNames.value;
		//alert(prospect);
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

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				//var mySplitResult = reslt.split("#");
				//alert(mySplitResult[15]);
				document.getElementById("companyList").innerHTML=reslt;


			} 
		}
		var queryString = "?company=" +prospect;
		ajaxRequest.open("GET","SuppliersList.jsp" + queryString, true);
		ajaxRequest.send(null); 
		
	}

	function addRowForSupplier(SupplierCode,SupplierName) 
	{	
		document.paymententry.companyNames.value=SupplierName;
		document.getElementById('companyList').style.visibility ='hidden';

	}

	
	
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
	
		<div align="left" style="background-color:#C6DEFF;margin-left: 0%;height: 400px;width: 150px;position: absolute;">
	</div>
	<div align="right" style="background-color:#C6DEFF;margin-left:90%;margin-right:0%;  height:400px;width: 150px;position: absolute;">
	</div>
		<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
	<a>Payment Entry</a> </div>
	<div align="center" style="margin-left: 20%;" >
	<form name="paymententry" method="post" action="insertPaymentEntry.jsp?id=new" onsubmit="return validate();">
	
	<table border="0" cellpadding="3" width="80%" align="center" style="background: white;">
	<tr>
							<td  align="right" ><b>Payment Entry Date:</b> </td>
							<td align="left">	<input type="hidden" name="paymententryon" value="<%=todaysDate%>"/><%=todaysDate%> &nbsp; <%=todaysTime %></td>
					  	<td align="right"><b>Company :</b></td>
							<td>	<input type="text" name="companyNames" id="search-text"  style="width: 175px;" 
									onkeyup="getSuppliers();" />
	
	</td>
	<td rowspan="5" valign="top">
	 <div id='companyList'>
		<div style="height: 110px; width: 300px; overflow: auto;">
				<table style="display: none;">
				</table>
		</div>
	 </div> 
	
	</td>				
	
	</tr>
	<tr>
				<td  align="right" ><b>Bill Date:</b> </td>
							<td  align="left"><input type="text"
								id="billdate" name="billdate" value='' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
							<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
							<script type="text/javascript">
						Calendar.setup( {
							inputField : "billdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "billdate" // ID of the button
						});
					</script>				
					</td>
					<td align="right"><b>Bill No:</b></td>
					<td  align="left"><input type="text" name="billno" id="search-text"  style='height: 12px;' />
					</td>
	</tr>
	<tr>
					<td  align="right"><b>Due Date:</b> </td>
							<td  align="left"><input type="text"
								id="duedate" name="duedate" value='' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
							<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
							<script type="text/javascript">
						Calendar.setup( {
							inputField : "duedate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "duedate" // ID of the button
						});
					</script>				
					</td>
					<td align="right"><b>Amount:</b></td>
					<td  align="left"><input type="text" name="amount" id="search-text"  style='height: 12px;' />
					</td>
	</tr>
	<tr>
		<td align="right"><b>Account Comments:</b></td>
		<td  align="left"><input type="text" name="accountcomments" id="search-text"  style='height: 12px;' />
		</td>
	
	<td align="right"><b>Mail To :</td>
	<td align="left"><div id="mailto"> <select name="mailto" style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
			<option value='select'>SELECT</option>
			<option value='r_maner@transworld-compressor.com'>Reshma Maner</option>
			<option value='a_laddha@myfleetview.com'>Ajay Laddha</option>
			<option value='k_manoj@transworld-compressor.com'>KK Manoj</option>
				</select></div></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
	</tr>
	<input type="hidden" name="todaystime" id="todaystime" value="<%=todaysTime %>"/>
	</table>
	
	</form>
	</div>
	<br><br><br><br><br>
		<br><br><br><br><br>
			<br><br><br><br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	
	</body>
	</html>
</jsp:useBean>