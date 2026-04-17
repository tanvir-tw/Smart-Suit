<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<%@page import="com.sun.org.apache.xml.internal.utils.StringBufferPool"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

	</head>
	<body>
	<script type="text/javascript">
	function validate()
	{
		 var marketingRep=document.addCustomer.repName.value;//alert(marketingRep);
		 var companyName=document.addCustomer.companyName.value;//alert(companyName);
		 var contactPerson=document.addCustomer.contactPerson.value;//alert(contactPerson);
		 var website=document.addCustomer.website.value;//alert(website);
		 var email=document.addCustomer.email.value;//alert(email);
		 var address=document.addCustomer.address.value;//alert(address);
		 var city=document.addCustomer.city.value;//alert(city);
		 var zip=document.addCustomer.zip.value;//alert(zip);
		 var state=document.addCustomer.state.value;//alert(state);
		 var country=document.addCustomer.country.value;//alert(country);
		 var mobile=document.addCustomer.phone.value;//alert(phone);
		 var phone=document.addCustomer.ph.value;//alert(phone);
		 var fax=document.addCustomer.fax.value;//alert(fax);
		 var category=document.addCustomer.category.value;//alert(category);
		 var product=document.addCustomer.product.value;//alert(product);
		 var weeklyOffOn=document.addCustomer.weeklyOffOn.value;//alert(weeklyOffOn);
		 var alternateNumber=document.addCustomer.alternateNumber.value;//alert(alternateNumber);

	      var numericExpression = /^[0-9]+$/;
	    	if(contactPerson.match(numericExpression)){
		    	alert("Persons name cannot be  Numeric");
	    		return false;
	    	}

	    	if(companyName=="" && contactPerson==""){
		    	alert("Please enter company name or contact person ");
	    		return false;
	    	}

	    	if(email=="" ){
		    	alert("Please enter Email-Id");
	    		return false;
	    	}
	    	if(mobile=="" ){
		    	alert("Please enter Mobile number");
	    		return false;
	    	}
 
	    	var at="@";
	    		var dot=".";
	    		var lat=email.indexOf(at);
	    		var lstr=email.length;
	    		var ldot=email.indexOf(dot);
	    		if (email.indexOf(at)==-1){
	    		   alert("Invalid E-mail ID");
	    		   return false;
	    		}
		    	if(!(mobile.match(numericExpression))){
			    	alert("Mobile Number Should Be Numeric Value");
		    		return false;
		    	}
		    	if(phone!="")
		    	if(!(phone.match(numericExpression))){
			    	alert("Phone Number Should Be Numeric Value");
		    		return false;
		    	}
	            var agree=confirm(" CompanyName: "+companyName+"\n Contact Person : "+contactPerson+"\n Email: "+email+"\n Mobile: "+mobile+"\n\nAre you sure you want to continue with these values?");
	    		if (agree)
	    			return true ;
	    		else
	    			return false ;
 
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
			String companyCode;

			
	%>
	<%
			companyCode = request.getParameter("companyCode");

			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
	%>

<%
	 String sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode = '"+companyCode+"' limit 1";
	System.out.println(sql);
	ResultSet rs=st.executeQuery(sql);
	if(rs.next())
	{
%>
	<div
		style="font-size: 1.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;"><b>Edit :  
	<a> <%=rs.getString("CompanyName") %></b></a></div>
	
<form name="addCustomer" method="post" action="updateCustomer_ssl.jsp"
		onSubmit="return validate();">
		
		<input type="hidden" name="companycode" value="<%=companyCode %>">
		<input type="hidden" name="companyname" value="<%=rs.getString("CompanyName")%>">
		
	<table border="0" cellpadding="3" width="80%"
		style="background: white;">

		<tr>
			<td valign="top" align="left">Contact Person : #</td>
			<td>
			<div id="contactPerson"><input type="text" name="contactPerson"
				id="search-text"  style='height: 12px;' value="<%=rs.getString("ContactPerson") %>"/></div>
				<a href="contactdetails.jsp?customercode=<%=rs.getString("customercode")%>&companyname=<%=rs.getString("companyname") %>&Type=Cust" style="font-weight: bold; color: black; " >Add Contacts</a>
			</td>
			<td valign="top" align="left">WebSite :</td>
			<td>
			<div id="website"><input type="text" name="website"
				id="search-text"  style='height: 12px;' value="<%=rs.getString("WebSite") %>" /></div>
			</td>
			
			<td valign="top" align="right"> Reason for updating<br>this record</td>
			<td><textarea
										name="reason" rows="1" id="search-text"
										style='width: 175px; height: auto;'></textarea></td>
		</tr>

		<tr>
			<td valign="top" align="left">E-mails : *<br>(add comma seprated<br> Id's if more than one)</td>
			<td>
			<div id="email">
					<textarea
						name="email" rows="2" id="search-text"
						style='width: 175px; height: auto;'><%=rs.getString("EMail") %></textarea>
			</div>
			</td>
			<td valign="top" align="left">Banker Details :</td>
			<td>
			<div id="BankerDetail">
				<textarea
										name="BankerDetail" rows="2" id="search-text"
										style='width: 175px; height: auto;'><%=rs.getString("BankerDetail") %></textarea>
			</div>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left">Billing City :</td>
			<td>
			<div id="BillingCity"><input type="text" name="BillingCity" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("BillingCity") %>"/></div> 
			</td>
			<td valign="top" align="left">Billing Zip Code :</td>
			<td align="left">
			<div id="BillingZip"><input type="text" name="BillingZip" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("BillingZip") %>"/></div>
			</td>
		</tr>
		
		<tr>
			<td valign="top" align="left">Billing State :</td>
			<td>
			<div id="BillingState"><input type="text" name="BillingState" id="search-text"
				 style='height: 12px;' value<%=rs.getString("BillingState")  %>/></div>
			</td>
			<td valign="top" align="left">Billing Country :</td>
			<td align="left">
			<div id="BillingCountry"><input type="text" name="BillingCountry" id="search-text"
				 style='height: 12px;' value<%=rs.getString("BillingCountry")  %>/></div>
			</td>
		</tr>
		
		<tr>
			<td valign="top" align="left">Billing Phone :</td>
			<td>
			<div id="BillingPhone"><input type="text" name="BillingPhone" id="search-text"
				 style='height: 12px;' value<%=rs.getString("BillingPhone")  %>/></div>
			</td>
			<td valign="top" align="left">Billing Fax :</td>
			<td align="left">
			<div id="BillingFax"><input type="text" name="BillingFax" id="search-text"
				 style='height: 12px;' value<%=rs.getString("BillingFax")  %>/></div>
			</td>
		</tr>
		
				
		<tr>
			<td valign="top" align="left">Billing Address :</td>
			<td>
			<div id="BillingAddress"><textarea
										name="BillingAddress" rows="2" id="search-text"
										style='width: 175px; height: auto;'><%=rs.getString("BillingAddress") %></textarea></div>
			</td>
			<td valign="top" align="left">Shipping Address :</td>
			<td align="left">
			<div id="ShippingAddress"><textarea
										name="ShippingAddress" rows="2" id="search-text"
										style='width: 175px; height: auto;'><%=rs.getString("ShippingAddress") %></textarea></div>
			</td>
		</tr>
 
 		<tr>
			<td valign="top" align="left">Shipping City :</td>
			<td>
			<div id="ShippingCity"><input type="text" name="ShippingCity" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("ShippingCity") %>"/></div>
			</td>
			<td valign="top" align="left">Shipping Zip Code :</td>
			<td align="left">
			<div id="ShippingZip"><input type="text" name="ShippingZip" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("ShippingZip") %>"/></div>
			</td>
		</tr>
		
				<tr>
			<td valign="top" align="left">Shipping State :</td>
			<td>
			<div id="ShippingState"><input type="text" name="ShippingState" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("ShippingState")  %>"/></div>
			</td>
			<td valign="top" align="left">Shipping Country :</td>
			<td align="left">
			<div id="ShippingCountry"><input type="text" name="ShippingCountry" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("ShippingCountry")  %>"/></div>
			</td>
		</tr> 	 	 	 	 	 
		
		<tr>
			<td valign="top" align="left">Shipping Phone :</td>
			<td>
			<div id="ShippingPhone"><input type="text" name="ShippingPhone" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("ShippingPhone")  %>"/></div>
			</td>
			<td valign="top" align="left">Shipping Fax :</td>
			<td align="left">
			<div id="ShippingFax"><input type="text" name="ShippingFax" id="search-text"
				 style='height: 12px;' value="<%=rs.getString("ShippingFax")  %>"/></div>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">CST/MST :</td>
			<td valign="top">
			<div id="CSTOrMST"><input type="text" name="CSTOrMST"
				id="search-text"   style='height: 12px;' value="<%=rs.getString("CSTOrMST")  %>" /></div>
			</td>
			<td valign="top" align="left">Terms :</td>
			<td align="left" rowspan="2">
			 <textarea
										name="terms" rows="2" id="search-text"
										style='width: 175px; height: auto;'><%=rs.getString("terms") %></textarea>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left">Mobile No : *</td>
			<td>
			<div id="mobileNo"><input type="text" name="mobileNo"
				id="search-text" value="<%=rs.getString("MobileNo") %>" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left"></td>
		</tr>

		<tr>
			<td valign="top" align="left">STD Code :</td>
			<td>
			<div id="std"><input type="text" name="std"
				id="search-text" value="<%=rs.getString("STDCode") %>" style='height: 12px;' /></div>
			</td>
			<td valign="top" align="left">Phone Number :</td>
			<td align="left">
			<div id="phone"><input type="text" name="phone" id="search-text"
				value="<%=rs.getString("TelephoneNo2") %>" style='height: 12px;' /></div>
			</td>
		</tr>
		
		<tr>
			<td valign="top" align="left">Category :</td>
			<td>
			<div id="category">
			
			<select name="category" style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  <% String sqlDropdown="SELECT TheGroupName,TheGroupCode FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  while(rsDropdown.next()){
				  %>
				  <option value="<%=rsDropdown.getString(2)%>">
				  <%=rsDropdown.getString(1)%></option>
							
						<% 	}%> 
				</select>
				</div>
			</td>
			<td valign="top" align="left">Interested In Product :</td>
			<td align="left">	
			<div id="product"><input type="text" name="product"
				id="search-text" value="<%=rs.getString("IntrestedProduct") %>" style='height: 12px;' /></div>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left">Weekly Off On :</td>
			<td>
			<div id="weelyoff">
			
			<select name="weelyoff" style="width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
			<option >Select</option>	  
			<option >Monday</option>
			<option >Tuesday</option>
			<option >Wednesday</option>
			<option >Thursday</option>
			<option >Friday</option>
			<option >Saturday</option>
			<option >Sunday</option>
			</select>
				</div>
			</td>
			<td valign="top" align="left">Residential Number :</td>
			<td align="left">
			<div id="resiNumber"><input type="text" name="resiNumber"
				id="search-text" value="<%=rs.getString("ResiNo") %>" style='height: 12px;' /></div>
			</td>
		</tr>

		<tr> 	 	 	 	
 		<td>TWEmpName</td>
 		<td><div id="twemp"><input type="text" name="twemp"
				id="search-text" value="<%=rs.getString("TWEmpName") %>" style='height: 12px;' /></div>
		</td>
 		<td>EnteredOn</td>
 		<td><div id="enteredon"><input type="text" name="enteredon" id="search-text" value="<%=rs.getString("EnteredOn") %>" style='height:12px;'/>
 		</div>
 		</td>
 		</tr>

		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr>
		<input type="hidden" name="coreforms" value="<%=rs.getString("CorEForms") %>">
		<input type="hidden" name="login" value="<%=rs.getString("LoginName") %>">
		<input type="hidden" name="password" value="<%=rs.getString("CustPassword") %>">
		<input type="hidden" name="isdatavalid" value="<%=rs.getString("IsDataValid") %>">
		<input type="hidden" name="custdisc" value="<%=rs.getString("CustDiscountPercent") %>" >
		
		<input type="hidden" name="creditlimit" value="<%=rs.getString("CustCreditLimit") %>">
		<input type="hidden" name="paymentterms" value="<%=rs.getString("CustPaymentTerms") %>">
		<input type="hidden" name="paymentmode" value="<%=rs.getString("CustPaymentMode") %>">
		<input type="hidden" name="telephone2" value="<%=rs.getString("TelephoneNo2") %>">
		<input type="hidden" name="vendorcode" value="<%=rs.getString("VendorCode") %>">
		<input type="hidden" name="tallyname" value="<%=rs.getString("TallyName") %>">
		<input type="hidden" name="transactionexisted" value="<%=rs.getString("TransactionExisted") %>">
		</tr>
				
		<tr>

			<td valign="bottom" align="center" colspan="5">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
		</tr>
		<tr>
		<td colspan="3"># : Either of the field is compulsory  </td> 
		</tr>
		<tr>
		<td colspan="3">* : These fields are compulsory  </td> 
		</tr>
	</table>

	</form>

<%
 }
} catch (Exception e) {
				System.out.print("Error In Edit Customer !!!  "+e);
			}
			finally{
				conn.close();
			}
%>

 
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>