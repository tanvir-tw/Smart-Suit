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
 
</head>
 <body style="background-color:azure;">

<%
// Connection Initialization
Connection con = null;
Statement st1 = null,st2=null,st4=null;

try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();
	    st2=con.createStatement();
	    st4=con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 

try{
String EmpNm=session.getAttribute("EmpName").toString().trim();
String addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String Id=request.getParameter("Id");
String ContractorName=request.getParameter("Name");

%>


<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Contract Master Entry Form</h5>
		    		</div>
		             <br>

<form id="form_27236" method="post" action="addMasterEntryForm.jsp" onsubmit="return chk()">

 <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <h6 class="heading-small text-muted" style="font-weight: bold;">Basic Details:</h6>	
      <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="comp_name" name="comp_name" 
                 onblur="return checkCompname()"  placeholder="" required>
          <label for="comp_name" class="floating-label">Company Name</label>
        </div>
      </div>

      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="cont_name" name="cont_name" 
                 onblur="return checkName()"  placeholder="" required>
          <label for="UserName" class="floating-label">Name</label>
        </div>
      </div>

      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="cont_id" name="cont_id" 
                  onblur="checkId()" placeholder="" required>
          <label for="cont_id" class="floating-label">ID</label>
        </div>
      </div>

      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="email" id="personal_email" name="personal_email" 
                 onblur="return checkEmail()" onkeyup="javascript: getSuggest();" 
                  placeholder="" required>
          <label for="personal_email" class="floating-label">Personal E-mail</label>
        </div>
      </div>
</div>
    </div>
  </div>
</div>
    
 <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row " >
     <h6 class="heading-small text-muted" style="font-weight: bold;">Temporary Address:</h6>
	
	  <div class="row col-12 mt-3">
    
        <div class="col-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_addr1" name="Temporary_addr1"   placeholder="" required>
                <label for="Temporary_addr1" class="floating-label">Street Address</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_addr2" name="Temporary_addr2"  placeholder="" >
                <label for="Temporary_addr2" class="floating-label">Address Line 2</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_city" name="Temporary_city"  placeholder="" required>
                <label for="Temporary_city" class="floating-label">City</label>
            </div>
        </div>     
    </div>

	<div class="row col-12 mt-3">
        <div class="col-4 mt-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_zip" name="Temporary_zip"  placeholder="" required >
                <label for="Temporary_zip" class="floating-label">Postal / Zip Cod</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">Country</label>
                 <select class="form-select" id="Temporarycountry" name ="Temporarycountry" required>
                   <script language="javascript">
	        		populateCountries("Temporarycountry", "Temporarystate");
	        </script>
                 </select>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">State</label>
                 <select class="form-select" name ="Temporarystate" id ="Temporarystate" required>
                 </select>
            </div>
        </div>     
    </div>	
</div>
</div>
</div>

<div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
  <div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" id="add1" name="add1" onchange="CopyAdd()">
  <span class="form-check-label">Click here if same as above</span>
</div>
    <div class="row m-2">   
	    
     <h6 class="heading-small text-muted" style="font-weight: bold;">Permanent Address:</h6>	  
	  <div class="row col-12">
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_addr1" name="permanant_addr1"  value="" placeholder="" >
                <label for="permanant_addr1" class="floating-label">Street Address</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_addr2" name="permanant_addr2" value="" placeholder="" >
                <label for="permanant_addr2" class="floating-label">Address Line 2</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_city" name="permanant_city" value="" placeholder="" >
                <label for="permanant_city" class="floating-label">City</label>
            </div>
        </div>     
    </div>
	
	<div class="row col-12 mt-3">
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_zip" name="permanant_zip" value="" placeholder="" >
                <label for="permanant_zip" class="floating-label">Postal / Zip Cod</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">Country</label>
                 <select class="form-select" id="permanantcountry" name ="permanantcountry" >
                     
                 </select>
                  <script language="javascript">
	        populateCountries("permanantcountry", "permanantstate");
	        </script>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">State</label>
                 <select class="form-select" name ="permanantstate" id ="permanantstate" >
                </select>
            </div>
        </div>     
    </div>	
    
	</div>
</div>
</div>

 <div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
    <h6 class="heading-small text-muted" style="font-weight: bold;">Contact Info:</h6>
	   <div class="row col-12 ">
         
        <div class="col-4 mt-3">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="phn_no" name="phn_no" onblur="return checkphno()" value="" placeholder="" required>
            <label for="phn_no" class="floating-label">Mobile Number</label>
            </div>
        </div>
         <div class="col-4 mt-3">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="dob" name="dob"  value="" placeholder="" required>
            <label for="dob" class="floating-label">DOB</label>
            </div>
        </div>
				<script>
						Calendar.setup( {
							inputField : "dob", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "dob" // ID of the button
						});
					</script>	

    <div class="col-4">
        <div class="input-container">
            <label class="form-label d-block"><b>Marital Status</b></label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" id="married" name="Marital" value="Married" >
                      
                <label class="form-check-label" for="married">Married</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" id="unmarried" name="Marital" value="UnMarried" 
                      >
                <label class="form-check-label" for="unmarried">UnMarried</label>
            </div>
        </div>
            </div>
        </div>
 </div>
 </div>
 </div>
  <div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
    <div class="row">    

     <h6 class="heading-small text-muted" style="font-weight: bold;">Immediate Contact:</h6>
        <div class="row col-12">
         
        <div class="col-4 mt-3">
            <div class="input-container">           
      
         <input class="form-control floating-input" type="text" id="name" name= "name" value="" onblur="checkName1()" placeholder="" required>
        <label for="name" class="floating-label">Name</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="relation" name="relation" value="" onblur="checkRelation()" placeholder="" required>
            <label for="relation" class="floating-label">Relation</label>
            </div>
        </div>
        <div class="col-4 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="imm_phnno" name="imm_phnno" onblur="checkno()" value="" placeholder="" required>
                <label for="imm_phnno" class="floating-label">Mobile Number</label>
            </div>
        </div>
    </div>
</div>
</div>
</div>
 <div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
    <div class="row">      
    
     <h6 class="heading-small text-muted" style="font-weight: bold;">Identity:</h6>	

	 <div class="row col-12">
         <div class="col-3 mt-3">
         <div class="input-container"> 
         <input class="form-control floating-input" type="text" id="pancard" name="pancard"  value="" placeholder="" required>
        <label for="pancard" class="floating-label">PanCard</label>
            </div>
        </div>
        <div class="col-3 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="aadhar_no" name="aadhar_no" value="" placeholder="" required>
            <label for="aadhar_no" class="floating-label">Aadhar Number</label>
            </div>
        </div>
        <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="driving_no" name="driving_no" value="" placeholder="" >
                <label for="driving_no" class="floating-label">Driving License</label>
            </div>
        </div>
         <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="passport_no" name="passport_no" value="" placeholder="" >
                <label for="passport_no" class="floating-label">Passport Number</label>
            </div>
        </div>
    </div>
    </div>
   </div>
  </div>
   <div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
    
     <h6 class="heading-small text-muted" style="font-weight: bold;">Banking :</h6>
	
	<div class="row col-12">
         <div class="col-4 mt-3">
           <div class="input-container">
         <input class="form-control floating-input" type="text"  id="bank_name" name="bank_name" value="" onblur="checkbank()" placeholder="" required>
            <label for="bank_name" class="floating-label">Bank Name</label>
            </div>
            </div>
      
      <div class="col-4 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="acc_no" name="acc_no" value="" onblur="checkacc()" placeholder="" required>
            <label for="acc_no" class="floating-label">Account Number</label>
            </div>
            
        </div>
        
        <div class="col-4 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="acc_holdername" name="acc_holdername" value="" onblur="checkholder()" placeholder="" required>
                <label for="acc_holdername" class="floating-label">Account Holder Name</label>
            </div>
        </div>
    </div>
    
    
	<div class="row col-12 mt-3">
         <div class="col-4 mt-3">
         <div class="input-container">
         <input class="form-control floating-input" type="text"  id="ifsc" name="ifsc"  value="" onblur="checkIfsc()" placeholder="" required>
            <label for="ifsc" class="floating-label">IFSC Number</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="branch" name="branch"  value="" onblur="checkBranch()" placeholder="" required>
            <label for="branch" class="floating-label">Branch Name</label>
            </div>
        </div>
  </div>
  </div>
  </div>
  </div>
   <div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
    <div class="row">     
    </div>
     <h6 class="heading-small text-muted" style="font-weight: bold;">MediClaim:</h6> 
     
	 <div class="row col-12">
         <div class="col-3 mt-3">
         <div class="input-container">
         	<input class="form-control floating-input" type="text" id="medi_comp" name="medi_comp" value="" onblur="checkMediName()"  placeholder="" required >
        	<label for="medi_comp" class="floating-label">Company Name</label>
          </div>
       </div>
        <div class="col-3 mt-3">
            <div class="input-container">
	            <input class="form-control floating-input" type="text" id="policy_no" name="policy_no" value="" onblur="checkPolicyNo()" placeholder="" required>
	            <label for="policy_no" class="floating-label">Policy Number</label>
            </div>
        </div>
        <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="policy_start" name="policy_start" value="" placeholder="" required>
                <label for="policy_start" class="floating-label">Policy Start</label>
                <script>
						Calendar.setup( {
							inputField : "policy_start", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "policy_start" // ID of the button
						});
					</script>
            </div>
        </div>
         <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="policy_end" name="policy_end" value="" placeholder="" required>
                <label for="policy_end" class="floating-label">Policy End</label>
                <script>
						Calendar.setup( {
							inputField : "policy_end", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "policy_end" // ID of the button
						});
					</script>
            </div>
        </div>
    </div>
    </div>
   </div>

   <div class="card shadow-lg  mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
     <h6 class="heading-small text-muted" style="font-weight: bold;">Education:</h6>

	 <div class="row col-12">
         <div class="col-4">
        <label class="tcolor">Education</label>
            <select class="form-select" id="education" name="education" required>
	            <option value="Graduation">Graduation</option> 
				<option value="10th" >10th</option>
				<option value="12th" >12th</option>
				<option value="Diploma" >Diploma</option>
				<option value="Post Graduation" >Post Graduation</option>
				<option value="Below Secondary" >Below Secondary</option>

            </select>
        </div>
        <div class="col-4 mt-4">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="stream" name= "stream"  value="" placeholder="" >
            <label for="stream" class="floating-label">Stream</label>
            </div>
        </div>      
        </div>
        </div>
        </div>
        </div>
      <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" type="submit">Submit</button>
    </div>
    </form>
    </div>
          
            </div>
                <!-- End of card body -->
            </div>
        </div>
        
        
        </section>

</div>
</div>	

		<%
	       		
}catch(Exception e){
	e.printStackTrace();
}
%>	
<script type="text/javascript">
function chk() {
    var company = document.getElementById("comp_name").value.trim();
    var companyRe = /^[A-Za-z0-9][A-Za-z0-9\s\-.&,]*$/;
    if (company === "") {
        alert("Enter the Company Name");
        return false;
    }
    if (!companyRe.test(company)) {
        alert("Enter Company Name Properly");
        return false;
    }

    // Contractor Name
    var contName = document.getElementById("cont_name").value.trim();
    var nameRe = /^[A-Za-z\s]+$/;
    if (contName === "") {
        alert("Enter the Contractor Name");
        return false;
    }
    if (!nameRe.test(contName)) {
        alert("Enter characters only for Contractor Name");
        return false;
    }

    // Contractor ID (only digits)
    var contId = document.getElementById("cont_id").value.trim();
    var idRe = /^[0-9]+$/;
    if (contId === "") {
        alert("Enter Contractor Id");
        return false;
    }
    if (!idRe.test(contId)) {
        alert("Enter Proper Value For Contractor Id");
        return false;
    }

    // Email
    var email = document.getElementById("personal_email").value.trim();
    var emailRe = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;
    if (email === "") {
        alert("Enter the Email Id");
        return false;
    }
    if (!emailRe.test(email)) {
        alert("Enter Valid Email Id");
        return false;
    }

    // Phone Number (10–15 digits, optional +)
    var phone = document.getElementById("phn_no").value.trim();
    var phoneRe = /^[+]{0,1}[0-9]{10,15}$/;
    if (phone === "") {
        alert("Enter the Mobile Number");
        return false;
    }
    if (!phoneRe.test(phone)) {
        alert("Please Enter Mobile Number Properly");
        return false;
    }
	

    const marital = document.querySelector('input[name="Marital"]:checked');
    if (!marital) {
    	    alert("Please select your Marital Status.");
    	    return false; // stop form submission
    	  }
    
    
    // Aadhaar (exactly 12 digits)
    var aadhaar = document.getElementById("aadhar_no").value.trim();
    var aadhaarRe = /^\d{12}$/;
    if (aadhaar === "") {
        alert("Enter the Aadhaar Number");
        return false;
    }
    if (!aadhaarRe.test(aadhaar)) {
        alert("Enter Aadhaar Number Properly (12 digits only)");
        return false;
    }

    // Bank Name
    var bank = document.getElementById("bank_name").value.trim();
    if (bank === "" || !nameRe.test(bank)) {
        alert("Enter Valid Bank Name");
        return false;
    }

    // Account Number
    var accNo = document.getElementById("acc_no").value.trim();
    var accRe = /^[0-9]+$/;
    if (accNo === "") {
        alert("Enter the Account Number");
        return false;
    }
    if (!accRe.test(accNo)) {
        alert("Please Enter Valid Account Number");
        return false;
    }

    // Account Holder Name
    var holder = document.getElementById("acc_holdername").value.trim();
    if (holder === "" || !nameRe.test(holder)) {
        alert("Enter Valid Account Holder Name");
        return false;
    }

    // IFSC Code (4 letters + 7 digits)
    var ifsc = document.getElementById("ifsc").value.trim();
    var ifscRe = /^[A-Za-z]{4}[0-9]{7}$/;
    if (ifsc === "") {
        alert("Enter the IFSC Code");
        return false;
    }
    if (!ifscRe.test(ifsc)) {
        alert("Please Enter Valid IFSC Code");
        return false;
    }

    // Branch Name
    var branch = document.getElementById("branch").value.trim();
    if (branch === "" || !nameRe.test(branch)) {
        alert("Enter Valid Branch Name");
        return false;
    }

    // Policy Number
    var policy = document.getElementById("policy_no").value.trim();
    var policyRe = /^[a-zA-Z0-9]+$/;
    if (policy === "" || !policyRe.test(policy)) {
        alert("Enter Valid Policy Number");
        return false;
    }

    // Date Validation (simplified)
    var from = new Date(document.getElementById("policy_start").value);
    var to = new Date(document.getElementById("policy_end").value);
    if (from > to) {
        alert("Policy Start Date should be less than Policy End Date");
        return false;
    }

    return true;
}
</script>
  
 <script>
    // Country → States mapping
    const countryStateMap = {
      "India": ["Maharashtra", "Delhi", "Karnataka", "Gujarat"],
      "USA": ["California", "Texas", "New York", "Florida"],
      "Canada": ["Ontario", "Quebec", "British Columbia"],
      "Australia": ["New South Wales", "Victoria", "Queensland"]
    };

    // Reusable function for any country/state pair
    function populateCountries(countryId, stateId) {
      const countrySelect = document.getElementById(countryId);
      const stateSelect = document.getElementById(stateId);

      // Clear and populate countries
      countrySelect.innerHTML = "";
      for (let country in countryStateMap) {
        let option = document.createElement("option");
        option.value = country;
        option.text = country;
        countrySelect.appendChild(option);
      }

      // When a country changes → update states
      countrySelect.addEventListener("change", function () {
        stateSelect.innerHTML = "";
        const states = countryStateMap[this.value] || [];
        states.forEach(state => {
          let option = document.createElement("option");
          option.value = state;
          option.text = state;
          stateSelect.appendChild(option);
        });
      });
      countrySelect.dispatchEvent(new Event("change"));
    }
    populateCountries("Temporarycountry", "Temporarystate");
    populateCountries("permanantcountry", "permanantstate");
  </script>

<script>
function checkIfsc()

{
	
	var cm=document.getElementById("ifsc").value;
	var re=/^[A-Za-z0-9]+/;
	
	if(cm==""){
		alert("Enter the IFSC Code");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid IFSC Code");
	return false;
	}
}
}
</script>
<script type="text/javascript">
 function checkCompname(){
	
	var company=document.getElementById("comp_name").value;

	
	var re=/^[A-Za-z0-9]+[\s\-]*[\s\- .,&A-Za-z0-9]*[A-Za-z.]+$/;
	if(company==""){
		
		alert("Enter the Company Name");
		return false;
	}
	else{
	if(!re.test(company))
	{
	alert("Enter Company Name Properly");
	return false;
	}
	}
}
</script>
<script type="text/javascript">
   
    function checkName(){
	   
		var cm=document.getElementById("cont_name").value;
		var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
		if(cm==""){
			alert("Enter the Contractor Name");
			return false;
		}else{
		if(!re.test(cm))
		{
		alert("Enter characters only");
		return false;
		}
   }
   }
</script>
<script type="text/javascript">
   
    function checkId(){
	   
		var id=document.getElementById("cont_id").value;
		var re=/^[A-Za-z0-9]+/;
		//var re=/^[0-9]*$/;
		if(id==""){
			alert("Enter Value For Contractor Id");
			return false;
		}else{
		if(!re.test(id))
		{
		alert("Enter Proper Value For Contractor Id");
		return false;
		}
   }
   }
</script>
<script type="text/javascript">
 function checkEmail(){  
	 
	 var txtEmail=document.getElementById("personal_email").value;
	 var re=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;
	if(txtEmail==""){
		alert("Enter Email Id");
		return false;
	}else{
	if(!re.test(txtEmail))
	{
	alert("Enter Valid  Email Id");
	return false;
	}
	
	} 
}
</script> 
<script type="text/javascript">   
     function checkphno(){
    	 var phn=document.getElementById("phn_no").value;
    	 var rs=/^[+]{0,1}[0-9]{10,15}$/;
         if(phn=="")
       	 {
        	alert("Enter the Phone no");
        	return false;
       	 }else{
    	 if(!rs.test(phn)){
        
        	 alert("Please Enter 10 Digit Phone number");
        	 return false;
         }
     }
     }
</script>
<script type="text/javascript">
     
     function checkno(){
    	 var iphn=document.getElementById("imm_phnno").value;
    	 var rs=/^[+]{0,1}[0-9]{10,15}$/;
    	 //var rs=/^\d{3}\d{3}\d{4}$/;
         if(iphn=="")
       	 {
        	alert("Enter the Mobile number");
        	return false;
       	 }else{
    	 if(!rs.test(iphn)){
        	 
        	 alert("Please Enter Mobile number properly ");
        	 return false;
         }
     }
     }
</script>
<script>
function checkName1()
{
	
	var cm=document.getElementById("name").value;
	var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
	if(cm==""){
		alert("Enter the Immediate Contact Person Name");
		return false;
	}else{ 
	if(!re.test(cm))
	{
	alert("Enter characters only");
	return false;
	}
}
}
</script>
<script>

function checkRelation()
{
	
	var cm=document.getElementById("relation").value;
	var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
	if(cm==""){
		alert("Enter the Relation");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Enter characters only");
	return false;
	}
}
}
</script>
<script>
function checkbank()
{
	var cm=document.getElementById("bank_name").value;
	var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
	if(cm==""){
		alert("Enter the Bank Name");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid Bank Name");
	return false;
	}
}
}
</script>

<script>
function checkacc()
{
	var cm=document.getElementById("acc_no").value;
	/* var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/; */
	
	var re=/^[0-9]*$/;
	if(cm==""){
		alert("Enter the Account Number");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid Account Number");
	return false;
	}
}
}
</script>
<script>
function checkholder()
{
	var cm=document.getElementById("acc_holdername").value;
	var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
	if(cm==""){
		alert("Enter the Account Holder Name");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid Account Holder Name");
	return false;
	}
}
}
</script>
<script>
function checkIfsc()
{
	var cm=document.getElementById("ifsc").value;
	var re=/^[A-Za-z0-9]+/;
	
	if(cm==""){
		alert("Enter the IFSC Code");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid IFSC Code");
	return false;
	}
}
}
</script>
<script>
function checkBranch()
{
	
	var cm=document.getElementById("branch").value;
	var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z.]+$/;
	if(cm==""){
		alert("Enter the Branch Name");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid Branch Name");
	return false;
	}
}
}	
</script>
<script>
function checkMediName()
{
	
	var cm=document.getElementById("medi_comp").value;
	var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z.]+$/;
	if(cm==""){
		alert("Enter the Insurance Company Name");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid Company Name");
	return false;
	}
}
}
</script>
<script>
function checkPolicyNo()
{
	var cm=document.getElementById("policy_no").value;
	
	
	var re=/^[a-zA-Z0-9]+$/;
	
	if(cm==""){
		alert("Enter the Policy Number");
		return false;
	}else{
	if(!re.test(cm))
	{
	alert("Please Enter Valid Policy Number");
	return false;
	}
}

}
</script>
<script type="text/javascript">
function CopyAdd() {
	  
	  var cb1 = document.getElementById('add1');
	  var a1 = document.getElementById('Temporary_addr1');
	  var al1 = document.getElementById('permanant_addr1');
	  var a2 = document.getElementById('Temporary_addr2');
	  var al2 = document.getElementById('permanant_addr2');
	  var a3 = document.getElementById('Temporary_city');
	  var al3 = document.getElementById('permanant_city');
	  var v1 = document.getElementById('Temporary_zip');
	  var vl1 = document.getElementById('permanant_zip');
	  var t1 = document.getElementById('Temporarycountry');
	  var tl1 = document.getElementById('permanantcountry');
	  var c1 = document.getElementById('Temporarystate'); 
	  var pradd = document.getElementById('permanant_state');		
	  if (cb1.checked) {
	    al1.value = a1.value;
	    al2.value = a2.value;
	    al3.value = a3.value;
	    vl1.value = v1.value;
	  } else {
	    al1.value = '';
	    al2.value = '';
	    al3.value = '';
	    vl1.value = '';
	    tl1.value = '';
	    pradd.value = '';	  
	  }
	}
</script>
<%@ include file="footer.jsp" %>
</body>
</html>