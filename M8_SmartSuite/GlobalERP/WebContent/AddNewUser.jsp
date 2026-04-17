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
 #userlist {
    display: none;              /* hidden by default */
    position:absolute;
    background: aliceblue;           /* white background */
    border: 1px solid #ccc;     /* border */
    border-radius: 4px;         /* rounded corners */
    max-height: 200px;          /* limit height */
    width: 29%;                /* same width as input */
    overflow-y: auto;           /* vertical scroll if content is large */
    box-shadow: 0 2px 6px rgba(0,0,0,0.15); /* subtle shadow */
    z-index: 9999;              /* keep above other elements */
    padding: 5px;
    font-size: 13px;
}
#userlist div, #userlist li {
    padding: 6px 10px;
    cursor: pointer;
}
#userlist div:hover, #userlist li:hover {
    background-color: #f1f1f1;  /* hover effect */
}
 
 </style>
 
</head>
 <body style="background-color:azure;">

<%
String department="";

//Connection Initialization
Connection con = null;
Statement st1 = null,st2=null,st21=null;

try {
		con = connection.getConnect("db_GlobalERP");       

	    st1=con.createStatement();
	    st2=con.createStatement();
	    st21=con.createStatement();

} catch (Exception e) {
e.printStackTrace();
} 

%>

<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add New User</h5>
		    		</div>
		             <br>

<form name="AddNewUser" method="post" enctype="multipart/form-data" action="InsertNewUserDetails.jsp" onsubmit="return validate();">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="FullName" name="FullName" placeholder="" required>
          <label for="FullName" class="floating-label">Full Name</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="UserName" name="UserName" placeholder="" required>
          <label for="Username" class="floating-label">User Name</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="password" id="Password" name="Password" placeholder="" required>
          <label for="Password" class="floating-label">Password</label>
        </div>
      </div>
  </div>    
</div>

<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">User Level</label>
            <select class="form-select" id="UserLevel" name="UserLevel" required>            
           	<option value="Level1">Level 1</option>
			<option value="Level2">Level 2</option>
			<option value="Level3">Level 3</option>
			<option value="Level4">Level 4</option>
			<option value="Level5">Level 5</option>
           
           </select>
        </div>
      </div>
     
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Department</label>
            <select class="form-select" id="Department" name="Department" required>            
           	<%
 String sql="select distinct(dept) as department  from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept";
            
		System.out.println("*******"+sql);
        ResultSet rsdept = st.executeQuery(sql);
		while(rsdept.next())
		{
			department=rsdept.getString("department");
			 System.out.println("department-->"+department);
			%>
			<option value="<%=department%>"><%=department%></option>
	         <%
      }
		%>
           
           </select>
        </div>
      </div>
      
       <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="EmpCode" name="EmpCode" 
                onblur="return validateEmpCode()" placeholder="" required>
          <label for="EmpCode" class="floating-label">Employee code</label>
        </div>
      </div>

</div>

</div>
<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">TA Level</label>
            <select class="form-select" id="TALevel" name="TALevel" required>            
				<option value="M1">M1</option>
				<option value="M2">M2</option>
				<option value="M3">M3</option>
				<option value="M4">M4</option>
				<option value="M5">M5</option>
           
           </select>
        </div>
      </div>
      
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="Mobno" name="Mobno" placeholder="" required>
          <label for="Mobno" class="floating-label">Mobile Number</label>
        </div>
      </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="email" id="emailid" name="emailid" 
                onblur="return validateEmpCode()" placeholder="" required>
          <label for="emailid" class="floating-label">Email-Id</label>
        </div>
      </div>
</div>
</div>

<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Active Status</label>
            <select class="form-select" id="ActiveStatus" name="ActiveStatus" required>            
				<option value="Yes">Yes</option>
				<option value="No">No</option>
           </select>
        </div>
      </div>
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="hod" name="hod" placeholder="" onkeyup="getUserHod();" required>
          <label for="hod" class="floating-label">HOD</label>
        </div>
            <div id="userlist" style="display:none;"></div>
        
      </div>
      
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Role</label>
            <select class="form-select" id="rolenew" name="rolenew" required>            
				<%
String role123="";
	String rolequery="select distinct(Role) from UserMaster where Role!='-' order by Role";
	ResultSet rsrole=st21.executeQuery(rolequery);
	%>
	<option value="Select">Select</option>
	<% 
while(rsrole.next())
	{
		role123=rsrole.getString("Role");
		System.out.println("Role is:---------------------------------------->:"+role123);

	%>
	<option value="<%=role123 %>" ><%=role123 %></option>
	<% 
	}
	%>
           </select>
        </div>
      </div>
</div>
</div>
<div class="row">
 <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">User Access</label>
            <select class="form-select" id="UAL" name="UAL" required>            
				<%
			String sqlDeatils1="Select * from db_GlobalERP.UserTypeMaster where UserType !='Super Admin' order by UserType" ;
			System.out.println("*********User Access    "+sqlDeatils1);
			ResultSet rsDetails12=strno.executeQuery(sqlDeatils1);
			%>
			<option value="Select">Select</option>
			<%while(rsDetails12.next()){ %>
			<option value="<%=rsDetails12.getInt("UserTypeCode") %>"><%=rsDetails12.getString("UserType") %></option>
			<%} %>
           </select>
        </div>
      </div>
      
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Working Zone</label>
            <select class="form-select" id="Zone" name="Zone" required>            
				<option value="Select">Select</option>
				<option value="East">East</option>
				<option value="West">West</option>
				<option value="South">South</option>
				<option value="North">North</option>
           </select>
        </div>
      </div>
      
         <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="state" name="state" placeholder="" required>
          <label for="state" class="floating-label">State</label>
        </div>
      </div>
 </div>
</div>
<div class="row">
      <div class="row col-12"> 
       <div class="col-4 mt-3">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="city" name="city"  placeholder="" required>
            <label for="city" class="floating-label">City</label>
            </div>
        </div>        
					
		<div class="col-4 mt-3">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="dotid" name="dotid"  placeholder="" required>
            <label for="dotid" class="floating-label">DotProjectId</label>
            </div>
        </div>
        
        <div class="col-4 mt-3">
            <div class="input-container">           
            <input class="form-control floating-input" type="text"  id="kradotid" name="kradotid"  placeholder="" required>
            <label for="kradotid" class="floating-label">KRADotProjectId</label>
            </div>
        </div>


</div>
</div>

<div class="row">
      <div class="row col-12"> 
<div class="col-5 mt-4">
  <div class="input-container">
    <input class="form-control floating-input" type="file" id="sign" name="sign" accept="image/*">
    <label for="sign" class="floating-label">Sign</label>
  </div>
</div>
</div>

 	<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" id="submit" name="Submit" type="submit">Submit</button>
    </div>
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
function validateEmpCode(){
	
	var empcode = document.getElementById("EmpCode").value;	
	var ajaxRequest; 
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
				alert("Your browser broke!");
				return false;
			}
		}
	}
	
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText.trim();
			if(reslt=="true"){
				alert("Contractor with "+empcode+" already exists");
				document.getElementById("EmpCode").value = "";
				
				return false;
			}
			return true;
			
		} 
	};
	var queryString = "?empcode="+empcode;
	ajaxRequest.open("GET", "AjaxValidateEmpCode.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
</script>
<script type="text/javascript">
function getUserHod()
{
	 //alert(" in fun");
	 
	 //alert("1");
	 var username=document.getElementById("hod").value.trim();

	
		 if(username.length=="")
			{
		        document.getElementById("userlist").style.display = "none";
		        document.getElementById("userlist").innerHTML = "";
			}

	 		//alert(username);
	 		var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
			// Opera 8.0+, Firefox, Safari
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

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if (ajaxRequest.readyState === 4 && ajaxRequest.status === 200) {
	            var reslt = ajaxRequest.responseText.trim();
	            //alert(reslt);
	            if (reslt !== "") {
	                document.getElementById("userlist").style.display = "block";
	                document.getElementById("userlist").innerHTML = reslt;
	            } else {
	                document.getElementById("userlist").style.display = "none";
	                document.getElementById("userlist").innerHTML = "";
	            }
	        }
		}
		
		var queryString = "?action=hod&name="+username;
		//alert(queryString);
		
		ajaxRequest.open("GET", "AjaxEditUser.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 
}
function showVisitingCardDetailsHod(username)
{
	 //alert("in fun");
	 document.getElementById("hod").value=username;
	 //Changing(username);
	 document.getElementById("userlist").style.display="none";
	 
}
function validate()
{	
	var letters = /^[A-Za-z ]+$/;  
	var letters=letters.test(document.AddNewUser.FullName.value);
    if(letters==false)
     {     
         alert('Full name must have characters only');  
          
       return false;  
      }  

    var username=document.AddNewUser.UserName.value;
	if(username=="")
	{
	alert("Please Enter the User Name");
     return false;
	}

	var pwd=document.AddNewUser.Password.value;
	if(pwd=="")
	{
      alert("Please Enter the Password");
      return false;
	}   

	 var ulaccess=document.AddNewUser.UserLevel.value;
	if(ulaccess=="")
	{
       alert("Please Enter the Company User Level Access");
       return false;
	}
	 
	  if(document.AddNewUser.Department.value=="Select")
	    {
	    	alert("Please Select Department");
	    	return false;
	    }
	
	var cm=document.AddNewUser.EmpCode.value;
	var re=/^[A-Za-z0-9]+/;
	if(cm==""){
	       alert("Please Enter Employee Code");
		return false;
	}else{
	if(!re.test(cm))
	{
		alert("Enter Proper Value For Employee Code without space");
	return false;
	}
}
	
	var mob=document.AddNewUser.Mobno.value;
	if(mob=="")
	{
	alert("Please Enter the Mobile Number");
	return false;
	}
	if(isNaN(mob))
	{
	alert("Enter the Valid Mobile Number(10 Digit Number)");
	return false;
	}
	
	if(document.AddNewUser.rolenew.value=="Select")
	{
	alert("Please Select User Role");
	return false;
	}
	
	if(document.AddNewUser.UAL.value=="Select" || document.AddNewUser.UAL.value=="select")
	{
	   	alert("Please Select User Access Level");
	   	return false;
	}
	
	if((mob.length<10)||(mob.length>10))
	{
	alert("Your Mobile Number Should be Valid 10 Digit Number");
	document.AddNewUser.Mobno.select();
	return false;
	}

	var emailfilter=/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i;
	var email=emailfilter.test(document.AddNewUser.emailid.value);
	if(email==false)
	{
	alert("Please Enter valid E-Mail ID");
	return false;
	}

    if(document.AddNewUser.hod.value=="")
    {
    	alert("Please Enter Hod Name");
    	return false;
    }

    if(document.AddNewUser.Zone.value=="Select")
    {
    	alert("Please Select Zone");
    	return false;
    }
    if(document.AddNewUser.state.value=="")
    {
    	alert("Please Enter State Name");
    	return false;
    }
    else
    	{
    	var letters = /^[A-Za-z ]+$/;  
    	var letters=letters.test(document.AddNewUser.state.value);
        if(letters==false)
         {     
             alert('State must have characters only');  
              
           return false;  
          }
    	}
    if(document.AddNewUser.city.value=="")
    {
    	alert("Please Enter City ");
    	return false;
    }
    else
    {
    	var letters = /^[A-Za-z ]+$/;  
    	var letters=letters.test(document.AddNewUser.city.value);
        if(letters==false)
         {     
             alert('City must have characters only');  
              
           return false;  
          }
    }
}
</script>
<%@ include file="footer.jsp" %>
</body>
</html>