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
	String fname="",UpdatedDateTime="",UploadedBy="";
	int srno=0,sn=1,i=0;
 // Connection Initialization
 Connection conn =null;
 Statement st1=null;

try {
	conn = connection.getConnect("db_leaveapplication");    	
	st1=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
}  
%>
<%		
			DateFormat d1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			DateFormat d2=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
			%> 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">

						<div class="row breadcrumbs-top">
								<%	if(request.getParameter("validity").equals("invalid")){ %>
								
								
									<h5 class="content-header-title text-center mb-0"style="color: #060637">
										<b>Invalid Document Report</b>
									</h5>
									
									<% }
								else if(request.getParameter("validity").equals("duplicate")) {	
	
%> 
<h5 class="content-header-title text-center mb-0"style="color: #060637">
										<b>Duplicate Document Report</b>
									</h5>
									
									<%} %>	
								</div>
</div>

<br>
<div class="container" style="width: 70%">
<table id="example" class="display" style="width:100%;">       
    <thead>
  <tr>
    <th class="col-width-4">Sr.</th>
    <th>File Name</th>
    <th>Upload Date</th>
    <th>Uploaded By</th>
    <th>Mark As</th>
  </tr>
</thead>
            <tbody>
           <%
int trcnt=0;
try
{	
	String sqlData="";
		if(request.getParameter("validity").equals("invalid"))
		{
		sqlData="select * from t_uploadedFiles where FileStatus='Invalid' ";
		}
		else if(request.getParameter("validity").equals("duplicate"))
		{
			sqlData="select * from t_uploadedFiles where FileStatus='Duplicate' ";
		}
		
	ResultSet rs1=st1.executeQuery(sqlData);
	System.out.println(sqlData);
	while(rs1.next())
	{
		fname=rs1.getString("FileName");
		srno=rs1.getInt("SrNo");
		UpdatedDateTime = rs1.getString("UpdatedDateTime");
		UploadedBy = rs1.getString("UploadedBy");
		UpdatedDateTime = rs1.getString("UpdatedDateTime");
		UpdatedDateTime = rs1.getString("UpdatedDateTime");
		%>
					<tr>
						<td class="text-center"><%=sn++%></td>
						<td class="text-left"><%=fname%></td>
						<td class="text-right"><%=d2.format(d1.parse(UpdatedDateTime))%>
						</td>
						<td class="text-left"><%=UploadedBy.toString()%></td>
						<%
						if (request.getParameter("validity").equals("invalid")) {
						%>
						<td class="text-left"><a href="#" onclick="settovalid('<%=fname%>','3')">Valid</a></td>
						<%
						} else if (request.getParameter("validity").equals("duplicate")) {
						%>
						<td class="text-left"><a href="#" onclick="settovalid('<%=fname%>','4')">Valid</a></td>
						<%
						}
						%>
					</tr>
					<%
					i++;
					}
					%>
	</tbody>
	</table>
</div>
			<input type="hidden" name="chbxCnt" id="chbxCnt" value="<%=i %>" />
			<input type="hidden" name="filename" id="filename" value="<%=fname%>" />
			
			<%
}
catch(Exception e)
{
	System.out.println("Thumbnail Exception======>>"+e);	
}

%>
</div>
<script type="text/javascript">
function settovalid(filename,id)
{
	var filename=filename;
	var id=id;
	var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			alert("File Status Updated.");
			reload();
		} 
	}
	var queryString = "?fname="+filename+"&id="+id;
	try
	{
		ajaxRequest.open("GET", "ValidandDuplicateDocs.jsp" + queryString, true);
		ajaxRequest.send(null);
	} 
	catch (e) 
	{
		alert(e);
	}	
}

function reload()
{

	window.location.reload();
}
</script>
 <% 
String reportTitle = "";
if(request.getParameter("validity").equals("invalid")) {
    reportTitle = "Invalid Document Report";
} else if(request.getParameter("validity").equals("duplicate")) {
    reportTitle = "Duplicate Document Report";
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
	                         title: '<%=reportTitle%>',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: '<%=reportTitle%>',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: '<%=reportTitle%>',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: '<%=reportTitle%>',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: '<%=reportTitle%>',
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
 