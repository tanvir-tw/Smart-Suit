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
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";

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
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

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
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
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