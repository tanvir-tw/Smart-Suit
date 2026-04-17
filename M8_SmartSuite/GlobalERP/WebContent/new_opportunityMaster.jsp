 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%><table></table>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head></head>
	

	<body onkeypress="hideList(event);" onclick="hideOnClick();">

	<script type="text/javascript">
	var globalcompany;var flag=true;
   /* function hideList(e)
    {
    if(e.which == 0){
    	document.getElementById("ProspectList").style.visibility='hidden';
    }
	}
    function hideOnClick()
    {
        //	document.getElementById("ProspectList").style.visibility='hidden';
	}
	*/
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

		if(document.getElementById("fromdate").value=="")
  				{
  			  		alert("Please Select The From Date");
  					return false;
  				}
  				if(document.getElementById("todate").value=="")
  				{
			  		alert("Please Select The To Date");
  					return false;
  				}
  			//	return datevalidate();
		
		 var marketingRep=document.addOpportunity.repName.value;//alert("1"+marketingRep);
		// alert(marketingRep);
		 var companyName=document.addOpportunity.custName.value;//alert("2"+companyName);
		// alert(companyName);
		// document.addOpportunity.listofcompany.value=companyname;
		// var consigner=document.addOpportunity.consigner.value;//alert("3"+contactPerson);
		
		if(document.getElementById("branch").disabled ==false)
		{
			var branch=document.forms["addOpportunity"]["branch"].value;
			if(branch=="Select"){
				alert("Please Select The Branch");
				return false;
			}
			
		}
		
		if(document.getElementById("billbranch").disabled ==false)
		{
			var billbranch=document.forms["addOpportunity"]["billbranch"].value;
			if(billbranch=="Select"){
				alert("Please Select The Billing Branch");
				return false;
			}
			
		}
		
		//alert(consigner1);
		if(document.getElementById("consigner").disabled ==false)
		{
			var consigner=document.forms["addOpportunity"]["consigner"].value;
			if(consigner=="Select"){
				alert("Please Select The Consignor");
				return false;
			}
			
		} 
		if(document.getElementById("consignee").disabled ==false)
		{
			var consignee=document.forms["addOpportunity"]["consignee"].value;
			if(consignee=="Select"){
				alert("Please Select The Consignee");
				return false;
			}
			
		}

		if(document.getElementById("loadType").disabled ==false)
		{
			var loadType=document.forms["addOpportunity"]["loadType"].value;
			if(loadType=="Select"){
				alert("Please Select The Load Type");
				return false;
			}
			
		}
		if(document.getElementById("frt").disabled ==false)
		{
			var frt=document.forms["addOpportunity"]["frt"].value;
			if(frt=="Select"){
				alert("Please Select The Freight Type");
				return false;
			}
			
		}
		
		
		
		var collectstaff=document.forms["addOpportunity"]["collectionstaff"].value;
		
		if(collectstaff=="Select")
			{
				alert("Please Select Collection Staff");
				return false;	
			}
		
		//alert("Above the consingee");
	/*	if(document.getElementById("consignee").disabled ==true)
		{
			var consignee1=document.forms["addOpportunity"]["consignee1"].value;
			if(consignee1=="" || consignee1==" "){
				alert("Please Enter The Consignee");
				return false;
			}
		}  */  
		
		if(document.getElementById("loadType").disabled ==true)
		{
			var loadType1=document.forms["addOpportunity"]["loadType1"].value;
			if(loadType1=="" || loadType1==" "){
				alert("Please Enter The Load Type");
				return false;
			}
		}
		if(document.getElementById("frt").disabled ==true)
		{
			var frttype=document.forms["addOpportunity"]["frttype"].value;
			if(frttype=="" || frttype==" "){
				alert("Please Enter The Freight Type");
				return false;
			}
		}
		
	
		
		//alert("after the consingee");
	//	 var consigner = document.forms["addOpportunity"]["consigner"].value;
		// alert(consigner);
		// alert(consignee);
		/* if(consigner=="Select"){
			    alert("Please Select The Consignor");
			    return false;
		    }  */
	/*	 var consignee = document.forms["addOpportunity"]["consignee"].value;
		 if(consignee=="Select"){
			    alert("Please Select The Consignee");
			    return false;
		    }  */
		 

		 // alert(consigner);
		 //var consignee=document.addOpportunity.consignee.value;
		 
		 var origin=document.addOpportunity.origin.value;//alert("4"+website);
		 var dest=document.addOpportunity.dest.value;//alert("5"+email);
		 var frt=document.addOpportunity.frt.value;//alert("6"+address);
		 var bsns=document.addOpportunity.bsns.value;//alert("7"+city);
		 var mvt=document.addOpportunity.mvt.value;//alert("8"+zip);
		 var product=document.addOpportunity.product.value;//alert("9"+state);
		 var load=document.addOpportunity.load.value;//alert("10"+country);
		 var trans=document.addOpportunity.trans.value;//alert("11"+phone);
		 var risk=document.addOpportunity.risk.value;//alert("12"+phone);
		 var comm=document.addOpportunity.comm.value;//alert("13"+fax);
		 var remark=document.addOpportunity.remark.value;//alert("14"+category);
		 
		// var from=document.addOpportunity.fromdate.value
			var from=document.forms["addOpportunity"]["fromdate"].value;
		 //var to=document.addOpportunity.todate.value
		 var to =document.forms["addOpportunity"]["todate"].value;
		 alert(from);
		 alert(to);
		 var endDate =new Date.parse(to);
		 var startDate =new Date.parse.Date(from);
		 if(startDate > endDate)
		 {
		 alert("Please Ensure That Valid To Date Is Greater Than Or Equal To Start Date.");
		 document.calldate.next_day.focus();
		 return false;
		 } 
		
		 		
			
		 var oth=contactPerson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var othC=companyName.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var othe=email.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var othp=phone.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			var letter = /^[A-Za-z]+$/;
			
			
	    	 var numericExpression = /^[0-9]+$/;
	    	    
	    	 var invalid=/[^A-Za-z\s]/;

	    	

	    	
	    	if(consigner == "Select"){
		    	alert("Please Select The Consignor");
	    		return false;
	    	}
	    	
	    	
	    	



	    	
	    	if(contactPerson=="" || oth==""){
		    	//alert("Please enter Contact person Name  ");
	    		//return false;
	    	}



	    	 if(invalid.test(contactPerson)){
	    	   //  alert('Please enter character value for contact person..');  
	    	    // return false;
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
	    		   alert("Please enter valid e-mail id");s
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
		document.getElementById("consigner").disabled = true;
		document.getElementById("consigner1").style.display="";
		document.getElementById("f10").style.display="";
		document.getElementById("f11").style.display='none';
		
		//document.getElementById("city").value='-';
		//document.addOpportunity.city.style.visibility="hidden";
	}
function showminus(id)
{
	document.getElementById("consigner").disabled = false;
	document.getElementById("f10").style.display='none';
	document.getElementById("consigner1").style.display='none';
	
	document.getElementById("f11").style.display="";
	document.getElementById("consigner1").value="";
	
	//document.addOpportunity.city.style.visibility="visible";
	
}
function showentryform1()
{
	document.getElementById("consignee").disabled = true;
	document.getElementById("consignee1").style.display="";
	document.getElementById("f12").style.display="";
	document.getElementById("f13").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus1(id)
{
	document.getElementById("consignee").disabled = false;	
document.getElementById("f12").style.display='none';
document.getElementById("consignee1").style.display='none';

document.getElementById("f13").style.display="";
document.getElementById("consignee1").value="";

//document.addOpportunity.city.style.visibility="visible";

}

function showentryform2()
{
	document.getElementById("origin").disabled = true;
	document.getElementById("startplace").style.display="";
	document.getElementById("f14").style.display="";
	document.getElementById("f15").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus2(id)
{
	document.getElementById("origin").disabled = false;
document.getElementById("f14").style.display='none';
document.getElementById("startplace").style.display='none';

document.getElementById("f15").style.display="";
document.getElementById("startplace").value="";

//document.addOpportunity.city.style.visibility="visible";

}
function showentryform3()
{
	document.getElementById("dest").disabled = true;
	document.getElementById("endplace").style.display="";
	document.getElementById("f16").style.display="";
	document.getElementById("f17").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus3(id)
{
	document.getElementById("dest").disabled = false;
document.getElementById("f16").style.display='none';
document.getElementById("endplace").style.display='none';

document.getElementById("f17").style.display="";
document.getElementById("endplace").value="";

//document.addOpportunity.city.style.visibility="visible";

}
function showentryform4()
{
	document.getElementById("loadType").disabled = true;
	document.getElementById("loadType1").style.display="";
	document.getElementById("f18").style.display="";
	document.getElementById("f19").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus4(id)
{
	document.getElementById("loadType").disabled = false;
document.getElementById("f18").style.display='none';
document.getElementById("loadType1").style.display='none';

document.getElementById("f19").style.display="";
document.getElementById("loadType1").value="";

//document.addOpportunity.city.style.visibility="visible";

}

function showentryform5()
{
	document.getElementById("frt").disabled = true;	
	document.getElementById("frttype").style.display="";
	document.getElementById("f20").style.display="";
	document.getElementById("f21").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus5(id)
{
	document.getElementById("frt").disabled = false;
document.getElementById("f20").style.display='none';
document.getElementById("frttype").style.display='none';

document.getElementById("f21").style.display="";
document.getElementById("frttype").value="";

//document.addOpportunity.city.style.visibility="visible";

}

function showentryform6()
{
	document.getElementById("product").disabled = true;
	document.getElementById("products").style.display="";
	document.getElementById("f22").style.display="";
	document.getElementById("f23").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus6(id)
{
	document.getElementById("product").disabled = false;
document.getElementById("f22").style.display='none';
document.getElementById("products").style.display='none';

document.getElementById("f23").style.display="";
document.getElementById("products").value="";

//document.addOpportunity.city.style.visibility="visible";

}

function showentryform7()
{
	document.getElementById("risk").disabled = true;
	document.getElementById("riskinv").style.display="";
	document.getElementById("f24").style.display="";
	document.getElementById("f25").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus7(id)
{
	document.getElementById("risk").disabled = false;
document.getElementById("f24").style.display='none';
document.getElementById("riskinv").style.display='none';

document.getElementById("f25").style.display="";
document.getElementById("riskinv").value="";

//document.addOpportunity.city.style.visibility="visible";

}
function showentryform8()
{
	document.getElementById("trans").disabled = true;
	document.getElementById("trans1").style.display="";
	document.getElementById("f26").style.display="";
	document.getElementById("f27").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus8(id)
{
	document.getElementById("trans").disabled = false;
document.getElementById("f26").style.display='none';
document.getElementById("trans1").style.display='none';

document.getElementById("f27").style.display="";
document.getElementById("trans1").value="";

//document.addOpportunity.city.style.visibility="visible";

}
function showentryform9()
{
	document.getElementById("branch").disabled = true;
	document.getElementById("branch1").style.display="";
	document.getElementById("f28").style.display="";
	document.getElementById("f29").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus9(id)
{
	document.getElementById("branch").disabled = false;
document.getElementById("f28").style.display='none';
document.getElementById("branch1").style.display='none';

document.getElementById("f29").style.display="";
document.getElementById("branch1").value="";

//document.addOpportunity.city.style.visibility="visible";

}

function showentryform10()
{
	document.getElementById("billbranch").disabled = true;
	document.getElementById("billbranch1").style.display="";
	document.getElementById("f30").style.display="";
	document.getElementById("f31").style.display='none';
	
	//document.getElementById("city").value='-';
	//document.addOpportunity.city.style.visibility="hidden";
}
function showminus10(id)
{
	document.getElementById("billbranch").disabled = false;
document.getElementById("f30").style.display='none';
document.getElementById("billbranch1").style.display='none';

document.getElementById("f31").style.display="";
document.getElementById("billbranch1").value="";

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
	
	
	function validCurrency()
	{
	var currency=document.getElementById("currency").value;
	//alert("currency==>"+currency);
	if(currency == "Select")
				{
				alert("Please Select Currency");
					document.getElementById("potentialValue").value("");
					
					return false;
					
				}
				
	}
	
	
	
	
	
	
	function myFunction(){
		var numericExpression = /^[0-9]+$/;
		
		var mvt=document.addOpportunity.mvt.value;
		
		if(mvt!="")
	    	if(!(mvt.match(numericExpression))){
		    	alert("Monthly Volume Should Be Numeric Value");
		    	return false;
	    	}
		var comm=document.addOpportunity.comm.value;
		if(comm!="")
	    	if(!(comm.match(numericExpression))){
		    	alert(" Commission Should Be Numeric Value");
	    		return false;
	    	}
		if(comm>100)
			{
			alert("Commision Should Be 100 or Less than 100 %");
			return false
			}
	}
	
	function validateProspectes()
	{
		//alert("IN FUNCVOOM     ");
		if(document.getElementById("consigner").disabled ==true)
		{
			var consigner1=document.forms["addOpportunity"]["consigner1"].value;
			if(consigner1=="" || consigner1==" "){
				alert("Please Enter The Consignor");
				return false;
			}
		}
		
		var consignor=document.addOpportunity.consigner1.value;
		
		
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
				alert("Consignor Name Already Exists !!You Can Not Add This Consignor");
				document.addOpportunity.consigner1.value="";
			//	document.getElementById("comlist").style.display='none';
			  }
			 
			}
		
		}
		
		var queryString = "?prospect=" +consignor;
		ajaxRequest.open("GET", "AjaxCheckForConsignor.jsp" + queryString, true);
		ajaxRequest.send(null);
		
			
	}
	
	function validateProspectes1()
	{
		//alert("IN FUNCVOOM     ");
		if(document.getElementById("consignee").disabled ==true)
		{
			var consignee1=document.forms["addOpportunity"]["consignee1"].value;
			if(consignee1=="" || consignee1==" "){
				alert("Please Enter The Consignee");
				return false;
			}
		}  
		
		
		var consignee=document.addOpportunity.consignee1.value;
		consignee=consignee.replace(/,/,'...');
		consignee=consignee.replace(/;/,'**');
		consignee=consignee.replace(/:/,'##');
//	 	compnaw=compnaw.replace(/!/,'***');
//	 	compnaw=compnaw.replace(/@/,'###');
//	 	compnaw=compnaw.replace(/$/,'####');
//	 	compnaw=compnaw.replace(/%/,'****');
		consignee=consignee.replace(/_/,'*****');
		consignee=consignee.replace(/-/,'#####');
		
		consignee=encodeURIComponent(consignee);
		
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
				var finalres=reselt.trim();	
			//	alert("After trim      "+reselt);
				  if(finalres=="Yes")
			  {
				alert("Consignee Name Already Exists !!You Can Not Add This Consignee");
				document.addOpportunity.consignee1.value="";
			//	document.getElementById("comlist").style.display='none';
			  }
			 
			}
		
		}
		

		function validateopportbranch()
		{
			//alert("IN FUNCVOOM     ");
			if(document.getElementById("branch").disabled ==true)
			{
				var branch1=document.forms["addOpportunity"]["branch"].value;
				if(branch1=="" || branch1==" "){
					alert("Please Enter The Opportunity Branch");
					return false;
				}
			}  
			
			
			var branch=document.addOpportunity.branch.value;
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
					alert("Opportunity Branch Name Already Exists !!You Can Not Add This Opportunity Branch");
					document.addOpportunity.consignee1.value="";
				//	document.getElementById("comlist").style.display='none';
				  }
				 
				}
			
			}
			
			var queryString = "?prospect=" +consignee;
			ajaxRequest.open("GET", "AjaxCheckForConsignor.jsp" + queryString, true);
			ajaxRequest.send(null); 
			
		}		
		
		
		var queryString = "?prospect=" +consignee;
		ajaxRequest.open("GET", "AjaxCheckForConsignor.jsp" + queryString, true);
		ajaxRequest.send(null); 
		
	}
	
	function validateLoadType()
	{
		//alert("IN FUNCVOOM     ");
		if(document.getElementById("loadType").disabled ==true)
		{
			var loadType1=document.forms["addOpportunity"]["loadType1"].value;
			if(loadType1=="" || loadType1==" "){
				alert("Please Enter The LoadType");
				return false;
			}
		} 
	}
	function validateFRT()
	{
		//alert("IN FUNCVOOM     ");
		if(document.getElementById("frt").disabled ==true)
		{
			var frttype=document.forms["addOpportunity"]["frttype"].value;
			if(frttype=="" || frttype==" "){
				alert("Please Enter The Freight Type");
				return false;
			}
		} 
	}
	function validateBranch()
	{
		//alert("IN FUNCVOOM     ");
		if(document.getElementById("branch").disabled ==true)
		{
			var branch1=document.forms["addOpportunity"]["branch1"].value;
			if(branch1=="" || branch1==" "){
				alert("Please Enter The Branch");
				return false;
			}
		} 
	}
	
	function validateBillBranch()
	{
		//alert("IN FUNCVOOM     ");
		if(document.getElementById("billbranch").disabled ==true)
		{
			var billbranch1=document.forms["addOpportunity"]["billbranch1"].value;
			if(billbranch1=="" || billbranch1==" "){
				alert("Please Enter The Billing Branch");
				return false;
			}
		} 
	}
	//if (document.all || document.getElementById)
	//	document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
	
	
	
	
	function add()
	{
		
		//alert("Contact");
		//alert("Contact12423");
	 var customername=document.getElementById("consigner").value;
	 //alert("HI");
	 customername=customername.replace("&","and");
	 
  	  //alert("Customercustomername:-"+customername);
  	//alert("Contact111----------"+customername);
  	  var  customercode=document.getElementById("customercode1").value;
  	//alert("Contact---------"+customercode);
       var Type=document.getElementById("customertype1").value;
     		
     // alert("Type hiiiiiiiiiiiiiiiiiii:-"+Type);
     		
     		
  	 
     		//alert("5"+type);
     		//var url="contactdetails.jsp?companyname='Test'&customercode='2'&Type='3'&isclose=true";
     		var url="addcontact.jsp?companyname="+customername+"&customercode="+customercode+"&Type="+Type+"&isclose=true";
     		var win = window.open(url,'_blank');
                  	  	win.focus();
     		
     		
	   	
	   	//alert("6");
	   	
	   	
	   	
	   	re(1);
	}
	
	
	function add1()
	{
		//alert("Contact");
		//alert("Contact12423");
	 var customername=document.getElementById("consignee").value;
	 
customername=customername.replace("&","and");
	 
	 
	 
	 
  	//alert("Contact111----------"+customername);
  	  var  customercode=document.getElementById("customercode1").value;
  	//alert("Contact---------"+customercode);
       var Type=document.getElementById("customertype1").value;
     		
     // alert("Type hiiiiiiiiiiiiiiiiiii:-"+Type);
     		
     		
  	 
     		//alert("5"+type);
     		//var url="contactdetails.jsp?companyname='Test'&customercode='2'&Type='3'&isclose=true";
     		var url="addcontact.jsp?companyname="+customername+"&customercode="+customercode+"&Type="+Type+"&isclose=true ";
     		var win = window.open(url,'_blank');
                  	  	win.focus();
     		
     		
	   	
	   	//alert("6");
	   	
	   	
	   	
	   	re(1);
	}
	
	function add2()
	{
		//alert("Contact");
		//alert("Contact12423");
	 var customername=document.getElementById("Liaison").value;
	 
      customername=customername.replace("&","..");
	 
	 
	 
	 
  	//alert("Contact111----------"+customername);
  	  var  customercode=document.getElementById("customercode1").value;
  	//alert("Contact---------"+customercode);
       var Type=document.getElementById("customertype1").value;
     		
     // alert("Type hiiiiiiiiiiiiiiiiiii:-"+Type);
     		
     		
  	 
     		//alert("5"+type);
     		//var url="contactdetails.jsp?companyname='Test'&customercode='2'&Type='3'&isclose=true";
     		var url="addcontact.jsp?companyname="+customername+"&customercode="+customercode+"&Type="+Type+"&Cat=Liaison&isclose=true ";
     		var win = window.open(url,'_blank');
                  	  	win.focus();
     		
     		
	   	
	   	//alert("6");
	   	
	   	
	   	
	   	re(1);
	}
	
	function addCon()
{
		//Prospect="+document.addFolloUp.customerName.value+"&Company="+document.addFolloUp.companyNames.value;
		
		var customername = "";
		var customercode = "";
		var Type = "";
		//alert("1");
  	   customername=document.getElementById("companyname1").value;
  	   customercode=document.getElementById("customercode1").value;
       Type=document.getElementById("customertype1").value;
     		
       
       alert("5555555555555"+Type);
     		
     		var url="addcontact.jsp?companyname="+customername+"&customercode="+customercode+"&Type="+Type+" ";
     		var win = window.open(url,'_blank');
                  	  	win.focus();
                  	//alert("6");
                  		re(1);	
}	
var v=0;
function re(count){
	
	//alert(v+"---refreshing--"+count);
	
	if(count==1)
	{
		//alert("1");
		v=1;
		//alert("2");
	}
	
	if(count==0)
	{
		//alert("3");
		if(v==1){
			//alert("4");
			document.getElementById("wait").style.display="";
			$("#refreshthis1").load(document.URL +   " #refreshthis1");
			//alert("5");
			v=0;
			//alert("6  "+v);
		}		
	}	
	
	//alert("refreshing1");
	//$("#refreshthis1").load(document.URL +   " #refreshthis1");
}
function load(){
	re(0);
	setTimeout(re, 3000);	
}
function consig()
{
	var customername=document.getElementById("consigner").value;
	
	customername=customername.replace(/,/,'...');
	customername=customername.replace(/;/,'**');
	customername=customername.replace(/:/,'##');

	customername=customername.replace(/_/,'*****');
	customername=customername.replace(/-/,'#####');
	
	customername=encodeURIComponent(customername);
	
	customername=customername.replace(/\ /g,'*');
	
	customername=customername.replace(/\&/g,'..');
	
	//alert("Customer---------"+customername);
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
		   //alert("Original result"+reselt);
			var finalres=reselt.split("#");
			document.getElementById("spokento123").innerHTML=finalres[0];
			//alert("After trim"+finalres[0]);
			document.getElementById("my1").value=finalres[1]; //comtype
			//alert("After trim Company Type----"+finalres[1]);
			document.getElementById("my2").value=finalres[2]; //comname
			//alert("After trim Company Name----"+finalres[2]);
			document.getElementById("my3").value=finalres[3]; //code
			//alert("After trim Comapny Code---"+finalres[3]);
		    //alert("After trim      "+reselt);
			  
		 
		}
	
	}
	
	var queryString = "?customername="+customername;
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "AjaxConsignorContact.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	
	//re(1);
	}
	
	function liason1()
	{
		
		var Liaison=document.getElementById("Liaison").value;
		Liaison=Liaison.replace(/,/,'...');
		Liaison=Liaison.replace(/;/,'**');
		Liaison=Liaison.replace(/:/,'##');

		Liaison=Liaison.replace(/_/,'*****');
		Liaison=Liaison.replace(/-/,'#####');
		
		Liaison=encodeURIComponent(Liaison);
		
		
		
		
		//alert("Customer---------"+customername);
		Liaison=Liaison.replace(/\ /g,'*');
		
		//alert("Customer---------"+customername);
		Liaison=Liaison.replace(/\&/g,'..');
		
		//alert("Customer---------"+customername);
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
			   //alert("Original result"+reselt);
				var finalres=reselt.split("#");
				//document.getElementById("spokento123").innerHTML=finalres[0];
				document.getElementById("Liaison12345").innerHTML=finalres[0];
				//alert("After trim"+finalres[0]);
				document.getElementById("my1").value=finalres[1]; //comtype
				//alert("After trim Company Type----"+finalres[1]);
				document.getElementById("my2").value=finalres[2]; //comname
				//alert("After trim Company Name----"+finalres[2]);
				document.getElementById("my3").value=finalres[3]; //code
				//alert("After trim Comapny Code---"+finalres[3]);
			    //alert("After trim      "+reselt);
				  
			 
			}
		
		}
		
		var queryString = "?customername="+Liaison;
	     //alert("Query String ---"+queryString);
		ajaxRequest.open("GET", "AjaxLiaisonContact.jsp"+queryString, true);
		ajaxRequest.send(null); 
	   
		//re(1);
		
		
	}
function consig1()
{
	var customername=document.getElementById("consignee").value;
	customername=customername.replace(/,/,'...');
	customername=customername.replace(/;/,'**');
	customername=customername.replace(/:/,'##');

	customername=customername.replace(/_/,'*****');
	customername=customername.replace(/-/,'#####');
	
	customername=encodeURIComponent(customername);
	
	
	
	
	//alert("Customer---------"+customername);
	customername=customername.replace(/\ /g,'*');
	
	//alert("Customer---------"+customername);
	customername=customername.replace(/\&/g,'..');
	
	//alert("Customer---------"+customername);
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
		   //alert("Original result"+reselt);
			var finalres=reselt.split("#");
			//document.getElementById("spokento123").innerHTML=finalres[0];
			document.getElementById("spokento12345").innerHTML=finalres[0];
			//alert("After trim"+finalres[0]);
			document.getElementById("my1").value=finalres[1]; //comtype
			//alert("After trim Company Type----"+finalres[1]);
			document.getElementById("my2").value=finalres[2]; //comname
			//alert("After trim Company Name----"+finalres[2]);
			document.getElementById("my3").value=finalres[3]; //code
			//alert("After trim Comapny Code---"+finalres[3]);
		    //alert("After trim      "+reselt);
			  
		 
		}
	
	}
	
	var queryString = "?customername="+customername;
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "AjaxConsigneeContact.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	//re(1);
	
	}
	
function validate()
{
	var OppBranch= document.getElementById("branch").value;
	var BillBranch= document.getElementById("billbranch").value;
	var Consignor= document.getElementById("consigner").value;
	var Consignee= document.getElementById("consignee").value;
	var Ldtype= document.getElementById("loadType").value;
	var frtype= document.getElementById("frt").value;
	
	if(OppBranch=="Select" || BillBranch=="Select" || Consignor=="Select" || Consignee=="Select" || Ldtype=="Select" || frtype=="Select")
	{
		alert("Mandatory Fields Can't Be Blank");
		return false;
		
	}
	var a=chk();
	
	
	if(a==false){
		return false;
	}
	return true;
	
}
function chk()
{
	//alert("Chk");
	
	
	var chkf="";
	var chkt="";
	var objFromDate = document.getElementById("fromdate").value;
	var fdate=objFromDate.split("-");
	if(fdate[1]=="Jan")
	{
		chkf="01";
	}
	if(fdate[1]=="Feb")
	{
		chkf="02";
	}
	if(fdate[1]=="Mar")
	{
		chkf="03";
	}
	if(fdate[1]=="Apr")
	{
		chkf="04";
	}
	if(fdate[1]=="May")
	{
		chkf="05";
	}
	if(fdate[1]=="Jun")
	{
		chkf="06";
	}
	if(fdate[1]=="Jul")
	{
		chkf="07";
	}
	if(fdate[1]=="Aug")
	{
		chkf="08";
	}
	if(fdate[1]=="Sep")
	{
		chkf="09";
	}
	if(fdate[1]=="Oct")
	{
		chkf="10";
	}
	if(fdate[1]=="Nov")
	{
		chkf="11";
	}
	if(fdate[1]=="Dec")
	{
		chkf="12";
	}
	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
    var objToDate = document.getElementById("todate").value;
    var tdate=objToDate.split("-");
    if(tdate[1]=="Jan")
	{
    	chkt="01";
	}
	if(tdate[1]=="Feb")
	{
		chkt="02";
	}
	if(tdate[1]=="Mar")
	{
		chkt="03";
	}
	if(tdate[1]=="Apr")
	{
		chkt="04";
	}
	if(tdate[1]=="May")
	{
		chkt="05";
	}
	if(tdate[1]=="Jun")
	{
		chkt="06";
	}
	if(tdate[1]=="Jul")
	{
		chkt="07";
	}
	if(tdate[1]=="Aug")
	{
		chkt="08";
	}
	if(tdate[1]=="Sep")
	{
		chkt="09";
	}
	if(tdate[1]=="Oct")
	{
		chkt="10";
	}
	if(tdate[1]=="Nov")
	{
		chkt="11";
	}
	if(tdate[1]=="Dec")
	{
		chkt="12";
	}
    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
     
    var date1 = new Date(objFromDate1);
    var date2 = new Date(objToDate1);
    
    //alert("from > "+date1+" Todate > "+date2);
    
    var date3 = new Date();
    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
    var currentDate = new Date(date4);
     
        if(date1 > date2)
        {
            alert("From Date Should be Less Than To Date");
            return false; 
        }
//         else if(date1 > currentDate)
//         {
//             alert("From Date should be less than current date");
//             return false; 
//         }
//         else if(date2 > currentDate) 
//         {
//             alert("To Date should be less than current date");
//             return false; 
//         }


	
}
var v=0;
function re(count){
	
	//alert(v+"---refreshing--"+count);
	
	if(count==1)
	{
		//alert("1");
		v=1;
		//alert("2");
	}
	
	if(count==0)
	{
		//alert("3");
		if(v==1){
			//alert("4");
			document.getElementById("wait").style.display="";
			$("#refreshthis1").load(document.URL +   " #refreshthis1");
			//alert("5");
			v=0;
			//alert("6  "+v);
		}		
	}	
	
	//alert("refreshing1");
	//$("#refreshthis1").load(document.URL +   " #refreshthis1");
}

function load(){
	re(0);
	setTimeout(re, 3000);	
}
</script>
 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null;
		Statement st2 = null;
		String selectedName;
		String FollowUpType = "";String company="";String CustomerName="",companyName="";
		int Code=0;
		String custcode="";
		int type=0;
		String comptype="";
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
				st5 = conn.createStatement();
				st6 = conn.createStatement();
				st7 = conn.createStatement();
				st8 = conn.createStatement();
				st9 = conn.createStatement();
				st10 = conn.createStatement();
				st11 = conn.createStatement();
				st12 = conn.createStatement();
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
companyName=request.getParameter("companyNames").toString();


companyName=companyName.replace("...","&");

System.out.println("User Leval -->"+session.getAttribute("userLevel").toString());

//System.out.println("Session Company  "+session.getAttribute("Company").toString());

if(save!=null)
{
	
	%>
	<script type="text/javascript">
	alert("Opportunity saved successfully in system.");
	
	
		var companyName= document.getElementById("custName").value;	
		companyName=companyName.replace("&","...");
		alert(companyName);
	window.location="addOpportunityNew.jsp?companyname="+companyName;
	
	
		//alert(e);
	
	</script>
	<%
} 
 		 %> 
	<%Date d=new Date();
	
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	String CompanyType=request.getParameter("customertype");
	
	System.out.println("Type-----------------"+CompanyType);
	
	
String  companynaw=request.getParameter("companyNames");
String  customercode=request.getParameter("customercode");
String  customertype=request.getParameter("customertype");
	%>
	
	<% 

	
	
	
	%>
	
	 
	 <%-- <%if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5"))){ %> --%>
	 <div>
	 <div style="background-color:white;height:27;width:100%; "> 
            
            <table style="width: 100%">
            <tr>
            
            	<td align="center" colspan="4"><font face="Arial" color="black" size="3"><b>
							
						Add New Opportunity</b></font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</br>
							</td>
            
       </tr>
            </table>
            </div>
            <br></br>
	
	<form name="addOpportunity" method="post" action="InsertOpportunityNew.jsp?update=false" onsubmit="return validate();" >
	<table  cellpadding="" align="center" border="0" width="90%" style="background: ">
		<tr>
			<td style="width: 17%" align="left">
			<div id="customer"><b><font face="Arial" size="2" color="black">Customer Name </font></b></div> 
			</td>
			<td >
			<div id="custName"><input type="text" name="custName" id=""  value="<%=companyName%>" readonly="readonly"/>
			
			
			
			
			
			<input type="hidden" id="companyname1" name="companyname1" value="<%=companynaw%>" />   
	<input type="hidden" id="customercode1" name="customercode1" value="<%=customercode%>" /> 
	<input type="hidden" id="customertype1" name="customertype1" value="<%=customertype%>" />   
			</div>
			</td>
			<td>
			
			</td>
			<td  align="left">
			<div id='repName'><b><font face="Arial" size="2" color="black">Marketing Rep.Name </font><font size="2" color="red">*</font></b></div>
			</td>
			<td>
				<select
						name="repName" id="repName"    style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "
						 >
						<%
							String sql = "select distinct MarketingRepName ,MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
							" WHERE username<>'' and password<>''  order by MarketingRepName";
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
			<input type="hidden" name="empName" value="<%=session.getAttribute("EmpName").toString() %>"  />
			</td>
			</tr>
			<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Opportunity Branch </b></font><font size="2" color="red">*</font></td>
			<td>
			<select name="branch" id="branch" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown11="SELECT Distinct branchName FROM "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster order by branchName ";
				  ResultSet rsDropdown11=st11.executeQuery(sqlDropdown11);
				  while(rsDropdown11.next())
				  {
				  %>
				  <option><%=rsDropdown11.getString(1)%></option>
							
						<% 	}%> 
				</select>
				<td>
			<a href="#" style="font-weight: bold; color: blue;" id="f29" onclick="showentryform9()">Add New</a>
			</td>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Billing Branch</b></font><font size="2" color="red">*</font></td>
			<td>
			<select name="billbranch" id="billbranch" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown12="SELECT Distinct branchName FROM "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster order by branchName ";
				  ResultSet rsDropdown12=st12.executeQuery(sqlDropdown12);
				  while(rsDropdown12.next())
				  {
				  %>
				  <option><%=rsDropdown12.getString(1)%></option>
							
						<% 	}%> 
				</select>
				</td>
				
				<td>
			<a href="#" style="font-weight: bold; color: blue;" id="f31" onclick="showentryform10()">Add New</a>
			</td>
		
	</tr>
	<tr>
		<td></td><td>
		<input type="text"  name="branch1" id="branch1" onblur="validateBranch()" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f28" onclick="showminus9('-')"><font  size="3" >(-)</font></a>
		</td>
		
		<td></td><td></td><td>
		<input type="text"  name="billbranch1" id="billbranch1" onblur="validateBillBranch()" style="display: none" />				<a href="#" style="font-weight: bold; color: blue;display: none " id="f30" onclick="showminus10('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>
			

<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Consignor </b></font><font size="2" color="red">*</font></td>
			<td>
			
			<select name="consigner" id="consigner" onchange="consig();" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown1="SELECT Distinct CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  order by CompanyName ";
				  ResultSet rsDropdown1=st1.executeQuery(sqlDropdown1);
				  
				  while(rsDropdown1.next())
				  {
					String name=rsDropdown1.getString(1);
					String Consignor=rsDropdown1.getString(1);
					
					//System.out.println("Name----------------"+name);
				  %>
				  
				  <option value="<%=Consignor%>"><%=Consignor%></option>
							
						<% 	}%> 
				</select>
							
				
				<td>
			 	<a href="#" style="font-weight: bold; color: blue;" id="f11" onclick="showentryform()">Add New</a> 
			</td>
			
			</td>
				   <td  align="left"><font face="Arial" size="2" color="black"><b>Consignee </b></font><font size="2" color="red">*</font></td>
			<td  align="left">
			
			<select name="consignee" id="consignee"  onchange="consig1();" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown2="SELECT Distinct CompanyName FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  order by CompanyName ";
				  ResultSet rsDropdown2=st2.executeQuery(sqlDropdown2);
				  while(rsDropdown2.next())
				 {
					   CustomerName=rsDropdown2.getString(1);
					   String Consignee=rsDropdown2.getString(1);
					   
					  
				  %>
				  <option value="<%=Consignee%>"><%=Consignee%></option>
							
						<% 	}%> 
						
				</select>
				</td>
				<td>
							<a href="#" style="font-weight: bold; color: blue;" id="f13" onclick="showentryform1()">Add New</a>  
			
			</td>
			
		
		</tr>
		
		<tr>
		<td></td><td>
		<input type="text"  name="consigner1" id="consigner1" onblur="validateProspectes()" style="display: none" />				<a href="#" style="font-weight: bold; color: blue;display: none " id="f10" onclick="showminus('-')"><font  size="3" >(-)</font></a>
		</td>
		
		
		<td></td><td></td><td>
		<input type="text"  name="consignee1" id="consignee1" onblur="validateProspectes1()" style="display: none" />				<a href="#" style="font-weight: bold; color: blue;display: none " id="f12" onclick="showminus1('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>
		<tr>
						  <th align="left" style=" width: 8.5%" ><font face="Arial" size="2" color="black"><b>Consignor Contact</b></font></th>
							<td style="vertical-align: top;width: 5%" align="left">
<!-- 	<input type="text" class="input" name="spokento" id="spokento" value="" style="height: 15px; width:95%; padding: 4px 5px 2px 5px;  background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; width: 75; max-width: 40;"> -->
<div id="refreshthis1">

<select  name="spokento123" id="spokento123" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000;" >
				  	<option value="Select">Select</option>
	<option></option>			  	
				  	

	</select>
	
	<input type="hidden" name="my1" id="my1" value="" />
    <input type="hidden" name="my2" id="my2" value=""/>
    <input type="hidden" name="my3" id="my3" value="" />
	
	<span id="" style="display: none;"><font color="red">Please Wait...</font> </span>
<!-- 	<p onclick="load()">Refresh</p> -->
	
	</div>
	</td>
			<td>
<!-- 			<a href="#" onclick="load(0)"> Refresh</a> -->
			
			<!-- <a href="#" style="font-weight: bold; color: blue;" onclick="addCon(1)"">Add Contact</a> -->
			<a href="#" style="font-weight: bold; color: blue;" onclick="add()"> Add New</a>
			</td>
			
			
			<th align="left" style=" width: 8.5%" ><font face="Arial" size="2" color="black"><b>Consignee Contact</b></font></th>
							<td style="vertical-align: top;width: 5%" align="left">
<!-- 	<input type="text" class="input" name="spokento" id="spokento" value="" style="height: 15px; width:95%; padding: 4px 5px 2px 5px;  background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; width: 75; max-width: 40;"> -->
<div id="refreshthis2">

<select  name="spokento12345" id="spokento12345" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000;" onclick="re(0)">
				  	<option value="Select">Select</option>
	<option></option>			  	
				  	

	</select>
	
	<input type="hidden" name="my1" id="my1" value="" />
    <input type="hidden" name="my2" id="my2" value=""/>
    <input type="hidden" name="my3" id="my3" value="" />
	
	<span id="wait1" style="display: none;"><font color="red">Please Wait...</font> </span>
<!-- 	<p onclick="load()">Refresh</p> -->
	
	</div>
	</td>
			<td>
<!-- 			<a href="#" onclick="load(0)"> Refresh</a> -->
			
			<!-- <a href="#" style="font-weight: bold; color: blue;" onclick="addCon(1)"">Add Contact</a> -->
			<a href="#" style="font-weight: bold; color: blue;" onclick="add1()"> Add New</a>
			</td>	
			</td>	
						</tr>
		<!-- <tr>
		<td></td><td>
		<input type="text"  name="consigner1" id="consigner1" onblur="validateProspectes()" style="display: none" />				<a href="#" style="font-weight: bold; color: blue;display: none " id="f10" onclick="showminus('-')"><font  size="3" >(-)</font></a>
		</td>
		
		
		<td></td><td>
		<input type="text"  name="consignee1" id="consignee1" onblur="validateProspectes1()" style="display: none" />				<a href="#" style="font-weight: bold; color: blue;display: none " id="f12" onclick="showminus1('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr> -->
	

<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Origin </b></font></td>
			<td>
			
			<select name="origin" id="origin" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown3="SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City ";
				  ResultSet rsDropdown31=st3.executeQuery(sqlDropdown3);
				  while(rsDropdown31.next())
				  {
				  %>
				  <option><%=rsDropdown31.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				<td>
				<a href="#" style="font-weight: bold; color: blue;" id="f15" onclick="showentryform2()">Add New</a>
			
			</td>
			</td>
				   <td  align="left"><font face="Arial" size="2" color="black"><b>Destination </b></font></td>
			<td>
			
			<select name="dest" id="dest" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown4="SELECT Distinct City FROM "+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo order by City ";
				  ResultSet rsDropdown4=st4.executeQuery(sqlDropdown4);
				  while(rsDropdown4.next())
				 {
				  %>
				  <option><%=rsDropdown4.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				<td>
				<a href="#" style="font-weight: bold; color: blue;" id="f17" onclick="showentryform3()">Add New</a>
			</td>
			
			</td>
		
		</tr>
		<tr>
		<td></td><td>
		<input type="text"  name="startplace" id="startplace" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f14" onclick="showminus2('-')"><font  size="3" >(-)</font></a>
		</td>
		
		<td></td><td></td><td>
		<input type="text"  name="endplace" id="endplace" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f16" onclick="showminus3('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>
		
		<tr>
				<td  align="left"><font face="Arial" size="2" color="black"><b>Load Type </b></font><font size="2" color="red">*</font></td>
			<td>
			
			<select name="loadType" id="loadType" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown10="SELECT Distinct loadType FROM "+session.getAttribute("CompanyMasterID").toString()+"loadTypeMaster  order by loadType";
				  ResultSet rsDropdown10=st10.executeQuery(sqlDropdown10);
				  while(rsDropdown10.next())
				  {
				  %>
				  <option><%=rsDropdown10.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				
			<!--  	<a href="#" style="font-weight: bold; color: blue;" id="f19" onclick="showentryform4()">Add New</a>-->
			
				</select>
				</td>
				<td>
				</td>
				<td  align="left"><font face="Arial" size="2" color="black"><b>Freight Type </b></font><font size="2" color="red">*</font></td>
			<td>
			
			<select name="frt" id="frt" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown5="SELECT Distinct frttype FROM "+session.getAttribute("CompanyMasterID").toString()+"freightMaster  order by frttype";
				  ResultSet rsDropdown5=st5.executeQuery(sqlDropdown5);
				  while(rsDropdown5.next())
				  {
				  %>
				  <option><%=rsDropdown5.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				
			<!--  	<a href="#" style="font-weight: bold; color: blue;" id="f21" onclick="showentryform5()">Add New</a>-->
			
			
			</td>
		</tr>
		<tr>
		<td></td><td>
		<input type="text"  name="loadType1" id="loadType1" onblur="validateLoadType()" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f18" onclick="showminus4('-')"><font  size="3" >(-)</font></a>
		</td>
		
		<td></td><td>
		<input type="text"  name="frttype" id="frttype" onblur="validateFRT()" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f20" onclick="showminus5('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>
		
		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Monthly Volume(Tons) </b></font></td>
			<td align="left">
			<input type="text" name="mvt" id="mvt" onblur="myFunction()"/>
			</td>
			<td>
			</td>
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>Products </b></font></td>
			<td>
			
			<select name="product" id="product" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown7="select distinct product from "+session.getAttribute("CompanyMasterID").toString()+"productMaster order by product ";
				  ResultSet rsDropdown7=st7.executeQuery(sqlDropdown7);
				  while(rsDropdown7.next())
				 {
				  %>
				  <option><%=rsDropdown7.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				
			<!--  	<a href="#" style="font-weight: bold; color: blue;" id="f23" onclick="showentryform6()">Add New</a>-->
			
			
			
		<td></td>
		</tr>
		<tr><td></td><td></td><td></td><td >
		<input type="text"  name="products" id="products" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f22" onclick="showminus6('-')"><font  size="3" >(-)</font></a>
		</td></tr>
			<tr>
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>Lead Reference </b></font></td>
			<td align="left">
			<input type="text" name="load" id="load"/>
			</td>
			
			<td>
			</td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Existing Transporter </b></font></td>
			<td>
			
			<select name="trans" id="trans" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown9="select distinct existTrans from "+session.getAttribute("CompanyMasterID").toString()+"opportunitymaster order by existTrans ";
				  ResultSet rsDropdown9=st9.executeQuery(sqlDropdown9);
				  while(rsDropdown9.next())
				 {
				  %>
				  <option><%=rsDropdown9.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				<td>
				<a href="#" style="font-weight: bold; color: blue;" id="f27" onclick="showentryform8()">Add New</a>
			</td>
			
			
		<td></td>
		</tr>
		<tr><td></td><td></td><td></td><td></td><td>
		<input type="text"  name="trans1" id="trans1" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f26" onclick="showminus8('-')"><font  size="3" >(-)</font></a>
		</td></tr>
			<tr>
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>Valid From </b></font></td>
			<td>
			
			<input type="text" id="fromdate"
name="fromdate"  value="<%=dtoday %>"  size="15" readonly
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "fromdate"       // ID of the button
}
);
</script>
			</td>
			<td>
			</td>
			
					<td  align="left"><font face="Arial" size="2" color="black"><b>Valid To </b></font></td>
			<td>
			
			<input type="text" id="todate"
name="todate" value="<%=dtoday %>" onchange="dateValidate();" size="15" readonly
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate"       // ID of the button
}
);
</script>
			</td>
			
			
		</tr>
		

         <tr>
         <td  align="left"><font face="Arial" size="2" color="black"><b>Risk Involved</b></font></td>
			<td>
			
			<select name="risk" id="risk" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option value="Select">Select</option>
				  <% String sqlDropdown8="SELECT Distinct riskInvolved FROM "+session.getAttribute("CompanyMasterID").toString()+"riskInvolvedMaster order by riskInvolved ";
				  ResultSet rsDropdown8=st8.executeQuery(sqlDropdown8);
				  while(rsDropdown8.next())
				  {
				  %>
				  <option><%=rsDropdown8.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
				
				
		<!--  		<a href="#" style="font-weight: bold; color: blue;" id="f25" onclick="showentryform7()">Add New</a>-->
			
			
			</td>
        <td></td> 
	<td>
			<!-- <div id="cstaff"><b><font face="Arial" size="2" color="black">Collection Staff	</font></b><font size="2" color="red">*</font></div> -->
			<font face="Arial" size="2" color="black"><b>Collection Staff</b></font></td> 		
			</td>
			<td>
		<div><select name="collectionstaff" id="collectionstaff" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "">
				<option value="Select">Select</option>
				<% String sqlDropdownCS="SELECT Distinct name  FROM "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster order by name asc";
				  ResultSet rsDropdownCS=st3.executeQuery(sqlDropdownCS);
				  while(rsDropdownCS.next()){
				  %>
				  <option value="<%=rsDropdownCS.getString(1)%>">
				  <%=rsDropdownCS.getString(1)%></option>
							
						<% 	}%></select></div> 
				
			</td>         
				



</tr>
<tr>
		<td></td><td>
		<input type="text"  name="riskinv" id="riskinv" style="display: none"/>				<a href="#" style="font-weight: bold; color: blue;display: none " id="f24" onclick="showminus7('-')"><font  size="3" >(-)</font></a>
		</td>
		</tr>

		<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Commission % </b></font></td>
			<td>
			<div id="comm"><input type="text" name="comm"  onblur="myFunction()"/></div>
			</td>
			<td></td>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Remarks </b></font></td>
			<td>
			<div id="remark"><textarea id="remark" name="remark" style="width: 235px"></textarea></div>
			</td>
			
		</tr>
		 
         <tr>
         <td>
			<!-- <div id="cstaff"><b><font face="Arial" size="2" color="black">Collection Staff	</font></b><font size="2" color="red">*</font></div> -->
			<font face="Arial" size="2" color="black"><b>Liaison Officer</b></font></td> 		
			</td>
			<td>
		<div><select name="Liaison" id="Liaison" onchange="liason1();" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; "">
				<option value="Select">Select</option>
				<% String sqlDropdown123="select * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustCategory='Liaison'";
				  ResultSet rsDropdown123=st3.executeQuery(sqlDropdown123);
				  while(rsDropdown123.next()){
				  %>
				  <option value="<%=rsDropdown123.getString("CompanyName")%>">
				  <%=rsDropdown123.getString("CompanyName")%></option>
							
						<% 	}%></select></div> 
				
			</td>
			<td></td>
			<th align="left" style=" width: 8.5%" ><font face="Arial" size="2" color="black"><b>Liaison Contact</b></font></th>
							<td style="vertical-align: top;width: 5%" align="left">
<!-- 	<input type="text" class="input" name="spokento" id="spokento" value="" style="height: 15px; width:95%; padding: 4px 5px 2px 5px;  background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; width: 75; max-width: 40;"> -->
<div id="refreshthis2">

<select  name="Liaison12345" id="Liaison12345" style="
				  	width: 235px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000;" onclick="re(0)">
				  	<option value="Select">Select</option>
	<option></option>			  	
				  	

	</select>
	
	<input type="hidden" name="my1" id="my1" value="" />
    <input type="hidden" name="my2" id="my2" value=""/>
    <input type="hidden" name="my3" id="my3" value="" />
	
	<span id="wait1" style="display: none;"><font color="red">Please Wait...</font> </span>
<!-- 	<p onclick="load()">Refresh</p> -->
	
	</div>
	</td>
			<td>
<!-- 			<a href="#" onclick="load(0)"> Refresh</a> -->
			
			<!-- <a href="#" style="font-weight: bold; color: blue;" onclick="addCon(1)"">Add Contact</a> -->
			<a href="#" style="font-weight: bold; color: blue;" onclick="add2()"> Add New</a>
			</td>   
         
         </tr>
	<tr></tr>
	<tr></tr>
			<tr>
			
			
			<td valign="bottom" align="center" colspan="10">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" /></div>
			</td>
		</tr>
	<tr>
	<td></td>
	
	</tr>

	</table>

	</form>
	<%-- <%} else{%> --%>
</div>
	</body>
	</html>
	
</jsp:useBean>

<%@include file="footer_new.jsp"%>
