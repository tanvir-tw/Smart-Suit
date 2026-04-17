<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add New Category</title>

<script type="text/javascript">

function validateProspectes()
	{
		//alert("IN FUNCVOOM     ");
		var prospect=document.paymententry.category_name.value;
		prospect=prospect.replace(".","");
		prospect=prospect.replace(",","");
		prospect=prospect.replace("?","");
		prospect=prospect.replace("$","");
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
				alert("Category  Already Exists !!You Can Not Add This Category  ");
				document.paymententry.category_name.value="";
				//document.getElementById("comlist").style.display='none';
			  }
			 
			}
		
		}
		
		var queryString = "?prospect=" +prospect;
		ajaxRequest.open("GET", "AjaxCheckForCategory.jsp" + queryString, true);
		ajaxRequest.send(null); 
			
	}

function validate()
{


	var category=document.paymententry.category_name.value;
	var limit=document.paymententry.limit.value;

	if(category=="" ){
    	alert("Please enter Category ");
		return false;
	}
	if(limit=="" ){
    	alert("Please enter Limit ");
		return false;
	}
	if(isNaN(limit))
	{
		alert("Please enter numeric value for Level 1 Limit");
		document.paymententry.limit.value="";
		return false;
	}


	var agree=confirm(" Category: "+category+"\n Level 1 Limit : "+limit+"\n\nAre you sure you want to continue with these values?");
	if (agree)
		return true ;
	else
		return false ;
	
}

</script>


</head>
<body>

		<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
		
	<a>Add New Category</a> </div>
	<div align="center" style="margin-left: 20%;">
	
	<form name="paymententry" method="post" action="insertcategorydata.jsp" onSubmit="return validate();" >
	<div style="width: 50%;" align="center"><div style="float: left;"><a href="categoryMasterReport.jsp">BACK</a></div><div><b><font color="red">All Fields are Compulsory.</font></b></div></div>
	<div style="margin-right:25%; border:3px solid #2aa1cc ;width:50%;height:50%;" align="center">
	<table border="0" cellpadding="3" width="80%" align="center" style="background: white;">
	<tr>
	
	</tr>
	<tr>
	<td align="right">		
					<b>Category Name  : </b></td>
					<td><input type="text" name="category_name" id="category_name"   value="" onblur="validateProspectes()" />
</td>
	</tr>
	<tr>
					<td align="right"><b>Limit : </b></td>
					<td  align="left"><input type="text" name="limit" id="limit"  />
					</td>
	</tr>
	

	
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" class="formElement" /></div>
			</td>
	</tr>
		
	</table>
	
	<table>
	<tr>
	<th>
	</th>
	</tr>
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