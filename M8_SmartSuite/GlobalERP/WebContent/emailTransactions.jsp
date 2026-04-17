<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	</head>
	<body>

	<script language="JavaScript1.2">
	function validate(form) {
		var checked = false;
		var buttons = form.elements.transactions;
		for ( var i = 0; i < buttons.length; i++) {
			if (buttons[i].checked) {
				checked = true;
				break;
			}
		}
		if (!checked)
			alert("You have to choose Number Of Transations to be sent");
		return checked;
	}
	if (document.all || document.getElementById)
		document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>



	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null;
			String companyName = "TESt", email = "test@test.com";
			String customerEmail="";
			if (request.getParameter("email").equalsIgnoreCase("") || request.getParameter("email").equalsIgnoreCase("-"))
				customerEmail="* customers EmailId not available in system";
			else
				customerEmail=request.getParameter("email");
	%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em; background-color: #339CCB">.
	</div>


	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em;">
	Email Statement For <a><%=request.getParameter("company")%></a></div>
	<form method="get" action="sendEmail.jsp"
		onSubmit=" return validate(this);">
	
	<table>

		<!-- 
		<tr>
			<td colspan="2"><b>Email Last</b> <input type="radio"
				name="transactions" value="3" />3 </div><input type="radio"
				name="transactions" value="5" />5 <input type="radio"
				name="transactions" value="10" />10 <input type="radio"
				name="transactions" value="LastMonth" />Last Month <input
				type="radio" name="transactions" value="all" />All <b>Transactions</b>
			</td>
		</tr> -->
<tr>
<td></td>
<td>	<input type="hidden" id="fromDate" name="fromDate" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("fromDate"))) %>"/>
<input type="hidden" id="toDate" name="todate" value="<%=new SimpleDateFormat( "yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(request.getParameter("toDate"))) %>"/>
</td>
</tr>


		<tr>
			<td valign="top"><b>E-mail To:</b></td>

			<td>
			<table>
				<tr>
					<td><input type="checkbox" name="manager" value="Manager" />Manager
					</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="sales" value="Sales" />
					Sales Dept</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="accounts" value="Accounts" />
					A/c's Dept</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MD" value="MD" /> MD</td>
				</tr>
				<tr>
					<td valign="top"><%if (!customerEmail.startsWith("*")) {%><input type="checkbox" name="customer"
						value="customer" /><%}else{ %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%} %>
					Customer</td>
					<td><textarea name="companyEmail" rows="1" id="search-text"
						style='border-style: none; width: 200px; height: auto;'>(<%=customerEmail%>)</textarea>
					</td>
				</tr>
			</table>
			</td>
			<!-- 
			<td><textarea name="companyEmail" rows="1" id="search-text"
				style='border-style: none; width: 200px; height: auto;'>< %=request.getParameter("email") %></textarea>
			</td> -->
		</tr>

		<tr>
			<td><b>Cc :(<%=session.getAttribute("EmpName").toString()%>)</b></td>
			<td align="left"><input type="text"
				style="border: none; width: 200px;" readonly="readonly"
				value="<%=session.getAttribute("EmpEmail")%>"></input></td>
		</tr>
		<tr>
			<td><br>
			</td>
		</tr>
		<tr>
			<td><b>Add Extra Email Id's</b><br>(optional and Cc)
			</td>
			<td><textarea name="ExtraEmail" rows="2" id="search-text"
				style='width: 200px; height: auto;' ></textarea></td>
		</tr>
		
				<tr>
			<td><b>Body:
			</td>
			<td><textarea name="body" rows="3" id="search-text"
				style='width: 200px; height: auto;'></textarea></td>
		</tr>
		
		
		<tr>

		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"><input type="submit" value="Send" /> &nbsp;&nbsp;&nbsp;
			<input type="reset" value="Clear" />&nbsp;&nbsp;&nbsp;
			<input type="button" value="Cancel" onclick="window.close()"/>
			</td>
			
		</tr>
		<tr>
		<td><input type="hidden" name="customerName" value="<%=request.getParameter("company") %>" />
		</td>
		</tr>
	</table>


	</form>
	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em; background-color: #339CCB">.
	</div>
	<br></br>





	<br><br> <br><br> <br><br> <br><br>
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