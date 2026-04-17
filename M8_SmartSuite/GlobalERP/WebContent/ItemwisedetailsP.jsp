<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

 <html>
 <head>
 
 
<script language="JavaScript1.2">





function showExcel()
{
	
	var todate=document.getElementById("todate").value;
	var fromdate=document.getElementById("fromdate").value;
	
	window.open("exportItemP.jsp?todate="+todate+"&fromdate="+fromdate);
}




</script>
</head>
                                 	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();

	st4 = conn.createStatement();

	st5 = conn.createStatement();


    String selectedName;
	String FollowUpType="",status="";
	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";
%>

<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	
	
	
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	String currentdate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date());

	if (!(null == request.getParameter("fromdate"))) 
	{
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	
%>

<body>

<form name="Enquiry1"  method="post">

	

	<div style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<font face="Arial" size="3" color="black">Purchase Order Report</font>
	
	
	</div>



	<div align="center">
	<table border="0">
	<tr> 
	
	
     
	<td align="left">
	<b> </b>&nbsp;&nbsp;
	<input type="text" id="fromdate"
	name="fromdate" value="<%=fromDateCal %>" size="15" readonly
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
			
	<font face="Arial" size="2" color="black"><b>To </b></font>&nbsp;&nbsp;
	<input type="text" id="todate"
	name="todate" value="<%=toDateCal %>" size="15" readonly
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
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" /></td>
	</tr>
	</table></div>
		<div align="center">
	
	<table width="100%" border="0" >
	<tr>
	<td align="right"><a href="#" onclick="window.print();return true;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>&nbsp;
	<a id="excel" href="#" onclick="showExcel();" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;<%=currentdate %>
	
	
	</td>

	</tr>
	
	</table></div>
	<div style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<font face="Arial" size="3" color="black">Purchase Order Report From <%=fromDateCal %> To <%=toDateCal %> </font>
	
	
	</div>
	
	
	
   
	<table class="sortable" align="center" width="90%" style="font: Arial, Helvetica, sans-serif; color: #ffffff;" >
		<tr>
		    <th style="height: 20px">Sr No</th>
		    <th>PO No.</th>
		    <th>Date</th>
		    <th>Supplier</th>
			<th>Item</th>
			<th>Part No </th>
			<th>Make</th>
			<th>Model</th>
			<th>Quantity</th>
			<th>Price</th>
 
		</tr>
 		<%
 		try{
		String PurOrderNumber="",SupplierName="",Total="",GrandTotal="",TotalInWords="",Terms="",sqlDisplayDesc="";
 		int k=1;
	String sqlPurchase = "SELECT * FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PODate between '"+fromDate+"' and '"+toDate+"'  Order by a.PODate Desc ";
	ResultSet rsTransaction = st5.executeQuery(sqlPurchase);
	
	while (rsTransaction.next()) 
	{
		SupplierName=rsTransaction.getString("SupplierName");		
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODueDate")));
				} catch (Exception e) {
				}
				String DelvDate = "NA";
				try {
					DelvDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DeliveryDate")));
				} catch (Exception e) 
				{
				}
				PurOrderNumber=rsTransaction.getString("PONo");
				Total=rsTransaction.getString("Total");
				
%>

	
	

	<%
	try{
	int i=1;
	String refMakeNameTable="";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items WHERE PONo ='"+ PurOrderNumber + "'  ";
	
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				while (rsPurDet.next())
				{
						String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
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
						{
						  
						 
						
						
	%>
		<tr>
							<td align="right"><div align="right"><%=k++%></div></td>
							<td align="right"><div align="right"><%=rsTransaction.getString("PONo")%></div></td>
							
							<td align="right" sorttable_customkey="20080211131900"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODate")))%></div></td>
							
							
	
					
							<td align="left"><div align="left"><%=rsTransaction.getString("SupplierName")%></div></td>
							
							<td align="left"><div align="left"><%=rsSql.getString("Description")%></div></td>
							<td align="left"> <div align="left"><%=rsSql.getString("Partno")%></div></td>
							<td align="left"><div align="left"><%=makeName %></div></td>
							<td align="left"><div align="left"><%=rsSql.getString("Model")%></div></td>
							<td align="right"><div align="right"><%=quantity%></div></td>
							<td align="right"><div align="right"><%=rsPurDet.getString("UnitPrice")%></div></td>
				 	
<%
						}
								}
				
	}catch(Exception e)
	{
		e.printStackTrace();
	}
		
			
	}
 		}catch(Exception e)
 		{
 			e.printStackTrace();
 		}
	%>

	</tr>
			</table></form>
		

</body>
<br></br>
<br></br>
<!--  <div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!--   </div> -->
</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>