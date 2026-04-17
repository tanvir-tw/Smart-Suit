 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
  <%@ page import="java.util.Date"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
 <body style="background-color:azure;">

<%
String ItemDescription="";
int InvoiceNo=0,ItemCode=0,Quantity=0,SellingPrice=0,SACCode=0;
double CGSTRate=0,CGSTValue=0,SGSTRate=0,SGSTValue=0,IGSTRate=0,IGSTValue=0;
NumberFormat formatter = new DecimalFormat("#0.00");    

String invoiceno=request.getParameter("InvoiceNo");
String Invoicerefno=request.getParameter("InvoicerefNo");
String companyid=session.getAttribute("CompanyMasterID").toString();

Connection conn = null;
Statement st1=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 

try{
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Item Description Of InvoiceRefNo <%=Invoicerefno%></h5>
    </div>
</div>
<input type="hidden" id="Invoicerefno" name="Invoicerefno" value="<%=Invoicerefno%>">

<br>
<table id="example"  class="display" style="width:100%"> 
<thead>
<tr>
	<th class="col-width-4">SrNo.</th>
	<th>InvoiceNo</th>
	<th>ItemCode</th>
	<th>Quantity</th>
	<th>SellingPrice</th>
	<th>ItemDescription</th>
	<th>SACCode</th>
	<th>CGSTRate</th>
	<th>CGSTValue</th>
	<th>SGSTRate</th>
	<th>SGSTValue</th>
	<th>IGSTRate</th>
	<th>IGSTValue</th>
</tr>
</thead>
<tbody>
		<%
		String Query="Select InvoiceNo,ItemCode,Quantity,SellingPrice,ItemDescription,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue from db_GlobalERP."+companyid+"salesinv_items where invoiceno='"+invoiceno+"' ";
		System.out.println("Query :-"+Query);
			
			ResultSet rs=st.executeQuery(Query);
			
			int i=1;
			while(rs.next())
				{
				InvoiceNo=rs.getInt("InvoiceNo");
				ItemCode=rs.getInt("ItemCode");
				Quantity=rs.getInt("Quantity");
				SellingPrice=rs.getInt("SellingPrice");
				ItemDescription=rs.getString("ItemDescription");
				SACCode=rs.getInt("SACCode");
				CGSTRate=rs.getDouble("CGSTRate");
				CGSTValue=rs.getDouble("CGSTValue");
				SGSTRate=rs.getDouble("SGSTRate");
				SGSTValue=rs.getDouble("SGSTValue");
				IGSTRate=rs.getDouble("IGSTRate");
				IGSTValue=rs.getDouble("IGSTValue");
		%>
		<tr>
				<td class="text-center"><%=i%></td>
                <td class="text-center"><%=InvoiceNo%></td>
               	<td class="text-center"><%=ItemCode%></td> 
                <td class="text-center"><%=Quantity%></td>
                <td class="text-center"><%=SellingPrice%></td>
                <td class="text-left"><%=ItemDescription%></td>
                <td class="text-center"><%=SACCode%></td>
                <td class="text-center"><%=formatter.format(CGSTRate)%></td>
                <td class="text-center"><%=formatter.format(CGSTValue)%></td>
                <td class="text-center"><%=formatter.format(SGSTRate)%></td>
                <td class="text-center"><%=formatter.format(SGSTValue)%></td>
                <td class="text-center"><%=formatter.format(IGSTRate)%></td> 
               <td class="text-center"><%=formatter.format(IGSTValue)%></td>
				</tr>
				<%
			i++;
				} 
%>
</tbody>
</table>
</div>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%> 

  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
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
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: ' Item Description of InvoiceRefNo '+$("#Invoicerefno").val() ,
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: ' Item Description of InvoiceRefNo '+$("#Invoicerefno").val() ,
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: ' Item Description of InvoiceRefNo '+$("#Invoicerefno").val() ,
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: ' Item Description of InvoiceRefNo '+$("#Invoicerefno").val() ,
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: ' Item Description of InvoiceRefNo '+$("#Invoicerefno").val() ,
	                     
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>       
 <%@ include file="footer.jsp" %>
 </body>
</html>