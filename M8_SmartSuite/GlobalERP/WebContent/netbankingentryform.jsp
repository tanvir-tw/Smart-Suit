<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>
<script type="text/javascript">

function clearFields()
{
	document.paymententry.supplier.value="";
	document.paymententry.accountno.value="";
	document.paymententry.ifccode.value="";
	document.paymententry.bankname.value="";
	document.paymententry.branchname.value="";
	document.paymententry.email.value="";
	//document.paymententry.limit.value="";

	/*
	var category= document.getElementById("type").value;
	alert("catt==>"+category);
	
	 
	 category=category.split(",");
	 for (var k = 0; k < category.length; k++) {

        var a=category[k];
        var b=category[k];
	 }
      
	 
	 alert("1st>"+a);
	 alert("2nd>"+b);
	 document.getElementById("ctypeSelected").value=b;
	*/
}
function showVisitingName(companyName,customerCode)
{
	document.paymententry.supplier.value=companyName;
	
	document.getElementById("supplierList").style.display='none';
	ChangingField('changefield',companyName);
	//alert("code "+customerode);
	
	//document..isCheckedAll.checked=false;
}

function ChangingField(type,benFname)
{
	
	//alert("call");
		//var name=document.netbanking.benfName.value;
		var name=benFname;
	//alert("benf name-->"+name);
	//document.getElementById("benfBankName").options.remove();
	//document.getElementById("BankList").style.display='block';
	
	//document.getElementById("NameList").style.display='block';

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
			//alert("hi");
			var reslt=ajaxRequest.responseText;
			//alert("option-->"+reslt);
			var opt="";
			var str_array = reslt.split(',');
			var flg=0;
			//alert("array length"+str_array.length);
			var length=document.getElementById("bankname").options.length;
   		//	alert("option length--->"+length);
   			//length=length+1;
   		//	alert("option length--->"+length);
   			//opt="";
   			for(var j=1;j<length;j++)
   			{
   	   			
   				document.getElementById("bankname").options[j]=null;
   				//alert("vv");
   			}
   			document.getElementById("bankname").options[str_array.length-1]=null;
			for(var i = 1; i < str_array.length ; i++)
			{
				//alert("array length"+str_array[i]);
	   		// Trim the excess whitespace.
	   			str_array[i] = str_array[i].replace(/^\s*/, "").replace(/\s*$/, "");
	   			// Add additional code here, such as:
	   		//	alert("bnk nme-->"+str_array[i]);
	   			
	   			 opt = document.createElement("option");
	   			
		   			flg++;
	   			document.getElementById("bankname").options.add(opt);
	   			opt.text = str_array[i];
		        opt.value = str_array[i];
		       // alert("flag--->"+flg);
	   			
		        
	   		}
   		
			
		} 
	}
	
	var queryString = "?name="+name+"&type="+type;
	ajaxRequest.open("GET", "netBankAjaxSearch.jsp" + queryString, true);
	ajaxRequest.send(null);

	}

	function getNames()
	{
		//alert("IN FUINCTIOn");
		var type=document.getElementById("type").value;
		
		if(type=="" || type=="select")
		{
			alert("Please Select Category Type");
			return false;
		}



		
		//alert("  type value   "+type);
		
		var company=document.paymententry.supplier.value;

		if(company.length=="")
		{

			document.getElementById("supplierList").style.visibility="hidden";
		
		 //alert(company);
		 
		}
		else
		{
			document.getElementById("supplierList").style.visibility="visible";
			company=company.replace(".","");
			company=company.replace(",","");
			company=company.replace("?","");
			company=company.replace("$","");
		 
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

	// Create a function that will receive data sent from the server0
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			//alert("rtrnData"+reslt);
			//var mySplitResult = reslt.split("#");
			//alert(mySplitResult[15]);
			document.getElementById("supplierList").innerHTML=reslt;
			

		} 
	}
	
	 var queryString ="?company=" +company+"&type="+type;
	 ajaxRequest.open("GET", "AjaxGetNames.jsp" + queryString, true);
	 ajaxRequest.send(null); 
		}//end of else
			
	}

	function getsupplierDetails(i)
	{
		//alert("IN ON CLICK   ");
		document.paymententry.supplier.value=document.getElementById("companyname"+i).value;
		document.getElementById("supplierList").style.visibility='hidden'; 
	
	}


	function checkduplicateuser(accountno)
	{
		//alert("IN  duplicate FUINCTIOn");
		var accountname=document.getElementById("supplier").value;
		//alert("  type value   "+type);
		//document.getElementById("supplierList").style.display='block';
		//var company=document.paymententry.supplier.value;
		//company=company.replace(".","");
		//company=company.replace(",","");
		//company=company.replace("?","");
		//company=company.replace("$","");
		 //alert(company);
		 
		if( accountname !="")
		{ 
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

	// Create a function that will receive data sent from the server0
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			//alert("result-->"+reslt);
			reslt=reslt.replace(/^\s+|\s+$/g,"");
			//alert("result trim-->"+reslt);
			if(reslt=="yes")
			{
				document.getElementById("supplier").value="";
				document.getElementById("accountno").value="";
				alert("Account Number is  already present!");
				document.getElementById("supplier").focus();
				
				return false;
				
			}else
			{
			}
			
			
			

		} 
	}
	
	 var queryString ="?accountno=" +accountno+"&accountname="+accountname;
	 ajaxRequest.open("GET", "AjaxDuplicateAccNames.jsp" + queryString, true);
	 ajaxRequest.send(null); 

		}//end of if
		else
		{
			document.getElementById("accountno").value="";
			alert("BeneficiaryName is Empty");
			document.getElementById("supplier").focus();
			return false;
		}
		
	}	//end ajax function
	

	function getCompanies(type)
	{
		//alert("HH");
		
		document.getElementById("supplierList").style.display='block';
		var name=document.paymententry.supplier.value;

//alert(name);
		if(name=="")
		{
			document.getElementById('supplierList').style.display = 'none';
		}else
		{

			document.getElementById('supplierList').style.display = 'visible';
		name=name.replace(".", "");
		name=name.replace(",", "");
		name=name.replace("$", "");
		name=name.replace("?", "");


		
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
				document.getElementById("supplierList").innerHTML=reslt;
			} 
		}
		var queryString = "?name=" +name+"&type="+type;
		ajaxRequest.open("GET", "netBankAjaxSearch.jsp" + queryString, true);
		ajaxRequest.send(null);


		}//end of else 
		
	}

	
	function validate()
	{
		var numericExpression = /^[0-9]+$/;

		var name=document.paymententry.supplier.value;
		var type =document.getElementById("type").value;
		if(type=="" || type=="select")
		{
			alert("Please Select Type");
			return false;
		}
		if(name=="")
		{
			alert("Please Enter Beneficiary Name");
			return false;
		}

		var accountno=document.paymententry.accountno.value;
		if(accountno=="" || accountno==null)
		{
			alert("Please Enter Account No");
			return false;
		}

		/*
		if(!(accountno.match(numericExpression)))
		{
			alert("Account No Should Be Numeric Value");
			return false;
		}

		*/
		var ifccode=document.paymententry.ifccode.value;
		if(ifccode=="" )
		{
			alert("Please Enter IFC Code");
			return false;
		}

		
		var bankname=document.paymententry.bankname.value;
		if(bankname=="" )
		{
			alert("Please Enter Bank Name ");
			return false;
		}

		
		var branchname=document.paymententry.branchname.value;
		if(branchname=="")
		{
			alert("Please Enter Branch Name");
			return false;
		}

		var email=document.paymententry.email.value;
		if(email=="" || email==null)
		{
			alert("Please Enter Email Address");
			return false;
		}
		var limit=document.paymententry.limit.value;
		if(limit=="" || limit==null)
		{
			alert("Please Enter Level 1 Limit");
			return false;
		}
		if(!(limit.match(numericExpression)))
		{
			alert("Level 1 Limit value Numeric Value");
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

		var agree=confirm("Beneficiary Name: "+name+"\n Account No : "+accountno+"\n  IFC Code: "+ifccode+"\n Beneficiary BankName: "+bankname+"\n  Beneficiary BranchName: "+branchname+"\n Beneficiary EmailID: "+email+"\n Level 1 Limit: "+limit+"\n\nAre you sure you want to continue with these values?");
		   if (agree)
			   return true ;
			   else
			   return false ;
		
	}

	

	function testlimit(limitvalue)
	{

		var category= document.getElementById("type").value;
		//alert("catt==>"+category);
		
		 
		 category=category.split(",");
		 for (var k = 0; k < category.length; k++) {

	        var a=category[k];
	        var b=category[k];
		 }
	      
		 
		// alert("1st>"+a);
		// alert("2nd>"+b);
		// document.getElementById("ctypeSelected").value=b;



		
		//var name=document.paymententry.type.value;

		var categoryLimit=b;
		//alert("limit val==>"+limitvalue+"type limit==>"+categoryLimit);

		limitvalue++;
		limitvalue--;
		categoryLimit++;
		categoryLimit--;
		if(limitvalue>categoryLimit)
		{
			alert("User Limit1 value can not be greater than category limit");
			document.paymententry.limit.value="";
		}



		
	}


	function limitpermission()
	{
		alert("You Dont have permission to change Level1Limit");
	}
</script>
</head>
<body>	
 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType = "";
			String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
			String id=request.getParameter("id");
			System.out.println("id is  "+id);
			String role1=session.getAttribute("role").toString();
			System.out.println("role  "+role1);
			
	%>
	<%
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			}
	
String name="";
if (null == request.getParameter("supplier"))
{
	  name = "";
}
else
{	name = request.getParameter("supplier");
}
		
	%>


		<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
	<a>Net Banking Entry</a> </div>
	<div align="center" style="margin-left: 20%;">
	
	<form name="paymententry" method="post" id="paymententry" action="insertnetbankdata.jsp" onsubmit="return validate();">
	<div style="width: 50%;" align="center"><div style="float: left;"><a href="accountReport.jsp">BACK</a></div><div><b><font color="red">All Fields are Compulsory.</font></b></div></div>
	<div style="margin-right:25%; border:3px solid #2aa1cc ;width:50%;height:50%;" align="center">
	<table border="0" cellpadding="3" width="80%" align="center" style="background: white;">
	<tr>
	<td align="right"><b>Select Category : </b></td>
	<td>
	<select id="type" name="type" onchange="clearFields();">
	<option value="select" >Select</option>
						<% 
						try
						{
							String sqlCat="select Category,Limit1 from "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory";
						    ResultSet rsCat=st1.executeQuery(sqlCat);
						    while(rsCat.next())
						    { %>
						     <option value="<%=rsCat.getString("Category")+","+rsCat.getString("limit1") %>"> <%=rsCat.getString("Category") %> </option>
						     
						<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }%>
	<!--<option value="select">Select</option>
	<option value="vendor">Vendor</option>
	<option value="contractor">Contractor</option>
	<option value="statutory">Statutory</option>
	--></select>
	
	<input type="hidden" name="ctypeSelected" id="ctypeSelected" >
	
	</td>
	</tr>
	<tr>
	<td align="right" valign="top" >		
					<b>Beneficiary Name:</b></td>
					<td ><input type="text" name="supplier" id="supplier" value="<%=name%>" autocomplete="off" style='height: 15px;' onkeyup="if (event.keyCode == 27){document.getElementById('supplierList').style.display = 'none';} else { getCompanies('quotation'); }"/></td>
					<td>
					<div style="position: absolute;">
  						<table>
 						 <tr><td></td></tr>
 						 <tr><td>
  							<div id='supplierList'>
 						 </div>
 						 </td></tr>
						  </table>
						</div>
					</td>
	</tr>
	<tr>
					<td align="right"><b>Account No: ( Alphanumeric only )</b></td>
					<td  align="left"><input type="text" name="accountno" id="accountno"  style='height: 15px;' onblur="checkduplicateuser(this.value);" />
					</td>
	</tr>
	<tr>
		<td align="right"><b>IFSCode : </b></td>
		<td  align="left"><input type="text" name="ifccode" id="ifccode"  style='height: 15px;' />
		</td>
	</tr>
	<tr>
		<td align="right"><b>Bank Name : </b></td>
		<td  align="left"><input type="text" name="bankname" id="bankname"  style='height: 15px;' />
		</td>
	</tr>
	<tr>
		<td align="right"><b>Branch Name : </b></td>
		<td  align="left"><input type="text" name="branchname" id="branchname"  style='height: 15px;' />
		</td>
	</tr>
	<tr>
		<td align="right" valign="top"><b>Beneficiary Email ID : </b></td>
		<td  align="left" ><input type="text" name="email" id="email"  style='height: 15px;' />
		</td>
	</tr>
	 <%if(role1.equalsIgnoreCase("Accounts") || role1.equalsIgnoreCase("HOD")){ %>
	<tr>
		<td align="right" valign="top"><b>Level 1 Limit : </b></td>
		<td  align="left" ><input type="text" name="limit" id="limit" onblur="testlimit(this.value);"  value="5" style='height: 15px;' />
		</td>
	</tr>
	<%}else{ %>
	<tr>
		<td align="right" valign="top"><b>Level 1 Limit : </b></td>
		<td  align="left" ><input type="text" name="limit" id="limit" onkeyup="limitpermission();" readonly="readonly" value="5" style='height: 15px;' />
		</td>
	</tr>
	<%} %>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" class="formElement" /></div>
			</td>
	</tr>
		<input type="hidden" name="type" id="type" value=""/>
	</table>
	</div>
	</form>
	</div>
	
			<br><br><br><br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	
	</body>
	</html>
</jsp:useBean>