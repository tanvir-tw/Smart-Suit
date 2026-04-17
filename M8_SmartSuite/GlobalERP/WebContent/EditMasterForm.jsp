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
<%!
 String cmpname="",id="" ;
 String name="",prnsemail="",tempadd1="",tempadd2="",Tempcity="",tempzip="",tempcon="",tempstate="",permadd1="",permadd2="",permcity="",permzip="",permcon="";
 String permstate="",phn="",dob="",married="",unmarried="",immname="",immphn="",rel="";
 String pan="", aadhar="",driving="",passport="";
 String bnkname="",accno="",ifsc="",accname="",branch="";
 String medicmp="",policyno="",policyStart="",policyEnd="";
 String edu="",strm="";
 String  EntryBy="";
 String  EntryDate="";
 String Marrital="";
 Integer defualtval=1;
    String CustCategory="";
    String Company="";
    String TempAddr="";
    String PermAddr="";
    %>
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
<%

    

		String Check="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+Id+"'";
            ResultSet rsCheck=st4.executeQuery(Check);
            if(rsCheck.next())
            {

            	cmpname=rsCheck.getString("CompanyName");
            	id=rsCheck.getString("ContractorId"); 
            	name=rsCheck.getString("ContractorName");
            	prnsemail=rsCheck.getString("Email");
            	TempAddr=rsCheck.getString("TemporaryAddress");
            	PermAddr=rsCheck.getString("PermanentAddress");
  
            	phn=rsCheck.getString("MobNo");
            	dob=rsCheck.getString("DateOfBirt");
            	Marrital=rsCheck.getString("MaritalStatus");
            	immname=rsCheck.getString("ImmediateContactName");
            	immphn=rsCheck.getString("ImmediateContactNumber");
            	rel=rsCheck.getString("ImmediateContactRelation");

            	pan=rsCheck.getString("PanCard");
            	aadhar=rsCheck.getString("AadharCard");
            	driving=rsCheck.getString("DrivingLicense");
            	passport=rsCheck.getString("Passport");

            	bnkname=rsCheck.getString("BankName");
            	accno=rsCheck.getString("BankAccountNumber");
            	ifsc=rsCheck.getString("BankIFSCCode");
            	accname=rsCheck.getString("BankAccountHolder");
            	branch=rsCheck.getString("BankBranchName");

            	medicmp=rsCheck.getString("MediclaimCompanyName");
            	policyno=rsCheck.getString("MediclaimPolicyNo");
            	policyStart=rsCheck.getString("MediclaimStartDate");
            	policyEnd=rsCheck.getString("MediclaimEndDate");

            	edu=rsCheck.getString("Education");
            	strm=rsCheck.getString("Stream");     	
            }
            String []arr=TempAddr.split(",");
            System.out.println("arr length"+arr.length);
            
            System.out.println("TempAddr "+TempAddr); 
            for(int i=1;i<arr.length;i++)
            {
                System.out.println("arr val"+arr[i]); 

            }  
            tempadd1=arr[0];
            tempadd2=arr[1];
            Tempcity=arr[2];
            tempzip=arr[3];
            tempcon=arr[4];
            tempstate=arr[5];
            
            String []arr1=PermAddr.split(",");
            System.out.println("arr length"+arr.length);

            for(int i=1;i<arr.length;i++)
            {
                System.out.println("arr val"+arr[i]); 

            } 
            permadd1=arr1[0];
            permadd2=arr1[1];
            permcity=arr1[2];
            permzip=arr1[3];
            permcon=arr1[4];
            permstate=arr1[5];
            
            String dt1 = "";
            String dt2 = "";
            
            if(policyStart.equalsIgnoreCase("-"))
            		{
            	 dt1 = "-";
            		}
            else
            {
            	 dt1 = new SimpleDateFormat("dd-MMM-yyyy")
    	        .format(new SimpleDateFormat("yyyy-MM-dd")
    	                .parse(policyStart));	
            }
            
            if(policyEnd.equalsIgnoreCase("-"))
    		{
    	 		dt2 = "-";
    		}
            else{
             dt2 = new SimpleDateFormat("dd-MMM-yyyy")
	        .format(new SimpleDateFormat("yyyy-MM-dd")
	                .parse(policyEnd));
            }        
            System.out.println("Marrital "+Marrital);
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

<form id="form_27236" method="post" action="UpdateMasterForm.jsp" onsubmit="return chk()">

 <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <h6 class="heading-small text-muted" style="font-weight: bold;">Basic Details:</h6>	
      <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="comp_name" name="comp_name" 
                 onblur="return checkCompname()" value="<%=cmpname%>" placeholder="" required>
          <label for="comp_name" class="floating-label">Company Name</label>
        </div>
      </div>

      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="cont_name" name="cont_name" 
                 onblur="return checkName()" value="<%=name%>" placeholder="" required>
          <label for="UserName" class="floating-label">Name</label>
        </div>
      </div>

      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="cont_id" name="cont_id" 
                 value="<%=id%>" onblur="checkId()" placeholder="" required>
          <label for="cont_id" class="floating-label">ID</label>
        </div>
      </div>

      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="email" id="personal_email" name="personal_email" 
                 onblur="return checkEmail()" onkeyup="javascript: getSuggest();" 
                 value="<%=prnsemail%>" placeholder="" required>
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
                <input class="form-control floating-input" type="text" id="Temporary_addr1" name="Temporary_addr1"  value="<%=tempadd1%>" placeholder="" required>
                <label for="Temporary_addr1" class="floating-label">Street Address</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_addr2" name="Temporary_addr2" value="<%=tempadd2%>" placeholder="" required>
                <label for="Temporary_addr2" class="floating-label">Address Line 2</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_city" name="Temporary_city" value="<%=Tempcity%>" placeholder="" required>
                <label for="Temporary_city" class="floating-label">City</label>
            </div>
        </div>     
    </div>

	<div class="row col-12 mt-3">
        <div class="col-4 mt-4">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="Temporary_zip" name="Temporary_zip" value="<%=tempzip%>" placeholder="" required>
                <label for="Temporary_zip" class="floating-label">Postal / Zip Cod</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">Country</label>
                 	<select class="form-select" id="Temporarycountry" name ="Temporarycountry" required>
               		<option selected="selected" value="<%=tempcon%>"><%=tempcon%></option>
                   <%
                   System.out.println("tempcon"+tempcon);
                   %>
                 </select>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">State</label>
                 	<select class="form-select" name ="Temporarystate" id ="Temporarystate" required>
                   	<option selected="selected" value="<%=tempstate%>"><%=tempstate%></option>
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
                <input class="form-control floating-input" type="text" id="permanant_addr1" name="permanant_addr1"  value="<%=tempadd1%>" placeholder="" required>
                <label for="permanant_addr1" class="floating-label">Street Address</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_addr2" name="permanant_addr2" value="<%=tempadd2%>" placeholder="" required>
                <label for="permanant_addr2" class="floating-label">Address Line 2</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_city" name="permanant_city" value="<%=Tempcity%>" placeholder="" required>
                <label for="permanant_city" class="floating-label">City</label>
            </div>
        </div>     
    </div>
	
	<div class="row col-12 mt-3">
        <div class="col-4 mt-3">
            <div class="input-container">
                <input class="form-control floating-input" type="text" id="permanant_zip" name="permanant_zip" value="<%=tempzip%>" placeholder="" required>
                <label for="permanant_zip" class="floating-label">Postal / Zip Cod</label>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">Country</label>
                 <select class="form-select" id="permanantcountry" name ="permanantcountry" required>
                    <option selected="selected" value="<%=tempcon%>"><%=tempcon%></option>
                   
                 </select>
            </div>
        </div>
        <div class="col-4">
            <div class="input-container">
                <label class="tcolor">State</label>
                 <select class="form-select" name ="permanantstate" id ="permanantstate" required>
                   <option selected="selected" value="<%=tempstate%>"><%=tempstate%></option>
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
            <input class="form-control floating-input" type="text"  id="phn_no" name="phn_no" onblur="return checkphno()" value="<%=phn%>" placeholder="" required>
            <label for="phn_no" class="floating-label">Mobile Number</label>
            </div>
        </div>
         <div class="col-4 mt-3">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="dob" name="dob"  value="<%=dob%>" placeholder="" required>
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
                <input class="form-check-input" type="radio" id="married" name="Marital" value="Married" 
                       <%= "Married".equalsIgnoreCase(Marrital) ? "checked" : "" %>>
                <label class="form-check-label" for="married">Married</label>
            </div>

            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" id="unmarried" name="Marital" value="UnMarried" 
                       <%= "UnMarried".equalsIgnoreCase(Marrital) ? "checked" : "" %>>
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
      
         <input class="form-control floating-input" type="text" id="name" name= "name" value="<%=immname%>" onblur="checkName1()" placeholder="" required>
        <label for="name" class="floating-label">Name</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="relation" name="relation" value="<%=rel%>" onblur="checkRelation()" placeholder="" required>
            <label for="relation" class="floating-label">Relation</label>
            </div>
        </div>
        <div class="col-4 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="imm_phnno" name="imm_phnno" onblur="checkno()" value="<%=immphn%>" placeholder="" required>
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
         <input class="form-control floating-input" type="text" id="pancard" name="pancard"  value="<%=pan%>" placeholder="" required>
        <label for="pancard" class="floating-label">PanCard</label>
            </div>
        </div>
        <div class="col-3 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="aadhar_no" name="aadhar_no" value="<%=aadhar%>" placeholder="" required>
            <label for="aadhar_no" class="floating-label">Aadhar Number</label>
            </div>
        </div>
        <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="driving_no" name="driving_no" value="<%=driving%>" placeholder="">
                <label for="driving_no" class="floating-label">Driving License</label>
            </div>
        </div>
         <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="passport_no" name="passport_no" value="<%=passport%>" placeholder="">
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
         	<input class="form-control floating-input" type="text"  id="bank_name" name="bank_name" value="<%=bnkname%>" onblur="checkbank()" placeholder="" required>
            <label for="bank_name" class="floating-label">Bank Name</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="acc_no" name="acc_no" value="<%=accno%>" onblur="checkacc()" placeholder="" required>
            <label for="acc_no" class="floating-label">Account Number</label>
            </div>
            
        </div>
        <div class="col-4 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="acc_holdername" name="acc_holdername" value="<%=accname%>" onblur="checkholder()" placeholder="" required>
                <label for="acc_holdername" class="floating-label">Account Holder Name</label>
            </div>
        </div>
    </div>
    
    
	<div class="row col-12 mt-3">
         <div class="col-4 mt-3">
         <div class="input-container">
         <input class="form-control floating-input" type="text"  id="ifsc" name="ifsc"  value="<%=ifsc%>" onblur="checkIfsc()" placeholder="" required>
            <label for="ifsc" class="floating-label">IFSC Number</label>
            </div>
        </div>
        <div class="col-4 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="branch" name="branch"  value="<%=branch%>" onblur="checkBranch()" placeholder="" required>
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
         <input class="form-control floating-input" type="text" id="medi_comp" name="medi_comp" value="<%=medicmp%>" onblur="checkMediName()"  placeholder="" required>
        <label for="medi_comp" class="floating-label">Company Name</label>
            </div>
        </div>
        <div class="col-3 mt-3">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="policy_no" name="policy_no" value="<%=policyno%>"  placeholder="" onblur="checkPolicyNo()"required>
            <label for="policy_no" class="floating-label">Policy Number</label>
            </div>
        </div>
        <div class="col-3 mt-3">
             <div class="input-container">
                <input class="form-control floating-input" type="text" id="policy_start" name="policy_start" value="<%=dt1%>" placeholder="" required>
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
                <input class="form-control floating-input" type="text" id="policy_end" name="policy_end" value="<%=dt2%>" placeholder="" required>
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
	            <option value="<%=edu%>"><%=edu%></option>
				<option value="10th" >10th</option>
				<option value="12th" >12th</option>
				<option value="Diploma" >Diploma</option>
				<option value="Post Graduation" >Post Graduation</option>
				<option value="Below Secondary" >Below Secondary</option>

            </select>
        </div>
        <div class="col-4 mt-4">
            <div class="input-container">
            <input class="form-control floating-input" type="text" id="stream" name= "stream"  value="<%=strm%>" placeholder="">
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
function chk()
{
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
		
		var cm=document.getElementById("cont_name").value;
		var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
		if(cm==""){
			alert("Enter the Name");
			return false;
		}else{
		if(!re.test(cm))
		{
		alert("Enter characters only");
		return false;
		}}

		var id=document.getElementById("cont_id").value;
		var re=/^[A-Za-z0-9]+/;
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
		 
		var txtEmail=document.getElementById("personal_email").value;
		var re=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/; 
	         
		    if(txtEmail==""){
			alert("Enter The Email Id");
			return false;
		    }else{
			if(!re.test(txtEmail))
			 {
			alert("Enter Valid  Email Id");
			return false;
			}}
		
			var phn=document.getElementById("phn_no").value;
			 var rs=/^[+]{0,1}[0-9]{10,15}$/;
	    	 if(phn==""){
	    		 alert("Enter The Mobile No");
	    		 return false;
	    	 }else{
	         if(!rs.test(phn)){
	        	 
	        	 alert("Please Enter Mobile Number Properly");
	        	 return false;
	         }}		
	       
	    	 var cm=document.getElementById("name").value;
	    		var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
	    		if(cm==""){
	    			alert("Enter the Contact Person Name");
	    			return false;
	    		}else{
	    		if(!re.test(cm))
	    		{
	    		alert("Enter characters only");
	    		return false;
	    		}
	    	}
	 
	 	    	 var iphn=document.getElementById("imm_phnno").value;
	 	    	var rs=/^[+]{0,1}[0-9]{10,15}$/;
	 	         if(iphn=="")
	 	       	 {
	 	        	alert("Enter the Immediate Phone No");
	 	        	return false;
	 	       	 }else{
	 	    	 if(!rs.test(iphn)){
	 	        	 
	 	        	 alert("Please Enter 10 Digit Phone number");
	 	        	 return false;
	 	         }
	 	       	 }
	 	         
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
	 	
	 		var cm=document.getElementById("acc_no").value;
	 		
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
	
	 		var cm=document.getElementById("branch").value;
	 		var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
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

 function checkId(){
	   
		var id=document.getElementById("cont_id").value;
		var re=/^[A-Za-z0-9]+/;
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

function checkacc()
{
	var cm=document.getElementById("acc_no").value;
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

function checkIfsc()
{
	var cm=document.getElementById("ifsc").value;
	//var re=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
	
	var re=/^[A-Za-z]{4}\d{4,7}$/;
	
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

function CopyAdd() {
	//  alert("hii");
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
<%@ include file="footer.jsp" %>
</body>
</html>