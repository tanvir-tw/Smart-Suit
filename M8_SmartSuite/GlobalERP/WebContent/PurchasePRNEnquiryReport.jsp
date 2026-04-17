<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="header.jsp" %>
    <%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$('#PRNEnquiryReport')
								.DataTable(
										{
											"pagingType" : "full_numbers",

											dom : 'Blfrtip',
											scrollY : 350,
											scrollX : true,
											buttons : [

											{
												extend : 'collection',

												text : 'Export',
												buttons : [
														{
															extend : 'excel',
															title : 'Purchase PRN Enquiry Report',
														},
														{
															extend : 'pdf',
															orientation : 'landscape',
															pageSize : 'LEGAL',
															title : 'Purchase PRN Enquiry Report',
														},
														{
															extend : 'csv',
															title : 'Purchase PRN Enquiry Report',
														},
														{
															extend : 'print',
															title : 'Purchase PRN Enquiry Report',
														},
														{
															extend : 'copy',
															title : 'Enquiry Report',
														},

												/* 'copy', 'csv', 'excel', 'pdf', 'print' */
												]
											} ],
											lengthMenu : [
													[ -1, 10, 25, 50, 100 ],
													[ "All", 10, 25, 50, 100 ] ],

										});
					});
</script>

</head>
<body>
<jsp:useBean id="ERP" class="com.erp.beans.ERP" scope="page">
<%
ERP.getConnection(DB_Driver,DB_NAME,DB_USERNAME,DB_PASSWORD);
Connection conn;
try{
conn=ERP.ReturnConnection();

System.out.println("connection status:"+conn);
Statement st1=conn.createStatement();
Statement st2=conn.createStatement();

String Sesrole1 = session.getAttribute("role").toString();
String comid = session.getAttribute("CompanyMasterID").toString();

String PurEnqNo = request.getParameter("RefNo").toString();
String PRN_RefNo = request.getParameter("PRN_RefNo").toString();
String PRNNo = request.getParameter("PRNNo").toString();


String SupCode="",SupName="",TWRefNo="",Quantity="",EntryBy="",SentBy="",ItemName="";
String PEnqDate="",PEnqTime="",PEnqDateTime="";


%>
<table border="0" align="center" width="100%">
			<tr>
				<td align="center"><font color="#1582AB" size="4"><b>Purchase Enquiry Report </b></font></td>
			</tr>
</table>

<table id="PRNEnquiryReport" class="display" style="width: 100%">
<thead>
<tr>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Sr No</th>
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Pur Enq No</th><!-- PRNItemMaster and purchaseenq -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">PRN Ref No</th><!-- PRNItemMaster  -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">PRN No</th><!-- PRNItemMaster  -->

<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">TW Ref No</th><!-- purchaseenq  -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Description</th><!-- PRNItemMaster  -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Quantity</th><!-- PRNItemMaster  -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Supplier</th><!-- purchaseenq and supplierdet -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">PRN EntryBy</th><!--  ItemMaster  -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Sent By</th><!--  purchaseenq  -->
<th style="font-size: 11px; background: #1582AB; color: white; face: san-serif;">Sent Date Time</th><!--  purchaseenq  -->
</tr>
</thead>
<tbody>
<%
int row=1;

String sql1 = "select a.PRN_RefNo,a.PRNNo,b.TWRefNo,a.ItemDescription,a.Quantity,b.Suppliercode,a.EntryBy,b.SentBy,b.PurEnqDate,b.PurEnqTime from db_GlobalERP."+comid+"PRNItemMaster a INNER JOIN db_GlobalERP."+comid+"purchaseenq b ON (a.Purchase_RefNo=b.PurchaseEnqNo) where a.Purchase_RefNo='"+PurEnqNo+"' and a.PRNNo='"+PRNNo+"'";
System.out.println("PurchaseEnquiryQuery------>"+sql1);
ResultSet rs1 = st1.executeQuery(sql1);
while(rs1.next()){
	
	
	TWRefNo = rs1.getString("TWRefNo");
	SupCode = rs1.getString("SupplierCode");
	ItemName = rs1.getString("ItemDescription");
	Quantity = rs1.getString("Quantity");
	EntryBy = rs1.getString("EntryBy");
	SentBy = rs1.getString("SentBy");
	PEnqDate = rs1.getString("PurEnqDate");
	PEnqTime = rs1.getString("PurEnqTime");
	
	
	PEnqDateTime = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(PEnqDate))+" "+PEnqTime;
	
	String sql2="select SupplierName from db_GlobalERP."+comid+"supplierdet where SupplierCode='"+SupCode+"'";
	System.out.println("SupplierQuery------>"+sql1);
	ResultSet rs2=st2.executeQuery(sql2);
	if(rs2.next()){
		SupName = rs2.getString("SupplierName");
	}
	
	
%>
<tr>
	<td style="font-size: 13px; face: san-serif; color: black" align="right"><%=row%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="right"><%=PurEnqNo%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="right"><%=PRN_RefNo%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="right"><%=PRNNo%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="left"><%=TWRefNo%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="left"><%=ItemName%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="right"><%=Quantity%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="right"><%=SupName%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="left"><%=EntryBy%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="left"><%=SentBy%></td>
	<td style="font-size: 13px; face: san-serif; color: black" align="left"><%=PEnqDateTime%></td>
</tr>	
<%	
row++;
}
%>
</tbody>
</table>

<%
}catch(Exception e){
	e.printStackTrace();
}finally{
	ERP.closeConnection();
}
%>
</jsp:useBean>
</body>
</html>