<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>


<script type="text/javascript">
function getNames()
{
//alert("IN FUINCTIOn");
	document.getElementById("supplierList").style.visibility="visible";
	var company=document.role.supplier.value;
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
		//alert(reslt);
		//var mySplitResult = reslt.split("#");
		//alert(mySplitResult[15]);
		document.getElementById("supplierList").innerHTML=reslt;
		

	} 
}

 var queryString ="?company="+company;
 ajaxRequest.open("GET", "AjaxForNames.jsp" + queryString, true);
 ajaxRequest.send(null); 
		
}


function getsupplierDetails(i)
{
	//alert("IN ON CLICK   ");
	document.role.supplier.value=document.getElementById("sname"+i).value;
	document.role.roleid.value=document.getElementById("srole"+i).value;
	alert(document.role.roleid.value);
	document.getElementById("supplierList").style.visibility='hidden';

}


function add()
{
	//alert("11111111");

	try{
		var rolename=document.getElementById("rolename").value;
		alert(rolename);
		var roledesc=document.getElementById("roledescription").value;
		alert(roledesc);
	var inci1="";
	
	var src = document.role.assigned2;
	for(var count=0; count < src.options.length; count++) {
		    var option = src.options[count];
		    if(count==0)
		    	inci1+=option.value;
		    else
		    	inci1+=","+option.value;
		
			} 

	}catch(e){}

alert(inci1);
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
			
		} 
	};
	 
	var queryString = "?modules="+inci1+"&rolename="+rolename+"&roledesc="+roledesc;
	ajaxRequest.open("GET", "insertroledata.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}

function addUser2()
{
try
	{
	
    var src = document.role.resources1;

    
    var dest = document.role.assigned2;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
	}
	catch(e)
	{
		alert(e);
	}
}


function removeUser2() 
{
    var src =document.role.assigned2;
    var dest =  document.role.resources1;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                        
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                        
                 }
                count--;
        }
    }
}

</script>

</head>
<body>
 	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null,st2=null,st3=null;
			boolean isInvoiceSelected=false;
			if(request.getParameter("InvoiceNo")!=null){
				isInvoiceSelected=true;
			}
			String poNo=request.getParameter("PONo");
			String InvoiceNo=request.getParameter("InvoiceNo");
 
			 
			 double sumAmount=0; 
			 int groupCode=0,makeCode=0;
			 String groupName="",makeName="",itemCode="";
			 String refMakeNameTable="";
			 String sqlDisplayDesc=" ";
			
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				st3 = conn.createStatement();
			} catch (Exception e) {
			}
	%>
	
	

	<div align="center" style="font-size: 1.5em;">
 			<a> Edit Role Details</a>
	</div>
	 
 	<br>
 	</br>
 	
 <div align="center" style="margin-left:25%;border:3px solid #2aa1cc ; width:45%;height:290px;" class="sortable">
		 	
<form name="role" method="post" action="insertroledata.jsp" >

<table border="0" style="margin-left:-11%;">
<tr><td><input type="hidden" name="roleid" id="roleid" value=""/></td></tr>
<tr>
<td><a>(* Field are compulsory.)</a></td>
</tr>
<tr>
<td><b><a></a> &nbsp;&nbsp;&nbsp;Select Role Name :</b> </td>
<td>
<div id="supplier"><input type="text" name="supplier"
id="search-text" value="" style='height: 15px;'  onkeyup="getNames();"/></div>

<div id='supplierList' style="width:275px;height:100px; position:absolute;overflow: auto;margin-left:1.0%;" >
</div> 
<script>document.getElementById("supplierList").style.visibility="hidden";</script></td>
</tr>
<tr>
<td><b><a>*</a> Role Description :</b> </td>
<td align="left">
<input type="text" name="roledescription" id="roledescription" style='height: 15px;' />
</td>
</tr>
</table>
<br></br>

<table border="0" align="center" class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label for="InsertRecordCoApplican"+session.getAttribute("CompanyMasterID").toString()+"Firs"+session.getAttribute("CompanyMasterID").toString()+"Name" ><b>Available Menus :</b></label>
</td>

<td colspan="10" class="cbFormLabelCell  cbFormLabel">
<label for="InsertRecordCoApplican"+session.getAttribute("CompanyMasterID").toString()+"Firs"+session.getAttribute("CompanyMasterID").toString()+"Name" ><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Existing Menus :</b></label>
</td>
</tr>

<tr>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<select name="resources1" style="width:160px" size="7" id="resources1" multiple="multiple">
<%
String sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"menu_master";
ResultSet rs1=st.executeQuery(sql1);
while(rs1.next())
{
%>
<option value="<%=rs1.getString("MenuID") %>"></option>
<%
}
%>
</select>
</td>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<div><input type="button" class="button" value="&gt;" onClick="addUser2();" /></div>
<div><input type="button" class="button" value="&lt;" onClick="removeUser2()" /></div>
</td>
<td align="center" valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<select name="assigned2" style="width:160px" size="7" multiple="multiple">

</select>

<select name="assigned3" style="width:160px;display: none" size="7" multiple="multiple"/>
</select>
</td>
</tr>
	
</table>

<br></br>
<table align="center">
<tr>
<td><input type="button" value="submit" onclick="add();"/></td>
</tr>
</table>
</form>

</div>
	<br><br> <br><br> <br><br> 
 
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
	</jsp:useBean>