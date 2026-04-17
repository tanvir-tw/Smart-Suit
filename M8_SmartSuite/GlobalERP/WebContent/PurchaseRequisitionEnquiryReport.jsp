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
	Connection con;
	ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
	Statement stmt = null, stmt1 = null, stmt2 = null;

	con = connection.getConnect("db_GlobalERP"); 
	stmt = con.createStatement();
	stmt1 = con.createStatement();
	stmt2 = con.createStatement();

	Statement st = null;
	st = con.createStatement();
	String datenew1 = "", datenew2 = "", sql_active = "";
	String targetClosure = "", date1 = "", date2 = "", dept = "", user_id1 = "", tDate1 = "", tDate2 = "",
			EmpName = "",EntryDt="";

	String concernPerson = "", sql = "", Status = "";
	int PRNNo = 0;
	String PRNRefNo = "", Name = "", ItemName = "", supplierName, group = "", make = "", model = "",
			partNo = "", ItemCode = "", Quantity = "", spcification = "", spcialInstruction = "", remark = "",
			status = "", UpdatedDateTime="" , ProjectName="";

	String Sesrole1 = session.getAttribute("role").toString();
	String comid = session.getAttribute("CompanyMasterID").toString();
	dept = session.getAttribute("department").toString();
%>
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
<%
String datex1="",datex2="",bt="",dt="",dt1="";
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
 bt=request.getParameter("submit");

if (bt== null || bt.equals("null")) {		
	
	 Calendar cal = Calendar.getInstance();
	    cal.add(Calendar.DATE, -30); // Subtract 30 days from the current date
	    cal.add(Calendar.DATE, -2); // Set the date to yesterday
    
    datex1 = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
    datex2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

} else {
	
	datex1 = request.getParameter("data");
	datex2 = request.getParameter("data1");
	System.out.println("datex1  "+datex1  +"datex2  "+datex1);
}

dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
System.out.println("dt "+dt +"dt1 "+dt1);

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Purchase PRN Report</h5>
    </div>
</div>
	<input type="hidden" id="sesname" name="sesname" />

	<form name="PRNreport1" id="PRNreport1" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" id="data" name="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>							
						</div>
						</div>
						
						<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >
				<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>							
							</div>
							</div>
				<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" name="submit" id="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
				<div class="col-md-2"></div>
		</div>
		
		<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "data"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
		
	</form>	
	<br>
	<div class="container"  style="width: 70%">
	<table id="example" class="display" style="width: 100%">
         <thead>
             <tr>
				<th class="col-width-4">SrNo.</th>
				<th>PRN Ref No</th>
				<th>Name</th>
				<th>Remark</th>
				<th>Entry Date</th>
				<th>Updated Time</th>
				<th>Status</th>
			
			<% if(dept.equals("Purchase")){ %>
			<th>Generate Request</th>
			<%} %>
			</tr>
		</thead>

		<tbody>

				<%
					int i = 1;

					sql= "select distinct(PRN_RefNo),EntryBy,Remark,EntryDate,UpdatedDate,Status,System_name from db_GlobalERP."+comid+"PRNMaster where DATE(EntryDate)>='"+dt+"' AND DATE(EntryDate)<='"+dt1+"'";
					System.out.println("Sql Query == " + sql);

					rs1 = stmt.executeQuery(sql);

					while (rs1.next()) {
						PRNRefNo = rs1.getString("PRN_RefNo");
						Name = rs1.getString("EntryBy");
						remark = rs1.getString("Remark");
						EntryDt = rs1.getString("EntryDate");
					    UpdatedDateTime = rs1.getString("UpdatedDate");
						status = rs1.getString("Status");
						if (remark == null) {
							remark = "-";
						}
						
						if(EntryDt!=null){
							EntryDt = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EntryDt));
						}
						
						if(UpdatedDateTime!=null){
							UpdatedDateTime = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(UpdatedDateTime));
						}
				%>
			
			<tr>
				<td class="text-center"><%=i%></td>
				<td class="text-center"><a href="ViewPRN.jsp" target="popup" onclick="window.open('ViewPRN.jsp?RefNo=<%=PRNRefNo%>'); return false;"><%=PRNRefNo%></a></td>
				<td class="text-left"><%=Name%></td>
				<td class="text-left"><%=remark%></td>
				<td class="text-right"><%=EntryDt%></td>					
				<td class="text-right"><%=UpdatedDateTime%></td>
				<td class="text-left"><%=status%></td>
				
				<% if(dept.equals("Purchase")){
					if(status.equalsIgnoreCase("Pending")){
					%>
			    <td class="text-left"><a href="GeneratePurchasePRNEnquiry.jsp?RefNo=<%=PRNRefNo%>"><button type="button">Generate</button></a></td>
			<%}else{
				%><td class="text-center">-</td><%
			}
					}%>
				<%
				  i++;
					}%>
			</tr>
		</tbody>

	</table>
	</div>
</div>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-5"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
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
		                     title: 'Purchase Requisition Report from ' + $("#data") .val() + ' to ' + $("#data1") .val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                     title: 'Purchase Requisition Report from ' + $("#data") .val() + ' to ' + $("#data1") .val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                     title: 'Purchase Requisition Report from ' + $("#data") .val() + ' to ' + $("#data1") .val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                     title: 'Purchase Requisition Report from ' + $("#data") .val() + ' to ' + $("#data1") .val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                     title: 'Purchase Requisition Report from ' + $("#data") .val() + ' to ' + $("#data1") .val(),
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