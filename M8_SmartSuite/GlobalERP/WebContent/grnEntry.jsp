<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

 
<script language="JavaScript1.2">

function showSelectedSuppliers(customerCode,companyName){
	document.data.companyNames.value=companyName;
	document.data.customerCode.value=customerCode;
	document.getElementById('companyList').style.visibility = 'hidden';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	document.data.companyNames.value='';
}

function getCompanies()
{
	//document.getElementById("companyList").style.display='block';
	var company=document.data.companyNames.value;
	document.getElementById('companyList').style.visibility = 'visible';

	if(company=="")
	{
		document.getElementById('companyList').style.visibility = 'hidden';
		
	}
	else
	{
		document.getElementById('companyList').style.visibility = 'visible';
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
			document.getElementById("companyList").innerHTML=reslt;
		} 
	}
	var queryString = "?company=" +company;
	ajaxRequest.open("GET", "AjaxGetSupplierForEnquiry.jsp" + queryString, true);
	ajaxRequest.send(null);
	}//end of else 
	
}
function popUp(Address,supplierCode,grnno,pono)
{ 
    window.open(Address+'?supplierCode='+supplierCode+'&grnno='+grnno+'&pono='+pono);
}

function validatePono()
{
	//alert("IN Validate");
	
	var pono=document.forms["data"]["pono"].value;
	//alert(pono);
	/*	if(pono=="" || pono1==" "){
			alert("Please Enter The PO Number");
			return false;
		}
	*/
	//alert(pono);
	
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
			  if(finalres=="No")
		  {
			alert("This PO Number Does Not Exist ");
			document.data.pono.value="";
		//	document.getElementById("comlist").style.display='none';
		  }
		 
		}
	
	}
	
	var queryString = "?pono=" +pono;
	ajaxRequest.open("GET", "AjaxCheckForPono.jsp" + queryString, true);
	ajaxRequest.send(null);
	
		
}

function validate()
{
	var pono=document.forms["data"]["pono"].value;
	//alert(pono);
		if(pono=="" || pono1==" "){
			alert("Please Enter The PO Number");
			return false;
		}

}

</script>
                                 	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;
    String selectedName;
	String FollowUpType="",status="";
	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";
%>

<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	if (null == request.getParameter("customer"))
	selectedName = "All";
	else
	selectedName = request.getParameter("customer");
 		
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();

	if (null == request.getParameter("customer"))
	selectedName = "All";
	else
	selectedName = request.getParameter("customer");

	String code=request.getParameter("customerCode");
	System.out.println("><<><><><><><><><      "+code);
	
	String customerCode="";
%>

<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >
	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Generate Purchase GRN from Pending Purchase Order</a></div>

<form name="data" id="data" action="ShowGrn.jsp" method="get" onSubmit="return validate()" >
	<input type="hidden" name="customerCode" id="customerCode" value=""/>
	<div align="center">
	<table border="0" width="50%">
	
		</table>
	
	
	<tr> 
	
	 <td align="center"><b>Enter PO No. :</b></td>
	 <td><input type="text" name="pono" id="pono"  size="7" value="" onblur="validatePono() " /> </td>
	&nbsp;&nbsp;&nbsp;&nbsp;<td>
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" /></td>
	</tr>
	
	</table></div>
	</form>
	
	
<% 
	} catch(Exception e)
	{
	e.printStackTrace();
	}
%>  
	
	
	
	
	</br>
	
	 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
     <br><br><br><br><br><br><br><br><br>
  <div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
  </div>
<!-- end #footer -->
</body>
</html>
</jsp:useBean>