<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>
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

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	<script language="javascript">
	function gotoPrint(divName)  
	{  
		  var printContents = document.getElementById(divName).innerHTML; 
		  var originalContents = document.body.innerHTML; 
		  document.body.innerHTML = printContents;  
		  window.print();
		  document.body.innerHTML = originalContents;  
	}
	</script>
	</head>
	<body>
		<%
			erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
			Connection conn = null;
			Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, pst = null;
			String todaysDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
						.format(new java.util.Date());
				String todaysTime = new SimpleDateFormat(" HH:mm:ss")
						.format(new java.util.Date());
			NumberFormat nf = new DecimalFormat("#0.00");
			NumberFormat nf1=NumberFormat.getInstance();
			nf1.setMaximumFractionDigits(2);
			nf1.setMinimumFractionDigits(2);
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				pst = conn.createStatement();
			} catch (Exception e) {
			}
			
			String PurInvoiceNumber=request.getParameter("PurInvoiceNumber");
			System.out.println("PurInvoiceNumber    "+PurInvoiceNumber);
			String SqlEnqDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice WHERE PurInvoiceNo='"+PurInvoiceNumber+"' ";
			System.out.println(">>>>>>>>>>>      " + SqlEnqDet);
			ResultSet rsEnqDet = st4.executeQuery(SqlEnqDet);
			if (rsEnqDet.next()) {
				
				String suppliercode=rsEnqDet.getString("SupplierCode");	
				String total=rsEnqDet.getString("Total");
				String grandtot=rsEnqDet.getString("GrandTotal");
				String totalwords=rsEnqDet.getString("TotalinWords");
				String termsconditions=rsEnqDet.getString("Terms");
				String PurInvoiceDate=rsEnqDet.getString("PurInvoiceDate");

			
			String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+suppliercode+"'";	
			ResultSet rssql=st.executeQuery(sql);
			rssql.next();
			String suppliername=rssql.getString("SupplierName");
			String add=rssql.getString("Address");
			String stat=rssql.getString("State");
			String count=rssql.getString("Country");
			String zip=rssql.getString("Zip");
			String contact=rssql.getString("ContactPerson");
			String phn=rssql.getString("Phone");
			String fx=rssql.getString("Fax");
			String mail=rssql.getString("Email");
			
			%>
			<table style="font-size:small;"  width="100%"  cellspacing="0" cellpadding="0">
	    	<tr>
			<%
			String companydata="select * from "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet where OurCompanyCode='1' ";
			ResultSet rsdata=st.executeQuery(companydata);
			rsdata.next();
			String companyname=rsdata.getString("OurCompanyName");
			String address=rsdata.getString("OurCompanyAddress");
			String phone=rsdata.getString("PhoneNo");
			String email=rsdata.getString("Puremail");
			String website=rsdata.getString("Website");
			String fax=rsdata.getString("FaxNo");
			%>
		
		
			<td><img src="DatabaseAccess?id=<%=session.getAttribute("CompanyMasterID").toString() %>" align="left" height="50" width="200"></img></td>
			<td style="font-size: small; " align="center"  >
			<b><%=companyname %></b><br>
			<%=address %><br>
			<%=phone %>   <%=fax %><br>
			<%=email %>    <%=website %></td>
			<td>
		    <pre>                                </pre>
			</td>
			</tr>
			</table>

			<br>
			 <div align="center" style="font-size: 3;"><b> Purchase Invoice No:<%=PurInvoiceNumber%></b></div>
			 <br></br>
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
			<td>
			From,<br></br>
			<%=suppliername %><br></br>
			<%=add %><br></br>
			Kind Attn:<%=contact %><br></br>
			Phone No:<%=phn%><br></br>
			Email:<%=mail%><br></br>
			Fax:<%=fx%><br></br>
			</td>
			<td>
			Purchase Invoice Details:<br></br>
			Purchase Invoice No : <%=PurInvoiceNumber%><br></br>
			PI Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(PurInvoiceDate))%><br></br>
			</td>
			</tr>
			</table>
			<br>
			<!-- <div align="left" style="font-size:2;">
			Dear Sir,<br>
			We request you to please deliver us the following:-
			
			</div> -->
		<br></br>
			<table border="1" style="border-spacing: 0px;font-size:3;" class="sortable">
			<tr style="border-spacing: 0px">
			<th>Sr. No</th>
			<th style="width: 400px;">Desc</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Selling Price</th>
			<th>Price Entered On</th>
			
			</tr>
		<%
			System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPpppp");
			int i=1;
			String refMakeNameTable="",sqlDisplayDesc="";
			String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items WHERE PurInvoiceNo ='"+ PurInvoiceNumber + "'  ";
		
					ResultSet rsPurDet = st.executeQuery(sqlPurDet);
					System.out.println("****************             "+sqlPurDet);
					while (rsPurDet.next()) {
							String makeCode = "", itemCode = "",  quantity, makeName = "",groupName="";
							int groupCode=0;
							makeCode = rsPurDet.getString("Make");
							itemCode = rsPurDet.getString("ItemCode");
							groupCode = rsPurDet.getInt("TheGroup");
							quantity = rsPurDet.getString("Quantity");
		
							
							String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
							ResultSet rsGroup = st1.executeQuery(Groupsql);
							System.out.println(">>>>>>>>>>>          "+Groupsql );
							if(rsGroup.next()) 
							{
								groupName=rsGroup.getString("TheGroupName");
							}
							if(groupCode<5)
							{
								refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
								   	  	
								String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
								ResultSet rsMakeName=st3.executeQuery(sqlMakename);
								System.out.println("********>>>>            "+sqlMakename );
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
							ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
							System.out.println("********>>>>            "+sqlDisplayDesc);
							while(rsSql.next())
							{%>
			<tr>
			<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td><div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td><div align="right"><%=rsPurDet.getString("UnitPrice")%></div></td>
							<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsSql.getString("EnteredonDate")))%></div></td>
			</tr>
			<%}
			}%>
			
			</table>
		<br></br><br></br>
			<div align="left"   style="font-size:3;"><b> TERMS & CONDITIONS :</b><br>
			<textarea readonly="readonly" name="termsconditions"  
			id="search-text" style="border:none; width:90%; height:350px ;font-size:2;"><%=termsconditions%></textarea></div>
			<br>
			
			<br>
			
			<div align="right" style="font-size:2;">
		   <%=companyname %>
			<br>
		<br> 
			( Authorsied Signatory )
			
			</div>
			
			<%}%>
			</body>
				</html>
			</jsp:useBean>