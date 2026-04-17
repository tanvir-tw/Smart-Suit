<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>

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
Date today = new Date();
String date=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
%>
 
 
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add New Company</h5>
		    		</div>
		             <br>

<!-- <form action="insertCompDet.jsp" method="post" name="data" enctype="multipart/form-data"> -->
	<form action="insertCompDet.jsp?action=Company" method="post"
		name="data">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="compName" id="compName" placeholder="" required>
          <label for="compName" class="floating-label">Company Name</label>
        </div>
      </div>
  <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Company Type</label>
            <select class="form-select" name="comptype" id="comptype" required >            
           <option value="select"> Select</option>
					<option value="bank">Banking</option>
					<option value="consult">Consultant</option>
					<option value="educat">Educational</option>
					<option value="finance">Finance</option>
					<option value="service">Service</option>
					<option value="trans">Transport</option>
           
           </select>
        </div>
      </div>
      <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="phNo" id="phNo" placeholder="" required>
          <label for="phNo" class="floating-label">Phone Number</label>
        </div>
      </div>


  </div>    
</div>
 <div class="row">
      <div class="row col-12 mt-3"> 
         <div class="col-4 mt-4">
        <div class="input-container">
          	 <textarea class="form-control floating-input" name="compAdd" id="compAdd" rows="1" placeholder="" required></textarea>
          	<label  for="compAdd" class="floating-label">Address</label>         	
        </div>
    </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          	 <textarea class="form-control floating-input" name="compGdAdd" id="compGdAdd" rows="1" placeholder="" required></textarea>
          	<label  for="compGdAdd" class="floating-label">Company Godown Address</label>         	
        </div>
    </div>
     
     
               <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="compBstno" id="compBstno" placeholder="" required>
          <label for="compBstno" class="floating-label">Company BST No</label>
        </div>
      </div>
      

      </div>
      </div>
       <div class="row">
      <div class="row col-12 mt-3"> 
            <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="compCstno" id="compCstno" placeholder="" required>
          <label for="compCstno" class="floating-label">Company CST No</label>
        </div>
      </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="faxNo" id="faxNo" placeholder="" required>
          	<label  for="faxNo" class="floating-label">Fax Number</label>         	
        </div>
    </div>
        <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="email" id="email" placeholder="" required>
          	<label  for="email" class="floating-label">Email ID</label>         	
        </div>
    </div>
  
    </div>
    </div>
    
         <div class="row">
      <div class="row col-12 mt-3"> 
            <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="website" id="website"  placeholder="" required>
          	<label  for="website" class="floating-label">Website</label>         	
        </div>
    </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="uadn" id="uadn" placeholder="" required >
          	<label  for="uadn" class="floating-label">User Name</label>         	
        </div>
    </div>
        <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="adn" id="adn" placeholder="" required>
          	<label  for="adn" class="floating-label">Admin Login Name</label>   
          	<font size="1.2" style="color:#990000;">Password Same As Admin Login Name</font>      	
        </div>
    </div>
       
    </div>
    </div> 
      <div class="row">
      <div class="row col-12 mt-3"> 
       <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="adnemail" id="adnemail" placeholder="" required>
          	<label  for="adnemail" class="floating-label">Admin User Email Id</label>         	
        </div>
    </div>
                          <div class="col-5">
<div class="input-container">
<label class="tcolor">Logo Image File</label>
<input type="file" class="form-control"name="uProperty" id="uProperty" required>
</div>
</div>
       
    </div>
    </div>
     <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" type="submit" id="submit" value="Submit" onclick="javascript:try{return validate();}catch(e){alert(e)}">Submit</button>
    </div>  

</div>
</div>
</form>
<%
	String sendMsg=request.getParameter("sendMsg");
%>
<input type="hidden" name="sendMsg" id="sendMsg" value="<%=sendMsg %>"></input>
<%
if(!(sendMsg==null))
{
	System.out.println("======="+sendMsg+"=======");
	%>
	<script LANGUAGE="JavaScript" type="text/javascript">
	
	//alert("company created");
	var sendMsg=document.getElementById("sendMsg").value;
	alert(sendMsg+"\n");
	</script>
	<%
}
%>
</div>
</div>
</div>
</div>
</section>
</div>
</div>
<script LANGUAGE="JavaScript" type="text/javascript">


function is_valid_url(url)
{ 
	 var RegExp = /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/; 
	 if(RegExp.test(url)){
	        return true;
	    }else{
	        return false;
	    } 
    
}

function validate()
{
	
	var compName = document.getElementById("compName").value;
	var compAdd= document.getElementById("compAdd").value;
	var compGdAdd = document.getElementById("compGdAdd").value;
	var phNo = document.getElementById("phNo").value;
	var faxNo = document.getElementById("faxNo").value;
	var email = document.getElementById("email").value;
	var adnemail = document.getElementById("adnemail").value;

	var compBstNO =document.getElementById("compBstno").value;
	var adn=document.getElementById("adn").value;
	var uadn=document.getElementById("uadn").value;
	var compCstNO= document.getElementById("compCstno").value;
	var website= document.getElementById("website").value;
	var letters = /^[A-Z a-z 0-9]+$/;  
	
	
	compAdd=compAdd.replace(/\s/g,"");
	compGdAdd=compGdAdd.replace(/\s/g,"");
	compName=compName.replace(/\s/g,"");
	phNo=phNo.replace(/\s/g,"");
	faxNo=faxNo.replace(/\s/g,"");
	email=email.replace(/\s/g,"");
	adnemail=adnemail.replace(/\s/g,"");
	compBstNO=compBstNO.replace(/\s/g,"");
	compCstNO=compCstNO.replace(/\s/g,"");
	website=website.replace(/\s/g,"");
	
		if(compName.length==0)
	{
		alert("Please Enter The Company Name");
		return false;
	}
	
	if(!isNaN(compName))
	{
	
	alert("Invalid Company Name");
	return false;
	}
	if(uadn.length==0)
	{
		alert("Please Enter User Name");
		return false;
	}
	if(adn.length==0)
	{
		alert("Please Enter Admin User Name");
		return false;
	}

	if(phNo.length==0)
	{
		alert("Please Enter Phone Number");
		return false;
	}
	
	if(isNaN(phNo))
	{
	alert("Enter The Valid Phone Number");
	return false;
	}

	 if (phNo.length<10 || phNo.length>=14)
    {
		alert("Phone Number Should Be 10-13 Digit");
    return false;   
  }	 

	
	if(compAdd.length==0)
	{   
		alert("Please Enter The Company Address");
		return false;
    }
	
	if(compGdAdd.length==0)
	{
		alert("Please Enter The Company Godown Address");
		return false;
	}
	
	
	var regularExpression = /^[a-z A-Z 0-9]+$/;
	 
	if(!(regularExpression.test(compBstNO)))
	{
		alert("BST Number Should Be Alpha-Numeric Only");
	    return false;   
	}
	if(compBstNO.length==0)
	{
		alert("Please Enter The Company BST No.");
		return false;
	}
	if (compBstNO.length <= 9 || compBstNO.length >= 15 )
    {
		alert("BST Number Maximum Limit Is 9-15 Digit ");
    	return false;   
  	}	 
	
	
	if(!(regularExpression.test(compCstNO)))
	{
		alert("CST Number Should Be Alpha-Numeric Only");
		return false;   
	}	
	if(compCstNO.length==0)
	{
		alert("Please Enter The Company CST NO.");
		return false;
	}
	if (compCstNO.length <=9 || compCstNO.length >= 15 )
    {
		alert("CST Number Maximum Limit Is 9-15 Digit ");
		return false;   
  	}	 
	
	if(faxNo.length==0)
	{
		alert("Please Enter The Fax Number");
		return false;
	}
	if(isNaN(faxNo))
	{
		alert("Please Enter The Valid Fax Number");
		return false;
	}

	 if (faxNo.length< 10 || faxNo.length>=14)
	    {
			alert("Fax Number Should Be 10-13 Digit ");
	    return false;   
	  }	 
	
	
	if(email.length==0)
	{
		alert("Please Enter The Email ID");
		return false;
	}
	else
	{
		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		    if (!filter.test(email)) {
		    alert('Please Enter Valid Email ID');
		    email.focus;
		    return false;
	} 
	}
	if(adnemail.length==0)
	{
		alert("Please Enter The Admin Email ID");
		return false;
	}
	else
	{
		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		    if (!filter.test(adnemail)) {
		    alert('Please Enter Valid Admin Email ID');
		    adnemail.focus;
		    return false;
	} 
	}
	if(website.length==0)
	{
		alert("Please Enter The Website Address");
		return false;
	}
	else
	{
		var url=is_valid_url(website);
		if(!url)
			{
			   alert("Please Enter Valid Website Address");
			   return false;
			}
	}
	return true;
}
function replaceAll(txt, replace, with_this) {
return txt.replace(new RegExp(replace, 'g'),with_this);
}
function showSrc() {
document.getElementById("myframe").href = document.getElementById("myfile").value;
var theexa=document.getElementById("myframe").href.replace("file:///","");
var path=document.getElementById("myframe").href.replace("file:///","");
var correctPath=replaceAll(path,"%20"," ");

alert(correctPath);

} 

</script>
 <%@ include file="footer.jsp" %>
</body>
</html>