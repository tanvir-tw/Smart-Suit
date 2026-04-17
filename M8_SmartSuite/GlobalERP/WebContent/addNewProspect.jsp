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
            text-decoration: none;
            
        }
    </style>
</head>
 <body style="background-color:azure;">
 <%
Connection con = null;
 Statement st=null, st1=null; 
String CompanyMasterID = session.getAttribute("CompanyMasterID").toString();
String companyName = request.getParameter("companyName");

try {
	con = connection.getConnect("db_GlobalERP");       
		st=con.createStatement();
	    st1=con.createStatement();
	    
} catch (Exception e) {
   e.printStackTrace();
}
%>

<div class="container-fluid mt-2" id="main">
		<div class="container">
		<section class="container" style="max-width: 1200px;"id="basic--layouts">
		

				<div class="row">
					<div class="col-md-12 col-12">
						<div class="card" style="background-color: transparent;">
							<div class="card-body" >
								<div class="row breadcrumbs-top">
								<%
					String Category=request.getParameter("Category");
					System.out.println("-CAt===="+Category);
					
					if(Category.equals("Liaison") || Category=="Liaison")
					{
						Category="Liaison";
						
					%>
								
									<h5 class="content-header-title text-center mb-0"style="color: #060637">
										<b>Add New <%=Category %> Officer</b>
									</h5>
									
									<% }
else
	
{
	
	Category="Prospect";
%> 
<h5 class="content-header-title text-center mb-0"style="color: #060637">
										<b>Add New <%=Category %></b>
									</h5>
									
									<%} %>	
								</div>
								<br>
								
<form name="addCustomer" action="addCustomer.jsp" method="post" onsubmit="return formValidation();">
<div class="card shadow-lg mb-4 rounded-3">
<div class="card-body">
<div class="row col-12">
						<div class="col-3 ">
						  <div class="input-container">
						  <label >Marketing Rep. Name : <%=session.getAttribute("EmpName").toString() %></label>
						  
						  </div>
						  </div>
						  </div>
				<div class="row col-12 mt-4">
						<div class="col-3 mt-4">
						  <div class="input-container">

														 <input class="form-control floating-input" type="text" name="companyName"   id="companyName" onkeyup="getProspectes();"  onblur="validateProspectes()" placeholder="" required> 
										   
														 <label  for="companyName" class="floating-label">Company Name</label>
														 <label   id="companynaw1" 	class="floating-label" style="display: none;">Please Enter company Name</label>
														 <label   id="companynaw2" 	class="floating-label" style="display: none;">Please Enter Character value</label>
														 </div>

							</div>
						<div class="col-3 mt-4">
							<div class="input-container">
										<input class="form-control floating-input" type="text" id="contactperson@123" name="contactPerson" value="" onblur="return contactpersonfun();" placeholder="" required> 
										<label for="contactperson@123" class="floating-label">Contact Person</label>
                                    
									 	<div>
										<label id="contact1"  style="display: none; color: red">Please Enter Contact Person Name</label>  
 	                                    <label id="contact2"  style="display: none; color: red">Please Enter Character Value</label> 
                                        </div> 
							</div>

						</div>
						
						
						<%
						System.out.println("usr level  -> "+session.getAttribute("userLevel").toString());
						if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>

						
						<div class="col-3 ">
							<div class="input-container">
						
							 <label class="tcolor">Assign To</label>
							<select id="assignTo" name="assignTo" class="form-select" >
	<%
							String sql = "select MarketingRepName ,MarketingRepCode from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
							" WHERE username<>'' and password<>''  and (Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1 ) order by MarketingRepName";
								ResultSet rs = st.executeQuery(sql);
								%>
								<option value="<%=session.getAttribute("EmpName").toString() %>"><%=session.getAttribute("EmpName").toString() %></option>
								<%
								while (rs.next()) {
						%>
						<option value="<%=rs.getString(1)%>">
							<%=rs.getString(1)%></option>
						<%
							}
						%>
					</select>
					<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
					<input type="hidden" name="assignedBy" class="form-control floating-input" placeholder="" value="<%=session.getAttribute("EmpName").toString() %>"  />
		<input type="hidden" name="assignTo" class="form-control floating-input" placeholder="" value="<%=session.getAttribute("EmpName").toString() %>"  />
			
							
						</div>
						</div>
						
						<div class="col-3 mt-4 ">
							<div class="input-container">
<input id="leadRef" name="leadRef" class="form-control floating-input"  type="text" placeholder="" >

<label for="leadRef"  class="floating-label">Lead reference</label>
		<%} else{%>
<div class="col-3 mt-4 ">
							<div class="input-container">
<input id="leadRef" name="leadRef"  class="form-control floating-input" type="text" placeholder="" >
      <label for="leadRef" class="floating-label">Lead reference</label>
      
      </div>
      </div>
		<%} %>
			             </div>
						</div>
         

				</div>

      <div class="row col-12 mt-4"> 
      <div class="col-3 mt-4">
        <div class="input-container">
  
           <input id="website" name="website"  class="form-control floating-input" value="" placeholder="" >
        	<label for="website" class="floating-label">WebSite</label>
           
   
        </div>
    </div>
    
    <div class="col-3 mt-4">        
         <div class="input-container">
       		<input class="form-control floating-input" type="text" id="email" name="email" value=""  placeholder="" onblur="return validateEmail();" required>
          	<label for="email" class="floating-label">E-mail</label>
			<div>
<label  id="email3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter EmailID</font></label> 
<label  id="email1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter valid EmailID</font></label> 
<label   id="email2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter valid EmailID</font></label> 
</div> 
        </div>
    </div>
        
      <div class="col-3 mt-4">
        <div class="input-container">
          	 <textarea class="form-control floating-input" id="address" name="address" rows="1" placeholder=""></textarea>
          	<label  for="address" class="floating-label">Address</label>         	
        </div>
    </div>
        
       <div class="col-3 ">
        <div class="input-container">
        
        <label class="tcolor">Country</label>
        <select class="form-select" id="country1" name="country1"  onchange="showbox();showbox2();"  required>
          	<option value="Select">Select</option>
				  <% String sqlDropdown3="SELECT Distinct(Country) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by Country asc";
				  ResultSet rsDropdown3=st1.executeQuery(sqlDropdown3);
				  while(rsDropdown3.next()){
				  %>
				  <option value="<%=rsDropdown3.getString(1)%>"><%=rsDropdown3.getString(1)%></option>
							
						<% 	}%> 
				</select>
				 <div>
					 <input class="form-control floating-input" type="text"  name="newcountry" id="newcountry" style="display: none"/>
					<a  style="font-weight: bold; color: blue;display: none " id="f14" onclick="showminus2('-')">(-)</a>
	                <label><a  id="f15" onclick="showentryform2();">Add Country</a></label>
			     </div> 
        </div>
        </div>
      </div>
        
<div class="row col-12 mt-4"> 
    <div class="col-3">
        <div class="input-container">
        <label class="tcolor">State</label>
        <select   disabled class="form-select"  id="state"  name="state"   onchange="showbox1()" > 
	           <option value="Select">Select</option>
				<% String sqlDropdown2="SELECT Distinct State FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by State asc";
				  ResultSet rsDropdown2=st1.executeQuery(sqlDropdown2);
				  while(rsDropdown2.next()){
				  %>
				  <option value="<%=rsDropdown2.getString(1)%>"><%=rsDropdown2.getString(1)%></option>
							
						<% 	}%> 

            </select>
            <div>

				 <input  class="form-control floating-input" type="text" name="newstate" id="newstate" style=" display: none"/>
				 <a  style="font-weight: bold; color: blue;display: none " id="f12" onclick="showminus1('-')">(-)</a>				
				<label><a style="display: none;" id="f13" onclick="showentryform1();" >Add State</a></label>
		
			</div>
				
             
        </div>
     </div>

 

<div class="col-3">
        <div class="input-container">
 
 <label class="tcolor">City </label>
<select disabled class="form-select"  id="city" name="city" >
<option value="Select">Select</option>
				  <% String sqlDropdown1="SELECT Distinct City FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City asc ";
				  ResultSet rsDropdown1=st1.executeQuery(sqlDropdown1);
				  while(rsDropdown1.next()){
				  %>
				  <option><%=rsDropdown1.getString(1)%></option>
							
						<% 	}%> 
				</select>
		    <div>
			<input  class="form-control floating-input" type="text" name="newcity" id="newcity" style="width: ; display: none"  />
			<a  style="font-weight: bold; color: blue;display: none " id="f10" onclick="showminus('-')">(-)</a>
				<label><a id="f11" style="display: none;" onclick="showentryform();">Add City</a></label>
			</div>
              
        </div>
     </div>

	
	<div class="col-3 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="zip" name="zip" value=""  placeholder=""  onblur="return pin();">
          	<label  for="zip" class="floating-label">PinCode</label>
          	<label id="zip1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
		    <label id="zip2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter 6 digit Value</font></label> 
				
        </div>
    </div>
	
	<div class="col-3 mt-4 ">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="mobile" name="mobile" value="" placeholder=""  required onblur="return funmob1();">
          	<label for="mobile" class="floating-label">Mobile No</label>
          	<!-- <label  class="floating-label" style="display: none; color: red">Please Enter Numeric Value</label>
          	<label  class="floating-label" style="display: none; color: red">Number Should Be 10-15 Digits</label>
          	<label  class="floating-label" style="display: none; color: red">Please Enter Mobile Number</label>
          	
          	 -->
          	 <div>
	           <label id="mob1"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric value</font></label>
				<label id="mob12" style="display: none;"><font face="Arial" size="2" color="red">Number Should Be 10-15 Digits</font></label>
		        <label id="mob123"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Mobile Number</font></label>
		         </div>
        </div>
    </div>	
	</div>     
<div class="row col-12 mt-4"> 
    <div class="col-3 mt-4">
<div class="input-container">
        
<input class="form-control floating-input" type="text" id="faxno" name="faxno"  value="" placeholder=""  onblur="return fax();">
          	<label for="faxno" class="floating-label">Fax No</label>
          	<div>
                 <label id="fax1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
				<label id="fax2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label>
           </div>
 </div>
        
    </div> 
     <div class="col-3 mt-4 ">
        <div class="input-container">
        <input class="form-control floating-input" type="text"  id="std" name="std"  value="" placeholder=""  onblur="return units5();">
          	<label  for="std" class="floating-label">STD Code</label>
          		<div>
				 <label id="noofunits3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label>
				 <label id="noofunits4" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
				</div>
        
        </div>
     </div>
       
      <div class="col-3 mt-4">
        <div class="input-container">
       		<input class="form-control floating-input" type="text" id="phone" name="phone"  value="" placeholder=""  required onblur="return funmob2();">
          	<label   for="phone" class="floating-label">Phone No</label>
          	<div>		
          	    <label id="phone1"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric value</font></label>
				<label id="phone2" style="display: none;"><font face="Arial" size="2" color="red">Number Should Be 10-14 Digits</font></label>
		        <label id="phone3"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Phone Number</font></label>
		    </div>
        </div>       
       </div>
        <div class="col-3">
        <div class="input-container">
        <label class="tcolor"  >Category</label>
        
        <select id="category" name="category" class="form-select"  > 
		  	<option value="0">Select</option>

				  <% String sqlDropdown="SELECT TheGroupName,TheGroupCode FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where IsDataValid='1' order by TheGroupName";
				  ResultSet rsDropdown=st1.executeQuery(sqlDropdown);
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
       		<input class="form-control floating-input" type="text" id="product" name="product"  value="" placeholder="" >
          	<label  for="product" class="floating-label">Interested In Product</label>
          	
        </div> 
        
     </div>
    <div class="col-3">       
         <div class="input-container">

 		    <input class="form-control floating-input" type="text" id="weeklyOffOn" name="weeklyOffOn"  value="" placeholder=""  onblur="return contactpersonfun1();">
          	<label for="weeklyOffOn" class="floating-label">Weekly Off</label>
            <div>	 
 				<label id="contact3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value</font></label> 
 		   </div>
                  </div>    
    </div>
       
<div class="col-3">       
         <div class="input-container">	      
		      <input class="form-control floating-input" type="text" id="alternateNumber" name="alternateNumber" maxlength="15" value="" placeholder=""  onblur="return  funmob3();">
          	<label   for="alternateNumber" class="floating-label">Alternate Number</label>
          	  <div>
				<label id="mob7"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric value</font></label>
                <label id="mob8"  style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric value</font></label>
		      </div></div>
</div>

<div class="col-3">       
         <div class="input-container">       
         <input id="potentialValue" name="potentialValue"  class="form-control floating-input" type="text"  value="" placeholder="" onblur="return code1();" />
         <label for="potentialValue"  class="floating-label" for="element_1">Potential Value</label>
            
				<div>
				 <label id="std3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
				 <label id="std4" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
				</div>
         
         </div>
</div>

    </div>    
<div class="row col-12 mt-4"> 
	<div class="col-3">     
           <div class="input-container">
  
           <input id="noofunits" name="noofunits"  class="form-control floating-input" type="text"  placeholder="" value="0" onblur="return  units();"/>
           <label  class="floating-label" for="noofunits">No Of Units</label>

               <div>
				 <label id="noofunits1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
				 <label id="noofunits2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value</font></label> 
				</div> 
           </div>
    </div>

    <div class="col-3 ">
        <div class="input-container">
          	 <textarea class="form-control floating-input" id="comments" name="comments" rows="1" placeholder=""></textarea>
          	<label for="comments" class="floating-label">Comments</label>         	
        </div>
    </div>
    
    
</div>   

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
function formValidation()
{
	validate1();
	
	document.getElementById("companynaw1").style.display='none';
	
	var compnaw=document.getElementById("companyName").value;
var invalid=/^[A-Za-z0-9]+[\s\-]*[\s\- .,&A-Za-z0-9]*[A-Za-z]+$/;
	if(!invalid.test(compnaw))
		{
		alert("Please Enter Valid Company Name");
		return false;
		}
	
	if(compnaw.trim()=="" || compnaw.trim()==null )
		{
		document.getElementById("companynaw1").style.display="";
		return false;
		}	
	document.getElementById("contact1").style.display="none";
	document.getElementById("contact2").style.display="none";	
var name=document.getElementById("contactperson@123").value;
var invalid=/^[a-zA-Z  .]+$/;
var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(name=="" || oth==""){
	document.getElementById("contact1").style.display="";
	return false;
}
if(!invalid.test(name)){
document.getElementById("contact2").style.display="";
     return false;
 }			
	document.getElementById("std3").style.display="none";
	document.getElementById("std4").style.display="none";
	var mob=document.getElementById("potentialValue").value;
	 var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("std3").style.display="";
						return false;
					}	
				 if(!invalid.test(mob)){
                     document.getElementById("std4").style.display="";
                             return false;
                         }					
			    }
	document.getElementById("noofunits1").style.display="none";
	document.getElementById("noofunits2").style.display="none";
	var mob=document.getElementById("noofunits").value;
	var invalid=/^[0-9]+$/; 
	if(!(mob ==0))
		{
			 if(isNaN(mob))
				{
					document.getElementById("noofunits1").style.display="";
					return false;
				}	
			 if(!invalid.test(mob)){
			        document.getElementById("noofunits2").style.display="";
			                return false;
			            }			
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
	 document.getElementById("mob7").style.display="none";
		document.getElementById("mob8").style.display="none";
		var mob=document.getElementById("alternateNumber").value;
		 var invalid=/^[0-9]+$/; 
		   if(!(mob ==0))
				{
					 if(isNaN(mob))
						{
							document.getElementById("mob7").style.display="";
							return false;
						}	
					 if(!invalid.test(mob)){
	                     document.getElementById("mob8").style.display="";
	                             return false;
	                         }						
				    }
	
			 document.getElementById("phone1").style.display="none";
			   document.getElementById("phone3").style.display="none";
			   var invalid=/^[0-9 ]+$/; 
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
   
	
	
	document.getElementById("noofunits3").style.display="none";
	document.getElementById("noofunits4").style.display="none";
	var mob=document.getElementById("std").value;
	var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("noofunits3").style.display="";
						return false;
					}	
				 if(!invalid.test(mob)){
				        document.getElementById("noofunits4").style.display="";
				                return false;
				            }
				 }
	
	document.getElementById("fax1").style.display="none";
	document.getElementById("fax2").style.display="none";
	var mob=document.getElementById("faxno").value;
	 var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("fax1").style.display="";
						return false;
					}	
				 if(!invalid.test(mob)){
                        document.getElementById("fax2").style.display="";
                                return false;
                            }
			    }
	   document.getElementById("mob1").style.display="none";
	   document.getElementById("mob12").style.display="none";
	   document.getElementById("mob123").style.display="none";
			  var invalid=/^[0-9]+$/; 
   var mob=document.getElementById("mobile").value;
   if(!(mob ==0))
		{
			 if(!invalid.test(mob))
				{
					document.getElementById("mob1").style.display="";
					return false;
				}	
			 if((mob.trim().length < 10)  || (mob.trim().length >15))
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
	
	 
   
   document.getElementById("zip1").style.display='none';
   document.getElementById("zip2").style.display='none';

   var mob = document.getElementById("zip").value.trim();

   // Check empty
   if (mob === "") {
       document.getElementById("zip1").style.display="";
       return false;
   }

   // Check NOT numeric
   if (isNaN(mob)) {
       document.getElementById("zip1").style.display="";
       return false;
   }

   // Check EXACT 6 digits
   var invalid = /^[0-9]{6}$/;

   if (!invalid.test(mob)) {
       document.getElementById("zip2").style.display="";
       return false;
   }

		   document.getElementById("email3").style.display="none";
			document.getElementById("email1").style.display="none";
			document.getElementById("email2").style.display="none";

			var txtEmail=document.getElementById("email").value; 
			var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

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
}
function validate1(){
	
var compnaw=document.getElementById("companyName").value;

	compnaw=compnaw.replace(/,/,'...');
	compnaw=compnaw.replace(/;/,'**');
	compnaw=compnaw.replace(/:/,'##');
	compnaw=compnaw.replace(/_/,'*****');
	compnaw=compnaw.replace(/-/,'#####');
	
	compnaw=encodeURIComponent(compnaw);
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
	}ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{var reselt=ajaxRequest.responseText;
		   var finalres=reselt.split("#");
			var finalrescount=finalres[1].trim();
			if(finalrescount>=1)
		   {
 			alert("Customer Name Already Exists !!You Can Not Add This Customer---->"+finalres[0].trim());
         // alert("Customer Name Is Already Exists! You Can't Add This C!!");
 			document.addCustomer.companyName.value="";
 			//document.getElementById("comlist").style.display='none';
		  }
		 
		}
	
	}
	
	var queryString = "?prospect=" +compnaw;
	
	
	ajaxRequest.open("GET", "AjaxCheckForCustomer.jsp" + queryString, true);
	ajaxRequest.send(null); 
}

function code1()
{
	document.getElementById("std3").style.display="none";
	document.getElementById("std4").style.display="none";
	var mob=document.getElementById("potentialValue").value;
	 var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("std3").style.display="";
						return false;
					}	
				 if(!invalid.test(mob)){
                     document.getElementById("std4").style.display="";
                             return false;
                         }
					
			    }
			}
function contactpersonfun1()
{
	
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
}
function funmob3()
{
	   
	document.getElementById("mob7").style.display="none";
	document.getElementById("mob8").style.display="none";
	var mob=document.getElementById("alternateNumber").value;
	 var invalid=/^[0-9]+$/; 
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("mob7").style.display="";
						return false;
					}	
				 if(!invalid.test(mob)){
                     document.getElementById("mob8").style.display="";
                             return false;
                         }
					
			    }
	
			
}
			
function validateEmail()
{
	document.getElementById("email3").style.display="none";
	document.getElementById("email1").style.display="none";
	document.getElementById("email2").style.display="none";

	var txtEmail=document.getElementById("email").value;

	var text= /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

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

	}
function contactpersonfun12()
{
	document.getElementById("contact10").style.display="none";
	document.getElementById("contact20").style.display="none";	
var name=document.getElementById("companyName").value;
//	var invalid=/[^A-Za-z\s]/;
var invalid=/^[a-zA-Z  .]+$/;
var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(name=="" || oth==""){
	document.getElementById("contact10").style.display="";
		return false;
	}
if(!invalid.test(name)){
 document.getElementById("contact20").style.display="";
	     return false;
	 }	
}
function contactpersonfun()
{
	document.getElementById("contact1").style.display="none";
	document.getElementById("contact2").style.display="none";	
var name=document.getElementById("contactperson@123").value;
var invalid=/^[a-zA-Z  .]+$/;
var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(name=="" || oth==""){
	document.getElementById("contact1").style.display="";
		return false;
	}
if(!invalid.test(name)){
 document.getElementById("contact2").style.display="";
	     return false;
	 }	
}
function showbox()
{

	//alert("hi");
	var country = document.getElementById("country1").value;
	//var country=e.options[e.selectedIndex].Text;
if(country!=null)
	{
	document.getElementById("f13").style.display="";
	
	}
else
	{
	document.getElementById("f13").style.display='none';
	
	}
	//alert(country);
	
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
			//alert(reslt);
			document.getElementById("state").disabled = false;
			//alert("after true");
			document.getElementById("state").innerHTML=reslt;
			
			
		
		} 
	};
	
	var queryString = "?country="+country;
	ajaxRequest.open("GET", "AjaxGetState.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
	
}
function showbox2()
{

	//alert("hi");
	var country = document.getElementById("country1").value;
	//var country=e.options[e.selectedIndex].Text;

	//alert(country);
	
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
			//alert(reslt);
			document.getElementById("city").innerHTML=reslt;
			
		} 
	};
	
	var queryString = "?country="+country;
	ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
	
}

function showbox1()
{

	//alert("hi");
	var state = document.getElementById("state").value;
//alert(state);
if(state!=null)
	{
	document.getElementById("f11").style.display="";
	
	}
else
	{
	document.getElementById("f11").style.display='none';
	
	}
	//alert(country);
	
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
			//alert(reslt);
			document.getElementById("city").disabled = false;
			document.getElementById("city").innerHTML=reslt;		
		} 
	};
	var queryString = "?state="+state;
	//alert(queryString);
	ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
	
}
function funmob1()
   {
		   document.getElementById("mob1").style.display="none";
		   document.getElementById("mob12").style.display="none";
		   document.getElementById("mob123").style.display="none";
				  var invalid=/^[0-9]+$/; 
	   var mob=document.getElementById("mobile").value;
	   if(!(mob ==0))
			{
				 if(!invalid.test(mob))
					{
						document.getElementById("mob1").style.display="";
						return false;
					}	
				 if((mob.trim().length < 10)  || (mob.trim().length >15))
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
	   }
 function funmob2()
	 {
	 document.getElementById("phone1").style.display="none";
	   document.getElementById("phone3").style.display="none";
	   var invalid=/^[0-9 ]+$/; 
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
   }
 function pin()
	{
	 document.getElementById("zip1").style.display='none';
		document.getElementById("zip2").style.display='none';
		var invalid=/^[0-9]+$/;
		var mob=document.getElementById("zip").value;
		   if(!(mob ==0))
				{
					 if(isNaN(mob))
						{
							document.getElementById("zip1").style.display="";
							return false;
						}	
					  if(!invalid.test(mob)){
                           document.getElementById("zip2").style.display="";
                                   return false;
                               }
				    }
				}
 function fax()
	{
		document.getElementById("fax1").style.display="none";
		document.getElementById("fax2").style.display="none";
		var mob=document.getElementById("faxno").value;
		 var invalid=/^[0-9]+$/; 
		   if(!(mob ==0))
				{
					 if(isNaN(mob))
						{
							document.getElementById("fax1").style.display="";
							return false;
						}	
					 if(!invalid.test(mob)){
                            document.getElementById("fax2").style.display="";
                                    return false;
                                }
					 
						
				    }
				}

 function units5()
	{
		document.getElementById("noofunits3").style.display="none";
		document.getElementById("noofunits4").style.display="none";
		var mob=document.getElementById("std").value;
		var invalid=/^[0-9]+$/; 
		   if(!(mob ==0))
				{
					 if(isNaN(mob))
						{
							document.getElementById("noofunits3").style.display="";
							return false;
						}	
					 if(!invalid.test(mob)){
					        document.getElementById("noofunits4").style.display="";
					                return false;
					            }
						
						
				    }
				}
 
 
 function units()
	{
		document.getElementById("noofunits1").style.display="none";
		document.getElementById("noofunits2").style.display="none";
		var mob=document.getElementById("noofunits").value;
		var invalid=/^[0-9]+$/; 
		   if(!(mob ==0))
				{
					 if(isNaN(mob))
						{
							document.getElementById("noofunits1").style.display="";
							return false;
						}	
					 if(!invalid.test(mob)){
					        document.getElementById("noofunits2").style.display="";
					                return false;
					            }
						
						
				    }
				}

var globalcompany;var flag=true;
function hideList(e)
{
if(e.which == 0){
	document.getElementById("ProspectList").style.visibility='hidden';
}
}
function hideOnClick()
{
    //	document.getElementById("ProspectList").style.visibility='hidden';
}
function getProspectes()
{
	var list;
	document.getElementById("comlist").style.display="";
	
	document.getElementById("list").style.visibility='visible';
	var prospect=document.addCustomer.companyName.value;
	//alert(prospect);
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

	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("list").innerHTML=reslt;
		
		} 
	}
	var queryString = "?prospect=" +prospect+"&displayList=true";
	ajaxRequest.open("GET", "ListOfSuppliers.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
 
function validateProspectes()
{
	document.getElementById("companynaw1").style.display='none';

	var compnaw=document.getElementById("companyName").value;
var invalid=/^[A-Za-z0-9]+[\s\-]*[\s\- .,&A-Za-z0-9]*[A-Za-z]+$/;
	
	if(!invalid.test(compnaw))
		{
		alert("Please Enter Valid Company Name");
		
		
		return false;
		}
	
	if(compnaw.trim()=="" || compnaw.trim()==null )
	{
	document.getElementById("companynaw1").style.display="";
	return false;
	}
	compnaw=compnaw.replace(/,/,'...');
	compnaw=compnaw.replace(/;/,'**');
	compnaw=compnaw.replace(/_/,'*****');
	compnaw=compnaw.replace(/-/,'#####');
	
	compnaw=encodeURIComponent(compnaw);
//alert("IN FUNCVOOM     ");
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
	//alert("eeeeeeeeeeeeeeeeeeeeeeeeee");
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{var reselt=ajaxRequest.responseText;
			var finalres=reselt.split("#");
				var finalrescount=finalres[1].trim();
			if(finalrescount>=1)
		   {
 			alert("Customer Name Already Exists !!You Can Not Add This Customer---->"+finalres[0].trim());
         // alert("Customer Name Is Already Exists! You Can't Add This C!!");
 			document.addCustomer.companyName.value="";
 			document.getElementById("comlist").style.display='none';
		  }
		}	
	}	
	var queryString = "?prospect=" +compnaw;	
	ajaxRequest.open("GET", "AjaxCheckForCustomer.jsp" + queryString, true);
	ajaxRequest.send(null); 		
}
function showentryform2()
{
	
	document.getElementById("country1").disabled = true;
	document.getElementById("newcountry").style.display="";
	document.getElementById("f14").style.display="";
	document.getElementById("f15").style.display='none';
	document.getElementById("f13").style.display="";
	}
function showminus2(id)
{
document.getElementById("country1").disabled = false;
document.getElementById("f14").style.display='none';
document.getElementById("newcountry").style.display='none';
document.getElementById("f13").style.display='none';
document.getElementById("f15").style.display="";
document.getElementById("newcountry").value="";
}
function showentryform1()
{
	
	document.getElementById("state").disabled = true;
	document.getElementById("newstate").style.display="";
	document.getElementById("f12").style.display="";
	document.getElementById("f13").style.display='none';
	document.getElementById("f11").style.display="";


}
function showminus1(id)
{
document.getElementById("state").disabled = false;
document.getElementById("f12").style.display='none';
document.getElementById("newstate").style.display='none';
document.getElementById("f11").style.display='none';
document.getElementById("f13").style.display="";
document.getElementById("newstate").value="";
}

function showentryform()
{
	
	document.getElementById("city").disabled = true;//select id
	document.getElementById("newcity").style.display="";//input type id
	document.getElementById("f10").style.display="";
	document.getElementById("f11").style.display='none';
}
function showminus(id)
{
document.getElementById("city").disabled = false;
document.getElementById("f10").style.display='none';
document.getElementById("newcity").style.display='none';

document.getElementById("f11").style.display="";
document.getElementById("newcity").value="";
}

function getClient1(id)
{ if(id=="+")
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
		document.getElementById("mobileno1").value="";
		document.getElementById("f1").style.display="";
		document.getElementById("mobileno1").style.display='none';
		
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
    }
    }


function getClient3(id)
{ 
	//alert("in2 get"+id);

	if(id=="-")
    {
	document.getElementById("mobileno2").style.display='none';
	document.getElementById("f2").style.display="";
	document.getElementById("f3").style.display="";
	document.getElementById("f4").style.display='none';	
    }
}
function Disable()
{
	var abc=document.getElementById("country1").value;
	alert(abc);
	if(abc=="Select")
		{
		}
	else{
		document.getElementById("state").disabled = true;
		document.getElementById("city").disabled = true;
	}
	
	}
		
</script>
<%@ include file="footer.jsp" %>
</body>
</html>