<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="icon" type="image/png" href="images/favicon.png">
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">

<%
Connection conn = null;
Statement st1 = null,st2=null;
try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
    st2=conn.createStatement();
     
} catch (Exception e) {
    e.printStackTrace();
} 

try{
String advid=request.getParameter("id");
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Advance Expense Details</h5>
    </div>
</div>
<br>
<table id="example" class="display" style= "width: 100%">  
<thead>
	<tr>
		<th width="4%">SrNo.</th>
		<th>AdvanceId</th>
		<th>TypeOfExpense</th>
		<th>Mode</th>
		<th>Origin</th>
		<th>Destination</th>
		<th>DepartureDate</th>
		<th>ReturnDate</th>
		<th>Amount</th>
	
	</tr>
</thead>
<tbody>
<%
String d1="",d2="";
String query="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where AdvanceId='"+advid+"'";
ResultSet rs1=st2.executeQuery(query);
if(rs1.next())
{
Date	deptDate=rs1.getDate("DepartureDate");
Date	returnDate=rs1.getDate("ReturnDate");
d1=new SimpleDateFormat("dd-MMM-yyyy").format(deptDate);
d2=new SimpleDateFormat("dd-MMM-yyyy").format(returnDate);
}

String query1="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceExpenseDetail where AdvanceId='"+advid+"'";
System.out.println(query1);
int i=1;
ResultSet rs=st1.executeQuery(query1);
String AdvanceId="",TypeOfExpense=null,origin=null,Destination=null,Mode=null;
while(rs.next())
{
	 double d3=rs.getDouble("Amount");
	String amount=new DecimalFormat("0.00").format(d3);
	AdvanceId =rs.getString("AdvanceId");
	TypeOfExpense =rs.getString("TypeOfExpense");
	Mode =rs.getString("Mode");
	origin =rs.getString("origin");
	Destination =rs.getString("Destination");
%>
<tr>
	<td class="text-center"><%=i%></td>
	<td  class="text-right"><%=AdvanceId%></td>
	<td  class="text-left"><%=TypeOfExpense %></td>
	<td  class="text-left"><%=Mode %></td>
	<td  class="text-left"><%=origin %></td>
	<td  class="text-left"><%=Destination %></td>
	<td  class="text-right"><%=d1 %></td>
	<td  class="text-right"><%=d2 %></td>
	<td  class="text-right"><%=amount%></td>

</tr>
<%

	i++;
}
%>
</tbody>
</table>
</div>
<%}catch(Exception e) {
	e.printStackTrace();
}
%>

  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary',
					 text:'Export',
					 orientation: 'Portrait',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Advance Expense Details',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	                         title: 'Advance Expense Details',
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Advance Claim Report  ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	                         title: 'Advance Expense Details',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Advance Expense Details',
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>