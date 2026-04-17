 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<%@page import="com.ConnectionClass"%>
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
 Connection con = null;
Statement stmt=null,st1=null, st2=null,st3=null;
String sql="",SqlDisplay="";
ResultSet rst=null;
int i=1;
try {
	 ConnectionClass connObj = new ConnectionClass();
	con = connObj.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+con);
	stmt = con.createStatement();
	st1 = con.createStatement();
	st2 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
		          		<h5 class="content-header-title text-center mb-0" style="color: #060637">Bill Details For Inward RefNo:<%=request.getParameter("refno") %></h5>
    </div>
</div>
 <br>
<table id="example" class="display" style="width:100%;">
<thead>
<tr>
<th>SrNo.</th>
<th>Inward No.</th>
<th>Paid Amount</th>
<th>Paid By</th>
<th>Check/Bill No</th>
<th>Date Of Payment</th>
<th>EnteredBy</th>
<th>EnteredDate-Time</th>
</tr>
</thead>
<tbody>
        <%
        try {
            SqlDisplay = "Select * from db_leaveapplication.t_billpayment where InwardNo='" + request.getParameter("refno") + "'";
            System.out.println(">>>>>>>SqlDisplay:" + SqlDisplay);
            rst = stmt.executeQuery(SqlDisplay); // Changed 'st' to 'stmt' to match declaration
            
            SimpleDateFormat inputDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat outputDate = new SimpleDateFormat("dd-MMM-yyyy");
            SimpleDateFormat inputDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat outputDateTime = new SimpleDateFormat("dd-MMM-yyyy HH:mm");

            while(rst.next()) {
                String inwardNo = rst.getString("InwardNo");
                String paidAmount = rst.getString("PaidAmount");
                String paidBy = rst.getString("PaidBy");
                String checkNo = rst.getString("CheckNo");
                String rawDate = rst.getString("DateOfPayment");
                String enteredBy = rst.getString("EnterBy");
                String rawDateTime = rst.getString("EnteredDateTime");

                // Format the dates
                String formattedDate = outputDate.format(inputDate.parse(rawDate));
                String formattedDateTime = outputDateTime.format(inputDateTime.parse(rawDateTime));
        %>
            <tr>
                <td class="text-center"><%= i %></td>
                <td class="text-center"><%= inwardNo %></td>
                <td class="text-center"><%= paidAmount %></td>
                <td class="text-left"><%= paidBy %></td>
                <td class="text-center"><%= checkNo %></td>
                <td class="text-right"><%= formattedDate %></td>
                <td class="text-left"><%= enteredBy %></td>
                <td class="text-right"><%= formattedDateTime %></td>
            </tr>
        <%
                i++;
            }
        } catch(Exception e) {
            System.out.println(">>>>>>>Exception in Display Query:" + e);
        }      
        %>
        </tbody>
            </table>
            
</div>


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
	         fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
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
								title: 'Bill Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Bill Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Bill Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Bill Report ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Bill Report ',
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