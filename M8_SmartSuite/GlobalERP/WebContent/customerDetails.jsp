<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%-- <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 --%>	
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
<%-- 
     <%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	 --%>
	<%
			Connection conn = null;
			Statement st = null;
			Statement st2 = null;
			String companyName;
			String customerType;
			String FollowUpType = "";
			String CustomerCode="",	CompanyName="-",	ContactPerson="-",EMail="-",WebSite="-",BillingAddress="-";
			String BillingCity="-",BillingZip="-",BillingState="-",BillingCountry="-",BillingPhone="-",BillingFax="-",ShippingAddress="-";
			String ShippingCity="-", ShippingZip="",ShippingState="-",ShippingCountry="-",	ShippingPhone="-",ShippingFax="-";
			String BankerDetail="-",CSTOrMST="-",Category="-",	Terms="-",CorEForms="-",LoginName="",CustPassword="-",	IntrestedProduct="-";
			String TWEmpName="-",EnteredOn="-",IsDataValid="-", 	CustDiscountPercent="-", 	CustCreditLimit="-", 	CustPaymentTerms="-";
			String CustPaymentMode="-", CustomerCode1="",	STDCode="-", 	MobileNo="-", 	ResiNo="-", 	TelephoneNo2="-", 	VendorCod="-";
	
			Class.forName(DB_Driver);
			conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

	
	%>
	<%
		if (null == request.getParameter("companyName"))
			companyName = "";
			else
				companyName = request.getParameter("companyName").replace("~","&");
				customerType = request.getParameter("type");
				CustomerCode1 = request.getParameter("customercode");

				System.out.println("Company Name =======>"+companyName);
				System.out.println("customerType  =======>"+customerType);
				System.out.println("customerType  =======>"+CustomerCode1);


try {
/*              	conn = erp.ReturnConnection();
 */				st = conn.createStatement();
				st2 = conn.createStatement();
		 
	%>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; height: 4px; background-color: #339CCB">
	</div>

	<div
		style="font-size: 1.5em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a><%=request.getParameter("companyName").replace("~","&") %></a></div>

	<div align="center"
		style="font-size: 1.5em; height: 4px; background-color: #339CCB">
	</div>

	<%
	if(customerType.equals("Prospect"))
	{
			//query for prospect
			String sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName = '"+companyName+"' limit 1";
			System.out.print(sql);
			ResultSet rs=st.executeQuery(sql);
			if(rs.next())
			{
				CustomerCode=rs.getString("CustomerCode");	
				CompanyName=rs.getString("CompanyName");	
				ContactPerson=rs.getString("ContactPerson");
				EMail=rs.getString("EMail");
				WebSite=rs.getString("WebSite");
				BillingAddress=rs.getString("Address");
				BillingCity=rs.getString("City");
				BillingZip=rs.getString("Zip");
				BillingState=rs.getString("State");
				BillingCountry=rs.getString("Country");
				BillingPhone=rs.getString("Phone");
				BillingFax=rs.getString("Fax");
				IntrestedProduct=rs.getString("IntrestedProduct");
				TWEmpName=rs.getString("CustEnteredByRep");
				EnteredOn=rs.getString("AddedOnDate");
				IsDataValid=rs.getString("IsDataValid"); 	
				STDCode=rs.getString("STDCode"); 	
				MobileNo=rs.getString("MobileNo"); 	
				ResiNo=rs.getString("ResiNo"); 	
				TelephoneNo2=rs.getString("TelephoneNo2"); 	
				VendorCod=rs.getString("VendorCode");				
			}
		
	}else if(customerType.equals("Customer"))
	{
				//code for customer
				String sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName = '"+companyName+"' and CustomerCode='"+CustomerCode1+"' limit 1";
				System.out.print(sql);
				ResultSet rs=st.executeQuery(sql);
				if(rs.next())
				{
				
					CustomerCode = rs.getString("CustomerCode");	
					CompanyName = rs.getString("CompanyName");	
					ContactPerson = rs.getString("ContactPerson");
					EMail = rs.getString("EMail");
					WebSite = rs.getString("WebSite");
					BillingAddress = rs.getString("BillingAddress");
					BillingCity = rs.getString("BillingCity");
					BillingZip = rs.getString("BillingZip");
					BillingState = rs.getString("BillingState");
					BillingCountry = rs.getString("BillingCountry");
					BillingPhone = rs.getString("BillingPhone");
					BillingFax = rs.getString("BillingFax");
					ShippingAddress = rs.getString("ShippingAddress");
					ShippingCity = rs.getString("ShippingCity"); 
					ShippingZip = rs.getString("ShippingZip");
					ShippingState = rs.getString("ShippingState");
					ShippingCountry = rs.getString("ShippingCountry");	
					ShippingPhone = rs.getString("ShippingPhone");
					ShippingFax = rs.getString("ShippingFax");
					BankerDetail = rs.getString("BankerDetail");
					CSTOrMST = rs.getString("CSTOrMST");
					Category = rs.getString("Category");	
					Terms = rs.getString("Terms");
					CorEForms = rs.getString("CorEForms");
					LoginName = rs.getString("LoginName");
					CustPassword = rs.getString("CustPassword");	
					IntrestedProduct = rs.getString("IntrestedProduct");
					TWEmpName = rs.getString("TWEmpName");
					EnteredOn = rs.getString("EnteredOn");
					IsDataValid = rs.getString("IsDataValid"); 	
					CustDiscountPercent = rs.getString("CustDiscountPercent"); 	
					CustCreditLimit = rs.getString("CustCreditLimit"); 	
					CustPaymentTerms = rs.getString("CustPaymentTerms");
					CustPaymentMode = rs.getString("CustPaymentMode"); 	
					STDCode = rs.getString("STDCode"); 	
					MobileNo = rs.getString("MobileNo"); 	
					ResiNo = rs.getString("ResiNo"); 	
					TelephoneNo2 = rs.getString("TelephoneNo2"); 	
					VendorCod = rs.getString("VendorCode");
				
				}
	
	}
%>

<%if(customerType.equals("Customer")) 
{%>
	<table border="0" cellpadding="3" width="100%" cellspacing="6"
		style="background: white;">
		<tr>

			<td valign="top" align="left"><b>Company Code : </b></td>
			<td align="left">
			<div id="CustomerCode"><input type="text" name="CustomerCode"
				id="search-text" style='height: 12px; border: none;'
				value="<%=CustomerCode %>" readonly="readonly" /></div>

			</b></td>

			<td valign="top" align="left"><b>Added By : </b></td>
			
			
			<%
			String entDate = "";
			System.out.println("EnteredOn"+EnteredOn);
				if(EnteredOn.equals("") || EnteredOn.equals("-"))
				{
					%><td align="left"><input type="text" name="CustomerCode"
				id="search-text" style='width: 95px; height: 12px; border: none;'
				value="<%=TWEmpName %>" readonly="readonly" /> <b>&nbsp;ON : </b>&nbsp;<%=entDate %> </b></td> <%
				}else
				{
					%><td align="left"><input type="text" name="CustomerCode"
							id="search-text" style='width: 95px; height: 12px; border: none;'
							value="<%=TWEmpName %>" readonly="readonly" /> <b>&nbsp;ON : </b>&nbsp;<%=new SimpleDateFormat(
							"dd-MMM-yyyy")
							.format(new SimpleDateFormat(
									"yyyy-MM-dd")
									.parse(EnteredOn.replace(".0",""))) %> </b></td><%	
				}
			%>
			
						
						
						
		</tr>
		
		<tr>
			<td valign="top" align="left"><b>Contact Person : </b></td>
			<td>
			<div id="contactPerson"><textarea name="contactPerson"
				id="search-text" rows="3" style='height: auto; border: none;'
				readonly="readonly"><%=ContactPerson %></textarea></div>
			</td>
			<td valign="top" align="left"><b>WebSite :</b></td>
			<td valign="top">
			<div id="website"><label> <a
				href="http://<%=WebSite %>"> <%=WebSite %></a></label></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>E-mails : </b></td>
			<td>
			<div id="email"><textarea name="email" rows="3"
				id="search-text" style='width: 175px; height: auto; border: none;'
				readonly="readonly"><%=EMail %></textarea></div>
			</td>
			<td valign="top" align="left"><b>Banker Details :</b></td>
			<td>
			<div id="BankerDetail"><textarea name="BankerDetail" rows="3"
				id="search-text" style='width: 175px; border: none; height: auto;'><%=BankerDetail %>
				</textarea></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b> Correspondence Address : </b></td>
			<td>
			<div id="email"><textarea name="corresadd" rows="3"
				id="search-text" style='width: 175px; height: auto; border: none;'
				readonly="readonly"><%=BillingAddress %></textarea></div>
			</td>
			<td valign="top" align="left"><b>Shipping Address:</b></td>
			<td>
			<div id="shippingadd"><textarea name="shippingadd" rows="3"
				id="search-text" style='width: 175px; border: none; height: auto;'><%=ShippingAddress %>
				</textarea></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Billing City :</b></td>
			<td>
			<div id="BillingCity"><input type="text" name="BillingCity"
				id="search-text" style='height: 12px; border: none;'
				value="<%=BillingCity %>" readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Billing Zip Code :</b></td>
			<td align="left">
			<div id="BillingZip"><input type="text" name="BillingZip"
				id="search-text" style='height: 12px; border: none;'
				value="<%=BillingZip %>" readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Billing State :</b></td>
			<td>
			<div id="BillingState"><input type="text" name="BillingState"
				id="search-text" style='height: 12px; border: none;'
				value='<%=BillingState  %>' readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Billing Country :</b></td>
			<td align="left">
			<div id="BillingCountry"><input type="text"
				name="BillingCountry" id="search-text"
				style='height: 12px; border: none;' value='<%=BillingCountry  %>'
				readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Billing Phone :</b></td>
			<td>
			<div id="BillingPhone"><input type="text" name="BillingPhone"
				id="search-text" style='width:300px; height: 12px; border: none;'
				value='<%=BillingPhone  %>' readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Billing Fax :</b></td>
			<td align="left">
			<div id="BillingFax"><input type="text" name="BillingFax"
				id="search-text" style='height: 12px; border: none;'
				value='<%=BillingFax  %>' readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Shipping City :</b></td>
			<td>
			<div id="ShippingCity"><input type="text" name="ShippingCity"
				id="search-text" style='height: 12px; border: none;'
				value="<%=ShippingCity %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Shipping Zip Code :</b></td>
			<td align="left">
			<div id="ShippingZip"><input type="text" name="ShippingZip"
				id="search-text" style='height: 12px; border: none;'
				value="<%=ShippingZip %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Shipping State :</b></td>
			<td>
			<div id="ShippingState"><input type="text" name="ShippingState"
				id="search-text" style='height: 12px; border: none;'
				value="<%=ShippingState  %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Shipping Country :</b></td>
			<td align="left">
			<div id="ShippingCountry"><input type="text"
				name="ShippingCountry" id="search-text"
				style='height: 12px; border: none;' value="<%=ShippingCountry  %>"
				readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Shipping Phone :</b></td>
			<td>
			<div id="ShippingPhone"><input type="text" name="ShippingPhone"
				id="search-text" style='width:300px; height: 12px; border: none;'
				value="<%=ShippingPhone  %>" readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Shipping Fax :</b></td>
			<td align="left">
			<div id="ShippingFax"><input type="text" name="ShippingFax"
				id="search-text" style='height: 12px; border: none;'
				value="<%=ShippingFax  %>" readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>CST/MST :</b></td>
			<td>
			<div id="CSTOrMST"><input type="text" name="CSTOrMST"
				id="search-text" style='height: 12px; border: none;'
				value="<%=CSTOrMST  %>" readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Mobile No : *</b></td>
			<td>
			<div id="phone"><input type="text" name="phone"
				id="search-text" style='height: 12px; border: none;'
				value="<%=MobileNo%>" readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>STD Code :</b></td>
			<td>
			<div id="std"><input type="text" name="std" id="search-text"
				style='height: 12px; border: none;' value="<%=STDCode %>"
				readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Phone Number :</b></td>
			<td align="left">
			<div id="ph"><input type="text" name="ph" id="search-text"
				style='height: 12px; border: none;' value="<%=ResiNo%>"
				readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Category :</b></td>
			<td>
			<div id="category">
			<%String cat=""; 
				  String sqlDropdown="SELECT TheGroupName  FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where IsDataValid='1' and TheGroupCode='"+Category+"'";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  if(rsDropdown.next()){
				 cat=rsDropdown.getString(1);
				  }%> <input type="text" name="ph" id="search-text"
				style='height: 12px; border: none;' value="<%=cat %>"
				readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Intrested In Product :</b></td>
			<td align="left">
			<div id="product"><input type="text" name="product" value="<%=IntrestedProduct %>"
				id="search-text" style='height: 12px; border: none;'
				readonly="readonly" /></div>
			</b></td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>Alternate Number :</b></td>
			<td align="left">
			<div id="alternateNumber"><input type="text"  value="<%=TelephoneNo2%>"
				name="alternateNumber" id="search-text"
				style='height: 12px; border: none;' readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
		</tr>

	</table>
<%}else if(customerType.equals("Prospect")) {%>

<table border="0" cellpadding="3" width="100%" cellspacing="6"
		style="background: white;">
		<tr>

			<td valign="top" align="left"><b>Company Code : </b></td>
			<td align="left">
			<div id="CustomerCode"><input type="text" name="CustomerCode"
				id="search-text" style='height: 12px; border: none;'
				value="<%=CustomerCode %>" readonly="readonly" /></div>

			</b></td>

			<td valign="top" align="left"><b>Added By : </b></td>
			
			
			<%
			String entDate = "";
				if(EnteredOn.equals(""))
				{
					%><td align="left"><input type="text" name="CustomerCode"
				id="search-text" style='width: 95px; height: 12px; border: none;'
				value="<%=TWEmpName %>" readonly="readonly" /> <b>&nbsp;ON : </b>&nbsp;<%=entDate %> </b></td> <%
				}else
				{
					%><td align="left"><input type="text" name="CustomerCode"
							id="search-text" style='width: 95px; height: 12px; border: none;'
							value="<%=TWEmpName %>" readonly="readonly" /> <b>&nbsp;ON : </b>&nbsp;<%=new SimpleDateFormat(
							"dd-MMM-yyyy")
							.format(new SimpleDateFormat(
									"yyyy-MM-dd")
									.parse(EnteredOn.replace(".0",""))) %> </b></td><%	
				}
			%>
			
						
						
						
		</tr>
		
		<tr>
			<td valign="top" align="left"><b>Contact Person : </b></td>
			<td>
			<div id="contactPerson"><textarea name="contactPerson"
				id="search-text" rows="3" style='height: auto; border: none;'
				readonly="readonly"><%=ContactPerson %></textarea></div>
			</td>
			<td valign="top" align="left"><b>WebSite :</b></td>
			<td valign="top">
			<div id="website"><label> <a
				href="http://<%=WebSite %>"> <%=WebSite %></a></label></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>E-mails : </b></td>
			<td>
			<div id="email"><textarea name="email" rows="3"
				id="search-text" style='width: 175px; height: auto; border: none;'
				readonly="readonly"><%=EMail %></textarea></div>
			</td>
			<td valign="top" align="left"><b>Banker Details :</b></td>
			<td>
			<div id="BankerDetail"><textarea name="BankerDetail" rows="3"
				id="search-text" style='width: 175px; border: none; height: auto;'><%=BankerDetail %>
				</textarea></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Address : </b></td>
			<td>
			<div id="email"><textarea name="corresadd" rows="3"
				id="search-text" style='width: 175px; height: auto; border: none;'
				readonly="readonly"><%=BillingAddress %></textarea></div>
			</td>
			<td valign="top" align="left"><b>Billing City :</b></td>
			<td>
			<div id="BillingCity"><input type="text" name="BillingCity"
				id="search-text" style='height: 12px; border: none;'
				value="<%=BillingCity %>" readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Zip Code :</b></td>
			<td align="left">
			<div id="BillingZip"><input type="text" name="BillingZip"
				id="search-text" style='height: 12px; border: none;'
				value="<%=BillingZip %>" readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>State :</b></td>
			<td>
			<div id="BillingState"><input type="text" name="BillingState"
				id="search-text" style='height: 12px; border: none;'
				value='<%=BillingState  %>' readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			
			<td valign="top" align="left"><b>Country :</b></td>
			<td align="left">
			<div id="BillingCountry"><input type="text"
				name="BillingCountry" id="search-text"
				style='height: 12px; border: none;' value='<%=BillingCountry  %>'
				readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Phone :</b></td>
			<td>
			<div id="BillingPhone"><input type="text" name="BillingPhone"
				id="search-text" style='width:300px; height: 12px; border: none;'
				value='<%=BillingPhone  %>' readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			
			<td valign="top" align="left"><b>Fax :</b></td>
			<td align="left">
			<div id="BillingFax"><input type="text" name="BillingFax"
				id="search-text" style='height: 12px; border: none;'
				value='<%=BillingFax  %>' readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Mobile No : *</b></td>
			<td>
			<div id="phone"><input type="text" name="phone"
				id="search-text" style='height: 12px; border: none;'
				value="<%=MobileNo%>" readonly="readonly" /></div>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>STD Code :</b></td>
			<td>
			<div id="std"><input type="text" name="std" id="search-text"
				style='height: 12px; border: none;' value="<%=STDCode %>"
				readonly="readonly" /></div>
			</td>
			<td valign="top" align="left"><b>Phone Number :</b></td>
			<td align="left">
			<div id="ph"><input type="text" name="ph" id="search-text"
				style='height: 12px; border: none;' value="<%=ResiNo%>"
				readonly="readonly" /></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><b>Category :</b></td>
			<td>
			<div id="category">
			<%String cat=""; 
				  String sqlDropdown="SELECT TheGroupName  FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where IsDataValid='1' and TheGroupCode='"+Category+"'";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  if(rsDropdown.next()){
				 cat=rsDropdown.getString(1);
				  }%> <input type="text" name="ph" id="search-text"
				style='height: 12px; border: none;' value="<%=cat %>"
				readonly="readonly" /></div>
			</b></td>
			<td valign="top" align="left"><b>Intrested In Product :</b></td>
			<td align="left">
			<div id="product"><input type="text" name="product" value="<%=IntrestedProduct %>"
				id="search-text" style='height: 12px; border: none;'
				readonly="readonly" /></div>
			</b></td>
		</tr>
		<tr>
			<td valign="top" align="left"><b>Alternate Number :</b></td>
			<td align="left">
			<div id="alternateNumber"><input type="text"  value="<%=TelephoneNo2%>"
				name="alternateNumber" id="search-text"
				style='height: 12px; border: none;' readonly="readonly" /></div>
			</b></td>
		</tr>

		<tr>
		</tr>

	</table>

<%} %>	
	

<% } catch (Exception e) {
out.print("!!!Connection Lost!!!");
e.printStackTrace();
}
finally{
	conn.close();
}%>

	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
<%-- </jsp:useBean>
 --%>
