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
Statement st = null;

ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;


try {
	conn = connection.getConnect("db_GlobalERP");    
	stmt=conn.createStatement();
	stmt1=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%> 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Contractor Details</h5>
    </div>
</div>

<form name="custreport" id="custreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-5"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="Status" name="Status" onblur="check()">
                             		<option value="Active" selected="selected">Active</option>				
									<option value="DeActive" >DeActive</option>
                           </select>
                            <script>
                            const mySel = document.getElementById("Status");

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
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			<div class="col-md-3"></div>
		</div>
		</form>
		<br>

<%
try{
String type=request.getParameter("Status");
System.out.println("type"+type);
if(type==null)
{
	type="Active";
%>
	<script>
	document.getElementById("Status").value = 'Active';
	</script>
<% }

else
{
	%>
<script>
document.getElementById("Status").value = '<% out.print(type); %>';
</script>
<% 
}
 %>

<table id="example" class="display" style="width:100%;">    
<thead>

		<tr>
				<th class="col-width-4">SrNo.</th>
				<th>Id</th>
				<th>Name</th>
				<th>Department</th>
				<th>Contractor Number</th>
				<th>Contractor Email</th>
				<th>Designation</th>
				<th>Renew Date</th>
				<th>Permanent Address</th>
				<th>Date Of Birth</th>
				<th>Marital Status</th>
				<th>Blood Group</th>
				<th>Pan Card</th>
				<th>Education</th>
				<th>Stream</th>
				<th>Mediclaim Policy No</th>
				<th>Fee(Month)</th>
				<th>PI</th>
				<th>KRA</th>
				<th>Fixed</th>
				<th>Vehicle</th>
				<th>Mobile</th>
				<th>Laptop</th>
				<th>Proximity</th> 
				<th>TDS</th>
				<th>Contract Start</th>
				<th>Contract End</th>
				<th>Status</th>

<%if(type.equalsIgnoreCase("Active"))
	{%>
 <th>Deactivate</th>
 <%} %>
	</tr>
</thead>
<tbody>

<%
if (type == null || type.equals("null")) {
    type = "Active";
}
%>

<script>
// Set the select value after DOM is fully loaded
window.addEventListener('DOMContentLoaded', function () {
    var statusSelect = document.getElementById("Status");
    if (statusSelect) {
        statusSelect.value = "<%= type %>";
    }
});
</script>
<% 

String query="",PermanentAddress="";
String EmpName="",dt="",DateOfBirt="",MaritalStatus="",BloodGroup="",PanCard="",Education="",Stream="",MediclaimPolicyNo="";

if(type!=null)
{
	query="select a.ContractorId,a.ContractorName,a.Status,a.PanCard,a.MediclaimPolicyNo,a.PermanentAddress,a.Stream,a.Education,a.DateOfBirt,a.BloodGroup,a.MaritalStatus,ContractFeePerMonth,PIFee,KRAFee,FixedFee,VehicleAllowance,MobileAllowance,LaptopAllowance,ProximityAllowance,TDSPercent from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew a,db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorPayMaster b  where a.ContractorId=b.ContractorId and a.Status='"+type+"' order by a.ContractorName";
	 System.out.println("---"+query);
	 rs=stmt.executeQuery(query);

 
 System.out.println("Inside Active");
 
 
 

 int i=1;
 
 while(rs.next())
 {
	
	
	 String ContractorId="",ContractorName="",ContractFeePerMonth="",ContractorOfficialNumber="",ContractorOfficialEmail="",Designation="",RenewDate="";
	 String PIFee="";
	 String KRAFee="";
	 String FixedFee="";
	 String VehicleAllowance="";
	 String MobileAllowance="";
	 String LaptopAllowance="";
	
	 String TDSPercent="";
	 String Status="";
	 String ProximityAllowance="";
	 
	 MediclaimPolicyNo=rs.getString("a.MediclaimPolicyNo");
if(MediclaimPolicyNo=="")
{
	MediclaimPolicyNo="-";
}
	 ContractorId=rs.getString("ContractorId");
	 Status=rs.getString("a.Status");
	 Education=rs.getString("a.Education");

	 Stream=rs.getString("a.Stream");
if(Stream=="")
{
	Stream="-";
}
	 
	 BloodGroup=rs.getString("a.BloodGroup");
	 PanCard=rs.getString("a.PanCard");

	 if(PanCard=="")
	 {
		 PanCard="-";
	 }
	 
		PIFee=rs.getString("PIFee");
		DateOfBirt=rs.getString("a.DateOfBirt");
		MaritalStatus=rs.getString("a.MaritalStatus");
if(MaritalStatus.equals("null") || MaritalStatus==null || MaritalStatus=="null")
{
	MaritalStatus="-";
}
		PermanentAddress=rs.getString("a.PermanentAddress");
	KRAFee=rs.getString("KRAFee");
	FixedFee=rs.getString("FixedFee");
	VehicleAllowance=rs.getString("VehicleAllowance");
	MobileAllowance=rs.getString("MobileAllowance");
	LaptopAllowance=rs.getString("LaptopAllowance");
	TDSPercent=rs.getString("TDSPercent");
	ProximityAllowance=rs.getString("ProximityAllowance");
	ContractFeePerMonth =rs.getString("ContractFeePerMonth");
	PIFee =rs.getString("PIFee");
	ContractorId =rs.getString("ContractorId");
	ContractorName =rs.getString("ContractorName");

	ProximityAllowance =rs.getString("ProximityAllowance");		TDSPercent =rs.getString("TDSPercent");		

	String contractStatus="";	
	String querystatus="";	
	
	querystatus="select ContractStartDate,ContractEndDate,ContractorOfficialNumber,ContractorOfficialEmail,Designation,RenewDate,Department,curdate() as todaysdate from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster where ContractorId='"+ContractorId+"'";
	
	System.out.println("querystatus:::"+querystatus);	 
	String ContractStartDate="",ContractEndDate="",Department="";
	ResultSet rs12=stmt1.executeQuery(querystatus);
	
	if(rs12.next())
	{
		ContractStartDate=rs12.getString("ContractStartDate");
		ContractEndDate=rs12.getString("ContractEndDate");
		Department=rs12.getString("Department");
		
		ContractorOfficialNumber=rs12.getString("ContractorOfficialNumber");
		ContractorOfficialEmail=rs12.getString("ContractorOfficialEmail");
		Designation=rs12.getString("Designation");
		RenewDate=rs12.getString("RenewDate");

		Date sdate=rs12.getDate("ContractStartDate");
		Date edate=rs12.getDate("ContractEndDate");
		
		Date todaysdate=rs12.getDate("todaysdate");
		if(Status.equals("Active"))
		{
		try
		{
			if(todaysdate.compareTo(edate) > 0)
			{
				contractStatus="Active Contract Expired";
			}
			if(todaysdate.compareTo(edate)<0)
			{
				contractStatus="Active";
			}
			if(todaysdate.equals(edate))
			{
				contractStatus="Active";
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		}
		else{
			contractStatus=Status;
		}
	}	

	System.out.println("contractStatus :- "+contractStatus);

	String dt1="";
	try
	{
	 dt1= new SimpleDateFormat("dd-MMM-yyyy")
	        .format(new SimpleDateFormat("yyyy-MM-dd")
	                .parse(ContractStartDate));
	}
	catch(Exception e)
	{
		dt1="-";
	}
	
	String dt2="";
	
	try
	{
	dt2= new SimpleDateFormat("dd-MMM-yyyy")
	        .format(new SimpleDateFormat("yyyy-MM-dd")
	                .parse(ContractEndDate));
	}
	catch(Exception e)
	{
		dt2="-";
	}
		%>
		 <tr>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=ContractorId%></td>
						<td class="text-left"><%=ContractorName%></td>
						<td class="text-left"><%=Department%></td>
						<td class="text-center"><%=ContractorOfficialNumber%></td>
						<td class="text-left"><%=ContractorOfficialEmail%></td>
						<td class="text-left"><%=Designation%></td>
						<td class="text-right"><%=RenewDate%></td>
						<td class="text-left"><%=PermanentAddress%></td>
						<td class="text-right"><%=DateOfBirt%></td>
						<td class="text-left"><%=MaritalStatus%></td>
						<td class="text-left"><%=BloodGroup%></td>
						<td class="text-left"><%=PanCard%></td>
						<td class="text-left"><%=Education%></td>
						<td class="text-left"><%=Stream%></td>
						<td class="text-center"><%=MediclaimPolicyNo%></td>
						<td class="text-right"><%=ContractFeePerMonth%></td>
						<td class="text-center"><%=PIFee%></td>
						<td class="text-center"><%=KRAFee%></td>
						<td class="text-center"><%=FixedFee%></td>
						<td class="text-center"><%=VehicleAllowance%></td>
						<td class="text-center"><%=MobileAllowance%></td>
						<td class="text-center"><%=LaptopAllowance%></td>
						<td class="text-center"><%=ProximityAllowance%></td>
						<td class="text-center"><%=TDSPercent%></td>	
						<td class="text-right"><%=dt1%></td>
						<td class="text-right"><%=dt2%></td>
						<td class="text-left"><%=contractStatus %></td>
							<%
							if(type.equals("Active") || type.equalsIgnoreCase("Active"))
									{
								%>			
						<td class="text-center">
			
						<a href="#" onclick="demo('<%=ContractorId%>','<%=ContractorName%>')"><%=("Deactive")%></a></td>
			
					<%} %>
		 </tr>
		 <% i++;
	
 }
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
	                         title: 'Contractor Details',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Contractor Details',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Contractor Details',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Contractor Details',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Contractor Details',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script>
function demo(ContractorId,ContractorName)
{
	 var  agree=confirm("You Want To Deactivate Contractor !");
    	if(agree)
	  	{		 
    	 	var li=location.assign("FinalDeac.jsp?comment1="+ContractorId);
		 	return true ;			 
	  	}	  	   
	  	else
	  	{
	     	return false ;
	  	}	  	   
}
</script>
<script type="text/javascript">

function check()
	{
		var v=document.getElemetbyId("Status").value;
		alert(v);
	}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>