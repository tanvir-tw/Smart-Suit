<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<body>
<script type="text/javascript">
function validate()
{

//alert("IN THE FUNCTION");
//var marketingRep=document.addSupplier.repName.value;//alert(marketingRep);
var numericExpression = /^[0-9]+$/;
var sName=document.editSupplier.supplierName.value;
//alert(sName);

if(sName=="" || sName==" ")
{
alert("Please enter Supplier Name");
return false;
	}
		
if(sName.match(numericExpression))
{
alert("Supplier name cannot be Numeric ");
return false;
}

var Reason=document.editSupplier.reason.value;
var invalid=/^[a-zA-Z  .]+$/;
var oth=Reason.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(Reason=="" || oth=="" || Reason==" "){
	//document.getElementById("contact1").style.display="";
	alert("Please Enter Value For Reason ");
	return false;
}
if(!invalid.test(Reason)){
//document.getElementById("contact2").style.display="";
alert("Please Enter Character Value For Reason ");
return false;
     
 }	



	
var contactPerson=document.editSupplier.contactPerson.value;
//alert(contactPerson);


if(contactPerson.match(numericExpression))
{
alert("Contact Persons name cannot be  Numeric");
return false;
}



if(contactPerson=="")
{
	alert(" Please Enter Contact Person");
	return false;
}

var desig=document.editSupplier.designation.value; 
//alert(desig);

var website=document.editSupplier.website.value;
//alert(website);

var email=document.editSupplier.email.value;
//alert(email);

if( email=="")
{
alert("Please enter Email Address");
return false;
}



var at="@";
var dot=".";
var lat=email.indexOf(at);
var lstr=email.length;
var ldot=email.indexOf(dot);
if(email.indexOf(at)==-1 && email!=""){
alert("Invalid E-mail ID");
return false;
}

var address=document.editSupplier.address.value;
//alert(address);
var city=document.editSupplier.city.value;
//alert(city);
var zip=document.editSupplier.zip.value; 
//alert(zip);
var state=document.editSupplier.state.value; 
//alert(state);
var country=document.editSupplier.country.value; 
//alert(country);
var mobi=document.editSupplier.mobile.value; 
//alert(mobi);

var invalid=/^[0-9]+$/; 

if(mobi=="" || mobi==" ")
	{
//document.getElementById("mob123").style.display="";
alert("Please Enter Mobile Number");
return false;
	}
if(!(mobi== 0))
		{
			 if(!invalid.test(mobi))
				{
					//document.getElementById("mob1").style.display="";
					alert("Please Enter Numeric Value For Mob No");
					return false;
				}	
			 if((mobi.trim().length < 10)  || (mobi.trim().length >15))
					 {
					 //document.getElementById("mob12").style.display="";
					 alert("Number Should Be 10-15 Digits");
		        return false;
		    }
		}
		
var fax1=document.editSupplier.fax.value; 
//(fax1);	
var aCode=document.editSupplier.areaCode.value; 
//alert(aCode);
if(aCode!="")
	{
if(!(aCode.match(numericExpression))){
	alert("Area Code Should Be Numeric Value");
	return false;
	}
	
	}
var phone=document.editSupplier.ph.value; 
//alert(phone);

if(phone!="")
	if(!(phone.match(numericExpression))){
	alert("Phone Number Should Be Numeric Value");
	return false;
	}
	
var supCate=document.editSupplier.supCategory.value;	 
//alert(supCate);
var supRat=document.editSupplier.supRating.value; 
//alert(supRat);
var supProdt=document.editSupplier.supProduct.value; 
//alert(supProdt);

var GSTIN=document.editSupplier.GSTIN.value;

if(GSTIN=="" || GSTIN==" " || GSTIN=="-")
{
alert("Please Enter GSTIN Code Value");
return false;
}




	
var weeklyOff=document.editSupplier.weeklyoff.value; 
//alert(weeklyOff);
var alterNumber=document.editSupplier.alternateNumber.value; 
//alert(alterNumber);

if(alterNumber!="")
{
if(!(alterNumber.match(numericExpression))){
alert("Alternate Numner Should Be Numeric Value");
return false;
}

}



//var SupPOAuthReqd=document.addSupplier.supAuthorisation.value;alert(SupPOAuthReqd);

//var SupPOAuthorisationReqd=document.addSupplier.supAuthorisation.value;//alert(">>>>      "+SupPOAuthorisationReqd);
		                    
    
	
	

	
	
	
	
	
	
	
	
	
	
	
	
var agree=confirm(" supplierName: "+sName+"\n Contact Person : "+contactPerson+"\n Email: "+email+"\n Mobile: "+mobi+"\n\nAre you sure you want to continue with these values?");
	if (agree)
	return true ;
	else
	return false ;

}

function getSuppliers()
{
//alert("IN FUINCTIOn");
	document.getElementById("supplierList").style.visibility="visible";
	var company=document.editSupplier.supplier.value;
	//alert(company);
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
//		alert(reslt);
		//var mySplitResult = reslt.split("#");
		//alert(mySplitResult[15]);
		document.getElementById("supplierList").innerHTML=reslt;


	} 
}

 var queryString ="?company="+company;
 ajaxRequest.open("GET", "AjaxGetSupplierInfo.jsp" + queryString, true);
 ajaxRequest.send(null); 
		
}

function getsupplierDetails(i)
{
	//alert("IN ON CLICK   ");
	document.getElementById("supplierList").style.visibility="hidden"; 
	//alert(document.getElementById("companyname"+i).value);
	document.editSupplier.supplierName.value=document.getElementById("companyname"+i).value; 
	document.editSupplier.contactPerson.value=document.getElementById("scontperson"+i).value; 
	document.editSupplier.address.value=document.getElementById("saddress"+i).value; 
	document.editSupplier.weeklyoff.value=document.getElementById("sweeklyoff"+i).value; 
	document.editSupplier.fax.value=document.getElementById("sfax"+i).value; 
	document.editSupplier.website.value=document.getElementById("swebsite"+i).value; 
	document.editSupplier.supProduct.value=document.getElementById("sproduct"+i).value; 
	document.editSupplier.city.value=document.getElementById("scity"+i).value; 
	document.editSupplier.ph.value=document.getElementById("sphone"+i).value; 
	document.editSupplier.email.value=document.getElementById("semail"+i).value; 
	document.editSupplier.mobile.value=document.getElementById("smobile"+i).value; 
	document.editSupplier.state.value=document.getElementById("sstate"+i).value; 
	document.editSupplier.country.value=document.getElementById("scountry"+i).value; 
	document.editSupplier.designation.value=document.getElementById("sdesignation"+i).value; 
	document.editSupplier.areaCode.value=document.getElementById("sareacode"+i).value; 
	document.editSupplier.GSTIN.value=document.getElementById("sGSTIN"+i).value;
	document.editSupplier.alternateNumber.value=document.getElementById("salternateno"+i).value; 
	document.editSupplier.zip.value=document.getElementById("szip"+i).value; 
	document.editSupplier.SupplierCode.value=document.getElementById("suppliercode"+i).value; 
	


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
										
	 		 	

	
}
if (document.all || document.getElementById)
document.body.style.background = "url('images/bg.jpg')  white top no-repeat "


</script>
<%
erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
Connection conn = null;
Statement st = null, st1 = null, st3 = null, st4 = null;
Statement st2 = null;
String FollowUpType = "";
Date today = new Date();
String fromDate = "", toDate = "";
fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(today);
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
%>

<div
style="font-size: 2em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
<a>Edit Supplier</a></div>

<form name="editSupplier" method="post" action="insertEditedSupplier.jsp" enctype="multipart/form-data"
onSubmit="return validate();">
<table>
<tr>
<td >
<div id="supplier"><b>SEARCH SUPPLER : </b><input type="text" name="supplier"
id="search-text" value="" style='width:275px;'  onkeyup="getSuppliers()"/></div>

<div id='supplierList' style="width:275px;position:absolute;overflow: auto;margin-left:7.6%;" >
</div> 
<script>document.getElementById("supplierList").style.visibility="hidden";</script>

</td>
</tr>
</table>
<br>
<table border="0" cellpadding="3" width="100%"
style="background: white;">
<tr>
<td valign="top" align="left">
<div id="repName">Marketing Rep. Name:</div>
</td>
<td valign="top" style="font-size: 1.2em;" ><%=session.getAttribute("EmpName").toString()%>

</td>
<td valign="top" align="left" >Supplier Name : #</td>
<td align="left">
<div id="supplierName">
<input type="text" name="supplierName" 
id="search-text" value="" style='height: 12px;' /></div>
</td>

<td valign="top" align="left" >Reason For <br>Updation this Record : #</td>
<td align="left">
<textarea
	name="reason" rows="1" id="search-text"
	style='width: 175px; height: auto;'></textarea>
</td>
</tr>
<tr>
<td valign="top" align="left">Contact Person : #</td>
<td>
<div id="contactPerson"><input type="text" name="contactPerson"
id="search-text" value="" style='height: 12px;' /></div>
</td>
<td valign="top" align="left">Designation :</td>
<td align="left">
<div id="designation"><input type="text" name="designation"
id="search-text" value="" style='height: 12px;' /></div>
</td>
		
</tr>
<tr>
<td valign="top" align="left">E-mails : *<br>
(add comma seprated<br>
Id's if more than one)</td>
<td>
<div id="email"><textarea name="email" value="" rows="1"
id="search-text" value="" style='width: 175px; height: auto;'></textarea></div>
</td>
<td valign="top" align="left">Address :</td>
<td>
<div id="address"><textarea name="address" rows="2"
id="search-text" value="" style='width: 175px; height: auto;'>
</textarea></div>
</td>
</tr>
<tr>
<td valign="top" align="left">City :</td>
<td align="left">
<div id="city"><input type="text" name="city"
id="search-text" value="" style='height: 12px;' /></div>
</td>
<td valign="top" align="left">ZipCode :</td>
<td align="left">
<div id="zip"><input type="text" name="zip" id="search-text" value=""
style='height: 12px;' /></div>
</td>
</tr>
<tr>
<td valign="top" align="left">State :</td>
<td align="left">
<div id="state"><input type="text" name="state" value=""
id="search-text" style='height: 12px;' /></div>
</td>
<td valign="top" align="left">Country :</td>
<td align="left">
<div id="country"><input type="text" name="country"
id="search-text" value="" style='height: 12px;' /></div>
</td>
</tr>
<tr>
<td valign="top" align="left">Mobile No : *</td>
<td>
<div id="mobile"><input type="text" name="mobile"
id="search-text" value=""style='height: 12px;' /></div>
</td>
<td valign="top" align="left">Fax No :</td>
<td align="left">
<div id="fax"><input type="text" name="fax" id="search-text" value=""
style='height: 12px;' /></div>
</td>
</tr>

<tr>
<td valign="top" align="left">Area Code :</td>
<td>
<div id="areaCode"><input type="text" name="areaCode" id="search-text" value=""
style='height: 12px;' /></div>
</td>
<td valign="top" align="left">Phone Number : </td>
<td align="left">
<div id="ph"><input type="text" name="ph" id="search-text" value=""
style='height: 12px;' /></div>
</td>
</tr>
<tr>
<td valign="top" align="left">Supplier category :</td>
<td><select name="supCategory" id="supCategory"
style="width: 188px; height: 20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000;">
<option value='Select'>Select</option>
<option value='1'>Manufacturer</option>
<option value='2'>Authorised Dealer</option>
<option value='3'>After Market Trader</option>
<option value='4'>Others</option>
</select></td>
<td valign="top" align="left">Supplier Rating : </td>

<td><select name="supRating" id="supRating"
style="width: 188px; height: 20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000;">
<option value='0'>Select</option>
<option value='1'>1</option>
<option value='2'>2</option>
<option value='3'>3</option>
<option value='4'>4</option>
<option value='5'>5</option>

</select></td>


</tr>
<tr>
<td valign="top" align="left">Supplier product :</td>
<td>
<div id="supProduct"><input type="text" name="supProduct"
id="search-text" value="" style='height: 12px;' /></div>
</td>
<%-- <td valign="top" align="left">Supplier Entered On :</td>
<td><input type="text" id="fromdate" name="fromdate"
value="<%=fromDate%>" size="15" readonly
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
</td> --%>

<td valign="top" align="left">GSTIN No *: </td>
<td align="left">
<div id="GSTIN"><input type="text" name="GSTIN" id="search-text"
style='height: 12px;' /></div>
</td>

</tr>
<tr>
<td valign="top" align="left">Weekly Off :</td>
<td><input type="text"
name="weeklyoff" id="search-text" value="" style='height: 12px;' /></td>
<td valign="top" align="left">Alternate Number :</td>
<td align="left">
<div id="alternateNumber"><input type="text"
name="alternateNumber" value="" id="search-text" style='height: 12px;' /></div>
</td>
</tr>
<tr>

	
<td valign="top" align="left">WebSite :</td>
<td>
<div id="website"><input type="text" name="website"
id="search-text" value="" style='height: 12px;' /></div>
</td>
</tr>
<tr>
<td><input type="checkbox"  id="supAuthorisation" name="supAuthorisation"  value="True" unchecked/>Sup PO Authorisation Reqd  </td>

<td>	<th align="left">Upload Document </th></td>
						<td><input type="file" name="myfile" id="myfile" />
						</td>	
					     </tr>
<tr></tr>
<tr>
<td valign="bottom" align="center" colspan="4">
<div><input type="submit" id="search-submit"
name="submitSupplierDet" value="Submit" /></div>
</td>
</tr>
<tr>
<td colspan="3"># : Either of the field is compulsory</td>
</tr>
<tr>
<td colspan="3">* : Either of the field is compulsory</td>
</tr>
</table>
<input type="hidden" name="twemp" id="twemp" value="<%=session.getAttribute("EmpName") %>"/>
<input type="hidden" name="SupplierCode" id="SupplierCode" value=""/>
</form>






<!-- <div id="footer"> -->
<!-- <p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- </div> -->
<!-- end #footer -->
</body>
</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>