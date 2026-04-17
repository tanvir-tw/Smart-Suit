<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>


	<script src="validateEntryForm.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>


	</head>
	<body>

	<script language="JavaScript1.2">
	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>


	<div id="wrapper">
	<div id="header-wrapper">
	<div id="header">
	<div id="logo">
	<table>
		<tr>
			<td><a href="http://www.transworldcompressor.com/"> <img
				src="images/transworld.jpg"></img> </a></td>
			<td>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>

			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><img src="images/erp.jpeg" height="70" width="200"></img></td>
		</tr>
	</table>
	</div>
	<div id="menu">
	<ul>
		<li><a href="home.jsp">Home</a></li>
		<li><a href="followUpReport.jsp">Report</a></li>
		<li><a href="http://blog.transworld-compressor.com/">Blog</a></li>
		<li><a href="#">Contact</a></li>
	</ul>
	</div>
	</div>
	</div>
	<!-- end #header --> <!-- end #page --></div>
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
		style="font-size: 2em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
	<a>Add New Customer</a></div>

	<form name="addCustomer" method="post" action="addCustomer.jsp"
		onSubmit="return validate();">
	<table border="0" cellpadding="3" width="55%"
		style="background: white;">
		<tr>
			<td valign="top" align="left">
			<div id='repName'>Marketing Rep. Name:</div>
			</td>
			<td valign="top">
			<div id='repName'><select name="repName" id="repName"
				style='width: 190px;'>

				<%
					String sql = "select MarketingRepName,MarketingRepCode  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster order by MarketingRepName";
						ResultSet rs = st.executeQuery(sql);
						while (rs.next()) {
				%>
				<option value="<%=rs.getString(2)%>"
					<%if (selectedName.equals(rs.getString(2))) {%> Selected <%}%>><%=rs.getString(1)%></option>
				<%
					}
				%>

			</select></div>
			</td>

			<td valign="top" align="left">Company Name :</td>
			<td align="left">
			<div id="companyName"><input type="text" name="companyName"
				id="search-text" value="" style='height: 12px;' /></div>

			</td>
		</tr>
		<tr>
			<td valign="top" align="left">Contact Person :</td>
			<td>
			<div id="contactPerson"><input type="text" name="contactPerson"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">E-mail :</td>
			<td>
			<div id="email"><input type="text" name="email"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Web-Site :</td>
			<td>
			<div id="website"><input type="text" name="website"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Address :</td>
			<td>
			<div id="address"><input type="text" name="address"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left">City :</td>
			<td>
			<div id="city"><input type="text" name="city" id="search-text"
				value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">ZipCode :</td>
			<td align="left">
			<div id="zip"><input type="text" name="zip" id="search-text"
				value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">State :</td>
			<td>
			<div id="state"><input type="text" name="state"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Country :</td>
			<td align="left">
			<div id="country"><input type="text" name="country"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Phone No :</td>
			<td>
			<div id="phone"><input type="text" name="phone"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Fax No :</td>
			<td align="left">
			<div id="fax"><input type="text" name="fax" id="search-text"
				value="" style='height: 12px;' /></div>
			</td>
		</tr>

<!-- <tr>
			<td valign="top" align="left">Shipping Address :</td>
			<td>
			<div id="shippingAddress"><input type="text"
				name="shippingAddress" id="search-text" value=""
				style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Shipping City:</td>
			<td align="left">
			<div id="shippingCity"><input type="text" name="shippingCity"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Shipping ZipCode :</td>
			<td>
			<div id="shippingZip"><input type="text" name="shippingZip"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Shipping State :</td>
			<td align="left">
			<div id="shippingState"><input type="text" name="shippingState"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Shipping Country :</td>
			<td>
			<div id="shippingCountry"><input type="text"
				name="shippingCountry" id="search-text" value=""
				style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Shipping Phone :</td>
			<td align="left">
			<div id="shippingPhone"><input type="text" name="shippingPhone"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Shipping Fax No :</td>
			<td>
			<div id="shippingFax"><input type="text" name="shippingFax"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Banker Details</td>
			<td align="left">
			<div id="bankerDetail"><input type="text" name="bankerDetail"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>
		<tr> 		


			<td valign="top" align="left">-</td>
			<td>
			<div id="-"><input type="text" name="-" id="search-text"
				value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">CST/MST :</td>
			<td align="left">
			<div id="CSTOrMST"><input type="text" name="CSTOrMST"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>-->
		<tr>
			<td valign="top" align="left">Category :</td>
			<td>
			<div id="category"><input type="text" name="category"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Intrested In Product :</td>
			<td align="left">
			<div id="product"><input type="text" name="product"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

	<!-- 	<tr>
			<td valign="top" align="left">C/E Forms</td>
			<td>
			<div id="cOReForm"><input type="text" name="cOReForm"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Login Name :</td>
			<td align="left">
			<div id="loginName"><input type="text" name="loginName"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		 -->

		<tr>


		</tr>
<!-- 
		<tr>
			<td valign="top" align="left">Discount (in %) :</td>
			<td>
			<div id="discount"><input type="text" name="discount"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Credit Limit :</td>
			<td align="left">
			<div id="creditLimit"><input type="text" name="creditLimit"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left">Customer Payment Terms :</td>
			<td>
			<div id="paymentTerms"><input type="text" name="paymentTerms"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Payment Mode :</td>
			<td align="left">
			<div id="paymentMode"><input type="text" name="paymentMode"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Mobile Number :</td>
			<td>
			<div id="mobile"><input type="text" name="mobile"
				id="search-text" value="" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Alternate Number :</td>
			<td align="left">
			<div id="alternateNumber"><input type="text"
				name="alternateNumber" id="search-text" value=""
				style='height: 12px;' /></div>
			</td>
		</tr> -->
		<tr></tr>
		<tr></tr>
		<tr>

			<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
		</tr>
	</table>

	</form>


	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
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