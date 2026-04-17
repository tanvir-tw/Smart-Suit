 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
  <%@ page import="java.util.Date"%>
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
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="",departmentNew="";
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 

Connection conn = null;
Statement st1=null;

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

				departmentNew=request.getParameter("departmentNew");
			}

		 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));	
	System.out.println("dt"+ dt +"dt 11111" +dt1);
	
%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Invoice Details</h5>
    </div>
</div>

 <form name="invoicedetail" id="invoicedetail" method="post">

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
			<div class="col-md-2">
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
<br>
		
 <table id="example"  class="display" style="width: 100%;">
			<thead>
				<tr>
						<th class="col-width-4">SrNo.</th>
						<th>CustomerCode</th>
						<th>CompanyName</th>
						<th>BillingGSTIN</th>
						<th>ShippingGSTIN</th>
						<th>Date</th>
						<th>InvoiceRefNo</th>
						<th>Total</th>                                                                             
						<th>GrandTotal</th>
						<th>GST</th>
						<th>SGSTValue</th>
						<th>CGSTValue</th>
						<th>IGSTValue</th>
				</tr>
			</thead>
			<tbody>
			<%
				try
				{
						int i=1;
						String CustomerCode="", CompanyName="", BillingGSTN="", ShippingGSTN="",Total="",GrandTotal="",GST="",SGSTValue="",CGSTValue="",IGSTValue="",InvoiceDate="";
						
						String sql="select InvoiceNo,InvoiceDate,a.CustomerCode,a.CompanyName,b.BillingGSTN,b.ShippingGSTN,InvoiceRefNo,(GrandTotal-(sum(CGSTValue+SGSTValue+IGSTValue))) as Total,GrandTotal,sum(CGSTValue) as CGSTValue,sum(SGSTValue) as SGSTValue, sum(IGSTValue) as IGSTValue,sum(CGSTValue+SGSTValue+IGSTValue) as GST from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"invoicedet a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b  on a.CustomerCode=b.CustomerCode where InvoiceDate >='"+dt+"' and InvoiceDate <='"+dt1+"'  and InvoiceCancelled=0 group by InvoiceNo ";
						System.out.println("query " + sql);
						ResultSet rs1 = st1.executeQuery(sql);
						while (rs1.next()) 
						{
							CustomerCode=rs1.getString("CustomerCode");
							CompanyName=rs1.getString("CompanyName");
							BillingGSTN=rs1.getString("BillingGSTN");
							ShippingGSTN=rs1.getString("ShippingGSTN");
							Total=rs1.getString("Total");
							
							GrandTotal=rs1.getString("GrandTotal");
							GST=rs1.getString("GST");
							SGSTValue=rs1.getString("SGSTValue");
							CGSTValue=rs1.getString("CGSTValue");
							IGSTValue=rs1.getString("IGSTValue");
							
							InvoiceDate = rs1.getString("InvoiceDate");
							if(InvoiceDate!=null){
								if(InvoiceDate.equals("-") || InvoiceDate.equals("")){
									InvoiceDate = "-";
								}else{
									InvoiceDate = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(InvoiceDate));
								}
							}else{
								InvoiceDate="-";
							}
			%>
				<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=CustomerCode%></td>
						<td class="text-left"><%=CompanyName%></td>
						<td class="text-center"><%=BillingGSTN%></td>
						<td class="text-center"><%=ShippingGSTN%></td>
						<td class="text-right"><%=InvoiceDate%></td>
						<td class="text-center"><a href="InvoiceItemDetails.jsp?InvoiceNo=<%=rs1.getString("InvoiceNo")%>&InvoicerefNo=<%=rs1.getString("InvoiceRefNo")%>"><%=rs1.getString("InvoiceRefNo")%></a></td>              
						<td class="text-center"><%=Total.replaceAll("-", "")%></td>
						<td class="text-center"><%=GrandTotal.replaceAll("-", "")%></td>
						<td class="text-center"><%=GST.replaceAll("-", "")%></td>
						<td class="text-center"><%=SGSTValue.replaceAll("-", "")%></td>
						<td class="text-center"><%=CGSTValue.replaceAll("-", "")%></td>
						<td class="text-center"><%=IGSTValue.replaceAll("-", "")%></td>
						<%
							i++;
										}
									} catch (Exception e) {
										System.out.println(e);
									}
						%>
					</tr>
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
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        keys: true, 
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
	                         title: 'Invoice Details Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Invoice Details Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Invoice Details Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Invoice Details Report '+$("#data").val()+ ' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Invoice Details Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                     
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