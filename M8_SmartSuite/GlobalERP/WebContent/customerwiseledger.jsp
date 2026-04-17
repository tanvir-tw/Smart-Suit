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
Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;

String BranchName="", month="",Year="";
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 

%>
<%
try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
   
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
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Ledger Summary Report</h5>
    </div>
</div>
<form name="custreport" id="custreport" method="post">

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

String countday="SELECT DAYNAME('"+dt+"') as DayName1,DAYOFMONTH('"+dt+"') as DayCnt ,MONTHNAME('"+dt+"') as MonthName,YEAR('"+dt+"') as Year";
ResultSet rs12=st1.executeQuery(countday);
if(rs12.next())
{
	month=rs12.getString("MonthName");
	Year=rs12.getString("Year");
}
month=month.substring(0,3);
%>
<table id="example"  class="display"  style="width:100%">
<thead>
<tr>
	<th class="col-width-4">SrNo.</th>
	<th>CustomerCode</th>
	<th>CompanyName</th>
	<th>BranchName</th>
	<th>Opening</th>
	<th>MainInvoicing</th>
	<th>ProformaInvoicing</th>
	<th>TotalInvoicing</th>
	<th>Receipt</th>
	<th>Closing</th>
</tr>
</thead>
<tbody>
<%
int i=1;
double totalinvoicing=0.00;
String CustomerCode="",Receipts="",Invoicing="",companyname="",CustomerName="",Opening="",Closingbal="",Receipt="",performagdata="",Day="",DutyOut="",DutyIn="",WorkingHours="",Status="";
String data12="select trim(companyname) as companyname,BranchName,customercode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode in (select distinct(CustomerCode) from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where TransactionDate >='"+dt+"' and TransactionDate <= '"+dt1+"') and IsDataValid=1 order by trim(companyname)";
ResultSet rsdata=st2.executeQuery(data12);
System.out.println("data12 is:"+data12);
while(rsdata.next())
{
		CustomerCode=rsdata.getString("customercode");
		companyname=rsdata.getString("companyname");
		BranchName=rsdata.getString("BranchName");
		
String invocingdata="select b.CustomerCode,SUM(DebitAmount) as Invoicing from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount a ,"+session.getAttribute("CompanyMasterID").toString()+"invoicedet b where TransactionDate >='"+dt+"' and TransactionDate <= '"+dt1+"' and a.TransactionDetail=b.invoicerefno and b.InvoiceCancelled=0 and b.CustomerCode='"+CustomerCode+"' group by CustomerCode";		
ResultSet rsdata31=st3.executeQuery(invocingdata);
System.out.println("invocingdata is:"+invocingdata);

if(rsdata31.next())
{
	Invoicing=rsdata31.getString("Invoicing");
}
else
{
	Invoicing="0.00";
}

String performagdata1="select b.CustomerCode,SUM(DebitAmount) as Invoicing from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount a ,"+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet b where TransactionDate >='"+dt+"' and TransactionDate <= '"+dt1+"' and  b.CustomerCode='"+CustomerCode+"' and a.TransactionDetail=b.invoicerefno and b.InvoiceCancelled=0 and b.InvoiceGenerated=0 group by CustomerCode ";		
ResultSet rsdata51=st4.executeQuery(performagdata1);
System.out.println("performagdata is:"+performagdata1);

if(rsdata51.next())
{
	performagdata=rsdata51.getString("Invoicing");
}
else
{
	performagdata="0.00";
}

String receiptdata=" select a.CustomerCode,SUM(CreditAmount) as Receipts from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount a  where TransactionDate >='"+dt+"' and TransactionDate <= '"+dt1+"' and  a.CustomerCode='"+CustomerCode+"' and (PaymentVoucherNo like '%SMR%' or PaymentVoucherNo like '%SCN%' ) group by CustomerCode";		
System.out.println("invocingdata is:"+receiptdata);
ResultSet rsdata41=st5.executeQuery(receiptdata);
if(rsdata41.next())
{
	Receipts=rsdata41.getString("Receipts");
}
else
{
	Receipts="0.00";
}
		String data111="SELECT Balance as Opening  FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"+CustomerCode+"' and  TransactionDate <'"+dt+"' order by concat(TransactionDate , TransactionId ) desc limit 1 ";
		ResultSet rsdata11=st6.executeQuery(data111);
		System.out.println("data111 is:"+data111);

		if(rsdata11.next())
		{
			Opening=rsdata11.getString("Opening");
		}
		String data1111="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"+CustomerCode+"' and TransactionDate between '"+ dt+ "' and '"+ dt1 + "' ORDER BY concat(TransactionDate , TransactionId ) DESC LIMIT 1";
		PreparedStatement pstmt = conn.prepareStatement(data1111, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );
		ResultSet rsdata111 = pstmt.executeQuery();

			if (rsdata111.next()) {
			    Closingbal = rsdata111.getString("Balance");
			}

			System.out.println("Closing Balance: " + Closingbal);
		totalinvoicing=Double.parseDouble(Invoicing)+Double.parseDouble(performagdata);
	
%>
<tr>
	<td class="text-center"><%=i%></td>
	<td class="text-center"><%=CustomerCode%></td>
	<td class="text-left">
    <div style="width:200px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
        <%=companyname%>
    </div>
	</td>
	
	<td class="text-left"><%=BranchName%></td>
	<td class="text-center"><%=Opening%></td>
	<td class="text-center"><%=Invoicing%></td>
	<td class="text-center"><%=performagdata%></td>
	<td class="text-center"><%=totalinvoicing%></td>
	<td class="text-center"><%=Receipts%></td>
	<td class="text-center"><%=Closingbal%></td>
	
<%
i++;
}


%>
</tbody>
</table>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
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
		                        title: 'Ledger Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Ledger Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Ledger Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Ledger Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Ledger Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
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