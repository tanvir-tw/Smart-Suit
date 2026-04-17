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
// Connection Initialization
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
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Contract Master Report</h5>
    </div>
</div>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a href="ContractEntryForm.jsp" style="color:blue;text-decoration:none;">Add New</a>
	    </div>
		<div class="col-2">
		   <a href="ContractorMasterReport.jsp" style="color:green;text-decoration:none;">Master Details</a>
		</div>
		<div class="col-8"></div>
	</div>

<table id="example" class="display" style="width:100%">     
<thead>
	<tr>
		<th class="col-width-4">SrNo.</th>
		<th>ID</th>
		<th>Name</th>
		<th>Email</th>
		<th>MobNo</th>
		<th>Company</th>
		<th>Designation</th>
		<th>Department</th>
		<th>ContractEnd</th>
		<th>Med.End</th>
		<th>Profile</th>
		<th>PayStructure</th>
	</tr>
</thead>
<tbody>
<%
String Id="",Name="",Email="",MobNo="",Company="",Qualification="",Stream="";
String ProfileStatus="";
String PayStructureStatus="",NewMedEndDate="",MedEndDate="";
String data="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active'"; 

System.out.println("check-------->"+data);

ResultSet rs21=st.executeQuery(data);
int i=1;
while(rs21.next())
{
	Id=rs21.getString("ContractorId");
	Name=rs21.getString("ContractorName");
	Email=rs21.getString("Email");
	MobNo=rs21.getString("MobNo");
	Company=rs21.getString("CompanyName");
	Qualification=rs21.getString("Education");
	MedEndDate=rs21.getString("MediclaimEndDate");
	Stream=rs21.getString("Stream");
	String Dept="",Designation="",ContractEndDate="";
	String NewContractEndDate="";
	 ProfileStatus="";
	 PayStructureStatus="";
	String ProfileDetails="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+Id+"'";
	ResultSet rsProfileDetails=st1.executeQuery(ProfileDetails);
	
	if(rsProfileDetails.next())
	{
	
	Dept=rsProfileDetails.getString("Department");
	Designation=rsProfileDetails.getString("Designation");
	ContractEndDate=rsProfileDetails.getString("ContractEndDate");
	ProfileStatus="Done";
	}
	
	else{
		Dept="-";
		Designation="-";
		ProfileStatus="-";
		ContractEndDate="-";
	}

	String Pay="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMaster where ContractorId='"+Id+"'";
	ResultSet rsPay=st2.executeQuery(Pay);
	if(rsPay.next())
	{
		PayStructureStatus="Done";
	}
	else
	{
		PayStructureStatus="-";
	}
	
	if(ContractEndDate.equals("-"))
	{
		NewContractEndDate="-";
	}
	else
	{
		NewContractEndDate = new SimpleDateFormat("dd-MMM-yyyy")
        .format(new SimpleDateFormat("yyyy-MM-dd")
                .parse(ContractEndDate));
	}
	
	if(MedEndDate.equals("-"))
	{
		NewMedEndDate="-";
	}
	else
	{
		NewMedEndDate = new SimpleDateFormat("dd-MMM-yyyy")
        .format(new SimpleDateFormat("yyyy-MM-dd")
                .parse(MedEndDate));
	}
	
	%>
	
	<tr>
		
		<td class="text-center"><%=i%></td>
		<td class="text-center"><%=Id%></td>
		<td class="text-left"><a href="#" onclick="senddata4('<%=Id %>','<%=Name %>')"><b><%=Name%></b></a></td>
		<td class="text-left"><%=Email%></td>
		<td class="text-right"><%=MobNo%></td>
		<td class="text-left"><%=Company%></td>
		<td class="text-left"><%=Designation%></td>
		<td class="text-left"><%=Dept%></td>
		<td class="text-right"><%=NewContractEndDate%></td>
		<td class="text-right"><%=NewMedEndDate%></td>
		<% if(ProfileStatus.equals("-"))
		{
		%>
		<td class="text-center"><a href="#" onclick="senddata('<%=Id %>','<%=Name %>')"><b>Add</b></a></td>
		<%}else{ %>
		<td class="text-center"><a href="#" onclick="senddata2('<%=Id %>','<%=Name %>')"><b>Edit</b></a></td>
		<%} %>
		
		<% if(PayStructureStatus.equals("-"))
		{
		%>
		<td class="text-center"><a href="#" onclick="senddata1('<%=Id %>','<%=Name %>')"><b>Add</b></a></td>
		<%}else{ %>
		<td class="text-center"><a href="#" onclick="senddata3('<%=Id %>','<%=Name %>')"><b>Edit</b></a></td>
		<%} %>	
</tr>	 	
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
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         
	        stateSave: true,
	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)	  
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
	                         title: 'Contract Master Report',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	                         title: 'Contract Master Report',
	                            orientation: 'landscape',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	                         title: 'Contract Master Report',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	                         title: 'Contract Master Report',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Contract Master Report',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script type="text/javascript">
 function senddata(id,Name)
 {
	 window.location="ContractProfileForm.jsp?Id="+id+"&Name="+Name+"";
 }
 
 function senddata1(id,Name)
 {
	 window.location="ContractPayStructure.jsp?Id="+id+"&Name="+Name+"";
 }
 
 function senddata2(id,Name)
 {
	 window.location="EditProfileMaster.jsp?Id="+id+"&Name="+Name+"";
 }
 
 function senddata3(id,Name)
 {
	 window.location="EditPayStructure.jsp?Id="+id+"&ContractorName="+Name+"";
 }
 
 function senddata4(id,Name)
 {
	 window.location="EditMasterForm.jsp?Id="+id+"&Name="+Name+"";
 }
 
</script>

 <%@ include file="footer.jsp" %>
 </body>
</html>