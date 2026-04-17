 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
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
          <h5 class="content-header-title text-center mb-0" style="color: #060637">ASC Pending Invoice Report</h5>
    </div>
</div>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
             <th>View</th>
            <th>Create</th>
            <th>Delete</th>
            <th>Customer</th>
            <th>Customer Code</th>
            <th>ASCFromDate</th>
            <th>ASCToDate</th>
            <th>InvoiceNumber</th>
             <th>InvoiceStatus</th>
            <th>EnrtyDate</th>
            <th>UpdatedDate</th>
            <th>EntryBy</th>          
            </tr>
         </thead>
         <tbody>
         <%
         
        String Customer="", CustomerCode="",ComputedTotal="", GrandTotal="",ASCFromDate="",ASCToDate="", InvoiceNumber="", InvoiceStatus="", EnrtyDate="",UpdatedDate="", EntryBy="",SRNumber="";
 		int i=1;
 		
         String sql ="select SRNumber,Ownername,CustomerCode,Date_Format(AmcFromDate,'%d-%b-%Y') as AmcFromDate,Date_Format(AmcToDate,'%d-%b-%Y') as AmcToDate,InvoiceNumber,InvoiceStatus,Date_Format(EnrtyDate,'%d-%b-%Y %T' ) as EnrtyDate,Date_Format(UpdatedDate,'%d-%b-%Y %T') as UpdatedDate,EntryBy,ComputedTotal,GrandTotal from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails where InvoiceStatus !='Deleted' order by InvoiceStatus desc";
     	System.out.println(sql);			
     	ResultSet rs=st1.executeQuery(sql);
   
     	while(rs.next()){ 
     		SRNumber = rs.getString("SRNumber");
     		Customer = rs.getString("Ownername");
     		CustomerCode = rs.getString("CustomerCode");
     		ASCFromDate= rs.getString("AmcFromDate");
     		ASCToDate= rs.getString("AmcToDate");
     		InvoiceNumber= rs.getString("InvoiceNumber");
     		InvoiceStatus= rs.getString("InvoiceStatus");
     		EnrtyDate= rs.getString("EnrtyDate");
     		UpdatedDate= rs.getString("UpdatedDate");
     		EntryBy= rs.getString("EntryBy");
     		ComputedTotal= rs.getString("ComputedTotal");
     	//	System.out.println("ComputedTotal Totalllllllllllllllll"+ComputedTotal);
     		GrandTotal= rs.getString("GrandTotal");
     		
         %>
        <tr> 
 		<td class="text-center"><%=i%></td>
		<td class="text-left">
		<a href="ASCView.jsp?company=<%=Customer%>&Id=<%=SRNumber%>&Invoiceno=<%=InvoiceNumber%>" target="_blank">View</a>
		</td>
        <td class="text-left">
		<a href="ASCInvoiceConfirm.jsp?company=<%=Customer%>&Id=<%=SRNumber%>&Total=<%=ComputedTotal%>&GrandTotal=<%=GrandTotal%>&InvoiceStatus=<%=InvoiceStatus%>" target="_blank">Create</a>
		</td>
		
        <td class="text-left">
		<a href="ASCSummaryDeleteConfirm.jsp?company=<%=Customer%>&Id=<%=SRNumber%>&ASCFrom=<%=ASCFromDate%>&ASCTo=<%=ASCToDate%>" target="_blank">Delete</a>
		</td>
        <td class="text-left"><%=Customer%></td>
        <td class="text-center"><%=CustomerCode%></td>
        <td class="text-right"><%=ASCFromDate%></td>
        <td class="text-right"><%=ASCToDate%></td>
        <td class="text-center"><%=InvoiceNumber%></td>
        <td class="text-left"><%=InvoiceStatus%></td>
        <td class="text-right"><%=EnrtyDate%></td>
        <td class="text-right"><%=UpdatedDate%></td>
        <td class="text-left"><%=EntryBy%></td>

  </tr>
       
          <%i++;} %>
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
		                        title : 'ASC Pending Invoice Report',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'ASC Pending Invoice Report',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title : 'ASC Pending Invoice Report',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title : 'ASC Pending Invoice Report',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title : 'ASC Pending Invoice Report',
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