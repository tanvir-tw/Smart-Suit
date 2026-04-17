 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*" import="java.util.Date"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<style>
    #delete {
    text-decoration: none;
    font-size: inherit;
    font-weight: bold;
    }
</style>
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
String UserTypeCode="",UserType="",AccessCode="",SuperAdmin1="",Admin1="",Sales1="",Purchase1="",Claim1="",Account1="";
String Collection1="",SalesAdmin1="",PurchaseAdmin1="",ClaimAdmin1="",AccountAdmin1="",CollectionAdmin1="",HRModule1="";
int i=1;

// Connection Initialization
Connection conn = null;
Statement st1 = null;

try {
	conn = connection.getConnect("db_GlobalERP"); 
	st1 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">User Access Control Report</h5>
    </div>
</div>

	<a href="AddNewUAC.jsp" style="text-decoration:none;"><b>Add New</b></a>
	
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
              <th class="col-width-4">SrNo</th>
              <th>UserTypeCode</th>
              <th>UserType</th>
              <th>AccessCode</th>
              <th>SuperAdmin</th>
              <th>Admin</th>
              <th>Sales</th>
              <th>Purchase</th>
              <th>Claim</th>
              <th>Account</th>
              <th>Collection</th>
              <th>SalesAdmin</th>
              <th>PurchaseAdmin</th>
              <th>ClaimAdmin</th>
              <th>AccountAdmin</th>
              <th>CollectionAdmin</th>
              <th>HRModule</th>
            </tr>
        </thead> 
        <tbody>

<% 
String query="select * from db_GlobalERP.UserTypeMaster a inner join db_GlobalERP.AccesControlList b on (a.AccessCode=b.AccessCode)"; 
System.out.println("query-------->"+query);
ResultSet rs=st.executeQuery(query);
while(rs.next())
{
	 UserTypeCode=rs.getString("UserTypeCode");
	 UserType=rs.getString("UserType");
	 AccessCode=rs.getString("AccessCode");
	 SuperAdmin=rs.getString("SuperAdmin");
	 Admin=rs.getString("Admin");
	 Sales=rs.getString("Sales");
	 Purchase=rs.getString("Purchase");
	 Claim=rs.getString("Claim");
	 Account=rs.getString("Account"); 
	 Collection=rs.getString("Collection");
	 SalesAdmin=rs.getString("SalesAdmin");
	 PurchaseAdmin=rs.getString("PurchaseAdmin");
	 ClaimAdmin=rs.getString("ClaimAdmin");
	 AccountAdmin=rs.getString("AccountAdmin");
	 CollectionAdmin=rs.getString("CollectionAdmin");
	 HRModule=rs.getString("HRModule");

	%>
	<tr>

	   <td class="text-center"><%=i%></td>
       <td class="text-center"><%=UserTypeCode%></td>
       <td class="text-left"><a href="EditUAC.jsp?UserTypeCode=<%=UserTypeCode%>&AccessCode=<%=AccessCode%>" ><%=UserType%></a></th>
       <td class="text-center"><%=AccessCode%></td>
       <td class="text-left"><%=SuperAdmin%></td>
       <td class="text-left"><%=Admin%></td>
       <td class="text-left"><%=Sales%></td>
       <td class="text-left"><%=Purchase%></td>
       <td class="text-left"><%=Claim%></td>
       <td class="text-left"><%=Account%></td>
       <td class="text-left"><%=Collection%></td>
       <td class="text-left"><%=SalesAdmin%></td>
       <td class="text-left"><%=PurchaseAdmin%></td>
       <td class="text-left"><%=ClaimAdmin%></td>
       <td class="text-left"><%=AccountAdmin%></td>
       <td class="text-left"><%=CollectionAdmin%></td>
        <td class="text-left"><%=HRModule%></td>
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
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
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
		                        title: 'User Access Control Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'User Access Control Report', 
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'User Access Control Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'User Access Control Report', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'User Access Control Report', 
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