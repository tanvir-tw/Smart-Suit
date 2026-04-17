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
Connection conn = null;
Statement st1 = null,st2=null,st4=null,st3=null;

try {
	conn = connection.getConnect("db_leaveapplication");         
	   
	    st=conn.createStatement();
	    st1=conn.createStatement();
	    st2=conn.createStatement();
	    st3=conn.createStatement();
	    st4=conn.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 

%>
<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 800px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Transworld - Leave Application</h5>
		    		</div>
		    		
		<%
String IP=request.getParameter("IP");
if(IP==null){
	System.out.println("if IP -->"+IP);
}else{
	System.out.println("else IP -->"+IP);
	%>
		
		<div class="text-center my-3">
		  	<b class="text-success fs-5"></b>
		</div>
		<%
}

String updated="";
updated=request.getParameter("inserted");
System.out.println("updated-->"+updated);
if(updated==null){
	System.out.println("if updated-->"+updated);
}
else if(updated.equalsIgnoreCase("yes")){
	System.out.println("if else updated Yes -->"+updated);
	%>
		
		<div class="text-center my-2">
		  <b class="text-success fs-5">Leave Added Successfully</b>
		</div>
		

		<%
}else if(updated.equalsIgnoreCase("no")){
	System.out.println("if esse updated no -->"+updated);
	%>
		
						
		<div class="text-center my-2">
		  <b class="text-danger fs-5">Leave is not added</b>
		</div>
		

		<%
}
else if(updated.equalsIgnoreCase("present")){
	
	System.out.println("last else if updated-->"+updated);
	%>
	
		<div class="text-center my-2">
		  <b class="text-success fs-5">Already Leave Applied !!</b>
		</div>		

		<%
}

String username=session.getAttribute("leaveusername").toString();
String empid1=session.getAttribute("leaveempID").toString();

System.out.println("empid1-******************************->"+empid1);
System.out.println("username-******************************->"+username);

System.out.println(username);
String sql="select * from t_leaveadmin where EmpID='"+empid1+"'";
System.out.println("sql User Query " +sql);
ResultSet rs=st4.executeQuery(sql);

if(rs.next()){
%>		
<form method="post" name="leave" action="leaveApplicationInsert.jsp" onsubmit="return validate();">
<div class="container p-4 shadow rounded bg-white" style="max-width: 700px;">
<div align="left">
  <a href="leaveApplication.jsp" style="color: black;" onclick="getTerms(); return false;">Terms of Use</a>
</div>

  <div class="card-body">
    <div class="row mt-4">
    
      <div class="col-6">
        <div class="input-container">   
          <input type="text" class="form-control floating-input" id="FirstDayOfLeave" name="FirstDayOfLeave" placeholder=""  value="" onblur="AJAXFunc()" required>
        <label for="FirstDayOfLeave" class="floating-label">First day of leave</label>
    
        </div>
      </div>
      <script type="text/javascript">
        Calendar.setup({
          inputField: "FirstDayOfLeave",
          ifFormat: "%d-%b-%Y",
          button: "trigger"
        });
      </script>
      
      <div class="col-md-6">
        <div class="input-container">
       
          <input type="text" id="DaysApplied" name="DaysApplied" class="form-control floating-input" placeholder="" onchange="AJAXFunc1();" required>
           <label for="DaysApplied" class="floating-label">Days applied </label>
        </div>
        
      </div>
    </div>

    <!-- Type of Leave -->
    <div class="row mt-4">
      <div class="col-md-6">
        <div class="input-container">
        <label for="reason" class="tcolor">Type of leave required</label>
          <select id="reason" name="reason" class="form-select floating-input" required>
            <%
              String reasone="select distinct(reason) as reason from t_leavereason where status='Active' order by reason";
            System.out.println("sql User Query reasone " +reasone);
            
            ResultSet rsReasone=st4.executeQuery(reasone);
              while(rsReasone.next()) {
            %>
              <option value="<%=rsReasone.getString("reason") %>"><%=rsReasone.getString("reason") %></option>
            <% } %>
          </select>
          
        </div>
      </div>
       <div class="col-md-6 mt-3">
        <div class="input-container">
          <input type="text" id="DateOfReporting" name="DateOfReporting" class="form-control floating-input" value="" placeholder="" readonly>
          <label for="DateOfReporting" class="floating-label">Date when reporting</label>
        </div>
      </div>
    </div>

    <!-- Email -->
    <div class="row mt-4">
      <div class="col-md-6">
        <div class="input-container">
          <input type="text" id="emailAdd" name="emailAdd" class="form-control floating-input" placeholder="" value="<%=session.getAttribute("leaveemail")%>" readonly>
          <label for="emailAdd" class="floating-label">Email address</label>
        </div>
      </div>
      
        <div class="col-md-6">
        <div class="input-container">
          <input type="text" id="HODemailAdd" name="HODemailAdd" class="form-control floating-input" placeholder="" readonly>
          <label for="HODemailAdd" class="floating-label">HOD's Email address</label>
        </div>
      </div>
    </div>

   
    <!-- Reason for Leave -->
    <div class="row mt-4">
      <div class="col-md-6">
        <div class="input-container">
          <textarea id="reasonForLeave" name="reasonForLeave" class="form-control floating-input" placeholder="" rows="2" required></textarea>
          <label for="reasonForLeave" class="floating-label">Reason for leave</label>
        </div>
      </div>
      
       <div class="col-md-6">
        <div class="input-container">
          <input type="text" id="name" name="name" class="form-control floating-input" placeholder=""
                 value="<%=session.getAttribute("leaveempname") %>" readonly>
          <label for="name" class="floating-label">Your full name</label>
        </div>
      </div>
    </div>
   
    <!-- Phone Number -->
    <div class="row mt-4">
      <div class="col-md-6">
        <div class="input-container">
          <input type="text" id="Details" name="Details" class="form-control floating-input" placeholder="" required>
          <label for="Details" class="floating-label">Your phone number</label>
        </div>
      </div>
      
    
      
    </div>
  <div class="d-grid gap-2 col-3 mx-auto mt-3">
         <button class="btn" id="submit" type="submit">Submit</button>
    </div>
    <input type="hidden" id="empid" name="empid" value="<%=empid1 %>">
  </div>
  </div>
</form>

			<%} %>
			</div>
			</div>
			</div>
			</div>
			</section>
			</div>
			</div>
			
<script type="text/javascript">
	function AJAXFunc()
	{
		
	//  alert("in ajax function  of APPLY LEAVE PAGE **************   ");
	  var v1=document.getElementById("empid").value;
	 //alert("empid==>"+v1);
	 
	 
	  //alert(v3);
	  
	 
	  //alert(owner);

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
	 		           //  Something went wrong
	 	                   alert("Your browser broke!");
	 			   return false;
	 	            }
	 	        }
	          }
	                
	          // Create a function that will receive data sent from the server
	            ajaxRequest.onreadystatechange = function()
	            {
	     	       if(ajaxRequest.readyState == 4)
	                {
	                      var reslt=ajaxRequest.responseText;
					//	alert(reslt);
	                      var mySplitResult = reslt.split("#");
	                      var mySplitResult1=  mySplitResult[0]; 
	                      var mySplitResult2=  mySplitResult[1];

							// Results from Ajaxunitadd.jsp are put into fields
							mySplitResult[0] = mySplitResult[0].replace(/^\s+|\s+$/g,"");//email id of HOD
							

							        // alert("email of hodid----->"+mySplitResult[0])  ;     
							      //   alert("email of hodid----->"+mySplitResult[1]) ;   
	                   // alert("ema il of hodid--2222--->"+ mySplitResult[2])    

	                 document.getElementById("HODemailAdd").value=mySplitResult[0];
							
	 	       } 
	            }
	            
	  
	           var queryString = "?empid=" +v1;
	 	   ajaxRequest.open("GET", "AjaxGetHodID.jsp" + queryString, true);
	 	 // ajaxRequest.open("GET", "AjaxGetHodemail.jsp" + queryString, true);
	 	  
	 	   ajaxRequest.send(null); 
	}

</script>
<script>
function AJAXFunc1()
{
 // alert("AJAXFunc1    ");
  var v1=document.getElementById("DaysApplied").value;
 //alert("No of days applied==>"+v1);
 
 
 var v2=document.getElementById("FirstDayOfLeave").value;
  //alert("FirstDayOfLeave==>"+v2);
   
  //alert(owner);

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
 		           //  Something went wrong
 	                   alert("Your browser broke!");
 			   return false;
 	            }
 	        }
          }
                
          // Create a function that will receive data sent from the server
            ajaxRequest.onreadystatechange = function()
            {
     	       if(ajaxRequest.readyState == 4)
                {
                      var reslt=ajaxRequest.responseText;
					//alert(">>>>"+reslt);
                      var mySplitResult = reslt.split("#");
                     
                      var mySplitResult1=  mySplitResult[0]; 
                      var mySplitResult2=  mySplitResult[1];
                      
                    // alert("mySplitResult2 type=="+typeof(mySplitResult2));
                    // alert("0 date:"+mySplitResult[0]);
                     // alert ("1 reject value:"+mySplitResult[1]);

						// Results from Ajaxunitadd.jsp are put into fields
						mySplitResult[0] = mySplitResult[0].replace(/^\s+|\s+$/g,"");//email id of HOD
						//alert("result 0:"+mySplitResult[0]);
						             //alert("email of hodid---0000--   >"+mySplitResult[0]) ;      
						         //alert("email of hodid----1111->"+mySplitResult[1])    
                     

                 document.getElementById("DateOfReporting").value=mySplitResult[0];
                      
						try{
							 /*							 */ 
						    if(mySplitResult[1]=="yes")
							{
							
							//alert("Leave date  can not be  more than 3 days from current date");
							
							  alert("You must Apply Leave within 3 Days ");
							
							 document.getElementById("DaysApplied").value="";
							 document.getElementById("FirstDayOfLeave").value="";
							 document.getElementById("DateOfReporting").value="";
							
							}else {
								//alert("in else cond  "+mySplitResult2);
								
								if(mySplitResult2 == 1 && mySplitResult2 !=31){
									
									alert("Applied Days Not In Multiple Of 0.5");	
									document.getElementById("DaysApplied").value="";
									 document.getElementById("FirstDayOfLeave").value="";
									 document.getElementById("DateOfReporting").value="";
									}
								 if(mySplitResult2 >=31)
									{
									
									//alert("Leave date  can not be  more than 3 days from current date");
									
									alert("You can't apply Leave more  than 31 Day's ");
									
									 document.getElementById("DaysApplied").value="";
									 document.getElementById("FirstDayOfLeave").value="";
									 document.getElementById("DateOfReporting").value="";
									
									}

								}
						         
						}catch(e)
						{
						//alert(e);	
							
						}                  		 
 	       } 
            }
            
  
           var queryString = "?NoDaysApplied=" +v1+"&v2="+v2;
 	   ajaxRequest.open("GET", "AjaxGetHodID1.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
}


</script>

<script type="text/javascript">
function validate(){
//alert("validate ");
    var FirstDayOfLeave = document.leave.FirstDayOfLeave.value.trim();
    if(FirstDayOfLeave.length==0){
        alert("Please enter First day of leave");
        return false;
    }

    var DaysApplied=document.leave.DaysApplied.value.trim();
    if(DaysApplied.length==0){
        alert("Please enter Number of days requested");
        return false;
    }
    if(isNaN(DaysApplied)){
        alert("Enter numeric value for Days Applied");
        return false; 
    }

    var reasonForLeave=document.leave.reasonForLeave.value.trim();
    if(reasonForLeave.length==0){
        alert("Please enter Reason for leave ");
        return false;
    }

    var name=document.leave.name.value.trim();
    if(name.length==0){
        alert("Please enter your full name");
        return false;
    }

    var DateOfReporting= document.leave.DateOfReporting.value.trim();
    if(DateOfReporting.length==0){
        alert("Please select Date when reporting / reported ");
        return false;
    }

    // Email check
    var emailAdd= document.leave.emailAdd.value.trim();  
    if(emailAdd.length==0){
        alert("Please enter your Email Id");
        return false;
    } else if(!validateEmail(emailAdd)){
        alert("Please enter valid Email Id");
        return false;
    }

    var HODemailAdd= document.leave.HODemailAdd.value.trim();  
    if(HODemailAdd.length==0){
        alert("Please enter HOD's Email Id");
        return false;
    } else if(!validateEmailHOD(HODemailAdd)){
        alert("Please enter valid HOD's Email Id");
        return false;
    }

    if(emailAdd==HODemailAdd){
        alert("User's email id and HOD's email id should not be the same");
        return false;
    }

    // Phone validation
    var Details= document.leave.Details.value.trim(); 
    if(Details.length==0){
        alert("Please enter phone number");
        return false;
    }else if(Details.length!=10 || isNaN(Details)){
        alert("Enter a valid 10 digit mobile number");
        return false;
    }

    return datevalidate(); // final check
}

function validateEmail(emailAdd){

    var splitted = emailAdd.match("^(.+)@(.+)$");
    if(!splitted) return false;
    var regexp_user=/^\"?[\w-_\.]*\"?$/;
    if(!splitted[1].match(regexp_user)) return false;
    var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
    if(!splitted[2].match(regexp_domain)){
        var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
        if(!splitted[2].match(regexp_ip)) return false;
    }
    return true;
}

function validateEmailHOD(HODemailAdd){
    return validateEmail(HODemailAdd); // same logic reused
}

function datevalidate(){
	//alert("datevalidate ");
    var date1=document.leave.FirstDayOfLeave.value;
    var date2=document.leave.DateOfReporting.value;

    var yy11=date1.substring(7,11);
    var yy22=date2.substring(7,11);
    var mm1=date1.substring(3,6);
    var mm2=date2.substring(3,6);
    var dd11=date1.substring(0,2);
    var dd22=date2.substring(0,2);

    var months={"Jan":1,"Feb":2,"Mar":3,"Apr":4,"May":5,"Jun":6,
                "Jul":7,"Aug":8,"Sep":9,"Oct":10,"Nov":11,"Dec":12};
    var mon1=months[mm1], mon2=months[mm2];

    // Convert to Date object for simplicity
    var d1=new Date(yy11,mon1-1,dd11);
    var d2=new Date(yy22,mon2-1,dd22);

    if(d1>d2){
        alert("First day of leave cannot be after Date of Reporting");
        return false;
    }
    return true;
}

function getTerms(){
    alert("Please enter your request for leave here. "+
          "Application does not automatically mean approval. "+
          "Provide detailed reason, get confirmation from HOD. "+
          "Sick leave requires medical certificate.");
}
</script>

 <%@ include file="footer.jsp" %>
 </body>
</html>