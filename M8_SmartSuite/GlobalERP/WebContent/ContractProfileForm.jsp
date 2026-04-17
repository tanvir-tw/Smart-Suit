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

System.out.println("EntryDate :- "+addedOn);

String Today=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

System.out.println("ToDays Date :- "+Today);


%>

<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 700px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Contract Profile Master - <%=ContractorName %></h5>
		    		</div>
		             <br>

<form id="form_27236" method="post" action="AddProfileMaster.jsp" onsubmit="return chk()">

  <div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">
      
      <!-- Contractor ID & Department -->
      <div class="row col-12 mt-3">
        <div class="col-6 mt-4">
          <div class="input-container">
            <input class="form-control floating-input" type="text" id="cont_id" name="cont_id"
                   value="<%=Id %>" readonly>
            <label for="cont_id" class="floating-label">Contractor ID</label>
          </div>
        </div>
	 <div class="col-6">
            <div class="input-container">
                	<label class="tcolor">Department</label>
                 	<select class="form-select" id="dept" name="dept" required>
		              <option value="Select">Select</option>
		              <option value="Department1">Department1</option>
		              <option value="Department2">Department2</option>
		              <option value="Department3">Department3</option>
                  
                 </select>
            </div>
        </div>

      
      </div>

      <!-- Designation & Official Number -->
      <div class="row col-12 mt-3">
        <div class="col-6">
          <div class="input-container">
            <input class="form-control floating-input" type="text" id="designation" name="designation" placeholder=""  onblur="return checkdes()" required>
            <label for="designation" class="floating-label">Designation</label>
          </div>
        </div>

        <div class="col-6">
          <div class="input-container">
            <input class="form-control floating-input" type="text" id="official_no" name="official_no" placeholder=""  onblur="return checkphno()" required>
            <label for="official_no" class="floating-label">Official Number</label>
          </div>
        </div>
      </div>

      <!-- Official Email & Contract Start Date -->
      <div class="row col-12 mt-3">
        <div class="col-6">
          <div class="input-container">
            <input class="form-control floating-input" type="email" id="official_email" name="official_email" placeholder=""  onblur="return checkEmail()" required>
            <label for="official_email" class="floating-label">Official Email</label>
          </div>
        </div>

        <div class="col-6">
          <div class="input-container">
            <input class="form-control floating-input" type="text" id="cont_startdate" name="cont_startdate" placeholder=""  value="<%=Today %>" required>
            <label for="cont_startdate" class="floating-label">Contract Start Date</label>
          </div>
           <script type="text/javascript">
						Calendar.setup( {
							inputField : "cont_startdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "cont_startdate" // ID of the button
						});
					</script>
        </div>
      </div>

      <div class="row col-12 mt-3">
        <div class="col-6 mt-4">
          <div class="input-container">
            <input class="form-control floating-input" type="text" id="cont_end" name="cont_end" placeholder=""   value="<%=Today %>" required>
            <label for="cont_end" class="floating-label">Contract End Date</label>
          </div>
            <script type="text/javascript">
						Calendar.setup( {
							inputField : "cont_end", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "cont_end" // ID of the button
						});
					</script>
        </div>

        <div class="col-6">
          <div class="input-container">
          <label class="tcolor">Contractor Weekoff</label>
            <select class="form-select" id="weekoff" name="weekoff" required>
              <option value="Select">Select</option>
              <option value="1">Monday</option>
              <option value="2">Tuesday</option>
              <option value="3">Wednesday</option>
              <option value="4">Thursday</option>
              <option value="5">Friday</option>
              <option value="6">Saturday</option>
              <option value="7">Sunday</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Hidden Fields -->
      <input type="hidden" name="form_id" value="27236" />
      <input type="hidden" value="<%=ContractorName %>" id="Name" name="Name"/>

      <!-- Submit -->
      <div class="row mt-4">
        <div class="col text-center">
          <button type="submit" class="btn btn-primary px-4">Submit</button>
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

 <%}catch(Exception e){
	 e.printStackTrace();
 } %>   
 <script type="text/javascript">
function chk()
{

	var dept=document.getElementById("dept").value;
	
	if(dept=="Select")
		{
		alert("Please Select Department");
		return false;
		}
	
   var company=document.getElementById("designation").value;

	
	var re=/^[A-Za-z0-9]+[\s\-]*[\s\- .,&A-Za-z0-9]*[A-Za-z]+$/;
	if(company==""){
		
		alert("Enter the Designation");
		return false;
	}
	else{
	if(!re.test(company))
	{
	alert("Enter Designation Properly");
	return false;
	}
	}
	
	var phn=document.getElementById("official_no").value;
	 //var rs=/^\d{3}\d{3}\d{4}$/;
	 var rs=/^[+]{0,1}[0-9]{10,15}$/;

	 if(phn==""){
		 alert("Enter the Official Phone Number");
		 return false;
	 }
    if(!rs.test(phn)){
   	 
   	 alert("Please Enter 10 digit Phone number");
   	return false;
    }
    
    var txtEmail=document.getElementById("official_email").value;
	if(txtEmail==""){
		alert("Please Enter the Email Id");
		return false;
	} 
	if(!txtEmail.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/))
	{
	alert("Enter Valid  Email Id");
	return false;
	}

	
	var chkf="";
	var chkt="";
	var objFromDate = document.getElementById("cont_startdate").value;
	
	
	var fdate=objFromDate.split("-");
	if(fdate[1]=="Jan")
	{
		chkf="01";
	}
	if(fdate[1]=="Feb")
	{
		chkf="02";
	}
	if(fdate[1]=="Mar")
	{
		chkf="03";
	}
	if(fdate[1]=="Apr")
	{
		chkf="04";
	}
	if(fdate[1]=="May")
	{
		chkf="05";
	}
	if(fdate[1]=="Jun")
	{
		chkf="06";
	}
	if(fdate[1]=="Jul")
	{
		chkf="07";
	}
	if(fdate[1]=="Aug")
	{
		chkf="08";
	}
	if(fdate[1]=="Sep")
	{
		chkf="09";
	}
	if(fdate[1]=="Oct")
	{
		chkf="10";
	}
	if(fdate[1]=="Nov")
	{
		chkf="11";
	}
	if(fdate[1]=="Dec")
	{
		chkf="12";
	}
	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
    var objToDate = document.getElementById("cont_end").value;
    var tdate=objToDate.split("-");
    if(tdate[1]=="Jan")
	{
    	chkt="01";
	}
	if(tdate[1]=="Feb")
	{
		chkt="02";
	}
	if(tdate[1]=="Mar")
	{
		chkt="03";
	}
	if(tdate[1]=="Apr")
	{
		chkt="04";
	}
	if(tdate[1]=="May")
	{
		chkt="05";
	}
	if(tdate[1]=="Jun")
	{
		chkt="06";
	}
	if(tdate[1]=="Jul")
	{
		chkt="07";
	}
	if(tdate[1]=="Aug")
	{
		chkt="08";
	}
	if(tdate[1]=="Sep")
	{
		chkt="09";
	}
	if(tdate[1]=="Oct")
	{
		chkt="10";
	}
	if(tdate[1]=="Nov")
	{
		chkt="11";
	}
	if(tdate[1]=="Dec")
	{
		chkt="12";
	}
    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
    var date1 = new Date(objFromDate1);
    var date2 = new Date(objToDate1);
   
    var date3 = new Date();
    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
    var currentDate = new Date(date4);
     
        if(date1 > date2)
        {
            alert("From Date Should be Less Than To Date");
            return false; 
        }

        var weekoff=document.getElementById("weekoff").value;
    	
    	if(weekoff=="Select")
    		{
    		alert("Please Select Week OFF");
    		return false;
    		}
        
        return true;
	
}
</script>

<script type="text/javascript">
function checkdes(){
	
	var company=document.getElementById("designation").value;

	
	var re=/^[A-Za-z0-9]+[\s\-]*[\s\- .,&A-Za-z0-9]*[A-Za-z]+$/;
	if(company==""){
		
		alert("Enter the Designation");
		return false;
	}
	else{
	if(!re.test(company))
	{
	alert("Enter Designation Properly");
	return false;
	}
	}
}
</script>
<script type="text/javascript">
     
     function checkphno(){
    	 var phn=document.getElementById("official_no").value;
    	 var rs=/^[+]{0,1}[0-9]{10,15}$/;

    	 if(phn==""){
    		 alert("Enter the Official Phone Number");
    		 return false;
    	 }
         if(!rs.test(phn)){
        	 
        	 alert("Please Enter 10 Digit number");
        	 return false;
         }
     
     }
</script>
<script type="text/javascript">
function checkEmail(){  
	 
	 var txtEmail=document.getElementById("official_email").value;
	if(txtEmail==""){
		alert("Please Enter the Email Id");
		return false;
	} 
	if(!txtEmail.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/))
	{
	alert("Enter Valid  Email Id");
	return false;
	}
	} 
</script>

<%@ include file="footer.jsp" %>
</body>
</html>