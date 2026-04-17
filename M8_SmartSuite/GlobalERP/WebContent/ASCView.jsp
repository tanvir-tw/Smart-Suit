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
String Company="",Id="",InvoiceNo="";
String Amcfromdate="",Amctodate="",Ownername="";
String Vehicle="", Transporter="", Installed="", Remove="", Status="", Billable="", LastASC="", ASCFrom="", ASCTo="", Days="", Age="", Rate="", Amount="", Itemcode="", RatePerDay="", Description="";
String ASCfromdate="",ASCtodate="";

Connection conn = null;
Statement st1=null,st2=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1=conn.createStatement();
	st2=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

%>

<%
try{
	
Id=request.getParameter("Id");
Company=request.getParameter("company");

String Data="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ASCSummaryDetails where SRNumber='"+Id+"' and Ownername='"+Company+"'";
System.out.println("Data---------sql"+Data);
ResultSet rs1=st1.executeQuery(Data);

if(rs1.next());
{
	Amcfromdate=rs1.getString("Amcfromdate"); 
	Amctodate=rs1.getString("Amctodate"); 
	Ownername=rs1.getString("Ownername");
	InvoiceNo=rs1.getString("InvoiceNumber");
}

Amcfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Amcfromdate));
Amctodate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Amctodate));
ASCfromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Amcfromdate));
ASCtodate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Amctodate));

System.out.println("FromDate---------"+ASCfromdate);
System.out.println("ToDate---------"+ASCtodate);


%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">ASC Summary For <%=Ownername%> From <%=Amcfromdate %> To <%=Amctodate %></h5>
    </div>
</div>
	<div class="row">
	    <div class="col-2 ms-5" style="max-width:10%;">		
   			<b><a href="AMCAnnexture.jsp?owner=<%=Company%>&Invoiceno=<%=InvoiceNo%>" target="_blank" style="text-decoration: none">Summary</a></b>
	</div>
	    
	
		<div class="col-10"></div>
	</div>


		  <div class="row col-12">
		    <div class="col-md-1">
		
		    </div>
		    <div class="col-md-9"></div>
		    </div>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Vehicle</th>
            <th>Transporter</th>
            <th>Installed</th>
            <th>Remove</th>
             <th>Status</th>
            <th>BillAble</th>
            <th>LastASC</th>
            <th>ASCFrom</th>
            <th>ASCTo</th>
            <th>Days</th>
            <th>Age</th>
            <th>Rate </th> 
            <th>Amount</th>
            <th>Item Code</th>
            <th>RatePerDay</th>
            <th>Description</th>
            </tr>
       </thead>
    
            <tbody>
            
           <%
           int i=1;
           String query ="select vehiclecode,vehicleNumber,Ownername,date_format(installeddate,'%d-%b-%Y') as installeddate,date_format(removeddate,'%d-%b-%Y') as removeddate,date_format(asnewremove,'%d-%b-%Y') as asnewremove,status,date_format(todaysdate,'%d-%b-%Y') as todaysdate,active,exclude,billable,date_format(warrenty,'%d-%b-%Y') as warranty ,date_format(amccovered,'%d-%b-%Y') as amccovered, date_format(newwarranty1,'%d-%b-%Y') as newwarranty1,date_format(billfrom,'%d-%b-%Y') as billfrom,date_format(billto,'%d-%b-%Y') as billto,days,age,rate,round(amount) as amount,itemcode,sellingprice,ItemDescription   from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"VehASCSummaryDetails where  Ownername='"+Ownername+"' and invoicestatus!='Deleted'";
           System.out.println("queryvvvvvvvvvvv:::::"+query);			
           	ResultSet rs=st2.executeQuery(query);

           	while(rs.next()){ 

           		Vehicle = rs.getString("vehicleNumber");
           		Transporter = rs.getString("Ownername");
           		Installed = rs.getString("installeddate");
           		Remove = rs.getString("removeddate");
           		Status = rs.getString("status");
           		Billable = rs.getString("billable");
           		LastASC = rs.getString("amccovered");
           		ASCFrom = rs.getString("billfrom");
           		ASCTo = rs.getString("billto");
           		Days = rs.getString("days");
           		Age = String.format("%.2f", Double.parseDouble(rs.getString("age")));
           		Rate = rs.getString("rate");
           		Amount = rs.getString("amount");
           		Itemcode = rs.getString("itemcode");
           		RatePerDay = rs.getString("sellingprice");
           		Description = rs.getString("ItemDescription");
           		if (Remove == null || Remove.trim().isEmpty() || "null".equalsIgnoreCase(Remove.trim())) {
           		    Remove = "-";
           		}
           %>
           <tr>
		        <td class="text-center"><%=i%></td>
		        <td class="text-left"><%=Vehicle%></td>
		        <td class="text-left"><%=Transporter%></td>
		        <td class="text-right"><%=Installed%></td>
		        <td class="text-left"><%=Remove%></td>
		        <td class="text-left"><%=Status%></td>
		        <td class="text-left"><%=Billable%></td>
		        <td class="text-right"><%=LastASC%></td>
		        <td class="text-right"><%=ASCFrom%></td>
		        <td class="text-right"><%=ASCTo%></td>
		        <td class="text-center"><%=Days%></td>
		        <td class="text-right"><%=Age%></td>
		        <td class="text-center"><%=Rate%></td>
		        <td class="text-center"><%=Amount%></td>
				<td class="text-center"><%=Itemcode%></td>
		        <td class="text-center"><%=RatePerDay%></td>
		        <td class="text-left"><%=Description%></td>
            </tr>
               <%i++;} %>
            </tbody>
</table>
</div>
<%
}
catch(Exception e)
{
	e.printStackTrace();
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
	                         title : 'ASC Summary Report',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title : 'ASC Summary Report',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title : 'ASC Summary Report',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title : 'ASC Summary Report',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title : 'ASC Summary Report',
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
