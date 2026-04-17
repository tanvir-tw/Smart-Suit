<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="headernew.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />	

</head>
 <body style="background-color:azure;">

<%
Connection conn = null;
Statement st1 = null, st3 = null, st4 = null;
Statement st2 = null;
String FollowUpType = "";
Date today = new Date();
String fromDate = "", toDate = "";
fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(today);
%>

<%
try {
	conn = connection.getConnect("db_GlobalERP");        
     st1=conn.createStatement();
     st2 = conn.createStatement();
     st3 = conn.createStatement();
     st4 = conn.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 
%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		            <h5 class="content-header-title text-center mb-0" style="color: #060637">Add New Supplier</h5>
		            
		            <h5 class="content-header-title text-center mb-0" style="color: #060637">Marketing Rep. Name :<%=session.getAttribute("EmpName").toString() %></h5>
		            </div>
		            
<form name="addSupplier" action="addSupplier.jsp" method="post" onsubmit="return validate();">
 <div class="card shadow-lg mb-3 rounded-3">
<div class="card-body">  
<div class="row col-12">
	<div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="supplierName" name="supplierName" placeholder="" required>
          		<label for="companyNames" class="floating-label">Supplier Name</label>
        </div>  
      </div>
      <div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="contactPerson" name="contactPerson" placeholder="" required>
          		<label for="companyNames" class="floating-label">Contact Person</label>
        </div>  
      </div>
      <div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="designation" name="designation" placeholder="" required>
          		<label for="companyNames" class="floating-label">Designation</label>
        </div>  
      </div>
</div>
<div class="row col-12 mt-3">
	 <div class="col-3 mt-4">
        	<div class="input-container">
          		<textarea class="form-control floating-input" id="email" name="email" rows="1" required></textarea>
           		<label for="address" class="floating-label">E-Mail (comma-separate IDs if multiple)</label>
        	</div>
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
          		<textarea class="form-control floating-input" id="address" name="address" rows="1"></textarea>
           		<label for="address" class="floating-label">Address</label>
        	</div>
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="city" name="city" placeholder="">
          		<label for="companyNames" class="floating-label">City</label>
        </div>  
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="zip" name="zip" placeholder="">
          		<label for="companyNames" class="floating-label">ZipCode</label>
        </div>  
      </div>
</div>
<div class="row col-12 mt-3">
	
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="state" name="state" placeholder="">
          		<label for="companyNames" class="floating-label">State</label>
        </div>  
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="country" name="country" placeholder="">
          		<label for="companyNames" class="floating-label">Country</label>
        </div>  
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="country" name="country" placeholder="" required>
          		<label for="companyNames" class="floating-label">Mobile No.</label>
        </div>  
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="country" name="country" placeholder="">
          		<label for="companyNames" class="floating-label">Fax No.</label>
        </div>  
      </div>
     
</div>
<div class="row col-12 mt-3">
	<div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="areaCode" name="areaCode" placeholder="">
          		<label for="companyNames" class="floating-label">Area Code</label>
        </div>  
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="number" id="ph" name="ph" placeholder="">
          		<label for="companyNames" class="floating-label">Phone Number</label>
        </div>  
      </div>
       <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Supplier Category</label>
                 <select class="form-select" id="supCategory" name ="supCategory" required>
                    <option value='0'>Select</option>
					<option value='1'>Manufacturer</option>
					<option value='2'>Authorized Dealer</option>
					<option value='3'>After Market Trader</option>
					<option value='4'>Others</option>
                 </select>
            </div>
        </div>
       <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Supplier Rating</label>
                 <select class="form-select" id="supRating" name ="supRating" required>
                   <option value='0'>Select</option>
					<option value='1'>1</option>
					<option value='2'>2</option>
					<option value='3'>3</option>
					<option value='4'>4</option>
					<option value='5'>5</option>
                 </select>
            </div>
        </div>
</div>

<div class="row col-12 mt-3">
 <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="supProduct" name="supProduct" placeholder="">
          		<label for="companyNames" class="floating-label">Supplier product</label>
        </div>  
      </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="GSTIN" name="GSTIN" placeholder="" required>
          		<label for="companyNames" class="floating-label">GSTIN No </label>
        </div>  
      </div>
       <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Weekly Off</label>
                 <select class="form-select" id="weeklyoff" name ="weeklyoff" required>
                  	<option value='Select'>Select</option>
					<option value='monday'>Monday</option>
					<option value='tuesday'>Tuesday</option>
					<option value='wednesday'>Wednesday</option>
					<option value='thurday'>Thursday</option>
					<option value='friday'>Friday</option>
					<option value='saterday'>Saturday</option>
					<option value='sunday'>Sunday</option>
                 </select>
            </div>
        </div>
      <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="alternateNumber" name="alternateNumber" placeholder="">
          		<label for="alternateNumber" class="floating-label">Alternate No</label>
        </div>  
      </div>
</div>
<div class="row col-12 mt-3">
<div class="col-4 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="website" name="website" placeholder="">
          		<label for="alternateNumber" class="floating-label">WebSite</label>
        </div>  
      </div>
<div class="col-md-4 mt-4">
    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="supAuthorisation" id="supAuthorisation" value="1" >
        <label class="form-check-label" for="browser">
            Sup PO Authorization Reqd
        </label>
    </div>
    </div>
</div>
    <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button  id="submit" name="submit" class="btn" type="submit">Submit</button>
  	</div>
  	
  	</div>
  	</div>
</form>
</div>
</div>
</div>
</div>
</section>
</div>
</div>
<script>
function validate()
{
var sName=document.addSupplier.supplierName.value;//alert(sName);
var contactPerson=document.addSupplier.contactPerson.value;//alert(contactPerson);
var website=document.addSupplier.website.value;//alert(website);
var email=document.addSupplier.email.value;//alert(email);
var address=document.addSupplier.address.value;//alert(address);
var city=document.addSupplier.city.value;//alert(city);
var zip=document.addSupplier.zip.value;//alert(zip);
var state=document.addSupplier.state.value;//alert(state);
var country=document.addSupplier.country.value;//alert(country);
var mobi=document.addSupplier.mobile.value;//alert(mobi);
var phone=document.addSupplier.ph.value;//alert(phone);
var supCate=document.addSupplier.supCategory.value;	//alert(supCate);
var supRat=document.addSupplier.supRating.value;//alert(supRat);
var supProdt=document.addSupplier.supProduct.value;//alert(supProdt);
//var EnteredOn=document.addSupplier.fromdate.value;//alert(EnteredOn);
var GSTIN=document.addSupplier.GSTIN.value;//
//alert("GSTIN :- "+GSTIN);
var fax1=document.addSupplier.fax.value;///(fax1);
var weeklyOff=document.addSupplier.weeklyoff.value;//alert(weeklyOff);
var alterNumber=document.addSupplier.alternateNumber.value;//alert(alterNumber);
var aCode=document.addSupplier.areaCode.value;//alert(aCode);
var desig=document.addSupplier.designation.value;//alert(desig);
	var numericExpression = /^[0-9]+$/;

	if(sName=="")
	{
	alert("Please enter Supplier Name");
	return false;
		}
			
	if(sName.match(numericExpression))
	{
	alert("Supplier Name cannot be Numeric ");
	return false;
	}

	if(contactPerson=="")
	{
		alert(" Please Enter Contact Person");
		return false;
	}
	
	if(contactPerson.match(numericExpression))
	{
	alert("Contact Persons name cannot be Numeric");
	return false;
	}

	if( email=="")
	{
	alert("Please enter Email Address");
	return false;
	}
		
	 var emails = email.split(',');

	 for (var i = 0; i < emails.length; i++) {
	     var emailToTest = emails[i].trim();
	     var emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

	     if (!emailRegex.test(emailToTest)) {
	         alert("Please Enter Valid E-mail ID");
	         return false;
	     }
	 }
	 
	var invalid=/^[0-9]+$/; 
	   	   
	   if(!(mobi ==0))
			{
				 if(!invalid.test(mobi))
					{
						//document.getElementById("mob1").style.display="";
						alert("Please Enter Numeric value");
						return false;
					}	
				 if((mobi.trim().length < 10)  || (mobi.trim().length >15))
						 {
						 //document.getElementById("mob12").style.display="";
						 alert("Number Should Be 10-15 Digits");
			        return false;
			    }
			}
			else
			{
				mobi="";
				//document.getElementById("mob123").style.display="";
				alert("Please Enter Mobile Number");
			    return false;	
			}
	
   if(GSTIN=="")
	{
	
	alert("Please Enter GSTIN No");
	return false;
	}

	if(!(mobi.match(numericExpression)) && mobi!=""){
	alert("Mobile Number Should Be Numeric Value");
	return false;
	}
	
var agree=confirm(" SupplierName: "+sName+"\n Contact Person : "+contactPerson+"\n Email: "+email+"\n Mobile: "+mobi+"\n\nAre you sure you want to continue with these values?");
	if (agree)
	return true ;
	else
	return false ;

}
</script>
<%@ include file="footer.jsp" %>
</body>
</html> 