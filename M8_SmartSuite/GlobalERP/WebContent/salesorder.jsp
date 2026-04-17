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
// Variable Declaration
String todaysDate = session.getAttribute("today").toString(); 
String fromDate="",datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="";
String sqlOrder="",TWSalesRefNo="",SalesquoRefNo="",SalesQuoDate="",CompanyName="",Total="",CurrType="",CurrValue="",RevofSalesQuoRefNo="",ReasonForCancellingQuo="",TWSalesOrderRefNo="",TWEmpName="",Quotationtype="",SalesQuoNo="",TheGroup="";
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
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Generate Sales Order form Sales Quotation</h5>
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
	        <th>TWSalesRefNo</th>
	        <th>SalesquoRefNo</th>
	        <th>SalesQuoDate</th>
	        <th>CompanyName</th>
	        <th>Total</th>
	        <th>CurrType</th>
	        <th>CurrValue</th>
	        <th>RevofSalesQuoRefNo</th>
	        <th>ReasonForCancellingQuo</th>
	        <th>TWSalesOrderRefNo</th>
	        <th>TWEmpname</th>
	        <th>Quotationtype</th>
	        <th>SalesQuoNo</th>
	        <th>TheGroup</th>        
            </tr>
        </thead> 
        <tbody>
        <%
		sqlOrder="SELECT DISTINCT a.TWSalesRefNo as TWSalesRefNo,a.SalesquoRefNo as SalesquoRefNo ,date_format(a.SalesQuoDate,'%d-%b-%Y') as SalesQuoDate, a.CompanyName as CompanyName,cast(a.Total as decimal(10,2)) as Total,a.CurrType as CurrType,a.CurrValue as CurrValue,a.RevofSalesQuoRefNo as RevofSalesQuoRefNo,a.ReasonForCancellingQuo as ReasonForCancellingQuo,a.TWSalesOrderRefNo as TWSalesOrderRefNo,a.TWEmpname as TWEmpname,a.Quotationtype as Quotationtype,a.SalesQuoNo as SalesQuoNo, (SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode=a.TheGroup) as TheGroup FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det as a WHERE a.CompanyName like '%%' AND a.SalesQuoCancelled=0 AND a.ThisisSalesOrder=0  AND a.SalesQuoDate BETWEEN '"+dt+"' AND '"+dt1+"'  "; 	
    	System.out.println(sqlOrder);			
    	ResultSet rsOrder=st1.executeQuery(sqlOrder);
   
    	while(rsOrder.next()){ 
    		
    		TWSalesRefNo=rsOrder.getString("TWSalesRefNo");
    		SalesquoRefNo=rsOrder.getString("SalesquoRefNo");
    		SalesQuoDate=rsOrder.getString("SalesQuoDate");
    		CompanyName=rsOrder.getString("CompanyName");
    		Total=rsOrder.getString("Total");
    		CurrType=rsOrder.getString("CurrType");
    		CurrValue=rsOrder.getString("CurrValue");
    		RevofSalesQuoRefNo=rsOrder.getString("RevofSalesQuoRefNo");
    		ReasonForCancellingQuo=rsOrder.getString("ReasonForCancellingQuo");
    		TWSalesOrderRefNo=rsOrder.getString("TWSalesOrderRefNo");
    		TWEmpName=rsOrder.getString("TWEmpName");
    		Quotationtype=rsOrder.getString("Quotationtype");
    		SalesQuoNo=rsOrder.getString("SalesQuoNo");
    		TheGroup=rsOrder.getString("TheGroup");
    	%>
         <tr> 
           <td class="text-center"><%=i%></td>
           <td class="text-left"><%=TWSalesRefNo%></td>
           <td class="text-left">
	<%
		if(TWSalesRefNo.contains("EXP"))
	{
		%>
		  <a href="Exporderdet.jsp?CompanyName=<%=CompanyName%>&SalesQuoRefNo=<%=SalesquoRefNo%>&SalesQuoNo=<%=SalesQuoNo%>&Ctype=<%=CurrType%>&Cval=<%=CurrValue%>" target="_blank"><%=SalesquoRefNo%></a>
		<%
	}
	else{
		%>
			<a href="orderdet.jsp?CompanyName=<%=CompanyName%>&SalesQuoRefNo=<%=SalesquoRefNo%>&SalesQuoNo=<%=SalesQuoNo%>" target="_blank"><%=SalesquoRefNo%></a>
		<%
	}
	%>	
	</td>
           <td class="text-right"><%=SalesQuoDate%></td>
           <td class="text-left"><%=CompanyName%></td>
           <td class="text-center"><%=Total%></td>
           <td class="text-left"><%=CurrType%></td>
           <td class="text-center"><%=CurrValue%></td>
           <td class="text-left"><%=RevofSalesQuoRefNo%></td>
           <td class="text-left"><%=ReasonForCancellingQuo%></td>
           <td class="text-center"><%=TWSalesOrderRefNo%></td>
           <td class="text-left"><%=TWEmpName%></td>
           <td class="text-left"><%=Quotationtype%></td>
           <td class="text-center"><%=SalesQuoNo%></td>
           <td class="text-left"><%=TheGroup%></td>
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
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	       /*   fixedColumns: { 
	            left: 3      //To freeze two columns
	        },  */
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
								title: 'Sales Order From Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Sales Order From Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Sales Order From Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Sales Order From Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Sales Order From Sales Quotation Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
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