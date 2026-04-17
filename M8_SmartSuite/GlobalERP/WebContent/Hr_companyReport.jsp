<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headernew.jsp" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
</head>
 <body style="background-color:azure;">
 
 
 <%
String qry="";
 String date = null;
Connection con = null;
Statement st=null;
ResultSet rs=null;


try {
	
	
	/* System.out.println("twEmp:::::::::::::::::: "+twEmp); */
	con = connection.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+con);
	st= con.createStatement();

	
 qry = "select * from t_ourcompanydet Order By CompanyCode";
 rs = st.executeQuery(qry); 
} catch (Exception e) {
   e.printStackTrace();
} 
%>

 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Company Report</h5>
    </div>
      <br>
</div>
		    		
		    		 <div class="row align-items-center">

    <!-- Buttons -->
    <div class="col-md-3">
     <div class="d-flex flex-column flex-sm-row gap-2">
            <a href="Hr_createComp.jsp" class="btn btn-primary " id="button" >ADD</a>
        </div>
        
    </div>
    </div>
    <br>
    
  <table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
					<th>Edit</th>
					<th>Company<br>Code</th>
					<th>Company Name</th>
					<th>Company Adress</th>
					<th>Godown Adress</th>
					<th>BSTNo</th>
					<th>CSTNo</th>
					<th>Phone No</th>
					<th>FAX No</th>
					<th>Email</th>
					<th>Website</th>
					<th>PAN No</th>
					<th>Entered By</th>
					<th>Date/Time</th>
				</tr>
            </thead>
            <tbody>
            
            
            <tr>
            <% 
              while(rs.next())
  { 
            	  String companyCode = rs.getString("CompanyCode");
            	    String ourCompanyName = rs.getString("OurCompanyName");
            	    String ourCompanyAddress = rs.getString("OurCompanyAddress");
            	    String godownAddress = rs.getString("OurCompanyGodownAddress");
            	    String bstNo = rs.getString("OurCompanyBSTNo");
            	    String cstNo = rs.getString("OurCompanyCSTNo");
            	    String phoneNo = rs.getString("PhoneNo");
            	    String faxNo = rs.getString("FaxNo");
            	    String email = rs.getString("Email");
            	    String website = rs.getString("Website");
            	    String panNo = rs.getString("PanNo");
            	    String empName = rs.getString("TWEmpName");

            	 /*    String date=""; */
	  try
	  {
         date = new SimpleDateFormat("dd-MMM-yyyy /HH:mm:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:SS").parse(rs.getString("UpdateDatetime")));  
	  }
	  
    catch(Exception e) {System.out.println("Date Format Exception"+e);}
	  %>
				
<td class="text-right">
<a href="Hr_editCompany.jsp?cmpCode=<%=companyCode%>">
<!-- <img src="images/edit1.jpeg" width="18px" height="18px"> -->
<i class='bx bxs-edit' style="color:green;font-size: 20px;"></i>
</a>
</td>

<td class="text-center"><%=companyCode %></td>
<td class="text-left"><%=ourCompanyName %></td>
<td class="text-left"><%=ourCompanyAddress %></td>
<td class="text-left"><%=godownAddress %></td>
<td class="text-center"><%=bstNo %></td>
<td class="text-center"><%=cstNo %></td>
<td class="text-center"><%=phoneNo %></td>
<td class="text-center"><%=faxNo %></td>
<td class="text-left"><%=email %></td>
<td class="text-left"><%=website %></td>
<td class="text-center"><%= (panNo == null || panNo.trim().equals("")) ? "-" : panNo %></td>
<td class="text-left"><%=empName %></td>
<td class="text-left"><%=date %></td>
</tr>
			
            <% } %>
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
								title: 'Company Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Company Report '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Company Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Company Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Company Report '+$("#data").val()+ 'to' +$("#data1").val(),
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