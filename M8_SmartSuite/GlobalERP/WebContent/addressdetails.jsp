<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<style>
			body
			{
            margin: 0px;
            padding: 0px;
            }
            
            #divheader
            {
            height:50;
            background:	White;
            }
            
            #header 
            {
            background: #2675a8;
            font:large;
            color:green;
            width: 100%;
            }
            
            #leftcolumn 
            {
            background:#0099CC;
            float: left;
            width: 35%;
            height: 400px;
            }
            
            #content 
            {
            border:medium;
            border-color:blue;
            background: ;
            float: left;
            width: 100%;
            height: 400px;
            /*overflow:scroll;*/
            }
            
            #myfooter 
            {
            background: #df781c;
            clear: both;
            width: 100%;
            }
            #tooltip
            {
  			  	position:relative;
    			font-family:arial,sans-serif;
    			font-size:10px;
    			color:#000;
    			padding:3px;
    			border:1px solid #000;
    			background-color:#ffe;
			}
			table.mysortable
			{
				text-align: left;
				font-family: Verdana, Geneva, Arial, Helvetica, sans-serif ;
				font-weight: normal;
				font-size: 11px;
				color: #fff;
				background-color: #1581AB; <!-- -->
				border: 0px;
				border-collapse: collapse;
				border-spacing: 0px;
			}

			table.mysortable td
			{
				background-color: #F8F8FF;
				color: #000;
				padding: 4px;
				border: 1px #808080 solid;
			}
			table.mysortable th
			{
				background-color: #1581AB;
				color: white;
				padding: 4px;
				border: 1px #808080 solid;
			}

			table.mysortable td.hed
			{
				background-color: #C6DEFF;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

			table.mysortable td.hed1
			{
				background-color: #C6DEFF;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

</style>

<script>

function cancelentryform()
{
	
	document.addressdata.action ="addNewCustomer.jsp?companyName="+document.addressdata.companyname.value;
    document.forms["addressdata"].submit();
}


</script>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 -->
 <meta http-equiv="content-type" content="text/html; charset=utf-8" />
</head>

<html>
<body>
<%!
Connection con1;
%>
<% 
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st=con1.createStatement();
		String sql="";
		sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where customercode="+request.getParameter("customercode")+" limit 1";				
        System.out.println("customer query---->>"+sql);
        ResultSet rs= st.executeQuery(sql);
        String maddress="";
        String mcity="";
        String mcountry="";
        String mstate="";
        String mzip="";
        String mproduct="";
        String mcontactperson="";
        while (rs.next())
        {
            maddress=rs.getString("address");
            mcity=rs.getString("city");
            mcountry=rs.getString("country");
            mstate=rs.getString("state");
            mzip=rs.getString("zip");
            mproduct=rs.getString("intrestedproduct");
            mcontactperson=rs.getString("contactperson");
        	
        }
%>



<form name="addressdata" action="AjaxSaveAddress.jsp" method="post" autocomplete="off">
<div style="border:thin solid black; width:100%;height:32px;text-align:center;"><h1>Add Addresses</h1></div>
<div style="border:thin solid black; width:100%;height:32px;text-align:center;"><h3>Prospective Customer Name:<%=request.getParameter("companyname") %></h3></div>
<div id="content">
<div id="dataentry" style="position: absolute; width:50%; background-color: #94ECF6; border: solid thin black; -moz-border-radius-topleft: 20px; -moz-border-radius-bottomleft: 20px; -moz-border-radius-topright: 20px; -moz-border-radius-bottomright: 20px;">
		<div style="border: thin solid blue; background-color: #457FC2; height: 26px; -moz-border-radius-topleft: 20px; -moz-border-radius-topright: 20px;">
		<table style="color: white; align: center; width: 100%">
			<tr style="color: white; text-align: center;">
				<td style="width: 80%; color: white;"><h3 style="color:white;">Address
				Entry</h3></td>
				<td align="right"><a href="#"
					style="font-weight: bold; color: black;" onclick="cancelentryform()">
				<img src="images/end.JPG" width="25px" height="22px"
					style="border-style: none"></img> </a>&nbsp; <!-- <input type="button" name="cancel" id="cancel" value="X"  onclick="cancelentryform()" style="width:20; color:red;" /> -->
				</td>
			</tr>
		</table>
		</div>
		<table style="width: 100%;">
			<tr>
				<td><b>Address:</b></td>
				<td><textarea
										name="address" rows="2" id="search-text"
										style='width: 225px; height: auto;'></textarea>
										
				</td>
			</tr>
			<tr>
				<td><b>Country:</b></td>
				<td><input type="text" name="country" style="width: 150px;" />
				</td>
			</tr>
			<tr>
				<td><b>State:</b></td>
				<td><input type="text" name="state" style="width: 150px;" />
				</td>
			</tr>

			<tr>
				<td><b>City:</b></td>
				<td><input type="text" name="city" style="width: 100px;" />
				</td>
			</tr>
			<tr>
				<td><b>Zip Code:</b></td>
				<td><input type="text" name="zipcode" style="width: 100px;" />
				</td>
			</tr>
			<tr>
				<td><b>STD Code:</b></td>
				<td><input type="text" name="stdcode" style="width: 100px;" />
				</td>
			</tr>
			<tr>
				<td><b>Email Ids:</b></td>
				<td><input type="text" name="emailids" style="width: 225px;" />
				</td>
			</tr>
			<tr>
				<td><b>Mobile No:</b></td>
				<td><input type="text" name="mobileno" style="width: 225px;" />
				</td>
			</tr>
			
			<tr>
				<td><b>Phone Nos.:</b></td>
				<td><input type="text" name="phoneno" style="width: 225px;" />
				</td>
			</tr>
			<tr>
				<td><b>Alertnative No.:</b></td>
				<td><input type="text" name="alternatenumber" style="width: 225px;" />
				</td>
			</tr>
			
			<tr>
				<td><b>Fax No.:</b></td>
				<td><input type="text" name="faxno" style="width: 190px;" />
				<input type="hidden" name="entryflag" value="ADD" />
				<input type="hidden" name="customercode" value="<%=request.getParameter("customercode") %>" />
				<input type="hidden" name="companyname" value="<%=request.getParameter("companyname") %>" />
				<input type="hidden" name="c_address" value="<%=maddress %>" />
				<input type="hidden" name="c_city" value="<%=mcity%>" />
				<input type="hidden" name="c_country" value="<%=mcountry%>" />
				<input type="hidden" name="c_state" value="<%=mstate%>" />
				<input type="hidden" name="c_zip" value="<%=mzip%>" />
				<input type="hidden" name="c_product" value="<%=mproduct%>" />
				<input type="hidden" name="c_contactperson" value="<%=mcontactperson%>" />
				<input type="hidden" name="currentrow" value="0" />
				</td>
				
			</tr>
		</table>
		<table style="width: 100%;">
			<tr>
				<td style="text-align:center;"><input type="submit" name="add" value="Save"
					style="width: 70px;" /> <input
					type="button" name="cancel_entry" id="cancel_entry" value="Cancel"
					onclick="cancelentryform()" style="width: 70px;" /></td>
			</tr>
		</table>
		</div>
		
		<div >
<%
		String sql1="";
		sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr where customercode="+request.getParameter("customercode");				
        System.out.println("address query---->>"+sql1);
        ResultSet rs1= st.executeQuery(sql1);
        %>
        <div style="border:thin solid black; width:48%;height:400px;margin-left:51%;position:absolute;background:color:aqua;">
        <table class="mysortable" style="width:100%;background-color: #457FC2;"><tr><td style="background-color: #457FC2;color:white;border:thin solid white;height:32px;text-align:center;"><h3 style="color:white">Address List</h3></td></tr></table>		
        <div style="overflow:auto;"></div>
        <table class="mysortable"><tr >
         <th style="width:400px;">Mobile No</th>
         <th style="width:400px;">Phone No</th>
        <th style="width:400px;">email</th>
        <th style="width:400px;">Address</th>
        <th style="width:200px;">City</th>
        <th style="width:200px;">State</th>
        <th style="width:200px;">Country</th>
        </tr>
        <%
        while (rs1.next())
    	{
    		%>
    		<tr>
    		<td>
    		<%=rs1.getString("mobileno") %>
    		</td>
    		<td>
    		<%=rs1.getString("phone") %>
    		</td>
    		<td>
    		<%=rs1.getString("email") %>
    		</td>
    		<td>
    		<%=rs1.getString("address") %>
    		</td>
    		<td>
    		<%=rs1.getString("city") %>
    		</td>
    		<td>
    		<%=rs1.getString("state") %>
    		</td>
    		<td>
    		<%=rs1.getString("Country") %>
    		</td>
    		</tr>	
    		<%
    	}
        %>
        </table>
		</div>
		
		</div>
		
		
	</div>
	</form>
</body>
</html>
</jsp:useBean>