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
String id=request.getParameter("id");
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="";
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
	<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Payment Report </h5>
    </div>
</div>
  <form name="data" id="formreport" method="get">
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
			<input type="hidden" name="id" value="<%=id %>">
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
	<%   
	if(null != request.getQueryString())
	{
	%> 
	
	<table id="example" class="display" style="width:100%;">
	<thead>
	<tr>
		<th class="col-width-4" >Sr no</th>
		<th>Payment Entry On</th>
		<th>Company</th>
		<th>Bill No</th>
		<th>Bill Date</th>
		<th>Due Date</th>
		<th>Amount</th>
		<th>Status</th>
		<th>Account Comments</th>
		<th>Approve</th>
	</tr>
	</thead>
	<tbody>
	<%
	String Sql="Select * from "+session.getAttribute("CompanyMasterID").toString()+"paymentEntryDet where EntryDate  between '"+ dt+"' AND '"+dt1+"' AND Status ='Pending'  order by EntryDate ";
	System.out.println("QUERY    "+Sql);
	ResultSet rsData=st.executeQuery(Sql);
	while(rsData.next())
	{	
		String a=rsData.getString("EntryDate");
		String payno=rsData.getString("PaymentEntryNO");
		System.out.println("payemnt nO  ::  "+payno);
	%>
	<tr>
	<td class="text-center"><%=i++ %></td>
	<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsData.getString("EntryDate")))  %></td>
	<td class="text-left"><%=rsData.getString("PartyName") %></td>
	<td class="text-center"><%=rsData.getString("BillNo") %></td>
	<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsData.getString("BillDate"))) %></td>
	<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsData.getString("DueDate"))) %></td>
	<td class="text-center"><%=rsData.getString("Amount") %></td>
	<td class="text-left"><%=rsData.getString("Status") %></td>
	<td class="text-left"><%=rsData.getString("AccountComments") %></td>
	<td class="text-center"><input type="submit" class="btn btn-primary" id="button" value="Approve" onclick="popUp('paymentApprovalDet.jsp',<%=payno %>)"></td>
	</tr>

	<%
	}
	}
	%>
	</tbody>
	</table>
</div>
<%
} catch (Exception e) {
	e.printStackTrace();
	} %>	
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
								title: 'Payment Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Payment Report from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Payment Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Payment Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Payment Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>

<script language="JavaScript1.2">
function popUp(Address,PaymentEntryNo)
{
	
	window.open(Address+'?PaymentEntryNo='+PaymentEntryNo,'jav','scrollbars=yes,menubar=yes,height=300,width=600,resizable=yes');
}	
</script>

 <%@ include file="footer.jsp" %>

</body>
</html>