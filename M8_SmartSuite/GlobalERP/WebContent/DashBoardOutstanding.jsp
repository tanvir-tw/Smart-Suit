 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*" import="java.util.Date"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<style>
    #delete {
    text-decoration: none;
    font-size: inherit;
    font-weight: bold;
    }
</style>
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
String name1=request.getParameter("EmpName"); 
String EmpCode=request.getParameter("repCode");
String CustCode="",companyName="";
int i=1;

// Connection Initialization
Connection conn = null;
Statement st1 = null,st2=null;

try {
	conn = connection.getConnect("db_GlobalERP"); 
	st1 = conn.createStatement();
	st2 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%try{%>
<input type="hidden" name="OutName" id="OutName" value="<%=name1%>">
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">OutStanding Details Of Customers Assigned To  <%=name1 %></h5>
    </div>
</div>
<br><br>
 <div class="container" style="width:60%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
<th class="col-width-4">SrNo</th>
<th>Company</th>
<th>Balance</th>
  </tr>
        </thead> 
        <tbody>

<% 
String Cust="select distinct(salescustomercode) as Customercode,CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  where AllocatedTo = '"+EmpCode+"' and salescustomercode!='0' order by CompanyName";
ResultSet rscust=st1.executeQuery(Cust);
	System.out.println("Cust :- "+Cust);
	 
	 while(rscust.next())
	 {
		 CustCode=rscust.getString("Customercode");
	     companyName=rscust.getString("CompanyName");
		 
		 /* Date date1=rs.getDate(11);
		 Date date2=rs.getDate(12); */
		
		 
		 /* double d=rs.getDouble(3);
		 
		String amount=new DecimalFormat("0.00").format(d);
		  */
		  String balance="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where customercode in ('"+CustCode+"') order by TransactionId desc limit 1";
			System.out.println("Balance :- "+balance);
			ResultSet rsbalance=st2.executeQuery(balance);
			
			double bal=0.00;
				if(rsbalance.next())
				{
				    bal=rsbalance.getDouble("Balance");
				}
		 
				String amount1=new DecimalFormat("0.00").format(bal);
		 %>
	<tr>

	<td class="text-center"><%=i%></td>
	<td class="text-left"><%=companyName%></td>
	<td class="text-right"><%=amount1%></td>

</tr>	
<% 	
	  i++;
	}
%>
        </tbody>
 </table>
 </div>
 </div>

 
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	      /*    fixedColumns: { 
	            left: 3      //To freeze two columns
	        },  */
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
		                        title: 'OutStanding Details Report of '+$("#OutName").val(), 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'OutStanding Details Report of '+$("#OutName").val(), 
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'OutStanding Details Report of '+$("#OutName").val(), 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'OutStanding Details Report of '+$("#OutName").val(), 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'OutStanding Details Report of '+$("#OutName").val(), 
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