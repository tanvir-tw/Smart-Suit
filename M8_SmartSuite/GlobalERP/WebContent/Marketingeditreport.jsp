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
String group = "";
int i = 1;

Connection conn = null;
Statement st1=null,st2=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>														
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Marketing Master Report</h5>
    </div>
</div>	
		<br>
	<div class="container" style="width: 80%">
		<table id="example" class="display" style="width: 100%">
			<thead>
				<tr>
					<th class="col-width-4">SrNo.</th>
					<th>Name</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Group</th>
					<th>Edit</th>
					<th>deactivate</th>
				</tr>
			</thead>
			<tbody>
				<%
					String sql = "SELECT * FROM " + session.getAttribute("CompanyMasterID").toString()+ "marketingrepmaster   WHERE username<>'' AND password<>''  AND ("+ " OtherGroups=1 OR Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1) order by MarketingRepName";
						ResultSet rs = st.executeQuery(sql);
						while (rs.next()) {
							String MarketingRepName="",MarketingRepEMail="",MarketingRepPhNo="";
							
							MarketingRepName = rs.getString("MarketingRepName");
							MarketingRepEMail = rs.getString("MarketingRepEMail");
							MarketingRepPhNo = rs.getString("MarketingRepPhNo");
							
							if (rs.getInt("Compressor") == 1) {
								group = "Compressor";
							}
							if (rs.getInt("DigitalEquipment") == 1) {
								group = "DigitalEquipment";
							}
							if (rs.getInt("DGSet") == 1) {
								group = "DGSet";
							}
							if (rs.getInt("Endoscope") == 1) {
								group = "Endoscope";
							}
							if (rs.getInt("OtherGroups") == 1) {
								group = "OtherGroups";
							}
				%>
				<tr>
					<td class="text-center"><%=i++%></td>
					<td class="text-left"><%=MarketingRepName%></td>
					<td class="text-left"><%=MarketingRepEMail%></td>
					<td class="text-center"><%=MarketingRepPhNo%></td>
					<td class="text-left"><%=group%></td>
					<td class="text-center"><a href="#" style="font-weight: bold; color: black;" onclick="popup('<%=MarketingRepName%>');"> <img src="images/edit1.jpeg" width="20px" height="18px"style="border-style: none"></img></a></td>
					<td class="text-left"> <a href="#" onclick="popup2('<%=MarketingRepName%>');">Deactivate</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		</div>
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
	                         title : 'Marketingedit Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title : 'Marketingedit Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title : 'Marketingedit Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title : 'Marketingedit Report ',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title : 'Marketingedit Report ',
	                     
							},
 
					],
				},
           ], 
       
       });

   });
   </script>  

<script>
function popup(repname)
{
	window.open("addNewMarketingRep.jsp?type=edit&repname="+repname,'jav');
}

function popup2(repname)
{
	  var agree=confirm("Do You Really Want To Deactivate This User ?");
	   if(agree)
	   {
		   var ajaxRequest;  // The variable that makes Ajax possible!
			try
			{
				ajaxRequest = new XMLHttpRequest();
			}  
			catch (e)
			{
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
					if(reslt="Yes")
					{
				alert("User Deactivated Sussessfully.");
					}
					else if(reslt="No")
					{ 
						 alert("User is Not Deactivated.Pls Try Again !! ");
								
					}
							reload();
				} 
			}
			var queryString = "?repname="+repname;
			try
			{
				ajaxRequest.open("GET", "deactivateuser.jsp" + queryString, true);
				ajaxRequest.send(null);
			} 
			catch (e) 
			{
				alert(e);
			} 
	  }
	   else
	   {
		   return false;
	   }
}

function reload()
{
	window.location.reload();
} 
	</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>