<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>
<%@ page import="java.util.Date" %>

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
 // Variable Declaration
 	 String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
 	String todaysDate = session.getAttribute("today").toString(); 
 	String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";

String sql="";
Connection con = null;
Statement st1=null, st2=null,st3=null;
try {
	
	
	/* System.out.println("twEmp:::::::::::::::::: "+twEmp); */
	con = connection.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+con);
	st1 = con.createStatement();
	st2 = con.createStatement();
	st3 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 
%>
 	<%
 	String twEmp = session.getAttribute("leaveempID").toString();
/* String datenew1="",datenew2="";
datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
Date d=new Date();

Format df1= new SimpleDateFormat("yyyy-MM-dd");
String dtoday=df1.format(d);
System.out.println("665555555555555555555="); */
%>
 <%
 bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";
 
 %>
 
 
 
 
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1200px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Contractor's Registration Form</h5>
		    		</div>
		             <br>
		             	<form name="EmpReg" id="EmpReg" action="empRegData.jsp" method="post"enctype="multipart/form-data" onsubmit="return validate();">

<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
  
  
  <div class="row col-12">
						<div class="col-3 ">
						  <div class="input-container">
						  <label >Contractor's Details</label>
						  
						  </div>
						  </div>
						  </div>
    <div class="row">
      <div class="row col-12 mt-3"> 
       
      
            <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="empId" id="empId" placeholder="" required>
          <label for="empId" class="floating-label">Contractor ID</label>
        </div>
      </div>

       <div class="col-3 ">
          <div class="input-container">    
        <label class="tcolor">Contractor Name</label>
            <select class="form-select"  name="gender" id="gender" required>            
           	<option value="Mr.">Mr.</option>
			<option value="Ms.">Ms.</option>
           
           </select>

        </div>
      </div>

      
            <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="fName" id="fName" placeholder="" required>
          <label for="fName" class="floating-label">First Name</label>
          
        </div>
      </div>
       <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="mName" id="mName" placeholder="" required>
          <label for="mName" class="floating-label">Middle Name</label>
          
        </div>
      </div>
      
      
 
  </div>    
</div>


<div class="row">
 <div class="row col-12 mt-3"> 
    <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="lName" id="lName" placeholder="" required>
          <label for="lName" class="floating-label">Last Name</label>
          
        </div>
  </div>   
       <div class="col-3 ">
        <div class="input-container">    
        <label class="tcolor">Company Name</label>
            <select class="form-select" name="cmpName" id="cmpName" 
								onchange="getDeptData(this.value);" required>            
           	<option value="Select">Select</option>
									<% 
						try
						{
							String sqlCat="select CompanyCode,OurCompanyName from t_ourcompanydet";
						    ResultSet rsCat=st1.executeQuery(sqlCat);
						    while(rsCat.next())
						    { %>
									<option value="<%=rsCat.getString("CompanyCode") %>">
										<%=rsCat.getString("OurCompanyName") %>
									</option>
									<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }%>
							</select>
        </div>
      </div>
      
    
              <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="doj" name="doj" value="<%=datex1%>" placeholder="" required>
                <label for="doj" class="floating-label">Date	Of Joining</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "doj", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "doj",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>

    <div class="col-3 ">
        <div class="input-container">
         <label class="tcolor">Department Name</label>
            <select class="form-select" name="deptName" id="deptName">            
          </select>
          
        </div>
  </div>

</div>

 </div>
 <div class="row">
 <div class="row col-12 mt-3"> 
 
       <div class="col-3 ">
        <div class="input-container">    
        <label class="tcolor">Contractor Designation </label>
            <select class="form-select" name="empDesg" id="empDesg">            
           <option value="Select">Select</option>
									<% 
						try
						{
							String sqlDesg="select designation from t_designation order by designation";
						    ResultSet rsDesg=st3.executeQuery(sqlDesg);
						    while(rsDesg.next())
						    { %>
									<option value="<%=rsDesg.getString("designation") %>">
										<%=rsDesg.getString("designation") %>
									</option>
									<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }%>
							</select>
        </div>
      </div>
   <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="contact" id="contact" placeholder="" required>
          <label for="contact" class="floating-label">Contact No</label>
          
        </div>
  </div>   
 
   <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="email" id="email" placeholder="" required>
          <label for="email" class="floating-label">Email</label>
          
        </div>
  </div>   
 
 

    
              <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="dob" name="dob" value="<%=datex2%>" placeholder="" required>
                <label for="dob" class="floating-label">Date Of Birth</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "dob", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "dob",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
        



</div>

 </div>
 <div class="row">
 <div class="row col-12 mt-3"> 

        <div class="col-3 ">
<div class="input-container">    
<label class="tcolor">Marital Status</label>
<select class="form-select" name="marial" id="marial" onchange="Change();" required>   
<option value="Select">Select</option>
<option value="Single">Single</option>
<option value="Married">Married</option>
</select>
</div>
</div>


<div class="col-3 mt-4" id="ani" style="display:none;">
<div class="input-container">
<input class="form-control floating-input" type="text" id="doa" name="doa" value="<%=datex2%>" required>
<label class="floating-label">Date Of Anniversary</label>
 <script type="text/javascript">
						    Calendar.setup( {
							inputField : "doa", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "doa",
							 
								 // ID of the button
					    	});
					    </script>
</div>
</div>


<div class="col-3" id="kid" style="display:none;">
<div class="input-container">    
<label class="tcolor">Kids Details</label>
<select class="form-select" name="kids" id="kids" onchange="Change2();" required>
<option value="Select">Select</option>
<option value="Yes">Yes</option>
<option value="No">No</option>
</select>
</div>
</div>
   <div class="col-3 mt-4">
        	<div class="input-container">
          <textarea class="form-control floating-input" name="address" id="address" rows="1"></textarea>
           <label for="address" class="floating-label">Address</label>
        	</div>
      </div>

<div class="row col-12 mt-3"> 

 <!-- Children Sex -->
<div class="col-3" id="bacche" style="display:none;">
<div class="input-container">    
<label class="tcolor">Children1 Sex</label>
<select class="form-select" name="kidsex" id="kidsex">
<option value="Male">Male</option>
<option value="Female">Female</option>
</select>
</div>
</div>



<!-- Child Name -->
<div class="col-3 mt-4" id="baccheName1" style="display:none;">
<div class="input-container">
<input class="form-control floating-input" type="text" name="child1" id="child1" placeholder="">
<label  for="child1" class="floating-label">Name of Child1</label>
</div>
</div>


<!-- Child DOB -->
<div class="col-3 mt-4" id="bacche1" style="display:none;">
<div class="input-container">
<input class="form-control floating-input" type="text" id="doch1" name="doch1" value="<%=datex2%>">
<label class="floating-label">Date Of Birth Child1</label>
   <script type="text/javascript">
						    Calendar.setup( {
							inputField : "doch1", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "doch1",
							 
								 // ID of the button
					    	});
					    </script>
</div>
</div>
 <div class="col-3 mt-4" id="c1" style="display:none;">



		<a href="#/" style="font-weight: bold; color: blue; text-decoration:none;" onclick="Change3();">
						<font size="3" >(+)</font>
						</a>
</div> 

</div>


<div class="row col-12 mt-3" id="baccheChild2" style="display:none;">

<div class="col-3">
<div class="input-container">
<label class="tcolor">Children2 Sex</label>
<select name="kidsex1" id="kidsex1" class="form-select">
<option value="Male">Male</option>
<option value="Female">Female</option>
</select>
</div>
</div>

<div class="col-3 mt-4">
<div class="input-container">
<input class="form-control floating-input" type="text" name="child2" id="child2" placeholder="">
<label for="child2" class="floating-label">Name of Child2</label>
</div>
</div>

<div class="col-3 mt-4">
<div class="input-container">
<input class="form-control floating-input" type="text" id="doch2" name="doch2" value="<%=datex2%>">
<label class="floating-label">Date Of Birth Child2</label>

<script type="text/javascript">
Calendar.setup({
inputField : "doch2",
ifFormat : "%d-%b-%Y",
button : "doch2",
showsTime : "true"
});
</script>

</div>
</div>

</div>


    
	


</div>

 </div>
 
 
 </div>
 </div>
 

 
  <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row col-12">
						<div class="col-3 ">
						  <div class="input-container">
						  <label >Contractor Registration</label>
						  
						  </div>
						  </div>
						  </div>
    <div class="row" >
    	  <div class="row col-12 mt-3">
  
  <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="contractdate" name="contractdate" value="<%=datex1%>" placeholder="" required>
                <label for="contractdate" class="floating-label">Contract Date</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "contractdate", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "contractdate",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
        
          <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="contractexpdate" name="contractexpdate" value="<%=datex2%>" placeholder="" required>
                <label for="contractexpdate" class="floating-label">Contract Expiry Date</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "contractexpdate", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "contractexpdate",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>

                <div class="col-5">
<div class="input-container">
<label class="tcolor">Contractor File</label>
<input type="file" class="form-control" name="myfile1" id="myfile1">
<input type="hidden" name="fileName" id="fileName" value="">
</div>
</div>
        </div>
        </div>
        </div>
          
    </div>
     <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row col-12">
						<div class="col-3 ">
						  <div class="input-container">
						  <label >Banking Details</label>
						  
						  </div>
						  </div>
						  </div>
						  
	   <div class="row" >
    	  <div class="row col-12 mt-3">
  
       <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="accno" id="accno" placeholder="" required>
          <label for="contact" class="floating-label">Account Number</label>
          
        </div>
  </div> 
     <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="bank" id="bank" placeholder="" required>
          <label for="bank" class="floating-label">Bank Name</label>
          
        </div>
  </div> 
   <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="branch" id="branch" placeholder="" required>
          <label for="branch" class="floating-label">Branch Name</label>
          
        </div>
  </div> 
     <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="ifsc" id="ifsc" placeholder="" required>
          <label for="ifsc" class="floating-label">IFSC Code</label>
          
        </div>
  </div> 
     </div>
        </div>
            <div class="row" >
    	  <div class="row col-12 mt-3">
  
       <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="pan" id="pan" placeholder="" required>
          <label for="pan" class="floating-label">Pan Card No</label>
          
        </div>
        </div>
        </div>
        </div>
        
        </div>
          
    </div>
    
    
     <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row col-12">
						<div class="col-3 ">
						  <div class="input-container">
						  <label >MediClaim	Details</label>
						  
						  </div>
						  </div>
						  </div>
		
						  
						  
						  
    <div class="row" >
    	  <div class="row col-12 mt-3">
  
       <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="policy" id="policy" placeholder="" required>
          <label for="policy" class="floating-label">Policy No</label>
          
        </div>
  </div> 
     <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="claimcmpny" id="claimcmpny" placeholder="" required>
          <label for="claimcmpny" class="floating-label">Name Of Company</label>
          
        </div>
  </div> 
 
   <div class="col-3 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="doe" name="doe" value="<%=datex2%>" placeholder="" required>
                <label for="doe" class="floating-label">Date Of Expiry</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "doe", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "doe",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
        
       <div class="col-3 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="amount" id="amount" placeholder="" required>
          <label for="amount" class="floating-label">Amount For Claim</label>
          
        </div>
  </div> 




                <div class="col-5">
<div class="input-container">
<label class="tcolor">Mediclaim(file)</label>
<input type="file" class="form-control" name="myfile" id="myfile">
<input type="hidden" name="fileName1" id="fileName1" value="">
</div>
</div>
        </div>
        </div>
        </div>
          
    </div> 
    
    
         <div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row col-12">
						<div class="col-3 ">
						  <div class="input-container">
						  <label >Emergency Contact Details</label>
						  
						  </div>
						  </div>
						  </div>
							
						
						  
	   <div class="row" >
    	  <div class="row col-12 mt-3 mb-4">
  
       <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="namecont" id="namecont" placeholder="" required>
          <label for="namecont" class="floating-label">Name of Contact Person</label>
          
        </div>
  </div> 
     <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="contno" id="contno" placeholder="" required>
          <label for="contno" class="floating-label">Contact No </label>
          
        </div>
  </div> 
      <div class="col-3">
        	<div class="input-container">
          <textarea class="form-control floating-input" name="contaddress" id="contaddress" rows="1" placeholder=""> </textarea>
           <label for="contaddress" class="floating-label">Address</label>
        	</div>
      </div>
     <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="relation" id="relation" placeholder="" required>
          <label for="relation" class="floating-label">RelationShip</label>
          
        </div>
  </div> 
     </div>
        </div>
<input type="hidden" name="action" id="action" value="add">
        
        </div>
          
    </div>

  <input type="hidden" id="empName" name="empName">
 <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" type="submit" id="submit1" value="Submit">Submit</button>
    </div>  
    
 </form>
 </div>
 </div>
 </div>
 </div>
 </section>
 </div>
 </div>
 
 
 
 
 
 
 
 <script LANGUAGE="JavaScript" type="text/javascript">
function name()
{
	alert("In Fun");
}
function dateformat(monthName) {
    var months = {
        "Jan":1, "Feb":2, "Mar":3, "Apr":4, "May":5, "Jun":6,
        "Jul":7, "Aug":8, "Sep":9, "Oct":10, "Nov":11, "Dec":12
    };
    return months[monthName];
}
function Change()
{
	var marial=document.getElementById("marial").value;

	if(marial=="Married")
	{
		document.getElementById("ani").style.display="";
		document.getElementById("kid").style.display="";
	}
	else
	{
		document.getElementById("ani").style.display="none";
		document.getElementById("kid").style.display="none";
		document.getElementById("bacche").style.display="none";
		document.getElementById("baccheName1").style.display="none";
		document.getElementById("bacche1").style.display="none";
		document.getElementById("baccheChild2").style.display="none";
		document.getElementById("bacche3").style.display="none";
		document.getElementById("c1").style.display="none";
	}
}
function Change1()
{
	var salary=document.getElementById("salary").value;
	if(salary=="Yes")
	{
		 document.getElementById("sal").style.display="";
		 document.getElementById("sal1").style.display="";
	}
	else
	{
		 document.getElementById("sal").style.display="none";
		 document.getElementById("sal1").style.display="none";
	}
	
}
function Change2()
{
	var kids=document.getElementById("kids").value;

	if(kids=="Yes")
	{
		document.getElementById("bacche").style.display="";
		document.getElementById("baccheName1").style.display="";
		document.getElementById("bacche1").style.display="";
		document.getElementById("c1").style.display="";
	}
	else
	{
		document.getElementById("bacche").style.display="none";
		document.getElementById("baccheName1").style.display="none";
		document.getElementById("bacche1").style.display="none";
		document.getElementById("baccheChild2").style.display="none";
		document.getElementById("bacche3").style.display="none";
		document.getElementById("c1").style.display="none";
	}
}
function Change3()
{
	document.getElementById("baccheChild2").style.display="";
	document.getElementById("c1").style.display="none";
}
function dateValidate(dt,today)
{   
	
	var dy1=dt.substring(7,11);
	var dy2=today.substring(0,4);
	var dm1=dt.substring(3,6);
	dm1=dateformat(dm1);
	var dm2=today.substring(5,7);
	var dd1=dt.substring(0,2);
	var dd2=today.substring(8,10);
	if((dy1<dy2)||(dm1<dm2)||dd1<dd2)
	{
		alert("Please Select the valid Date");
		return false;
	}
	
	return true;
}

function validate()
{
	//alert("IN FUNc");
	var val2 = document.getElementById("cmpName").value;
	var deptName = document.getElementById("deptName").value;
	var val4 = document.getElementById("empDesg").value;
	var val5 = document.getElementById("fName").value;
	// var val6 = document.getElementById("mName").value;
	var val7 = document.getElementById("lName").value;
	var val8 = document.getElementById("email").value;
	var val9 = document.getElementById("empId").value;
	var contact = document.getElementById("contact").value;
	var dob = document.getElementById("dob").value;
	var marial = document.EmpReg.marial.value;
	var address = document.getElementById("address").value;
	var accno = document.getElementById("accno").value;
	var bank = document.getElementById("bank").value;
	var branch = document.getElementById("branch").value;
	var ifsc = document.getElementById("ifsc").value;
	var policy = document.getElementById("policy").value;
	var claimcmpny = document.getElementById("claimcmpny").value;
	var doe = document.getElementById("doe").value;
	var amount = document.getElementById("amount").value;
	var namecont = document.getElementById("namecont").value;
	var contactno = document.EmpReg.contno.value;
	var contaddress = document.getElementById("contaddress").value;
	var relation = document.getElementById("relation").value;
	var pan = document.getElementById("pan").value;
	var contractdate = document.getElementById("contractdate").value;
	var contractexpdate = document.getElementById("contractexpdate").value;
	ifsc=ifsc.replace(/\s/g,"");
	val2=val2.replace(/\s/g,"");
	val5=val5.replace(/\s/g,"");
	val8=val8.replace(/\s/g,"");
	val9=val9.replace(/\s/g,"");
	contact=contact.replace(/\s/g,"");
	address=address.replace(/\s/g,"");
	accno=accno.replace(/\s/g,"");
	bank=bank.replace(/\s/g,"");
	policy=policy.replace(/\s/g,"");
	namecont=namecont.replace(/\s/g,"");
	contactno=contactno.replace(/\s/g,"");
	contaddress=contaddress.replace(/\s/g,"");
	relation=relation.replace(/\s/g,"");
	pan=pan.replace(/\s/g,"");
	doe=doe.replace(/\s/g,"");
	var letters = /^[A-Za-z 1-9 ]+$/;  
	var val1 = document.getElementById("empName").value;
	document.getElementById("empName").value=val5+" "+val7;
	
	
	
	
	
	//alert("1");
	if(marial=="Married")
	{
	  var doa = document.getElementById("doa").value;
	  var kids = document.getElementById("kids").value;
	  if(kids=="Yes")
	  {
		 var child1= document.getElementById("child1").value;
		 var child2= document.getElementById("child2").value;
		 var doch1= document.getElementById("doch1").value;
		 var doch2= document.getElementById("doch2").value;
	  }
	}
	if(val9.length==0)
	{
		alert("Please Enter the Contractor ID ");
		return false;
	}
	if(isNaN(val9))
	{
	alert("Enter the Valid Contractor ID");
	return false;
	}
	
	if(val5.length==0)
	{
		alert("Please Enter the Contractor First Name");
		return false;
	}
	var letters2=letters.test(val5);
    if(letters2==false)
     {     
        alert('Contractor First Name must have characters only');    
       return false;  
      }  
	
	if(val2=="" || val2=="Select")
	{
		alert("Please select the Company Name");
		return false;
	}
	if(deptName=="" || deptName=="select")
	{
		alert("Please select the Department");
		return false;
	}
	if(val4=="" || val4=="Select")
	{
		alert("Please select the Contractor Designation");
		return false;
	}
	
	
	if(contact.length==0)
	{
	alert("Please Enter the Contact Number");
	return false;
	}
	if(isNaN(contact))
	{
	alert("Enter the Valid Contact Number(10 Digit Number)");
	return false;
	}
	if((contact.length<10)||(contact.length>10))
	{
	alert("Your Contact Number Should be Valid 10 Digit Number");
	return false;
	}
	if(val8.length==0)
	{
		alert("Please Enter the Contractor Email ID");
		return false;
	}
 	else
  	{	 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  		    if (!filter.test(val8)) {
  		    alert('Please provide a valid Contractor Email ID');
  		    return false;
  	} 
  	}
	var dd11=dob.substring(0,2);
    var mm1=dob.substring(3,6);
    var mm11=dateformat(mm1);///alert(mm11);
    var yy11=dob.substring(7,11);//alert(yy11);
    var date=new Date();
    var month=date.getMonth()+1;
    var day=date.getDate();
    var year=date.getFullYear();
    if(yy11>year)
    {
            alert("Date of Birth Should Not be Greater Than Todays Date");
            document.getElementById("dob").value="";
            document.getElementById("dob").focus;
            return false;
    }
    else if(year==yy11)
    {
            if(mm11>month)
            {
            	alert("Date of Birth Should Not be Greater Than Todays Date");
                document.getElementById("dob").value="";
                document.getElementById("dob").focus;
                return false;
            }
    }
    if(mm11==month && year==yy11)
    {
            if(dd11>day)
            {
            	alert("Date of Birth Should Not be Greater Than Todays Date");
                document.getElementById("dob").value="";
                document.getElementById("dob").focus;
                return false;
            }
    }
    if(dob=="")
    {
    	alert("Please Enter Date of Birth. ");
    	return false;
    }
    if(marial=="Select")
    {
    	alert("Please Select Marital Status. ");
    	return false;
    }
     if(marial=="Married")
     {
     var dd11e=doa.substring(0,2);
     var mm1e=doa.substring(3,6);
     var mm11e=dateformat(mm1e);///alert(mm11);
     var yy11e=doa.substring(7,11);//alert(yy11);
     if(yy11e>year)
     {
             alert("Date of Anniversary Should Not be Greater Than Todays Date");
             document.getElementById("doa").value="";
             document.getElementById("doa").focus;
             return false;
     }
     else if(year==yy11e)
     {
             if(mm11e>month)
             {
             	alert("Date of Anniversary Should Not be Greater Than Todays Date");
                 document.getElementById("doa").value="";
                 document.getElementById("doa").focus;
                 return false;
             }
     }
     if(mm11e==month && year==yy11e)
     {
             if(dd11e>day)
             {
             	alert("Date of Anniversary Should Not be Greater Than Todays Date");
                 document.getElementById("doa").value="";
                 document.getElementById("doa").focus;
                 return false;
             }
     }
     if(doa=="")
     {
     	alert("Please Enter Date of Anniversary. ");
     	return false;
     }
     if(kids=="Select")
     {
     	alert("Please Select Kids Details Yes/No. ");
     	return false;
     }
     }

    if(address.length==0)
    {
    	alert("Please Enter Address of Contractor. ");
    	return false;
    }
	 if(contractdate.length==0)
	    {
	    	alert("Please Enter Contract Date. ");
	    	return false;
	    }
	var dd11con=contractdate.substring(0,2);
    var mm1con=contractdate.substring(3,6);
    var mm11con=dateformat(mm1con);///alert(mm11);
    var yy11con=contractdate.substring(7,11);//alert(yy11);
     if(contractexpdate.length==0)
    {
    	alert("Please Enter Contract Expiry Date. ");
    	return false;
    }
		var dd11cone=contractexpdate.substring(0,2);
		var mm1cone=contractexpdate.substring(3,6);
		var mm11cone=dateformat(mm1cone);///alert(mm11);
		var yy11cone=contractexpdate.substring(7,11);//alert(yy11);
		mm11con=mm11con+2;
		
		if(yy11cone <yy11con)
		{
		        alert("Contract Expiry Date Should be 3 Month Grater then Contract Date");
		        document.getElementById("contractexpdate").value="";
		        document.getElementById("contractexpdate").focus;
		        return false;
		}else if(yy11cone==yy11con)
	     {
            if((mm11cone<mm11con|| dd11cone<dd11con))
            {
                alert("Contract Expiry Date Should be 3 Month Grater then Contract Date");
		        document.getElementById("contractexpdate").value="";
		        document.getElementById("contractexpdate").focus;
		        return false;
		}}
	
	if(accno.length==0)
	{
	alert("Please Enter Account Number");
	//documnet.AddNewUser.Mobno.focus();
	return false;
	}
	if(isNaN(accno))
	{
	alert("Enter the Valid Account Number");
	//document.AddNewUser.Mobno.focus();
	return false;
	}
	if((accno.length<10)||(accno.length>20))
	{
	alert("Your Account Number Should be Max 20 Digit Number");
	//document.AddNewUser.contact.select();
	return false;
	}
	if(bank.length==0)
	{
	 alert("Please Enter Bank Name");
	 return false;
	}
	
	if(ifsc.length==0)
	{
		alert("Please Enter IFCS No.");
		return false;
	}
	if(ifsc.length>=21)
	{
		alert("IFCS No. should not be more than 20 digit");
		return false;
	}	
	if(pan.length==0)
	{
		alert("Please Enter Pan Card No.");
		return false;
	}
	if(pan.length>=11)
	{
		alert("PAN No should not be more than 10 digit");
		return false;
	}
	var letters16=letters.test(pan);
	if(letters16==false)
	{     
       alert('Pan Card No must have Characters & Number only');    
        return false;  
     }
	
    if(policy.length==0)
	{
	alert("Please Enter the Policy Number");
	return false;
	}
    var lett=letters.test(policy);
    if(lett==false)
    {     
        alert('Policy Number must have Alphanumeric values');    
       return false;  
    } 
    if(policy.length>=15)
	{
		alert("policy No should not be more than 15 digit");
		return false;
	}
    if(doe.length==0)
    {
    	alert("Please Enter Mediclaim Expiry Date. ");
    	return false;
    }
	var dd11e=doe.substring(0,2);
    var mm1e=doe.substring(3,6);
    var mm11e=dateformat(mm1e);///alert(mm11);
    var yy11e=doe.substring(7,11);//alert(yy11);
    if(yy11e<year)
    {
            alert("Mediclaim Expiry Date Should be Greater Than Todays Date");
            document.getElementById("doe").value="";
            document.getElementById("doe").focus;
            return false;
    }
    else if(year==yy11e)
    {
            if(mm11e<month)
            {
            	alert("Mediclaim Expiry Date Should be Greater Than Todays Date");
                document.getElementById("doe").value="";
                document.getElementById("doe").focus;
                return false;
            }
    }
    if(mm11e==month && year==yy11e)
    {
            if(dd11e<day)
            {
            	alert("Mediclaim Expiry Date Should be Greater Than Todays Date");
                document.getElementById("doe").value="";
                document.getElementById("doe").focus;
                return false;
            }
    }
    
    if(namecont.length==0)
	{
		alert("Please Enter the Name of Immediate Contact ");
		return false;
	}
	var letters8=letters.test(namecont);
    if(letters8==false)
    {     
        alert('Name of Immediate Contact must have characters only');    
       return false;  
    } 
    
	if(contactno.length==0)
	{
	alert("Please Enter the Immediate Contact Number");
	return false;
	}
	if(isNaN(contactno))
	{
	alert("Enter the Valid Immediate Contact Number(10 Digit Number)");
	return false;
	}
	if((contactno.length<10)||(contactno.length>10))
	{
	alert("Your Immediate Contact Number Should be Valid 10 Digit Number");
	return false;
	}
	
	if(contaddress.length==0)
	{
		alert("Please Enter the Address of Immediate Contact ");
		return false;
	}
    if(relation.length==0)
	{
		alert("Please Enter the RelationShip");
		return false;
	}
	var letters19=letters.test(relation);
    if(letters19==false)
    {     
        alert('RelationShip must have characters only');    
       return false;  
    }
   return true;
}

function getDeptData(cmpCode)
{
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  // code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {
	//	  alert(xmlhttp.responseText);
		  document.getElementById("deptName").innerHTML=xmlhttp.responseText;
		  }
		}
		xmlhttp.open("GET","AjxDeptData.jsp?cmpCode="+cmpCode,true);
		xmlhttp.send(null);
		
}
</script>
 <%@ include file="footer.jsp" %>
</body>
</html>