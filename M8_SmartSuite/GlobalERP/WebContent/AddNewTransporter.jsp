<%@page import="java.util.Date"%>
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

  try
  {
	  	String VehicleRegNumber = request.getParameter("VehicleRegNumber");
		String OwnerName = request.getParameter("OwnerName");
		OwnerName =OwnerName.replace("^","&");
		String vehiclecode = request.getParameter("vehiclecode");
	%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Add New Transporter Entry Form</h5>
		    		</div>
		             <br>

<form name="AddNewUser" method="post" action="insertnewtransporter.jsp" onsubmit="return validate();">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="vehregno" name="vehregno" value="<%=VehicleRegNumber %>" placeholder="" readonly required>
          <label for="vehregno" class="floating-label">Vehicle Registration Number</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="transporter" name="transporter" value="<%=OwnerName %>" readonly placeholder="" required>
          <label for="transporter" class="floating-label">Transporter</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="erpcode" name="erpcode"  placeholder="" required>
          <label for="erpcode" class="floating-label">ERP Code</label>
        </div>
      </div>
  </div>    
</div>
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="erpcustnm" name="erpcustnm" placeholder="" required>
          <label for="erpcustnm" class="floating-label">ERP Cust Name</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="grpcd" name="grpcd" placeholder="" required>
          <label for="grpcd" class="floating-label">Group Code</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="group" name="group" placeholder="" required>
          <label for="group" class="floating-label">Group Name</label>
        </div>
      </div>
  </div>    
</div>
<div class="row">
      <div class="row col-12 mt-3"> 
      <div class="col-4">
        <div class="input-container">    
        <label class="tcolor">Bill Transporter</label>
            <select class="form-select" id="billtransporter" name="billtransporter" required>            
         		<option value="Yes">Yes</option>
				<option value="No">No</option>
           </select>
        </div>
      </div>

      <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="slaper" name="slaper" placeholder="" required>
          <label for="slaper" class="floating-label">Service Level Agreement Percentage</label>
        </div>
      </div>

      <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="rate" name="rate" placeholder="" required>
          <label for="rate" class="floating-label">Rate</label>
        </div>
      </div>
  </div>    
</div>

<div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-3">
        <div class="input-container">    
        <label class="tcolor">Bill Type</label>
            <select class="form-select" id="billtype" name="billtype" required>            
         		<option value="Combined">Combined</option>
				<option value="Single">Single</option>
           </select>
        </div>
      </div>

     <div class="col-3">
        <div class="input-container">
        <label class="tcolor">Contact Person</label>
        <select class="form-select" id="cp" name="cp" onchange="insertrows();" required>
            <option value="Use ERP">Use ERP</option>
            <option value="Other">Other</option>
        </select>
    </div>
</div>
   <div class="col-3 mt-3" id="otherDiv" style="display:none;">
        <div class="input-container">
        <input class="form-control floating-input" type="text" id="cpname" name="cpname" placeholder="">
        <label for="cpname" class="floating-label">Contact Person's Name</label>
    </div>
</div>

      <div class="col-3 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="stax" name="stax" placeholder="" required>
          <label for="stax" class="floating-label">Service Tax</label>
        </div>
      </div>
  </div>    
</div>
<div class="row">
      <div class="row col-12"> 
<div class="col-5 mt-4">
  <div class="input-container">
    <input class="form-control floating-input" type="text" id="scharge" name="scharge" placeholder="" required>
    <label for="scharge" class="floating-label">Service Charge</label>
  </div>
</div>
</div>

   <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button  id="submit" name="submit" class="btn" type="submit">Submit</button>
  	</div>
<input type="hidden" name="vehiclecode" value="<%=vehiclecode %>">
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

<%
}
catch(Exception e)
{
   System.out.println(e);
}
%>


<script type="text/javascript">
function insertrows()
{
    var cpch = document.getElementById("cp").value;
    var otherDiv = document.getElementById("otherDiv");

    if (cpch === "Other")
    {
        otherDiv.style.display = "block";
    }
    else
    {
        otherDiv.style.display = "none";
        document.getElementById("cpname").value = "";
    }
}

function validate()
{
  var erpcode = document.getElementById("erpcode").value;
  var erpcustnm = document.getElementById("erpcustnm").value;
  var grpcd = document.getElementById("grpcd").value;
  var group = document.getElementById("group").value;
  var slaper = document.getElementById("slaper").value;
  var rate = document.getElementById("rate").value;
  var stax = document.getElementById("stax").value;
  var scharge = document.getElementById("scharge").value;
  if(document.getElementById("cpname")!= null)
  {	  
   var cpname = document.getElementById("cpname").value;
   if(erpcode=="" || erpcustnm=="" || grpcd=="" || group=="" || slaper=="" || rate=="" || stax=="" || scharge=="")
   {
      alert("Fields Indicated With * Should Not Be Left Blank");
      return false;
    }
  }
    if(erpcode=="" || erpcustnm=="" || grpcd=="" || group=="" || slaper=="" || rate=="" || stax=="" || scharge=="" )
     {
        alert("Fields Indicated With * Should Not Be Left Blank");
        return false;
      }
  
	 if(isNaN(erpcode))
	 {
		 alert("ERP Code Has To Be a Number");
		 return false;
	 }
	 
	 
	 if(!erpcustnm.match(/^[.&/a-zA-Z ]+$/) )
	 {
		 alert("Please Enter Only Characters In ERP Customer Name Field");
		 return false;
	 }
	 if(isNaN(grpcd))
	 {
		 alert("Group Code Has To Be a Number");
		 return false;
	 }
	 
	 if(!group.match(/^[.&/a-zA-Z ]+$/) )
	 {
		 alert("Please Enter Only Characters In Group Name Field");
		 return false;
	 }
	 
	 if(isNaN(slaper))
	 {
		 alert("Service Level Agreement Percentage Has To Be a Number");
		 return false;
	 }

	 if(slaper>100)
	 {
		 alert("Service Level Agreement Percentage cannot be greater than 100");
		 return false;
	 }
	 
	 if(isNaN(rate))
	 {
		 alert("Rate Has To Be a Number");
		 return false;
	 }	

	 if(document.getElementById("cpname")!= null)
	 {
		 var cpname = document.getElementById("cpname").value;
		 if(!cpname.match(/^[a-zA-Z]+$/) )
		 {
			 alert("Please Enter Only Characters In Contact Person Name Field");
			 return false;
		 } 
	 }
	 
	 if(isNaN(stax))
	 {
		 alert("Service Tax Has To Be a Number");
		 return false;
	 }	
	 
	 if(isNaN(scharge))
	 {
		 alert("Service Charge Has To Be a Number");
		 return false;
	 }

	 else
		 return confirm("Are you sure you want to submit the form?");
	 
}
</script>

</body>
</html>