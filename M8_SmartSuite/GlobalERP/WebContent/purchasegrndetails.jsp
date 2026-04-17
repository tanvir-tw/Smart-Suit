<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
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


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<!-- <title>Transworld Compressor-Technologies LTD, ERP</title> -->
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
    </style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>	
	<script language="javascript">
	function printpage() {
        //Get the print button and put it into a variable
        var printButton = document.getElementById("printGRN");
        //Set the print button visibility to 'hidden' 
        printButton.style.visibility = 'hidden';
        //Print the page content
        window.print()
        //Set the print button to 'visible' again 
        //[Delete this line if you want it to stay hidden after printing]
        printButton.style.visibility = 'visible';
    }

	</script>
	</head>
	<body>
	
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%

	Connection conn = null;
	Statement st = null, st1 = null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null;
	
	int groupCode=0,makeCode=0;
	int d=0,k=0;
	double tax=0,discount=0.00,amount=0;
	int i=1;
	String groupName="",makeName="",itemCode="",stpercent="",refMakeNameTable="",sqlDisplayDesc="";
	String type=request.getParameter("condition");
	System.out.println(type);
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
	
	Date today = new Date();
	String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today);
	
	String grnno=request.getParameter("GRNNo");
	String pono=request.getParameter("PONo");
	String suppliercode=request.getParameter("supplierCode");
	
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 =conn.createStatement();
	st6 =conn.createStatement();
	st7 =conn.createStatement();
	} catch (Exception e) {
	}
	String CompanyName="";
	String com_name="select Companyname from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
	ResultSet rs_cmpy=st7.executeQuery(com_name);
	while(rs_cmpy.next()){
		CompanyName=rs_cmpy.getString("Companyname");
	}
	System.out.println("Company Name DB"+CompanyName);
	NumberFormat nf = new DecimalFormat("#0.00");
	
	String oldgrn1="''",oldgrn="",CourierName="",DocketNo="",SenderPersonDetails="",Exp_date="",MaterialDetails="",OpenPolicyNo="";
	
	String sqlGrn="SElect * from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn where GRNno='"+grnno+"'";
	
	
	ResultSet rsGrn=st.executeQuery(sqlGrn);
	rsGrn.next();
	
	String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where pono='"+rsGrn.getString("PONo")+"'";
	ResultSet rspur=st2.executeQuery(sql);
	rspur.next();
	
	String sqlcheck="select grnno from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn where pono='"+rsGrn.getString("PONo")+"'and grnno not in ('"+grnno+"') and grnno < "+grnno+" ";
	ResultSet rscheck=st5.executeQuery(sqlcheck);
	while(rscheck.next()){
		oldgrn=rscheck.getString("grnno");
		oldgrn="'"+oldgrn+"'";
		oldgrn1=oldgrn1+","+oldgrn;
	}
	
	System.out.println("Old GRN no-->"+oldgrn1);
	
	String sqlcode="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+suppliercode+"'";
	ResultSet rscode=st1.executeQuery(sqlcode);
	rscode.next();
	String name=rscode.getString("SupplierName");
	
	
	OpenPolicyNo=rsGrn.getString("OpenPolicyNo");
	if(OpenPolicyNo==null) {
		OpenPolicyNo="-";
	}else{
		OpenPolicyNo=rsGrn.getString("OpenPolicyNo");
		
	}
	CourierName=rsGrn.getString("CourierName");
	if(CourierName==null) {
		CourierName="-";
	}else{
		CourierName=rsGrn.getString("CourierName");
		
	}
	DocketNo=rsGrn.getString("DocketNo");
	if(DocketNo==null) {
		DocketNo="-";
	}else{
		DocketNo=rsGrn.getString("DocketNo");
		
	}
	SenderPersonDetails=rsGrn.getString("SenderPersonDetails");
	if(SenderPersonDetails==null) {
		SenderPersonDetails="-";
	}else{
		SenderPersonDetails=rsGrn.getString("SenderPersonDetails");
		
	}
	Exp_date=rsGrn.getString("Exp_date");
	if(Exp_date==null) {
		Exp_date="-";
	}else{
		Exp_date=rsGrn.getString("Exp_date");

		Exp_date=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Exp_date));
		 //System.out.println("Exp_date-->"+Exp_date);
	}
	MaterialDetails=rsGrn.getString("MaterialDetails");
	if(MaterialDetails==null) {
		MaterialDetails="-";
	}else{
		MaterialDetails=rsGrn.getString("MaterialDetails");
		
	}
%>
<title><%=CompanyName %></title>
 <div align ="center" style="font-size: 1.5em; ">
<%=CompanyName %>
</div>
<br>
	<div align="center"
 		style="margin-top:0.3em; margin-bottom:0.3em; font-size: 1.5em;">
 	<a> Goods Receipt For PO No. : <%=rspur.getString("PONo") %> </a> </div>
 		
 	<!-- <table border="1px"  width="100%"  style="background-color: #F8F8FF;border-style: hidden;"> -->
 	<table border="1" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
 	<tr>
	<td style="border-style: inset;">GRN No:</td>
	<td><%=rsGrn.getString("grnno") %></td>
	<td>GRN Date:</td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsGrn.getString("grndate"))) %></td>
	</tr>
	<tr>
 	<td>PO No:</td>
	<td><%=rspur.getString("PONo") %></td>
	<td>PO Date:</td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rspur.getString("PODate"))) %></td>
	</tr>
	<tr>
	<td>Supplier Name:</td>
	<td><%=rscode.getString(1) %></td>
	<td>Ship Date : </td>
 	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsGrn.getString("ShipmentDate"))) %></td>
 	</tr>
	<tr>
 	<td>Supplier Order:</td>
 	<td><%=rsGrn.getString("SupOrderNo") %></td>
 	<td>Carrier : </td>
 	<td><%= rsGrn.getString("carrier")%></td>
 	</tr>
	
 	</table>
 	
  <div>&nbsp;&nbsp;</div>		
 	<table  border="1" cellpadding="0" cellspacing="0"  class="sortable" style="border-collapse:collapse;align:center; font:normal 13px Arial,Helvtica,sans-serif;">
 	<tr>
 	<th>Sr No</th>
 	<th>Group</th>
 	<th>Part No</th>
 	<th>Description</th>
 	<th>Ordered </th>
 	<th>Already Received</th>
 	<th>Received In This GRN</th>
 	<th>Balance</th>
 	<th>Rate</th>
 	</tr> 
<%
	
 	//String SqlgrnDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items WHERE GRNno='"+grnno+"' order by itemcode ";
	String SqlgrnDet=" select a.TheGroup,a.ItemCode,a.Make,a.ItemCode,a.OrderedQuantity,a.ShippedQuantity,a.ReceivedQuantity,a.TheTableToBeAccessed,b.UnitPrice from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items a LEFT OUTER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items b ON a.ItemCode=b.ItemCode where  PONo="+pono+" AND GRNno="+grnno+"";
	System.out.println("*******    &&&&&&&&&&&&&&    "+SqlgrnDet);
 	ResultSet rsgrndet=st4.executeQuery(SqlgrnDet);
	while(rsgrndet.next())
	{	
		groupName="";makeName="";refMakeNameTable="";
		groupCode=rsgrndet.getInt("TheGroup");
		makeCode=rsgrndet.getInt("Make");
		itemCode=rsgrndet.getString("ItemCode");
		  
		String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
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
			System.out.println("-1-"+sqlDisplayDesc);
		}
		else{
			sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
			System.out.println("--"+sqlDisplayDesc);
			makeName="-"  ;
		}
	
		ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
		
		if(rsDisplayDesc.next())
		{
			
			String alreadyrec="";
			String sql10="select Sum(ReceivedQuantity) as quantity from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items where grnno in ("+oldgrn1+") and grnno not in ("+grnno+") and ItemCode='"+itemCode+"' group by itemcode ";
			ResultSet rs10=st6.executeQuery(sql10);
			if(rs10.next()){
				alreadyrec=rs10.getString("quantity");
			}else
				alreadyrec="0";
%>

 <tr>
 		<td><div align="right"><%=i++ %></div></td>
 		<td><div align="left"><%=groupName %></div></td>		
		<td><div align="left"><%=rsDisplayDesc.getString("Partno") %></div></td>
		<td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
 		<td><div align="right"><%=((rsgrndet.getString("OrderedQuantity")!=null) ? rsgrndet.getString("OrderedQuantity") : "-")  %></div></td>
 		<td><div align="right"><%=alreadyrec%></div></td>
 		<td><div align="right"><%=((rsgrndet.getString("ReceivedQuantity")!=null) ? rsgrndet.getString("ReceivedQuantity") : "-")  %></div></td>
 		<td><div align="right"><%=((Integer.parseInt(rsgrndet.getString("OrderedQuantity")))-(Integer.parseInt(alreadyrec))-(Integer.parseInt(rsgrndet.getString("ReceivedQuantity"))))%></div></td>
 		<td style="text-align:right;"><%=rsgrndet.getString("UnitPrice") %></td>
 </tr>
 
<%
		}
		}
%>
 </table>			
 <br/>
<div style="font-size: 1.0em" align="left">
	<table>
	<tr>
	<td>Proforma Invoice :</td> 
 	<td><%=rsGrn.getString("ProformaInvoiceNo") %></td>
 	</tr>
 	
 	<tr>
	<td></>Supplier Order :</td>
 	<td><%=rsGrn.getString("SupOrderNo") %></td>
 	
 	
 	<tr>
	<td></>Total Invoice Value : </td>
 	<td><%=rsGrn.getString("TotalInvoiceValue") %></td>
 </tr>
 	
 	<tr>
 	<td></>Gross Weight :</td>
 	<td><%=rsGrn.getString("GrossWeight") %></td>
 	<!-- <td style="float:right;margin-left:83%;"><b></>Store Incharge Signature</b></td> -->
 	</tr>
 	<tr>
 <td>
	Open Policy :</td>
 	<td><%=OpenPolicyNo %></td>
 	<!-- <td style="float:left;margin-left:80%;">Name : </td> -->
 	</tr>
 	
 	<tr>
	<td>Total Assessable Value :</td>
 	<td><%=rsGrn.getString("TotalAssessableValue") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Courier Name :</td>
 	<td><%=CourierName %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Docket No :</td>
 	<td><%=DocketNo %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Sender Person Details :</td>
 	<td><%=SenderPersonDetails %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Specifications :</td>
 	<td><%=rsGrn.getString("Specifications") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Warranty :</td>
 	<td><%=rsGrn.getString("Warranty") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Expiry Date :</td>
 	<td><%=Exp_date%></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Material Name:</td>
 	<td><%=rsGrn.getString("MaterialName") %></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	<tr>
	<td>Material Details/UnitId's :</td>
 	<td><%=MaterialDetails%></td>
 	<!-- <td style="float:left;margin-left:80%;">Date :</td> -->
 	</tr>
 	</div>
 	</table>
<table style="float:right;margin-right:30px;margin-top:-110px;">

    <tbody >
        <tr>
        <td><b>Store Incharge Signature</b></td>
        </tr>
        <tr>
        <td>Name :______________________</td>
        </tr>
        <tr>
        <td>Date    :   ______________________</td>
        </tr>
        </tbody>
        </table>
<table style="float:right;margin-right:30px;margin-top: -10px;">

    <tbody>
        <tr>
        <td><b>QC Approval</b></td>
        </tr>
        <tr>
        <td>Name   :______________________</td>
        </tr>
        <tr>
        <td>Date      :  ______________________</td>
        </tr>
        </tbody>
        </table>
	<div align="center" style="margin-top: 3em;">
 	
 	<input type="submit" id="printGRN" name="printGRN" value="Print" onclick="printpage(); "  style="border: outset; background-color: #C6DEFF"  />
 	</div></div></br>
	</body>
	</html>
</jsp:useBean>
<%@ include file="footer_new.jsp"%>			