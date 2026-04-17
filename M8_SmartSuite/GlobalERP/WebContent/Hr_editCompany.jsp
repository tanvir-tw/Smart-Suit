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
	String companyCode;
  	String cmpCode= "";
  	String qry=""; 
//replace st with stmt
Connection conn = null;
Statement stmt=null,st1=null, st2=null,st3=null,st4=null;
try {

	conn = connection.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+conn);
	stmt = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
} catch (Exception e) {
   e.printStackTrace();
} 
%>
<%
Date today = new Date();
String date=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
cmpCode= request.getParameter("cmpCode");
System.out.println("cmpCode"+cmpCode);


%>
<%
qry = "select * from t_ourcompanydet where CompanyCode='"+cmpCode+"'";

System.out.println("CompanyCode================"+qry);
ResultSet rs = stmt.executeQuery(qry);
while(rs.next())
{
  %>
 
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 900px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Company Form</h5>
		    		</div>
		             <br>
 
	<form action="EditDeptData.jsp?action=Companyedit&cmpCode=<%=cmpCode %>" method="post" name="data">
	<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
    <div class="row">
      <div class="row col-12 mt-3"> 
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="compName" id="compName" value="<%=rs.getString("OurCompanyName")%>" placeholder="" required>
          <label for="compName" class="floating-label">Company Name</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="phNo" id="phNo" value="<%=rs.getString("PhoneNo") %>" placeholder="" required>
          <label for="phNo" class="floating-label">Phone Number</label>
        </div>
      </div>

         <div class="col-4 mt-4">
        	<div class="input-container">
          <textarea class="form-control floating-input" name="compAdd" id="compAdd" rows="1"></textarea>
           <label for="compAdd" class="floating-label">Company Address</label>
        	</div>
      </div>
  </div>    
</div>
<div class="row">
      <div class="row col-12 mt-3"> 
        <div class="col-4 mt-4">
        	<div class="input-container">
          <textarea class="form-control floating-input" name="compGdAdd" id="compGdAdd" rows="1"></textarea>
           <label for="compGdAdd" class="floating-label">Company Godown Address</label>
        	</div>
      </div>
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="compBstno" id="compBstno"	value="<%=rs.getString("OurCompanyBSTNo") %>" placeholder="" required>
          <label for="compBstno" class="floating-label">Company BST No</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="compCstno" id="compCstno"	value="<%=rs.getString("OurCompanyCSTNo") %>" placeholder="" required>
          <label for="compCstno" class="floating-label">Company CST No</label>
        </div>
      </div>

       
  </div>    
</div>
<div class="row">
      <div class="row col-12 mt-3"> 
        <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="pNo" id="pNo"	value="<%=rs.getString("PanNo") %>" placeholder="" required>
          <label for="pNo" class="floating-label">Pan Number</label>
        </div>
      </div>
           <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="faxNo" id="faxNo" value="<%=rs.getString("FaxNo") %>" placeholder="" required>
          <label for="faxNo" class="floating-label">Fax Number</label>
        </div>
      </div>

      <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text"  name="email" id="email" value="<%=rs.getString("Email") %>" placeholder="" required>
          <label for="email" class="floating-label">Email</label>
        </div>
      </div>

       
  </div>    
</div>
<div class="row">
      <div class="row col-12 mt-3"> 
        <div class="col-4 mt-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" name="website" id="website" value="<%=rs.getString("Website") %>" placeholder="" required>
          <label for="website" class="floating-label">Website</label>
        </div>
      </div>
      </div>
      </div>


<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn"   id="submit1" value="Update" onclick="return validate();">Update</button>
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

	<%} %>
</div>
</div>
</div>
</div>
</section>
</div>
</div>
<%} %>
<script LANGUAGE="JavaScript" type="text/javascript">


function validate()
{//alert("call");
	var compName = document.getElementById("compName").value;
	var compAdd= document.getElementById("compAdd").value;
	var compGdAdd = document.getElementById("compGdAdd").value;
	var phNo = document.getElementById("phNo").value;
	var faxNo = document.getElementById("faxNo").value;
	var pNo = document.getElementById("pNo").value;
	var email = document.getElementById("email").value;
	var compBstNO =document.getElementById("compBstno").value;
	
	var compCstNO= document.getElementById("compCstno").value;
	var website= document.getElementById("website").value;
	var letters = /^[A-Za-z 1-9 ]+$/;  
	
	compAdd=compAdd.replace(/\s/g,"");
	compGdAdd=compGdAdd.replace(/\s/g,"");
	compName=compName.replace(/\s/g,"");
	phNo=phNo.replace(/\s/g,"");
	faxNo=faxNo.replace(/\s/g,"");
	pNo=pNo.replace(/\s/g,"");
	email=email.replace(/\s/g,"");
	compBstNO=compBstNO.replace(/\s/g,"");
	compCstNO=compCstNO.replace(/\s/g,"");
	website=website.replace(/\s/g,"");
	
	if(compName.length==0)
	{
		alert("Please Enter the Company Name");
		return false;
	}
	
	if(!isNaN(compName))
	{
	
	alert("Invalid name");
	return false;
	}
	
	if(phNo.length==0)
	{
		alert("Please Enter Phone Number");
		return false;
	}
	
	if(isNaN(phNo))
	{
	alert("Enter the Valid Phone Number");
	return false;
	}

	 if (phNo.length<10 || phNo.length>=14)
    {
		alert("The Phone number should be atleast 10 digit and maximum 13 digit ");
    return false;   
  }	 

	
	if(compAdd.length==0)
	{   
		alert("Please Enter the Company Address");
		return false;
    }
	
	if(compGdAdd.length==0)
	{
		alert("Please Enter the Company Godown Address");
		return false;
	}
	
	if(compBstNO.length==0)
	{
		alert("Please Enter the Company BST No.");
		return false;
	}
	
	if(isNaN(compBstNO))
		{
		
		alert("Enter Numaric Value for BSTNO Number");
		return false;
		}
	
	if (compBstNO.length>=11 )
    {
		alert("BST number's maximum limit is 10 Digit ");
    return false;   
  }	 
	
	if(compCstNO.length==0)
	{
		alert("Please Enter the Company CST NO.");
		return false;
	}
	
	if(isNaN(compCstNO))
	{
		alert("Enter Numaric Value for CSTNO Number.");
		return false;
	}
	
	if (compCstNO.length>=11 )
    {
		alert("CST number's maximum limit is 10 Digit ");
    return false;   
  }	 
	
/* 	if(pNo.length==0)
	{
		alert("Please Enter the Pan Number");
		return false;
	}
	var letters1=letters.test(pNo);
    if(letters1==false)
     {     
        alert('Pan Cord No must have characters & Number only');    
       return false;  
      }  
	if(pNo.length>=10)
	{
		alert("PAN no should not be more than 10 digit");
		return false;
	} */
	var panPattern = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;

	if(pNo.length == 0)
	{
	    alert("Please Enter the PAN Number");
	    return false;
	}

	pNo = pNo.toUpperCase();

	if(!panPattern.test(pNo))
	{
	    alert("Invalid PAN Number. Format should be like ABCDE1234F");
	    return false;
	}
		 
	if(faxNo.length==0)
	{
		alert("Please Enter the Fax Number");
		return false;
	}
	if(isNaN(faxNo))
	{
	alert("Please Enter the valid Fax number");
	return false;
	}

	 if (faxNo.length< 10 || faxNo.length>=14)
	    {
			alert("The Fax number should be atleast 10 digit and maximum 13 digit ");
	    return false;   
	  }	 
	
	
	if(email.length==0)
	{
		alert("Please Enter the Email ID");
		return false;
	}
	else
	{
		// var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-]{1,3})+\.)+([a-zA-Z0-9]{2,4})+$/;
		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		    if (!filter.test(email)) {
		    alert('Please provide a valid email ID');
		    email.focus;
		    return false;
	} 
	}
	if(website.length==0)
	{
		alert("Please Enter the Website");
		return false;
	}
	else
	{
		var url=is_valid_url(website);
		if(!url)
			{
			   alert("Please Enter valid website URL");
			   return false;
			}
	}
	
	return true;
}


function is_valid_url(url)
{   return url.match(/^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/);
    
}

</script>
<%@ include file="footer.jsp" %>
</body>
</html>