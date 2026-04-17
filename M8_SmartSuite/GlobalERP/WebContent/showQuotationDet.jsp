<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>

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


function checkAll()
{

	var field = document.getElementById("checkedNumber").value;
	var i;
	try{
	for (i = 0; i < field; i++)
	{
		 if(document.getElementById('check'+i).checked == false)
		 {
			 document.getElementById('check'+i).checked = true;
		 }
		
	}
}catch(e){alert(e);}
}

function unCheckAll()
{
var field = document.getElementById("checkedNumber").value;
var i;
try{
for (i = 0; i < field; i++)
{
	 if(document.getElementById('check'+i).checked == true)
	 {
		 document.getElementById('check'+i).checked = false;
	 }
	
}
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
	
	
	try {
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st2 = conn.createStatement();
		st1 = conn.createStatement();
		st3 = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	
	String scode=request.getParameter("supplierCode");
	System.out.println(">>>>>>   COMOMO    "+scode);

	String sqlData="Select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+scode+"'";
	ResultSet rsData=st2.executeQuery(sqlData);
	rsData.next();
	String supname=rsData.getString("SupplierName");	
	String contactper=rsData.getString("ContactPerson");	
	String addrs=rsData.getString("Address");	
	String cty=rsData.getString("City");	
	String Stat=rsData.getString("State");	
		
		
	String penqno=request.getParameter("PurchaseEnqNo");
	System.out.println(">>>>>>    NO   <<<<< "+penqno);
	String twrefno=request.getParameter("TWRefNo");
	System.out.println(">>>>>>  TW REF NO      <<<<< "+twrefno);
	
	String fromDate="";
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_MONTH, 0);
	fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
			.getTime());


%>


<div align="center"
		style="font-size: 1.5em; margin-top: 0.5em; margin-bottom: 0.3em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.5em; ">
	Domestic Purchase Enquiry  </a> 
	</div>
	<div align="center"
		style="font-size: 1.5em; margin-top:0.3em; margin-bottom:0.5em; height: 3px; background-color: #339CCB">
	</div>
	

	 		
	
	<%
	String sqlDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq as a left outer join "+session.getAttribute("CompanyMasterID").toString()+"supplierdet  as b on (a.Suppliercode=b.SupplierCode ) where  a.PurchaseEnqNo='"+penqno+"' ";
	System.out.println(sqlDet);
	ResultSet rsDet=st.executeQuery(sqlDet);
	if(rsDet.next()){
	
	%>
<form name="generatequo" method="post" action="generatePurQuo.jsp">
	<tr>
	<table width="100%">
	
	
	 
		<td><b>Date:</b></td>
		<td><%=new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat( 
								"yyyy-MM-dd")
								.parse(rsDet.getString("PurEnqDate")))%></td>
		<td><b>Time:</b></td>
		<td><%=rsDet.getString("PurEnqTime") %></td>
		

	<td><b>Contact Person</b></td>
	<td><input type="hidden" name="contactper" id="contactper" value="<%=contactper %>"/><%=contactper%></td>
	<td><b>Expiry Date:</b></td>
	<td>
	<div>
	<input type="text" id="fromdate"
	name="fromdate" value="<%=fromDate%>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "fromdate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "fromdate"       // ID of the button
	}
	);
	</script></div></td>
	</tr>
	<tr>
	<td><b>Supplier Name:</b></td>
	<td><input type="hidden" name="supplier" id="supplier" value="<%=supname %>"/><%=supname %></td>
	<td><b>Address:</b></td>
	<td><input type="hidden" name="address" id="address" value="<%=addrs %>"/><%=addrs %></td>
	<td><b>City:</b></td>
	<td><input type="hidden" name="city" id="city" value="<%=cty %>"/><%=cty %></td>
	<td><b>State:</b></td>
	<td><input type="hidden" name="state" id="state" value="<%=Stat%>"/><%=Stat %></td>
	</tr>
   <%}%> 

	</table>

 <div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
 
 
 	<table  align="center" class='sortable'>
	<tr>
	 
	<th style="width: 125px;">
	<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
	<font color="white">Chk All &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
	<a href="#" onclick="unCheckAll()"> <font color="white">UnChk all</font></a>
	</th>


	<th>Make</th>
	<th>Model</th>
	<th>Part No</th>
	<th>Description</th>
	<th>Quantity</th>
	<th>Selling price</th>
<!--	<th>Prize Date</th>-->
<!--	<th>OEM Prize</th>-->
	
	</tr>
	
	<%
	String Sql="";
	String sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo='"+penqno+"'";
	
	System.out.println("+++++++++++++++++"+sqlEnq);
	int i=0;
	ResultSet rsEnq=st1.executeQuery(sqlEnq);
	while(rsEnq.next())
	{
	
	groupName="";makeName="";refMakeNameTable="";
	String tableToBeAccessed="";
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
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$    "+sqlDisplayDesc);
	ResultSet rsDetails1=st.executeQuery(sqlDisplayDesc);
	if(rsDetails1.next())
	{
		if(rsEnq.getString("TheTableToBeAccessed").equals("-"))
		{	
			System.out.println("---------------------------------------    ");
			if(groupCode<5){
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+"";
			System.out.println(tableToBeAccessed);
			}
			else
			{ 
				tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
				System.out.println(tableToBeAccessed);
			}
			Sql="SELECT * FROM "+tableToBeAccessed+" WHERE ItemCode='"+itemCode+"' ";
			System.out.println(Sql);
		}
		else
		{
			Sql="SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed").toLowerCase()+" WHERE ItemCode='"+itemCode+"' ";
		}
		System.out.println("???????                         >>>>>>"+Sql);
		ResultSet rsSql=st2.executeQuery(Sql);
		if(rsSql.next())
		{
%>
	<tr>
			<td><input type="checkbox" checked="checked" name="check<%=i %>"   id="check<%=i %>" value="check<%=i %>" /></td>
			<td><div align="left"><%=makeName %></div></td>
			<td><div align="left"><%=rsSql.getString("Model") %></div></td>
			<td><div align="left"><%=rsSql.getString("Partno") %></div></td>
			<td><div align="left"><input type="hidden" id="description<%=i %>" name="description<%=i %>"   value="<%=rsSql.getString("Description")%>" /><%=rsSql.getString("Description") %></div></td>
			<td><div align="right"><input type="text" id="quantity<%=i %>" name="quantity<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rsEnq.getString("Quantity") %>" /></div></td>
			<td><div align="right"><input type="text" id="sellingPrice<%=i %>" name="sellingPrice<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rsSql.getString("SellingPrice") %>" /></div></td>
			
				<%String pricedate ="NA";try{pricedate=new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat( 
						"yyyy-MM-dd")
						.parse(rsSql.getString("PriceDate"))); }
						catch(Exception e){}%>
			
<!--			<td><div align="left">< %=((pricedate!=null) ? pricedate : "-") %></div></td>-->
<!--			 -->
<!--			<td><div align="right">< %=rsSql.getString("OEMPrices") %></div></td>-->
		
	</tr>
<%
		i++;
		}
	}
	
}
%>
	</table>
		<div align="center" style="margin-top: 3em;">
		<input type="hidden" name="group" id="group" value="<%= groupName%>" />
		<input type="hidden" name="purchaseenqno" id="purchaseenqno" value="<%=penqno %>"/>
	    <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i %>"/>
	    <input type="hidden" name="supcode" id="supcode" value="<%=scode %>"/>
	     <input type="hidden" name=twrefno id="twrefno" value="<%=twrefno %>"/>
		<input type="submit" value="submit" style="border: outset; background-color: #C6DEFF"  />
	</div>
	
	
</form>

<!-- 	<br><br> <br><br> <br><br> <br><br> -->
<!-- 	<br><br> <br><br> <br><br> <br><br>  -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@ include file="footer_new.jsp"%>