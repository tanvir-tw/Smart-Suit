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
	{if(document.getElementById("fromdate").value=="")
	{
  		alert("Please Select The From Date");
		return false;
	}
	if(document.getElementById("todate").value=="")
	{
		alert("Please Select The To Date");
		return false;
	}	

	var letters1 = /^[A-Z a-z]+$/;
	document.getElementById("lblNameMsg1").style.display="none";
	document.getElementById("lblNameMsg2").style.display="none";	
var name=document.addBranch.staffname.value;
var invalid=/[^A-Za-z\s]/;
var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(name=="" || oth==""){
	document.getElementById("lblNameMsg1").style.display="";
		return false;
	}
if(invalid.test(name)){
 document.getElementById("lblNameMsg2").style.display="";
	     return false;
	 }	


document.getElementById("lblBranchMsg1").style.display="none";
var branch=document.forms["addBranch"]["branch"].value;
if(branch=="Select"){
	document.getElementById("lblBranchMsg1").style.display="";
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
document.getElementById("lblMoNoMsg1").style.display="none";
document.getElementById("lblMoNoMsg2").style.display="none";
document.getElementById("lblMoNoMsg3").style.display="none";	

	var contact=document.addBranch.contact.value;
	if(!(contact ==0))
	{
		 if(isNaN(contact))
			{
				document.getElementById("lblMoNoMsg1").style.display="";
				return false;
			}	
			 if((contact.trim().length < 10)  || (contact.trim().length >15))
				 {
				 document.getElementById("lblMoNoMsg2").style.display=""; 
	        return false;
	    }
	}
	else
	{
		contact="";
		document.getElementById("lblMoNoMsg3").style.display="";
	    return false;	
	}
	
	document.getElementById("lblCommMsg1").style.display="none";
	document.getElementById("lblCommMsg2").style.display="none";
	var comm=document.addBranch.commission.value;
	if(!(comm ==0))
	{
		 if(isNaN(comm))
			{
				document.getElementById("lblCommMsg1").style.display="";
				return false;
			}	
			
	}
	else
	{
		comm="";
		document.getElementById("lblCommMsg2").style.display="";
	    return false;	
	}
	
	
	var Location=document.addBranch.loc.value;
	document.getElementById("lblLocMsg1").style.display="none";
	document.getElementById("lblLocMsg2").style.display="none";	
	var invalid=/[^A-Za-z\s]/;
var oth=Location.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
if(Location=="" || oth==""){
	document.getElementById("lblLocMsg1").style.display="";
		return false;
	}
if(invalid.test(Location)){
 document.getElementById("lblLocMsg2").style.display="";
	     return false;
	 }	

	document.getElementById("lblEmailMsg2").style.display="none";
	var email=document.addCustomer.email.value;
	if(email=="")
	{
		//document.getElementById("lblEmailMsg1").style.display="";
		//return false;
	}

var sss=validateMultipleEmailsCommaSeparated(email);
if(!sss)
{
	document.getElementById("lblEmailMsg2").style.display="";
	return false;
} 
   	var at="@";
		var dot=".";
		var comaa=",";
		var lat=email.indexOf(at);
		var lstr=email.length;
		var ldot=email.indexOf(dot);
		var lcomaa=email.indexOf(comaa);
		if (email.indexOf(at)==-1 && email!="" && email.indexOf(dot)==-1 && email.indexOf(comaa)==-1){
		   alert("Invalid E-mail ID");
		   return false;
		}
	
		
		
	}
	function validateStaffName()
	{
		document.getElementById("lblNameMsg1").style.display="none";
		document.getElementById("lblNameMsg2").style.display="none";	
	var name=document.addBranch.staffname.value;
	var invalid=/[^A-Za-z\s]/;
	var oth=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(name=="" || oth==""){
		document.getElementById("lblNameMsg1").style.display="";
    		return false;
    	}
 if(invalid.test(name)){
	 document.getElementById("lblNameMsg2").style.display="";
    	     return false;
    	 }	
	}
	function validateContact()
	{
		document.getElementById("lblMoNoMsg1").style.display="none";
		document.getElementById("lblMoNoMsg2").style.display="none";
		document.getElementById("lblMoNoMsg3").style.display="none";	
		
			var contact=document.addBranch.contact.value;
			if(!(contact ==0))
			{
				 if(isNaN(contact))
					{
						document.getElementById("lblMoNoMsg1").style.display="";
						return false;
					}	
					 if((contact.trim().length < 10)  || (contact.trim().length >15))
						 {
						 document.getElementById("lblMoNoMsg2").style.display=""; 
			        return false;
			    }
			}
			else
			{
				contact="";
				document.getElementById("lblMoNoMsg3").style.display="";
			    return false;	
			}
	}
	
	function ValidateEmailField()
	{
		document.getElementById("lblEmailMsg2").style.display="none";
		var email=document.addCustomer.email.value;
		if(email=="")
    	{
			//document.getElementById("lblEmailMsg1").style.display="";
    		//return false;
    	}

	var sss=validateMultipleEmailsCommaSeparated(email);
	if(!sss)
	{
		document.getElementById("lblEmailMsg2").style.display="";
		return false;
	} 
       	var at="@";
   		var dot=".";
   		var comaa=",";
   		var lat=email.indexOf(at);
   		var lstr=email.length;
   		var ldot=email.indexOf(dot);
   		var lcomaa=email.indexOf(comaa);
   		if (email.indexOf(at)==-1 && email!="" && email.indexOf(dot)==-1 && email.indexOf(comaa)==-1){
   		   alert("Invalid E-mail ID");
   		   return false;
   		}
	}
	
	function validateCommission()
	{
		document.getElementById("lblCommMsg1").style.display="none";
		document.getElementById("lblCommMsg2").style.display="none";
		var comm=document.addBranch.commission.value;
		if(!(comm ==0))
		{
			 if(isNaN(comm))
				{
					document.getElementById("lblCommMsg1").style.display="";
					return false;
				}	
				
		}
		else
		{
			comm="";
			document.getElementById("lblCommMsg2").style.display="";
		    return false;	
		}
	}
	function validateLocation()
	{
		var Location=document.addBranch.loc.value;
		document.getElementById("lblLocMsg1").style.display="none";
		document.getElementById("lblLocMsg2").style.display="none";	
		var invalid=/[^A-Za-z\s]/;
	var oth=Location.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(Location=="" || oth==""){
		document.getElementById("lblLocMsg1").style.display="";
    		return false;
    	}
 if(invalid.test(Location)){
	 document.getElementById("lblLocMsg2").style.display="";
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
	
	function dateformat(days)
	{
		if(days=='Jan')
			return(1);
		else
			if(days=='Feb')
				return(2);
			else
				if(days=='Mar')
					return(3);
				else
					if(days=='Apr')
						return(4);
					else
						if(days=='May')
							return(5);
						else
							if(days=='Jun')
								return(6);
							else
								if(days=='Jul')
									return(7);
								else
									if(days=='Aug')
										return(8);
									else
										if(days=='Sep')
											return(9);
										else
											if(days=='Oct')
												return(10);
											else
												if(days=='Nov')
													return(11);
												else
													if(days=='Dec')
														return(12);
	}

	function dateValidate() 
	{
		var date1=document.getElementById("fromdate").value;
		var date2=document.getElementById("todate").value;
		var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
		dy1=date1.substring(0,2);
		dy2=date2.substring(0,2);
		dm1=date1.substring(3,6);
		dm2=date2.substring(3,6);

		dm11=dateformat(dm1);
		dm22=dateformat(dm2);	
		dd1=date1.substring(7,11);
		dd2=date2.substring(7,11);
		var date=new Date();
		var month=date.getMonth()+1;
		//var month1=date2.getMonth();
		var day=date.getDate();
		var year=date.getFullYear();
		
		
		
		
		if(dd1>dd2)
		{  
			
			
			
			alert("From Date Year Is Should Not Be Greater Than To Date Year");
			document.getElementById("fromdate").value="";
			document.getElementById("todate").value="";
			document.getElementById("fromdate").focus;
			return false;
			
		}
		
		else if(year==dd1 && year==dd2) if(dm11>dm22)
		{
			
			alert("From Date Month Is Should Not Be Greater Than To Date Month ");
			document.getElementById("fromdate").value="";
			document.getElementById("todate").value="";
			document.getElementById("fromdate").focus;
			return false;
		}
		 if(dm1==dm2 && dd1==dd2) {
		if(dy1 > dy2)
		{
			alert("From Date Should Not Be Greater Than To Date");
			document.getElementById("fromdate").value="";
			document.getElementById("todate").value="";
			document.getElementById("fromdate").focus;
			return false;
		}
		}
		return true;
	

		
		/*		var d=new Date().getMonth();
		//alert(d);
		dy1=dt.substring(7,11);
		dy2=today.substring(0,4);
		
		dm1=d+1;
		dm2=today.substring(5,7);
		
		dd1=dt.substring(0,2);
		dd2=today.substring(8,10);
*/
		//alert(dy1+"=="+dy2+"=="+dm1+"=="+dm2+"=="+dd1+"=="+dd2);

	/*	if( (dd1>dd2 && dm1>=dm2) || (dm1>dm2 && dy1>=dy2) || (dy1>dy2) )
		{
			alert("Please Select Valid Date");
			return false;
		}  */
		
	
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
				st3 = conn.createStatement();
			} catch (Exception e) 
			{}
		String srno=request.getParameter("Id");
		System.out.println("Srno===="+ srno);
		String name="", contact="",email="",commission="",location="",remark="",validfrom="",validto="",branch="";
		String Query="Select * from "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster where srno='"+srno+"'";
		 ResultSet rs = st.executeQuery(Query);
		if(rs.next())	
		{
			name=rs.getString("name");
			branch=rs.getString("branch");
			contact=rs.getString("contact");
			email=rs.getString("email");
			commission=rs.getString("commission");
			location=rs.getString("Location");
			remark=rs.getString("remark");
			validfrom=rs.getString("validfrom");
			validto=rs.getString("validto");
			
		}
 %> 
<form name="addBranch" method="post" action="insertEditCollection.jsp?Id=<%=srno%>" onsubmit="return ValidateForm();">
		<div align="center"><font face="Arial" color="black" size="3"><b>Edit Existing Collection Staff</b></font></div>
		<br><br>
		<table align="center">
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Name</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="staffname" id="staffname" value="<%= name%>" onblur="return validateStaffName();" style="width: 200px;" />
						<label id="lblNameMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Name</font></label>
				<label id="lblNameMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Name..</font></label>
				</td>
			</tr>
			<tr>
			
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>Branch</b></font><font size="2" color="red">*</font></td>
			<td>
			
			<select name="branch" id="branch" style="
				  	width: 170px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; ">
				  	<option><%= branch %></option>
				  <% String sqlDropdown11="SELECT Distinct branchName FROM "+session.getAttribute("CompanyMasterID").toString()+"BranchMaster order by branchName ";
				  ResultSet rsDropdown11=st3.executeQuery(sqlDropdown11);
				  while(rsDropdown11.next())
				  {
				  %>
				  <option><%=rsDropdown11.getString(1)%></option>
							
						<% 	}%> 
				</select>
							
			</td>
			</tr>
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Contact No.</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
						<label id="lblMoNoMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Mobile Number</font></label>
										<label id="lblMoNoMsg2" style="display: none;"><font face="Arial" size="2" color="red">Mobile No Should Be Greater Than 9 Digits and Less Than 15 Digits</font></label>
										<label id="lblMoNoMsg3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Mobile Number</font></label>
				</td>
				<td>
						<input type="text" name="contact" id="contact" value="<%= contact%>" onblur="return validateConatct();" style="width: 200px;" />
						<label id="lblMoNoMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Mobile Number</font></label>
										<label id="lblMoNoMsg2" style="display: none;"><font face="Arial" size="2" color="red">Mobile No Should Be Greater Than 9 Digits and Less Than 15 Digits</font></label>
										<label id="lblMoNoMsg3" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Mobile Number</font></label>
				</td>
			</tr>
			
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Email Id</b></font>&nbsp;&nbsp;
				</td>
				<td>
						<input type="text" name="email" id="email" value="<%= email%>"  onblur="return ValidateEmailField();"    onchange="return ValidateEmailField();" style="width: 200px;" />
						<label id="lblEmailMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Valid Email Id</font></label>
				</td>
			</tr>
			
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Commission %</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="commission" id="commission" value="<%= commission%>" onblur="return validateCommission();" style="width: 200px;" />
						<label id="lblCommMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Numeric Value For Commission</font></label>
						<label id="lblCommMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Commission</font></label>
				</td>
			</tr>
			
			<tr>
				<td>
						<font face="Arial" size="2" color="black"><b>Location</b></font>&nbsp;&nbsp;<font size="2" color="red">*</font>
				</td>
				<td>
						<input type="text" name="loc" id="loc" value="<%= location%>" onblur="return validateLocation();" style="width: 200px;" />
						<label id="lblLocMsg1" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Location</font></label>
				<label id="lblLocMsg2" style="display: none;"><font face="Arial" size="2" color="red">Please Enter Character Value For Location..</font></label>
				</td>
			</tr>
			
			<tr>
			
			<td  align="left"><font face="Arial" size="2" color="black"><b>Valid From </b></font><font size="2" color="red">*</font></td>
			<td>
			
			<input type="text" id="fromdate"
name="fromdate"  value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(validfrom)) %>"  size="15" readonly
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
			</td>
			</tr>
			<tr>
					<td  align="left"><font face="Arial" size="2" color="black"><b>Valid To </b></font><font size="2" color="red">*</font></td>
			<td>
			
			<input type="text" id="todate"
name="todate" value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(validto)) %>" onchange="dateValidate();" size="15" readonly
style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate"       // ID of the button
}
);
</script>
			</td>
			
			
		</tr>
			
			<tr>
			<td  align="left"><font face="Arial" size="2" color="black"><b>Remark </b></font> &nbsp;&nbsp;</td>
			<td>
			<div id="remark"><textarea id="remark" name="remark" " value="<%= remark%>" style="width: 300px"></textarea></div>
			
			</td></tr>
			
			</table>
					<div align="center"><input type="submit" value="Update" style="margin-top: 20px;"  /></div>
		
</form>
   </body>
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>