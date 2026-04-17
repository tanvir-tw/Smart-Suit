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

//Connection Initialization
Connection conn = null;
Statement st = null, st1=null;
ResultSet rs=null;
int j=0;
String date="",status1="";
String name="",color="";
try {
	conn = connection.getConnect("db_GlobalERP");    
 st = conn.createStatement();
 st1=conn.createStatement();
 String sql = "select * from  "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory  ";

 rs = st.executeQuery(sql);
 
} catch (Exception e) {
 e.printStackTrace();
} 
 %> 
 
 <div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Category Master</h5>
    </div>
  <br>
<div class="row">
<div class="col-1 ms-5"></div>
    <div class="col-2 ms-5">
        <a href="Accounts.jsp" class="btn btn-primary" id="button" name="button">BACK</a>
        <a href="new_categoryMaster.jsp" class="btn btn-primary" id="button" name="button">ADD</a>
        <input type="button" name="del" id="button" name="button" class="btn btn-primary" value="Deactivate" onclick="getcheckedrow()" />
    </div>
    <div class="col-9 ms-5"></div>
    
</div>


</div>
<div class="container" style="width:70%">
<table id="example" class="display" width="100%">  
           <thead>
				<tr>
					<th>Edit</th>
					<th>Select</th>
					<th>Id</th>
					<th>Category</th>
					<th>Limit</th>
					<th>Status</th>
				</tr>
			</thead>
<tbody>
<% 
 
 while(rs.next())
 {  
	
	j++; 
	 if (rs.getString("Status").equalsIgnoreCase("Deactivate")) {
		 color = "#FF8080";

		} else 
		{

			color = "#CCFF99";
		}
	 System.out.println("colorrrrrrr"+color);
	 
 %>
  <tr>
 
<td style="background:<%=color%>;" class="text-center"><a href="Edit_categoryMaster.jsp?ID=<%=rs.getString("id")%>"><img src="images/edit1.jpeg" width ="18px" height="18px"></a></td>


<%status1=rs.getString("Status");
	
	if(status1.equalsIgnoreCase("Deactivate") )
	{
		%>

		<td style="background: <%=color%>;" width="1%" class="text-center"><div  style="visibility:hidden"><input type="checkbox" name="chkbx" disabled="disabled" id="chk<%=j%>" /></div></td>
		<%
	}else 
	{
		%>
		<td style="background: <%=color%>;" width="1%" class="text-center"><input type="checkbox" name="chkbx" id="chk<%=j%>" /></td>
		<%
	}
	
	%>
 

<td style="background:<%=color%>;" width="2%" class="text-center" id="net_id<%=j %>"><div align="right" id="net_id1<%=j %>"><%=rs.getString("id")%></div></td>
 <td style="background:<%=color%>;" class="text-left"><%=rs.getString("Category")%></td>
 <td style="background:<%=color%>;" class="text-center"><%=rs.getString("Limit1")%></td>
 <%
 String status="";
 try{
	 status=rs.getString("Status") ;
	 if(status.equalsIgnoreCase("Deactivate"))
	 {
		 status="Deactive";
	 }
	 else
	 {
		 status="Active";
	 }
 }catch(Exception e)
 {
	 status="test";
	 System.out.println("exception------>"+e);
 }
 
 
 %>
 <td style="background:<%=color%>;"class="text-left"><%=status%></td>
 </tr>
<% }
 %>

</tbody>
</table>
</div>
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
	        keys: true,  //Keytable
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
								title: 'Category Master Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Category Master Report  ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Category Master Report  ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: ' Category Master Report  ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: ' Category Master Report  ',
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