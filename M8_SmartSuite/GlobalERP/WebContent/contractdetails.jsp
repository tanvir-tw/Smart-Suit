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

String Customer1=" ", ERPCode1=" ", category1=" ", CustomerType1=" ", Frequency1=" ", BillType1=" ", ToId1=" ", ToCc1=" ", BillStatus1=" ", OperationalStatus1=" ", fromdate1=" ", todate1=" ", billday1=" ", document1=" ";
Double Rate1=0.00;

// Connection Initialization
Connection conn = null;
Statement st2=null, st3=null;
%>
<%

try {
	conn = connection.getConnect("db_GlobalERP");    
    st2 = conn.createStatement();
    st3 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Customer Contract Report</h5>
    </div>
</div>
<form name="custreport" id="custreport" method="post">
<%
int i=1;
%>
<table id="example"  class="display"  style="width:100%">
        <thead>
            <tr>
                <th class="text-center">Sr.No</th>
            	<th class="text-left">Customer</th>
            	<th class="text-center">CompanyCode</th>
                <th class="text-left">Category</th>
                <th class="text-left">CustomerType</th>
        		<th class="text-right">FromDate</th>
        		<th class="text-right">ToDate</th>
        		<th class="text-center">BillDay</th>
        		<th class="text-left">Document</th>
                <th class="text-center">Rate </th>
                <th class="text-left">Frequency </th>
 				<th class="text-left">BillType </th>
                <th class="text-left">ToId </th>
                <th class="text-left">ToCc</th>
                <th class="text-left">BillStatus</th>
                <th class="text-left">OperationalStatus </th>
            </tr>
        </thead>
        <tbody>
<%
String data = "select CustomerName,CustomerCode,ContarctFromDate,ContarctToDate,Document from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster";

	System.out.println("check-------->"+data);

	ResultSet rs21=st2.executeQuery(data);
	while(rs21.next())
	{

		Customer1=rs21.getString("CustomerName");
		ERPCode1=rs21.getString("CustomerCode");
		fromdate1=rs21.getString("ContarctFromDate");
		todate1=rs21.getString("ContarctToDate");
		document1=rs21.getString("Document");
		if(document1.startsWith(","))
		{
			document1=document1.substring(1);
		}else{
			document1="-";
		}
 String sql="select BillDay,ToId,ToCc,category,Rate,OperationalStatus,BillFrequency,BillStatus,BillType,CustomerType from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerBillMaster where CustomerCode='"+ERPCode1+"' ";

 System.out.println("sql-------->"+sql);
		ResultSet rs24=st3.executeQuery(sql);
		while(rs24.next())
		{
			category1=rs24.getString("category");
			CustomerType1=rs24.getString("CustomerType");
			Rate1=rs24.getDouble("Rate");
			Frequency1=rs24.getString("BillFrequency");
			BillType1=rs24.getString("BillType");
			ToId1=rs24.getString("ToId");
			ToCc1=rs24.getString("ToCc");
			BillStatus1=rs24.getString("BillStatus");
			OperationalStatus1=rs24.getString("OperationalStatus");
			billday1=rs24.getString("BillDay");
			String d1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate1));
			String d2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate1));
			%>
			<tr>		          
			 	<td class="text-center"><%=i%></td>
				<td class="text-left"><%=Customer1%></td>
				<td class="text-center"><%=ERPCode1%></td>
				<td class="text-left"><%=category1%></td>
				<td class="text-left"><%=CustomerType1%></td>
				<td class="text-right"><%=d1%></td>
				<td class="text-right"><%=d2%></td>
				<td class="text-center"><%=billday1%></td>
				<td class="text-left">
			    <div style="width:200px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
			        <%=document1%>
			    </div>
			</td>

				<td class="text-center"><%=Rate1%></td>
				<td class="text-left"><%=Frequency1%></td>
				<td class="text-left"><%=BillType1%></td>
				<td class="text-left"><%=ToId1%></td>
				<td class="text-left"><%=ToCc1%></td>
				<td class="text-left"><%=BillStatus1%></td>
			 	<td class="text-left"><%=OperationalStatus1%></td>
          </tr>
  <%

	
%>  
    
   <%
   i++;}
	}%>
</tbody>
</table>
</form>
</div>

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
	         fixedColumns: { 
	            left: 4      //To freeze two columns
	        }, 
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
	                         title: 'Customer contract Report', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Customer contract Report', 
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Customer contract Report', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Customer contract Report', 
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Customer contract Report', 
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