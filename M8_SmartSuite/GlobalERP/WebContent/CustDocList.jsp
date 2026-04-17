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
//Variable Declaration
String companyName="",phone="",contact="",email="",product="",city="";
	int counter=1;
	String empName="" , followUpDate="" , comments="" , reply="" , remarks="" , documentType="",documentName="";
 // Connection Initialization
Connection conn = null;
    
	Statement st = null; 

try {
	conn = connection.getConnect("db_GlobalERP");    
		st = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>
<%
String custName=request.getParameter("companyName");
custName=custName.replace("...","&");
String comid=session.getAttribute("CompanyMasterID").toString();
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Document Uploaded For <%=custName %></h5>
    </div>
</div>
<br>
<%
		try{
			companyName=request.getParameter("companyName");
 	%> 
<table id="example" class="display" style="width:100%;">   
 	<thead>
 	<tr>
 	<th class="col-width-4">Sr</th>
 	<th >Marketing Rep. Name.</th>
 	<th >Follow-up Date</th>
 	<th >Comments</th>
 	<th >Spoken To</th>
 	<th >Reply</th>
 	<th >Remarks</th>
 	<th >Document Type</th>
 	<th >Document Name</th>
 	</tr>
 	</thead>
 	<tbody>
 	<% 

 	String sql = "SELECT b.EmpName,Date_Format(a.FollowUpDate,'%d-%b-%Y') as FollowUpDate,a.Comments,a.SpokenTo,a.Reply,a.Remarks,a.DocumentType,a.DocumentName FROM db_GlobalERP."+comid+"followup AS a LEFT OUTER JOIN   db_GlobalERP."+comid+"security  AS b ON ( a.MarketingRepCode = b.EmpCode ) where a.ProspCustName='"+companyName+"' and a.DocumentStatus = 'Upload' AND (b.EmpName IS NOT NULL OR b.EmpCode IS NOT NULL ) ORDER BY  a.followupdate DESC";
 	System.out.println("sql--->"+sql);
 	ResultSet rs = st.executeQuery(sql);
 	while(rs.next()){
 		empName = rs.getString("EmpName");
 		followUpDate = rs.getString("FollowUpDate");
 		comments = rs.getString("Comments");
 		contact = rs.getString("SpokenTo");
 		reply = rs.getString("Reply");
 		remarks = rs.getString("Remarks");
 		documentType = rs.getString("Remarks");
 		documentName = rs.getString("DocumentName");
 		
 		if(remarks == null || remarks.equals("")){
 			remarks="-";
 		}
 		if(documentType == null || documentType.equals("")){
 			documentType="-";
 		}
 	%>
 	
 	<tr>
 	<td class="text-center"><%=counter++%></td>
 	<td class="text-left"><%=empName %></td>
 	<td class="text-right"><%=followUpDate %></td>
 	<td class="text-left">
    <div style="width:400px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
        <%=comments%>
    </div>
</td>
 	
 	
 	
 	
 	<td class="text-left"><%=contact %></td>
 	<td class="text-left"><%=reply %></td>
 	<td class="text-left"><%=remarks %></td>
 	<td class="text-left"><%=documentType %></td>
 <td class="text-left">
<%
if(documentName == null || documentName.equals("-") || documentName.trim().equals("")){
%>
    -
<%
}else{

    String[] tok = documentName.split(",");

    for (int ij = 0; ij < tok.length; ij++) {

        String fileName = tok[ij].trim();

        if(!fileName.equals("")){
%>
        <a href="https://twtech.in/GLOBALERP/followup/<%=java.net.URLEncoder.encode(fileName,"UTF-8")%>" 
           target="_blank">
           <%=fileName%>
        </a><br>
<%
        }
    }
}
%>
</td>
 	</tr>
 	<% }
 	
 	
 	}catch(Exception e){
 		e.printStackTrace();
 	}finally{
 		if(conn!=null){
 			conn.close();
 		}
 		
 	}%>
 	</tbody>
 	</table>
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
								title: 'Customer Document List Report  '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Customer Document List Report '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Customer Document List Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Customer Document List Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Customer Document List Report '+$("#data").val()+ 'to' +$("#data1").val(),
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