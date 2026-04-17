<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
     <style>
        a {
            cursor: pointer;
            margin: 10px;
            text-decoration: none;
            
        }
    </style>
</head>
 <body style="background-color:azure;">
  <%
Connection con = null;
 Statement st1 = null,st2 = null, st3 = null, st4 = null;
 String companyCode;
 String selectedName;
 String FollowUpType = "";String company="";
String customerCode = "",companyName = "",coreForms = "",loginName = "",custPassword = "", isDataValid = "",custDiscount = "",custCreditLimit = "", custPaymentTerms = "",custPaymentMode = "",telephoneNo2 = "",vendorCode = "",tallyName = "",transactionExisted = "";


try {
	con = connection.getConnect("db_GlobalERP"); 
	st1 = con.createStatement();
	st2 = con.createStatement();
	st3 = con.createStatement();
	st4 = con.createStatement();

	
	companyCode = request.getParameter("companyCode");
	System.out.println("companyCodecompanyCodecompanyCode-------------"+companyCode);

} catch (Exception e) {
   e.printStackTrace();
}
%>
<%
try{
	String sql="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode = '"+request.getParameter("companyCode")+"' limit 1";
	System.out.println(sql);
	ResultSet rs=st1.executeQuery(sql);
	if(rs.next())
	{
		String  noofunit="0";
		String pros="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode = '"+request.getParameter("companyCode")+"' limit 1";
		ResultSet rspros=st4.executeQuery(pros);
		customerCode = rs.getString("CustomerCode");
	    companyName = rs.getString("CompanyName");
	    coreForms = rs.getString("CorEForms");
	    loginName = rs.getString("LoginName");
	    custPassword = rs.getString("CustPassword");
	    isDataValid = rs.getString("IsDataValid");
	    custDiscount = rs.getString("CustDiscountPercent");
	    custCreditLimit = rs.getString("CustCreditLimit");
	    custPaymentTerms = rs.getString("CustPaymentTerms");
	    custPaymentMode = rs.getString("CustPaymentMode");
	    telephoneNo2 = rs.getString("TelephoneNo2");
	    vendorCode = rs.getString("VendorCode");
	    tallyName = rs.getString("TallyName");
	    transactionExisted = rs.getString("TransactionExisted");
		if(rspros.next()){
			noofunit=rspros.getString("NoOfUnits");
			
		}else{
			noofunit="0";
		}
		%>
	<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637"><b>Edit Customer:-<%=rs.getString("CompanyName") %></b></h5>
		    		</div>
		             <br>
		             
		             <form name="addCustomer" method="post" action="CustomerUpdate.jsp"  onSubmit="return Validation();">
<div class="card shadow-lg mb-4 rounded-3">
<div class="card-body">
<div class="row col-12 mt-4">
						<div class="col-3 ">
						  <div class="input-container">
<textarea class="form-control floating-input" id="reason" name="reason" rows="1" placeholder="" onblur="return reason5();" required></textarea>
          	<label  for="reason" class="floating-label">Reason For Update</label>        						  
           	<label id="reason1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Reason For Updating</font></label> 
  
						  </div>
						</div>					
								<div class="col-3">
												<div class="input-container">
													<input class="form-control floating-input" type="text" id="ContacPerson" name="ContacPerson" value="<%=rs.getString("ContactPerson") %>"  onblur="return contactpersonfun();" placeholder=""
														required> <label for="contactperson@123"
														class="floating-label">Contact Person</label>
											<div>
														<label id="contact1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Contact Person Name</font></label> 
														<label id="contact2" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label>
													</div>
												</div>
											</div>
											<div class="col-3">
												<div class="input-container">
													<input id="website" name="website"
														class="form-control floating-input" value="<%=rs.getString("WebSite") %>"
														placeholder=""> <label for="website"
														class="floating-label">WebSite</label>
												</div>
											</div>
		 <div class="col-3">        
         <div class="input-container">
          	<textarea class="form-control floating-input" id="email" name="email" rows="1" placeholder="" onblur="return validateEmail();"required><%=rs.getString("EMail") %></textarea>
          	
          	<label for="email" class="floating-label">E-mail</label>
			<div>
<label  id="email1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter EmailID</font></label> 
<label  id="email2" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter valid EmailID</font></label> 
<label   id="email3" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter EmailID</font></label> 
</div> 
        </div>        
    </div>
									
</div>
<div class="row col-12 mt-4"> 
    <div class="col-3">
     <div class="input-container">
       		<input class="form-control floating-input" type="text" id="BankerDetail" name="BankerDetail" value="<%=rs.getString("BankerDetail") %>"  placeholder=""  onblur="return pin();">
          	<label  for="BankerDetail" class="floating-label">Banker Details</label>	
        </div>
    </div>
    <div class="col-3">
     <div class="input-container">
       		<input class="form-control floating-input" type="text" id="resiNumber" name="resiNumber" value="<%=rs.getString("ResiNo") %>"  placeholder=""  onblur="return Residential();">
          	<label  for="resiNumber" class="floating-label">Residential Number</label>
          	</div>
          	</div>
          	
          	
          	 <div class="col-3">
     <div class="input-container">
       		<input class="form-control floating-input" type="text" id="country1" name="country1" value="<%=rs.getString("BillingCountry") %>"  placeholder=""  onblur="return contactpersonfun1();">
          	<label  for="country1" class="floating-label">Billing Country</label>
          	<label id="contact10" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label> 
          	
          	</div>
          	</div>
          	 <div class="col-3">
     <div class="input-container">
       		<input class="form-control floating-input" type="text" id="state" name="state" value="<%=rs.getString("BillingState") %>"  placeholder=""  onblur="return contactpersonfun2();">
          	<label  for="state" class="floating-label">Billing State</label>
          	 				<label id="contact11" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label> 
          	</div>
          	</div>
          	
    </div>
    
    
    <div class="row col-12 mt-4"> 
    <div class="col-3">
     <div class="input-container">
     <input class="form-control floating-input" type="text" id="city" name="city" value="<%=rs.getString("BillingCity") %>"  placeholder=""  onblur="return contactpersonfun3();">
          	<label  for="city" class="floating-label">Billing City</label>
 				<label id="contact12" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label> 
     </div>
     </div>
      <div class="col-3">
     <div class="input-container">
     <input class="form-control floating-input" type="text" id="Billingzip" name="Billingzip" value="<%=rs.getString("BillingZip") %>"  placeholder=""  onblur="return billingzip();">
          	<label  for="Billingzip" class="floating-label">Billing Zip Code</label>
 				 <label id="bzip1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric Value</font></label> 
    
     </div>
     </div>
          <div class="col-3">
     <div class="input-container">
     <input class="form-control floating-input" type="text" id="BillingPhone" name="BillingPhone" value="<%=rs.getString("BillingPhone") %>"  placeholder=""  onblur="return billingphone();">
          	<label  for="BillingPhone" class="floating-label">Billing Zip Code</label>
                <label id="phone4"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric value</font></label>
				<label id="phone5" style="display: none;"><font face="Arial"  size="1" color="red">Number Should Be 10-14 Digits</font></label>
		        <label id="phone6"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Phone Number</font></label>
    
     </div>
     </div>

          <div class="col-3">
     <div class="input-container">
     <input class="form-control floating-input" type="text" id="BillingFax" name="BillingFax" value="<%=rs.getString("BillingFax")%>"  placeholder=""  onblur="return billingfax();">
          	<label  for="BillingFax" class="floating-label">Billing Fax</label>
				 <label id="bfax1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric Value</font></label> 
    
     </div>
     </div>
     </div>
     
     <div class="row col-12 mt-4"> 
    <div class="col-3">
         <div class="input-container">
<textarea class="form-control floating-input"  id="BillingAddress" name="BillingAddress" rows="1" placeholder=""><%=rs.getString("BillingAddress") %></textarea>
          	<label  for="BillingAddress" class="floating-label">Billing Address</label>
 
 				
     </div>
     </div>
              <div class="col-3">
         <div class="input-container">
<textarea class="form-control floating-input"  id="ShippingAddress" name="ShippingAddress" rows="1" placeholder=""><%=rs.getString("ShippingAddress") %></textarea>
          	<label  for="ShippingAddress" class="floating-label">Shipping Address</label>		
     </div>
     </div>
         <div class="col-3">
         <div class="input-container">
              <input class="form-control floating-input" type="text" id="BillingGSTN" name="BillingGSTN" value="<%=rs.getString("BillingGSTN") %>"  placeholder=""  onblur="return billinggstn();">
                   	<label  for="BillingGSTN" class="floating-label">Billing GSTN</label>
          	<label id="BillingGSTN1"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Alphanumeric value</font></label>
          	
 <div>
 
 </div>	
     </div>
     </div>

         <div class="col-3">
 <div class="input-container">
              <input class="form-control floating-input" type="text" id="ShippingGSTN" name="ShippingGSTN" value="<%=rs.getString("ShippingGSTN")%>"  placeholder=""  onblur="return shippinggstn();">
                   	<label  for="ShippingGSTN" class="floating-label">Shipping GSTN</label>
				 <label id="ShippingGSTN1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Alphanumeric Value</font></label> 
     </div>
     </div>
     </div>
         <div class="row col-12 mt-4"> 
    <div class="col-3">
    <div class="input-container">
              <input class="form-control floating-input" type="text" id="country2" name="country2" value="<%=rs.getString("ShippingCountry") %>"  placeholder=""  onblur="return contactpersonfun4();">
                   	<label  for="country2" class="floating-label">Shipping Country</label>
 				<label id="contact13" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label>
     </div>
    </div>
       <div class="col-3">
    <div class="input-container">
              <input class="form-control floating-input" type="text" id="state1" name="state1" value="<%=rs.getString("ShippingState") %>"  placeholder=""  onblur="return contactpersonfun5();">
                   	<label  for="state1" class="floating-label">Shipping State</label>
 				<label id="contact14" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label> 
     </div>
    </div>
       <div class="col-3">
    <div class="input-container">
              <input class="form-control floating-input" type="text" id="city1" name="city1" value="<%=rs.getString("ShippingCity") %>"  placeholder=""  onblur="return contactpersonfun6();">
                   	<label  for="city1" class="floating-label">Shipping City</label>
 				<label id="contact15" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Character Value</font></label> 
     </div>
    </div>
       <div class="col-3">
    <div class="input-container">
              <input class="form-control floating-input" type="text" id="ShippingFax" name="ShippingFax" value="<%=rs.getString("ShippingFax")%>"  placeholder=""  onblur="return shippingfax();">
                   	<label  for="ShippingFax" class="floating-label">Shipping Fax</label>
				 <label id="sfax1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric Value</font></label> 
     </div>
    </div>
    </div>
        <div class="row col-12 mt-4"> 
    <div class="col-3">   
   <div class="input-container">
              <input class="form-control floating-input" type="text" id="CSTOrMST" name="CSTOrMST" value="<%=rs.getString("CSTOrMST")  %>"  placeholder="">
                   	<label  for="ShippingFax" class="floating-label">CST/MST</label>
     </div>
    </div>
       <div class="col-3">   
   <div class="input-container">
              <input class="form-control floating-input" type="text" id="MobileNo" name="MobileNo" value="<%=rs.getString("MobileNo") %>"  placeholder="" onblur="return funmob1();">
                   	<label  for="MobileNo" class="floating-label">Mobile No</label>
                   	<div>
                   	<label id="mob1"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric value</font></label>
				<label id="mob12" style="display: none;"><font face="Arial"  size="1" color="red">Number Should Be 10-15 Digits</font></label>
		        <label id="mob123"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Mobile Number</font></label>
                   	</div>
     </div>
    </div>
                      <div class="col-3">
         <div class="input-container">
<textarea class="form-control floating-input"  id="terms" name="terms" rows="1" placeholder=""><%=rs.getString("terms") %></textarea>
          	<label  for="terms" class="floating-label">Terms</label>	
     </div>
     </div>
        <div class="col-3">   
   <div class="input-container">
              <input class="form-control floating-input" type="text" id="std" name="std" value="<%=rs.getString("STDCode") %>"  placeholder="" onblur="return faxnumber();">
                   	<label  for="std" class="floating-label">STD Code</label>
                   	<label id="fax1" style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric Value</font></label> 
     </div>
    </div>
    </div>
        <div class="row col-12 mt-4"> 
    <div class="col-3 mt-4">
     <div class="input-container">
              <input class="form-control floating-input" type="text" id="phone" name="phone" value="<%=rs.getString("TelephoneNo2") %>"  placeholder="" onblur="return funmob2();">
                   	<label  for="phone" class="floating-label">Phone No</label>
<div>
                <label id="phone1"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Numeric value</font></label>
				<label id="phone2" style="display: none;"><font face="Arial"  size="1" color="red">Number Should Be 10-14 Digits</font></label>
		        <label id="phone3"  style="display: none;"><font face="Arial"  size="1" color="red">Please Enter Phone Number</font></label>
</div>                   	

     </div> 
    </div>
    <%
String TheGroupNameshow="",TheGroupCodeshow="";
String sqltemp="SELECT TheGroupName,TheGroupCode FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode='"+rs.getString("Category")+"' "; 
ResultSet rscat=st3.executeQuery(sqltemp);
if(rscat.next()){
	TheGroupNameshow=rscat.getString("TheGroupName");
	TheGroupCodeshow=rscat.getString("TheGroupCode");
}
%>

<div class="col-3">
        <div class="input-container">
        <label class="tcolor"  >Category</label>
        
        			<select name="category"  id="category" class="form-select" >
        
<option value="<%=TheGroupCodeshow%>"><%=TheGroupNameshow%></option>
				  <% String sqlDropdown="SELECT TheGroupName,TheGroupCode FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  while(rsDropdown.next()){
				  %>
				  <option value="<%=rsDropdown.getString(2)%>">
				  <%=rsDropdown.getString(1)%></option>
							
						<% 	}%> 
				</select>
        
        </div>
        </div>
                               <div class="col-3 mt-4">
         <div class="input-container">
<input class="form-control floating-input"  id="product" name="product" value="<%=rs.getString("IntrestedProduct") %>"  placeholder=""  >
          	<label  for="product" class="floating-label">Interested In Product</label>	
     </div>
     </div>
        
        <div class="col-3">
        <div class="input-container">
        <label class="tcolor"  >Verticals</label>
        
        			<select name="verticals" id="verticals" class="form-select" >
        
<option value="<%=rs.getString("verticals")%>"><%=rs.getString("verticals")%></option> 
<option value="Fleet Solutions">>Fleet Solutions</option>
				  					  					  	 
				</select>
        </div>
        </div>

    </div>
      <div class="row col-12 mt-4"> 
    <div class="col-3">
    <div class="input-container">
        <label class="tcolor"  >Segment</label>
        
        			<select name="segment" id="segment" class="form-select" >
        
				  	<option value="<%=rs.getString("segment")%>"><%=rs.getString("segment")%></option> 
<option value='Goods'>Goods</option>
				  	 <option value='Hazmat'>Hazmat</option>
				  	 <option value='Industrial Supply chain'>Ind.Supply chain</option>
				  	 <option value='People'>People</option>		  					  					  	 
				</select>
        
        </div>  
    </div>
       <div class="col-3">
    <div class="input-container">
        <label class="tcolor"  >Sub Group</label>
        
        			<select name="subgroup" id="subgroup" class="form-select" >
        
				  	 <option value="<%=rs.getString("subgroup")%>"><%=rs.getString("subgroup")%></option> 
				  	 <option value='DragonDroid'>DragonDroid</option>
				  	 <option value='Driver Behavior'>Driver Behavior</option>
				  	 <option value='Portable GPS'>Portable GPS</option>
				  	 <option value='Route Mapping'>Route Mapping</option>
				  	 <option value='Tracking'>Tracking</option>  					  					  	 
				</select>		
        
        </div>  
    </div>
           <div class="col-3">
    <div class="input-container">
        <label class="tcolor"  >Confidence Level</label>     
        			<select name="confidencelevel" id="confidencelevel"  class="form-select" >      
				<option value="<%=rs.getString("confidencelevel")%>"><%=rs.getString("confidencelevel")%></option> 	  					  					  	
				  	 <option value='25%'>25%</option>
				  	 <option value='50%'>50%</option>
				  	 <option value='75%'>75%</option>
				  	 <option value='100%'>100%</option> 					  					  	 
				</select>	        
        </div>  
    </div>
    <%
    String ontmchg=rs.getString("onetimecharge");
if(ontmchg.equals("-"))
{
	ontmchg="0";
}
%>
<%String recchg=rs.getString("recurringcharge");
if(recchg.equals("-"))
{
	recchg="0";
}
String conchg=rs.getString("contractvalue");
if(conchg.equals("-"))
{
	conchg="0";
}
%>
            <div class="col-3 mt-4">   
   <div class="input-container">
              <input class="form-control floating-input" type="text" id="onetimecharge" name="onetimecharge" value="<%=ontmchg %>"  placeholder="">
                   	<label  for="onetimecharge" class="floating-label">One Time Charge</label>
     </div>
    </div>
    </div>
    
      <div class="row col-12 mt-4"> 
    <div class="col-3 mt-4">
    <div class="input-container">
              <input class="form-control floating-input" type="text" id="recurringcharge" name="recurringcharge"  value="<%=recchg %>"  placeholder="" onblur="chk();">
                   	<label  for="onetimecharge" class="floating-label">Recurring Charge</label>
     </div>
    </div>
     <div class="col-3 mt-4">
    <div class="input-container">
              <input class="form-control floating-input" type="text" id="contractvalue" name="contractvalue"  value="<%=conchg %>"  placeholder="" >
                   	<label  for="contractvalue" class="floating-label">Contract Value</label>
     </div>
    </div>
               <div class="col-3">
    <div class="input-container">
        <label class="tcolor"  >Solution</label>     
        			<select  id="solution"name="solution"  class="form-select" >      
				<option value="<%=rs.getString("solution")%>"><%=rs.getString("confidencelevel")%></option> 
				  	 <option value='Camera'>Camera</option>
				  	 <option value='DragonDroid'>DragonDroid</option>
				  	 <option value='JRM'>JRM</option>
				  	 <option value='Mobile eye'>Mobile eye</option>				  					  	 
				</select>	        
        </div>  
    </div>
 
     <div class="col-3">
    <div class="input-container">
        <label class="tcolor"  >Weakly Off</label>     
<select  id="weeklyoff" name="weeklyoff" class="form-select">     
					<option value="Sunday"><%=rs.getString("weeklyoff") %></option>	  
					<option >Monday</option>
					<option >Tuesday</option>
					<option >Wednesday</option>
					<option >Thursday</option>
					<option >Friday</option>
					<option >Saturday</option>
					<option >Sunday</option>				  					  	 
				</select>	        
        </div>  
    </div>
    </div>
      <div class="row col-12 mt-4"> 
    <div class="col-3">
      <div class="input-container">
        <label class="tcolor"  >TWEMP Name</label>     
<select  id="assignTo" name="assignTo" class="form-select" >     
				<%				
							String sql1 = "select MarketingRepName ,MarketingRepCode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
							" WHERE username<>'' and password<>''  and (Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1 ) order by MarketingRepName";
							System.out.println(" In Query :::::::::: :- "+sql1);
							ResultSet rs3 = st1.executeQuery(sql1);
								%>
								<option value="<%=session.getAttribute("EmpName").toString() %>"><%=session.getAttribute("EmpName").toString() %></option>
								<%
								while (rs3.next()) {
						%>
						<option value="<%=rs3.getString(1)%>">
							<%=rs3.getString(1)%></option>
		
						<%
							}
						%>			  					  	 
				</select>	
				<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
				        
        </div>  
    </div>
    </div>    
     <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button  id="saveForm" name="submit" class="btn" type="submit" value="Submit" >Submit</button>
  </div>  
</div>
</div>
<input type="hidden" name="noofunit" id="noofunit" value="<%=noofunit%>">    
<input type="hidden" name="companyname" value="<%=customerCode%>">
<input type="hidden" name="companyname1" value="<%=companyName%>">
<input type="hidden" name="coreforms1" value="<%=coreForms%>">
<input type="hidden" name="login1" value="<%=loginName%>">
<input type="hidden" name="password" value="<%=custPassword%>">
<input type="hidden" name="isdatavalid" value="<%=isDataValid%>">
<input type="hidden" name="custdisc" value="<%=custDiscount%>">
<input type="hidden" name="creditlimit" value="<%=custCreditLimit%>">
<input type="hidden" name="paymentterms" value="<%=custPaymentTerms%>">
<input type="hidden" name="paymentmode" value="<%=custPaymentMode%>">
<input type="hidden" name="telephone2" value="<%=telephoneNo2%>">
<input type="hidden" name="vendorcode" value="<%=vendorCode%>">
<input type="hidden" name="tallyname" value="<%=tallyName%>">
<input type="hidden" name="transactionexisted" value="<%=transactionExisted%>">
		          </form>		             
		             </div>
		         </div>
		       </div>
		    </div>
		</section>
	</div>
</div>
<%} %>	
	
<%}catch(Exception e){
	System.out.print(e);
    e.printStackTrace();

	}%>

 <script>
function Validation()
{

	document.getElementById("reason1").style.display="none";
	 var reason1=document.getElementById("reason").value;
		if(reason1.trim()==""|| reason1==null)
	{
			document.getElementById("reason1").style.display='';
			return false;
	}
		document.getElementById("contact1").style.display="none";
		document.getElementById("contact2").style.display="none";	
	var name=document.getElementById("ContacPerson").value;
	var invalid=/^[a-zA-Z  . / ]+$/;
	var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(name.trim()=="" || oth==""){
		document.getElementById("contact1").style.display="";
			return false;
		}
	if(!invalid.test(name)){
	 document.getElementById("contact2").style.display="";
		     return false;
		 }
	
	document.getElementById("email3").style.display="none";
	document.getElementById("email1").style.display="none";
	document.getElementById("email2").style.display="none";

	var txtEmail=document.getElementById("email").value;

	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;

	if(txtEmail=="")
		{
		document.getElementById("email3").style.display="";
		return false;
		}

	if(!text.test(txtEmail))
		{
		document.getElementById("email2").style.display="";
		return false;
		
		}
	document.getElementById("resi1").style.display="none";
	var mob=document.getElementById("resiNumber").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("resi1").style.display="";
	                return false;
	            }
				
			    }
	document.getElementById("contact10").style.display="none";	
	var name=document.getElementById("country1").value;

	var invalid=/^[a-zA-Z ]+$/;
if(!name.trim()==0)
	{
	
	if(!invalid.test(name)){
	 document.getElementById("contact10").style.display="";
		     return false;
		 }	
	}
	
	
document.getElementById("contact11").style.display="none";	
var name=document.getElementById("state").value;

var invalid=/^[a-zA-Z ]+$/;
if(!name.trim()==0)
{

if(!invalid.test(name)){
 document.getElementById("contact11").style.display="";
	     return false;
	 }	
}


document.getElementById("contact12").style.display="none";	
var name=document.getElementById("city").value;

var invalid=/^[a-zA-Z ]+$/;
if(!name.trim()==0)
{

if(!invalid.test(name)){
 document.getElementById("contact12").style.display="";
	     return false;
	 }	
}
	
	
document.getElementById("contact13").style.display="none";	
var name=document.getElementById("country2").value;

var invalid=/^[a-zA-Z ]+$/;
if(!name.trim()==0)
{

if(!invalid.test(name)){
 document.getElementById("contact13").style.display="";
	     return false;
	 }	
}
document.getElementById("contact14").style.display="none";	
var name=document.getElementById("state1").value;

var invalid=/^[a-zA-Z ]+$/;
if(!name.trim()==0)
{

if(!invalid.test(name)){
 document.getElementById("contact14").style.display="";
	     return false;
	 }	
}


document.getElementById("contact15").style.display="none";	
var name=document.getElementById("city1").value;

var invalid=/^[a-zA-Z ]+$/;
if(!name.trim()==0)
{

if(!invalid.test(name)){
 document.getElementById("contact15").style.display="";
	     return false;
	 }	
}

	
	   document.getElementById("mob1").style.display="none";
	   document.getElementById("mob12").style.display="none";
	   document.getElementById("mob123").style.display="none";
			  var invalid=/^[0-9 ,]+$/; 
   var mob=document.getElementById("MobileNo").value;
   
  
   
   if(!(mob ==0))
		{
			 if(!invalid.test(mob))
				{
					document.getElementById("mob1").style.display="";
					return false;
				}	
		}
		else
		{
			
		}  
   document.getElementById("fax1").style.display="none";
	var mob=document.getElementById("std").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("fax1").style.display="";
	                return false;
	            }
				
			    }
	  document.getElementById("phone3").style.display="none";
	  var invalid=/^[0-9 ,]+$/; 
	 var mob=document.getElementById("phone").value;

	  if(!(mob ==0))
			{
		   if(!invalid.test(mob))
					{
						document.getElementById("phone1").style.display="";
						return false;
					}	
					 
			}
			else
			{
				
			}	  
	  document.getElementById("phone4").style.display="none";
	  document.getElementById("phone6").style.display="none";
	  var invalid=/^[0-9 ,]+$/; 
	 var mob=document.getElementById("BillingPhone").value;

	  if(!(mob ==0))
			{
		   if(!invalid.test(mob))
					{
						document.getElementById("phone4").style.display="";
						return false;
					}	
					 
			}
			else
			{
				mob="";
				document.getElementById("phone6").style.display="";
			    return false;	
			}
	  
	
	  document.getElementById("bfax1").style.display="none";
		var mob=document.getElementById("BillingFax").value;
		var invalid=/^[0-9]+$/;    
		if(!(mob ==0))
				{
			if(!invalid.test(mob)){
		        document.getElementById("bfax1").style.display="";
		                return false;
		            }
					
				    }
	  
	  
}
	function contactpersonfun1()
				{
					
					document.getElementById("contact10").style.display="none";	
				var name=document.getElementById("country1").value;

				var invalid=/^[a-zA-Z ]+$/;
			if(!name.trim()==0)
				{
				
				if(!invalid.test(name)){
				 document.getElementById("contact10").style.display="";
					     return false;
					 }	
				}
				}

		function contactpersonfun2()
		{
			
			document.getElementById("contact11").style.display="none";	
		var name=document.getElementById("state").value;

		var invalid=/^[a-zA-Z ]+$/;
	if(!name.trim()==0)
		{
		
		if(!invalid.test(name)){
		 document.getElementById("contact11").style.display="";
			     return false;
			 }	
		}
		}

		function contactpersonfun3()
		{
			
			document.getElementById("contact12").style.display="none";	
		var name=document.getElementById("city").value;

		var invalid=/^[a-zA-Z ]+$/;
	if(!name.trim()==0)
		{
		
		if(!invalid.test(name)){
		 document.getElementById("contact12").style.display="";
			     return false;
			 }	
		}
		}
		function contactpersonfun4()
		{
			
			document.getElementById("contact13").style.display="none";	
		var name=document.getElementById("country2").value;

		var invalid=/^[a-zA-Z ]+$/;
	if(!name.trim()==0)
		{
		
		if(!invalid.test(name)){
		 document.getElementById("contact13").style.display="";
			     return false;
			 }	
		}
		}
		function contactpersonfun5()
		{
			
			document.getElementById("contact14").style.display="none";	
		var name=document.getElementById("state1").value;

		var invalid=/^[a-zA-Z ]+$/;
	if(!name.trim()==0)
		{
		
		if(!invalid.test(name)){
		 document.getElementById("contact14").style.display="";
			     return false;
			 }	
		}
		}

		function contactpersonfun6()
		{
			
			document.getElementById("contact15").style.display="none";	
		var name=document.getElementById("city1").value;

		var invalid=/^[a-zA-Z ]+$/;
	if(!name.trim()==0)
		{
		
		if(!invalid.test(name)){
		 document.getElementById("contact15").style.display="";
			     return false;
			 }	
		}
		}


function reason5()
{
	
	document.getElementById("reason1").style.display="none";
	 var reason1=document.getElementById("reason").value;
		if(reason1.trim()==""|| reason1==null)
	{
			document.getElementById("reason1").style.display='';
			return false;
	}
}

function contactpersonfun()
{
	document.getElementById("contact1").style.display="none";
	document.getElementById("contact2").style.display="none";	
var name=document.getElementById("ContacPerson").value;
var invalid=/^[a-zA-Z  . / ]+$/;
var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(name.trim()=="" || oth==""){
	document.getElementById("contact1").style.display="";
		return false;
	}
if(!invalid.test(name)){
 document.getElementById("contact2").style.display="";
	     return false;
	 }	
}
function ValidateEmail()
{
	document.getElementById("email3").style.display="none";
	document.getElementById("email1").style.display="none";
	document.getElementById("email2").style.display="none";

	var txtEmail=document.getElementById("email").value;

	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;

	if(txtEmail=="")
		{
		document.getElementById("email3").style.display="";
		return false;
		}

	if(!text.test(txtEmail))
		{
		document.getElementById("email2").style.display="";
		return false;
		}
	}	
function funmob1()
{
		   document.getElementById("mob1").style.display="none";
		   document.getElementById("mob12").style.display="none";
		   document.getElementById("mob123").style.display="none";
				  var invalid=/^[0-9 ,]+$/; 
	   var mob=document.getElementById("MobileNo").value;
	   if(!(mob ==0))
			{
				 if(!invalid.test(mob))
					{
						document.getElementById("mob1").style.display="";
						return false;
					}	
			}
			else
			{
				 
			}   
	   }
	   
	   
function faxnumber()
{
	
	document.getElementById("fax1").style.display="none";
	var mob=document.getElementById("std").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("fax1").style.display="";
	                return false;
	            }
				
			    }
	
}


function funmob2()
{
document.getElementById("phone1").style.display="none";
  document.getElementById("phone3").style.display="none";
  var invalid=/^[0-9 ,]+$/; 
 var mob=document.getElementById("phone").value;

  if(!(mob ==0))
		{
	   if(!invalid.test(mob))
				{
					document.getElementById("phone1").style.display="";
					return false;
				}	
				 
		}
		else
		{
			
		}
}
	
function billingphone()
{
document.getElementById("phone4").style.display="none";
  document.getElementById("phone6").style.display="none";
  var invalid=/^[0-9 ,]+$/; 
 var mob=document.getElementById("BillingPhone").value;

  if(!(mob ==0))
		{
	   if(!invalid.test(mob))
				{
					document.getElementById("phone4").style.display="";
					return false;
				}	
				 
		}
		else
		{
			mob="";
			document.getElementById("phone6").style.display="";
		    return false;	
		}
}


function billingfax()
{
	
	document.getElementById("bfax1").style.display="none";
	var mob=document.getElementById("BillingFax").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("bfax1").style.display="";
	                return false;
	            }				
			    }	
}


function shippinggstn()
{
	
	document.getElementById("ShippingGSTN1").style.display="none";
	var mob=document.getElementById("ShippingGSTN").value;
	var invalid=/^[A-Za-z0-9]+$/;
    if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("ShippingGSTN1").style.display="";
	                return false;
	            }				
			}	
}

function billinggstn()
{
	
	document.getElementById("BillingGSTN1").style.display="none";
	var mob=document.getElementById("BillingGSTN").value;
	var invalid=/^[A-Za-z0-9]+$/;
  	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("BillingGSTN1").style.display="";
	                return false;
	            }
				
			}
	
}

function billingzip()
{
	
	document.getElementById("bzip1").style.display="none";
	var mob=document.getElementById("Billingzip").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("bzip1").style.display="";
	                return false;
	            }
				
			    }
	
}
	
function shippingfax()
{
	
	document.getElementById("sfax1").style.display="none";
	var mob=document.getElementById("ShippingFax").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("sfax1").style.display="";
	                return false;
	            }				
			    }	
}

function Residential()
{
	
	document.getElementById("resi1").style.display="none";
	var mob=document.getElementById("resiNumber").value;
	var invalid=/^[0-9]+$/;    
	if(!(mob ==0))
			{
		if(!invalid.test(mob)){
	        document.getElementById("resi1").style.display="";
	                return false;
	            }
				
			    }
	
}

function showbox()
{

	var country = document.getElementById("country1").value;
if(country!=null)
	{
	document.getElementById("f13").style.display="";
	
	}
else
	{
	document.getElementById("f13").style.display='none';
	
	}
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
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
			//alert(reslt);
			document.getElementById("state").disabled = false;
			document.getElementById("state").innerHTML=reslt;		
		} 
	};
	
	var queryString = "?country="+country;
	ajaxRequest.open("GET", "AjaxGetState.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
	
}
function showbox2()
{

	var country = document.getElementById("country1").value;
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
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
			document.getElementById("city").disabled = false;
			document.getElementById("city").innerHTML=reslt;
			
		} 
	};
	
	var queryString = "?country="+country;
	ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
	
}

function showbox1()
{	var state = document.getElementById("state").value;
if(state!=null)
	{
	document.getElementById("f11").style.display="";
	
	}
else
	{
	document.getElementById("f11").style.display='none';
	
	}
		var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
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
			//alert(reslt);
			document.getElementById("city").disabled = false;
			document.getElementById("city").innerHTML=reslt;
		
		} 
	};
	
	var queryString = "?state="+state;
	ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
	ajaxRequest.send(null); 	
}

function showentryform2()
{
	
	document.getElementById("country1").disabled = true;
	document.getElementById("newcountry").style.display="";
	document.getElementById("f14").style.display="";
	document.getElementById("f15").style.display='none';
	document.getElementById("f13").style.display="";
}
function showminus2(id)
{
document.getElementById("country1").disabled = false;
document.getElementById("f14").style.display='none';
document.getElementById("newcountry").style.display='none';
document.getElementById("f13").style.display='none';
document.getElementById("f15").style.display="";
document.getElementById("newcountry").value="";



}
function showentryform1()
{
	
	document.getElementById("state").disabled = true;
	document.getElementById("newstate").style.display="";
	document.getElementById("f12").style.display="";
	document.getElementById("f13").style.display='none';
	document.getElementById("f11").style.display="";


}
function showminus1(id)
{
document.getElementById("state").disabled = false;
document.getElementById("f12").style.display='none';
document.getElementById("newstate").style.display='none';
document.getElementById("f11").style.display='none';

document.getElementById("f13").style.display="";
document.getElementById("newstate").value="";
}

function showentryform()
{
	
	document.getElementById("city").disabled = true;//select id
	document.getElementById("newcity").style.display="";//input type id
	document.getElementById("f10").style.display="";
	document.getElementById("f11").style.display='none';
}
function showminus(id)
{
document.getElementById("city").disabled = false;
document.getElementById("f10").style.display='none';
document.getElementById("newcity").style.display='none';

document.getElementById("f11").style.display="";
document.getElementById("newcity").value="";
}
function shhiping()
{
	//alert("hi");
	var country2 = document.getElementById("country2").value;
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
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
			document.getElementById("state1").disabled = false;
			document.getElementById("state1").innerHTML=reslt;
		} 
	};
	
	var queryString = "?country2="+country2;
	ajaxRequest.open("GET", "AjaxGetStates.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
function shhiping2()
{
	var country2 = document.getElementById("country2").value;
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
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
			document.getElementById("city1").disabled = false;
			document.getElementById("city1").innerHTML=reslt;
			
		} 
	};
	
	var queryString = "?country2="+country2;
	ajaxRequest.open("GET", "AjaxGetCitys.jsp" + queryString, true);
	ajaxRequest.send(null); 	
}

function shhiping1()
{

	//alert("hi");
	var state1 = document.getElementById("state1").value;
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
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
			document.getElementById("city1").disabled = false;
			document.getElementById("city1").innerHTML=reslt;
		} 
	};
	var queryString = "?state1="+state1;
	ajaxRequest.open("GET", "AjaxGetCitys.jsp" + queryString, true);
	ajaxRequest.send(null);	
}
function chk()
{
	var recchg=document.getElementById("recurringcharge").value;
	var ontmchg=document.getElementById("onetimecharge").value;
	var nounts=document.getElementById("noofunit").value;
	var tot=(nounts*ontmchg)+(36*recchg*nounts);
	document.getElementById("contractvalue").value=tot;	
}
	
</script>
<%@ include file="footer.jsp" %>
</body>
</html>