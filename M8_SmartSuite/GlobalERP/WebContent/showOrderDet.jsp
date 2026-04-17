<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>

<%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

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
	String comid=(String)session.getAttribute("CompanyMasterID");
	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null;
	boolean isInvoiceSelected=false;
			
	double sumAmount=0; 
	int groupCode=0,makeCode=0;
	String groupName="",makeName="",itemCode="";
	String refMakeNameTable="";
	String sqlDisplayDesc=" ";
	String sellingPrice="" ,priceAccepted="",quantity="";
	String scode=request.getParameter("supplierCode");
	System.out.println(">>>>>>   COMOMO    "+scode);
	String pquono=request.getParameter("PurchaseQuoNo");
	System.out.println(">>>>>>    NO   <<<<< "+pquono);
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	
	String fromDate="";
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_MONTH, -30);
	fromDate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
			.getTime());
    
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	} catch (Exception e) {
	}
%>


<div align="center"
		style="font-size: 1.5em; margin-top: 0.5em; margin-bottom: 0.3em; height: 3px; background-color: #339CCB">
	</div>
	<div align="center" style="font-size: 1.5em; ">
	Domestic Purchase Quotation  </a> 
	</div>
	<div align="center"
		style="font-size: 1.5em; margin-top:0.3em; margin-bottom:0.5em; height: 3px; background-color: #339CCB">
	</div>
	
	<form name="generatequo" method="post" action="generatePurOrd.jsp">
	<%
	String sqlDet="SELECT * from "+comid+"purchasequo as a left outer join "+comid+"supplierdet  as b on (a.SupplierCode=b.SupplierCode ) where  a.PurQuoNo='"+pquono+"' ";
	System.out.println(sqlDet);
	ResultSet rsDet=st.executeQuery(sqlDet);
	if(rsDet.next()){
	
	%>
	
	<table width="100%">
	<tr>
	 
	<td><b>PQuo Date:</b></td>
	<td><%=rsDet.getString("PurQuoDate") %></td>

	<td><b>Contact Person</b></td>
	<td><%=rsDet.getString("ContactPerson") %></td>
	<td><b>Pur Quo Exp Date</b></td>
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
	<td><b>Sup Name:</b></td>
	<td><%=rsDet.getString("SupplierName") %></td>
	</tr>
	<tr>
	
	<td><b>Address</b></td>
	<td><%=rsDet.getString("Address") %></td>
	<td><b>City</b></td>
	<td><%=rsDet.getString("Address") %></td>
	<td><b>State</b></td>
	<td><%=rsDet.getString("Address") %></td>
	</tr>
   <%}%> 
	</table>

 <div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
 
  
 	<table  align="center" class='sortable'>
	<tr>
	 
	<th style="width: 125px;"><a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
	<font color="white">Chk All&nbsp;&nbsp;/&nbsp;</font></a> <a href="#"
	onclick="unCheckAll()"> <font color="white">UnChk all</font></a></th>


	<th>Make</th>
	<th>Model</th>
	<th>Part No</th>
	<th>Description</th>
	<th>Quantity</th>
	<th>Selling Price</th>
	<th>SACCode</th>
	<th>HSNCode</th>
	<th>CGSTRate</th>
	<th>SGSTRate</th>
	<th>IGSTRate</th>
	<th>CGSTAmt</th>
	<th>SGSTAmt</th>
	<th>IGSTAmt</th>
	
	</tr>
	
	<%
	String Sql="";
	NumberFormat nf1=NumberFormat.getInstance();
	nf1.setMaximumFractionDigits(2);
	nf1.setMinimumFractionDigits(2);
	double CGSTRate=0.00,SGSTRate=0.00,IGSTRate=0.00,CGSTAmt=0.00,SGSTAmt=0.00,IGSTAmt=0.00,UnitPrice=0.00;
	String SACCode="";
	String HSNCode="";
	String Make="",Model="",PartNo="",Desc="",Quantity="";
	String sqlEnq="SELECT * FROM "+comid+"pquo_items WHERE PQNo='"+pquono+"'";
	String ServiceCategary="";
	double SellPrice=0.00;
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
	
	CGSTRate=rsEnq.getDouble("CGSTRate");
	SGSTRate=rsEnq.getDouble("SGSTRate");
	IGSTRate=rsEnq.getDouble("IGSTRate");
	CGSTAmt=rsEnq.getDouble("CGSTAmt");
	SGSTAmt=rsEnq.getDouble("SGSTAmt");
	SellPrice=rsEnq.getDouble("UnitPrice");
	
	if(IGSTRate!=0.00)
	{
		IGSTAmt=rsEnq.getDouble("IGSTAmt");
	}
	else
	{
		IGSTAmt=0.00;
	}
	
	ServiceCategary=rsEnq.getString("ServiceCategary");
	
	if(ServiceCategary.equals("Services"))
	{
	SACCode=rsEnq.getString("SACCode");
	HSNCode="-";
	}
	else
	{
		SACCode="-";
		HSNCode=rsEnq.getString("HSNCode");	
	}
	
	System.out.println("CGSTRate "+CGSTRate);
	System.out.println("SGSTRate "+SGSTRate);
	System.out.println("IGSTRate "+IGSTRate);
	System.out.println("CGSTAmt "+CGSTAmt);
	System.out.println("SGSTAmt "+SGSTAmt);
	System.out.println("IGSTAmt "+IGSTAmt);
	System.out.println("SACCode "+SACCode);
	System.out.println("HSNCode "+HSNCode);
	
	String sqlGroup="SELECT TheGroupName from  "+comid+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";

	ResultSet rsGroup=st2.executeQuery(sqlGroup);
	if(rsGroup.next())
	groupName=rsGroup.getString("TheGroupName");
	if(groupCode<5)
	{
		refMakeNameTable=comid+"tbl_"+groupName.substring(0,5)+"makemaster";
		   	  	
		String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		   
		ResultSet rsMakeName=st3.executeQuery(sqlMakename);
		if(rsMakeName.next())
		makeName=rsMakeName.getString(1);
		else
		makeName="-";
				      
		sqlDisplayDesc="SELECT * FROM  "+comid+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
	}
	else
	{
		sqlDisplayDesc="SELECT * FROM  "+comid+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
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
				refMakeNameTable=" "+comid+"tbl_"+groupName.substring(0,5)+"makemaster";
		   	  	
				String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
				ResultSet rsMakeName=st3.executeQuery(sqlMakename);
				System.out.println("********>>>>            "+sqlMakename );
				if(rsMakeName.next())
				makeName=rsMakeName.getString(1);
				else
				makeName="-";
						      
				sqlDisplayDesc="SELECT * FROM  "+comid+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
			}
			else
			{ 
				tableToBeAccessed=" "+comid+"tbl_otherim_group"+groupCode;
				System.out.println("--2-------------------><><><>"+tableToBeAccessed);
			}
			System.out.println("--3-------------------><><><>"+tableToBeAccessed);
			Sql="SELECT * FROM "+tableToBeAccessed+" WHERE ItemCode='"+itemCode+"' ";
			System.out.println(Sql);
		}
		else
		{
			Sql="SELECT * FROM "+rsEnq.getString("TheTableToBeAccessed").toLowerCase()+" WHERE ItemCode='"+itemCode+"' ";
			System.out.println("---3.5------------------><><><>"+tableToBeAccessed);
		}
		System.out.println("---4------------------><><><>"+tableToBeAccessed);
		System.out.println("???????                         >>>>>>"+Sql);
		ResultSet rsSql=st2.executeQuery(sqlDisplayDesc);
		if(rsSql.next())
		{
			String s_price=rsSql.getString("SellingPrice");
			if(s_price==null){
				s_price="0.00";
			}
%>

	<tr>
			<td><input type="checkbox" checked="checked" name="check<%=i %>"   id="check<%=i %>" value="check<%=i %>" /></td>
			<td><div align="left"><%=makeName %></div></td>
			<td><div align="left"><%=rsSql.getString("Model") %></div></td>
			<td><div align="left"><%=rsSql.getString("Partno") %></div></td>
			<td><div align="left"><input type="hidden" id="description<%=i %>" name="description<%=i %>"   value="<%=rsSql.getString("Description")%>" /><%=rsSql.getString("Description") %></div></td>
			<td><div align="right"><input type="text" id="quantity<%=i %>" name="quantity<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rsEnq.getString("Quantity") %>" readonly="readonly"/></div></td>
			
			<td><div align="right"><input type="text" id="sellingPrice<%=i %>" name="sellingPrice<%=i %>" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=SellPrice %>"  readonly="readonly" /></div></td>
			
				<%String pricedate ="NA";try{pricedate=new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat( 
						"yyyy-MM-dd")
						.parse(rsSql.getString("PriceDate"))); }
						catch(Exception e){}%>
			
			<%-- <td><div align="left"><%=((pricedate!=null) ? pricedate : "-") %></div></td>
			 
			<td><div align="right"><%=rsSql.getString("OEMPrices") %></div></td> --%>
			
			
			<td><div align="right"><%=SACCode %></div></td>
			<td><div align="right"><%=HSNCode %></div></td>
			<td><div align="right"><%=nf1.format(CGSTRate) %></div></td>
			<td><div align="right"><%=nf1.format(SGSTRate) %></div></td>
			<td><div align="right"><%=nf1.format(IGSTRate) %></div></td>
			
			<td><div align="right"><%=nf1.format(CGSTAmt) %></div></td>
			<td><div align="right"><%=nf1.format(SGSTAmt) %></div></td>
			<td><div align="right"><%=nf1.format(IGSTAmt) %></div></td>
			
		
	</tr>
	
	<%
		i++;
		}
	}
	
}
%>
		</table>
			<div align="center" style="margin-top: 3em;">
		<input type="hidden" name="group" value="<%= groupName%>" />
		<input type="hidden" name="purchasequono" value="<%=pquono %>"/>
	    <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=i %>"/>
	 
		<input type="submit" value="submit" style="border: outset; background-color: #C6DEFF"  />
	</div>
	</form>
<!-- <br><br> <br><br> <br><br> <br><br> -->
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