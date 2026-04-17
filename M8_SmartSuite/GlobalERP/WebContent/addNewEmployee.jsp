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
Connection conn= null;
Statement st1=null, st2=null, st3=null;
try {
	conn = connection.getConnect("db_leaveapplication");       
    st1=conn.createStatement();
    st2=conn.createStatement();
    st3=conn.createStatement();
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
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add Contractor</h5>
		    		</div>
		            
<form name="leave" method="post"  action="addNewEmployeeInsert.jsp?action=addemp" onsubmit="return validate();">
<%
String updated="",already="";
updated=request.getParameter("inserted");
already=request.getParameter("already");
System.out.println("updated-->"+updated+" already"+already);
if(already==null){
	
}else if(already.equalsIgnoreCase("yes")){
	%>
	 				<div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: red;">Contractor ID is already exist</h5>
		    		</div>
		    		 <br>
						<%	
}
if(updated==null){
	
}
else if(updated.equalsIgnoreCase("yes")){
	%>
					<div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: green;">Contractor Added Successfully</h5>
		    		</div>
						<%
}
%>

<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
     <div class="row col-12 mt-3"> 
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="empid" name="empid" placeholder="" required>
          <label for="FullName" class="floating-label">Contractor ID</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="cName" name="cName" placeholder="" required>
          <label for="Username" class="floating-label">Contractor Name</label>
        </div>
      </div>
      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="username" name="username" placeholder="" required>
          <label for="Username" class="floating-label">User Name</label>
        </div>
      </div>
 </div>    
</div>

<div class="row">
 <div class="row col-12 mt-3">      
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="email" name="email" placeholder="" required>
          <label for="Username" class="floating-label">Email Id</label>
        </div>
      </div>
     
     <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="password" id="pass" name="pass" placeholder="" required>
          <label for="Username" class="floating-label">Password</label>
        </div>
      </div>						
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="password" id="confirm" name="confirm" placeholder="" required>
          <label for="Username" class="floating-label">Confirm Password</label>
        </div>
      </div>			
	</div>
</div>							
<div class="row">
 <div class="row col-12 mt-3">      
	<div class="col-4 mt-2">
                <div class="input-container">
			    <label class="form-label d-block">Type Of User</label>
			
			    <div class="form-check form-check-inline">
			        <input class="form-check-input" type="radio" id="reason1" name="typeOfUser" value="contractor">
			        <label class="form-check-label" for="in">Contractor</label>
			    </div>
			
			    <div class="form-check form-check-inline">
			        <input class="form-check-input" type="radio" id="reason2" name="typeOfUser" value="hod" checked>
			        <label class="form-check-label" for="out">HOD</label>
			    </div>
			</div>
        </div>		
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Weekly Off</label>
            <select class="form-select" id="weekoff" name="weekoff" required>            
           		<option value="0">Sunday</option>
				<option value="1">Monday</option>
				<option value="2">Tuesday</option>
				<option value="3">Wednesday</option>
				<option value="4">Thursday</option>
				<option value="5">Friday</option>
				<option value="6">Saturday</option>
           
           </select>
        </div>
      </div>
     <div class="col-4">
       <div class="input-container">    
        <label class="tcolor">Type Of Department</label>
            <select class="form-select" id="deptName" name="deptName" required>            
           		<option value="-1">Select</option>
												<% 
						try
						{
							String sqlCat="select DeptCode,DeptName from t_department where status='Active'";
						    ResultSet rsCat=st1.executeQuery(sqlCat);
						    while(rsCat.next())
						    { %>
							<option value="<%=rsCat.getString("DeptCode") %>"><%=rsCat.getString("DeptName") %></option>
						<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }%>
           </select>
        </div>
      </div>
     </div>
   </div>
<div class="row">
 <div class="row col-12 mt-3">      
	<div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="hod" name="hod"onkeyup="getUserHod()" placeholder="" required>
          <label for="Username" class="floating-label">HOD</label>
          <input type="hidden" name="hodid" id="hodid"/>
        </div>
        <div>
		<table border="0" align="center" style="font-family: arial;font-size:12; border-left: 120px">
		<tr><td></td></tr>
		  <tr><td>
		  <div id='userlist' style="overflow: auto; background:#fffff;">
			</div>
		  </td></tr>
		</table>
		</div>
		<script type="text/javascript">document.getElementById("userlist").style.visibility="hidden";
		document.getElementById("userlist").style.height="0";
		</script>
      </div>
    </div>
 </div>   
<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" id="submit" name="Submit" type="submit">Submit</button>
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
<script type="text/javascript">
function validate(){
	  var id=document.leave.empid.value;
	 var name=document.leave.cName.value;
	 var username=document.leave.username.value;
	 var email=document.leave.email.value;
     var pass=document.leave.pass.value;
     var confirm=document.leave.confirm.value;
     var department=document.leave.deptName.value;
     var hod=document.leave.hod.value;
	var reason1=document.leave.reason1.checked;
	var reason2=document.leave.reason2.checked;
     if(isNaN(id))
	 	{
	 	alert("Invalid Contractor Id");
	 	return false;
	 	}
     if(id==""){
    	 alert("Please Enter Contractor Id");
 			return false;
         }
     if(name=="")
 	{
 		alert("Please Enter the Contractor Name");
 		return false;
 	}
     
     if(username==""){
    	 alert("Please Enter User Name");
 		return false;
         }else
     	{
     		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
     		    if (!filter.test(username)) {
     		    alert('Please provide a valid User Name');
     		    email.focus;
     		    return false;
     		    }
     	} 
     if(email==""){
    	 alert("Please Enter Email ID");
 		return false;
         }else
     	{
     		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
     		    if (!filter.test(email)) {
     		    alert('Please provide a valid email ID');
     		    email.focus;
     		    return false;
     	} 
     	}
     
     if(pass==""){
    	 alert("Please Enter Password");
 		return false;
         }

     if(confirm==""){
    	 alert("Please Confirm Password");
 		return false;
         }

		if(pass==confirm){
		}else{
			alert("confirm password does not match");
	 		return false;
			}  

		  if(reason1==true){
			    }else if(reason2==true){
			       }else{
						alert("Please select Type Of User");
						return false;
			                }
					   
		if( department == "-1" )
	    {
	      alert( "Please Select Department" );
	      return false;
	    }
     
		if(hod=="")
		{
			alert("Please Enter HOD");
			return false;
		}
	return true;
}
</script>
<script type="text/javascript">
function showVisitingCardDetailsHod(username,hodid)
{
	 document.getElementById("hod").value=username;
	 document.getElementById("hodid").value=hodid;
	 document.getElementById("userlist").style.visibility='hidden';
	 document.getElementById("userlist").style.height="0";
}
function getUserHod()
{
	 var uname=document.getElementById("hod").value;
		 if(uname.length=="")
			{
			 document.getElementById("userlist").style.visibility="hidden";
			 document.getElementById("hod").value="";
			 document.getElementById("userlist").style.height="0";
			}
		 else
		 {
			 document.getElementById("userlist").style.visibility='visible';
			 document.getElementById("userlist").style.height="100px";
	 		var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
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
				var reslt=ajaxRequest.responseText;
				document.getElementById("userlist").innerHTML=reslt;
			} 
		}
		
		var queryString = "?action=hod&name="+uname;
		ajaxRequest.open("GET", "AjaxGetHOD.jsp" + queryString, true);
		ajaxRequest.send(null); 
		 }//end of else
	 
}
function getHodDetails(transporter)
{
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("reportingto").value=transporter;
}

function getHod(num)
{
	try{
	var b=0;
	var hodName=document.getElementById("reportingto").value;
    if(hodName.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			document.leave.counter.value=b;
			document.leave.counter.value=b*document.leave.counter.value;
			counter=document.leave.counter.value;
		} 
	};
	var queryString = "?hodName="+hodName+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "AjaxGetHodName.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    }
	}catch(e)
	{
	}
}
</script>	
	
	
<%@ include file="footer.jsp"%>
</body>
</html>