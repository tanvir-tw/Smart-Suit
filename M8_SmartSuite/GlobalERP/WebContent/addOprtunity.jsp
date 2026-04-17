 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head></head>
	

	<body onkeypress="hideList(event);" onclick="hideOnClick();">

	<script type="text/javascript">
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
		document.getElementById("list").style.visibility='visible';
		var prospect=document.addOpportunity.companyName.value;
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
				//alert(reslt);
				//var mySplitResult = reslt.split("#");
				//alert(mySplitResult[15]);
				document.getElementById("list").innerHTML=reslt;
			
			} 
		}
		var queryString = "?prospect=" +prospect+"&displayList=true";
		ajaxRequest.open("GET", "ListOfSuppliers.jsp" + queryString, true);
		ajaxRequest.send(null); 
	}
	 function getCustsDetails(name) 
	    {
		    alert(name);
		    try{
	      //alert(document.getElementById("name"+i).value);
	   		document.getElementById("list").style.visibility="hidden";
	   		document.addOpportunity.companyName.value=document.getElementById(i).value;
		    }catch(e)
		    {
			    alert(e);
		    }
		}
	function validateProspectes()
	{
		//alert("IN FUNCVOOM     ");
		var prospect=document.addOpportunity.companyName.value;
		//alert(prospect);
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
			{//alert("######################### ");
				
			   var reselt=ajaxRequest.responseText;
		//	   alert("Original result     "+reselt);
				var finalres=reselt.trim();	
			//	alert("After trim      "+reselt);
				  if(finalres=="Yes")
			  {
				alert("Customer Name Already Exists !!You Can Not Add This Customer  ");
				document.addOpportunity.companyName.value="";
				document.getElementById("list").style.visibility='hidden';
			  }
			 
			}
		
		}
		
		var queryString = "?prospect=" +prospect;
		ajaxRequest.open("GET", "AjaxCheckForCustomer.jsp" + queryString, true);
		ajaxRequest.send(null); 
			
	}
	
	function validateEdit()
	{
			//alert("IN VALIDATE EDIT  ");
		   var marketingRep=document.editCustomer.repName.value;//alert(marketingRep);
		   var companyName=document.editCustomer.companyNameafteredit.value;//alert(companyName);
		   var contactPerson=document.editCustomer.contactPerson.value;//alert(contactPerson);
		   var website=document.editCustomer.website.value;//alert(website);
		   var email=document.editCustomer.email.value;//alert(email);
		   var address=document.editCustomer.address.value;//alert(address);
		   var city=document.editCustomer.city.value;//alert(city);
		   var zip=document.editCustomer.zip.value;//alert(zip);
		   var state=document.editCustomer.state.value;//alert(state);
		   var country=document.editCustomer.country.value;//alert(country);
		   var mobile=document.editCustomer.phone.value;//alert(phone);
		   var phone=document.editCustomer.ph.value;//alert(phone);
		   var fax=document.editCustomer.fax.value;//alert(fax);
		   var category=document.editCustomer.category.value;//alert(category);
		   var product=document.editCustomer.product.value;//alert(product);
		   var weeklyOffOn=document.editCustomer.weeklyOffOn.value;//alert(weeklyOffOn);
		   var alternateNumber=document.editCustomer.alternateNumber.value;//alert(alternateNumber);
		   var reason=document.editCustomer.reason.value;//alert(alternateNumber);
	
		if(reason==""){
		alert("Please enter reason for updating this record");
		return false;
		}
		 
	    var numericExpression = /^[0-9]+$/;
	   	if(contactPerson.match(numericExpression)){
		    	alert("Persons name cannot be  Numeric");
	   		return false;
	   	}
	
	   	if(companyName=="" && contactPerson==""){
		    	alert("Please enter company name or contact person ");
	   		return false;
	   	}
	
	   	if(email=="" || mobile=="" ){
		    	alert("Please enter Email-Id or Contact Number");
	   		return false;
	   	}
	 	if(phone==""){
	    	alert("Please enter  phone Number");
			return false;
		}
	
	   	var at="@";
	   		var dot=".";
	   		var lat=email.indexOf(at);
	   		var lstr=email.length;
	   		var ldot=email.indexOf(dot);
	   		if (email.indexOf(at)==-1 && email!=""){
	   		   alert("Invalid E-mail ID");
	   		   return false;
	   		}
		    	if(!(mobile.match(numericExpression)) && mobile!=""){
			    	alert("Mobile Number Should Be Numeric Value");
		    		return false;
		    	}
		    	if(phone!="")
		    	if(!(phone.match(numericExpression))){
			    	alert("Phone Number Should Be Numeric Value");
		    		return false;
		    	}
	           var agree=confirm(" CompanyName: "+companyName+"\n Contact Person : "+contactPerson+"\n Email: "+email+"\n Mobile: "+mobile+"\n\nAre you sure you want to continue with these values?");
	   		if (agree)
	   			return true ;
	   		else
	   			return false ;
	
	}

	function validate()
	{
		//alert("IN AVL:OIDATE   ");

		 var marketingRep=document.addOpportunity.repName.value;//alert("1"+marketingRep);
		 var companyName=document.addOpportunity.companyName.value;//alert("2"+companyName);
		// document.addOpportunity.listofcompany.value=companyname;
		 var contactPerson=document.addOpportunity.contactPerson.value;//alert("3"+contactPerson);
		 var lead=document.addOpportunity.leadRef.value;
		 
		 var website=document.addOpportunity.website.value;//alert("4"+website);
		 var email=document.addOpportunity.email.value;//alert("5"+email);
		 var address=document.addOpportunity.address.value;//alert("6"+address);
		 var city=document.addOpportunity.city.value;//alert("7"+city);
		 var zip=document.addOpportunity.zip.value;//alert("8"+zip);
		 var state=document.addOpportunity.state.value;//alert("9"+state);
		 var country=document.addOpportunity.country.value;//alert("10"+country);
		 var mobile=document.addOpportunity.phone.value;//alert("11"+phone);
		 var phone=document.addOpportunity.ph.value;//alert("12"+phone);
		 var fax=document.addOpportunity.fax.value;//alert("13"+fax);
		 var category=document.addOpportunity.category.value;//alert("14"+category);
		 var product=document.addOpportunity.product.value;//alert("15"+product);
		 var weeklyOffOn=document.addOpportunity.weeklyOffOn.value;//alert("16"+weeklyOffOn);
		 var alternateNumber=document.addOpportunity.alternateNumber.value;//alert("17"+alternateNumber);
		 var std=document.addOpportunity.std.value;//alert("18"+std);
		// var newabc=document.getElementById("listofcompany").value;
		// alert(newabc);
		         var noofunits=document.addOpportunity.noofunits.value;
		
		         state=state.replace(/^\s+|\s+$/g,"");

		 var ocode=document.addOpportunity.ocode.value;
		 var oname=document.addOpportunity.oname.value;
		var nameoth=oname.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		var codeoth=ocode.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		
			
		 var oth=contactPerson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var othC=companyName.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var othe=email.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var othp=phone.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var letter = /^[A-Za-z]+$/;
			
			
	    	 var numericExpression = /^[0-9]+$/;
	    	    
	    	 var invalid=/[^A-Za-z\s]/;

	    	

	    	
	    	if(companyName=="" || othC==""){
		    	alert("Please enter company name  ");
	    		return false;
	    	}
	    	
	    	
	    	



	    	
	    	if(contactPerson=="" || oth==""){
		    	alert("Please enter Contact person Name  ");
	    		return false;
	    	}



	    	 if(invalid.test(contactPerson)){
	    	     alert('Please enter character value for contact person..');  
	    	     return false;
	    	 }
	    	
		    	
		    	if(ocode=="" || codeoth==""){
			    	alert("Please enter Opportunity code");
		    		return false;
		    	}
		    	 if(isNaN(ocode))
					{
						alert("Please enter numeric value for Opportunity code");
						return false;
					}
		    	if(oname=="" || nameoth==""){
			    	alert("Please enter Opportunity name");
		    		return false;
		    	}

		    	 if(invalid.test(oname)){
		    	     alert('Please enter character value for Opportunity Name..');  
		    	     return false;
		    	 }

		    	 if(invalid.test(lead)){
		    	     alert('Please enter character value for lead reference..');  
		    	     return false;
		    	 }

			    	
		    	
		    	 if(!(website.match(letter)) && website.length!=0)  
		    	 {  
		    	    alert('Please enter character value for website');  
		    	 return false;  
		    	 }

		    	if(email=="" || othe=="")
		    	{
		    		alert("Please enter Email-Id");
		    		return false;
		    	}

		    	
	    	//if(email=="" || mobile=="" || phone==""){
		    	//alert("Please enter Email-Id or Contact Number");
	    		//return false;
	    	//}


	    	var at="@";
	    		var dot=".";
	    		var lat=email.indexOf(at);
	    		var lstr=email.length;
	    		var ldot=email.indexOf(dot);
	    		if (email.indexOf(at)==-1 && email!=""){
	    		   alert("Please enter valid e-mail id");
	    		   return false;
	    		}

	    		  //if(email)
	    		
	    		 if(isNaN(zip))
					{
						alert("Please enter numeric value for zipcode");
						return false;
					}
	    		  
	    		/* if(!(state.match(letter)))  
		    	 {
			    	 alert(state);  
		    	    alert('Please enter character value for state');  
		    	 return false;  
		    	 }*/
	    		 if(!(country.match(letter)) && country.length!=0)  
		    	 {  
		    	    alert('Please enter character value for country');  
		    	 return false;  
		    	 }
		    	 

			    
		    	if(!(mobile ==0))
				{
					
					 if(isNaN(mobile))
						{
							alert("Please enter numeric value for mobile number");
							return false;
						}
					
						 if((mobile.trim().length < 6)  || (mobile.trim().length >15))
							 {
						        alert("Mobile no should be greater than 6 digits and less than 15 digits"); 
				        return false;
				    }
				}
				else
				{
					mobile="";
					
					alert("Please enter mobile number");
				    return false;	
				}


var phno11=document.getElementById("mobileno1").value;
				
				if(!(phno11 ==0))
				{
					
					 if(isNaN(phno11))
						{
							alert("Please enter numeric value for mobile number");
							return false;
						}
					
						 if((phno11.trim().length < 6)  || (phno11.trim().length >15))
							 {
						        alert("Mobile no should be greater than 6 digits and less than 15 digits"); 
				        return false;
				    }
				}


				var phno12=document.getElementById("mobileno2").value;
				
				if(!(phno12 ==0))
				{
					
					 if(isNaN(phno12))
						{
							alert("Please enter numeric value for mobile number");
							return false;
						}
					
						 if((phno12.trim().length < 6)  || (phno12.trim().length >15))
							 {
						        alert("Mobile no should be greater than 6 digits and less than 15 digits"); 
				        return false;
				    }
				}


				
try{
	if(isNaN(fax))
	{
				    	alert("Fax number should be numeric value");
			    		return false;
			    	}
}catch(e)
{
alert(e);
}
		    	 if(isNaN(std))
					{
						alert("Please enter numeric value for STD code");
						return false;
					}
		    	if(std.length>5)
				{	
					alert("STD cannot be more than 5 digits");
					return false;
				}
		    	

		    	if(phone=="" || othp==""){
			    	alert("Please enter phone number");
		    		return false;
		    	}

		    	
		    	if(phone!="")
		    	if(!(phone.match(numericExpression))){
			    	alert("Phone Number Should Be Numeric Value");
		    		return false;
		    	}

		    	if((phone.trim().length < 6)  || (phone.trim().length >15))
				 {
			        alert("Phone no should be greater than 6 digits and less than 15 digits"); 
	        return false;
	    }
					

		    	 if(!(weeklyOffOn.match(letter)) && weeklyOffOn.length!=0)  
		    	 {  
		    	    alert('Please enter character value for weekly Off/On');  
		    	 return false;  
		    	 }

		    	 if(isNaN(alternateNumber))
					{
						alert("Please enter numeric value for alternate number");
						return false;
					}
		    	 if(isNaN(noofunits))
					{
						alert("Please enter numeric value for no. of unit");
						return false;
					}

	          
	            var agree=confirm(" CompanyName: "+companyName+"\n Contact Person : "+contactPerson+"\n Email: "+email+"\n Mobile: "+mobile+"\n\nAre you sure you want to continue with these values?");
	    		if (agree)
	    			return true ;
	    		else
	    			return false ;
		          
	}

	function showentryform()
	{
		
		document.getElementById("newcity").style.display="";
		document.getElementById("f10").style.display="";
		document.getElementById("f11").style.display='none';
		
		//document.getElementById("city").value='-';
		//document.addOpportunity.city.style.visibility="hidden";
	}
function showminus(id)
{
	document.getElementById("f10").style.display='none';
	document.getElementById("newcity").style.display='none';
	
	document.getElementById("f11").style.display="";
	document.getElementById("newcity").value="";
	
	//document.addOpportunity.city.style.visibility="visible";
	
}

	function getClient1(id)
	{ 
		//alert("in2 get"+id);

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


			//alert("in2 get"+id);
			    
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
		//document.getElementById("f1").style.display='none';
		document.getElementById("mobileno2").style.display='none';
		document.getElementById("f2").style.display="";
		document.getElementById("f3").style.display="";
		document.getElementById("f4").style.display='none';
		
		
	    }
	}

	function mob1()
	{

	//alert("hi");
		var phno=document.getElementById("phone").value;
		//alert(phno);
		if(!(phno ==0))
		{
			
			 if(isNaN(phno))
				{
					alert("Please enter numeric value for mobile number");
					return false;
				}
			
				 if((phno.trim().length <6)  || (phno.trim().length >15))
					 {
				        alert("Mobile no should be greater than 6 digits and less than 15 digits"); 
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
					return false;
				}
			
				 if((phno.trim().length < 6)  || (phno.trim().length >15))
					 {
				        alert("Mobile no should be greater than 6 digits and less than 15 digits"); 
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
					return false;
				}
			
				 if((phno.trim().length < 6)  || (phno.trim().length >15))
					 {
				        alert("Mobile no should be greater than 6 digits and less than 15 digits"); 
		        return false;
		    }
		}



			
	}


	function showcountry()
	{
		document.getElementById("newcountry").style.visibility="visible";
	}
	//if (document.all || document.getElementById)
	//	document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
</script>
 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null;
		Statement st2 = null;
		String selectedName;
		String FollowUpType = "";String company="";
	%>
	<%
		if (null == request.getParameter("repName"))
				selectedName = "All";
		else
				selectedName = request.getParameter("repName");

		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			}
		if (null == request.getParameter("division"))
				selectedName = "All";
			else
				selectedName = request.getParameter("division");
	%>
	
<%
String save=request.getParameter("ck");
//String compreturn=request.getParameter("companyName");
System.out.println("value of ck is " +save);
//System.out.println("value of compreturn is " +compreturn);

if(save!=null)
{
	%>
	<script type="text/javascript">
	alert("Opportunity saved successfully in system.");
	
	try{
	window.location="addOpportunity.jsp?companyName="+request.getParameter("companyName");
	}catch(e)
	{
		//alert(e);
	}
	</script>
	<%
} 
 		 %> 
	
	<div style="background-color:#E1F3F3;">
	 <div style="background-color:#2678B7;height:27;width:100%; "> 
            
            <table style="width: 100%">
            <tr>
            
            	<td align="center" colspan="4"><font face="Arial" color="white" size="3"><b>
							
						Add New Opportunity</b></font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="white">(<font color="red"> *</font> indicates mandatory fields)</font></br>
							</td>
            
       </tr>
            </table>
            </div>
            <br></br>
	
	<form name="addOpportunity" method="post" action="InsertOpportunity.jsp"  onSubmit="return validate();" >
	
	<table  cellpadding="" align="center" border="0" width="90%" style="background: ">
		<tr>
			<td style="width: 17%" align="left">
			<div id="repName"><b><font face="Arial" size="2" color="black">Marketing Rep. Name :</font></b></div> 
			</td>
			<td >
			<div id="repName"><input type="text" name="repName" id=""  value="<%=session.getAttribute("EmpName").toString() %>" readonly="readonly"/>
			</div>
			</td>
</tr><tr>
			<td style="width: 10%" align="left"><b><font face="Arial" size="2" color="black">Company Name : </font></b></td>
			<td align="left" style="width: 15%">
			
			<input type="text" name="companyName" style="width: 350px;"  id="companyName" value="<%=request.getParameter("companyName")%>" readonly="readonly"/>
         
			</td>
			<td  align="left" style="width: 14%"><br></br><font face="Arial" size="2" color="black"><b>Contact Person :</b> </font><font size="2" color="red">*</font><br></br></td>
			<td style="width: 30%">
			<div id="contactPerson">
			 <select  id="element_4" name="element_4" style="border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; width: 12%; height: 25%;">
		      <option value="Mr." selected="selected">Mr.</option>
		      <option value="Mrs." >Mrs.</option>
		      <option value="Ms.">Ms.</option>
		      <option value="Dr.">Dr.</option>
		      <option value="M/s.">M/s.</option>
		      </select>
			
			 <input type="text" name="contactPerson"
				  style="width:300px ;" /> </div>
				</td>
			
		</tr>

<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>WebSite :</b></font></td>
			<td>
			<div id="website"><input type="text" name="website"
				   /></div></td>
				   <td  align="left"><font face="Arial" size="2" color="black"><b>Designation :</b></font></td>
			<td>
			<div id="designation"><input type="text" name="designation"
				   /></div></td>
		
		</tr>
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Opportunity Code :</b></font><font color="red"> *</font></td>
			<td>
			<input type="text" name="ocode" id="ocode"/>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Opportunity Name :</b></font><font color="red"> *</font></td>
			<td align="left">
			<input type="text" name="oname" id="oname"/>
			</td>
		</tr>



	  	<tr>
		<%
		System.out.println("usr level  -> "+session.getAttribute("userLevel").toString());
		if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>

		<td  align="left">
			<div id='repName'><b><font face="Arial" size="2" color="black">Assign To :</font></b></div>
			</td>
			<td>
				<select
						name="assignTo" id="assignTo"    style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "
						 >
						<%
							String sql = "select MarketingRepName ,MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
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
			</td>
			<td><b><font face="Arial" size="2" color="black">Lead Reference</font></b></td>
			<td><input type="text" name="leadRef"     /></td></tr>
		
		<%} else{%><tr>
		<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
		<input type="hidden" name="assignTo" value="<%=session.getAttribute("EmpName").toString() %>"  />
		
		<td><font face="Arial" size="2" color="black"><b>Lead Reference :</b></font></td>
			<td><input style="width: 240px" type="text" name="leadRef"     /></td>
		
		<%} %>
		
		</tr>
		
		
			
		
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>E-mails : </b></font><font size="2" color="red">*</font><br>(add comma seprated<br> Id's if more than one)</td>
			<td>
			<div id="email">
<textarea
										name="email" rows="3" 
										style='width: 375px; height: auto;'></textarea>
</div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Address :</b></font></td>
			<td>
			<div id="address">
				<textarea
										name="address" rows="3" 
										style='width: 375px; height: auto;'></textarea>
			</div>
			</td>
		</tr>

		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>City :</b></font></td>
			<td>
			
			<select name="city" id="city" style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown1="SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo ";
				  ResultSet rsDropdown1=st2.executeQuery(sqlDropdown1);
				  while(rsDropdown1.next()){
				  %>
				  <option><%=rsDropdown1.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				
				<a href="#" style="font-weight: bold; color: blue;" id="f11" onclick="showentryform()">Add City</a>
			
			
			</td>
			
			
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>ZipCode :</b></font></td>
			<td align="left">
			<div id="zip"><input type="text" name="zip" 
				  /></div>
			</td>
		</tr>
		<tr>
		<td></td><td>
		<input type="text"  name="newcity" id="newcity" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f10" onclick="showminus('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>

		<tr>
<!--			<td  align="left"><font face="Arial" size="2" color="black"><b>State :</b></font></td>-->
<!--			<td><div id="state">-->
<!--				<input type="text" name="state" -->
<!--				  /></div>-->
<!--			</td>-->

<td  align="left"><font face="Arial" size="2" color="black"><b>State :</b></font></td>
			<td><div id="state">
<!--				<input type="text" name="state" />-->
				  <select  	style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; " name="state">
<option value="">Select</option>
<option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
<option value="Andhra Pradesh">Andhra Pradesh</option>
<option value="Arunachal Pradesh">Arunachal Pradesh</option>
<option value="Assam">Assam</option>
<option value="Bihar">Bihar</option>
<option value="Chandigarh">Chandigarh</option>
<option value="Chhattisgarh">Chhattisgarh</option>
<option value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</option>
<option value="Daman and Diu">Daman and Diu</option>
<option value="Delhi">Delhi</option>
<option value="Goa">Goa</option>
<option value="Gujarat">Gujarat</option>
<option value="Haryana">Haryana</option>
<option value="Himachal Pradesh">Himachal Pradesh</option>
<option value="Jammu and Kashmir">Jammu and Kashmir</option>
<option value="Jharkhand">Jharkhand</option>
<option value="Karnataka">Karnataka</option>
<option value="Kerala">Kerala</option>
<option value="Lakshadweep">Lakshadweep</option>
<option value="Madhya Pradesh">Madhya Pradesh</option>
<option value="Maharashtra">Maharashtra</option>
<option value="Manipur">Manipur</option>
<option value="Meghalaya">Meghalaya</option>
<option value="Mizoram">Mizoram</option>
<option value="Nagaland">Nagaland</option>
<option value="Orissa">Orissa</option>
<option value="Pondicherry">Pondicherry</option>
<option value="Punjab">Punjab</option>
<option value="Rajasthan">Rajasthan</option>
<option value="Sikkim">Sikkim</option>
<option value="Tamil Nadu">Tamil Nadu</option>
<option value="Tripura">Tripura</option>
<option value="Uttaranchal">Uttaranchal</option>
<option value="Uttar Pradesh">Uttar Pradesh</option>
<option value="West Bengal">West Bengal</option>
</select>
<!-- Script by hscripts.com -->
				  
				  </div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Country :</b></font></td>
			<td><div id="country">
				<input type="text" name="country" 
				  /></div>
			
				</div>
			<!--	<a href="#" onclick="showcountry()">Add Country</a>
				
				<div id="newcountry">
			<div id="country"><input type="text" name="country"
				   /></div>
			</div>
			<script>document.getElementById("newcountry").style.visibility="hidden";</script>
				-->
				</td>
		</tr>

		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Mobile No :</b> </font><font size="2" color="red">*</font> </td>
			<td>
			<div id="phone"><input type="text" name="phone" style="width: 250px;"
				   />		<a href="#" style="font-weight: bold; color: blue; " id="f1" onclick="getClient1('+')"><font   size="3" >(+)</font></a></div>
				   		
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Fax No :</b></font></td>
			<td align="left">
			<div id="fax"><input type="text" name="fax" 
				  /></div>
			</td>
		</tr>
		<tr>
		<td></td><td>
				
		<input type="text" id="mobileno1" name="mobileno1" id="mobileno1" style="width: 250px;display: none;" onchange="mob2();" /><a href="#" style="font-weight: bold; color: blue;display: none " id="f2" onclick="getClient2('+')"><font   size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue;display: none " id="f3" onclick="getClient2('-')"><font  size="3" >(-)</font></a>
				</td></tr><tr><td></td><td><input type="text" id="mobileno2" name="mobileno2" id="mobileno2" style="width: 250px;display: none;" onchange="mob3();" /><a href="#" style="font-weight: bold; color: blue;display: none " id="f4" onclick="getClient3('-')"><font  size="3" >(-)</font></a>
				</td></tr>

		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>STD Code :</b></font></td>
			<td>
			<div id="std"><input type="text" name="std"
				   /></div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Phone Number :</b></font><font color="red"> *</font></td>
			<td align="left">
			<div id="ph"><input type="text" name="ph" 
				  /></div>
			</td>
		</tr>
		
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Category :</b></font></td>
			<td>
			<div id="category">
			
			<select name="category" style="
				  	width: 185px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="0">Select</option>
				  <% String sqlDropdown="SELECT TheGroupName,TheGroupCode FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where IsDataValid='1' order by TheGroupName";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  while(rsDropdown.next()){
				  %>
				  <option value="<%=rsDropdown.getString(2)%>">
				  <%=rsDropdown.getString(1)%></option>
							
						<% 	}%> 
				</select>
				</div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Intrested In Product :</b></font></td>
			<td align="left">
			<div id="product"><input type="text" name="product"
				   /></div>
			</td>
		</tr>
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Weekly Off On :</b></font></td>
			<td>
			<div id="weeklyOffOn"><input type="text" name="weeklyOffOn"
				   /></div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Alternate Number :</b></font></td>
			<td align="left">
			<div id="alternateNumber"><input type="text" name="alternateNumber"
				   /></div>
			</td>
		</tr>
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Potential Value :</b><br>(in Rs.)</br></font></td>
			<td>
			<div id="potentialValue"><input type="text" name="potentialValue"
				   /></div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Comments :</b></font></td>
			<td align="left">
			<div id="comments">
				<textarea
										name="comments" rows="3" 
										style='width: 375px; height: auto;'></textarea>
			</div>
			</td>
		</tr>

		<tr>
	
		<td  align="left"><font face="Arial" size="2" color="black"><b>No Of Units :</b></font></td>
			<td>
			<div id="noofunits"><input type="text" name="noofunits"
				   value="0"/></div>
			</td>

		</tr>

		<tr></tr>
		
		<tr>

			<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
		</tr>
	<tr>
	<td></td>
	
	</tr>

	</table>
 
	</form>
	


	<br>
	<br>
	<br>
	<br>
          	<br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div></div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>