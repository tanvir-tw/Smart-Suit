<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"/>
<%@page import="java.io.*" import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>



<html>
<head>
<script type="text/javascript">

	function submitchange()
	{
		
		status=document.getElementById("status").value;	
		if(status=="Select")
			{
				alert("Please Select Status For Group");
				return false;
			}
		else
			{
			document.getElementById("submit").submit();
			alert("Group Updated Successfully...");

			}
	}
	
	

</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Existing Group</title>
</head>
<body>
<div style="font-size: 1.7em; text-align: center; margin-top: 0.2em; margin-bottom: 0.2em;">
<a><b>EDIT GROUP</b></a>
</div>
<%
	String grpname=request.getParameter("group");
	
	System.out.println("Group Name Is"+grpname);
	

%>
<form name="GrpName" method="post" action="UpdateGroup.jsp" onsubmit="return submitchange();">
<div style=" margin-left:35%;border:3px solid #2aa1cc ;width:25%;height:50%;" class="sortable">
	
		<table >
			<tr>
			<td align="center" colspan="3"><b><font color="red">Edit Existing Group</font></b></td>
			</tr>
		   <tr>
		   <td><b>GROUP NAME:</b></td>
					<td><input type="text"  id="thegroup" name="thegroup" style="width: 150px; height: 15px; padding: 4px 5px 2px 5px;
	border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;" value='<%=grpname%>'/></td>
		   </tr>
		   <tr>
		   <td><b>STATUS:</b></td>
		   
		   <td><select name="status" id="status" style="width: 160px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; 
				 color: #000000; " >
				 <option value='Select' name="Select">Select</option>
				 <option value='active' name="Active">Active</option>
				 <option value='deactive' name="DeActive">DeActive</option></select>
				</td>
		   
		   </tr>
		   <tr>
		   <td>
		   </td>
		   <td align="center">
		   <input type="submit" name="submit" id="submit" value="Submit" >
		   </td>
		   <td>
		   </td>
		   </tr>
</table>

</div>
<!-- <div id="footer" style="margin-top: 65%"> -->
<!-- 	<p><a href="#"> -->
<!-- Copyright &copy; 2014 Safe & Secure Logistics Pvt Ltd. -->
<!-- </a></p> -->
<!-- 	</div> -->
</form>	
</body>
</html>
<%@include file="footer_new.jsp"%>