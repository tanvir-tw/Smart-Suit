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
Statement st=null;
String  month="",monthname="";
int i=1;
String OwnerName="",VehicleCode="",Vehicle="",Installed="",InstalledPlace="",InstalledBy="",LastReplace="";
String sql="";
String Description="",Status="",MonthlyRental="",VehicleType="",EmpName="",EmpCode="";

try {

	conn = connection.getConnect("db_GlobalERP");    
	st = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
}

String Year=request.getParameter("year");
month=request.getParameter("month");
monthname=new SimpleDateFormat("MMM").format(new SimpleDateFormat("MM").parse(month)); 

try{
String ownername=request.getParameter("ownername");
String status=request.getParameter("status");

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=status %> Summary Report of <%=ownername %> For <%=monthname%>_ <%=Year %></h5>
    </div>
</div>

	<input type="hidden" id="ownername" name="ownername" value="<%=ownername %>">
	<input type="hidden" id="month" name="month" value="<%=month %>">
    <input type="hidden" id="monthname" name="monthname" value="<%=monthname %>">
	<input type="hidden" id="year" name="year" value="<%=Year %>">
	<input type="hidden" id="status" name="status" value="<%=status %>">
 <br>
<table id="example" class="display" style="width:100%;">        
<thead>
	<tr>
			<th class="col-width-4">SrNo.</th>
			<th>OwnerName</th>
			<th>VehicleCode</th>
			<th>Vehicle</th>
			<th>Installed</th>
			<th>InstalledPlace</th>
			<th>InstalledBy</th>
			<th>LastReplace</th>
			<th>Description</th>
        	<th>Status</th>
	        <th>MonthlyRental</th>
			<th>VehicleType</th>
			<th>EmpName</th>
        	<th>EmpCode</th>
	</tr>
	</thead>
	<tbody>
	<%
	
	if(status.equalsIgnoreCase("Billed") ){
		 sql="select OwnerName,VehicleCode,VehicleRegNumber as Vehicle ,Date_Format(InstalledDate,'%d-%b-%Y %H:%i') as Installed,InstalledPlace,InstalledBy,Date_Format(LastReplacementDate,'%d-%b-%Y %H:%i' ) as LastReplace,Description,Status,MonthlyRental,vehtype as VehicleType,Empname as EmpName,Empcode as EmpCode from db_gps.t_vehicledetails  where VehicleCode in (select  vehid from db_GlobalERP.100000fv_erp_relation"+Year+"_"+month+") and OwnerName='"+ownername+"' order by  VehicleRegNumber desc";
	}else if(status.equalsIgnoreCase("Billable")){
		 sql="select OwnerName,VehicleCode,VehicleRegNumber as Vehicle ,Date_Format(InstalledDate,'%d-%b-%Y %H:%i') as Installed,InstalledPlace,InstalledBy,Date_Format(LastReplacementDate,'%d-%b-%Y %H:%i' ) as LastReplace,Description,Status,MonthlyRental,vehtype as VehicleType,Empname as EmpName,Empcode as EmpCode from db_gps.t_vehicledetails  where OwnerName='"+ownername+"' order by  VehicleRegNumber desc";
    }else{
	  sql="select OwnerName,VehicleCode,VehicleRegNumber as Vehicle ,Date_Format(InstalledDate,'%d-%b-%Y %H:%i') as Installed,InstalledPlace,InstalledBy,Date_Format(LastReplacementDate,'%d-%b-%Y %H:%i' ) as LastReplace,Description,Status,MonthlyRental,vehtype as VehicleType,Empname as EmpName,Empcode as EmpCode from db_gps.t_vehicledetails  where VehicleCode not in (select  vehid from db_GlobalERP.100000fv_erp_relation"+Year+"_"+month+") and OwnerName='"+ownername+"' order by  VehicleRegNumber desc";
	}
	System.out.println("Sql :- "+sql);
	
	ResultSet rs=st.executeQuery(sql);
		while(rs.next())
		{
			OwnerName=rs.getString("OwnerName");
			VehicleCode=rs.getString("VehicleCode");
			Vehicle=rs.getString("Vehicle");
			Installed=rs.getString("Installed");
			InstalledPlace=rs.getString("InstalledPlace");
			InstalledBy=rs.getString("InstalledBy");
			LastReplace=rs.getString("LastReplace");
			Description=rs.getString("Description");
			Status=rs.getString("Status");
			MonthlyRental=rs.getString("MonthlyRental");
			VehicleType = (rs.getString("VehicleType").equalsIgnoreCase("null")) ? "-" : rs.getString("VehicleType");
			EmpName=rs.getString("EmpName");
			EmpCode=rs.getString("EmpCode");
	 %>
	 <tr>
				<td class="text-center"><%=i %></td>
				<td class="text-left"><%=OwnerName %></td>
				<td class="text-center"><%= VehicleCode %></td>
				<td class="text-left"><%= Vehicle %></td>
				<td class="text-right"><%= Installed %></td>
				<td class="text-left"><%= InstalledPlace %></td>
				<td class="text-left"><%= InstalledBy %></td>
				<td class="text-right"><%= LastReplace %></td>
				<td class="text-left"><%= Description %></td>
				<td class="text-left"><%= Status %></td>
				<td class="text-center"><%= MonthlyRental %></td>
				<td class="text-left"><%= VehicleType %></td>
				<td class="text-left"><%= EmpName %></td>
				<td class="text-center"><%= EmpCode %></td>
							
						<%
			i++;
		} 
	
	%>	
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
		                        title:$("#status").val()+' Summary Report of '+$("#ownername").val()+' For '+$("#monthname").val()+'_'+$("#year").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title:$("#status").val()+' Summary Report of '+$("#ownername").val()+' For '+$("#monthname").val()+'_'+$("#year").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title:$("#status").val()+' Summary Report of '+$("#ownername").val()+' For '+$("#monthname").val()+'_'+$("#year").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title:$("#status").val()+' Summary Report of '+$("#ownername").val()+' For '+$("#monthname").val()+'_'+$("#year").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title:$("#status").val()+' Summary Report of '+$("#ownername").val()+' For '+$("#monthname").val()+'_'+$("#year").val(),
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