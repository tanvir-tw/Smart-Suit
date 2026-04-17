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
    }"WebContent/addNewCustomer.jsp"
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
	 
	function validateProspectes()
	{
		//alert("IN FUNCVOOM     ");
		var prospect=document.addCustomer.companyName.value;
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
				document.addCustomer.companyName.value="";
				document.getElementById("comlist").style.display='none';
			  }
			 
			}
		
		}
		
		var queryString = "?prospect=" +prospect;
		ajaxRequest.open("GET", "AjaxCheckForCustomer.jsp" + queryString, true);
		ajaxRequest.send(null); 
			
	}
	
	function validateEdit()
	{
		
		   var marketingRep=document.editCustomer.repName.value;//alert(marketingRep);
		   var companyName=document.editCustomer.companyNameafteredit.value;//alert(companyName);
		   var contactPerson=document.editCustomer.contactPerson.value;//alert(contactPerson);
		   var website=document.editCustomer.website.value;//alert(website);
		   var email=document.editCustomer.email.value;//alert(email);
		   var address=document.editCustomer.address.value;//alert(address);
		   var city=document.editCustomer.city.value;//alert(city);
		   var zip=document.editCustomer.zip.value;//alert(zip);
		   var country=document.editCustomer.country.value;//alert(country);
		   var mobile=document.editCustomer.phone.value;//alert(phone);
		   var phone=document.editCustomer.ph.value;//alert(phone);
		   var fax=document.editCustomer.fax.value;//alert(fax);
		   var std=document.editCustomer.std.value;
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
	   	var letters1 = /^[A-Z a-z .]+$/;  
		var letters1=letters1.test(contactPerson);
	    if(letters1==false)
	     {     
	         alert('Contact Person must have characters only');  
	          
	       return false;  
	      }  
	
	   	if(companyName==""){
		    	alert("Please enter company name");
	   		return false;
	   	}
	 
	
	   	if(email=="" || mobile=="" ){
		    	alert("Please enter Email-Id or Contact Number");
	   		return false;
	   	}
	    //***************
	    
	    if(isNaN(mobile))
	   				{
						alert("Please enter numeric value for mobile number");
						return false;
					}

		    	 if((mobile!="") && ((mobile.trim().length < 10)  || (mobile.trim().length >15)))
				  {
			        alert("Mobile Number should be greater than 9 digits and less than 15 digits"); 
	                return false;
	                }
	    
	    if(isNaN(phone))
	   				{
						alert("Please enter numeric value for phone number");
						return false;
					}

		    	 if((phone!="") && ((phone.trim().length < 6)  || (phone.trim().length >15)))
				  {
			        alert("Phone Number should be greater than 6 digits and less than 15 digits"); 
	                return false;
	                }

		    	
				  if(isNaN(std))
	   				{
						alert("Please enter numeric value for std number");
						return false;
					}

		    	 if((std!="") && ((std.trim().length < 3)  || (std.trim().length >5)))
				  {
			        alert("STD Number should be greater than 2 digits and less than 6 digits"); 
	                return false;
	                }
	    	    
	    //***************
	var sss=validateEmail(email);
			if(!sss)
			{
				alert("Please enter valid Email Id");
				return false;
			} 
	    			var at="@";
			   		var dot=".";
			   		var comaa=",";
			   		var lat=email.indexOf(at);
			   		var lstr=email.length;
			   		var ldot=email.indexOf(dot);
			   		var lcomaa=email.indexOf(comaa);
			   		if (email.indexOf(at)==-1 && email!="" && email.indexOf(dot)==-1 && email.indexOf(comaa)==-1){
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
	           var agree=confirm(" CompanyName: "+companyName+"\n Contact Person : "+contactPerson+"\n Email: "+email+"\n Mobile: "+mobile+"\n\nDo you want to Update prospect?");
	   		if (agree)
	   			return true ;
	   		else
	   			return false ;
	
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
	      }// if
	      return true;
	    }

		
	return false;
		}
	}
	
	
	//Validation For Add New Prospect
	
	function ValidateContactPerson()
	{
		document.getElementById("lblContactMsg1").style.display="none";
		document.getElementById("lblContactMsg2").style.display="none";
		var contactPerson=document.addCustomer.contactPerson.value;//alert("3"+contactPerson);
		 var invalid=/[^A-Za-z\s]/;
			var oth=contactPerson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
					if(contactPerson=="" || oth==""){
						document.getElementById("lblContactMsg1").style.display="";
		 	    		return false;
		 	    	}
				 if(invalid.test(contactPerson)){
					 document.getElementById("lblContactMsg2").style.display="";
		   	    	     return false;
		   	    	 }	
	}
	function ValidateLead()
	{
		document.getElementById("lblLeadMsg1").style.display="none";
		 var lead=document.addCustomer.leadRef.value;
		 var invalid=/[^A-Za-z\s]/;
			var oth=lead.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
				 if(invalid.test(lead)){
						document.getElementById("lblLeadMsg1").style.display="";
		   	    	     return false;
		   	    	 }	

	}
	function ValidateEmailField()
	{
		document.getElementById("lblEmailMsg1").style.display="none";
		document.getElementById("lblEmailMsg2").style.display="none";

		
		var email=document.addCustomer.email.value;//alert("5"+email);
		var othe=email.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

if(email=="" || othe=="")
		    	{
	document.getElementById("lblEmailMsg1").style.display="";
		    		return false;
		    	}

	var sss=validateMultipleEmailsCommaSeparated(email);
			if(!sss)
			{
				document.getElementById("lblEmailMsg2").style.display="";
				return false;
			} 
		       	var at="@";
		   		var dot=".";
		   		var comaa=",";
		   		var lat=email.indexOf(at);
		   		var lstr=email.length;
		   		var ldot=email.indexOf(dot);
		   		var lcomaa=email.indexOf(comaa);
		   		if (email.indexOf(at)==-1 && email!="" && email.indexOf(dot)==-1 && email.indexOf(comaa)==-1){
		   		   alert("Invalid E-mail ID");
		   		   return false;
		   		}
	    	
	}
	function ValidateZip()
	{
		document.getElementById("lblZipMsg1").style.display="none";

		var zip=document.addCustomer.zip.value;//alert("8"+zip);
		 if(isNaN(zip))
						{
							document.getElementById("lblZipMsg1").style.display="";

							return false;
						}
	}
	function ValidateCountry()
	{
		document.getElementById("lblConMsg1").style.display="none";
		var country=document.addCustomer.country.value;//alert("10"+country);
		var letter = /^[A-Za-z]+$/;
	
		if(!(country.match(letter)) && country.length!=0)  
	    	 {  
			document.getElementById("lblConMsg1").style.display="";
	    	 return false;  
	    	 }
	
	}
	function ValidateMobile()
	{
		
		document.getElementById("lblMoNoMsg1").style.display="none";
		document.getElementById("lblMoNoMsg2").style.display="none";
		document.getElementById("lblMoNoMsg3").style.display="none";

		var mobile=document.addCustomer.phone.value;//alert("11"+phone);
		if(!(mobile ==0))
				{
					 if(isNaN(mobile))
						{
							document.getElementById("lblMoNoMsg1").style.display="";
							return false;
						}	
						 if((mobile.trim().length < 10)  || (mobile.trim().length >15))
							 {
							 document.getElementById("lblMoNoMsg2").style.display=""; 
				        return false;
				    }
				}
				else
				{
					mobile="";
					document.getElementById("lblMoNoMsg3").style.display="";
				    return false;	
				}


	}
	function ValidateSTD()
	{
		document.getElementById("lblStdMsg1").style.display="none";
		document.getElementById("lblStdMsg2").style.display="none";
		
		 var std=document.addCustomer.std.value;//alert("18"+std);
    	 if(isNaN(std))
					{
				    		 document.getElementById("lblStdMsg1").style.display="";
    							return false;
					}
		    	if(std.length>5)
				{	
		    		document.getElementById("lblStdMsg2").style.display="";
					return false;
				}		    
		    
	}
	function ValidationWeek()
	{
		document.getElementById("lblWoffMsg1").style.display="none";
		 var weeklyOffOn=document.addCustomer.weeklyOffOn.value;//alert("16"+weeklyOffOn);
		 var letter = /^[A-Za-z]+$/;
		 	 if(!(weeklyOffOn.match(letter)) && weeklyOffOn.length!=0)  
		 		    	 {  
					 		document.getElementById("lblWoffMsg1").style.display="";
		 		    	 return false;  
		 		    	 }

	}
	function ValidationPay()
	{
		document.getElementById("lblPayMsg1").style.display="none";
		 var payment=document.addCustomer.payment.value;
		 if(isNaN(payment))
	    			 {
						 document.getElementById("lblPayMsg1").style.display="";						
						 return false;
	    			 }
	    	
	}
	function ValidationUnit()
	{
		document.getElementById("lblUntMsg1").style.display="none";

		  var noofunits=document.addCustomer.noofunits.value;
			 if(isNaN(noofunits))
						{
							document.getElementById("lblUntMsg1").style.display="";
							return false;
						}
		   
	}
	function BranchValidate()
	{
		document.getElementById("lblBNMsg1").style.display="none";
		var BranchM=document.addCustomer.BranchMaster.value;
		if(BranchM=="Select")
			{
				document.getElementById("lblBNMsg1").style.display="";
				return false; 
			}
	}
	function validate()
	{
		document.getElementById("lblBNMsg1").style.display="none";
		var BranchM=document.addCustomer.BranchMaster.value;
		if(BranchM=="Select")
			{
				document.getElementById("lblBNMsg1").style.display="";
				return false; 
			}
		
		var prospect=document.addCustomer.companyName.value;
		var letters1 = /^[A-Z a-z 0-9]+$/;  
		var letters1=letters1.test(prospect);
	
		//alert("IN FUNCVOOM     ");
		
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
			document.getElementById("lblCompMsg2").style.display="none";

			if(ajaxRequest.readyState == 4)
			{//alert("######################### ");
				
			   var reselt=ajaxRequest.responseText;
		//	   alert("Original result     "+reselt);
				var finalres=reselt.trim();	
			//	alert("After trim      "+reselt);
		
			if(finalres=="Yes")
			  {
				document.getElementById("lblCompMsg2").style.display="";
				document.addCustomer.companyName.value="";
				document.getElementById("comlist").style.display='none';
			  }

			}
		
		}
		
		var queryString = "?prospect=" +prospect;
		ajaxRequest.open("GET", "AjaxCheckForCustomer.jsp" + queryString, true);
		ajaxRequest.send(null); 

		var collectstaff=document.addCustomer.CollectionStaff.value;
		if(collectstaff=="Select")
			{
				alert("Please Select Collection Staff");
				return false; 
			}
		
		
		document.getElementById("lblContactMsg1").style.display="none";
			document.getElementById("lblContactMsg2").style.display="none";
			var contactPerson=document.addCustomer.contactPerson.value;//alert("3"+contactPerson);
			 var invalid=/[^A-Za-z\s]/;
				var oth=contactPerson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
						if(contactPerson=="" || oth==""){
							document.getElementById("lblContactMsg1").style.display="";
			 	    		return false;
			 	    	}
					 if(invalid.test(contactPerson)){
						 document.getElementById("lblContactMsg2").style.display="";
			   	    	     return false;
			   	    	 }	
		
			document.getElementById("lblLeadMsg1").style.display="none";
			 var lead=document.addCustomer.leadRef.value;
			 var invalid=/[^A-Za-z\s]/;
				var oth=lead.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
					 if(invalid.test(lead)){
							document.getElementById("lblLeadMsg1").style.display="";
			   	    	     return false;
			   	    	 }	

			document.getElementById("lblEmailMsg1").style.display="none";
			document.getElementById("lblEmailMsg2").style.display="none";

			
			var email=document.addCustomer.email.value;//alert("5"+email);
			var othe=email.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

	if(email=="" || othe=="")
			    	{
		document.getElementById("lblEmailMsg1").style.display="";
			    		return false;
			    	}

		var sss=validateMultipleEmailsCommaSeparated(email);
				if(!sss)
				{
					document.getElementById("lblEmailMsg2").style.display="";
					return false;
				} 
			       	var at="@";
			   		var dot=".";
			   		var comaa=",";
			   		var lat=email.indexOf(at);
			   		var lstr=email.length;
			   		var ldot=email.indexOf(dot);
			   		var lcomaa=email.indexOf(comaa);
			   		if (email.indexOf(at)==-1 && email!="" && email.indexOf(dot)==-1 && email.indexOf(comaa)==-1){
			   		   alert("Invalid E-mail ID");
			   		   return false;
			   		}
		    	
			document.getElementById("lblZipMsg1").style.display="none";

			var zip=document.addCustomer.zip.value;//alert("8"+zip);
			 if(isNaN(zip))
							{
								document.getElementById("lblZipMsg1").style.display="";

								return false;
							}

			 document.getElementById("lblConMsg1").style.display="none";
			var country=document.addCustomer.country.value;//alert("10"+country);
			var letter = /^[A-Za-z]+$/;
		
			if(!(country.match(letter)) && country.length!=0)  
		    	 {  
				document.getElementById("lblConMsg1").style.display="";
		    	 return false;  
		    	 }
		
			
			document.getElementById("lblMoNoMsg1").style.display="none";
			document.getElementById("lblMoNoMsg2").style.display="none";
			document.getElementById("lblMoNoMsg3").style.display="none";

			var mobile=document.addCustomer.phone.value;//alert("11"+phone);
			if(!(mobile ==0))
					{
						 if(isNaN(mobile))
							{
								document.getElementById("lblMoNoMsg1").style.display="";
								return false;
							}	
							 if((mobile.trim().length < 10)  || (mobile.trim().length >15))
								 {
								 document.getElementById("lblMoNoMsg2").style.display=""; 
					        return false;
					    }
					}
					else
					{
						mobile="";
						document.getElementById("lblMoNoMsg3").style.display="";
					    return false;	
					}
			
			document.getElementById("lblStdMsg1").style.display="none";
			document.getElementById("lblStdMsg2").style.display="none";
			
			 var std=document.addCustomer.std.value;//alert("18"+std);
	    	 if(isNaN(std))
						{
					    		 document.getElementById("lblStdMsg1").style.display="";
	    							return false;
						}
			    	if(std.length>5)
					{	
			    		document.getElementById("lblStdMsg2").style.display="";
						return false;
					}		    
			    
			document.getElementById("lblWoffMsg1").style.display="none";
			 var weeklyOffOn=document.addCustomer.weeklyOffOn.value;//alert("16"+weeklyOffOn);
			 var letter = /^[A-Za-z]+$/;
			 	 if(!(weeklyOffOn.match(letter)) && weeklyOffOn.length!=0)  
			 		    	 {  
						 		document.getElementById("lblWoffMsg1").style.display="";
			 		    	 return false;  
			 		    	 }

			document.getElementById("lblPayMsg1").style.display="none";
			 var payment=document.addCustomer.payment.value;
			 if(isNaN(payment))
		    			 {
							 document.getElementById("lblPayMsg1").style.display="";						
							 return false;
		    			 }
		    	
			document.getElementById("lblUntMsg1").style.display="none";

			  var noofunits=document.addCustomer.noofunits.value;
				 if(isNaN(noofunits))
							{
								document.getElementById("lblUntMsg1").style.display="";
								return false;
							}
}
//End of Validation of Add New Prospect



	function showentryform()
	{
		
		document.getElementById("city").disabled = true;
		document.getElementById("newcity").style.display="";
		document.getElementById("Lblnewcity").style.display="";
		
		document.getElementById("f10").style.display="";
		document.getElementById("f11").style.display='none';
		
		//document.getElementById("city").value='-';
		//document.addCustomer.city.style.visibility="hidden";
	}
function showminus(id)
{
	document.getElementById("city").disabled = false;
	document.getElementById("f10").style.display='none';
	document.getElementById("newcity").style.display='none';
	document.getElementById("Lblnewcity").style.display='none';
	
	
	document.getElementById("f11").style.display="";
	document.getElementById("newcity").value="";
	
	//document.addCustomer.city.style.visibility="visible";
	
}

	function getClient1(id)
	{ 
		//alert("in2 get"+id);

		if(id=="+")
	    {
		document.getElementById("f1").style.display='none';
		document.getElementById("mobileno1").style.display='';
		document.getElementById("Lblmobileno1").style.display='';
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
		document.getElementById("Lblmobileno2").style.display='';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f4").style.display="";
		
		
	    }
		else{


			//alert("in2 get"+id);
			    
			document.getElementById("f1").style.display="";
			document.getElementById("mobileno1").style.display='none';
			document.getElementById("Lblmobileno1").style.display='none';
			
			
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
		document.getElementById("Lblmobileno2").style.display='none';
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
			
				 if((phno.trim().length < 10)  || (phno.trim().length >15))
					 {
				        alert("Mobile no should be greater than 9 digits and less than 15 digits"); 
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
			
				 if((phno.trim().length < 10)  || (phno.trim().length >15))
					 {
				        alert("Mobile no should be greater than 9 digits and less than 15 digits"); 
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
			
				 if((phno.trim().length < 10)  || (phno.trim().length >15))
					 {
				        alert("Mobile no should be greater than 9 digits and less than 15 digits"); 
		        return false;
		    }
		}



			
	}
function hidebox()
{
//	document.getElementById("list").style.display='none';
}



	
	function showcountry()
	{
		document.getElementById("newcountry").style.visibility="visible";
	}
	//if (document.all || document.getElementById)
	//	document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
	
	
	
	
	function validateEmail(field) { 

    var regex=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i; 

    return (regex.test(field)) ? true : false; 

} 

 

function validateMultipleEmailsCommaSeparated(value) { 

    var result = value.split(","); 

    for(var i = 0;i < result.length;i++) 

    if(!validateEmail(result[i]))  

            return false;                

    return true; 

} 
	
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
//String save=request.getParameter("ck");
//System.out.println("value of ck is " +save);
//if(save!=null)
//{
//msg printed as details saved successfully.	
//String msg=request.getParameter("msg");
//System.out.println("msg is " +msg);
//if(msg!=null)
//{
	
//}	
	%>
	
	<%
//} 
 		 %> 





<% if(request.getParameter("companyName")==null){ %>
	
	<div style="background-color:#E1F3F3;">
	 <div style="background-color:#2678B7;height:27;width:100%; "> 
            
            <table style="width: 100%">
            <tr>
            
            	<td align="center" colspan="4"><font face="Arial" color="white" size="3"><b>
							
						Add New Prospect</b></font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" color="white" >(<font color="red"> *</font> indicates mandatory fields)</font></br>
							</td>
            
       </tr>
            </table>
            </div>
	<form name="addCustomer" method="post" action="addCustomer.jsp" onclick="hidebox();" onsubmit="return validate();" ONKEYDOWN="if (event.keyCode == 27){document.getElementById('comlist').style.display = 'none';}" >
	<br></br>
	<table  cellpadding="" align="center" border="0" width="90%" style="background: ">
		<tr>
			<td style="width: 17%" align="left">
			<div id="repName"><b><font face="Arial" size="2" color="black">Marketing Rep. Name </font></b></div> 
			</td>
			<td >
			<div id="repName"><input type="text" name="repName" id=""  value="<%=session.getAttribute("EmpName").toString() %>" readonly="readonly" style=" width: 250px"/>
			</div>
			</td>
						<td  align="left">
			<div id='repName'><b><font face="Arial" size="2" color="black">Assign To </font></b></div>
			</td>

			<td>
				<select
						name="assignTo" id="assignTo"    style='width: 255px; height: auto;'>
						<%
								String sql = "select MarketingRepName ,MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  WHERE username<>'' and password<>''  order by MarketingRepName";
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
</tr><tr>
	<td><b><font face="Arial" size="2" color="black">Branch Name </font></b><font size="2" color="red">*</font></td>
		<td><div><select name=BranchMaster onblur="BranchValidate();" style="width: 255px">
				<option value="Select">Select</option>
				<% String sqlDropdownB="SELECT Distinct BranchName  FROM "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster order by BranchName asc";
				  ResultSet rsDropdownB=st2.executeQuery(sqlDropdownB);
				  while(rsDropdownB.next()){
				  %>
				  <option value="<%=rsDropdownB.getString(1)%>">
				  <%=rsDropdownB.getString(1)%></option>
							
						<% 	}%></select></div> 
						<label id="lblBNMsg1" style="display: none;"><font face="Arial" size="2" color="red">Select Branch Name First</font></label>
						
						
						</td>
			<td>
			<div id="cstaff"><b><font face="Arial" size="2" color="black">Collection Staff	</font></b><font size="2" color="red">*</font></div> 		
			</td>
			<td>
		<div><select name=CollectionStaff style="width: 255px">
				<option value="Select">Select</option>
				<% String sqlDropdownCS="SELECT Distinct name  FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster order by name asc";
				  ResultSet rsDropdownCS=st3.executeQuery(sqlDropdownCS);
				  while(rsDropdownCS.next()){
				  %>
				  <option value="<%=rsDropdownCS.getString(1)%>">
				  <%=rsDropdownCS.getString(1)%></option>
							
						<% 	}%></select></div> 
				
			</td>
	
</tr><tr>
		<td style="width: 10%" align="left"><b><font face="Arial" size="2" color="black">Company Name : </font></b><font size="2" color="red">*</font></td>
			<td align="left" style="width: 15%">
			<div id="companyName">
			<input type="text" name="companyName" style="width: 250px;"  id="companyName" onkeyup="getProspectes();"  onblur="validateProspectes()" />
			</div>

				
									
			</td>
			<td  align="left" style="width: 14%"><font face="Arial" size="2" color="black"><b>Contact Person </b> </font><font size="2" color="red">*</font></td>
			<td style="width: 30%">
			
<div>					
			<select  id="element_4" name="element_4" style='width: 12%; height: auto;'>
		      <option value="Mr." selected="selected">Mr.</option>
		      <option value="Mrs." >Mrs.</option>
		      <option value="Ms.">Ms.</option>
		      <option value="Dr.">Dr.</option>
		      <option value="M/s.">M/s.</option>
		      </select>
	 <input type="text" name="contactPerson" onblur="return ValidateContactPerson();" onchange="return ValidateContactPerson();" style="width:200px ;"/> </div>
				<label id="lblContactMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Contact Person Name</font></label>
				<label id="lblContactMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Contact Person..</font></label>
				</td>
		</tr>
<tr id = "comlist"  style="display:none;" >
<td></td>
						<td align="left"  valign="top"   colspan="1" style="text-align: center;margin-left:10% ;" >
						<div align="left" style="border: thin;margin-right: 32%"> 
						<div id='list' style="background-color: white;height: auto; width: 250px; overflow: auto; border:solid inset;" align="left">
						
						</div>
							</div>
						</td>
						</tr>
		<tr>
		<td  align="left"><font face="Arial" size="2" color="black"><b>E-mails </b></font><font size="2" color="red">*</font></td>
			<td>
			<div id="email">
<textarea
										name="email" rows="3" onblur="return ValidateEmailField();" onchange="return ValidateEmailField();"
										style='width: 250px; height: 50px;'></textarea><br>(add comma seprated Id's if more than one)
</div>
										<label id="lblEmailMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Email-Id</font></label>
										<label id="lblEmailMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Valid Email Id</font></label>

			</td>					
		
			<td  align="left"><font face="Arial" size="2" color="black"><b>Mobile No </b> </font><font size="2" color="red">*</font> </td>
			<td>
			<div id="phone"><input type="text" name="phone" onblur="return ValidateMobile();" style="width: 250px;" 
				   />		<a href="#" style="font-weight: bold; color: blue; " id="f1" onclick="getClient1('+')"><font   size="3" >(+)</font></a></div>
										<label id="lblMoNoMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Mobile Number</font></label>
										<label id="lblMoNoMsg2" style="display: none;"><font face="Arial" size="2" color="red">Mobile No Should Be Greater Than 9 Digits and Less Than 15 Digits</font></label>
										<label id="lblMoNoMsg3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Mobile Number</font></label>
				   		
			</td>
		</tr>
		<tr>
		<td></td><td></td><td><label id="Lblmobileno1" style="display: none;"><b><font face="Arial" size="2" color="black">Mobile No. 1</font></b></label></td><td>
				
		<input type="text" id="mobileno1" name="mobileno1" id="mobileno1"  style="width: 250px;display: none;" onchange="mob2();" /><a href="#" style="font-weight: bold; color: blue;display: none " id="f2" onclick="getClient2('+')"><font   size="3" >(+)</font></a><a href="#" style="font-weight: bold; color: blue;display: none " id="f3" onclick="getClient2('-')"><font  size="3" >(-)</font></a>
				</td></tr><tr><td></td><td></td><td><label id="Lblmobileno2" style="display: none;"><b><font face="Arial" size="2" color="black">Mobile No. 2</font></b></label></td><td><input type="text" id="mobileno2" name="mobileno2" id="mobileno2" style="width: 250px;display: none;" onchange="mob3();" /><a href="#" style="font-weight: bold; color: blue;display: none " id="f4" onclick="getClient3('-')"><font  size="3" >(-)</font></a>
				</td></tr>
		
	  	<tr>
		<%
		System.out.println("usr level  -> "+session.getAttribute("userLevel").toString());
		if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>

			<td><b><font face="Arial" size="2" color="black">Lead reference</font></b></td>
			<td><div><input type="text" name="leadRef" onblur="return ValidateLead();" onchange="return ValidateLead();" style="width: 250px"/></div>
			<label id="lblLeadMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Lead Reference</font></label></td>
		
		<%} else{%>
		<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>"  />
		<input type="hidden" name="assignTo" value="<%=session.getAttribute("EmpName").toString() %>"  />
		
		<td><font face="Arial" size="2" color="black"><b>Lead reference </b></font></td>
			<td><div><input style="width: 240px" type="text" name="leadRef"  onblur="return ValidateLead();" onchange="return ValidateLead();"    /></div>
			<label id="lblLeadMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Lead Reference</font></label>
			</td>
		
		<%} %>
		
		
			<td  align="left"><font face="Arial" size="2" color="black"><b>WebSite </b></font></td>
			<td>
			<div id="website"><input type="text" name="website" style="width: 250px"
				   /></div></td>
				
		</tr>
		<tr><td><font face="Arial" size="2" color="black"><b>Group of Company</b></font></td>
		<td><input type="text" name="grcomp" id="grcomp" style="width: 250px;"/></td>
		<td><font face="Arial" size="2" color="black"><b>Type of Business </b></td>
				<td><select name=typebusiness style="width: 255px;">
				<option value="Select">Select</option>
				
				<% String sqlDropdownGB="SELECT Distinct loadType  FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster order by loadType asc";
				  ResultSet rsDropdownGB=st2.executeQuery(sqlDropdownGB);
				  while(rsDropdownGB.next()){
				  %>
				  <option value="<%=rsDropdownGB.getString(1)%>">
				  <%=rsDropdownGB.getString(1)%></option>
							
						<% 	}%>
				
				</select></td>
		</tr>
		<tr><td>
		<font face="Arial" size="2" color="black"><b>Dealing in Products</b></font>
		</td>
			<td><select multiple="multiple" name="Productdeal" style=" width: 250Px;">
				<option value="Select">Select</option>
				<% String sqlDropdownP="SELECT Distinct product  FROM "+session.getAttribute("CompanyMasterID").toString()+"productMaster order by product asc";
				  ResultSet rsDropdownP=st2.executeQuery(sqlDropdownP);
				  while(rsDropdownP.next()){
				  %>
				  <option value="<%=rsDropdownP.getString(1)%>">
				  <%=rsDropdownP.getString(1)%></option>
							
						<% 	}%> </select> </td>
		
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>Address </b></font></td>
			<td>
				<textarea
										name="address" rows="3" 
										style='width: 250px; height: 50px;'></textarea>
			</td>
		</tr>

		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>City </b></font></td>
			<td>
			
			<select name="city" id="city" style='width: 200px; height: auto;'>
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
			
			
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>ZipCode </b></font></td>
			<td align="left"><div>
		<input type="text" name="zip" onblur="return ValidateZip();" onchange="return ValidateZip();" style="width: 250px;"
				  /></div>
				  <label id="lblZipMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Zip Code</font></label>
			</td>
		</tr>
		<tr>
		<td><label id="Lblnewcity" style="display: none;"><b><font face="Arial" size="2" color="black">New City</font></b></label></td><td>
		<input type="text"  name="newcity" id="newcity" style="width: 250px; display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f10" onclick="showminus('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>

		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>State </b></td>
			<td><div id="state">
				<select name=state style="width: 255px;">
				<option value="Select">Select</option>
                <option value="Andaman and Nicobar Islands">Andaman and Nicobar
                                                            Islands</option>
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

				 
				</div>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Country </b></font></td>
			<td><div>
				<input type="text" name="country" onblur="return ValidateCountry();" onchange="return ValidateCountry();" style="width: 250px;"
				  /></div>
				  
				  <label id="lblConMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Country</font></label>
			
			
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
			<td  align="left"><font face="Arial" size="2" color="black"><b>STD Code </b></font></td>
			<td>
			<div id="std"><input type="text" name="std" onblur="return ValidateSTD();" onchange="return ValidateSTD();" style='width: 250px;' /></div>
			<label id="lblStdMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For STD Code</font></label>
			<label id="lblStdMsg2" style="display: none;"><font face="Arial" size="2" color="red">STD Cannot Be More Than 5 Digits</font></label>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Phone Number </b></font></td>
			<td align="left">
			<input type="text" name="ph" style="width: 250px;"
				  />
			</td>
		</tr>
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Fax No </b></font></td>
			<td align="left">
			<input type="text" name="fax" style="width: 250px;"
				  />
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Alternate Number </b></font></td>
			<td align="left">
			<input type="text" name="alternateNumber" style="width: 250px;"
				   />
			</td>
</tr><tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Risk Involved </b></td>
			<td>
			<div id="RiskInvolved">
			
			<select name="RiskInvolved" style='width: 255px;'>
			<option value="Select">Select</option>
				  <% String sqlDropdown="SELECT  Distinct riskInvolved FROM "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster order by riskInvolved ";
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  while(rsDropdown.next()){
				  %>
				  <option value="<%=rsDropdown.getString(1)%>">
				  <%=rsDropdown.getString(1)%></option>
							
						<% 	}%> 
				</select>
				</div>
			
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Interested In Product </b></font></td>
			<td align="left">
			<input type="text" name="product" style="width: 250px;"
				   />
			</td>
		</tr>
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Weekly Off</b></font></td>
			<td>
			<div id="weeklyOffOn"><input type="text" name="weeklyOffOn"  onblur="return ValidationWeek();" onchange="return ValidationWeek();" style="width: 250px;"
				   /></div>
				   	<label id="lblWoffMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Weekly Off/On</font></label>
		
			</td>
		
			<td  align="left"><font face="Arial" size="2" color="black"><b>Potential Value </b>(in Rs.)</font></td>
			<td>
			<div id="potentialValue"><input type="text" name="potentialValue" style="width: 250px;"
				   /></div>
			</td>
		</tr>

		<tr>
	<td><font face="Arial" size="2" color="black"><b>Payment Terms (Days)</b></font></td>
	<td><div><input type="text" name="payment" onblur="return ValidationPay();" onchange="return ValidationPay();" style="width: 250px;"/></div>
	<label id="lblPayMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Payment Terms</font></label>
	
	</td>
		<td><font face="Arial" size="2" color="black"><b>No Of Units </b></font></td>
			<td>
			<div id="noofunits"><input type="text" name="noofunits"  onblur="return ValidationUnit();" onchange="return ValidationUnit();" style="width: 250px;"
				   value="0"/></div>
			<label id="lblUntMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For No. of Unit</font></label>
	
			</td>

		</tr>
<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Comments </b></font></td>
			<td align="left">
			<div id="comments">
				<textarea
										name="comments" 
										style='width: 250px;'></textarea>
			</div>
			</td>
		</tr>
		
		<!-- dynamic fields starts from here..-->  
		<%-- 
		<tr>
			<td colspan="4">
				<jsp:include page="ReflectedForm.jsp"/>			
			</td>
		</tr>		
		<br>
		<br> --%>
		<!-- dynamic fields ends here. -->	
		
		
		<tr>
			<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp"  value="Submit" /></div>
			</td>
		</tr>
	

	</table>
 
	</form>
	
<%}else{
	try{
	//String sql="SELECT * FROM t_prospectivecustmaster where CompanyName ='"+request.getParameter("companyName").replaceAll("~~","&")+"' limit 1 ";
	
	String sql="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode ='"+request.getParameter("companyName").replaceAll("~~","&")+"' limit 1 ";
	System.out.println("CHANGED QUERY   "+sql);	
	ResultSet rs1=st.executeQuery(sql);
	rs1.next();
%>
	<div
		style="font-size: 2em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em; background-color:#2678B7; "><font face="Arial" color="white" size="3">
	<b>Edit Prospect  - &nbsp;<%=rs1.getString("CompanyName") %></b></font>&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<form name="editCustomer" method="post" action="addCustomer.jsp?update=true&newcity=&companyName=<%=request.getParameter("companyName").replaceAll("~~","&") %>" onsubmit="return validateEdit();"> 
	<table border="0" cellpadding="3" width="100%" style="background-color: #E1F3F3;">
		<tr>
		
		<td><b><font face="Arial" size="2" color="black">Branch Name</font></b><font size="2" color="red">*</font></td>
		<td><select name=BranchMaster style="width: 255px">
				<option value="Select">Select</option>
				<% String sqlDropdownB="SELECT Distinct BranchName  FROM "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster ";
				  ResultSet rsDropdownB=st2.executeQuery(sqlDropdownB);
				  while(rsDropdownB.next()){
				  %>
 <option value="<%=rsDropdownB.getString(1)%>"<% if(rs1.getString("BranchName").equalsIgnoreCase(rsDropdownB.getString(1))){ %> Selected<%}%>>
				  <%=rsDropdownB.getString(1)%></option>							
						<% 	}%></select> </td>
		
		
		
		<td><b><font face="Arial" size="2" color="black">Collection Staff</font></b><font size="2" color="red">*</font></td>
		<td><select name=CollectionStaff style="width: 255px">
				<option value="Select">Select</option>
				<% String sqlDropdownCCB="SELECT Distinct name  FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster order by name asc";
				  ResultSet rsDropdownCCB=st2.executeQuery(sqlDropdownCCB);
				  while(rsDropdownCCB.next()){
				  %>
 <option value="<%=rsDropdownCCB.getString(1)%>"<% if(rs1.getString("ColloectionStaffName").equalsIgnoreCase(rsDropdownCCB.getString(1))){ %> Selected<%}%>>
				  <%=rsDropdownCCB.getString(1)%></option>							
						<% 	}%></select> </td>
		
		
		
		
		</tr>
		
		
		<tr>
		
					<td  align="left"><b>Company Name </b><font size="2" color="red">*</font></td>
			<td align="left">
			<div id="companyNameafteredit">
			
			<textarea
										name="companyNameafteredit" rows="1" 
										style='width: 250px; height: auto;'><%=rs1.getString("CompanyName") %></textarea>
			</div>
			</td>
			
						<td  align="left"><b>Contact Person </b></td>
			<td>
			<div id="contactPerson">
						<textarea
										name="contactPerson" rows="1" 
										style='width: 250px; height: auto;'><%=rs1.getString("ContactPerson") %></textarea>
			 </div>
			<a href="contactdetails.jsp?customercode=<%=rs1.getString("customercode")%>&companyname=<%=rs1.getString("companyname") %>&Type=Pros" style="font-weight: bold; color: black; " >Add Contacts</a>			 
			</td>
			</tr>
		<tr>
					<td  align="left">
			<div id='repName'><b>Marketing Rep. Name</b></div><font size="2" color="red">*</font>
			</td>
			<td >
			<div id='repName'><input type="text" name="repName" style="border: none;"  value="<%=rs1.getString("CustEnteredByRep") %>"/>
			</div>
			</td>

			<td  align="left"><b>WebSite </b></td>
			<td>
			<div id="website"><input type="text" name="website" style='width: 250px; height: auto;'
				    value="<%=rs1.getString("WebSite") %>" /></div>
			</td>
		</tr>
		

		<tr>
									<td  align="left"><b>Assigned by </b></td>
			 <td>
			<div id="assigned"><input type="text" name="assigned"
				  style='height: 12px; border: none;'  value="<%=rs1.getString("Assighnedby") %>" readonly="readonly" /></div>
		 		<%
		System.out.println("usr level  -> "+session.getAttribute("userLevel").toString());
		if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %>
			
		<td  align="left">
			<div id='repName'><b>Reassign To</b></div>
			</td>
			<td >
				<select
						name="assignTo" id="assignTo"    
				  	style='width: 255px; height: auto;'
						 >
						<%
							  sql = "select MarketingRepName ,MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster order by MarketingRepName";
								ResultSet rs = st2.executeQuery(sql);
								%>
								<option value="<%=rs1.getString("CustEnteredByRep") %>"><%=rs1.getString("CustEnteredByRep")%></option>
								<%
								while (rs.next()) {
						%>
						<option value="<%=rs.getString(1)%>">
							<%=rs.getString(1)%></option>
						<%
							}
						%>
					</select>
					<input type="hidden" name="assignedBy" value="<%=session.getAttribute("EmpName").toString() %>" />
			</td>

			</td>
		</tr>
		<%} else{%><tr><td>
		<input type="hidden" name="assignedBy" value="<%=rs1.getString("Assighnedby") %>"  />
		<input type="hidden" name="assignTo" value="<%=session.getAttribute("EmpName").toString() %>"  />
		<tr></td>
		<%} %>
		
		<tr>
		<td><b>Lead Ref</b></td>
		<td><input type="text" name="leadRef" style='width: 250px; height: auto;'
				  value="<%=rs1.getString("leadRef") %>" /></td>
		
		<td><font face="Arial" size="2" color="black"><b>Group of Company</b></font></td>
		<%
		String Goc="";
		if(rs1.getString("GroupOfCompany") == null )
		{
			Goc="";
		}
		else
		{
			Goc=rs1.getString("GroupOfCompany");
		}
		%>
		
		<td><input type="text" name="grcomp" id="grcomp"  value="<%=Goc%>" style="width: 250px;"/></td>
		
		
		
		</tr>
		<tr>
		<td><font face="Arial" size="2" color="black"><b>Type of Business </b></font><font size="2" color="red">*</font></td>
				<td><select name=typebusiness style="width: 255px;">
				<option value="Select">Select</option>
				
				<% String sqlDropdownGB="SELECT Distinct loadType  FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster ";
				  ResultSet rsDropdownGB=st2.executeQuery(sqlDropdownGB);
				  while(rsDropdownGB.next()){
				  %>
		
		 <option value="<%=rsDropdownGB.getString(1)%>"<% if(rs1.getString("TypeOfBuisness").equalsIgnoreCase(rsDropdownGB.getString(1))){ %> Selected<%}%>>
				  <%=rsDropdownGB.getString(1)%></option>
							
						<% 	}%>
				
				</select></td>
	


<td>
		<font face="Arial" size="2" color="black"><b>Dealing in Products</b></font>
		</td>
			<td><select multiple="multiple" name="Productdeal" style=" width: 250Px;">
				<option value="Select">Select</option>
				<% 
				String DealProd= rs1.getString("DealInProduct");
				String SplitedArray[]=DealProd.split(",");
				for(int i=0;i<SplitedArray.length; i++)
				{
						System.out.println("Splited Array==="+ SplitedArray[i]);
				}
				
				  String sqlDropdownP="SELECT Distinct product  FROM "+session.getAttribute("CompanyMasterID").toString()+"productMaster ";
				  ResultSet rsDropdownP=st2.executeQuery(sqlDropdownP);
				  while(rsDropdownP.next()){
				  System.out.println("Value =========================================="+ rs1.getString("DealInProduct"));
				  %>
				<option value="<%=rsDropdownP.getString(1)%>"<% 
				
						for(int i=0;i<SplitedArray.length; i++)
						{
						
								if(SplitedArray[i].equalsIgnoreCase(rsDropdownP.getString(1))){ %> Selected<%}}%>>
								  <%=rsDropdownP.getString(1)%></option>
						
						<% 	}%> </select> </td>
		
		</tr>
		<tr>
			<td  align="left"><b>E-mails </b><font size="2" color="red">*</font><br>(add comma seprated<br> Id's if more than one)</td>
			<td>
			<div id="email">
<textarea
										name="email" rows="1" 
										style='width: 250px; height: auto;'><%=rs1.getString("EMail") %></textarea>
</div>
			</td>
			<td  align="left"><b>Address </b></td>
			<td>
			<div id="address">
				<textarea
										name="address" rows="2" 
										style='width: 250px; height: auto;'><%=rs1.getString("Address") %></textarea>
			</div>
			<a href="addressdetails.jsp?customercode=<%=rs1.getString("customercode")%>&companyname=<%=rs1.getString("companyname") %>" style="font-weight: bold; color: black; " >Add Address</a>
			</td>
		</tr>
		<tr>
			<td  align="left"><b>City </b></td>
			<td>
			<div id="city"><input type="text" name="city" style='width: 250px; height: auto;'
				  value="<%=rs1.getString("City") %>" /></div>
			</td>
			<td  align="left"><b>ZipCode </b></td>
			<td align="left">
			<div id="zip"><input type="text" name="zip" style='width: 250px; height: auto;'
				  value="<%=rs1.getString("Zip") %>" /></div>
			</td>
		</tr>

		<tr>
			<td  align="left"><b>State </b></td>
			<td>
			<div id="state"><%//rs1.getString("State") %>
			       <select name=state style="width: 255px;">
			       <option value="<%=rs1.getString("State") %>"><%=rs1.getString("State") %></option>
                   <option value="Andaman and Nicobar Islands">Andaman and Nicobar
                                                               Islands</option>
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


			       
				   </div>
			</td>
			<td  align="left"><b>Country </b></td>
			<td align="left">
			<div id="country"><input type="text" name="country" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("Country") %>"  /></div>
			</td>
		</tr>

		<tr>
			<td  align="left"><b>Mobile No</b><font size="2" color="red">*</font></td>
			<td>
			<div id="phone">
			<input type="text" name="phone" style='width: 250px; height: auto;' value="<%=rs1.getString("MobileNo") %>"  /></div></td>
		
			<td  align="left"><b>Fax No </b> </td>
			<td align="left">
			<div id="fax"><input type="text" name="fax" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("Fax") %>"  /></div>
			</td>
		</tr>


		<tr>
			<td  align="left"><b>STD Code</b></td>
			<td>
			<div id="std"><input type="text" name="std" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("STDCode") %>"  /></div>
			</td>
			<td  align="left"><b>Phone Number </b> </td>
			<td align="left">
			<div id="ph"><input type="text" name="ph" style='width: 250px; height: auto;'
				  value="<%=rs1.getString("Phone") %>"  /></div>
			</td>
		</tr>
		
		<tr>
			<td  align="left"><b>Risk Involved </b></td>
			<td>
			<div id="category">
			
			<select name="category" 
				  	style='width: 255px; height: auto;' >
				  	
				  <% String sqlDropdown="SELECT  Distinct riskInvolved FROM "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster order by riskInvolved";
				  System.out.println(sqlDropdown);
				  System.out.println(sqlDropdown+rs1.getString("RiskInvolved"));
				  ResultSet rsDropdown=st2.executeQuery(sqlDropdown);
				  while(rsDropdown.next()){
				  %>
				  <option value="<%=rsDropdown.getString(1)%>"<% if(rs1.getString("RiskInvolved").equalsIgnoreCase(rsDropdown.getString("riskInvolved"))){ %> Selected<%}%>>
				  <%=rsDropdown.getString(1)%></option>
							
						<% 	}%> 
				</select>
				</div>
			</td>
			<td  align="left"><b>Interested In Product</b></td>
			<td align="left">
			<div id="product"><input type="text" name="product" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("IntrestedProduct") %>"  /></div>
			</td>
		</tr>
		<tr>
			<td  align="left"><b>Weekly Off On </b></td>
			<td>
			<div id="weeklyOffOn"><input type="text" name="weeklyOffOn" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("WeeklyOffon") %>"  /></div>
			</td>
			<td  align="left"><b>Alternate Number</b></td>
			<td align="left">
			<div id="alternateNumber"><input type="text" name="alternateNumber" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("TelephoneNo2") %>"  /></div>
			</td>
		</tr>

		<tr>
		
		
			<td  align="left"><b>Potential Value</b><br>(in Rs.)</td>
			<td>
			<div id="potentialValue"><input type="text" name="potentialValue" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("PotentialValue") %>"/></div>
			</td>
			<td  align="left"><b>Comments</b></td>
			<td align="left">
			<div id="comments">
				<textarea
										name="comments" rows="1" 
										style='width: 250px; height: auto;'><%=rs1.getString("Comments") %>
				</textarea>
			</div>
			</td>
		</tr>

		<tr>
		<td><font face="Arial" size="2" color="black"><b>Payment Terms (Days)</b></font></td>
			<%
		String Pt="";
		if(rs1.getString("PayTerms") == null )
		{
			Pt="";
		}
		else
		{
			Pt=rs1.getString("PayTerms");
		}
		%>
		
		
	<td><div><input type="text" name="payment" value='<%=Pt%>'  onblur="return ValidationPay();" onchange="return ValidationPay();" style="width: 250px;"/></div>
	<label id="lblPayMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Payment Terms</font></label>
	
	</td>
		<td  align="left"><b>No Of Units </b> </td>
			<td>
			<div id="noofunits"><input type="text" name="noofunits" style='width: 250px; height: auto;'
				   value="<%=rs1.getString("NoOfUnits") %>"/></div>
			</td>
			</tr><tr>
						<td> <b>Reason for updating<br>this record </br></b><font size="2" color="red">*</font></td>
			<td><textarea
										name="reason" rows="1" 
										style='width: 250px; height: auto;'></textarea></td>

			
			</tr>
		<tr>

			<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
	<input type="hidden" name="vendorcode" value="<%=rs1.getString("VendorCode") %>"/>
	</table>

	</form>

<%}catch(Exception e){System.out.print(e);
e.printStackTrace();
}
	}%>
        
	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>