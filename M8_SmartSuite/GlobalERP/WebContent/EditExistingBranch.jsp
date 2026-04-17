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
	<title>Add New Branch</title>
	</head>
	<script type="text/javascript">
	function ValidateForm()
	{
			var BranchName=document.addBranch.BranchName.value;
			if(BranchName=="")
			{
				alert("Please Enter Branch Name");
				return false;
			}
		   	var letters1 = /^[A-Z a-z]+$/;  
			var letters1=letters1.test(BranchName);
		    if(letters1==false)
		     {     
		         alert('Branch Name must have characters only');  
		          
		       return false;  
		      }  
		
			var address=document.addBranch.address.value;
			if(address=="")
			{
				alert("Please Enter Address");
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
		var BranchName=document.addBranch.BranchName.value;
		if(BranchName=="")
		{
			alert("Please Enter Branch Name");
			return false;
		}
	   	var letters1 = /^[A-Z a-z]+$/;  
		var letters1=letters1.test(BranchName);
	    if(letters1==false)
	     {     
	         alert('Branch Name must have characters only');  
	          
	       return false;  
	      }  
	
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
		try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
			} catch (Exception e) 
			{}
		String srno=request.getParameter("Id");
		System.out.println("Srno===="+ srno);
		String BranchName="", Address="", Location="", PhoneNumber="";
		String Query="Select * from "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster where srno='"+srno+"'";
		 ResultSet rs = st.executeQuery(Query);
		while(rs.next())	
		{
			BranchName=rs.getString("BranchName");
			Address=rs.getString("Address");
			Location=rs.getString("Location");
			PhoneNumber=rs.getString("Phone");
		}
 %> 
<form name="addBranch" method="post" action="EditBranch.jsp?Id=<%=srno%>" onsubmit="return ValidateForm();">
		<div align="center"><font face="Arial" color="black" size="3"><b>Edit Existing Branch</b></font></div>
		<br><br>
		<table align="center">
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Branch Name</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="BranchName" id="BranchName" value="<%=BranchName %>" onblur="return validateBranchName();"  style="width: 300px;" />
				</td>
			</tr>
			<tr><td></td></tr>
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Address</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<textarea name="address" id="address" onblur="return validateaddress();" style="width: 300px;"><%=Address%></textarea>
				</td>
			</tr>
			<tr><td></td></tr>
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Location</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="Location" id="Location" value="<%=Location %>" onblur="return validateLocation();" style="width: 300px;"  />
				</td>
			</tr>
			<tr><td></td></tr>
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Phone Number</b></font>
				</td>
				<td>
						<input type="text" name="PhoneNumber" id ="PhoneNumber" value="<%=PhoneNumber %>"  onblur="return validatePhoneNumber();" style="width: 300px;"  id="PhoneNumber" />
				</td>
			</tr>
		</table>
					<div align="center"><input type="submit" value="Submit" style="margin-top: 20px;"  /></div>
		
</form>
 	</body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>