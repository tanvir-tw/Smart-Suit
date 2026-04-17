<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style type="text/css">
</style>
	<style>
</style>
	

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

<script language="JavaScript1.2">

	
	function generateQuo(Address,salesenqno,check)
	{ 
	alert(salesenqno+'  '+Address+'   '+check);
	window.open(Address+'&salesenqno='+salesenqno+'&check='+check,'jav');

	}


	function checkAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = true ;
	}catch(e){alert(e);}
	}

	function unCheckAll()
	{
	var field=document.getElementsByName('check');
	var i;
	try{
	for (i = 0; i < field.length; i++)
	field[i].checked = false ;
	}catch(e){alert(e);}
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
			
	double sumAmount=0; 
	int groupCode=0,makeCode=0;
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ";
	String sellingPrice="" ,priceAccepted="",quantity="";
	String company=request.getParameter("companyName");
	System.out.println(">>>>>>   COMOMO    "+company);
	String salesrefno=request.getParameter("SalesEnqRefNo");
	System.out.println(">>>>>>   REF NO   <<<<< "+salesrefno);
	String salesenqno=request.getParameter("SalesEnqNo");	
	
	
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	} catch (Exception e) {
	}
	%>
	
	<div align="center" style="font-size: 1.5em; "><font face="Arial" size="3" color="black">
	Export Enquiry Of : <%=request.getParameter("SalesEnqRefNo")%>&nbsp;&nbsp; For: <%=request.getParameter("companyName")%> </font> <br></br>
	</div>
	
	<form name="generateQuo" method="get" action="quotationexp.jsp"   >
	 
	<%
	String sqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqNo='"+salesenqno+"' ";
	System.out.println(sqlDet);
	ResultSet rsDet=st.executeQuery(sqlDet);
	while(rsDet.next()){
	
	%>
	 <table width="100%"><tr>
	 <td style="width: 40%">
		<table  align="left" width="100%" cellpadding="3" cellspacing="3">
		<tr>
		<td><font face="Arial" size="2" color="black"><b>Export Date:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat( 
								"yyyy-MM-dd")
								.parse(rsDet.getString("SalesEnqDate")))%></font></td>
		<td><font face="Arial" size="2" color="black"><b>Export Time:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("SalesEnqTime") %></font></td>
		</tr>
		<tr>
		<td><font face="Arial" size="2" color="black"><b>Customer Ref. No:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("CustRefNo") %></font></td>
		<td><font face="Arial" size="2" color="black"><b>Due date :</b></font></td>
		<%String duedate ="NA";try{duedate=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat( 
					"yyyy-MM-dd")
					.parse(rsDet.getString("SalesEnqDueDate"))); }
					catch(Exception e){}%>
		<td><font face="Arial" size="2" color="black"><input type="hidden" name="duedate" value=""/><%=duedate%></font>
		
		</td>
		</tr>
		<tr>
		<td><font face="Arial" size="2" color="black"><b>Remarks:</b></font></td>
		<td style="width:100px;"><font face="Arial" size="2" color="black"><input type="hidden" name="remarks" id="remarks" value="<%=rsDet.getString("CustRemarks") %>"/>
		<%=rsDet.getString("CustRemarks") %></font>
		</td>
		<td><font face="Arial" size="2" color="black"><b>Group:</b></font></td>
		<td><font face="Arial" size="2" color="black"><input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;" /></font></td>
		</tr>
		<input type="hidden" name="addresscode" value="<%= rsDet.getString("AddressCode") %>"/>
		</table>
	</td>
	
	<td>
		<table  bgcolor="#C6DEFF" align="right" valign="top" cellpadding="3" cellspacing="3" >
		<tr>
		<td><font face="Arial" size="2" color="black"><b>Cust name:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("CompanyName") %></font></td>
		<td><font face="Arial" size="2" color="black"><b>Contact Person:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("ContactPerson") %></font></td>
		<td><font face="Arial" size="2" color="black"><b>Address:</b></font></td>
		<td style="width: 220px;"><font face="Arial" size="2" color="black"><%=rsDet.getString("Address") %></font></td>
		</tr>
		<tr>
		<td><font face="Arial" size="2" color="black"><b>City:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("city") %></font></td>
		<td><font face="Arial" size="2" color="black"><b>State:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("State") %></font></td>
		<td><font face="Arial" size="2" color="black"><b>Country:</b></font></td>
		<td><font face="Arial" size="2" color="black"><%=rsDet.getString("country") %></font></td>
		</tr>
		<tr>
		<td><font face="Arial" size="2" color="black"><b>Phone:</b></font></td>
		<td><div align="left"><font face="Arial" size="2" color="black"><%=((rsDet.getString("Phone")!=null) ? rsDet.getString("Phone") : "-") %></font></div></td>
		<td><font face="Arial" size="2" color="black"><b>Fax:</b></font></td>
		<td><div align="left"><font face="Arial" size="2" color="black"><%=((rsDet.getString("Fax")!=null) ? rsDet.getString("Fax") : "-") %></font></div></td>
		<td><font face="Arial" size="2" color="black"><b>Zip code:</b></font></td>
		<td><div align="left"><font face="Arial" size="2" color="black"><%=((rsDet.getString("Zip")!=null) ? rsDet.getString("Zip") : "-") %></font></div></td>
		</tr>
	<%}%>        		
	   	</table>
   	
   	</td></tr></table>
  <div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;</div>


	<table  align="center" class='sortable'>
	<tr>
	 
	<th style="width: 125px;"><a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
	<font color="white">Chk All&nbsp;&nbsp;/&nbsp;</font></a> <a href="#"
	onclick="unCheckAll()"> <font color="white">UnChk all</font></a></th>

	<th>Option No</th>
	<th>Insert Or</th>
	<th>Make</th>
	<th>Model</th>
	<th>Part No</th>
	<th>Description</th>
	<th>Quantity</th>
	<th>Selling Price</th>
	<th>Prize Date</th>
	<th>OEM Prize</th>
	</tr>

<%
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items WHERE SalesEnqNo='"+salesenqno+"'";
	
	System.out.println("+++++++++++++++++"+sqlEnq);
	int i=0;
	ResultSet rsEnq=st1.executeQuery(sqlEnq);
while(rsEnq.next())
{
	
	groupName="";makeName="";refMakeNameTable="";
	
	double amount=0.00,discount=0;
	
	groupCode=rsEnq.getInt("TheGroup");
	
	makeCode=rsEnq.getInt("Make");
	itemCode=rsEnq.getString("ItemCode");
	     
	     
	String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5)
	{
		refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
		   	  	
		String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
				     
		ResultSet rsMakeName=st3.executeQuery(sqlMakename);
		if(rsMakeName.next())
		makeName=rsMakeName.getString(1);
		else
		makeName="-";
				      
		sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else
	{
		sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
		makeName="-"  ;
	}
	%>
	<script type="text/javascript">
	document.getElementById('groupTop').value='<%=groupName%>';
	</script>
	<%  
	ResultSet rsDetails1=st.executeQuery(sqlDisplayDesc);
	if(rsDetails1.next())
	{
		String Sql="SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed").toLowerCase()+" WHERE ItemCode='"+itemCode+"' ";
		ResultSet rsSql=st2.executeQuery(Sql);
		System.out.println("table is " +Sql);
		if(rsSql.next())
		{
			%>
			<tr>
			<td><input type="checkbox" checked="checked" name="check<%=i %>"   id="check<%=i %>" value="check<%=i %>" /></td>
			<td><div align="right"><%=rsEnq.getString("TheOptionNo") %></div></td>
			<td><div align="right"><%=rsEnq.getString("InsertOR") %></div></td>
			<td><div align="left"><%=makeName %></div></td>
			<td><div align="left"><%=rsSql.getString("Model") %></div></td>
			<td><div align="right"><%=rsSql.getString("Partno") %></div></td>
			<td><div align="left"><input type="hidden" id="description<%=i %>" name="description<%=i %>" value="<%=rsSql.getString("Description") %>"/><%=rsSql.getString("Description") %></div></td>
			
			
			<td style="width: 85px;"><div align="right">
			<input type="text" id="quantity<%=i %>" name="quantity<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
				color: #000000; " value="<%=rsEnq.getString("Quantity") %>" /></div>
				
				
				
				</td>
				
				
				
			<td style="width: 85px;">
			<div align="right"><input type="text" id="sellingPrice<%=i %>" name="sellingPrice<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rsSql.getString("SellingPrice") %>" /></div></td>
			
			<%String pricedate ="NA";try{pricedate=new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat( 
						"yyyy-MM-dd")
						.parse(rsDet.getString("PriceDate"))); }
						catch(Exception e){}%>
			
			<td><div align="left"><%=((pricedate!=null) ? pricedate : "-") %></div></td>
			 
			<td><div align="right"><%=rsSql.getString("OEMPrices") %></div></td>
			
			</tr>
		<%
		i++;
			}
	}
	
}
%>
	 </table>
	<div align="center" style="margin-top: 3em;">
		<input type="hidden" name="group" value="<%= request.getParameter("TheGroup")%>" />
	    <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i %>"/>
	    <input type="hidden" name="company" id="company" value="<%=company %>"/>
	    <input type="hidden" name="salesenqno" value="<%=salesenqno %>" />
		<input type="submit" value="submit" style="border: outset; background-color: #C6DEFF"  />
	</div>
	      
	</form>
	
	
	
	<br><br> <br><br> 
	<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>