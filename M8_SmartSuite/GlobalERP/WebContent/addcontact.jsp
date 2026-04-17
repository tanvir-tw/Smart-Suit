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
Statement st1 = null;

String maddress="",mcity="",mcountry="",mstate="",mzip="", sql="",CompName="",type12="",Code="", comptype="";

try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 


String isclose=request.getParameter("isclose");
	String company= request.getParameter("companyname");
	company=company.replace("...","&");  
	String customercode=request.getParameter("customercode");
%>

<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Contact Details For <%= company%></h5>
		    		</div>
		             <br>
<form name="userform" action="addcontactinsert.jsp" method="post" onsubmit="return formValidation();">
<% 
   String sql1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+company+"'";
   ResultSet rs3=st1.executeQuery(sql1);
   while(rs3.next())
   {
   	CompName = rs3.getString("CompanyName");
   	type12 = rs3.getString("SalesCustomerCode");
   	Code= rs3.getString("CustomerCode");
   }
   if(type12.equals("0") || type12=="0")
   {
   	  comptype ="Prospect";
   }
   else	
   {
   	   comptype ="Customer";
   }
   if( comptype.equals("Customer"))
   {
	   sql="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+company+"' and Customercode='"+customercode+"' order by CustomerCode desc limit 1";
		ResultSet rs= st.executeQuery(sql);
		if(rs.next())
      {
          maddress=rs.getString("BillingAddress");
          mcity=rs.getString("BillingCity");
          mcountry=rs.getString("BillingCountry");
          mstate=rs.getString("BillingState");
          mzip=rs.getString("BillingZip");
          CompName = rs.getString("CompanyName");
          Code= rs.getString("CustomerCode");
       }
	}else{
		sql="SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName like '"+company+"'  and Customercode='"+customercode+"' order by CustomerCode desc limit 1";
	ResultSet rs= st.executeQuery(sql);
		if(rs.next())
       {
           maddress=rs.getString("address");
           mcity=rs.getString("city");
           mcountry=rs.getString("country");
           mstate=rs.getString("state");
           mzip=rs.getString("zip");
           CompName = rs.getString("CompanyName");
        	Code= rs.getString("CustomerCode");         
       }
	}   
   System.out.println(sql);
  
%>

 <div class="card shadow-lg mb-4 rounded-3">

  <div class="card-body">
    <div class="row">	
      <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_1" name="element_3_1" placeholder="" value="" required>
          <label for="comp_name" class="floating-label">Contact Person</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_2" name="element_3_2" placeholder=""  value="" onblur="chk();"  >
          <label for="comp_name" class="floating-label">Designation</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <textarea class="form-control floating-input" id="element_3_3" name="element_3_3" rows="1" required></textarea>
          <label for="comp_name" class="floating-label">Address</label>
        </div>
      </div>
       <div class="col-3">
        <div class="input-container"> 
        <a href="#" onclick="addresspaste()" style="text-decoration: none; font-weight: bold; font-size: 12px">Copy Company Address</a>
        </div>
      </div>
   </div>
  <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_4" name="element_3_4" placeholder="" value="">
          <label for="comp_name" class="floating-label">Country</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_5" name="element_3_5" placeholder="" value="">
          <label for="comp_name" class="floating-label">State</label>
        </div>
      </div>      
      <div class="col-3">
        <div class="input-container">
           <input class="form-control floating-input" type="text" id="element_3_6" name="element_3_6" placeholder="" value="">
          <label for="comp_name" class="floating-label">City</label>
        </div>
      </div> 
       <div class="col-3">
       <div class="input-container">
           <input class="form-control floating-input" type="text" id="element_3_7" name="element_3_7" placeholder="" value="">
          <label for="comp_name" class="floating-label">Zip Code</label>
        </div>
      </div>     
  </div>
  <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_8" name="element_3_8" placeholder="" value="" required>
          <label for="comp_name" class="floating-label">Email1</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_9" name="element_3_9" placeholder="" value="" required>
          <label for="comp_name" class="floating-label">Phone Number</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_12" name="element_3_12" placeholder="" value="" >
          <label for="comp_name" class="floating-label">Email2</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_13" name="element_3_13" placeholder="" value="" >
          <label for="comp_name" class="floating-label">Email3</label>
        </div>
      </div>
  </div>
   <div class="row col-12 mt-3"> 
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_10" name="element_3_10" placeholder="" value="">
          <label for="comp_name" class="floating-label">Mobile Number1</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_11" name="element_3_11" placeholder="" value="">
          <label for="comp_name" class="floating-label">Fax Number</label>
        </div>
      </div>
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_14" name="element_3_14" placeholder="" value="">
          <label for="comp_name" class="floating-label">Mobile Number2</label>
        </div>
      </div>
      
      <div class="col-3">
        <div class="input-container">
          <input class="form-control floating-input" type="text" id="element_3_15" name="element_3_15" placeholder="" value="">
          <label for="comp_name" class="floating-label">Mobile Number3</label>
        </div>
      </div>
      
  </div>
    <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button id="saveForm" name="submit" class="btn" type="submit">Submit</button>
    </div>
      
      
				<input type="hidden" name="entryflag" value="ADD" />
				<input type="hidden" name="customercode" value="<%=Code%>" />
				<input type="hidden" name="companyname" value="<%=CompName%>" />
				<input type="hidden" name="Type" value="<%=comptype%>" />
				<input type="hidden" name="c_address" value="<%=maddress %>" />
				<input type="hidden" name="c_city" value="<%=mcity%>" />
				<input type="hidden" name="c_country" value="<%=mcountry%>" />
				<input type="hidden" name="c_state" value="<%=mstate%>" />
				<input type="hidden" name="c_zip" value="<%=mzip%>" />
				<input type="hidden" name="currentrow" value="0" />
				<input type="hidden" name="CustOfType" value="<%=comptype%>" />
				<input type="hidden" name="comcode" value="<%=session.getAttribute("CompanyMasterID").toString()%>" />
				<input type="hidden" value="<%=isclose%>" name="isclose" />

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

function chk()
{
var data=document.getElementById("element_3_2").value;
var invalid=/^[a-zA-Z]+[\s.@-]*[a-zA-Z\s.@-]+[a-zA-Z]+$/;
if(!invalid.test(data))
	{
	alert("Please Enter valid Entry");
	return false;
	}
}
</script>
<script>
function formValidation()
{
var displaylabel="";
var displaycount="";
var count3="";
if((element_3_1.value==0))
	{
	displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
	displaycount+='1,';
	}
if((element_3_3.value==0))
{
    displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
    displaycount+='3,';
}else{
	count3+='3,';
}
if((element_3_8.value==0))
{
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='8,';
}
// Mandatorytransworld
// alphatransworld
if(!(element_3_1.value==0))
{ 
var letters = /^[A-Za-z . /]+$/;
if(element_3_1.value.match(letters))
{
count3+='1,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='1,';
}
}if(!(element_3_2.value==0))
{ 
var letters = /^[a-zA-Z]+[\s.@-]*[a-zA-Z\s.@-]+[a-zA-Z]+$/;
if(element_3_2.value.match(letters))
{
count3+='2,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='2,';
}
}if(!(element_3_4.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_4.value.match(letters))
{
count3+='4,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='4,';
}
}if(!(element_3_5.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_5.value.match(letters))
{
count3+='5,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='5,';
}
}if(!(element_3_6.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_6.value.match(letters))
{
count3+='6,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='6,';
}
}// charactertransworld
if(!(element_3_7.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_7.value.match(numbers))
{
count3+='7,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='7,';
}
}if(!(element_3_9.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_9.value.match(numbers))
{
count3+='9,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='9,';
}
}if(!(element_3_10.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_10.value.match(numbers))
{
count3+='10,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='10,';
}
}


if(!(element_3_14.value==0))
{
var numbers1 = /^[0-9]+$/;
if(element_3_14.value.match(numbers1))
{
count3+='14,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='14,';
}
}

if(!(element_3_15.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_15.value.match(numbers))
{
count3+='15,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='15,';
}
}


if(!(element_3_11.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_11.value.match(numbers))
{
count3+='11,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='11,';
}
}// numbertransworld
if(!(element_3_8.value==0))
{ 
var mailformat = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,3}$/;
if(element_3_8.value.match(mailformat))
{
count3+='8,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Correct Email-Id</font>,';
displaycount+='8,';
}
}// emailtransworld

if(!(element_3_12.value==0))
{ 
var mailformat1 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,3}$/;
if(element_3_12.value.match(mailformat1))
{
count3+='12,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Correct Email-Id</font>,';
displaycount+='12,';
}
}// emailtransworld


if(!(element_3_13.value==0))
{ 
var mailformat2 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,3}$/;
if(element_3_13.value.match(mailformat2))
{
count3+='13,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Correct Email-Id</font>,';
displaycount+='13,';
}
}// emailtransworld

if(displaylabel == ""){
return true;
}

else{
var displaylabelres = displaylabel.split(",");
var res1=displaycount.split(",");
var res2=count3.split(",");
var i;
var j;

for(j=0; j < res2.length-1; j++){
 document.getElementById("element_error_"+ res2[j]).style.display='none';
 }
 
for (i = 0; i < displaylabelres.length-1; i++) {
    var element_error_="element_error_"+i;
    var number=i;
    document.getElementById("element_error_"+ res1[i]).style.display="";
    document.getElementById("element_error_"+ res1[i]).innerHTML=displaylabelres[i];
} 

 return false;
}
}

function addresspaste()
{
	document.userform.element_3_3.value=document.userform.c_address.value;
    document.userform.element_3_6.value=document.userform.c_city.value;
    document.userform.element_3_5.value=document.userform.c_state.value;
    document.userform.element_3_7.value=document.userform.c_zip.value;
    document.userform.element_3_4.value=document.userform.c_country.value;
}
</script>
<%@ include file="footer.jsp" %>
</body>
</html>