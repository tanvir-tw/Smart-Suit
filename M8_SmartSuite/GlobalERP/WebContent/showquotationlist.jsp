 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
 <%@ page import="java.util.Date" %>
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
String todaysDate = session.getAttribute("today").toString();
String id=request.getParameter("id");
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",fromDate="";
String sqlQuo="",SalesquoRefNo="",SalesQuoNo="",SalesQuoDate="",CompanyName="",Quotationtype="",TheGroup="",TWEmpName="",Total="";
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
bt=request.getParameter("button");
Date today = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DAY_OF_MONTH, -30);
Date today30 = cal.getTime();
fromDate=new SimpleDateFormat("dd-MMM-yyyy").format(today30);

	if (bt== null || bt.equals("null")) {		
		datex1 = fromDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
    <% if(id.equals("revise")) {%>
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Revise Sales Quotation</h5>
     <%}else if(id.equals("close")){%>
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Close Sales Quotation</h5>
     <%}else{ %>
           <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=id%> Sales Quotation</h5>
     <%} %>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
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
			<div class="col-md-2"></div>
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
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
               <th class="col-width-4">SrNo.</th>
               <th>Sales Quo Ref no</th>
               <th>SQ Date</th>
               <th>Company</th>
               <th>Status</th>
               <th>Group</th>
               <th>Sign</th>
               <th>Amount</th>        
            </tr>
        </thead> 
        <tbody>
        <%
		sqlQuo="SELECT DISTINCT SalesquoRefNo,SalesQuoDate,CompanyName,SalesQuoCancelled,TheGroup,ThisIsSalesOrder,Total,TWEmpname,Quotationtype,SalesQuoNo FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoDate BETWEEN '"+dt+"' and '"+dt1+"' ORDER BY SalesQuoNo DESC";
        System.out.println(sqlQuo);			
    	ResultSet rsQuo=st1.executeQuery(sqlQuo);
   
    	while(rsQuo.next()){ 
    		
    		SalesquoRefNo=rsQuo.getString("SalesquoRefNo");
    		SalesQuoNo=rsQuo.getString("SalesQuoNo");

    		SalesQuoDate=rsQuo.getString("SalesQuoDate");
    		 if(SalesQuoDate =="-" || SalesQuoDate.equalsIgnoreCase("-") || SalesQuoDate==null){
    			 SalesQuoDate ="-";
	    		 
	    	 }else{
	     		SalesQuoDate =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(SalesQuoDate));
	    	 }
    		CompanyName=rsQuo.getString("CompanyName");
    		Quotationtype=rsQuo.getString("Quotationtype");
    		TheGroup=rsQuo.getString("TheGroup");
    		TWEmpName=rsQuo.getString("TWEmpName");
    		Total=rsQuo.getString("Total");
    	
        %>
                <tr> 
                   <td class="text-center"><%=i%></td>
                   <td class="text-left"> <a href="viewQuotation.jsp?condition=View&salesQuotation=<%=SalesQuoNo%>" target="_blank"><%=SalesquoRefNo%></a></td>
                   <td class="text-right"><%=SalesQuoDate%></td>
                   <td class="text-left"><%=CompanyName%></td>
                   <td class="text-left"><%=Quotationtype%></td>
                   <td class="text-center"><%=TheGroup%></td>
                   <td class="text-left"><%=TWEmpName%></td>
                   <td class="text-center"><%=Total%></td>				
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
	    var id = "<%=id%>"; // Dynamic id value
	 // Capitalize
	    id = id.charAt(0).toUpperCase() + id.slice(1).toLowerCase();

	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         /* fixedColumns: { 
	            left: 3      //To freeze two columns
	        },  */
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
								title: id + ' Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: id + ' Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: id + ' Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: id + ' Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: id + ' Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
					],
				},
           ], 
       });
   });
</script>
 <%@ include file="footer.jsp"%>
 </body>
</html>