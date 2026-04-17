<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
     <%@page import="java.util.*" %>
     
     
<%@ include file="header.jsp"%>
  
 <html> 
<head>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 
 
 <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
 

	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        scrollY: 350,
	        scrollX: true,
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Supplier Master', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Supplier Master', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Supplier Master', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Supplier Master', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Supplier Master', 
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	     	
	    } );
	} );

</script>

	<script src="dropdown.js" type="text/javascript"></script>
<style>
div.dataTables_wrapper {
     /*    width: 1255px; */
        margin: 0 auto;
    }
</style>

	</head>
<body>

<%!
Connection conn=null;
%>

<%

Class.forName(DB_Driver);
conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
  
Statement st1=conn.createStatement();
%>
<br>
<table border="0" align="center" width="100%">
    <tr>
        <td align="center"><font color="black" size="3"><b>Supplier Master</b></font></td>
     </tr>
    <tr></tr>
    <tr></tr>
 </table>   
 <br>
 <table id="example"  class="display" style="width: 100%;">
	
			<thead>
				<tr>
	
						<th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SrNo</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SupplierCode</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SupplierName</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">ContactPerson</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Address</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Mobile</th>
				
	
				</tr>
			</thead>
			<tbody>
			<%
				try
				{
						int i=1;
						String SupplierCode="",SupplierName="",ContactPerson="",Address="",Mobile="";
						String sql="select SupplierCode,SupplierName,ContactPerson,Address,Mobile from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet order by SupplierCode desc limit 50";
						System.out.println("query " + sql);
						ResultSet rs1 = st1.executeQuery(sql);
						while (rs1.next()) 
						{
							SupplierCode=rs1.getString("SupplierCode");
							SupplierName=rs1.getString("SupplierName");
							ContactPerson=rs1.getString("ContactPerson");
							Address=rs1.getString("Address");
							Mobile=rs1.getString("Mobile");
										%>
	
			
				<tr>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="right"><%=i%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="right"><%=SupplierCode%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="left"><%=SupplierName%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="left"><%=ContactPerson%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="left"><%=Address%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="right"><%=Mobile%></td>
				
						<%
							i++;
										}
									} catch (Exception e) {
										System.out.println(e);
									}
						%>
						
					</tr>
				</tbody>
			<tfoot>
				<tr>
	
				<th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SrNo</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SupplierCode</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SupplierName</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">ContactPerson</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Address</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Mobile</th>
				

				</tr>
				
			</tfoot>
			

		
			
	</table>
	
 </body>
     </html>      
   
 
 <%@ include file="footer_new.jsp"%>   
                    