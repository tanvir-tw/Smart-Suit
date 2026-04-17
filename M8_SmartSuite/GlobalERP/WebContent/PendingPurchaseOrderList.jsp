 <%@page import="java.util.Date"%>
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

<%!
Connection conn=null;
String Bt="";

%>
<%
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
try{
	
conn = connection.getConnect("db_GlobalERP");

}catch(Exception e){
	e.printStackTrace();
}
%>
<%

String CustomerCode="";
String stp="";
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String fromDate="", toDate ="";
try{
bt=request.getParameter("button");
	stp="Select";
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
	
	%>	
	<br>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Pending Purchase Order List</h5>
    </div>
</div>	

<form action=""  name="dateform" action="" method="get" onsubmit="return validate();">
<div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="companyName1" name="companyName1">
							<option><%=stp%></option>
						 	<option value="All">All</option> 
						<%
							String Status = "";
								String sql1 = "select distinct(AuthorisationStatus) as Status from db_GlobalERP."
										+ session.getAttribute("CompanyMasterID").toString()
										+ "authorisepo_det  order by AuthorisationStatus";
								System.out.println("*******" + sql1);
								ResultSet rsregno = st.executeQuery(sql1);
								while (rsregno.next()) {

									Status = rsregno.getString("Status");
						%> 
						<option value="<%=Status%>"><%=Status%></option>
						<%
								}
						%>
		              </select>
		               <script>
                            const mySel = document.getElementById("companyName1");
                             const isBtNull = <%= bt == null %>;
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>		
		                </div>
				</div>				
		        <div class="col-md-2" id="frmDT">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="toDT">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1">
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>		              		       					

<%	 
		String POStatus="";
		System.out.println("----------In Button-234------------"+Bt);
		if(bt==null)
		{
			System.out.println("----------In Button-------------");
			POStatus="Pending";
		}else{
			POStatus=request.getParameter("companyName1");
			String Action="onload";
		}
%>
<br>
<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
			    <th width="4%">Sr.No</th>
				<th>PONo</th>
				<th>ActualPONo</th>
				<th>PODate</th>
				<th>Amount</th>
				<th>Currency</th>
				<th>SupplierName</th>
				<th>ApprovalRequest</th>
				<th>PendingReason</th>
				<th>Status</th>
				<th>EntryBy</th>
			</tr>
		</thead>
		<tbody>
		  	<%
		  	fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		  	toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
		  	
		  	System.out.println("----------In Button-------------"+fromDate +"----- "+toDate);
			String sql2 = "";
			int i = 1;
				try 
				{
				CallableStatement cs=(CallableStatement) conn.prepareCall("{call db_GlobalERP.Pending_purchase_order('"+POStatus+"','"+fromDate+"','"+toDate+"')}");        //93 database
					
					ResultSet rs1 = cs.executeQuery();
					System.out.println("cs--------------------"+cs);
					while (rs1.next())  
					{
						String PONo = rs1.getString("PONo");
		%>
		
		<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-center"><a href="PODetails.jsp?transactionId=<%=PONo%>&condition=<%=rs1.getString("Status")%>"><%=rs1.getString("PONo")%></a></td>          
			<td class="text-center"><%=rs1.getString("ActualPONo")%></td>
			<td class="text-right"><%=rs1.getString("PODate")%></td>
			<td class="text-center"><%=rs1.getString("Amount")%></td>
			<td class="text-center"><%=rs1.getString("Currancy")%></td>
			<td class="text-left"><%=rs1.getString("SupplierName")%></td>
			<td class="text-left"><%=rs1.getString("ApprovalRequest")%></td>
			<td class="text-left"><%=rs1.getString("PendingReason")%></td>
			<td class="text-left"><%=rs1.getString("Status")%></td>
			<td class="text-left"><%=rs1.getString("EntryBy")%></td>
				<%
					i++;
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
				%>
			</tr> 
		
		</tbody>
	</table>
<%

}catch(Exception e){
	e.printStackTrace();
}
%>
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
		                        title: 'Pending Order Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Pending Order Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Pending Order Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Pending Order  Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Pending Order Report '+$("#data").val()+' to ' +$("#data1").val(),
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