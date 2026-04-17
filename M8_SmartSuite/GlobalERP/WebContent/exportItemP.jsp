<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>
<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename;
 filename="PurchaseOrder_Item.xls";
 response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<html>
<head></head>
<%!
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");

Connection conn = null;
Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
Statement st2 = null;
%>
                                	                                                                                                              
<%
try{
String DB_Driver="com.mysql.cj.jdbc.Driver";
   //String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
   //String DB_NAME="jdbc:mysql:// twdb.fleetview.in/db_GlobalERP";
   String DB_NAME="jdbc:mysql://"+host+"/db_GlobalERP";

String DB_USERNAME=user;
String DB_PASSWORD=pass;
//String DB_NAMEPAY="jdbc:mysql://10.0.10.62:3306/db_leaveapplication";



	conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

	st=conn.createStatement();
	
	st1 = conn.createStatement();
	st3 = conn.createStatement();

	st4 = conn.createStatement();

	st5 = conn.createStatement();

	
}catch(Exception e)
{
	e.printStackTrace();
}

    
%>
<%
try{

String selectedName;
	String FollowUpType="",status="";
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";

	
 
	if (!(null == request.getParameter("fromdate"))) 
	{
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	System.out.println("From date is " +fromDate);
	System.out.println("From date is " +toDate);

%>

<body>


	

	<div style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<font face="Arial" size="2" color="black">Purchase Order Report From <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate)) %> To <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate)) %> </font>
	
	
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
	String sqlPurchase = "SELECT * FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PODate between '"+fromDate+"' and '"+toDate+"'  Order by a.PONo,a.PODate Desc ";
	ResultSet rsTransaction = st5.executeQuery(sqlPurchase);
	System.out.println("Main query is " +sqlPurchase );
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
							
							<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODate")))%></div></td>
							
							
	
					
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
}catch(Exception e)
{
	e.printStackTrace();
}
	%>

	</tr>
			</table>
		

</body>

</html>
