<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<html>
<style type="text/css">

.inputbox {
vertical-align: left;
}


</style>
<body onload="resetAll();" style="font-family:arial;">


<script type="text/javascript">
function addRow()
{
	//alert("Hi");
	
	var allocate=document.getElementById("group").value;
	
	//alert("allocate "+allocate);
	
	
	if(allocate=="" || allocate=="Select")
		{
		
		alert("Please Select Marketing Representative");
		
		return false;
		}
	
	
	var representativecode=document.getElementById("group").value;
//	alert(representativecode);


	var code=document.getElementById("code").value;
	var type=document.getElementById("type").value;


	window.location="ReAllocationAction.jsp?representativecode="+representativecode+"&code="+code+"&type="+type+"";
	
	return true;
}
</script>
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
		Connection conn = null;
		Statement st = null,st1 = null,st4 = null,stlbl=null;
		Format format=new SimpleDateFormat("dd-MMM-yyyy");
		Format parse=new SimpleDateFormat("yyyy-MM-dd");
		String fromDate="",toDate="",fromDateCal="",toDateCal="";
		String companyName="",phone="",contact="",email="",product="",city="";
		Date today = new Date();
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
 		try 
 		{
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st4 = conn.createStatement();
				stlbl = conn.createStatement();
		} 
 		catch (Exception e) 
 		{
		
 		}
 		
 		/* String Company=request.getParameter("Company");
 		System.out.println("Company :-"+Company); */
 		
 		String Code=request.getParameter("Code");
 		
 		//Code=Code.substring(1);
 		
 		System.out.println("Company :-"+Code);
 		
 		String Type=request.getParameter("Type");
 		System.out.println("Company :-"+Type);
 		
 		String Query="";
 		String MarkCode="",MarkName="";
 		
 		
%>
<form name="ledgerDetails" action="ReAllocationAction.jsp"  method="post">
<br>
  <div style="font-family: arial;font-size:16px;margin-left: 30%;" ><b>Customer Reassignment</b></div>
  

<div id="dataentry" style="position:absolute;margin-top:5%;margin-left:28%;margin-right:5%;background-color:#94ECF6;border:solid thin black;">
    <table style="width:75%;font-family:arial;font-size:12px;" align="center" border="0" >
     
    <tr>   
         <!-- <td align="left" style="font-family: arial;font-size:16px;"><b>ReAllocate </b></td> -->
    </tr>
    
    <tr>
    </tr>
    
 	<tr>   
         <td align="left" style="font-family: arial;font-size: 15px;"><font color="red">*</font>ReassignTo:</td>
         
         <td style="font-family: arial;font-size: 16px;">
         
         <select name="group" id="group" style="width: 170px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif;">
		 
		 <option value='Select' selected="selected" >Select</option>
		 	
		 	<%
 		  	String sqlGroup="select distinct(a.MarketingRepCode) as MarketingRepCode ,a.MarketingRepName as MarketingRepName from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster a,   db_GlobalERP.UserMaster b where b.ActiveStatus='YES' and a.MarketingRepCode=b.EmpCode  order by a.MarketingRepName";
 			ResultSet rsGroup=st.executeQuery(sqlGroup);
 			
 			while(rsGroup.next())
 			{
 				MarkName=rsGroup.getString("MarketingRepName");
 				MarkCode=rsGroup.getString("MarketingRepCode");
 			%>
 			<option value="<%=rsGroup.getString("MarketingRepCode")%>"><%=rsGroup.getString("MarketingRepName") %></option>
 			<%
 			}
 			%>
 			</select>
 			
 			
 			
 			
 			
 			
	 </td>
	 </tr>
	 
	</table>
	<table style="width:100%;font-family: arial;font-size: 8;" align="center">
	<tr>
	</tr>
	<tr>
	</tr>
	<tr>
	</tr>
	  	<tr>
			<td style="width:100px;font-family: arial;font-size: 8;">
			</td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 <input type="button" name="add" value="Submit"  onclick="addRow()" style="width:80px;"/>
			</td>
			<td>
			</td>
		</tr>
	</table>
 </div>
</form>

<input type="hidden" name='code' id='code' value=<%=Code %>> 
<input type="hidden" name='type' id='type' value=<%=Type %>>



</body>
</html>
</jsp:useBean>