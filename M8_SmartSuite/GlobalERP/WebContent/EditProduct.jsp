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
	<title>Add New Product</title>
	</head>
	<script type="text/javascript">
	function ValidateForm()
	{
			var product=document.addBranch.product.value;
			if(product=="")
			{
				alert("Please Enter Product");
				return false;
			}
		  /* 	var letters1 = /^[A-Z a-z]+$/;  
			var letters1=letters1.test(loadType);
		    if(letters1==false)
		     {     
		         alert('Load Type Name Must Have Characters Only');  
		          
		       return false;  
		      }  */  
		

	}
	function validateBranchName()
	{
		var product=document.addBranch.product.value;
		if(product=="")
		{
			alert("Please Enter Product");
			return false;
		}
	  /* 	var letters1 = /^[A-Z a-z]+$/;  
		var letters1=letters1.test(loadType);
	    if(letters1==false)
	     {     
	         alert('Load Type Name Must Have Characters Only');  
	          
	       return false;  
	      }  */ 
	
	}
	function validateDescription()
	{
		var descr=document.addBranch.description.value;
		if(descr=="")
		{
			alert("Please Enter Description");
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
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
			} catch (Exception e) 
			{}
		String srno=request.getParameter("Id");
		System.out.println("Srno===="+ srno);
		String product="", description="";
		String Query="Select * from "+session.getAttribute("CompanyMasterID").toString()+"productMaster where srno='"+srno+"'";
		 ResultSet rs = st.executeQuery(Query);
		while(rs.next())	
		{
			product=rs.getString("product");
			description=rs.getString("description");
			
		}
 %> 
<form name="addBranch" method="post" action="insertEditProduct.jsp?Id=<%=srno%>" onsubmit="return ValidateForm();">
		<div align="center"><font face="Arial" color="black" size="3"><b>Edit Existing Product</b></font></div>
		<br><br>
		<table align="center">
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Product</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="product" id="product" value="<%=product %>" onblur="return validateBranchName();" style="width: 300px;" />
				</td>
			</tr>
			
			<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Description </b></font> &nbsp;&nbsp;<font size="2" color="red">*</font></td>
			<td>
			<div id="description"><textarea id="description" name="description" value="<%=description %>" onblur="return validateDescription();" style="width: 300px"></textarea></div>
			
			</td></tr>
			
			</table>
					<div align="center"><input type="submit" value="Update" style="margin-top: 20px;"  /></div>
		
</form>
   </body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>