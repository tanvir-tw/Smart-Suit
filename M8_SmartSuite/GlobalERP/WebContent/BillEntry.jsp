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
String sql="";
String refno=request.getParameter("refno");
%>
	<%
	String datex1 ="";
 	String twEmp = session.getAttribute("leaveempID").toString();
	String monthFirstDate = session.getAttribute("PresentMonthFirst").toString(); 
	datex1 = monthFirstDate;

%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 800px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Bill Entry Form</h5>
		    		</div>
		             <br>
	<form name="billentry" method="get" action="">
<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
      <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="inwardno" id="inwardno" value="<%=refno %>" placeholder="" >
          <label for="inwardno" class="floating-label">Inward No</label>
        </div>
      </div>
     <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="amount" id="amount" placeholder="" >
          <label for="amount" class="floating-label">Paid Amount</label>
        </div>
      </div>
     <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="paidby" id="paidby" placeholder="" >
          <label for="paidby" class="floating-label">Paid By</label>
        </div>
      </div>

      </div>
      </div>
      <div class="row">
      <div class="row col-12 mt-3">   
           <div class="col-4 mt-4">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="checkno" id="checkno" placeholder="" >
          <label for="checkno" class="floating-label">Check/Bill No</label>
        </div>
      </div>  
       <div class="col-4 mt-4">
         <div class="input-container">
                <input class="form-control floating-input" type="text" id="dop" name="dop" value="<%=datex1%>" placeholder="" required>
                <label for="dop" class="floating-label">Date Of Payment</label>
               <script type="text/javascript">
						    Calendar.setup( {
							inputField : "dop", // ID of the input fieldom
							ifFormat : "%d-%b-%Y", // the date format
							button : "dop",
							 
								 // ID of the button
					    	});
					    </script>
            </div>
        </div>
      </div>
      </div>
       <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" type="submit" id="Submit" value="Submit" onclick="validate();">Submit</button>
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
<script LANGUAGE="JavaScript" type="text/javascript">
function validate()
{
	var refno = document.getElementById("inwardno").value;
	var amount = document.getElementById("amount").value;
	var checkno = document.getElementById("checkno").value;
	var paidby = document.getElementById("paidby").value;
	var dop = document.getElementById("dop").value;

	if(refno==""||refno==null)
	{
		alert("Please Enter Inward No ");
		return false;
	}
	if(amount=="")
	{
		alert("Please Enter Paid Amount ");
		return false;
	}
	if(isNaN(amount))
	{
	alert("Enter the Valid Paid Amount");
	return false;
	}
	if(checkno=="")
	{
		alert("Please Enter Check/Bill No ");
		return false;
	}
	if(paidby=="")
	{
		alert("Please Enter Check/Bill No ");
		return false;
	}
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
	//alert("function is not ready ready");
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		//alert("function ready");
		if(ajaxRequest.readyState == 4)
		{
			//alert("ready state is 4");
			var reslt=ajaxRequest.responseText;
			//alert(">>>    "+reslt);
			var data=reslt.trim();
			//alert("<*****  "+data);
			if(data="Yes")
			{
                    alert("Bill Data Save Successfully");					 
					window.opener.location.reload();
					
					 setTimeout('self.close()',5);              
            }
			else if(data = "No")
			{
					 alert("Bill Data Not Save Successfully");
			}
		}
	}	
	var queryString = "?refno="+refno+"&amount="+amount+"&checkno="+checkno+"&paidby="+paidby+"&dop="+dop;
	ajaxRequest.open("GET", "insertbillentry.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
</script>      
<%@ include file="footer.jsp" %>
</body>
</html>