 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>

 <script>

	function timer()
	{
		
		setTimeout("getCompanies(1)", 2000);
	}
	
	function getCompanies(num)
	{
		//alert("compani"+num);
		
			document.getElementById("comlist").style.display="";
			
		    
    	
			var company=document.addFolloUp.companyNames.value;

			if(company.length=="")
			{
				document.getElementById("companyList").style.visibility="hidden";
				document.getElementById("companyinfoid").style.visibility="hidden";
				document.getElementById("CompanyCount").innerHTML=""; 
				document.getElementById("comlist").style.display="none";
				document.getElementById("labels").style.display="none";
				document.getElementById("Last").style.display="none";
				document.getElementById("BtnLabels").style.display="none";
				document.addFolloUp.companyNames.value=""; 
				document.addFolloUp.companyCode.value="";
				document.addFolloUp.companyEnteredBy.value="";
				document.addFolloUp.companyCity.value="";
				document.addFolloUp.companyPhoneNumber.value="";
				document.addFolloUp.companyProduct.value="";
				document.addFolloUp.companyContactPerson.value="";
				document.addFolloUp.PotentialValue.value="";
				document.addFolloUp.companyEmail.value="";
				document.addFolloUp.companyfax.value="";
				document.addFolloUp.companyWebSite.value="";
				document.addFolloUp.companyProduct.value=""; 
				document.addFolloUp.customerWeeklyOff.value="";
				document.addFolloUp.custType.innerHTML="";
				 
				document.addFolloUp.assignedBy.value="";
				document.addFolloUp.leadRef.value="";
				document.addFolloUp.addedOnDate.value="";
				document.getElementById("transactionDetails").style.visibility="hidden";
				document.getElementById("followupDetails").style.visibility="hidden";
				
			}
			else
			{
				document.getElementById("companyList").style.visibility="visible";
			//var name=document.netbanking.benfName.value;
			//company=company.replace(/\W/g, '');
			//company = company.replace(/[^a-zA-Z 0-9]+/g, '');
			//'.', '') ,' ','') ,'-',''),',',''),'?',''),'_','')
			company=company.replace(".", "");
			company=company.replace(",", "");
			company=company.replace("$", "");
			company=company.replace("#", "");
			company=company.replace("?", "");
			company=company.replace("-", "");
			company=company.replace("_", "");
			company=company.replace(" ", "");
			company=company.replace("(", "");
			company=company.replace(")", "");
			
		    //var counter=document.addFolloUp.counter.value;
	    //	alert(">>>>>>>>>>   "+counter);
		/*	if(num>100)
			{
				counter=0;
			}
			*/
			if(num==1)
			{
				counter=20;
			}
			else if(num==2)
			{
				counter=0;
			}
			
			//var timer=setTimeout("getValue()",10000);
	//		alert(timer);
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

			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					//alert(reslt);

					document.getElementById("companyList").innerHTML=reslt;
					var b=document.getElementById("element").value;
					document.addFolloUp.counter.value=b;
					document.addFolloUp.counter.value=b*document.addFolloUp.counter.value;
					counter=document.addFolloUp.counter.value;
					
				} 
			}
			//alert("val==>"+counter);
			var queryString = "?company=" +company+"&limitcount="+counter+"";
			
			//alert("limit count val"+counter);	
			ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}//end of else
			
	}

	function getCustomerInfo(type, code) 
	{
		
	
		//alert(" >>.in get Cutomer info=>"+type);
		//alert(" >>.in fun for Customer code=>"+code);
		if(type == "" || type==null)
		{
			alert("Error  ");
		}
		else
		{
		//alert(" type==> "+type+" >>"+ code);
		document.getElementById("companyList").style.visibility="hidden";
		//alert("=1===");
		document.getElementById("comlist").style.display="none";
		//alert("=2===");
		document.getElementById("labels").style.display="";
		//alert("=3===");
		document.getElementById("Last").style.display="";
		//alert("=4===");
		document.getElementById("BtnLabels").style.display="";
		//alert("=5===");
		
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
				
				var reslt = ajaxRequest.responseText;
				//alert(""+reslt);
				reslt=reslt.replace(/^\s+|\s+$/g,"");
				//alert(""+reslt);
				if(reslt == "NO")
				{
					alert(" Data Not Available");
					 document.getElementById("CompanyCount").innerHTML = "";
					 document.addFolloUp.companyNames.value="";
					 document.addFolloUp.companyNames.value=""; 
						document.addFolloUp.companyCode.value="";
						document.addFolloUp.companyEnteredBy.value="";
						document.addFolloUp.companyCity.value="";
						document.addFolloUp.companyPhoneNumber.value="";
						document.addFolloUp.companyProduct.value="";
						document.addFolloUp.companyContactPerson.value="";
						document.addFolloUp.PotentialValue.value="";
						
						document.addFolloUp.companyEmail.value="";
						document.addFolloUp.companyfax.value="";
						document.addFolloUp.companyWebSite.value="";
						document.addFolloUp.companyProduct.value=""; 
						document.addFolloUp.customerWeeklyOff.value="";
						document.addFolloUp.custType.value="";
						
						document.addFolloUp.assignedBy.value="";
						document.addFolloUp.leadRef.value="";
						document.addFolloUp.addedOnDate.value="";
				}else
				{
					//alert("in else of getCustomerInfo"+reslt);
				document.getElementById("tempList").innerHTML = reslt;
				getCustomerDetails();
				}
				//alert("result"+reslt);
				
			}
			//getCustomerDetails(); 
		}
		var queryString = "?code=" +code+"&type="+type;
		ajaxRequest.open("GET", "AjaxGetCustomerInfo.jsp" + queryString, true);
		ajaxRequest.send(null);
		}//end of else
	}
	
	function getCustomerDetails() 
	{   
	//alert("in Get Details");	
	try{
		//document.getElementById("companyList").style.visibility="hidden";
		//document.getElementById("comlist").style.display="none";
		//alert("NM"+document.getElementById("Name").value);
		document.addFolloUp.companyNames.value=document.getElementById("Name").value; 
		document.addFolloUp.custname.value=document.getElementById("Name").value; 

		document.addFolloUp.companyCode.value=document.getElementById("Code").value;
		document.addFolloUp.companyEnteredBy.value=document.getElementById("RepName").value;
		document.addFolloUp.companyCity.value=document.getElementById("City").value;
		document.addFolloUp.companyPhoneNumber.value=document.getElementById("MobileNo").value;
		document.addFolloUp.companyProduct.value=document.getElementById("IntrestedProduct").value;
		document.addFolloUp.companyContactPerson.value=document.getElementById("ContactPerson").value;
		document.addFolloUp.PotentialValue.value=document.getElementById("PotentialValue1").value;
		document.addFolloUp.companyEmail.value=document.getElementById("Email").value;
		document.addFolloUp.companyfax.value=document.getElementById("Fax").value;
		document.addFolloUp.companyWebSite.value=document.getElementById("WebSite").value;
		document.addFolloUp.companyProduct.value=document.getElementById("IntrestedProduct").value; 
		document.addFolloUp.customerWeeklyOff.value=document.getElementById("WeeklyOff").value;
		//alert("in Get Details"+document.getElementById("custtype").value);
		document.addFolloUp.custType.value=document.getElementById("custtype").value;
		
		document.addFolloUp.assignedBy.value=document.getElementById("assignby").value;
		document.addFolloUp.leadRef.value=document.getElementById("leadref").value;
		document.addFolloUp.addedOnDate.value=document.getElementById("addedondate").value;
		document.addFolloUp.count.value=document.getElementById("oppcount").value;
	 
	
	}catch(e)
	{
		/* alert("Exception "+ e.message); */
	}
		
				var cctype=document.addFolloUp.custType.value;
				//document.getElementById("cctype").value=cctype;
				//alert(document.getElementById("cctype").value);
		var company=document.addFolloUp.companyCode.value;
		var companyName=document.addFolloUp.companyNames.value;
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
				var mySplitResult = reslt.split("#");
				//alert(mySplitResult[0]);
				//alert(mySplitResult[1]);

				//alert(mySplitResult[2]);
				
				document.getElementById("transactionDetails").innerHTML=mySplitResult[0];
				document.getElementById("followupDetails").innerHTML=mySplitResult[1];
				//document.getElementById("companydocuments").innerHTML=mySplitResult[2];
				//alert(reslt);
				//alert(document.getElementById("ContactCount").innerHTML=mySplitResult[3]);
			    document.getElementById("CompanyCount").innerHTML = mySplitResult[3];
				//document.getElementById("CompanyCount").value = mySplitResult[3];
				} 
		}
		
		var queryString = "?company="+company+"&companyName="+companyName+"&cctype="+cctype;
		ajaxRequest.open("GET", "AjaxGetTransactionDetails.jsp" + queryString, true);
		ajaxRequest.send(null); 

	}


	function validateCompany()
	{
		var companyName = document.addFolloUp.companyNames.value;
		if(companyName == "" || companyName == null)
		{
			 return a = 1;
		}

		return a = 0;
	}
	
	function showFollowUpEntryForm(webadd) 
	{
		//alert("in showFollowUpEntryForm");
	
       //var a = validateCompany(a);
       //if (a == 0) {
        var a = validateCompany(a);
	       if (a != 0) {
	alert("Please Select Company Name !!!!!");
	       }
	       else{
		 var ajaxRequest;
	     try
	     {
				ajaxRequest = new XMLHttpRequest();
	     }  
	     catch (e)
	     {
		     try
	         {
		          ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
	              catch (e)
	              {
		               try
		               {
			                ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			           } 
	                   catch (e)
	                   {
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
                      //alert("reslt"+reslt);
                      var mySplitResult = reslt.split("#");
                      var action=mySplitResult[1];
                      
         	           if(action=="Accept")
                      {
         	        	  var type=document.getElementById("custType").value;
         	        		var ph=document.addFolloUp.companyPhoneNumber.value;
         	        		var email=document.addFolloUp.companyEmail.value;
         	        		var contactperson=document.addFolloUp.companyContactPerson.value;
         	        		var city=document.addFolloUp.companyCity.value;
         	        		var product=document.addFolloUp.companyProduct.value;
                  			var qs="&type="+type+"&phone="+ph+"&email="+email
                  			var pros=document.addFolloUp.companyNames.value;
                  			pros=pros.replace("&","...");
                  			var ccode=document.addFolloUp.companyCode.value;
                  			var cmp=document.addFolloUp.companyNames.value;
                  			cmp=cmp.replace("&","...");
                  			var cmpcode=document.addFolloUp.companyCode.value;
                  			var cmps=document.addFolloUp.companyNames.value;
                  			cmps=cmps.replace("&","...");
                                              var ccity=document.addFolloUp.companyCity.value;
                  			var cmpconper=document.addFolloUp.companyContactPerson.value;
                  			//alert(qs);
         	        		//document.getElementById(divid).style.display=state;
                  			//alert("--Prospects--"+document.addFolloUp.customerName.value+"--customer--"+document.addFolloUp.companyNames.value+"--customercode="+document.addFolloUp.customerCode.value+"Company="+document.addFolloUp.companyNames.value+"companycode="+document.addFolloUp.companyCode.value+"customerName="+document.addFolloUp.customerName.value+"companyCity="+document.addFolloUp.companyCity.value+"companyContactPerson="+document.addFolloUp.companyContactPerson.value+"customerCity="+document.addFolloUp.customerCity.value+"customerContactPerson="+document.addFolloUp.customerContactPerson.value);
                  		//	window.open('followupEntryForm.jsp'+'?Prospect='+document.addFolloUp.customerName.value+'&customercode='+document.addFolloUp.customerCode.value+'&Company='+document.addFolloUp.companyNames.value+'&companycode='+document.addFolloUp.companyCode.value+'&customerName='+document.addFolloUp.customerName.value+'&companyCity='+document.addFolloUp.companyCity.value+'&companyContactPerson='+document.addFolloUp.companyContactPerson.value+'&customerCity='+document.addFolloUp.customerCity.value+'&customerContactPerson='+document.addFolloUp.customerContactPerson.value,'jav');
                  		var url=''+webadd+'?Prospect='+pros+qs+'&customercode='+ccode+'&Company='+cmp+'&companycode='+cmpcode+'&companyNames='+cmps+'&companyCity='+ccity+'&companyContactPerson='+cmpconper+'&customerCity='+document.addFolloUp.companyCity.value+'&customerContactPerson='+document.addFolloUp.companyContactPerson.value+''	;
                  		//window.open(url);
                  		//alert(url);
                  		var win = window.open(url,'_blank');
                  	  	win.focus();
                  	   }
                      else
	                   {
		                   alert("Please Enter Prospects Address as the prospect is followed up for two more than two times.     (!!! Address Is Mandatory !!!)");
                   	   //document.getElementById(divid).style.display="none";
	                   }
	                  // alert("---"+document.addFolloUp.companyNames.value);
	                   //alert("0000"+document.addFolloUp.customerName.value);
	                   if(document.addFolloUp.companyNames.value != "" )
	                   {
	                	   getSpokenTo("comp");
	                   }
	                   else
	                   {
	                	   getSpokenTo("prosp");
	                   }
         	          
              }
        }
	    
	          var queryString = "?Prospect="+document.addFolloUp.companyNames.value+"&Company="+document.addFolloUp.companyNames.value;
              //alert(queryString);
	          ajaxRequest.open("GET", "checkNoOfFollowUp.jsp" + queryString, true);
	      	  ajaxRequest.send(null); 
	 	  
	       }
	}
       
	function goto1(webadd)
	{
		
		 var Category="Prospect";
		window.open(webadd+'?Category='+Category);
	}
	
	function goto2(webadd)
	{
		
	    var Category="Liaison";
		window.open(webadd+'?Category='+Category);
	} 
	
	function goto3(webadd)
	{
		
		 var CustType=document.addFolloUp.custType.value;
		 if(CustType=="Customer")
			 {
			 
			 var company=document.addFolloUp.companyNames.value;
				company=company.replace("&","...");
				var customercode=document.addFolloUp.companyCode.value;
				
		window.open(webadd+'?companyName='+company+'&customercode='+customercode+'&custtype='+CustType);
		
		return true;
			 }
		 else
			 {
			 
			 alert("Not Allwoed To Prospect");
			 return false;
			 
			 }
	} 
	
	function editCompany(webadd1,webadd2)
	{ 
		var custType;
		custType = document.addFolloUp.custType.value;
		/* alert("Edit Company Type==> "+custType);
		alert("First page=====>"+webadd1+"Second page----->>>"+webadd2); */
		//var a = validateCompany(a);
		if(document.addFolloUp.companyCode.value=="" || document.addFolloUp.companyCode.value==null)
		{
			alert("Please select Customer! ");
		}
		else{
			/* alert("Edit Company Typ******88> "+custType); */
		
			if(custType=='Customer'){
				window.open(webadd1+'?companyCode='+document.addFolloUp.companyCode.value);
			}else{
				window.open(webadd2+'?companyName='+document.addFolloUp.companyCode.value);
			}	
			
		}
		
		    
		
	}


	function popup123(webadd)
	{ 
		var companyName = document.addFolloUp.companyNames.value;
		var customercode=document.addFolloUp.companyCode.value;
		var CustType=document.addFolloUp.custType.value;
		// window.open(webadd+'?Comapny='+companyName+'&Code='+customercode+',' ' ,'width=565,height=320,top=200,left=300,resizable=no');
		
		window.open(webadd+'?Company='+companyName+'&Code='+customercode+'&Type='+CustType+'','','width=565,height=320,top=200,left=300,resizable=no');
		
	}
	
	function showFileAttachementForm() 
	{
		//alert("visibility");
		document.getElementById("fileAttachment").style.visibility="visible";
	}
	
	function searchInfoline(webadd,type)
	{
		 var key;
		 if(type=='Prospect')
			 key=document.addFolloUp.customerName.value.split(' ').join('-');
		 else
		    key=document.addFolloUp.companyNames.value.split(' ').join('-');
		// var load = window.open(webadd+'/stock-market/equity/NewsBoard/133/'+key+'^/AllNewsScripListing.htm','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
		 var load = window.open(webadd,'','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');

	}
	
	function searchMoneyControl(webadd,type)
	{
		 var key;
		 if(type=='Prospect')
			 key=document.addFolloUp.customerName.value.split(' ').join('+');
		 else
		    key=document.addFolloUp.companyNames.value.split(' ').join('+');
		var load = window.open(webadd+'/news/websearch.php?search_data='+key+'&cid=News&mbsearch_str=&topsearch_type=3&search_str='+key+'&x=0&y=0','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');

	}

	function searchGoogle(webadd,type) 
	{
		 var key;
		 if(type=='Prospect')
			 key=document.addFolloUp.customerContactPerson.value.split(' ').join('+');
		 else
		    key=document.addFolloUp.companyNames.value.split(' ').join('+');
		 var load = window.open(webadd+'#hl=en&source=hp&q='+key+'&oq='+key+'&aq=f&aqi=g2g-v8&aql=undefined&gs_sm=e&gs_upl=635l5073l0l16l16l0l3l3l0l276l2363l0.7.5l12&bav=on.2,or.r_gc.r_pw.&fp=263275ba9c13808&biw=1366&bih=541','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
	}
	
	function searchLinkedin(webadd,type)
	{
  		 var keyFirstName,keyLastName,key,result;
		 if(type=='Prospect')
		 {
			 key=document.addFolloUp.customerContactPerson.value.split('Mr.').join('');

			 key=key.split('Mr.  ').join('');
			 key=key.split('  ').join(' ');
			 result=key.split(" ");
			 keyFirstName=result[1];
			 keyLastName=result[2];
		 }
		 else
		 {
		     key=document.addFolloUp.companyContactPerson.value.split('Mr.').join('');
		     
			 key=key.split('Mr.  ').join('');
			 key=key.split('  ').join(' ');
			 result=key.split(" ");
			 keyFirstName=result[1];
			 keyLastName=result[2];
		 }
		 var load = window.open(webadd+'/pub/dir/?first='+keyFirstName+'&last='+keyLastName+'&search=Search','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
	}

	function gotoOprtunity(webadd)
	{
		var company=document.addFolloUp.companyNames.value;
		var customercode=document.addFolloUp.companyCode.value;
		
		var Type = document.addFolloUp.custType.value;
		company=company.replace("&","...");
		//alert(company);
		if(company !="")
		{
			window.open(webadd+'?companyname='+company+'&customercode='+customercode+'&&customertype='+Type);}
				
			 else {
	               alert("Please select Company Name");  
	               //return false;              			
			}	
	}
	
	function gotoviewQuotation(webadd)
	{
		
		//alert("HI");
		var company=document.addFolloUp.companyNames.value;
		company=company.replace("&","..");
		var customercode=document.addFolloUp.companyCode.value;
		//alert("Code--------"+customercode);
		var cmpconper=document.addFolloUp.companyContactPerson.value;
		var companyEmail=document.addFolloUp.companyEmail.value;
		if(company !="")
		{
		        window.open(webadd+'?companyname='+company+'&customercode='+customercode+'&contact='+cmpconper+'&companyEmail='+companyEmail);}
		
				else 
				{
		               alert("Please select Company Name");  
		               //return false;              			
				}	
	
	}
	
	function gotoviewcontract(webadd)
	{
		
		//alert("HI");
		var company=document.addFolloUp.companyNames.value;
		company=company.replace("&","..");
		var customercode=document.addFolloUp.companyCode.value;
		//alert("Code--------"+customercode);
		var cmpconper=document.addFolloUp.companyContactPerson.value;
		var companyEmail=document.addFolloUp.companyEmail.value;
		if(company !="")
		{
		        window.open(webadd+'?companyName='+company+'&companyCode='+customercode+'&contact='+cmpconper+'&companyEmail='+companyEmail);}
		
				else
				{
		               alert("Please select Company Name");  
		               //return false;              			
				}	
	
	}

	function gotoFollowUpReport(webadd)
	{ 
			var company=document.addFolloUp.companyNames.value;
			company=company.replace("&","...");
			var companyPerson=document.addFolloUp.companyContactPerson.value;
			var companyPhone=document.addFolloUp.companyPhoneNumber.value;
			var companyEmail=document.addFolloUp.companyEmail.value;
			var companyCity=document.addFolloUp.companyCity.value;
			var companyProduct=document.addFolloUp.companyProduct.value;
			window.open(webadd+'?companyName='+company+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct);
		
	}
	function validateProsp()
    {
    	var company=document.addFolloUp.customerName.value;
    	if (company == null || company == "") 
        {
        	return a = 1;
			
		}
		else 
		{
			return a = 0;
		}
        	
    }
    
	function gotoFollowUpReportAsProspect(webadd)
	{ 
        var a = validateProsp(a);
		 if (a == 0) {
			 var company=document.addFolloUp.customerName.value;
			 company=company.replcae("&","...");
				var companyPerson=document.addFolloUp.customerContactPerson.value;
				var companyPhone=document.addFolloUp.customerPhoneNumber.value;
				var companyEmail=document.addFolloUp.customerEmail.value;
				var companyCity=document.addFolloUp.customerCity.value;
				var companyProduct=document.addFolloUp.customerProduct.value;
				window.open(webadd+'?companyName='+company+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct);
			
		} else {
               alert("Please Select The Company Name");                			

		}
    }

	function gotoAddContacts(webadd,from)
	{ 
		//alert("gotoAddContacts"+webadd+from);
			var fromList = from;
        var a = "";
        var type=document.addFolloUp.custType.value;
        if(fromList == 'comp')
        {  
		  a = validateCompany(a);
        }
        else{
          a = validateProsp(a);
		} 
		
      if(a == 0 )
      { 
		//Prospect="+document.addFolloUp.customerName.value+"&Company="+document.addFolloUp.companyNames.value;
		var customername = "";
		var customercode = "";
      
    	   customername=document.addFolloUp.companyNames.value;
    	   customername=customername.replace("&","...");
    	   customercode=document.addFolloUp.companyCode.value;
       
	   	window.open(webadd+'?Type='+type+'&companyname='+customername+'&customercode='+customercode);
		} else {
		if(fromList == 'comp')
        {  
			 alert("Please Select The Company Name");
        }
        else{
        	 alert("Please Select The Prospects");
		} 
		    
	}
	
	}
	
	
	
	function gotoAddContactsNew(webadd,from)
	{ 
		var fromList = from;
        var a = "";
        var type=document.addFolloUp.custType.value;
        if(fromList == 'comp')
        {  
		  a = validateCompany(a);
        }
        else{
          a = validateProsp(a);
		} 
		
      if(a == 0 )
      { 
		//Prospect="+document.addFolloUp.customerName.value+"&Company="+document.addFolloUp.companyNames.value;
		var customername = "";
		var customercode = "";
      
    	   customername=document.addFolloUp.companyNames.value;
    	   customername=customername.replace("&","...");
    	   customercode=document.addFolloUp.companyCode.value;
       		var type=document.getElementById("custType").vaalue;
       		var ph=document.addFolloUp.companyPhoneNumber.value;
       		var email=document.addFolloUp.companyEmail.value;
       		var contactperson=document.addFolloUp.companyContactPerson.value;
       		var city=document.addFolloUp.companyCity.value;
       		var product=document.addFolloUp.companyProduct.value;
    	   
// 	   	window.open(webadd+'?Type='+type+'&companyname='+customername+'&customercode='+customercode);
	   	window.open(webadd+"?companyname="+customername+"&code="+customercode+"&type="+type+"&phone="+ph+"&email="+email+"&contactperson="+contactperson+"&city="+city+"&product="+product,"Add Contacts","height=750px,width=500px,status,resizable,top=" + top);
		} else {
		if(fromList == 'comp')
        {  
			 alert("Please Select The Company Name");
        }
        else{
        	 alert("Please Select The Prospects");
		} 
		    
	}
	
	}
	
	
	
	
	
    
	function gotoLedgerDetails(webadd)
	{ 

		try{var a = validateCompany(a);

		if (a == 0) {
			
		var company=document.addFolloUp.companyNames.value;
		company=company.replace("&","...");
		var companyPerson=document.addFolloUp.companyContactPerson.value;
		var companyPhone=document.addFolloUp.companyPhoneNumber.value;
		var companyEmail=document.addFolloUp.companyEmail.value;
		var companyCity=document.addFolloUp.companyCity.value;
		var companyProduct=document.addFolloUp.companyProduct.value;
		var customercode=document.addFolloUp.companyCode.value;
		window.open(webadd+'?companyName='+company.replace('&','~')+'&companyPerson='+companyPerson+'&companyPhone='+companyPhone+'&companyEmail='+companyEmail+'&companyCity='+companyCity+'&companyProduct='+companyProduct+'&customercode='+customercode);
	   }
	   else 
		   {
		      alert("Please Select The Company Name");  
  	       }
		}catch(e)
		{
			alert(e);
		}
	}
	
	function editCompany(webadd1,webadd2)
	{ 
		var custType;
		custType = document.addFolloUp.custType.value;
		/* alert("Edit Company Type==> "+custType);
		alert("First page=====>"+webadd1+"Second page----->>>"+webadd2); */
		//var a = validateCompany(a);
		if(document.addFolloUp.companyCode.value=="" || document.addFolloUp.companyCode.value==null)
		{
			alert("Please select Customer! ");
		}
		else{
			/* alert("Edit Company Typ******88> "+custType); */
		
			if(custType=='Customer'){
				window.open(webadd1+'?companyCode='+document.addFolloUp.companyCode.value);
			}else{
				window.open(webadd2+'?companyName='+document.addFolloUp.companyCode.value);
			}	
			
		}
		
		    
		
	}


	function editProspect(webadd)
	{ 
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
			alert("Please select Customer ");
		else
			window.open(webadd+'?companyName='+document.addFolloUp.companyNames.value);
	}



	
	
	
	function check(webadd)
 	{
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
		alert("Please select Prospect ");
	
		else
		{
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
					var mySplitResult = reslt.split("#");
					if(mySplitResult[1]=='Yes')
					{
							alert("This Prospect is already converted into Customer");
							return false;
					}
		
					else
					{
						var agree=confirm("\n\n Do you want to convert Prospective Customer: "+document.addFolloUp.companyNames.value.replace('&','~~')+" to customer?");
						if (agree)
						window.location=webadd+'?companyName='+document.addFolloUp.companyNames.value.replace('&','~~');
					}
				} 
			}
		    
			var queryString = "?companyName="+document.addFolloUp.companyNames.value.replace('&','~~');
			ajaxRequest.open("GET", "AjaxGetCustomerList.jsp" + queryString, true);
			ajaxRequest.send(null);

		}
 	}
	
	function getEmp()
	{
		//alert("m shoaib");
		document.getElementById("EmpList").style.display='block';
		var emp=document.getElementById("EmpNames").value;
//		alert(document.getElementById("EmpNames").value);
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
				document.getElementById("EmpList").innerHTML=reslt;
			} 
		}
		var queryString = "?emp=" +emp;
		//alert(""+queryString);
		ajaxRequest.open("GET", "GenericAjaxSearchME.jsp" + queryString, true);
		ajaxRequest.send(null); 
	}
	
	function showVisitingCardDetails(eName,empMail)
	{
		//alert("Inside Show visiting card details...");
		document.getElementById("EmpNames").value=eName;
		document.getElementById("SelectedEmpMail").value=empMail;
		//alert(document.getElementById("SelectedEmpMail").value=empMail);
		document.getElementById("EmpList").style.display='none';
	}
	
	function newwindow()
	{ 
		if(document.addFolloUp.customerName.value=="" || document.addFolloUp.customerName.value==null)
			alert("Please select Prospect ");
		else
			window.open('prospectDetails.jsp'+'?companyName='+document.addFolloUp.customerName.value,'jav','width=750,height=500,top=30,left=300,resizable=no');
	}

	function newwindowEmail(webadd)
	{ 
		if(document.getElementById("search-text").value=="" || document.getElementById("search-text").value==null)
			alert("Please select a company name");
		else
			window.open(webadd+'?email='+document.getElementById("companyEmailID").value+'&company='+document.getElementById("search-text").value,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}
	
	function billingDetails()
	{ 
		//alert(document.addFolloUp.custType.value);
	
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
			alert("Please select a Company Name");
		else 
			window.open('billingDetails.jsp'+'?companyName='+document.addFolloUp.companyNames.value.replace('&','~')+'&companyCode='+document.addFolloUp.companyCode.value,'_blank');/* 'jav','width=750,height=700,top=30,left=300,resizable=yes' */
	}
	
	function customerDetails()
	{ 
		//alert("in customerDetails");
		//alert(document.addFolloUp.custType.value);
			var customercode=document.addFolloUp.companyCode.value;
//alert(customercode);
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
			{
			alert("Please select a Company Name");
			}
		else {
			window.open('customerDetails.jsp'+'?companyName='+document.addFolloUp.companyNames.value.replace('&','~')+'&type='+document.addFolloUp.custType.value+'&customercode='+customercode,'jav','width=750,height=700,top=30,left=300,resizable=yes');
	   }
	}
	
	function cancelfileAttachment()
	{
		document.getElementById("fileAttachment").style.visibility="hidden";
	}

	
	function showFileAttachementForm()
	{
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
			alert("Please select a Company ");
		else
		window.open('documentAttach.jsp'+'?companyName='+document.addFolloUp.companyNames.value.replace('&','~'),'jav','width=300,height=200,top=30,left=300');
	}

	
	function showProspectFileAttachementForm()
	{
		if(document.addFolloUp.customerName.value=="" || document.addFolloUp.customerName.value==null)
			alert("Please select a Prospect");
		else
		window.open('documentAttach.jsp'+'?companyName='+document.addFolloUp.customerName.value.replace('&','~'),'jav','width=300,height=200,top=30,left=300');

	}

	
	function getSpokenTo(type)
	{
			// alert("m another function for shoaib");
			var company=document.addFolloUp.companyNames.value;
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
					document.getElementById("spokento").innerHTML=reslt.replace(/\s/g, "");
				} 
			}
			
			var queryString = "";"?company=" +company+"";
			if(type == 'comp')
			{
				//alert("in company");
				var company=document.addFolloUp.companyNames.value;
				queryString = "?company=" +company+"";
				ajaxRequest.open("GET", "getSpokenTo.jsp" + queryString, true);
				ajaxRequest.send(null); 
			}
			else
			{
				//alert("in Prosp");
				var company=document.addFolloUp.customerName.value;
				queryString = "?company=" +company+"";
				ajaxRequest.open("GET", "getSpokenTo.jsp" + queryString, true);
				ajaxRequest.send(null);  
			}
			
	}	

    function popup()
   	{
    	var Type = document.addFolloUp.custType.value;
	   
		   if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
				alert("Please select the Company Name");
			else
	           window.open('showMultipleContacts.jsp'+'?Type='+Type+'&company='+document.getElementById("search-text").value+'&companyCode='+document.addFolloUp.companyCode.value,'jav','width=470,height=500,top=250,left=400,resizable=no');
	   
   }
    
    function popup1()
   	{
    	
   	
    	var company=document.addFolloUp.companyNames.value;
		var customercode=document.addFolloUp.companyCode.value;
		
		var Type = document.addFolloUp.custType.value;
		company=company.replace("&","...");
	   
		   if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
				alert("Please select the Company Name");
			else
	           window.open('OpportunityRep.jsp'+'?companyname='+company+'&customercode='+customercode+'&customertype='+Type);
	   
   }

 </script> 
  <style>
  label{
    /* width: 30%; */
    width:85%;
    align-content: center;
    font-weight: 500;
    font-size: small;
}
.control-label{
     font-weight: 500; /* Makes the text bold */
      font-size:12px; /* Font Size */
 
}
    .profile-card {
    display: flex;
    align-items: center; 
    padding: 10px;
    border: 1px solid #ddd; 
    border-radius: 8px;
    background-color: #f9f9f9; 
    width: 100%; 
}

.profile-img {
    width: 40px; 
    height: 40px; 
    border-radius: 50%;
    object-fit: cover;
    margin-right: 10px; 
}
 
.profile-info h6 {
    margin: 0; /* Remove default margin */
    font-size: 16px; /* Adjust the size of the name text */
}

.profile-info p {
    margin: 0; /* Remove default margin */
    font-size: 14px; /* Adjust the size of the designation text */
    color: #888; /* Slightly gray color for designation */
}
  
  .profile-card {
    display: flex;
    flex-direction: row; /* Image and text will be in one line */
    padding: 10px;
    border: 1px solid #ddd; /* Light border around the card */
    border-radius: 8px; /* Rounded corners for the card */
    background-color: #f9f9f9; /* Background color for the card */
    width:90%; /* Set a fixed width for the profile card */
    margin: 10px;
}

.profile {
    width: 60px; /* Size of the profile image */
    height: 60px; /* Size of the profile image */
    border-radius: 50%; /* Make the image round */
    object-fit: cover; /* Ensure the image covers the space without distortion */
    margin-right: 10px; /* Space between image and text */
}

.profile-info {
    display: flex;
    flex-direction: column; /* Stack the text vertically */
    justify-content: center; /* Center the text vertically */
}
  
.detail-info {
    display: flex;
    flex-direction: row; /* Align profile details in a horizontal line */
    justify-content: space-between; /* Distribute space evenly between the sections */
    width: 100%; /* Ensure full width */
}

.info-section {
    display: flex;
    flex-direction: column; /* Stack label and value vertically within each section */
    align-items: center; /* Center the content horizontally */
    flex: 1; /* Ensure all sections take up equal space */
/*     padding: 5px;
 */}

.info-section h6 {
    margin: 0; /* Remove default margin */
    font-size: 14px; /* Adjust size of the heading */
    font-weight: bold; /* Make the label bold */
    color: #333; /* Dark color for the text */
}

.info-section p {
    margin: 0; /* Remove default margin */
    font-size: 14px; /* Adjust the size of the text */
    color: #555; /* Slightly lighter color for the text */
}

.glass-button {
    margin: 5px;
      color: #fff; /* White text color */
/*     background: rgba(0, 128, 128, 0.3); /* Semi-transparent background (CadetBlue with opacity) #2498cd*/
  background : #2498cd;
    border: 2px solid; /* Semi-transparent border */
    border-radius: 30px; /* Rounded corners */
    width: 120px; /* Fixed width */
    height: 35px; /* Fixed height */
    font-size: 12px; /* Font size */
    font-weight: bold; /* Bold text */
    text-align: center; /* Center the text */
    cursor: pointer; /* Pointer cursor on hover */
    transition: all 0.3s ease; /* Smooth transition for hover effect */
    backdrop-filter: blur(10px); /* Apply the blur effect behind the button */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow to give depth */
}

.btn-card{
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
   background-clip: border-box;
    border-radius: 0.25rem;
}

span{
      font-size:13px; /* Font Size */

}
.data-card{

    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
/*     border: 1px solid rgba(0,0,0,.125);
 */    border-radius: 0.25rem;
       font-size:12px; /* Font Size */
 
}
.data-card h6{

       font-size:13px; /* Font Size */
 
}
.data-card1{

    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
     border: 1px solid rgba(0,0,0,.125);
     border-radius: 0.25rem;
       font-size:11px; /* Font Size */
 margin:2px;
     box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow to give depth */
 
}
.form-control {
    display: block;
    width: 100%;
    padding: 0.2rem 0.75rem;
    font-size: 11px;
    font-weight: 400;
    line-height: 1;
    color: #212529;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
  </style>   
    <script>
    function toggleEdit() {
        // Toggle between span and input visibility
        const fieldsToToggle = [
            { id: 'date', inputId: 'dateInput' },
            { id: 'rep', inputId: 'repInput' },
            { id: 'addby', inputId: 'addbyInput' },
            { id: 'leadref', inputId: 'leadrefInput' },
            { id: 'contact', inputId: 'contactInput' },
            { id: 'pvalue', inputId: 'pvalueInput' },
            { id: 'adcontacts', inputId: 'adcontactsInput' },
            { id: 'mobile', inputId: 'mobileInput' },
            { id: 'email', inputId: 'emailInput' },
            { id: 'code', inputId: 'codeInput' },
            { id: 'opcount', inputId: 'opcountInput' },
            { id: 'city', inputId: 'cityInput' },
            { id: 'product', inputId: 'productInput' },
            { id: 'weekoff', inputId: 'weekoffInput' },
            { id: 'fax', inputId: 'faxInput' },
            { id: 'website', inputId: 'websiteInput' }

            // Add other fields similarly here
        ];

        fieldsToToggle.forEach(field => {
            const span = document.getElementById(field.id);
            const input = document.getElementById(field.inputId);
            const isEditable = input.style.display === 'none';

            // Show the input and hide the span if not editable, otherwise reverse
            span.style.display = isEditable ? 'none' : 'inline';
            input.style.display = isEditable ? 'inline' : 'none';
        });
    }
</script>
   </head>
<body style="background-color:azure;">

<form name="addFolloUp" method="post" action="" enctype="multipart/form-data" id="addFolloUp">
<div class="container-fluid" style="padding-top:5%;">
<div class="row"> 
     <div class="col-3"></div>
     <div class="col-5">
     <div class="row">
      <form class="d-flex">
      <label>Search Customer</label>
        <input class="form-control me-2" type="search" id="search-text" name="companyNames" placeholder="Search" aria-label="Search" style="font-size:12px;" onkeyup="timer();">
      </form>
      </div>
      <div class="row mt-1" id="comlist"  style="display:none;margin-left:10px;">
         <div id='companyList' style="background-color: white;height: 100px; width: 500px; overflow: auto; border:solid inset;" align="center">
				</div>  
         <input type="hidden" name="counter" id="counter" value="10" />
				   
	</div>
     </div>
          <div class="col-4 mt-3"> <button class="btn btn-primary" id="button" name="button" onclick="goto1('addNewProspect.jsp');">Add New Prospect</button>
                     <button class="btn btn-primary" id="button" name="button" onclick="goto2('addNewProspect.jsp');">Add New Liaison</button>
</div>
<div id="labels" style="display: none;">
    <div class="row mt-2">
     <div class="col-md-7">
  <div class="card">
              <div class="card-body">
              <div class="row">
                  <div class="col-2 d-flex justify-content-center"><img src="imagesnew/User.png" alt="Profile Image" class="profile"/></div>
                  <div class="col-10">
                  <div class="row">
                  <div class="col-6"><input type="text" id="custname" name="custname" value="" style='border-style: none;font-size: 18px;' readonly></div>

                  </div>
                  <div class="row">
                  <input type="text" id="custType" name="custType" value="" style='border-style: none;font-size: 12px;' readonly/>
                  </div>
                  </div>
              </div>
             <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="date" class="control-label">Added on Date :</label>
        </div>
        <div class="col-md-6">
            <input type="text" id="addedOnDate" name="addedOnDate" value="" class="form-control" readonly>
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="rep" class="control-label">Rep :</label>
        </div>
        <div class="col-md-6">
            <input type="text" id="lab-text" name="companyEnteredBy" value='<%=session.getAttribute("EmpName")%>' class="form-control" readonly>

        </div>
        </div>
              </div>
             </div> 
              <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="addby" class="control-label">Added By :</label>
        </div>
        <div class="col-md-6">
             <input type="text" id="search-text" name="assignedBy" value="" class="form-control" readonly>
            
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="leadref" class="control-label">Lead Ref :</label>
        </div>
        <div class="col-md-6">
            <input type="text" id="search-text" name="leadRef" value="" class="form-control" readonly>
            
        </div>
        </div>
              </div>
             </div> 
             <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="contact" class="control-label">Contact :</label>
        </div>
        <div class="col-md-6">
              <input type="text" id="search-text"  name="companyContactPerson" value="" class="form-control" readonly>
            
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="pvalue" class="control-label">Potential Value :</label>
        </div>
        <div class="col-md-6">
             <input type="text" id="search-text"  name="PotentialValue" value="" class="form-control" readonly>
            
        </div>
        </div>
              </div>
             </div> 
             <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="adcontacts" class="control-label">Additional Contacts :</label>
        </div>
        <div class="col-md-6">
            <input type="text" id="search-text" name="CompanyCount" value="" class="form-control" readonly>
            
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="mobile" class="control-label">Mobile :</label>
        </div>
        <div class="col-md-6">
             <input type="text" id="search-text" name="companyPhoneNumber" value="" class="form-control" readonly>
            
        </div>
        </div>
              </div>
             </div> 
             <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="email" class="control-label">Email :</label>
        </div>
        <div class="col-md-6">
           <textarea name="companyEmail" rows="1" id="search-text" style="font-size: 10px;" class="form-control" readonly></textarea>
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="code" class="control-label">Code :</label>
        </div>
        <div class="col-md-6">
              <input type="text" id="lab-text" name="companyCode" value="" class="form-control" readonly>
        </div>
        </div>
              </div>
             </div> 
             <div class="row">
             	<%if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport")))
								{
									%>
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <a href="#" onclick="gotoOprtunity('addOpportunityNew.jsp');"><label for="opcount" class="control-label">Opportunity Count :</label></a>
        </div>
        <div class="col-md-6">
               <input type="text" id="search-text" name="count" value="" class="form-control" readonly>
        </div>
        </div>
        </div>
        <%}
								else {
								%>
              <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="opcount" class="control-label">Opportunity Count :</label>
        </div>
        <div class="col-md-6">
               <input type="text" id="search-text" name="count" value="" class="form-control" readonly>   
        </div>
        </div>
        </div>
        <%}
								%>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="city" class="control-label">City :</label>
        </div>
        <div class="col-md-6">
              <input type="text" id="search-text" name="companyCity" value="" class="form-control" readonly>
        </div>
        </div>
              </div>
             </div> 
             
              <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="product" class="control-label">Product :</label>
        </div>
        <div class="col-md-6">
               <input type="text" id="search-text"  name="companyProduct" value="" class="form-control" readonly>
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="weekoff" class="control-label">Weekly off :</label>
        </div>
        <div class="col-md-6">
             <input type="text" id="search-text"  name="customerWeeklyOff" value="" class="form-control" readonly>
        </div>
        </div>
              </div>
             </div> 
              <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-6">
            <label for="fax" class="control-label">Fax :</label>
        </div>
        <div class="col-md-6">
              <input type="text" id="search-text" name="companyfax" value="" class="form-control" readonly>
        </div>
        </div>
        </div>
                     <div class="col-6">
         <div class="row">
           <div class="col-md-6">
            <label for="website" class="control-label">Website :</label>
        </div>
        <div class="col-md-6">
            <input type="text" id="search-text" name="companyWebSite" value="" class="form-control" readonly>
     
        </div>
        </div>
              </div>
             </div> 
            </div>
           </div> 
        
    </div>
     <div class="col-md-5" id="BtnLabels" style="display:none;">
      <div class="btn-card">
              <div class="card-body">
                               <button type="button" class="glass-button"><a href="#" style="text-decoration:none;color:white;" onClick="showFollowUpEntryForm('followupEntryForm.jsp');return false ">Follow-Up</a></button>
                   <% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport"))){%>
                   
                               <button type="button" class="glass-button" onclick="gotoOprtunity('addOpportunityNew.jsp');">Opportunity</button>
                    <%}else{ %>
                               <button type="button" class="glass-button" onclick="gotoOprtunity('OpportunityRep.jsp');">Opportunity</button>
                    <%} %>
                               
                               <button type="button" class="glass-button" onclick="editCompany('EditCompaany.jsp','Editprospect.jsp');">Edit</button>
                    
                    <button type="button" class="glass-button" onclick="customerDetails();">Details</button>
                    <button type="button" class="glass-button" onclick="gotoLedgerDetails('ledgerdetails.jsp');">Ledger Det</button>
                    <button type="button" class="glass-button" onclick="editProspect('prospectHistory.jsp');">Show History</button>
                    <button type="button" class="glass-button" onclick="check('ProsToCust.jsp');">ConvToCust</button>
                    <button type="button" class="glass-button" onclick="gotoFollowUpReport('customerWiseFollowUpReport.jsp');">Follow-Up Rep</button>
                    <button type="button" class="glass-button" onclick="gotoFollowUpReport('CustDocList.jsp');">Doc Uploaded</button>
                    <button type="button" class="glass-button" onclick="gotoAddContacts('contactdetails.jsp','comp');">Add Contacts</button>
                    <button type="button" class="glass-button" onclick="return goto3('addNewCustomerBranch.jsp');">Add Branch</button>
                                  <% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport")))
								{%>     
                                        <button type="button" class="glass-button" onclick="gotoviewQuotation('IntroMail.jsp');">Intro Email</button>
                                       <%}else{ %>
                                        <button type="button" class="glass-button" onclick="gotoviewQuotation('IntroMail.jsp');">Intro Email</button>
                                   <%} %>
                    <button type="button" class="glass-button" onclick="billingDetails();">Billing Profile</button>
                    <button type="button" class="glass-button" onclick="gotoviewcontract('customercontract.jsp');">Contract</button>
                               
             </div> 
       </div>       
     </div>
   
    </div>

 <div class="row mt-2 mb-5" id="Last" style="display:none;">
  <div class="col-md-6">
      <h6 class="card-title"><b>Last 3 Transactions</b></h6>
  
  <div class="data-card" id="transactionDetails" style="min-height:90px;">
</div>
</div>
    <div class="col-md-6">
                <h6 class="card-title"><b>Last 3 Follow-Ups</b></h6>
  <div class="data-card" id="followupDetails" style="min-height:90px;">
          
     </div>
   </div>
 </div>
 </div>
</div>
<div id='tempList' align="center" style="display: none;">						
</div>
</div>	
</form>
 <%@ include file="footer.jsp" %>

</body>
</html>