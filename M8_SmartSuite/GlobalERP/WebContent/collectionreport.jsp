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
<%
Connection conn = null;
Statement st1=null,st2=null;
String monthFirstDate = session.getAttribute("onemonthback").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String datex1="",datex2="",bt="",data1="",data2="";
try {
	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
}
%>
<%
String condition="";
String CMID=session.getAttribute("CompanyMasterID").toString();

bt=request.getParameter("button");

if (bt== null || bt.equals("null")) {		
	datex1 = monthFirstDate;
	datex2 = todaysDate;
} else {	
	datex1 = request.getParameter("data");
	datex2 = request.getParameter("data1");

}

	String mybegindate1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
	 String myenddate1 = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	condition="where paymentdate between '"+mybegindate1+"' and '"+myenddate1+"' order by a.twempname";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Collection Report</h5>
    </div>
</div>
  <form name="CollectionReport" id="CollectionReport" method="post">
  		<div class="row col-12">
		   <div class="col-md-3"></div>
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
 			<div class="col-md-1">
				  <label for="dropdown"><b>Category</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="status" name="status">
 			<%
        	String ss="";
        	String Status1="";
        	try{
        		ss=request.getParameter("status");
        		if(ss==null)
        			ss="All";
        	}catch(Exception e){
        		ss="All";
        		out.print(ss+e);
        	}
        	try{
        			if(ss.equalsIgnoreCase("All")){ %>
        			<option value="All" selected>All</option>
        			<%}else{%>
        				<option value="All" >All</option>
        				<%}if(ss.equalsIgnoreCase("cleared")){ %>
        				<option value="Cleared" selected> Cleared </option>
        				<%}else{%>
        				<option value="Cleared"> Cleared </option>
        				<%}if(ss.equalsIgnoreCase("Uncleared")){ %>
        				<option value="Uncleared" selected> Uncleared </option>
        				<%}else{%>
        				<option value="Uncleared"> Uncleared </option>
        				<%} %>
 			<%}catch(Exception e){out.println(e);} %>	
 			</select>
 			<script>
                            const mySel = document.getElementById("status");

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
 			<div class="col-md-1 mt-4">
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>

	    <%
        try
        {
        
        	
        	String mybegindate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
     	    String myenddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
        
        	String todaydate="";
        	String a=""; 
        	double totalamount=0;
	        todaydate=new SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
	        
        	String sql="", sql1="", Status="";
        	
			try{
				condition="where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and status='Active' order by a.twempname";
				Status1="All";
        		Status=request.getParameter("status");
        		if(Status==null){
        			condition="where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and status='Active' order by a.twempname";
        			Status1="All";
        			
        			System.out.println(Status1);
        		}
        		if(Status.equalsIgnoreCase("Cleared")){
        			condition="where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and tallyrefno !=''  order by a.twempname";
        			Status1="Cleared";
        			System.out.println(Status1);
        		}
        		if(Status.equalsIgnoreCase("Uncleared")){
        			condition="where paymentdate between '"+mybegindate+"' and '"+myenddate+"' and (tallyrefno = '' OR PaymentMode='Suspense')  and status='Active' order by a.twempname";
        			Status1="UnCleared";
        			System.out.println(Status1);
        		}
		%>        		
<%
	String query123="select PaymentMode,PaymentVoucherNo,DATE_FORMAT(PaymentDate,'%d-%b-%Y') as PaymentDate,CompanyName,ChOrDDorCreditNoteNo,DATE_FORMAT(ChOrDDorCreditNoteDate,'%d-%b-%Y') as ChOrDDorCreditNoteDate,AmountPaid,(select InvNo from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"collectioninv where MoneyReceiptNo=a.MoneyReceiptNo limit 1) as InvNo,tallyrefno,a.twempname from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"collection as a inner join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.customercode=b.customercode "+condition+"";
	System.out.println(query123);
%>
<br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
				<th>SrNo</th>
				<th>Customer</th>
				<th>Amount </th>
				<th>Mode</th>
				<th>Released </th>
				<th>Instrument Id</th>
				<th>Invoice No</th>
				<th>Entry </th>
				<th>Voucher No</th>
				<th>Balance</th>
				<th>FAS Ref</th>
				<th>Status</th>
				<th>Sign</th>
			</tr>
	</thead>
	<tbody>
	
	
	<%
	ResultSet rs123=st1.executeQuery(query123);
	int i=1;
	while(rs123.next())
	{
		
	String invoicenumber=rs123.getString("InvNo");
	String vouchernumber=rs123.getString("PaymentVoucherNo");
	String tallyRefno=rs123.getString("tallyrefno");
	if(tallyRefno.equals("-") || tallyRefno.isEmpty())
	{
		tallyRefno="12345";
		System.out.println("===============>"+tallyRefno);
		Status1="UnCleared";
	}
	else
	{
		Status1="Cleared";
	}
	
	if(vouchernumber.isEmpty()
			)
	{
		vouchernumber="-";
		System.out.println("----------------------->"+vouchernumber);
	}
	
	if(invoicenumber==null)
	{
		invoicenumber="-";
		System.out.println(invoicenumber);
		
	}
		
	
	String sql12="";
	String Balance="-";
	if(!vouchernumber.equals("-"))
	{
		System.out.println("I m Here");
		sql12="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where PaymentVoucherNo ='"+vouchernumber+"'";
		
		ResultSet rs12=st2.executeQuery(sql12);
		if(rs12.next())
		{
			Balance=rs12.getString("Balance");
		}
	}
		
	
	%>
	
	
	 <tr>
		<td class="text-center"><%=i %></td>
		<td class="text-left"><%=rs123.getString("CompanyName") %></td>
		<td class="text-center"><%=rs123.getString("AmountPaid") %></td>
		<td class="text-left"><%=rs123.getString("PaymentMode") %></td>
		<td class="text-right"><%=rs123.getString("PaymentDate")%></td>
		<td class="text-center"><%=rs123.getString("ChOrDDorCreditNoteNo") %></td>
		<td class="text-center"><%=invoicenumber %></td>
		<td class="text-right"><%=rs123.getString("ChOrDDorCreditNoteDate") %></td>
		<td class="text-center"><%=vouchernumber %></td>
		<td class="text-center"><%=Balance %></td>
		<td class="text-center"><%=rs123.getString("tallyrefno") %></td>
		<td class="text-left"><%=Status1%></td>
		<td class="text-left"><%=rs123.getString("twempname") %></td>
		
	 </tr>
	 <%i++;
	 } %>
	</tbody>
	</table>
	</div>
        		<% 
        	}catch(Exception e){
        		out.println(e);
        	}
        %>
				
			<%
        }catch(Exception e){
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
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Collection Report '+$("#data").val()+' to ' +$("#data1").val(),
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