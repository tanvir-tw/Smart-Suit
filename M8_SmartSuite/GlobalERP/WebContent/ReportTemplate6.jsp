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
// Variable Declaration
String bt="";

 // Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
 try{ 
bt=request.getParameter("button");
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
            <h5 class="content-header-title text-center mb-0" style="color: #060637">Report Head</h5>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
             <div class="col-md-1">
				  <label for="checkbox"><b>Checkbox</b></label>
					<div class="form-check">
                       <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
                   </div>
			</div>				
			<div class="col-md-2">
				  <label for="dropdown"><b>Dropdown 1</b></label>
						<div class="input-group input-group-merge">
			              <select class="form-select" id="basicSelect" name="basicSelect">
                             <% if(bt == null) { %>
                               <option value="Select" selected>Select</option>
                                 <% } %>
                              <option value="Active">Active</option>
                              <option value="Deactive">Deactive</option>
                              <option value="All">All</option>
                           </select>
                            <script>
                            const mySel = document.getElementById("basicSelect1");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>                        
                        </div>
			</div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
		    <div class="col-md-3"></div>
		</div>
</form> 
 <br>
<table id="example" class="display" width="100%">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Action</th>
			<th>UserName</th>
			<th>UserLevel</th>
			<th>Dept</th>
			<th>EmpName</th>
			<th>ActiveStatus</th>
			<th>Role</th>
         	<th>State</th>
	        <th>City</th>
	        <th>File</th>
	     	<th>Edit</th>
            </tr>
        </thead> 
       <tbody>
         <tr> 
				<td class="text-center">1</td> <!-- Numeric data - center aligned -->
				<td style="font-size: 14px; face: san-serif; color: black" class="text-center">
				    <a><i class='bx bxs-edit'></i></a>&nbsp;&nbsp;
				    <a><i class='bx bxs-trash'></i></a>
				</td>
				<td class="text-left">n_naikawadi@twtech.in</td> <!-- AlphaNumeric data - left aligned -->
				<td class="text-left">Level3</td>
				<td class="text-left">Software</td> <!--Alphabetic data - left aligned -->
				<td class="text-left">Nasrin Naikawadi</td>
				<td class="text-left">Yes</td>
				<td class="text-left">Contractor</td>
				<td class="text-left">Pune</td>
				<td class="text-left">Maharashtra</td>
			    <td class="text-center"><a href="#">View</a></td>  <!--Hyperlink - center aligned -->
			    <td class="text-center"><a href="#" data-bs-toggle="modal" data-bs-target="#SampleModal" >Open</a></td>  <!--Modal Popup - center aligned -->
				</tr>
				 <tr> 
				<td class="text-center">2</td> 
				<td style="font-size: 14px; face: san-serif; color: black" class="text-center">
				    <a><i class='bx bxs-edit'></i></a>&nbsp;&nbsp;
				    <a><i class='bx bxs-trash'></i></a>
				</td>
				<td class="text-left">n_bomble@twtech.in</td>
				<td class="text-left">Level1</td>
				<td class="text-left">RnD</td>
				<td class="text-left">Nasrin Naikawadi</td>
				<td class="text-left">Nilam Bomble</td>
				<td class="text-left">Contractor</td>
				<td class="text-left">Pune</td>
				<td class="text-left">Maharashtra</td>
	            <td class="text-center"><a href="#">View</a></td> 
                <td class="text-center"><a href="#" data-bs-toggle="modal" data-bs-target="#SampleModal">Open</a></td>  				
				</tr>
        </tbody>
 </table> 
 </div>

<!-- Modal -->
<div class="modal fade" id="SampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Approve Action</b></h4>
        <div class="row">
             <div class="col-md-5">
                <div class="row">
                   <div class="col-md-5">
                      <label for="eid" class="control-label"><b>Id : </b></label>
                   </div>
                   <div class="col-md-7">
                      <input type="text" id="eid" name="eid" readonly="readonly" class="form-control">
                  </div>
               </div>
           </div>
            <div class="col-md-7">
               <div class="row">
                  <div class="col-md-6">
                      <label for="name" class="control-label"><b>Name : </b></label>
                  </div>
                  <div class="col-md-6">
                      <input type="text" id="ename" name="ename" readonly="readonly" class="form-control">
                  </div>
              </div>
            </div> 
       </div>
       <div class="row mt-1">
             <div class="col-md-5">
                 <div class="row">
                     <div class="col-md-5">
                         <label for="date" class="control-label"><b>Date :</b></label>
                     </div>
                     <div class="col-md-7">
                         <input type="text" id="date" name="date" readonly="readonly" class="form-control">
                     </div>
                 </div>
             </div>
             <div class="col-md-7">
                 <div class="row">
                     <div class="col-md-6">
                          <label for="status" class="control-label"><b>ActualStatus :</b></label>
                    </div>
                    <div class="col-md-6">
                          <input type="text" id="status" name="status" readonly="readonly" class="form-control">
                    </div>
                </div>
             </div>
         </div>
         <hr>
         <div class="row mt-3">
             <div class="col-md-3">				  
                  <label for="dropdown"><b>Comments : </b></label>
             </div>
             <div class="col-md-6">  
                  <textarea class="form-control" id="mycomments" name="mycomments"></textarea>
             </div>
      	   	<div class="col-md-3"></div>		
        </div>
     </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm">Submit</button>
      </div>
    </div>
  </div>
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
	         fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
	        keys: true,  //Keytable
	        stateSave: true,
	        
	        /* //for adding checkbox to first column
            columnDefs: [{
                orderable: false,
                className: 'select-checkbox',
                targets: 0
            }],
            select: {
                style: 'multi',
                selector: 'td:first-child'
            },
            order: [[1, 'asc']],
            //end adding checkbox to first column */

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
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Report Template from '+$("#data").val()+ 'to' +$("#data1").val(),
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