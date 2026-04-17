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
try{
	String customer =request.getParameter("Type");
	String companyname = request.getParameter("companyname");
	String customercode = request.getParameter("customercode");
	
	String sql1="";
    if(request.getParameter("Type").equals("Customer") )
    {
	    sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where salesCustomerCode="+request.getParameter("customercode")+" order by firstname,middlename,lastname";				
        System.out.println("customer query---->>"+sql1);
    }
    else
    {
    	sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"contactdet where customercode="+request.getParameter("customercode")+" order by firstname,middlename,lastname";				
        System.out.println("customer query---->>"+sql1);
    }
        ResultSet rs1= st.executeQuery(sql1);
    %>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Contact Detail Report</h5>
    </div>
</div>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a href="ContactDetailNew.jsp?Type=<%=customer%>&companyname=<%=companyname%>&customercode=<%=customercode %>" style="color:blue;" class="text-decoration-none">Add Contact</a>
	    </div>
		<div class="col-8"></div>
	</div>
  <br>
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
	            <th class="col-width-4">SrNo.</th>
				<th>Contact Person</th>
	        	<th>Address</th>
	        	<th>City</th>
		        <th>Mobile No</th>
	    	   	<th> Alternate No</th>
	        	<th>Email ID</th>
	        	<th>Fax Number</th>
            </tr>
        </thead> 
        <tbody>
        <%
        String contactperson="",Address="",city="",m1="",m2="",m3="",AlternetNO="",fax="";
        int i=1;
        while (rs1.next())
    	{
        	contactperson = rs1.getString("contactperson");
        	Address = rs1.getString("Address");
        	city = rs1.getString("city");
        	m1 = rs1.getString("mobileno");
        	m2 = rs1.getString("mobileno1");
        	m3 = rs1.getString("mobileno2");
        	
        	String e1 = rs1.getString("email");
        	String e2 = rs1.getString("Email1");
        	String e3 = rs1.getString("Email2");

        	fax= rs1.getString("fax");
        	AlternetNO = rs1.getString("AlternetNO");
    		%>
         <tr> 
         <td class="text-center"><%=i %></td>
         <td class="text-left"><%=contactperson %></td>
         <%
         if (Address == null || Address.trim().equals("")) {
        	    Address = "NA";
        	}
        	%>
         
         <td class="text-left"><%=contactperson %></td>
          <%
         if (city == null || city.trim().equals("")) {
        	 city = "NA";
        	}
        	%>
         <td class="text-left"><%=city %></td>
         <%
         StringBuilder mobiles = new StringBuilder();

         if (m1 == null || m1.trim().isEmpty()) {
             mobiles.append("NA");
         } else {
             mobiles.append(m1);
         }

         if (m2 != null && !m2.trim().isEmpty()) {
             mobiles.append(", ").append(m2);
         }

         if (m3 != null && !m3.trim().isEmpty()) {
             mobiles.append(", ").append(m3);
         }
        
         %>
         <td class="text-left"><%=mobiles.toString() %></td>
          <%
         if (AlternetNO == null || AlternetNO.trim().equals("")) {
        	 AlternetNO = "NA";
        	}
        	%>
         <td class="text-left"><%=AlternetNO %></td>
         <%
         if (fax == null || fax.trim().equals("")) {
        	 fax = "NA";
        	}
         
         StringBuilder emails = new StringBuilder();

         if (e1 == null || e1.trim().isEmpty()) {
             emails.append("NA");
         } else {
             emails.append(e1);
         }

         if (e2 != null && !e2.trim().isEmpty()) {
             emails.append(", ").append(e2);
         }

         if (e3 != null && !e3.trim().isEmpty()) {
             emails.append(", ").append(e3);
         }
        	%>
        	
         <td class="text-left"><%=emails.toString() %></td>
         <td class="text-left"><%=fax %></td>
		</tr>
		<%i++;
		} %>
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
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                       title: 'Contact Details Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                       title: 'Contact Details Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Contact Details Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                       title: 'Contact Details Report ',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                       title: 'Contact Details Report ',
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