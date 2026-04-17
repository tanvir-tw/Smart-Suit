<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.io.*" import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add New Load Type</title>
	</head>
	<script type="text/javascript">
	function ValidateForm()
	{
			var loadType=document.addBranch.loadType.value;
			if(loadType=="")
			{
				alert("Please Enter Load Type");
				return false;
			}
		 /*  	var letters1 = /^[A-Z a-z]+$/;  
			var letters1=letters1.test(loadType);
		    if(letters1==false)
		     {     
		         alert('Load Type Name Must Have Characters Only');  
		          
		       return false;  
		      }  
		*/
			var descr=document.addBranch.description.value;
			if(descr=="")
			{
				alert("Please Enter Discription");
				return false;
			}
			var Location=document.addBranch.Location.value;
			if(Location=="")
			{
				alert("Please Enter Location");
				return false;
			}
		 	var letters12 = /^[A-Z a-z]+$/;  
			var letters12=letters12.test(Location);
		    if(letters12==false)
		     {     
		         alert('Location must have characters only');  	          
		       	 return false;  
		      }  
			var PhoneNumber=document.addBranch.PhoneNumber.value;
			if(isNaN(PhoneNumber))
			{
				alert("Please Enter Numeric Value For Phone Number");
				return false;
			}

	}
	function validateBranchName()
	{
		var loadType=document.addBranch.loadType.value;
		if(loadType=="")
		{
			alert("Please Enter Load Type");
			return false;
		}
	 /*  	var letters1 = /^[A-Z a-z]+$/;  
		var letters1=letters1.test(loadType);
	    if(letters1==false)
	     {     
	         alert('Load Type Name Must Have Characters Only');  
	          
	       return false;  
	      }  
		*/	
	}
	function validateDescription()
	{
		var descr=document.addBranch.description.value;
		if(descr=="")
		{
			alert("Please Enter Description");
			return false;
		}
	   /*	var letters1 = /^[A-Z a-z]+$/;  
		var letters1=letters1.test(descr);
	    if(letters1==false)
	     {     
	         alert('Load Type Name Must Have Characters Only');  
	          
	       return false;  
	      }*/  
	
	}
	
	function validateaddress()
	{
		var address=document.addBranch.address.value;
		if(address=="")
		{
			alert("Please Enter Address");
			return false;
		}
	}
	function validateLocation()
	{
		var Location=document.addBranch.Location.value;
		if(Location=="")
		{
			alert("Please Enter Location");
			return false;
		}
	 	var letters12 = /^[A-Z a-z]+$/;  
		var letters12=letters12.test(Location);
	    if(letters12==false)
	     {     
	         alert('Location must have characters only');  	          
	       	 return false;  
	      }  
	}
	function validatePhoneNumber()
	{
		var PhoneNumber=document.addBranch.PhoneNumber.value;
		if(isNaN(PhoneNumber))
		{
			alert("Please Enter Numeric Value For Phone Number");
			return false;
		}
	}
	
	
	</script>	
	<body><%
	 	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
 %> <%
		Connection conn = null;
		Statement st = null, st1 = null, st3 = null, st4 = null;
		Statement st2 = null;
 %> <%
		String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		String fromDateCal="",toDateCal="",thegroupname="";
		fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		String id=request.getParameter("id");
		System.out.println("ID IS  "+id);
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) 
			{}
 %> 
<form name="addBranch" method="post" action="insertLoadType.jsp" onsubmit="return ValidateForm();">
		<div align="center"><font face="Arial" color="black" size="3"><b>Add New Load Type</b></font></div>
		<br><br>
		<table align="center">
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Load Type</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="loadType" id="loadType" onblur="return validateBranchName();" style="width: 300px;" />
				</td>
			</tr>
			
			<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Description </b></font> &nbsp;&nbsp;<font size="2" color="red">*</font></td>
			<td>
			<div id="description"><textarea id="description" name="description" onblur="return validateDescription();" style="width: 300px"></textarea></div>
			
			</td></tr>
			
			</table>
					<div align="center"><input type="submit" value="Submit" style="margin-top: 20px;"  /></div>
		
</form>
  </body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>