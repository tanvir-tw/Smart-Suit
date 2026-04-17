<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>

	
	<script type="text/javascript">
	
	function showFollowUpEntryForm(divid, state) {

		
		 var ajaxRequest;
	     try
	     {
				ajaxRequest = new XMLHttpRequest();
	     }  
	     catch (e)
	     {
		     try
	         {
		          ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
	              catch (e)
	              {
		               try
		               {
			                ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			           } 
	                   catch (e)
	                   {
		                   alert("Your browser broke!");
		                   return false;
		               }
	        		}
	          }
	          var queryString = "?Prospect="+document.addFolloUp.customerName.value+"&Company="+document.addFolloUp.companyNames.value;
              //alert(queryString);
	          ajaxRequest.open("GET", "checkNoOfFollowUp.jsp" + queryString, true);
	      	  ajaxRequest.send(null); 
	      	  ajaxRequest.onreadystatechange = function()
	          {
	               if(ajaxRequest.readyState == 4)
	               {
	                       var reslt=ajaxRequest.responseText;
	                       var mySplitResult = reslt.split("#");
	                       var action=mySplitResult[1];
                           
	          	           if(action=="Accept")
	                       {
	                   			document.getElementById(divid).style.display=state;
	                   		}
	                       else
		                   {
			                   alert("Please Enter Prospects Address as the prospect is followed up for two more than two times.     (!!! Address Is Mandatory !!!)");
	                    	   document.getElementById(divid).style.display="none";
		                   }
	               }
	        }
	
	}

	
	function searchInfoline(webadd,type) {
		 var key;
		 if(type=='Prospect')
			 key=document.addFolloUp.customerName.value.split(' ').join('-');
		 else
		    key=document.addFolloUp.companyNames.value.split(' ').join('-');
		var load = window.open(webadd+'/stock-market/equity/NewsBoard/133/'+key+'^/AllNewsScripListing.htm','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		}

	
	function searchMoneyControl(webadd,type) {
		 var key;
		 if(type=='Prospect')
			 key=document.addFolloUp.customerName.value.split(' ').join('+');
		 else
		    key=document.addFolloUp.companyNames.value.split(' ').join('+');
		var load = window.open(webadd+'/news/websearch.php?search_data='+key+'&cid=News&mbsearch_str=&topsearch_type=3&search_str='+key+'&x=0&y=0','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		}

	function searchGoogle(webadd,type) {
		 var key;
		 if(type=='Prospect')
			 key=document.addFolloUp.customerContactPerson.value.split(' ').join('+');
		 else
		    key=document.addFolloUp.companyNames.value.split(' ').join('+');
		var load = window.open(webadd+'#hl=en&source=hp&q='+key+'&oq='+key+'&aq=f&aqi=g2g-v8&aql=undefined&gs_sm=e&gs_upl=635l5073l0l16l16l0l3l3l0l276l2363l0.7.5l12&bav=on.2,or.r_gc.r_pw.&fp=263275ba9c13808&biw=1366&bih=541','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		}
	
	function searchLinkedin(webadd,type) {
  
		 var keyFirstName,keyLastName,key,result;
		 if(type=='Prospect'){
			 key=document.addFolloUp.customerContactPerson.value.split('Mr.').join('');

			 key=key.split('Mr.  ').join('');
			 key=key.split('  ').join(' ');
			 result=key.split(" ");
			 keyFirstName=result[1];
			 keyLastName=result[2];
		 }
		 else
		 {
		     key=document.addFolloUp.companyContactPerson.value.split('Mr.').join('');
		     
			 key=key.split('Mr.  ').join('');
			 key=key.split('  ').join(' ');
			 result=key.split(" ");
			 keyFirstName=result[1];
			 keyLastName=result[2];
		 }
		var load = window.open(webadd+'/pub/dir/?first='+keyFirstName+'&last='+keyLastName+'&search=Search','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		}

	function gotoFollowUpReport(webadd)
	{ 
		var company=document.addFolloUp.companyNames.value;
		var companyPerson=document.addFolloUp.companyContactPerson.value;
		var companyPhone=document.addFolloUp.companyPhoneNumber.value;
		var companyEmail=document.addFolloUp.companyEmail.value;
		var companyCity=document.addFolloUp.companyCity.value;
		var companyProduct=document.addFolloUp.companyProduct.value;
		
		window.location=webadd+'?companyName='+company+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct;
	}

	function goto(webadd)
	{
		window.location=webadd;
	}
	
	function gotoFollowUpReportAsProspect(webadd)
	{ 
		
		var company=document.addFolloUp.customerName.value;
		var companyPerson=document.addFolloUp.customerContactPerson.value;
		var companyPhone=document.addFolloUp.customerPhoneNumber.value;
		var companyEmail=document.addFolloUp.customerEmail.value;
		var companyCity=document.addFolloUp.customerCity.value;
		var companyProduct=document.addFolloUp.customerProduct.value;
		
		window.location=webadd+'?companyName='+company+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct;
	}
	function gotoLedgerDetails(webadd)
	{ 
		var company=document.addFolloUp.companyNames.value;
		var companyPerson=document.addFolloUp.companyContactPerson.value;
		var companyPhone=document.addFolloUp.companyPhoneNumber.value;
		var companyEmail=document.addFolloUp.companyEmail.value;
		var companyCity=document.addFolloUp.companyCity.value;
		var companyProduct=document.addFolloUp.companyProduct.value;
		
		window.open(webadd+'?companyName='+company.replace('&','~')+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct);
	}
	function editCompany(webadd)
	{ 
		window.location=webadd+'?companyCode='+document.addFolloUp.companyCode.value;
	}
	function editProspect(webadd)
	{ 
		if(document.addFolloUp.customerName.value=="" || document.addFolloUp.customerName.value==null)
			alert("Please select Prospect ");
		else
			window.location=webadd+'?companyName='+document.addFolloUp.customerName.value.replace('&','~~');
	}
	
	function check(webadd)
 	{
		if(document.addFolloUp.customerName.value=="" || document.addFolloUp.customerName.value==null)
		alert("Please select Prospect ");
	
		else
		{
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
					var mySplitResult = reslt.split("#");
					if(mySplitResult[1]=='Yes')
					{
							alert("This Prospect is already converted into Customer");
							return false;
					}
		
					else
					{
						var agree=confirm("\n\n Do you want to convert Prospective Customer: "+document.addFolloUp.customerName.value.replace('&','~~')+" to customer?");
						if (agree)
						window.location=webadd+'?companyName='+document.addFolloUp.customerName.value.replace('&','~~');
					}
				} 
			}
		    
			var queryString = "?companyName="+document.addFolloUp.customerName.value.replace('&','~~');
			ajaxRequest.open("GET", "AjaxGetCustomerList.jsp" + queryString, true);
			ajaxRequest.send(null);

		}
 	}
	
	function getCustomerDetails(i) 
	{   
		document.getElementById("companyList").style.visibility="hidden";
		document.addFolloUp.companyNames.value=document.getElementById("cName"+i).value;
		document.addFolloUp.companyCode.value=document.getElementById("cCode"+i).value;
		document.addFolloUp.companyEnteredBy.value=document.getElementById("cRepName"+i).value;
		document.addFolloUp.companyCity.value=document.getElementById("cCity"+i).value;
		document.addFolloUp.companyPhoneNumber.value=document.getElementById("cMobileNo"+i).value;
		document.addFolloUp.companyProduct.value=document.getElementById("cIntrestedProduct"+i).value;
		
		document.addFolloUp.companyContactPerson.value=document.getElementById("cContactPerson"+i).value;
		document.addFolloUp.companyEmail.value=document.getElementById("cEmail"+i).value;
		document.addFolloUp.companyfax.value=document.getElementById("cFax"+i).value;
		document.addFolloUp.companyWebSite.value=document.getElementById("cWebSite"+i).value;



		var company=document.addFolloUp.companyCode.value;
		var companyName=document.addFolloUp.companyNames.value;
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
				 var mySplitResult = reslt.split("#");
				document.getElementById("transactionDetails").innerHTML=mySplitResult[0];
				document.getElementById("followupDetails").innerHTML=mySplitResult[1];
			} 
		}
		
		var queryString = "?company=" +company+"&companyName="+companyName;
		ajaxRequest.open("GET", "AjaxGetTransactionDetails.jsp" + queryString, true);
		ajaxRequest.send(null); 


	}
	function getProspectDetails(i) {
		document.getElementById("ProspectList").style.visibility="hidden"; 
		document.addFolloUp.customerName.value=document.getElementById("pCompanyName"+i).value; 
		document.addFolloUp.customerCode.value=document.getElementById("pCode"+i).value;	 
		document.addFolloUp.customerContactPerson.value=document.getElementById("pContactPerson"+i).value;  
		document.addFolloUp.customerProduct.value=document.getElementById("pIntrestedProduct"+i).value; 
		document.addFolloUp.customerWeeklyOff.value=document.getElementById("pWeeklyOff"+i).value;
		document.addFolloUp.prospectEnteredBy.value=document.getElementById("pRepName"+i).value;
		
		document.addFolloUp.customerCity.value=document.getElementById("pCity"+i).value;
		document.addFolloUp.customerPhoneNumber.value=document.getElementById("pMobileNo"+i).value; 
		document.addFolloUp.customerEmail.value=document.getElementById("pEmail"+i).value;
		
		document.addFolloUp.customerFax.value=document.getElementById("pFax"+i).value;
		document.addFolloUp.customerWebSite.value=document.getElementById("pWebSite"+i).value;
		
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
                var mySplitResult = reslt.split("#");
                
                document.addFolloUp.assignedBy.value=mySplitResult[1];
                document.addFolloUp.leadRef.value=mySplitResult[2];
                document.getElementById("prospectFollowUp").innerHTML=mySplitResult[3];
			} 
		}
		
		var queryString = "?prospect=true&companyName="+document.addFolloUp.customerName.value.replace('&','~~');
		ajaxRequest.open("GET", "AjaxGetTransactionDetails.jsp" + queryString, true);
		ajaxRequest.send(null); 

		
	}


	function getProspectes() {
		document.getElementById("ProspectList").style.visibility="visible";
		var prospect=document.addFolloUp.customerName.value;
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
				document.getElementById("ProspectList").innerHTML=reslt;
			} 
		}
		var queryString = "?prospect=" +prospect;
		ajaxRequest.open("GET", "AjaxGetProspectInfo.jsp" + queryString, true);
		ajaxRequest.send(null); 

	}
	function getCompanies(prospect)
	{
		document.getElementById("companyList").style.visibility="visible";
			var company=document.addFolloUp.companyNames.value;
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
			var queryString = "?company=" +company;
			ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp" + queryString, true);
			ajaxRequest.send(null); 
			
	}
	function newwindow()
	{ 
		if(document.addFolloUp.customerName.value=="" || document.addFolloUp.customerName.value==null)
			alert("Please select Prospect ");
		else
			window.open('prospectDetails.jsp'+'?companyName='+document.addFolloUp.customerName.value,'jav','width=750,height=500,top=30,left=300,resizable=no');
		
	}
	function customerDetails()
	{ 
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
			alert("Please select a Company ");
		else 
			window.open('customerDetails.jsp'+'?companyName='+document.addFolloUp.companyNames.value.replace('&','~'),'jav','width=750,height=670,top=30,left=300,resizable=no');
	}

	function validate()
	{
		if(document.addFolloUp.todate.value=='')
		{
			alert("Please Enter Next Follow-Up Date" );
			return false;
		}
		if(document.addFolloUp.comments.value=='')
		{
			alert("Please Enter Comments" );
			return false;
		}
		return true; 
	}
 
	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
			
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
		String fromDateCal = "", toDateCal = "", sql = "";
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
			if (null == request.getParameter("division"))
				selectedName = "All";
			else
				selectedName = request.getParameter("division");
	%>
 
	<!-- <div style="text-align: right">
	<table border="1" width="10%" style="align=right;">
		<tr>

			<td align="right"><input type="checkbox"
				name="Money-Control" value="Moneycontrol"></input></td>
			<td><input type="checkbox"
				name="Google" value="Google"></input></td>
			<td><input type="checkbox"
				name="India Times" value="India Times"></input></td>
		</tr>
	</table>
	</div> -->
 
	<form name="addFolloUp" method="post" action="addFollowUp.jsp"
		    onSubmit="return validate();">
		    
		    <div id="followUpTable" style="display: none; margin-left:71%; margin-top:7%; height:425;width:35%; border-style:inset; border-width:1; border-color: blue;position:absolute; background-color: #E1F3F3; " >
			
			<table>
				<tr>
				</tr>
				<tr>
					<td colspan="1">
					
					
					
					<table style="background: white;" cellspacing="1">
						<tr>

							<td colspan="2">

							<div id="enterFollowUpLabel"
								style="font-size: 1.2em; text-shadow text-align: left margin-top : 1.0em; margin-bottom: 1.0em;">
							<a> Enter Follow Up.</a></div>
							</td>
						</tr>
						<tr>
							<th align="left">Follow-Up Date</th>
							<td align="left" valign="top"><input type="text"
								id="fromdate" name="fromdate" value='<%=fromDateCal%>' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
							<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
							<script type="text/javascript">
						Calendar.setup( {
							inputField : "fromdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "fromdate" // ID of the button
						});
					</script></td>
						</tr>
						<tr>
							<th align="left">Status &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
							<td style="vertical-align: top;" align="left"><select
								name="followUpStatus" id="followUpStatus" style='width: 70px;'>
								<option value="cold">Cold</option>
								<option value="warm">Warm</option>
								<option value="hot">Hot</option>
							</select></td>

						</tr>
						<tr>
							<th align="left">Follow-Up Type</th>
							<td style="vertical-align: top;" align="left"><select
								name="followUpType" id="followUpType" style='width: 100px;'>
								<option value="phoneCall">Ph. Call</option>
								<option value="Visit">Visit</option>
								<option value="E-mail">E-mail</option>
								<option value="Letter">Letter</option>
								<option value="Meeting">Meeting</option>
							</select></td>


						</tr>
						<tr>
							<th align="left">Comments</th>
							<td style="vertical-align: top;" align="left"><textarea 
								wrap="virtual" rows="2" cols="25" name="comments" id="comments"
								style="height: 50px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 70; max-width: 70;"></textarea></td>
						</tr>
						<tr>
							<th align="left">Next Follow-Up Date</th>
							<td align="left" valign="top"><input type="text" id="todate"
								name="todate" value='' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" />
							<script type="text/javascript">
						Calendar.setup( {
							inputField : "todate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "todate" // ID of the button
						});
					</script></td>

						</tr>
						<tr>
							<th align="left">Payment<br>
							Follow-Up</th>
							<td align="left" valign="top"><input type="checkbox"
								name="paymentFollowUp" value="paymentFollowUp"></input></td>
						</tr>
						<tr>
							<th align="left">Reply</th>
							<td align="left" valign="top"><input type="checkbox"
								name="reply" value="reply"></input></td>
						</tr>
						<tr>
							<th>.</th>


							<td align="left" valign="top">
							<div><input
								type="submit" id="search-submit" name="submitFollowUp"
								value="Submit" /></div>
						
							</td>
						</tr>
						<tr>
						</tr>
					</table>
					</td>
				</tr>
			</table>
	</div>
<div >
	<table width="100%" >
		<tr>
			<td>
 			<table width="100%">

				<tr>

					<td valign="top">
					<table border="0" cellpadding="0" style="background: white;">
 					<tr>
 
							<td align="left" style="display: none;">Customers not
							followed-up<br></br>
							since last 10 Days</td>
							<td style="display: none;">
							<%
								sql = " SELECT COUNT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectcustomers";
							%>
							<div id='customersNotfollowedup'>&nbsp;(10)&nbsp;&nbsp;</div>
							</td>
							<td align="left" style="display: none;">Prospects not
							followed-up<br></br>
							since last 10 Days</td>
							<td style="display: none;">
							<%
								sql = " SELECT COUNT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectcustomers";
							%>
							<div id='prospectsNotfollowedup'>&nbsp;(12)</div>
							</td>

						</tr>
					</table>
					</td>

				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td align="left">
					<form method="get" id="tab"">
					<div class="TabView" id="TabView">
					<div class="Tabs" style="width: 350px;"><a>Customer</a> <a>
					Prospects </a> <a></a></div>
					<div class="Pages" style="width: 700px; height: 390px;">
					<div class="Page">
					<div class="Pad">




					<table style="background: white;" border="0">
						<tr>
							<!-- 				<td style="vertical-align: top;">Company Name:&nbsp; <select
						name="companyName" id="companyName"
						onChange="OnChangeGetCompanyDetails(this);" style='width: 190px;'>
 
						<option value="< %=rsCompanyName.getString(1)%>"
							< % if (selectedName.equals(rsCompanyName.getString(1))) {%>
							Selected < % }%>>< %=rsCompanyName.getString(1)%></option>
						< % //	}%> 

					</select></td>-->
							<td valign="top" style="width: 30%">
							<div id="companyNames"><b>Search :</b> &nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="companyNames"
								id="search-text" value="" style='width: 250px;'
								onkeyup="getCompanies()" /></div>
							<table>
							<tr>
								<td colspan="2">
									<table border="0">
										<tr><td><b>in :</b></td>
											<td><a href="javascript:searchMoneyControl('http://www.moneycontrol.com','cust')"><img src="images/moneyControl.jpeg" style="height: 22px; width: 100px;"></img></a></td>
											<td><a href="javascript:searchInfoline('http://www.sharekhan.com','cust')"><img src="images/sharekhan_logo.gif" style="height: 22px; width: 100px;"></img></a></td>
											<td><a href="javascript:searchGoogle('http://www.google.com','cust')"><img src="images/google_logo.jpg" style="height: 18px; width: 60px;"></img></a></td>
											<td><a href="javascript:searchLinkedin('http://www.linkedin.com','cust')"><img src="images/link.jpg" style="height: 18px; width: 60px;"></img></a></td>
										</tr>
									</table>
									
								</td>
							</tr>
								<tr>
									<td align="left"><b>Rep</b></td>
									<td valign="top" align="left">
									<div id="companyEnteredBy" style="visibility: visible;">

									:<input type="text" name="companyEnteredBy" id="lab-text"
										value='<%=session.getAttribute("EmpName")%>'
										style='border-style: none; width: 150px; height: 12px;' readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td align="left"><b>Contact</b></td>
									<td valign="top" align="center">
									<div id="companyContactPerson"><input type="text"
										name="companyContactPerson" id="search-text" value=""
										style='border-style: none; width: 300px;' readonly="readonly"/></div>
									</td>
								</tr>
								<tr>
									<td align="left"><b>Mob</b></td>
									<td valign="top" align="center">
									<div id="companyPhoneNumber" style="visibility: visible;">
									<input type="text" name="companyPhoneNumber" id="search-text"
										value=""
										style='border-style: none; width: 300px; height: 12px;' readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td align="left" valign="top"><b>E-mail</b></td>
									<td valign="top" align="left">
									<div id="companyEmail" style="visibility: visible;"><textarea
										name="companyEmail" rows="1" id="search-text"
										style='border-style: none; width: 280px; height: auto;'></textarea>
									</div>
									</td>
								</tr>
								<tr>
									<td align="left"><b>Code</b></td>
									<td valign="top" align="center">
									<div id="companyCode"><input type="text"
										name="companyCode" id="lab-text" value=""
										style='border-style: none; width: 300px; height: 12px' readonly="readonly"/></div>
									</td>
								</tr>
								<tr>
									<td align="left"><b>City</b></td>
									<td>
									<table>
										<tr>

											<td valign="top" align="center">
											<div id="companyCity"><input type="text"
												name="companyCity" id="search-text" value=""
												style='border-style: none; width: 70px; height: 12px;' readonly="readonly"/></div>
											</td>
											<td align="center" style="width: 25%"><b>Product </b></td>
											<td valign="top" align="right">
											<div id="companyProduct"><input type="text"
												name="companyProduct" id="search-text" value=""
												style='border-style: none; width: 130px;' readonly="readonly"/></div>
											</td>

										</tr>

									</table>
									</td>
								</tr>
								<tr>
									<td align="left"><b>Fax</b></td>
									<td valign="top" align="left">
									<div id="companyFax"><input type="text" name="companyfax"
										id="search-text" value=""
										style='border-style: none; width: 120px;' readonly="readonly"/></div>
									</td>
								</tr>
								<tr>
									<td align="left" style="background: white;"><b>WebSite</b></td>
									<td valign="top" align="left" style="background: white;">
									<div id="companyWebSite"><input type="text"
										name="companyWebSite" id="search-text" value=""
										style='border-style: none; width: 120px;' readonly="readonly"/></div>
									</td>
									
								</tr>
								
							</table>
							</td>
							<td align="left" valign="top">

							<table border="0">
								<tr>
									<td>
									<div id='companyList'>
									<div style="height: 110px; width: 300px; overflow: auto;">
									<table style="display: none;">

									</table>

									</div>
									</div>
									</td>
								</tr>
								<tr>
									<td align="right" valign="top">
									<div><a href="#"
										onClick="showFollowUpEntryForm('followUpTable', 'block'); return false"><input
										type="submit" id="search-submit" name="followUp" style="width: 95px;"
										value="Follow-Up      " onclick="<%FollowUpType = "Pros";%>" /></a></div>
								
									</td>
								</tr>
 							<tr>
 									<td align="right" >
 
 											 <a href="#" ><input type="button" onclick="editCompany('editCompany.jsp');"
										style="width: 95px; height: 20px; border: none; background: #B9B9B9; color: #000000; "
										name="EditNewCustomer" value="Edit         " /></a>
 									</td>
 								</tr>
 								<tr>
 								  <td align="right" >
 																		<a href="#" onclick="customerDetails();"><input type="button"
										id="search-submit" style="width: 95px;"
										name="Details" value="Details            " /></a>
 				 
 								 </td>
 								 </tr>
 								 								<tr>
 									<td align="right" >
 
 											 <a href="#" ><input type="button" onclick="gotoLedgerDetails('ledgerdetails.jsp');"
										style="width: 95px; height: 20px; border: none; background: #B9B9B9; color: #000000; "
										name="ledgetdetails" value="Ledger Det     " /></a>
 									</td>
 								</tr>
 
 								 								 								<tr>
 									  <td align="right" >
 
 											 <a href="#" ><input type="button" onclick="gotoFollowUpReport('customerWiseFollowUpReport.jsp');"
										style="width: 95px; height: 20px; border: none; background: #B9B9B9; color: #000000; "
										name="followUpdetails" value="Follow-Up Rep" /></a>
 									</td>  
 								</tr>
						 
							</table>
							</td>
						</tr>

						<tr>
							<td>
							<table border="0" width="100%">

								<tr>
								<td colspan="4"><b> Last 3 transactions</b></td>
								</tr>
								<tr>
									<td colspan="4" align="left">
									
									<div id="transactionDetails">
									<table style="border-style: groove; border-color: aqua; " >
					
									</table>
									</div>
									</td>
								</tr>

							</table>
							</td>
							
														<td>
							<table border="0" width="100%">

								<tr>
								<td colspan="4"><b> Last 3 follow-ups</b></td>
								</tr>
								<tr>
									<td colspan="4" align="left">
									
									<div id="followupDetails">
									<table style="border-style: groove; border-color: aqua; display: none;" >
 
									</table>
									</div>
									</td>
								</tr>

							</table>
							</td>
							
							
						</tr>
					</table>

				</div>
				</div>
				<div class="Page">
				<div class="Pad"> 
				
				
				
				<table style="background: white;" border="0">
						<tr>
							<td valign="top" style="width: 30%">

						<div id="customerName"><b>Search :</b> &nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="customerName"
							id="search-text" value="" style='width: 250px;'
							onkeyup="getProspectes()" /></div>
							
							<table>
														<tr>
								<td colspan="2">
									<table border="0">
										<tr><td><b>in :</b></td>
											<td><a href="javascript:searchMoneyControl('http://www.moneycontrol.com','Prospect')"><img src="images/moneyControl.jpeg" style="height: 22px; width: 100px;"></img></a></td>
											<td><a href="javascript:searchInfoline('http://www.sharekhan.com','Prospect')"><img src="images/sharekhan_logo.gif" style="height: 22px; width: 100px;"></img></a></td>
											<td><a href="javascript:searchGoogle('http://www.google.com','Prospect')"><img src="images/google_logo.jpg" style="height: 18px; width: 60px;"></img></a></td>
											<td><a href="javascript:searchLinkedin('http://www.linkedin.com','Prospect')"><img src="images/link.jpg" style="height: 18px; width: 60px;"></img></a></td>
										</tr>
									</table>
								</td>
							</tr>
								<tr>
									<td align="left"><b>Rep</b></td>
									<td valign="top" align="left">
									<div id="prospectEnteredBy" style="visibility: visible;">

									:<input type="text" name="prospectEnteredBy" id="lab-text"
										value='<%=session.getAttribute("EmpName")%>'
										style='border-style: none; width: 150px; height: 12px;' readonly="readonly"/></div>
									</td>
								</tr>
								<tr><td><b>Added By</b></td><td>
										<table><tr>
											<td valign="top" align="center">
											<div id="assignedBy"><input type="text"
												name="assignedBy" id="search-text" value=""
												style='border-style: none; width: 100px;'  readonly="readonly"/></div>
											</td>							
											<td align="left"><b>Lead Ref:</b></td>
											<td valign="top" align="center">
											<div id="leadRef"><input type="text"
												name="leadRef" id="search-text" value=""
												style='border-style: none; width: 100px;'  readonly="readonly"/></div>
											</td>
											</tr></table></td>
								</tr>
								<tr>
									<td align="left"><b>Contact</b></td>
									<td valign="top" align="center">
									<div id="customerContactPerson"><input type="text"
										name="customerContactPerson" id="search-text" value=""
										style='border-style: none; width: 300px;' readonly="readonly"/></div>
									</td>
								</tr>
								<tr>
									<td align="left"><b>Mobile</b></td>
									<td valign="top" align="center">
									<div id="customerPhoneNumber" style="visibility: visible;">
									<input type="text" name="customerPhoneNumber" id="search-text"
										value=""
										style='border-style: none; width: 300px; height: 12px;' readonly="readonly"/></div>
									</td>
								</tr>
								<tr>
									<td align="left" valign="top"><b>E-mail</b></td>
									<td valign="top" align="left">
									<div id="customerEmail" style="visibility: visible;"><textarea
										name="customerEmail" rows="1" id="search-text"
										style='border-style: none; width: 280px; height: auto;' readonly="readonly"></textarea>
									</div>
									</td>
								</tr>
								
									<tr>
									<td align="left"><b>City</b></td>
									<td>
									<table>
										<tr>
											<td valign="top" align="center">
											<div id="customerCity"><input type="text"
												name="customerCity" id="search-text" value=""
												style='border-style: none; width: 70px; height: 12px;' readonly="readonly" /></div>
											</td>
											<td align="center" style="width: 25%"><b>Product </b></td>
											<td valign="top" align="right">
											<div id="customerProduct"><input type="text"
												name="customerProduct" id="search-text" value=""
												style='border-style: none; width: 130px;' readonly="readonly"/></div>
											</td>

										</tr>

									</table>
									</td>
								</tr>
								
								<tr>
									<td align="left"><b>Code</b>
									
									
									</td>
									<td>
									<table>
										<tr>

									<td valign="top" align="center">
									<div id="customerCode"><input type="text"
										name="customerCode" id="lab-text" value=""
										style='border-style: none; width: 70px; height: 12px' readonly="readonly"/></div>
									</td>
							<td align="right"><b>Weekly off:</b></td>
								<td valign="top" align="center">
								<div id="customerWeeklyOff"><input type="text"
										name="customerWeeklyOff" id="search-text" value=""
										style='border-style: none; width: 70px;' readonly="readonly"/></div>
										</td>

										</tr>

									</table>
									</td>
 
								</tr>

								<tr>
									<td align="left"><b>Fax</b></td>
									<td valign="top" align="left">
									<table>
										<tr>
											<td>
											<div id="customerFax"><input type="text"
												name="customerFax" id="search-text" value=""
												style='border-style: none; width: 120px;'
												readonly="readonly" /></div>
											</td>
											<td>
											<div id="prospectFollowUp" style="position: absolute;">
											</div>
											</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr> 
								
									<td align="left" style="background: white;"><b>WebSite</b></td>
									<td valign="top" align="left" style="background: white;">
									<div id="customerWebSite"><input type="text"
										name="customerWebSite" id="search-text" value=""
										style='border-style: none; width: 180px;' readonly="readonly"/></div>
									</td>
								</tr>
							</table>
							</td>
							<td align="left" valign="top">
							<table>
								<tr>
									<td>
									<div id='ProspectList'>
									<div style="height: 110px; width: 300px; overflow: auto;">
									<table style="display: none;">
									</table>
									</div>
									</div>
									</td>
								</tr>
								<tr>
									<td align="right" valign="top">
									<div>
									<a href="#" onclick="showFollowUpEntryForm('followUpTable', 'block'); return false"><input
										type="submit" id="search-submit" name="followUp"
										value="Follow-Up     "  onclick="<%FollowUpType = "Pros";%>" /></a>
										</div>
									</td>
								</tr>
								<tr>
									<td align="right" valign="top">
									<a href="#" ><input type="button" onclick="goto('addNewCustomer.jsp');"
  												id="search-submit"
										name="addNewCustomer" value=" Add New     " /></a>
								</td>
								</tr>

								<tr>
									<td align="right" valign="top"><a href="#"
										onclick="newwindow();"><input type="button"
										id="search-submit" name="Details" value="Details           " /></a>
									</td>
								</tr>
								<tr>
									<td align="right" valign="top"><input type="button" 
										id="search-submit" name="prosFollowUpReport" value="Follow-Up Rep"
										 onclick="gotoFollowUpReportAsProspect('customerWiseFollowUpReport.jsp');"/>
									</td>
								</tr>


								<tr>
															 		<td align="right" valign="top">
  											 <a href="#" ><input type="button" onclick="editProspect('addNewCustomer.jsp');"
  												id="search-submit"
										name="EditNewCustomer" value="Edit               " /></a>
 
									</td> 
								</tr>
								<tr>
								 		<td align="right" valign="top">
  											 <a href="#" ><input type="button" onclick="editProspect('prospectHistory.jsp');"
  												id="search-submit"
										name="EditNewCustomer" value="Show History         " /></a>
 
									</td> 
								</tr>
								<tr>
								 	  	<td align="right" valign="top">
  											 <a href="#" ><input type="button" onclick="check('ProsToCust.jsp');"
  												id="search-submit"
										name="convertPros" value="ConvToCust   " /></a>
										
 
									</td>
									
								</tr>
								<tr>
								<td>
								<!--<table  style="border-style:groove; border-color: aqua">
								<tr>
								<th>Tr. Id</th><th>Debit</th>
								<th>Credit</th><th>Bal</th></tr><tr>
								<td>1233232</td><td>233.6</td>
								<td>213.4</td><td>354</td></tr><tr>
								<td>764321432</td><td>2334.6</td>
								<td>245</td><td>3ad</td></tr><tr>
								
								<td>76324esa432</td><td>233d3.6</td>
								<td>2adsf</td><td>sdafsda</td>
								</tr>
								</table>-->
</td></tr>
						 
							</table>
							</td>
						</tr>

						<tr>
							<td colspan="3">
							<table border="0" width="100%">

								<tr>

								</tr>


							</table>
							</td>
						</tr>
					</table>
				
				
				
				
				
				</div>
				</div>

				</div>
				</div>
				</form>
				<script type="text/javascript">
					tabview_initialize('TabView');
				</script>
				</td>
				</tr>

				<tr>
					<td>
             </td>
				</tr>


				<!-- **************************************************************************** -->


			</table>

			</td>
			<td align="left"></td>
		</tr>
	</table>
	</div>
		
	
	</form>
	<%
		System.out.println("//////////"
					+ (String) request.getParameter("msg"));
			System.out.println(session.getAttribute("flag"));
			conn.close();
	%>

	<br>
	<br>
	<br>
	<br>
	<br>
	

	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>