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
String fromDate="",datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String sql="",sql1="",sql2="" ,status="Proforma",companymasterid = session.getAttribute("CompanyMasterID").toString();
String invoiceno=" ",InvoiceNo1=" ",RevOfinvoiceRefNo1=" ",RevOfinvoiceRefNo2=" ",InvoiceDate1=" ";
String GrandTotal1=" ",CurrType1=" ",InvoiceCancelled1=" ",CompanyName1=" ",TWEmpName1=" ",ClosedBy1=" ",ReasonForCancelling1=" ",PODate1=" ";

 String dt4=" ",dt6= " ",fdate="",tdate="",ddate="" ,ItemDescription2="",sqlGroup="",Group="",TheGroupName1=" ";
int i = 1;

 // Connection Initialization
Connection conn = null;
Statement st1 = null,st2=null,st3=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();

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
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Proforma Invoice</h5>
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
<table id="example" class="display" style="width:100%">
				<thead>
					<tr>
						<th class="col-width-4">SrNo</th>
						<th>InvoiceNo</th>
						<th>Revised</th>
						<th>InvoiceDate</th>
						<th>Amount</th>
						<th><div style="width:350px;">Description</div></th>
						<th>FromDate</th>
						<th>ToDate</th>
						<th>DueDate</th>
						<th>Group</th>
						<th>Status</th>
						<th>Customer</th>
						<th>Sign</th>
					</tr>
				</thead>
				<tbody>
					<%
					        if(bt==null)
					        { 
					      	    sql = "select distinct(invoiceRefNo),RevofInvoiceNo ,RevOfinvoiceRefNo,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate,InvoiceDate,invoiceno,PODate,GrandTotal,CurrType,InvoiceCancelled,TheGroup,CompanyName,TWEmpName,CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate from db_GlobalERP."+companymasterid+"performainvoicedet   where  InvoiceCancelled=0 AND InvoiceDate>='"+dttime+"' and InvoiceDate<='"+dt1time+"'  order by InvoiceDate desc, invoiceRefNo desc";
					            System.out.println("onload query-->" + sql);
					      	  }
					    	 else
					      	  {
					         	   sql = "select distinct(invoiceRefNo),RevofInvoiceNo ,RevOfinvoiceRefNo,CASE WHEN ToDate ='0000-00-00' THEN null ELSE ToDate END as ToDate,CASE WHEN DueDate ='0000-00-00' THEN null ELSE DueDate END as DueDate,InvoiceDate,invoiceno,PODate,GrandTotal,CurrType,InvoiceCancelled,TheGroup,CompanyName,TWEmpName,CASE WHEN FromDate ='0000-00-00' THEN null ELSE FromDate END as FromDate from db_GlobalERP."+companymasterid+"performainvoicedet  where InvoiceCancelled=0 AND InvoiceDate>='"+dttime+"' and InvoiceDate<='"+dt1time+"' order by InvoiceDate desc,  invoiceRefNo desc";
					         	   System.out.println("onsubmit query-->" + sql);
					      	  
					      	  }
					        
					        ResultSet rs1=st1.executeQuery(sql);
					        while(rs1.next()){
					        	try{
					  
									InvoiceCancelled1 = rs1.getString("InvoiceCancelled");
									RevOfinvoiceRefNo2 = rs1.getString("RevOfinvoiceRefNo");
									invoiceno = rs1.getString("invoiceno");
									InvoiceNo1 = rs1.getString("invoiceRefNo");
									InvoiceDate1 = rs1.getString("InvoiceDate");
									PODate1 = rs1.getString("PODate");
									GrandTotal1 = rs1.getString("GrandTotal");
									CurrType1 = rs1.getString("CurrType");
									CompanyName1 = rs1.getString("CompanyName");
									TWEmpName1 = rs1.getString("TWEmpName");
									fdate = rs1.getString("FromDate");
									tdate = rs1.getString("ToDate");
									ddate = rs1.getString("DueDate");
									Group = rs1.getString("TheGroup");

									if (fdate == null || fdate == "null" || fdate.equals("null") || fdate.equals("0000-00-00")) {
										fdate = "-";
									}
									if (fdate.equals("-")) {
										fdate = "-";
									} else {
										fdate = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd").parse(fdate));
									}

									if (tdate == null || tdate == "null" || tdate.equals("null") || tdate.equals("0000-00-00")) {
										tdate = "-";
									}
									if (tdate.equals("-")) {
										tdate = "-";
									} else {
										tdate = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd").parse(tdate));
									}

									if (ddate == null || ddate == "null" || ddate.equals("null") || ddate.equals("0000-00-00")) {
										ddate = "-";
									}
									if (ddate.equals("-")) {
										ddate = "-";
									} else {
										ddate = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd").parse(ddate));
									}

									dt4 = new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd").parse(InvoiceDate1));
									dt6 = new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd").parse(PODate1));

									sql1 = "select  ItemDescription from db_GlobalERP."
											+ session.getAttribute("CompanyMasterID").toString()
											+ "performainvoice_items where invoiceno='" + rs1.getString("invoiceno") + "'";
									//System.out.println("desc query   =======>" + sql1);
									ResultSet rs2 = st2.executeQuery(sql1);
									
									while (rs2.next()) {
										
										ItemDescription2 = ItemDescription2 + "," + rs2.getString("ItemDescription");
									}

									if (ItemDescription2 == " " || ItemDescription2 == "") {
										ItemDescription2 = ItemDescription2;
									} else {

										ItemDescription2 = ItemDescription2.substring(1);

									}

									TheGroupName1 = " ";
									sqlGroup = "SELECT TheGroupName FROM " + session.getAttribute("CompanyMasterID").toString()
											+ "tbl_groupmaster where TheGroupCode='" + Group + "' ";
									// System.out.println(sqlGroup);
									ResultSet rsGroup = st3.executeQuery(sqlGroup);
									while (rsGroup.next()) {
										TheGroupName1 = rsGroup.getString("TheGroupName");
									}
					%>

					<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><a target="_blank" href="detailForProInvoice.jsp?InvoiceRefNo=<%=InvoiceNo1%>&Invoiceno=<%=invoiceno%>&condition=View">
						    <%=InvoiceNo1%></a></td>
						<td class="text-left"><%=RevOfinvoiceRefNo2%></td>
						<td class="text-right"><%=dt4%></td>
						<td class="text-center"><%=GrandTotal1%></td>
						<td class="text-left"><div style="width:350px;"><%=ItemDescription2%></div></td>
						<td class="text-right"><%=fdate%></td>
						<td class="text-right"><%=tdate%></td>
						<td class="text-right"><%=ddate%></td>
						<td class="text-left"><%=TheGroupName1%></td>
						<td class="text-left"><%=status%></td>
						<td class="text-left"><%=CompanyName1%></td>
						<td class="text-left"><%=TWEmpName1%></td>
					</tr>
					<%
						i++;
					
						} catch (Exception e) {
									e.printStackTrace();
								}
							}
					%>
				</tbody>
 </table>
 </div>
 <%
 	} catch (Exception e) {
 		System.out.println("Exception " + e);
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
	            left: 2      //To freeze two columns
	        },  
	        //keys: true,  //Keytable
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
								title: 'Proforma Invoice from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Proforma Invoice from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Proforma Invoice from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Proforma Invoice from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Proforma Invoice from '+$("#data").val()+ ' to ' +$("#data1").val(),
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