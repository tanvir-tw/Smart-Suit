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
	                        title: 'Item Master', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Item Master', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Item Master',
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Item Master',
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Item Master',
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50,100], ["All", 10, 25, 50, 100 ]],
	     	
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
        <td align="center"><font color="black" size="3"><b>Item Master</b></font></td>
     </tr>
    <tr></tr>
    <tr></tr>
 </table>   
 <br>
 <table id="example"  class="display" style="width: 100%;">
	
			<thead>
				<tr>
	
						<th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SrNo</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">ItemCode</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GroupName</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">MakeName</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Model</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PartNo</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Description</th>                                                                             
				
	
				</tr>
			</thead>
			<tbody>
			<%
				try
				{
						int i=1;
						String ItemCode="",GroupName="",MakeName="",Model="",PartNo="",Description="";
						String sql="select ItemCode,GroupName,makename,Model,PartNo,Description from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"searchitems order by ItemCode desc limit 50";   
						System.out.println("query " + sql);
						ResultSet rs1 = st1.executeQuery(sql);
						while (rs1.next()) 
						{
							ItemCode=rs1.getString("ItemCode");
							GroupName=rs1.getString("GroupName");
							MakeName=rs1.getString("MakeName");
							Model=rs1.getString("Model");
							PartNo=rs1.getString("PartNo");
							Description=rs1.getString("Description");
										%>
	
			
				<tr>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="right"><%=i%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="right"><%=ItemCode%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="left"><%=GroupName%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="left"><%=MakeName%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="left"><%=Model%></td>
						<td style="font-size: 11px; face:san-serif; color:black"
						align="right"><%=PartNo%></td>
						<td style="font-size: 11px; face:san-serif; color:black;
						 word-wrap:break-word; width:40%;" align="left"><%=Description%></td>
										
				
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
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">ItemCode</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GroupName</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">MakeName</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Model</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PartNo</th>
						<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Description</th>    
	
				</tr>
				
			</tfoot>	
			
	</table>
	
 </body>
     </html>      
   
 
 <%@ include file="footer_new.jsp"%>   
                    