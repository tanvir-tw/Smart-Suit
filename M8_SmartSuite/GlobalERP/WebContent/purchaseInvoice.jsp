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
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";

	Connection conn = null;
	Statement st1 = null;
    String supplier="";
    String todaysDate = session.getAttribute("today").toString(); 

	String code=request.getParameter("customerCode");
	System.out.println(">><><>   "+code);

%>

<%
 		
try {
	conn = connection.getConnect("db_GlobalERP");  
	st = conn.createStatement();
    st1 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

try{
bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		
		
		 Calendar cal = Calendar.getInstance();
		 cal.add(Calendar.DATE, -30);
		    
	    datex1 = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	    datex2 = todaysDate;
		System.out.println();
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}
	
	System.out.println("datex1 "+datex1);
	System.out.println("datex2 "+datex2);

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Generate Purchase Invoice from Purchase Order</h5>
    </div>
  
</div>

  <form name="data" action="" method="post">
  <input type="hidden" name="customerCode" id="customerCode" value=""/>
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>
 <br>
  <br>
	  
<%

%>
<div class="container" style="width:60%">
<table id="example" class="display" style="width:100%;"> 
<thead>       
	<tr>
		<th class="col-width-4">SrNo.</th>
		<th>Purchase Order No</th>
		<th>Purchase Order Date</th>
		<th>Sent By</th>
		<th>Supplier</th>
	</tr>
	</thead>
	<tbody>
<%	
String sqlEnq="",supcode="",purchno="",pono="",sendby="",pdate="";

sqlEnq="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder as a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items as b ON(a.PONo =b.PONo) WHERE a.POCancelled=0 and a.PODate BETWEEN '"+dttime+"' and '"+dt1time+"' GROUP BY a.PONo , a.PODate,a.SentBy";

System.out.println(sqlEnq);			
ResultSet rsEnq=st.executeQuery(sqlEnq);
int i=1;
while(rsEnq.next()){
	supcode=rsEnq.getString("SupplierCode");
	pono=rsEnq.getString("PONo");
	purchno = rsEnq.getString("PurQuoNo");
	sendby = rsEnq.getString("SentBy");
	pdate =rsEnq.getString("PODate");
	String sqlSup="select SupplierName from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+supcode+"'";
	ResultSet rs=st1.executeQuery(sqlSup);
	if(rs.next())
	{		
	supplier=rs.getString("SupplierName");
	}
%>  
<tr>
	<td class="text-center"><%=i++ %></td>
	<td class="text-center">
	<a href="#" onclick="popUp('showPurInvoiceDet.jsp','<%= supcode%>','<%=pono%>','<%=purchno%>')"/> <%=pono%></td>
	<td class="text-right"><%=new SimpleDateFormat(
				"dd-MMM-yyyy")
				.format(new SimpleDateFormat(
						"yyyy-MM-dd")
						.parse(pdate))%></td>
	<td class="text-left"><%=rsEnq.getString("SentBy")%></td>
	<td class="text-left"><%=supplier%></td>
</tr>
	<%} %>
	</tbody>
	</table>
	</div>
<% 
	
	} catch(Exception e)
	{
	e.printStackTrace();
	}
%>  
	</div>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	       
	        stateSave: true,
	        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]], //Page Length(Pagination)
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
	                         title: 'Purchase Invoice from Purchase Order '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	                         title: 'Purchase Invoice from Purchase Order '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	                         title: 'Purchase Invoice from Purchase Order '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	                         title: 'Purchase Invoice from Purchase Order '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Purchase Invoice from Purchase Order '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script>
function popUp(Address,supplierCode,PurchaseQuoNo,TWRefNo)
{ 
    window.open(Address+'?supplierCode='+supplierCode+'&PurchaseQuoNo='+PurchaseQuoNo+'&TWRefNo='+TWRefNo);
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>