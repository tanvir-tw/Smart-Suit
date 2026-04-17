<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%!Connection conn;%>
<%
Connection conn = null;
Statement st1 = null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs=null;
String maddress="", mcity="",mcountry="",mstate="",mzip="", sql ="";
try {
	conn = connection.getConnect("db_GlobalERP");        
     st1=conn.createStatement();
     stmt1 = conn.createStatement();
     stmt2 = conn.createStatement();
     stmt3 = conn.createStatement();
     stmt4 = conn.createStatement();
     stmt5 = conn.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
} 

		String type1=request.getParameter("save");
		String type=request.getParameter("Type");
	        
	     if(type.equalsIgnoreCase("Customer")){
			sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+request.getParameter("companyname")+"' limit 1";
			rs= st.executeQuery(sql);
			if(rs.next())
	        {
	            maddress=rs.getString("BillingAddress");
	            mcity=rs.getString("BillingCity");
	            mcountry=rs.getString("BillingCountry");
	            mstate=rs.getString("BillingState");
	            mzip=rs.getString("BillingZip");
	            
	        }
		}else{
			sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+request.getParameter("companyname")+"' limit 1";
			rs= st.executeQuery(sql);
			if(rs.next())
	        {
	            maddress=rs.getString("address");
	            mcity=rs.getString("city");
	            mcountry=rs.getString("country");
	            mstate=rs.getString("state");
	            mzip=rs.getString("zip");
	            
	        }
		}
        System.out.println("customer query---->>"+sql);
%>
<%
if(type1!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Saved Successfully");
	</script>
	<%
}
String isclose=request.getParameter("isclose");
%>
<div class="container-fluid" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >
 <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		            <%
		            if(request.getParameter("Type").equals("Customer") )
					{%>
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Customer Name:-<%=request.getParameter("companyname") %></h5>
		          		
		          		<%}else{ %>
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Prospective Customer Name:-<%=request.getParameter("companyname") %></h5>
		    		<%} %>
		    		<h5 class="content-header-title text-center mt-2" style="color: #060637">Add Contact</h5>
		    		</div>
		             <br>
 <form action="AjaxSaveContact.jsp" method="post" name="contactdata" id="contactdata" onsubmit="return  validate();">
 <div class="card shadow-lg mb-3 rounded-3">
    <div class="card-body">   
    <input type="hidden" value="<%=isclose%>" name="isclose" />
				<input type="hidden" name="entryflag" value="ADD" />
				<input type="hidden" name="customercode" value="<%=request.getParameter("customercode") %>" />
				<input type="hidden" name="companyname" value="<%=request.getParameter("companyname") %>" />
				<input type="hidden" name="c_address" value="<%=maddress %>" />
				<input type="hidden" name="c_city" value="<%=mcity%>" />
				<input type="hidden" name="c_country" value="<%=mcountry%>" />
				<input type="hidden" name="c_state" value="<%=mstate%>" />
				<input type="hidden" name="c_zip" value="<%=mzip%>" />
				<input type="hidden" name="currentrow" value="0" />

      <div class="row col-12 mt-3">
        <div class="col-3">
         <div class="input-container">
          <label for="PI_source" class="tcolor">Contact Person</label>
            <select class="form-select" id="salutation" name="salutation" required>
             		<option value='Mr.'>Mr.</option>
					<option value='Mrs.'>Mrs.</option>
					<option value='Ms.'>Ms.</option>
            </select>
            
          </div>
          </div>
		 <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="firstname" name="firstname" placeholder="" required>
          		<label for="companyNames" class="floating-label">First Name</label>
        	</div>  
      	</div>
      	 <div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="middlename" name="middlename" placeholder="" required>
          		<label for="companyNames" class="floating-label">Middle Name</label>
        	</div>  
      	</div>
      	<div class="col-3 mt-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="lastname" name="lastname" placeholder="" required>
          		<label for="companyNames" class="floating-label">Last Name</label>
        	</div>  
      	</div>
      </div>
		
	 <div class="row col-12 mt-3">	
	 	<div class="col-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="designation" name="designation" placeholder="">
          		<label for="companyNames" class="floating-label">Designation</label>
        	</div>  
      	</div>
      	<div class="col-4">
        	<div class="input-container">
          		<textarea class="form-control floating-input" id="address" name="address" rows="1"></textarea>
           		<label for="reason" class="floating-label">Address</label>
        	</div>
      	</div>
      	<div class="col-4">
        <div class="input-container"> 
        <a href="#" onclick="addresspaste()" style="text-decoration: none; font-weight: bold; font-size: 12px">Copy Company Address</a>
        </div>
      </div>
	 </div>
	 <div class="row col-12 mt-3">	
	 <div class="col-3">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="city" name="city" placeholder="">
          		<label for="companyNames" class="floating-label">City</label>
        	</div>  
     </div>
     <div class="col-3">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="zipcode" name="zipcode" placeholder="">
          		<label for="companyNames" class="floating-label">Zip Code</label>
        	</div>  
     </div>
     <div class="col-3">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="state" name="state" placeholder="">
          		<label for="companyNames" class="floating-label">State</label>
        	</div>  
     </div>
     <div class="col-3">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="country" name="country" placeholder="">
          		<label for="companyNames" class="floating-label">Country</label>
        	</div>  
     </div>
	</div>
	<div class="row col-12 mt-3">
	<div class="col-3">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="emailids" name="emailids" placeholder="" onchange="mob4();" >
          		<label for="companyNames" class="floating-label">Email Ids</label>
        	</div>  
     </div>
	<div class="col-1">
	<a href="#" style="font-weight: bold; color: blue; " id="f5" onclick="getClient4('+')"><font   size="3" >(+)</font></a>
	</div>
		<div class="col-3">
        	<div class="input-container">
				<input class="form-control floating-input" type="text" id="emailids1" name="emailids1"  style="display: none;" onchange="mob5();" />
			</div>
		</div>
		<div class="col-1">
				<a href="#" style="font-weight: bold; color: blue;display: none " id="f6" onclick="getClient5('+')"><font   size="3" >(+)</font></a>
				<a href="#" style="font-weight: bold; color: blue;display: none " id="f7" onclick="getClient5('-')"><font  size="3" >(-)</font></a>
		</div>		
		<div class="col-3">
        	<div class="input-container">
				<input class="form-control floating-input" type="text" id="emailids2" name="emailids2"  style="display: none;" onchange="mob6();" />
        	</div>  
     	</div>
     	<div class="col-1">
     	<a href="#" style="font-weight: bold; color: blue;display: none " id="f8" onclick="getClient6('-')"><font  size="3" >(-)</font></a>
     	</div>
	 </div>
	 
	 <div class="row col-12 mt-3">	
	 <div class="col-3">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="mobileno" name="mobileno" placeholder="" onchange="mob1();" required>
          		<label for="companyNames" class="floating-label">Mobile Number</label>
        	</div>  
     </div>
	 
	 	<div class="col-1">
				<a href="#" style="font-weight: bold; color: blue; " id="f1" onclick="getClient1('+')"><font   size="3" >(+)</font></a>
		</div>
	<div class="col-3">
       <div class="input-container">
				<input type="text" class="form-control floating-input" id="mobileno1" name="mobileno1" id="mobileno1" style="display: none;" onchange="mob2();" />
		</div>
	</div>
	<div class="col-1">
			<a href="#" style="font-weight: bold; color: blue;display: none " id="f2" onclick="getClient2('+')"><font  size="3" >(+)</font></a>
			<a href="#" style="font-weight: bold; color: blue;display: none " id="f3" onclick="getClient2('-')"><font  size="3" >(-)</font></a>	
	</div>
	<div class="col-3">
        	<div class="input-container">
				<input type="text" class="form-control floating-input" id="mobileno2" name="mobileno2" id="mobileno2" style="display: none;" onchange="mob3();" />
        	</div>  
     </div>
     <div class="col-1">
     <a href="#" style="font-weight: bold; color: blue;display: none " id="f4" onclick="getClient3('-')"><font  size="3" >(-)</font></a>
     </div>
	</div>
	
	 <div class="row col-12 mt-3">	
	 	<div class="col-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="phoneno" name="phoneno" placeholder="">
          		<label for="companyNames" class="floating-label">Phone Number</label>
        	</div>  
      	</div>
      	<div class="col-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="alternetno" name="alternetno" placeholder="">
          		<label for="companyNames" class="floating-label">Alternate Number</label>
        	</div>  
      	</div>
      	<div class="col-4">
        	<div class="input-container">
       			<input class="form-control floating-input" type="text" id="faxno" name="faxno" placeholder="">
          		<label for="companyNames" class="floating-label">Fax Number</label>
        	</div>  
      	</div>
     </div>
	 <input type="hidden" name="CustOfType" value="<%=request.getParameter("Type")%>" />				
				<%System.out.println("type ::::::::::::::::::::::::::;"+request.getParameter("Type")); %>
	<div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button  id="submit" name="submit" class="btn" type="submit">Submit</button>
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
function validate()
{
	var phno=document.getElementById("mobileno").value;
	var fname=document.getElementById("firstname").value;
	var lname=document.getElementById("lastname").value;
	var mname=document.getElementById("middlename").value;
	var desig=document.getElementById("designation").value;
	var city=document.getElementById("city").value;
	var zipcode=document.getElementById("zipcode").value;
	var state=document.getElementById("state").value;
	var country=document.getElementById("country").value;
	var email=document.getElementById("emailids").value;
	var email1=document.getElementById("emailids1").value;
	var email2=document.getElementById("emailids2").value;
	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
	var phoneno=document.getElementById("phoneno").value;
	var alternetno=document.getElementById("alternetno").value;
	var faxno=document.getElementById("faxno").value;
	var letter = /^[A-Za-z]+$/;
	var letter1 = /^[A-Za-z -]+$/;
if(fname=="")
{
	alert("Please enter contact person name");

	return false;
}
if(lname=="")
{
	alert("Please enter contact person name");

	return false;
}

 if(!(fname.match(letter)) && fname.length!=0)  
 {  
    alert('Please enter characters value for Contact Person');  
 return false;  
 } 
 if(!(lname.match(letter)) && lname.length!=0)  
 {  
    alert('Please enter characters value for Contact Person');  
 return false;  
 } 
 if(!mname == "")
 {
	 if(!(mname.match(letter)) && mname.length!=0)  
	 {  
	    alert('Please enter characters value for Contact Person');  
	 return false;  
	 } 
 }
 if(!(desig.match(letter1)) && desig.length!=0)  
 {  
    alert('Please enter characters value for Designation');  
 return false;  
 } 
 if(!(city.match(letter)) && city.length!=0)  
 {  
    alert('Please enter characters value for City');  
 return false;  
 } 

 if(isNaN(zipcode))
	{
		alert("Please enter numeric value for Zipcode");
		//document.getElementById("zipcode").value="";
		return false;
	}
 
 
 if(!(state.match(letter)) && state.length!=0)  
 {  
    alert('Please enter characters value for State');  
 return false;  
 } 
 if(!(country.match(letter)) && country.length!=0)  
 {  
    alert('Please enter characters value for Country');  
 return false;  
 } 
try{
var sss=validateEmail(email);
if(!sss)
	{
		alert("Please enter valid Email Id");
		return false;
	} 

}catch(e)
{
}
	if(!(phno ==0))
	{
		
		 if(isNaN(phno))
			{
				alert("Please enter numeric value for mobile number");
				document.getElementById("mobileno").value="";
				return false;
			}
		
			 if((phno.trim().length < 10)  || (phno.trim().length >15))
				 {
			        alert("Mobile no should be greater than 10 digits and less than 15 digits"); 
	        return false;
	    }
	}
	else
	{
		phno="";
		
		alert("Please enter mobile number");
	    return false;	
	}
	var phno1=document.getElementById("mobileno1").value;
	//alert(phno);
	if(!(phno1 ==0))
	{
		
		 if(isNaN(phno1))
			{
				alert("Please enter numeric value for mobile number");
				document.getElementById("mobileno1").value="";
				return false;
			}
		
			 if((phno1.trim().length < 10)  || (phno1.trim().length >15))
				 {
	        alert("Mobile no should be greater than 10 digits and less than 15 digits"); 
	        return false;
	    }
	}


	
			 var phno2=document.getElementById("mobileno2").value;
				//alert(phno);
				if(!(phno2 ==0))
				{
					
					 if(isNaN(phno2))
						{
							alert("Please enter numeric value for mobile number");
							document.getElementById("mobileno2").value="";
							return false;
						}
					
						 if((phno2.trim().length < 10)  || (phno2.trim().length >15))
							 {
						        alert("Mobile no should be greater than 10 digits and less than 15 digits"); 
				        return false;
				    }
}		
if(!(phoneno==0)){
				 if(isNaN(phoneno))
					{
						alert("Please enter numeric value for phone number");
						return false;
					}
				 if((phoneno.trim().length < 10)  || (phoneno.trim().length >15))
				 {
			        alert("Phone no should be greater than 10 digits and less than 15 digits"); 
	        return false;
	    }}
					 if(isNaN(alternetno))
					{
						alert("Please enter numeric value for alternate number");
						return false;
					}

				 if(isNaN(faxno))
					{
						alert("Please enter numeric value for fax number");
						return false;
					}
	}

function validateEmail(email)
{
	if(email.trim()==""){
	      return true;		
	}
	else{
     var splitted = email.match("^(.+)@(.+)$");
     if(splitted == null) return false;
     
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
	    var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
	    if(splitted[2].match(regexp_ip) == null) return false;
      }
      return true;
    }

	
return false;
	}
}

function addresspaste()
{
	document.contactdata.address.value=document.contactdata.c_address.value;
    document.contactdata.city.value=document.contactdata.c_city.value;
    document.contactdata.state.value=document.contactdata.c_state.value;
    document.contactdata.zipcode.value=document.contactdata.c_zip.value;
    document.contactdata.country.value=document.contactdata.c_country.value;
}
function cancelentryform()
{
	document.contactdata.action ="home.jsp";
    document.forms["contactdata"].submit();
}

function getClient1(id)
{ 
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno1").style.display='';
	document.getElementById("f2").style.display="";
	document.getElementById("f3").style.display="";
	
    }
}
function getClient2(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno2").style.display='';
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f4").style.display="";
	
	
    }
	else{
		document.getElementById("f1").style.display="";
		document.getElementById("mobileno1").style.display='none';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
    }
   }

function getClient3(id)
{ 
	if(id=="-")
    {
	document.getElementById("mobileno2").style.display='none';
	document.getElementById("f2").style.display="";
	document.getElementById("f3").style.display="";
	document.getElementById("f4").style.display='none';
	
    }
}

function getClient4(id)
{ 
	if(id=="+")
    {
	document.getElementById("f5").style.display='none';
	document.getElementById("emailids1").style.display='';
	document.getElementById("f6").style.display="";
	document.getElementById("f7").style.display="";
	
    }
}
function getClient5(id)
    {
	if(id=="+")
    {
	document.getElementById("f5").style.display='none';
	document.getElementById("emailids2").style.display='';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display='none';
	document.getElementById("f8").style.display="";
	
	
    }
	else{
		document.getElementById("f5").style.display="";
		document.getElementById("emailids1").style.display='none';
		document.getElementById("f6").style.display='none';
		document.getElementById("f7").style.display='none';
    }
  }

function getClient6(id)
{ 
	if(id=="-")
    {
	document.getElementById("emailids2").style.display='none';
	document.getElementById("f6").style.display="";
	document.getElementById("f7").style.display="";
	document.getElementById("f8").style.display='none';
    }
}

function mob1()
{
	var phno=document.getElementById("mobileno").value;
	if(!(phno ==0))
	{
		 if(isNaN(phno))
			{
				alert("Please enter numeric value for mobile number");
				document.getElementById("mobileno").value="";
				return false;
			}
		
			 if((phno.trim().length < 10)  || (phno.trim().length >15))
				 {
			        alert("Mobile no should be greater than 10 digits and less than 15 digits"); 
			        //document.getElementById("mobileno").value="";
	        return false;
	    }
	}
	else
	{
		phno="";
		alert("Please enter mobile number");
	    return false;	
	}
}
function mob2()
{
	var phno=document.getElementById("mobileno1").value;
	
	if(!(phno ==0))
	{
		 if(isNaN(phno))
			{
				alert("Please enter numeric value for mobile number");
				document.getElementById("mobileno1").value="";
				
				return false;
			}
		
			 if((phno.trim().length < 10)  || (phno.trim().length >15))
				 {
			        alert("Mobile no should be greater than 10 digits and less than 15 digits"); 
	        return false;
	    }
	}
}
function mob3()
{
	var phno=document.getElementById("mobileno2").value;
	
	if(!(phno ==0))
	{
		 if(isNaN(phno))
			{
				alert("Please enter numeric value for mobile number");
				document.getElementById("mobileno2").value="";
				
				return false;
			}
		
			 if((phno.trim().length < 10)  || (phno.trim().length >15))
				 {
			        alert("Mobile no should be greater than 10 digits and less than 15 digits"); 
	        return false;
	    }
	}
}

function mob4()
{
	var email=document.getElementById("emailids").value;
	var sss=validateEmail(email);
	if(!sss)
		{
			alert("Please enter valid Email Id");
			return false;
		} 
}

function mob5()
{
var email=document.getElementById("emailids1").value;
	
var sss=validateEmail(email);
if(!sss)
	{
		alert("Please enter valid Email Id");
		document.getElementById("emailids1").value="";
		
		return false;
	} 
}
function mob6()
{
var email=document.getElementById("emailids2").value;
	
var sss=validateEmail(email);
if(!sss)
	{
		alert("Please enter valid Email Id");
		document.getElementById("emailids2").value="";
		
		return false;
	} 
}

function getContactInfo(fname)
{
	var total='stotal';
	window.open('showComplaintDetails.jsp?fname='+fname+'&lname='+lname+'&status='+total+'&email='+email+'','mywindow','width=1000, height=850, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	
}
</script>
<%@ include file="footer.jsp" %>
</body>
</html> 