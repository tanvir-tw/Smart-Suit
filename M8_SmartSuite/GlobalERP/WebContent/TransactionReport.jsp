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
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="";
String Bt=request.getParameter("button");
ResultSet rs=null,rs1=null;
Statement stmt=null,stmt1=null;

 // Connection Initialization
Connection conn = null;
Statement st = null;
try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    stmt=conn.createStatement();
    stmt1=conn.createStatement();
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
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Transaction Report</h5>
    </div>
    
   </div>

 <form name="formreport" id="formreport" method="post">
 
         <div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
              <label>Payment Mode</label>

                 <div class="input-group input-group-merge">
                          <select name="companyName1" id="companyName1" class="form-select">
			                <option value="All">All</option>
           						 <%
            						String customer="";
       								String sql1 = "select distinct(TransactionType) as TransactionType from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount order by TransactionType";
									System.out.println("*******"+sql1);
       								rs= stmt.executeQuery(sql1);
									while(rs.next())
									{
			 
										 customer=rs.getString("TransactionType");
										 System.out.println("Customer-->"+customer);
								%>
							<option value="<%=customer%>"><%=customer%></option>
	        				 <%
	       								 // customer=customer.replaceAll("&", "..");
    								  }
							%>
          				 </select>
          				  <script>
                            const mySel = document.getElementById("companyName1");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>		
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
<th width="4%">SrNo</th>
<th>TransactionId</th>
<th>CustomerCode</th>
<th>TransactionType</th>
<th>TransactionDetail</th>
<th>TransactionDate</th>
<th>DebitAmount</th>
<th>CreditAmount</th>
<th>Balance</th>
<th>EmpName</th>
<th>PaymentVoucherNo</th>
<th>DebitParty</th>
<th>CreditParty</th> 
<th>companyname</th>
</thead>
<tbody>
<%
String Query="";
int i=1;
String TransactionId="",CustomerCode="",TransactionType="",TransactionDetail="",TransactionDate="",DebitAmount="",CreditAmount="";
String Balance="",EmpName="",PaymentVoucherNo="",DebitParty="",CreditParty="",companyname="";
String Cust=request.getParameter("companyName1");
System.out.println("Cust....."+Cust);

if(Bt==null || Bt==" " || Bt=="")
{
	 Query="select a.TransactionId,a.CustomerCode,a.TransactionType,a.TransactionDetail,date_format(a.TransactionDate,'%d-%b-%Y') TransactionDate,a.DebitAmount,a.CreditAmount,a.Balance,a.EmpName,a.PaymentVoucherNo,a.DebitParty,a.CreditParty,b.companyname from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b where a.CustomerCode=b.CustomerCode and a.TransactionDate >='"+dt+"' and a.TransactionDate <='"+dt1+"' ";

}else{
if(Cust.equals("All") || Cust.equalsIgnoreCase("All")){
	
	 Query="select a.TransactionId,a.CustomerCode,a.TransactionType,a.TransactionDetail,date_format(a.TransactionDate,'%d-%b-%Y') TransactionDate,a.DebitAmount,a.CreditAmount,a.Balance,a.EmpName,a.PaymentVoucherNo,a.DebitParty,a.CreditParty,b.companyname from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b where a.CustomerCode=b.CustomerCode and a.TransactionDate >='"+dt+"' and a.TransactionDate <='"+dt1+"' ";

}else{
	
     Query="select a.TransactionId,a.CustomerCode,a.TransactionType,a.TransactionDetail,date_format(a.TransactionDate,'%d-%b-%Y') TransactionDate,a.DebitAmount,a.CreditAmount,a.Balance,a.EmpName,a.PaymentVoucherNo,a.DebitParty,a.CreditParty,b.companyname from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet b where a.TransactionType='"+Cust+"' and a.CustomerCode=b.CustomerCode and a.TransactionDate >='"+dt+"' and a.TransactionDate <='"+dt1+"' ";

}
}
    System.out.println("Query-------->"+Query);
    rs1=stmt1.executeQuery(Query);
   while(rs1.next())
     {

	   TransactionId=rs1.getString("TransactionId");
	   CustomerCode=rs1.getString("CustomerCode");
	   TransactionType=rs1.getString("TransactionType");
	   TransactionDetail=rs1.getString("TransactionDetail");
	   TransactionDate=rs1.getString("TransactionDate");
	   DebitAmount=rs1.getString("DebitAmount");
	   CreditAmount=rs1.getString("CreditAmount");
	   Balance=rs1.getString("Balance");
	   EmpName=rs1.getString("EmpName");
	   PaymentVoucherNo=rs1.getString("PaymentVoucherNo");
	   DebitParty=rs1.getString("DebitParty");
	   CreditParty=rs1.getString("CreditParty");						
	   companyname=rs1.getString("companyname");				
%>
<tr>
	
	<td class="text-center"><%=i%></td>
	<td class="text-center"><%=TransactionId%></td>
	<td class="text-center"><%=CustomerCode%></td>
	<td><%=TransactionType%></td>
	<td><%=TransactionDetail%></td>
	<td class="text-right"><%=TransactionDate%></td>
	<td class="text-center"><%=DebitAmount%></td>
	<td class="text-center"><%=CreditAmount%></td>
	<td class="text-center"><%=Balance%></td>
	<td><%=EmpName%></td>
	<td><%=PaymentVoucherNo%></td>
	<td><%=DebitParty%></td>
	<td><%=CreditParty%></td>
	<td ><%=companyname%></td>
	
<%
i++;
}

%>
</table>
</div>

<%

} catch (Exception e) {
		e.printStackTrace();        
    }%>

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
	        keys: true,  //Keytable
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
								title: 'Transaction Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Transaction Report from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Transaction Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Transaction Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Transaction Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
</body>
<%@ include file="footer.jsp"%>
</html>