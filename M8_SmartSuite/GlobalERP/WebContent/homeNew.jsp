<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%-- <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 --%>
<head>
<style>
			body
			{
            margin: 0px;
            padding: 0px;
            }
            
            #divheader
            {
            height:50;
            background:	White;
            }
            
            #header 
            {
            background: #2675a8;
            font:large;
            color:green;
            width: 100%;
            }
            
            #leftcolumn 
            {
            background:#0099CC;
            float: left;
            width: 35%;
            height: 400px;
            }
            
            #content 
            {
            border:medium;
            border-color:blue;
            background: ;
            float: left;
            width: 100%;
            height: 400px;
            overflow:scroll;
            }
            
            #myfooter 
            {
            background: #df781c;
            clear: both;
            width: 100%;
            }
            #tooltip
            {
  			  	position:relative;
    			font-family:arial,sans-serif;
    			font-size:10px;
    			color:#000;
    			padding:3px;
    			border:1px solid #000;
    			background-color:#ffe;
			}
			table.mysortable
			{
				text-align: left;
				font-family: Verdana, Geneva, Arial, Helvetica, sans-serif ;
				font-weight: normal;
				font-size: 11px;
				color: #fff;
				background-color: #1581AB; <!-- -->
				border: 0px;
				border-collapse: collapse;
				border-spacing: 0px;
			}

			table.mysortable td
			{
				background-color: #F8F8FF;
				color: #000;
				padding: 4px;
				border: 1px #808080 solid;
			}
			table.mysortable th
			{
				background-color: #1581AB;
				color: white;
				padding: 4px;
				border: 1px #808080 solid;
			}

			table.mysortable td.hed
			{
				background-color: #C6DEFF;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

			table.mysortable td.hed1
			{
				background-color: #C6DEFF;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

</style>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-166064963-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-166064963-1');
</script>

 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>
<script type="text/javascript">


function popup123(webadd)
{ 
	var companyName = document.addFolloUp.companyNames.value;
	var customercode=document.addFolloUp.companyCode.value;
	var CustType=document.addFolloUp.custType.value;
	// window.open(webadd+'?Comapny='+companyName+'&Code='+customercode+',' ' ,'width=565,height=320,top=200,left=300,resizable=no');
	
	window.open(webadd+'?Company='+companyName+'&Code='+customercode+'&Type='+CustType+'','','width=565,height=320,top=200,left=300,resizable=no');
	
}
function reassign()
{ 
	//alert("in ressign");
	var companyName = document.addFolloUp.companyNames.value;
	//alert("companyName..."+companyName);
	var customercode=document.addFolloUp.companyCode.value;
	//alert("customercode..."+customercode);
	var CustType=document.addFolloUp.custType.value;
	//alert("CustType..."+CustType);
	var vehlist=document.addFolloUp.vehlst.value;
	
	var billYear=document.addFolloUp.billYear.value;
	var billMonth=document.addFolloUp.billMonth.value;

	
	//alert("vehlist..."+vehlist);
	// window.open(webadd+'?Comapny='+companyName+'&Code='+customercode+',' ' ,'width=565,height=320,top=200,left=300,resizable=no');
	window.open('ReAllocationNew.jsp?Company='+companyName+'&Code='+customercode+'&Type='+CustType+'&Vehlist='+vehlist+'&billYear='+billYear+'&billMonth='+billMonth);

		//window.open('prospectDetails.jsp'+'?companyName='+document.addFolloUp.customerName.value,'jav','width=750,height=500,top=30,left=300,resizable=no');

/* 	window.open(webadd+'?Company='+companyName+'&Code='+customercode+'&Type='+CustType+'','','width=565,height=320,top=200,left=300,resizable=no');
 */	
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
		 var load = window.open(webadd+'/stock-market/equity/NewsBoard/133/'+key+'^/AllNewsScripListing.htm','','scrollbars=yes,menubar=yes,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
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

	function goto1(webadd)
	{
		
		 var Category="Prospect";
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
	
	
	function goto2(webadd)
	{
		
	    var Category="Liaison";
		window.open(webadd+'?Category='+Category);
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
	
	function getCustomerInfo(type, code) 
	{
		
	
		//alert(" >>.in fun Cutomer Type=>"+type);
		//alert(" >>.in fun for Customer code=>"+code);
		if(type == "" || type==null)
		{
			alert("Error  ");
		}
		else
		{
		//alert(" type==> "+type+" >>"+ code);
		document.getElementById("companyList").style.visibility="hidden";
		document.getElementById("comlist").style.display="none";
		document.getElementById("labels").style.display="";
		document.getElementById("Last").style.display="";
		document.getElementById("BtnLabels").style.display="";
		//alert("=1===");
		
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

	function timer()
	{
		//alert("in timer");
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
				document.addFolloUp.custType.value="";
				 
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
		alert("in customerDetails");
		//alert(document.addFolloUp.custType.value);
			var customercode=document.addFolloUp.companyCode.value;
alert(customercode);
		if(document.addFolloUp.companyNames.value=="" || document.addFolloUp.companyNames.value==null)
			{
			alert("Please select a Company Name");
			}
		else {
			window.open('customerDetails.jsp'+'?companyName='+document.addFolloUp.companyNames.value.replace('&','~')+'&type='+document.addFolloUp.custType.value+'&customercode='+customercode,'jav','width=750,height=700,top=30,left=300,resizable=yes');
	   }
	}
	function validate()
	{
		//alert(document.addFolloUp.myfile.value);
		//alert("Check for Empty Todate"+document.addFolloUp.todate.value);
		if(document.addFolloUp.todate.value=='')
		{
			alert("Please Enter Next Follow-Up Date" );
			return false;
		}
	//	alert("Check for Comments"+document.addFolloUp.comments.value);
		if(document.addFolloUp.comments.value=='')
		{
			alert("Please Enter Comments" );
			return false;
		}

		var userDate = document.addFolloUp.fromdate.value;
		var tdy = document.addFolloUp.today.value;
		//alert(tdy);
		var ydy = document.addFolloUp.yesterday.value;
		//alert(ydy);
		if(userDate != tdy || useDate != ydy)
		{
			alert("Follow-Up For "+userDate+" Is Not Allowed");
			return false;
		}
		
		return true; 
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

	  /*	 function showmorecompanies()
	 {
		//alert("IM MORE FUNC  ");
		document.getElementById("companyList").style.visibility="visible";
		//document.getElementById("companyList2").style.visibility="visible";
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
				//alert(reslt);
				//var mySplitResult = reslt.split("#");
				//alert(mySplitResult[15]);
				document.getElementById("companyList").innerHTML=reslt;


			} 
		}
		var queryString = "?company=" +company+"&limitcount=100&clikcnt=1";
		 
		//alert("IN AJAX");
		ajaxRequest.open("GET", "AjaxGetCompanyInfo.jsp" + queryString, true);
		ajaxRequest.send(null); 
	 } */
	 
	 
//	if (document.all || document.getElementById)
	//	document.body.style.background = "url('images/bg.jpg')  white top no-repeat "
			
</script>
</head>
<body >
<%-- <%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
 %> --%>
 <%!
Connection conn=null;
%>	 
 <%
try{ 

 %>
 <%
  
    Class.forName(DB_Driver);
	conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

 	Statement st = null, st1 = null, st3 = null, st4 = null;
 	Statement st2 = null;
 	String selectedName;
 	String FollowUpType = "",vehlist="",billYear="",billMonth="";
 	
 

 %>
 <%
 	String fromDateCal = "", toDateCal = "", sql = "";
 	String todaysTime = new SimpleDateFormat(" HH:mm:ss")
 				.format(new java.util.Date());

 	Date tdy = new Date();
 	Date tomorrow = new Date();
 	Calendar cal = Calendar.getInstance();
 	Calendar now = Calendar.getInstance();
 	cal.setTime(tdy);
 	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(tdy);
 	cal.add(Calendar.DAY_OF_MONTH, -1);
 	Date YesterdaysDateAsDate = cal.getTime();
 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(YesterdaysDateAsDate);

 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(new java.util.Date());
 	try {
 		Class.forName(DB_Driver);
 		conn= DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD); 			
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
 	//====Get Syst Crnt Time==================================
 		Date d = new Date();

 		Format df1 = new SimpleDateFormat("yyyy-MM-dd");
 		String dtoday = df1.format(d);

 		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
 		DateFormat d1 = new SimpleDateFormat("yyyy-MM-dd");

 		Format d2 = new SimpleDateFormat("HH:mm:ss");
 		String incdReg = d2.format(d);
 		String hrTime = incdReg.substring(0, 2);
 		String minTime = incdReg.substring(3, 5);
 		System.out.println(">>>>>>>>>>>>dtoday:" + dtoday);
 		
 		vehlist = request.getParameter("Vehlist");
 	 	System.out.println("vehlist"+vehlist);
 	 	
 	 	billYear = request.getParameter("billYear");
 	 	System.out.println("billYear"+billYear);
 	 	
 	 	billMonth = request.getParameter("billMonth");
 	 	System.out.println("billMonth"+billMonth);
 		//========================================================
 %>
	<!-- <div style="text-align: right">
	<table border="1" width="10%" style="align=right;">
		<tr>

			<td align="right"><input type="checkbox"
				name="Money-Control" value="Moneycontrol"></input></td>
			<td><input type="checkbox"
				name="Google" value="Google"></input></td>
			<td><input type="checkbox"
				name="India Times" value="India Times"></input></td>
		</tr>
	</table>
	</div> -->
 
	<form name="addFolloUp" method="post" action="addFollowUp.jsp" enctype="multipart/form-data" onSubmit="return validate();" id="addFolloUp">
	<div id="followUpTable" style="display: none; margin-left:71%; margin-top:2%; height:425;width:35%; border-style:inset; border-width:1; border-color: blue;position:absolute; background-color: #E1F3F3;">
			<table>
			<input type="hidden" name="today" id="today" value="<%=todaysDate%>">
			<input type="hidden" name="yesterday" id="yesterday" value="<%=yesterdaysDate%>">
			<input type="hidden" name="vehlst" id="vehlst" value="<%=vehlist%>">			
			<input type="hidden" name="billYear" id="billYear" value="<%=billYear%>">
			<input type="hidden" name="billMonth" id="billMonth" value="<%=billMonth%>">
			
			
			<tr>
				</tr>
				<tr>
					<td colspan="1">
							
					<table style="background: white;" cellspacing="1" border="0">
					<tr>

							<td colspan="2">

							<div id="enterFollowUpLabel"
								style="font-size: 1.2em; text-shadow text-align: left margin-top : 1.0em; margin-bottom: 1.0em;">
							<a> Enter Follow Up.</a></div>
							</td>
					</tr>
					<tr>
							<th align="left">Follow-Up Date</th>
							<td align="left" valign="top"><input type="text"
								id="fromdate" name="fromdate" value='<%=fromDateCal%>' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
							<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
							<script type="text/javascript">
						Calendar.setup( {
							inputField : "fromdate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "fromdate" // ID of the button
						});
					</script>&nbsp;&nbsp;&nbsp;					
					<input style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" name="followuptime" value="<%=todaysTime%>"/>			
					</td>
					</tr>
					<tr>
						<th align="left">Follow-Up IN/OUT</th>
						<td><input type="checkbox" name="inorout" value="in" />IN &nbsp;&nbsp;&nbsp;  
						<input type="checkbox" name="inorout" value="out"   />OUT</td>
					</tr>
					<tr>
							<th align="left">Status &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
							<td style="vertical-align: top;" align="left"><select
								name="followUpStatus" id="followUpStatus" style='width: 70px;'>
								<option value="cold">Cold</option>
								<option value="warm">Warm</option>
								<option value="hot">Hot</option>
							</select></td>

					</tr>
					<tr>
							<th align="left">Follow-Up Type</th>
							<td style="vertical-align: top;" align="left"><select
								name="followUpType" id="followUpType" style='width: 100px;'>
								<option value="phoneCall">Ph. Call</option>
								<option value="Visit">Visit</option>
								<option value="E-mail">E-mail</option>
								<option value="Letter">Letter</option>
								<option value="Meeting">Meeting</option>
							</select></td>


					</tr>
					<tr>
							<th align="left">Comments</th>
							<td style="vertical-align: top;" align="left"><textarea 
								wrap="virtual" rows="2" cols="25" name="comments" id="comments"
								style="height: 50px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 70; max-width: 70;"></textarea></td>
					</tr>
					<tr>
							<th align="left">Next Follow-Up Date<br>Time</th>
							<td align="left" valign="top"><input type="text" id="todate"
								name="todate" value='' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" />
		             <script type="text/javascript">
						Calendar.setup( {
							inputField : "todate", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "todate" // ID of the button
						});
					</script>&nbsp;&nbsp;&nbsp;					
									&nbsp;&nbsp;
		<select name="hrs" id="hrs" style="
				  	width: 45px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
		<option value="<%=hrTime%>"><%=hrTime%></option>
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for (int i = 10; i < 24; i++) {
		%>
				<option value="<%=i%>"><%=i%></option>
			<%
				}
			%>
		</select>
		<select name="mins" id="mins" value="<%=minTime%>" style="
				  	width: 45px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
		<option value="<%=minTime%>"><%=minTime%></option>
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for (int i = 10; i < 60; i++) {
		%>
				<option value="<%=i%>"><%=i%></option>
		<%
			}
		%>
		
		</select>	</td>

					</tr>
					<tr>
						<th align="left">Next Followup Type</th>
						<td style="vertical-align: top;" align="left"><select
								name="nextfollowUpType" id="nextfollowUpType" style='width: 100px;'>
								<option value="phoneCall">Ph. Call</option>
								<option value="Visit">Visit</option>
								<option value="E-mail">E-mail</option>
								<option value="Letter">Letter</option>
								<option value="Meeting">Meeting</option>
							</select></td>
					</tr>
						
						<tr>
						<th align="left">Preparation for <br>next followup</th>
							<td style="vertical-align: top;" align="left"><textarea 
								wrap="virtual" rows="2" cols="25" name="preparation" id="preparation"
								style="height: 50px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 70; max-width: 70;"></textarea></td>
						</tr>
						<tr>
							<th align="left">Payment<br>
							Follow-Up</th>
							<td align="left" valign="top"><input type="checkbox"
								name="paymentFollowUp" value="paymentFollowUp"></input>
							&nbsp;&nbsp;&nbsp;	
							<b>Reply</b><input type="checkbox"
								name="reply" value="reply"></input></td>
						</tr>
						<tr>
						<th align="left">Spoken To</th>
							<td style="vertical-align: top;" align="left"><textarea 
								wrap="virtual" rows="2" cols="25" name="spokento" id="spokento"
								style="height: 15px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 40; max-width: 40;"></textarea></td>
					
						</tr>
							<tr>
						<th align="left">Amnt Expctd</th>
							<td style="vertical-align: top;" align="left"><textarea 
								wrap="virtual" rows="2" cols="10" name="expectedamnt" id="expectedamnt"
								style="height: 15px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 20; max-width: 20;"></textarea></td>
						</tr>
						<tr>
							<th align="left">Amnt Expectd On</th>
							<td align="left" valign="top"><input type="text"
								id="expectedon" name="expectedon" value='' size="15" readonly="readonly"
								style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
							<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
							<script type="text/javascript">
						Calendar.setup( {
							inputField : "expectedon", // ID of the input field
							ifFormat : "%d-%b-%Y", // the date format
							button : "expectedon" // ID of the button
						});
					</script>&nbsp;&nbsp;&nbsp;					
					</td>
					</tr>
						<tr>
						<th align="left">Remarks</th>
							<td style="vertical-align: top;" align="left"><textarea 
								wrap="virtual" rows="2" cols="25" name="remarks" id="remarks"
								style="height: 50px; padding: 4px 5px 2px 5px; border: 1px solid; # DEDEDE; background: #FFFFFF font :normal 11px Arial, Helvetica, sans-serif; color: #5D781D; width: 70; max-width: 70;"></textarea></td>
						</tr>
						<tr>
							
						</tr>
						<tr>
							<th align="left">Document Type</th>
							<td style="vertical-align: top;" align="left"><select
								name="documentType" id="documentType" style='width: 100px;'>
								<option value="select">SELECT</option>
								<option value="contactcard">Contact Card</option>
								<option value="commercial">Commercial</option> 
								<option value="meeting">Meeting</option>
								<option value="notes">Notes</option>
								<option value="legal">Legal</option>
							</select></td>
						<tr>
						<tr>
						<th align="left">Upload Document </th>
						<td><input type="file" name="myfile" id="myfile" />
						</td>	
						</tr>

						<tr>
							<td valign="top" align="left"><b>Special Email To </b></td>
							<td><input type="hidden" name="SelectedEmpMail"
								id="SelectedEmpMail" value="" /> <input type="text"
								name="EmpNames" id="EmpNames"
								style="width: 230px; border-color: activeborder;"
								autocomplete="off" value=""
								onkeyup="if (event.keyCode == 27){document.getElementById('EmpList').style.display = 'none';} else { getEmp(); }" />
							&nbsp;&nbsp;&nbsp;<br>
							<div style="position: absolute;">
							<table>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td>
									<div id='EmpList'></div>
									</td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<th>.</th>
					<td align="left" valign="top">
							<div><input	type="submit" id="search-submit" name="submitFollowUp" value="Submit"/></div>
							</td>
				</tr>
						<tr>
						</tr>
					</table>
					</td>
				</tr>
			</table>
	</div>
<div  align="center" style="border:thin solid; border-color: blue; background-color: #E1F3F3; border-radius: 12px 12px 12px 12px;" >
	<table width="100%" border="0" >
	<tr>
		<td align = "center" width="100%">
 			
					<table border="0" cellpadding="0" style="background: white;" >
 					<tr>
							<td align="left" style="display: none;">Customers not
							followed-up<br></br>
							since last 10 Days</td>
							<td style="display: none;">
							<%
								sql = " SELECT COUNT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectcustomers";
							%>
							<div id='customersNotfollowedup'>&nbsp;(10)&nbsp;&nbsp;</div>
							</td>
							<td align="left" style="display: none;">Prospects not
							followed-up<br></br>
							since last 10 Days</td>
							<td style="display: none;">
							<%
								sql = " SELECT COUNT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectcustomers";
							%>
							<div id='prospectsNotfollowedup'>&nbsp;(12)</div>
							</td>

						</tr>
					</table>
		</td>
	</tr>
				
	<tr>
		<td align="center">
					<form method="get" id="tab">
					
					
					<font size="2" style="font-family: Montserrat, sans-serif;">
					
					<div class="Pages" style="width: 100%; height: 900px;">
					<div class="Page">
					<div class="Pad" align="center">
					
					<div align="center">
					<table style="font-size:small" border="0" align="center" width = "100%" >
						<tr>						
						<td align="center"  colspan="">

							<div id="companyNames" style="margin-right: 5px;">
							<font size="2" style="font-family: Montserrat, sans-serif;">
								
							Search Customer :</font></div> </td><td>	
							<input type="text" name="companyNames"
								id="search-text" value="" style='width: 500px; font-size: 15px;' onkeyup="timer();"   />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	
	<a href="#" ><input type="button" onclick="return reassign();" style="width: 130px;height:25px;background-color: #C6DEFF;
	border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;" name="Reassign" value="Reassign" /></a>&nbsp;&nbsp;&nbsp;
							 
							
	<a href="#" ><input type="button" onclick="goto1('addNewProspect.jsp');" style="width: 150px;height:25px;background-color: #C6DEFF;
	border: medium;text-align: left;font: bold; cursor: pointer;" id="search-submit"name="addNewCustomer" value=" Add New Prospect" /></a>
	
<!-- <a href="#" ><input type="button" onclick="goto2('addNewProspect.jsp');" style="width: 150px;height:25px;background-color: #C6DEFF; 
 	border: medium;text-align: left;font: bold; cursor: pointer;" id="search-submit"name="addNewCustomer" value=" Add New Liaison" /></a>   -->
	
						</td>
						
					<!--	<td valign="bottom"    style="text-align: ;" id = "comlist">
						<div align="left" style="border: thin;margin-left: 30%;"> 
						<div id='companyList' style="background-color: white;height: 150px; width: 350px; overflow: auto; border:solid inset;" align="center">
						
						</div>
							<input type="hidden" name="counter" id="counter" value="10" />
							</div>
						</td>
						-->
							
						</tr>
					 	<tr id = "comlist"  style="display:none;" >
						<td></td>
						
						<td valign="top"    style="text-align: ;" >
						<div align="left" style="border: thin;"> 
						<div id='companyList' style="background-color: white;height: 150px; width: 500px; overflow: auto; border:solid inset;" align="center">
						
						</div>
							<input type="hidden" name="counter" id="counter" value="10" />
							</div>
						</td>
						</tr>
						 <tr>
									
											<td></td>
											<td><a
												href="javascript:searchMoneyControl('http://www.moneycontrol.com','cust')"><img
												src="images/moneyControl.jpeg"
												style="height: 22px; width: 100px;"></img></a>
											<a
												href="javascript:searchInfoline('http://www.sharekhan.com','cust')"><img
												src="images/sharekhan_logo.gif"
												style="height: 22px; width: 100px;"></img></a>
											<a
												href="javascript:searchGoogle('http://www.google.com','cust')"><img
												src="images/google_logo.jpg"
												style="height: 18px; width: 60px;"></img></a>
											<a
												href="javascript:searchLinkedin('http://www.linkedin.com','cust')"><img
												src="images/link.jpg" style="height: 18px; width: 60px;"></img></a>
											</td>
								</tr>
								
						</table>
			
					<table style="font-size:small"  border="0" width = "100%" >	
						<tr>
						<td>	
								
							<table align="center" id="labels" border ="0" style="display: none; border-collapse: collapse;" cellpadding="5" cellspacing="5">
							
							
						
								 <tr>
									<td align="left">Customer Type</td>
									<td valign="top">
									<div id="companyEnteredBy" style="visibility: visible;">
									<input type="text" name="custType" id = "custType"
										value=""
										style='border-style: none; width: 300px; height: 20px;font-size: 15px;background-color:#E1F3F3; '
										readonly="readonly" /></div>
									</td>
									
								</tr>
								<tr>
									<td align="left">Added on Date</td>
									<td valign="top">
									<div id="companyEnteredBy" style="visibility: visible;">
									<input type="text" name="addedOnDate" id="addedOnDate"
										value=""
										style='border-style: none; width: 300px; height: 20px;font-size: 15px;background-color:#E1F3F3; '
										readonly="readonly" /></div>
									</td>
									
								</tr>	
								<tr>
									<td align="left">Rep :</td>
									<td valign="top">
									<div id="companyEnteredBy" style="visibility: visible;">
									<input type="text" name="companyEnteredBy" id="lab-text"
										value='<%=session.getAttribute("EmpName")%>'
										style='border-style: none; width: 300px; height: 20px;font-size: 15px;background-color:#E1F3F3;'
										readonly="readonly" /></div>
									</td>
									
								</tr>
								
								<tr><td align = "left">Added By</td>
											<td valign="top">
											<div id="assignedBy"><input type="text"
												name="assignedBy" id="search-text" value=""
												style='border-style: none;width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'  readonly="readonly"/></div>
											</td>
								</tr>
								<tr>									
											<td align="left">Lead Ref</td>
											<td valign="top" >
											<div id="leadRef"><input type="text"
												name="leadRef" id="search-text" value=""
												style='border-style: none;width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'  readonly="readonly"/></div>
											</td>
											
								
								</tr>
								
								
								<tr>
									<td align="left">Contact</td>
									<td valign="top">
									<div id="companyContactPerson"><input type="text"
										name="companyContactPerson" id="search-text" value=""
										style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;' readonly="readonly" /></div>
									</td>
								</tr>
							<tr>
									<td align="left">PotentialValue</td>
									<td valign="top">
									<div id="PotentialValue"><input type="text"
										name="PotentialValue" id="search-text" value=""
										style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;' readonly="readonly" /></div>
									</td>
								</tr>
							
								
								<tr>
								<td align="left">Additional Contacts - <a href ="#" onclick="popup()" title="click to view multiple contacts">( View )</a></td>
									<td valign="top">
									<div id="CompanyCount"><input type="text"
										name="CompanyCount" id="search-text" value=""
										style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;' readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td align="left">Mobile</td>
									<td valign="top">
									<div id="companyPhoneNumber" style="visibility: visible;">
									<input type="text" name="companyPhoneNumber" id="search-text"
										value=""
										style='border-style: none; width: 300px;background-color: #E1F3F3;height: 20px;font-size: 15px;background-color:#E1F3F3;'
										readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td align="left" valign="top">E-mail</td>
									<td valign="top">
									<div id="companyEmail" style="visibility: visible;"><textarea
										name="companyEmail" rows="1" id="search-text"
										style='border-style: none;width: 300px;height: 40px;font-size: 15px;background-color:#E1F3F3;' readonly="readonly"></textarea>
									</div>
									</td>
								</tr>
								<tr>
									<td align="left">Code</td>
									<td valign="top">
									<div id="companyCode"><input type="text"
										name="companyCode" id="lab-text" value=""
										style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'
										readonly="readonly" /></div>
									</td>
								</tr>
								
								<%if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport")))
								{
									%>
								
								<tr>
								<td align="left">
									<a href="#" onclick="gotoOprtunity('addOpportunityNew.jsp');">
									<strong>Opportunity Count :</strong></a>
									</td>
									
									<td>
									<div id="count"><input type="text"
												name="count" id="search-text" value=""
												style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'
												readonly="readonly" /></div>
									
									</td>
									
									</tr>
									
									<%}
								else {
								%>
									
									<tr>
								<td align="left">
									<!-- <a href="#" onclick="gotoOprtunity('addOpportunityNew.jsp');"> -->
									Opportunity Count
									</td>
									
									<td><div id="count"><input type="text"
												name="count" id="search-text" value=""
												style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'
												readonly="readonly" />
									</div>
									</td>
									
									</tr>
									
																		
									<%}
								%>
								
									<tr><td align="left">City</td>							
											<td valign="top">
											<div id="companyCity"><input type="text"
												name="companyCity" id="search-text" value=""
												style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'
												readonly="readonly" /></div>
											</td>
								</tr>
								<tr>			
											<td align="left" >Product</td>
											<td valign="top">
											<div id="companyProduct"><input type="text"
												name="companyProduct" id="search-text" value=""
												style='border-style: none; width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;'
												readonly="readonly" /></div>
											</td>
								</tr>
								
								<tr>
									<td align="left">Weekly off</td>
									<td valign="top">
									<div id="customerWeeklyOff"><input type="text"
										name="customerWeeklyOff" id="search-text" value=""
										style='border-style: none;width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;' readonly="readonly"/></div>
										</td>
 
								</tr>
									
								<tr>
									<td align="left">Fax</td>
									<td valign="top">
									<div id="companyFax"><input type="text" name="companyfax"
										id="search-text" value=""
										style='border-style: none;width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;' readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td align="left">Website</td>
									<td valign="top">
									<div id="companyWebSite"><input type="text" name="companyWebSite" id="search-text" value=""
										style="border-style: none;width: 300px;height: 20px;font-size: 15px;background-color:#E1F3F3;" readonly="readonly" /></div>
									</td>
								</tr>
							</table>
	</td>
	<td>					

							<table id="BtnLabels" border="0" style="display: none;" cellpadding="5" cellspacing="5">
							
							  
							
								<tr>
								<td align="left" valign="top">
									<div><a href="#" onClick="showFollowUpEntryForm('followupEntryForm.jsp');return false "><%-- <input type="button" id="search-submit" name="followUp" style="width: 130px;height:25px;background-color:#C6DEFF; border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;" value="Follow-Up" onclick="<%FollowUpType = "Pros";%>"  /> --%></a></div> 
									
									</td>
								</tr>
								<tr>
								<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport"))){%>
									<td align="left" valign="top">
									<a href="#" ><!-- <input type="button" onclick="gotoOprtunity('addOpportunityNew.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="addNewOpportunity" value=" Opportunity     " /> --></a>
								</td>
									<%}else{ %>
										<td align="left" valign="top">
									<a href="#" ><!-- <input type="button" onclick="gotoOprtunity('OpportunityRep.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="addNewOpportunity" value="Opportunity" /> --></a>
								</td>
										
								<%} %> 
					</tr>
					<tr>
					<td align="left">
	<a href="#"><!-- <input type="button" onclick="editCompany('EditCompaany.jsp','Editprospect.jsp');" 
	style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;
	font: bold;cursor: pointer;" name="EditNewCustomer" value="Edit" /> --></a>

					</td>
				</tr>
			<tr>
									<td align="left">
									<a href="#"><!-- <input type="button" onclick="customerDetails();" 
										id="search-submit" style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;" name="Details"
										value="Details            " /> --></a></td>
								</tr>
								<tr>
									<td align="left"><a href="#"><!-- <input type="button"
										onclick="gotoLedgerDetails('ledgerdetails.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
										name="ledgetdetails" value="Ledger Det     " /> --></a></td>
								</tr>

								<tr>
								 		<td align="left" valign="top">
  											 <a href="#" ><!-- <input type="button" onclick="editProspect('prospectHistory.jsp');" 
  											 style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="EditNewCustomer" value="Show History         " /> --></a>
 
									</td> 
								</tr>
								<tr>
								 	  	<td align="left" valign="top">
  											 <a href="#" ><!-- <input type="button" onclick="check('ProsToCust.jsp');" 
  												style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="convertPros" value="ConvToCust   " /> --></a>
								  	   </td>
									
								</tr>
								<tr>
									<td align="left"><a href="#"><!-- <input type="button"
										onclick="gotoFollowUpReport('customerWiseFollowUpReport.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
										name="followUpdetails" value="Follow-Up Rep" /> --></a></td>
								</tr>

                                <tr>
									<td align="left"><a href="#"><!-- <input type="button"
										onclick="gotoFollowUpReport('CustDocList.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
										name="DocUploaded" value="Doc Uploaded" /> --></a></td>
								</tr>  
								
								<tr>
									<td align="left"><a href="#" ><!-- <input type="button"
										onclick="gotoAddContacts('contactdetails.jsp','comp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
										name="addcontacts" value="Add Contacts" /> --></a></td>
								</tr>
								
								<tr>
									<td align="left"><a href="#" ><!-- <input type="button"
										onclick="return goto3('addNewCustomerBranch.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
										name="addbranch" value="Add Branch" /> --></a></td>
								</tr>
								
		<% /* if((session.getAttribute("EmpName").toString().equals("Monika Barmukh") || (session.getAttribute("EmpCode").toString().equals("463"))))
								{ */%>
								<tr>
									<td align="left"><a href="#" ><!-- <input type="button"
										onclick="return popup123('ReAllocation.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
										name="Reassign" value="Reassign" /> --></a></td>
								</tr>
								<%/* } */ %>
								
								 
								
								


								<tr>
								<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport")))
								{%>
									<td align="left" valign="top">
									<a href="#" ><!-- <input type="button" onclick="gotoviewQuotation('IntroMail.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="Intro Email" value=" Intro Email     " /> --></a>
								</td>
									<%}else{ %>
										<td align="left" valign="top">
									<a href="#" ><!-- <input type="button" onclick="gotoviewQuotation('IntroMail.jsp');"
										style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="Intro Email" value=" Intro Email     " /> --></a>
								</td>
										
								<%} %> 
					</tr>

					<tr>
								 		<td align="left" valign="top">
  											 <a href="#" ><!-- <input type="button" onclick="billingDetails();" 
  											 style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="BillingProfile " value="Billing Profile     " /> --></a>
 
									</td> 
								</tr> 
								
								<tr>
								 		<td align="left" valign="top">
  											 <a href="#" ><!-- <input type="button" onclick="gotoviewcontract('customercontract.jsp');"
  											 style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  												id="search-submit"
										name="Contract" value="Contract" /> --></a>
 
									</td> 
								</tr> 
								
								
					
							
							</table>
							</td>
						</tr>
 <tr>
<td colspan="2">
	 <table  id="Last" style="background: #E1F3F3; display: none;" border="0" align="center" width = "100%" >
		<tr>
			<td><b> Last 3 transactions</b></td>
			<td>
			<div style="float: left; margin-left: 80px"><b> Last 3 follow-ups</b></div>
			<div style="float: right; margin-right: 50px">
			<a href="" onclick="return viewfollowup('FollowupMaster.jsp');">View All</a>
			</div>
			</td>
		</tr>
		<tr>
			<td align="left">
			<div id="transactionDetails">
			<table class = "mysortable">
			</table>
			</div>
			</td>
			<td align="left">
			<div id="followupDetails">
			<table class = "mysortable">
			</table>
			</div>
			</td>
		</tr>
	</table> 
	</td>
</tr> 
		</table>
		</td>
		</tr>
		</table>
		</div>
		
<div class="Page">
<div class="Pad"> 
</div>
</div>
</form>
<script type="text/javascript">
					tabview_initialize('TabView');
					
					function viewfollowup(webadd)
					{
						/* alert("welcome to followup"); */
						//var company=document.addFolloUp.companyNames.value
						var company=document.getElementById("search-text").value;
						company=company.replace("&","...");
						/* alert("Followup for "+company); */
						window.open(webadd+"?companyNames="+company+"&condition=viewall");
					}
					
				</script>

				
<!--outer table-->	
<div id='tempList' align="center" style="display: none;">						
</div>
	
	<%
			System.out.println("//////aaa////"
						+ (String) request.getParameter("msg"));
				System.out.println(session.getAttribute("flag"));
				//conn.close();
		%>


	
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009-2015 by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
<%}catch(Exception e){
	e.printStackTrace();	
}finally{
		conn.close();
		
}
	%>	

	</body>
	<style>
#followupDetails{
margin-left: 70px;
width: 100%;
}

</style>
	</html>
<%-- </jsp:useBean>  
 --%> 
 <%@include file="footer_new.jsp"%> 