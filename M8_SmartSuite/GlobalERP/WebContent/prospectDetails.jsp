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


	<meta name="keywords" content="" readonly="readonly" />
	<meta name="description" content="" readonly="readonly" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8"
		readonly="readonly" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" readonly="readonly" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" readonly="readonly" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css"
		readonly="readonly" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	</head>
	<body>


	</head>
	<body>

	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType = "";
	%>
	<%
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
			} catch (Exception e) {
			}
	try{
 	String company=request.getParameter("companyName");
 	System.out.println("********    "+company);	
	
 	String abc=company.replace("ampersand","&");
	System.out.println("********    "+abc);	
	String sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName ='"+abc+"' limit 1 ";
	System.out.println("\\\\\\\\\\\\\\\\\\"+sql);
	System.out.println(sql);
	ResultSet rs1=st.executeQuery(sql);
	rs1.next();
%>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; height: 4px; background-color: #339CCB">
	</div>
	<div
		style="font-size: 1.5em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a><%=abc %></a></div>

	<div align="center"
		style="font-size: 1.5em; margin-bottom: 0.5em; height: 4px; background-color: #339CCB">
	</div>
	<table border="0" cellpadding="3" width="100%"
		style="background: white;">
		<tr>

			<td valign="top" align="left"><b>Company Name : </b></td>
			<td align="left">
			<div id="companyName"><textarea readonly="readonly"
				name="companyName" rows="2"
				style='width: 175px; height: auto; border: none;'><%=rs1.getString("CompanyName") %></textarea>
			</div>
			</td>

			<td valign="top" align="left"><b>Contact Person : #</b></td>
			<td>
			<div id="contactPerson"><textarea readonly="readonly"
				name="contactPerson" rows="2"
				style='width: 175px; height: auto; border: none;'><%=rs1.getString("ContactPerson") %></textarea>
			</div>
			</td>

		</tr>
		<tr>
			<td><b>Added On</b></td>
			<td><%=new SimpleDateFormat(
			"dd-MMM-yyyy")
			.format(new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss")
					.parse(rs1.getString("ProspCustAddedOn").replace(".0",""))) %></td>
		</tr>
		<tr>
			<td valign="top" align="left">
			<div id='repName'><b>Marketing Rep. Name:</b></div>
			</td>
			<td valign="top">
			<div id='repName'><input type="text"
				style='width: 175px; height: auto; border: none;' name="repName"
				value="<%=rs1.getString("CustEnteredByRep") %>" readonly="readonly"
				readonly="readonly" /></div>
			</td>

			<td valign="top" align="left"><b>WebSite :</b></td>
			<td>
			<div id="website"><input type="text" name="website"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("WebSite") %>" readonly="readonly" /></div>
			</b></td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>Assigned By:</b></td>
			<td valign="top">
			<div id='assignedBy'><input type="text"
				style='width: 175px; height: auto; border: none;' name="assignedBy"
				value="<%=rs1.getString("Assighnedby") %>" readonly="readonly" /></div>
			</td>

			<td valign="top" align="left"><b>Lead Ref :</b></td>
			<td>
			<div id="leadRef"><input type="text" name="leadRef"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("leadRef") %>" readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>E-mail : </b></td>
			<td>
			<div id="email"><textarea name="email" rows="3"
				style='width: 175px; height: auto; border: none;'
				readonly="readonly"><%=rs1.getString("EMail") %></textarea></div>
			</b></td>
			<td valign="top" align="left"><b>Address :</b></td>
			<td>
			<div id="address"><textarea name="address" rows="3"
				style='width: 175px; height: auto; border: none;'
				readonly="readonly"><%=rs1.getString("Address") %>
				</textarea></div>
			</b></td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>City :</b></td>
			<td>
			<div id="city"><input type="text" name="city"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("City") %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>ZipCode :</b></td>
			<td align="left">
			<div id="zip"><input type="text" name="zip"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("Zip") %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>State :</b></td>
			<td>
			<div id="state"><input type="text" name="state"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("State") %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Country :</b></td>
			<td align="left">
			<div id="country"><input type="text" name="country"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("Country") %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Mobile No : *</b></td>
			<td>
			<div id="phone"><input type="text" name="phone"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("MobileNo") %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Fax No :</b></td>
			<td align="left">
			<div id="fax"><input type="text" name="fax"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("Fax") %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>STD Code :</b></td>
			<td>
			<div id="std"><input type="text" name="std"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("STDCode") %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Phone Number :</b></td>
			<td align="left">
			<div id="ph"><input type="text" name="ph"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("Phone") %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Category :</b></td>
			<td>
			<div id="category">
			<% String sqlDropdown="SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where IsDataValid='1' and TheGroupCode='"+rs1.getString("Category")+"'";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  rsDropdown.next();
				  %> <input type="text" name="weeklyOffOn"
				style='width: 175px; height: auto; border: none;'
				value="<%=rsDropdown.getString("TheGroupName") %>"
				readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Intrested In Product :</b></td>
			<td align="left">
			<div id="product"><input type="text" name="product"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("IntrestedProduct") %>" readonly="readonly" /></div>
			</b></td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>Weekly Off On :</b></td>
			<td>
			<div id="weeklyOffOn"><input type="text" name="weeklyOffOn"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("WeeklyOffon") %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Alternate Number :</b></td>
			<td align="left">
			<div id="alternateNumber"><input type="text"
				name="alternateNumber"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("TelephoneNo2") %>" readonly="readonly" /></div>
			</b></td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>Potential Value :</b></td>
			<td>
			<div id="weeklyOffOn"><input type="text" name="weeklyOffOn"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("potentialvalue") %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Comments :</b></td>
			<td align="left">
			<div id="alternateNumber"><input type="text"
				name="alternateNumber"
				style='width: 175px; height: auto; border: none;'
				value="<%=rs1.getString("comments") %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
		</tr>
	</table>
	<%
conn.close();
	}catch(Exception e){System.out.print(e);
e.printStackTrace();
}
	 %>
	<br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>