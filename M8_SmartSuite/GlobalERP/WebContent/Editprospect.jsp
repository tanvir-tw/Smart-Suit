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
        a {
            cursor: pointer;
            margin: 10px;
        }
    </style>
</head>
 <body style="background-color:azure;">
 
 <%
Connection con = null;
Statement st1=null,st2=null,st3=null;

String CompanyMasterID = session.getAttribute("CompanyMasterID").toString();
String companyName = request.getParameter("companyName");
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;


try {
	con = connection.getConnect("db_GlobalERP");       
  
	    st1=con.createStatement();
	    st2=con.createStatement();
	    st3=con.createStatement();

} catch (Exception e) {
   e.printStackTrace();
}
%>
<%
String Companyname = "";
	try{
	
	String sql="SELECT * FROM db_GlobalERP."+CompanyMasterID+"prospectivecustmaster where CustomerCode ='"+companyName.replaceAll("~~","&")+"' limit 1 ";
	System.out.println("CHANGED QUERY   "+sql);	
	ResultSet rs1 = st3.executeQuery(sql);
		 	rs1.next();
		 	
		 	Companyname = rs1.getString("CompanyName");
%>
<div class="container-fluid mt-2" id="main">
<div class= "container">
<section class="container" style="max-width: 1000px;" id="basic--layouts" >

    <div class="row">
        <div class="col-md-12 col-12">
            <div class="card" style="background-color: transparent;">
                <div class="card-body">
		            <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637"><b>Edit Prospect :-</b><%=Companyname %></h5>
		    		</div>
		             <br>
	<form name="editCustomer" method="post" action="addCustomer.jsp?update=true&companyName=<%=request.getParameter("companyName").replaceAll("~~","&") %>" onsubmit="return validation();"> 

<div class="card shadow-lg mb-4 rounded-3">
  <div class="card-body">
      <div class="row col-12 mt-4"> 
      <div class="col-3 mt-4">
        <div class="input-container">
          <textarea class="form-control floating-input" id="reason" name="reason" rows="1"></textarea>
           <label for="reason" class="floating-label">Reason For Update</label>
          <label for="reason1" style="display: none;" class="floating-label">Reason For Update</label>
        </div>
      </div>
      
      <div class="col-3 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="assigned" name="assigned" value="<%=rs1.getString("Assighnedby") %>"  placeholder="" readonly>
          	<label for="assigned" class="floating-label">Assigned by</label>
        </div>
      </div>
<%
		if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
 	<div class="col-3">
        <div class="input-container">      	
          	 <label class="tcolor">Reassign To</label>
                 	<select class="form-select" id="assignTo" name ="assignTo" required>
               		<option value="<%=rs1.getString("CustEnteredByRep")%>"><%=rs1.getString("CustEnteredByRep") %></option>
						<%
							  sql = "select distinct(MarketingRepCode),MarketingRepName  from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a ,db_GlobalERP.UserMaster b where b.empcode=a.MarketingRepCode and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and ActiveStatus='Yes' order by a.MarketingRepName";
								ResultSet rs = st2.executeQuery(sql);
								%>
								<option value="<%=rs1.getString("CustEnteredByRep") %>"><%=rs1.getString("CustEnteredByRep")%></option>
								<%
								while (rs.next()) {
						%>
						<option value="<%=rs.getString(2)%>">
							<%=rs.getString(2)%></option>
						<%
							}
						%>
               		
               		</select>
               		<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>" />
               		<input type="hidden" name="assignedBy" value="<%=rs1.getString("Assighnedby") %>"  />
					<input type="hidden" name="assignTo" value="<%=session.getAttribute("EmpName").toString() %>"  />
        </div>
      </div>
		<%}%>
	
		<div class="col-3 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="assigned" name="assigned" value="<%=rs1.getString("CompanyName") %>"  placeholder="" required>
          	<label  for="assigned" class="floating-label">Company Name</label>
          	<label id="companynaw2" style="display: none;" for="assigned" class="floating-label">Please Enter company Name</label>
          	<label id="companynaw1" style="display: none;" for="assigned" class="floating-label">Please Enter Character value</label>
          	
        </div>
      </div>
</div>
<div class="row col-12 mt-4"> 
	<div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="repName" name="repName" value="<%=session.getAttribute("EmpName") %>"  placeholder="" required>
          	<label  for="repName" class="floating-label">Marketing Rep. Name</label>
        </div>
    </div>
	<div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="contactperson@123" name="contactPerson" value="<%=rs1.getString("ContactPerson") %>"  placeholder="" required>
          	<label  for="contactPerson" class="floating-label">Contact Person</label>
          	<label id="contact1" class="floating-label" style="display: none;">Please Enter Contact Person Name</label>  
 			<label id="contact2" class="floating-label" style="display: none;">Please Enter Character Value</label> 
        </div>
    </div>
    <div class="col-3">
        <div class="input-container">
          <textarea class="form-control floating-input" id="address" name="address" rows="1"><%=rs1.getString("Address") %></textarea>
          	<label  for="address" class="floating-label">Address</label>
        </div>
    </div>
      <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="leadRef" name="leadRef" value="<%=rs1.getString("leadRef") %>"  placeholder="" required>
          	<label  for="leadRef" class="floating-label">Lead Ref</label>
        </div>
    </div>
</div>
<div class="row col-12 mt-4"> 
      <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="website" name="website" value="<%=rs1.getString("WebSite") %>"  placeholder="" required>
          	<label  for="website" class="floating-label">WebSite</label>
        </div>
    </div>
    <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="email" name="email" value="<%=rs1.getString("EMail") %>"  placeholder="" required>
          	<label  for="email" class="floating-label">E-mail</label>
          	<label  id="email1" class="floating-label" style="display: none;">Please Enter EmailID</label> 
			<label  id="email2" class="floating-label" style="display: none;">Please Enter valid EmailID</label> 
			<label  id="email3" class="floating-label" style="display: none;">Please Enter EmailID</label> 
        </div>
    </div>
      <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="mobile" name="mobile" value="<%=rs1.getString("MobileNo") %>"  placeholder="" required>
          	<label  for="mobile" class="floating-label">Mobile No</label>
          	<label id="mob1" class="floating-label" style="display: none;">Please Enter Numeric value</label>
          	<label id="mob12" class="floating-label" style="display: none;">Number Should Be 10-15 Digits</label>
          	<label id="mob123" class="floating-label" style="display: none;">Please Enter Mobile Number</label>
        </div>
    </div>
     <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="country1" name="country1" value="<%=rs1.getString("Country") %>"  placeholder="" required>
          	<label  for="mobile" class="floating-label">Country</label>
          	<label id="country1" class="floating-label" style="display: none;">Please Enter Character Value</label> 
        </div>
    </div>

</div>
<div class="row col-12 mt-4"> 
      <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="state" name="state" value="<%=rs1.getString("State") %>"  placeholder="" required>
          	<label  for="state" class="floating-label">State</label>
          	<label id="contact11" class="floating-label" style="display: none; color: red">Please Enter Character Value</label>
        </div>
    </div>
     <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="city" name="city" value="<%=rs1.getString("City") %>"  placeholder="" required>
          	<label  for="city" class="floating-label">City</label>
          	<label id="contact12" class="floating-label" style="display: none; color: red">Please Enter Character Value</label>
        </div>
    </div>
         <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="zip" name="zip" value="<%=rs1.getString("Zip") %>"  placeholder="" required>
          	<label  for="zip" class="floating-label">PinCode</label>
          	<label id="zip1" class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
        </div>
    </div>
     <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="faxno" name="faxno" value="<%=rs1.getString("Fax") %>"  placeholder="" required>
          	<label  for="faxno" class="floating-label">Fax Number</label>
          	<label id="fax1" class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
        </div>
    </div>
</div>

<div class="row col-12 mt-4"> 
     <div class="col-3 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="std" name="std" value="<%=rs1.getString("STDCode") %>"  maxlength="6"  placeholder="" required>
          	<label  for="std" class="floating-label">STD Code</label>
          	<label id="fax1" class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
        </div>
    </div>
     <div class="col-3 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="phone" name="phone" value="<%=rs1.getString("Phone") %>" placeholder="" required>
          	<label  for="phone" class="floating-label">Phone No</label>
          	<label id="phone1" class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
          	<label id="phone2" class="floating-label" style="display: none; color: red">Number Should Be 10-14 Digits</label>
          	<label id="phone3" class="floating-label" style="display: none; color: red">Please Enter Phone Number</label>
        </div>
    </div>
<%
String TheGroupNameshow="",TheGroupCodeshow="";
String sqltemp="SELECT TheGroupName,TheGroupCode FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode='"+rs1.getString("Category")+"' "; 
ResultSet rscat=st1.executeQuery(sqltemp);
if(rscat.next()){
	TheGroupNameshow=rscat.getString("TheGroupName");
	TheGroupCodeshow=rscat.getString("TheGroupCode");
}%>


        <div class="col-3">
            <div class="input-container">
                <label class="tcolor">Category</label>
                 	<select class="form-select" id="category" name ="category" required>
                 	<option value="<%=TheGroupCodeshow%>"><%=TheGroupNameshow%></option> 
                 	<% String sqlDropdown="SELECT TheGroupName,TheGroupCode FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where IsDataValid='1' order by TheGroupName";
						  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
						  while(rsDropdown.next()){
						  %>
						  <option value="<%=rsDropdown.getString(2)%>">
						  <%=rsDropdown.getString(1)%></option>
							
						<% 	}%>
                 	</select>
             </div>
        </div>	
   
 </div>               	

<div class="row col-12 mt-4"> 
    <div class="col-3">
        <div class="input-container">
       		 <label class="tcolor">Verticals</label>
                 	<select class="form-select" id="verticals" name ="verticals" required>
                 	 	<option value="<%=rs1.getString("verticals")%>"><%=rs1.getString("verticals")%></option> 
				 		<option value="Fleet Solutions">>Fleet Solutions</option>
                 	</select>
        </div>
    </div>
        <div class="col-3 mt-1">
<b>
    <a id="Add2">Add</a> / <a id="Remove">Remove</a>
</b>
</div>
	<div id="textboxDiv"></div>

</div>

<div class="row col-12 mt-4">
       <div class="col-3">
        <div class="input-container">
       		 <label class="tcolor">Segment</label>
                 	<select class="form-select" id="segment" name ="segment" required>
	                 	 <option value="<%=rs1.getString("segment")%>"><%=rs1.getString("segment")%></option> 
					  	 <option value='Goods'>Goods</option>
					  	 <option value='Hazmat'>Hazmat</option>
					  	 <option value='Industrial Supply chain'>Ind.Supply chain</option>
					  	 <option value='People'>People</option>
                 	</select>
        </div>
    </div>
   <div class="col-3">
        <div class="input-container">
       		 <label class="tcolor">Sub Group</label>
                 	<select class="form-select" id="subgroup" name ="subgroup" required>
	                 	<option value="<%=rs1.getString("subgroup")%>"><%=rs1.getString("subgroup")%></option> 
				  		<option value='DragonDroid'>DragonDroid</option>
				  	 	<option value='Driver Behavior'>Driver Behavior</option>
				  	 	<option value='Portable GPS'>Portable GPS</option>
				  	 	<option value='Route Mapping'>Route Mapping</option>
				  	 	<option value='Tracking'>Tracking</option>
                 	</select>
        </div>
    </div>
    <div class="col-3">
        <div class="input-container">
       		 <label class="tcolor">Confidence Level</label>
                 	<select class="form-select" id="confidencelevel" name ="confidencelevel" required>
	                 	<option value="<%=rs1.getString("confidencelevel")%>"><%=rs1.getString("confidencelevel")%></option> 
				  	 	<option value='25%'>25%</option>
				  	 	<option value='50%'>50%</option>
				  	 	<option value='75%'>75%</option>
				  	 	<option value='100%'>100%</option>
                 	</select>
        </div>
    </div>
         <div class="col-3">
        <div class="input-container">
       		 <label class="tcolor">Solution</label>
                 	<select class="form-select" id="solution" name ="solution" required>
                 					  	<option value="<%=rs1.getString("solution")%>"><%=rs1.getString("solution")%></option> 
			  	 	<option value='Camera'>Camera</option>
				  	<option value='DragonDroid'>DragonDroid</option>
				  	<option value='JRM'>JRM</option>
				  	<option value='Mobile eye'>Mobile eye</option>
				  	</select>
		</div>
	</div>
</div>			
<div class="row col-12 mt-4"> 
     <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="product" name="product" value="<%=rs1.getString("IntrestedProduct") %>" placeholder="" required>
          	<label  for="product" class="floating-label">Interested In Product</label>
        </div>
    </div>
         <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="weeklyOffOn" name="weeklyOffOn" value="<%=rs1.getString("WeeklyOffOn") %>" placeholder="" required>
          	<label  for="weeklyOffOn" class="floating-label">Weekly Off</label>
          	<label id="contact12" class="floating-label" style="display: none; color: red">Please Enter Character Value</label>
        </div>
    </div>
         <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="noofunits" name="noofunits" value="<%=rs1.getString("NoOfUnits") %>" placeholder="" required>
          	<label  for="noofunits" class="floating-label">No Of Units</label>
          	<label id="contact3" class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
        </div>
    </div>
         <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="alternateNumber" name="alternateNumber" value="<%=rs1.getString("TelephoneNo2") %>" placeholder="" required>
          	<label  for="std" class="floating-label">Alternate No</label>
          	<label id="mob8" class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
        </div>
    </div>


</div>
<%String ontmchg=rs1.getString("onetimecharge");
if(ontmchg.equals("-"))
{
	ontmchg="0";
}
%>
<div class="row col-12 mt-4"> 
     <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="onetimecharge" name="onetimecharge" value="<%=ontmchg %>" placeholder="" required>
          	<label  for="onetimecharge" class="floating-label">One Time Charge</label>
        </div>
    </div>
	    <%String recchg=rs1.getString("recurringcharge");
		if(recchg.equals("-"))
		{
			recchg="0";
		}
		String conchg=rs1.getString("contractvalue");
		if(conchg.equals("-"))
		{
			conchg="0";
		}
		%>
     <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="recurringcharge" name="recurringcharge" onblur="chk();" value="<%=recchg%>" placeholder="" required>
          	<label  for="recurringcharge" class="floating-label">Recurring Charge</label>
        </div>
    </div>
    <div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="contractvalue" name="contractvalue" value="<%=conchg%>" placeholder="" required>
          	<label  for="contractvalue" class="floating-label">Contract Value</label>
        </div>
    </div>
	<div class="col-3">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="potentialValue" name="potentialValue" value="<%=rs1.getString("PotentialValue")%>" placeholder="" required>
          	<label  for="potentialValue" class="floating-label">Potential Value</label>
          	<label id="std2" class="floating-label" style="display: none;color: red;">Please Enter Numeric Value</label>
        </div>
    </div>
</div>
<div class="row col-12 mt-4"> 

	<div class="col-4">
        <div class="input-container">
          <textarea class="form-control floating-input" id="comments" name="comments" rows="2" ><%=rs1.getString("Comments") %></textarea>
           <label for="comments" class="floating-label">Comments</label>
        </div>
    </div>
</div>
 <div class="d-grid gap-2 col-3 mx-auto mt-3">
        <button class="btn" id="saveForm" type="submit">Submit</button>
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
	}%>
<script>

function validation()
{
	document.getElementById("contact12").style.display="none";	
	var name=document.getElementById("city").value;
var invalid=/^[a-zA-Z ]+$/;
if(!name==0)
	{
	
	if(!invalid.test(name)){
	 document.getElementById("contact12").style.display="";
		     return false;
		 }	
	}
	
	document.getElementById("mob8").style.display="none";
	var mob=document.getElementById("alternateNumber").value;
	 var invalid=/^[+]{0,1}[0-9]{10,15}$/;
	   if(!(mob ==0))
			{

				 if(!invalid.test(mob)){
                     document.getElementById("mob8").style.display="";
                             return false;
                         }
					
			    }
	
	   document.getElementById("contact11").style.display="none";	
		var name=document.getElementById("state").value;

		var invalid=/^[a-zA-Z ]+$/;
		if(!name==0)
		{
		
		if(!invalid.test(name)){
		 document.getElementById("contact11").style.display="";
			     return false;
			 }	
		}
	
	document.getElementById("contact10").style.display="none";	
	var name=document.getElementById("country1").value;

	var invalid=/^[a-zA-Z ]+$/;
if(!name==0)
	{
	
	if(!invalid.test(name)){
	 document.getElementById("contact10").style.display="";
		     return false;
		 }	
	}
	
	document.getElementById("contact1").style.display="none";
	document.getElementById("contact2").style.display="none";	
var name=document.getElementById("contactperson@123").value;
var invalid=/^[A-Za-z]+[\s\-]*[\s\- .,&A-Za-z]*[A-Za-z]+$/;
var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(name=="" || oth==""){
	document.getElementById("contact1").style.display="";
		return false;
	}
if(!invalid.test(name)){
 document.getElementById("contact2").style.display="";
	     return false;
	 }	
	 
	 	document.getElementById("phone1").style.display="none";
	   	document.getElementById("phone2").style.display="none";
	   	document.getElementById("phone3").style.display="none";
	   	var invalid=/^[0-9 ,]+$/; 
	  	var mob=document.getElementById("phone").value;

	   if(!(mob ==0))
			{
		   if(!invalid.test(mob))
					{
						document.getElementById("phone1").style.display="";
						return false;
					}	
			}
			else
			{
				mob="";
				document.getElementById("phone3").style.display="";
			    return false;	
			}
	
	
	 	document.getElementById("mob1").style.display="none";
	   	document.getElementById("mob12").style.display="none";
	   	document.getElementById("mob123").style.display="none";
		var invalid=/^[+]{0,1}[0-9]{10,15}$/;
 		var mob=document.getElementById("mobile").value;
  if(!(mob ==0))
		{
			 if(!invalid.test(mob))
				{
					document.getElementById("mob12").style.display="";
					return false;
				}
			

		}
		else
		{
			mob="";
			document.getElementById("mob123").style.display="";
		    return false;	
		}
  
	document.getElementById("email3").style.display="none";
	document.getElementById("email1").style.display="none";
	document.getElementById("email2").style.display="none";

	var txtEmail=document.getElementById("email").value;
	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;
	if(txtEmail=="")
		{
		document.getElementById("email3").style.display="";
		return false;
		}

	if(!text.test(txtEmail))
		{
		document.getElementById("email2").style.display="";
		return false;
		
		}
	document.getElementById("contact3").style.display="none";	
	var name1=document.getElementById("weeklyOffOn").value;
	var invalid=/[^A-Za-z\s]/;
	var oth=name1.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(name1==" " || oth==" "){
		}
	else{
		if(invalid.test(name1)){
	    document.getElementById("contact3").style.display="";
		     return false;
		 }	
	}
	document.getElementById("noofunits1").style.display="none";
	var mob=document.getElementById("noofunits").value;
		var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
		   if(!invalid.test(mob)){
		        document.getElementById("noofunits1").style.display="";
		                return false;
		            }
					 }
	document.getElementById("reason1").style.display='none';
	 var reason1=document.getElementById("reason").value;
		if(reason1.trim()==""||reason1==null)
	{
			document.getElementById("reason1").style.display='';
			return false;
	}
		document.getElementById("std2").style.display="none";
		var mob=document.getElementById("potentialValue").value;
		var invalid=/^[0-9]+$/; 
		   if(!(mob ==0))
				{
			   if(!invalid.test(mob)){
			        document.getElementById("std2").style.display="";
			                return false;
			            }
						 }
		
		document.getElementById("companynaw1").style.display='none';
		var compnaw=document.getElementById("companyName").value;
		if(compnaw=="" || compnaw==null )
			{
			document.getElementById("companynaw1").style.display="";
			return false;
			}
	
	document.getElementById("std1").style.display="none";
	var mob=document.getElementById("std").value;
	var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
				 if(!invalid.test(mob)){
				        document.getElementById("std1").style.display="";
				                return false;
				            }
			    }
	   document.getElementById("zip1").style.display="none";
		var mob=document.getElementById("zip").value;
		var invalid=/^[0-9]+$/; 
		   if(!(mob ==0))
				{
			   if(!invalid.test(mob)){
			        document.getElementById("zip1").style.display="";
			                return false;
			            }
						 }
		   document.getElementById("fax1").style.display="none";
			var mob=document.getElementById("faxno").value;
			var invalid=/^[0-9]+$/;    
			if(!(mob ==0))
					{
				if(!invalid.test(mob)){
			        document.getElementById("fax1").style.display="";
			                return false;
			            }
						
					    }
}

function chk()
{
	var recchg=document.getElementById("recurringcharge").value;
	var ontmchg=document.getElementById("onetimecharge").value;
	var nounts=document.getElementById("noofunits").value;
	var tot=(nounts*ontmchg)+(36*recchg*nounts);
	document.getElementById("contractvalue").value=tot;
}
</script>




<script>
$(document).ready(function() {
	  $("#Add2").on("click", function(e) {
	    e.preventDefault();

	    // Count how many inputs currently exist
	    const totalInputs = $("#textboxDiv .col-3").length;

	    // Determine if a new row is needed (every 4 inputs, create a new row)
	    if (totalInputs % 4 === 0) {
	      // Create a new row container and append it to #textboxDiv
	      $("#textboxDiv").append('<div class="row new-row"></div>');
	    }

	    // Create the new input column
	    const newField = `
	      <div class="col-3 mt-4">
	        <div class="input-container">
	          <input type="text" 
	                 pattern="[a-zA-Z0-9-.@&() ]*$" 
	                 class="form-control floating-input" 
	                 placeholder="" 
	                 required />
	        </div>
	      </div>
	    `;

	    // Append the new input to the last row
	    $("#textboxDiv .new-row").last().append(newField);
	  });

	  $("#Remove").on("click", function(e) {
	    e.preventDefault();

	    // Find the last input column inside the last row
	    const lastRow = $("#textboxDiv .new-row").last();
	    if (lastRow.length > 0) {
	      lastRow.children().last().remove();

	      // If the last row becomes empty after removal, remove the empty row div too
	      if (lastRow.children().length === 0) {
	        lastRow.remove();
	      }
	    }
	  });
	});

</script>

<%@ include file="footer.jsp" %>
</body>
</html>	
	
	