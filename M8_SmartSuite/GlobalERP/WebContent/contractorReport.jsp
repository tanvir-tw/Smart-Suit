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
<body>
<%
Connection conn = null;
Statement st1=null,st2=null,st3=null;
try {

	conn = connection.getConnect("db_leaveapplication");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
String joinDate="",dateOfDate="",conexdate="",contractDate="",claimexdate="",companyName="",deptName="";
%>
	<%
String dspData1=request.getParameter("EmpID");
String dspData2=request.getParameter("EmpName");
String dspData3=request.getParameter("Empemail");
String dspData4=request.getParameter("sendMsg");
%>
	<input type="hidden" name="dspData1" id="dspData1" value="<%=dspData1 %>"></input>
	<input type="hidden" name="dspData2" id="dspData2" value="<%=dspData2 %>"></input>
	<input type="hidden" name="dspData3" id="dspData3" value="<%=dspData3 %>"></input>
	<input type="hidden" name="dspData4" id="dspData4" value="<%=dspData4 %>"></input>
	<%
if(!(dspData4==null))
 {
 	System.out.println("==="+dspData1+"====="+dspData2+"======"+dspData3+"======="+dspData4+"=======");
 %>
	<script lang="JavaScript" type="text/javascript">
 	var d1=document.getElementById("dspData1").value;
 	var d2=document.getElementById("dspData2").value;
 	var d3=document.getElementById("dspData3").value;
 	var d4=document.getElementById("dspData4").value;
 	alert("\t"+d4+"\n\nEmp ID:"+d1+"\nEmp Name:"+d2+"\nEmp Mail:"+d3);
 	</script>
	<% 
 }
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Contractor Report</h5>
    </div>
</div>

<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a href="employeeRegistration.jsp" style="color:blue; text-decoration:  none;">Add</a>
	    </div>
		<div class="col-10"></div>
	</div>
<form name="contractorReport" id="contractorReport" method="post">
	<table id="example" class="display" style="width: 100%;"> 
   		<thead>
			<tr>
					<th>Delete</th>
					<th>Edit</th>
					<th>SrNo</th>
					<th>Contractor<br>ID
					</th>
					<th>Contractor Name</th>
					<th>Company Name</th>
					<th>Joining Date</th>
					<th>Department</th>
					<th>Designation</th>
					<th>Contact No</th>
					<th>Email</th>
					<th id="bdate" style="display: none;">Date Of Birth</th>
					<th id="mstatus" style="display: none;">Marital-Status</th>
					<th id="add" style="display: none;">Address</th>

					<th id="cdate" style="display: none;">Contract Date</th>
					<th id="cedate" style="display: none;">Contract <br>Expiry-Date</th>
					<th id="dfile" style="display: none;">Contract<br>Document File</th>

					<th id="accno" style="display: none;">Account No</th>
					<th id="bankname" style="display: none;">Bank Name</th>
					<th id="brname" style="display: none;">Branch Name</th>
					<th id="ifcs" style="display: none;">IFCS Code</th>
					<th id="pno" style="display: none;">Pan No.</th>

					<th id="policyno" style="display: none;">Policy No.</th>
					<th id="coname" style="display: none;">Company Name</th>
					<th id="exdate" style="display: none;">DateOfExpiry</th>
					<th id="camount" style="display: none;">Claim Amount</th>
					<th id="mfile" style="display: none;">Mediclaim-File</th>

					<th id="contname" style="display: none;">Contact Person Name</th>
					<th id="contno" style="display: none;">Contact No</th>
					<th id="cperadd" style="display: none;">Address</th>
					<th id="rel" style="display: none;">Relationship</th>
				</tr>
		</thead>
		<tbody>
				<% 
int i=0;
String sql="select * from t_employee where Status='Active'";
ResultSet rs=st3.executeQuery(sql);
while(rs.next())
{ 
	i++;
     try{
    	 String sql1="select OurCompanyName from t_ourcompanydet where CompanyCode='"+rs.getString("CompanyCode")+"'";
    	 ResultSet rs1=st1.executeQuery(sql1);
	     if(rs1.next())
	     {
	    	 companyName=rs1.getString(1);
	     }
         
	     String sql2="select DeptName from t_department where ComapanyCode='"+rs.getString("CompanyCode")+"' and DeptCode='"+rs.getString("DeptID")+"'";
   	    
	     ResultSet rs2=st2.executeQuery(sql2);
	     if(rs2.next())
	     {
	    	 deptName=rs2.getString(1);
	     }
       
     joinDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("DateofJoining"))); 
     System.out.println("JoinDate "+joinDate);
     
     dateOfDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("DateOfBirth"))); 
     System.out.println("dateOfDate "+dateOfDate);
     
      contractDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("ContractDate"))); 
      System.out.println("contractDate "+contractDate);
      
      conexdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("ContractExpDate"))); 
      System.out.println("conexdate "+conexdate);
      
      claimexdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("ExpiryDateClaim"))); 
      System.out.println("claimexdate"+claimexdate );
     }catch(Exception e){
    	 
    	 e.printStackTrace();
     }
%>
				<tr>
				
					<td class="text-center">
					<a href="#" style="font-weight: bold; color: black;" onclick="DeleteRow('<%=rs.getString("EmpID")%>');">
					<i class='bx bxs-trash' style="color:red;font-size: 20px;"></i></a></td>
					
					<td><a href="EmployeeEditForm.jsp?empid=<%=rs.getString("EmpID")%>" style="font-weight: bold; color: black;" onclick="">
					<i class='bx bxs-edit' style="color:green;font-size: 20px;"></i></a></td>
					
					<td class="text-center"><%=i%></td>
					<td class="text-center"><%=rs.getString("EmpID") %></td>
					<td class="text-left"><%=rs.getString("EmpName") %></td>
					<td class="text-left"><%=companyName%></td>
					<td class="text-right"><%=joinDate%></td>
					<td class="text-left"><%=deptName%></td>
					<td class="text-left"><%=rs.getString("designation") %></td>
					<td class="text-center"><%=rs.getString("EmpContactNo")%></td>
					<td class="text-left"><%=rs.getString("Empemail")%></td>
					<td class="text-left" id="bdate<%=i%>" style="display: none;"><%=dateOfDate%></td>
					<td class="text-left" id="mstatus<%=i%>" style="display: none;"><%=rs.getString("MarialStatus")%></td>
					<td class="text-left" id="add<%=i%>" style="display: none;"><%=rs.getString("AddressEmp")%></td>

					<td class="text-right" id="cdate<%=i%>" style="display: none;"><%=contractDate%></td>
					<td class="right" id="cedate<%=i%>" style="display: none;"><%=conexdate%></td>
					<td class="text-left" id="dfile<%=i%>"  style="display: none;"><%=rs.getString("ContractFileName")%></td>

					<td class="text-center" id="accno<%=i%>" style="display: none;"><%=rs.getString("AccNo")%></td>
					<td class="text-left" id="bankname<%=i%>" style="display: none;"><%=rs.getString("BankName")%></td>
					<td class="text-left" id="brname<%=i%>"style="display: none;"><%=rs.getString("BankBranch")%></td>
					<td class="text-center" id="ifcs<%=i%>" align="right" style="display: none;"><%=rs.getString("IFSC")%></td>
					<td class="text-center" id="pno<%=i%>" align="right" style="display: none;"><%=rs.getString("PanNo")%></td>

					<td class="text-center" id="policyno<%=i%>" style="display: none;"><%=rs.getString("PolicyNo")%></td>
					<td class="text-left" id="coname<%=i%>" style="display: none;"><%=rs.getString("NameOfClaimCompany")%></td>
					<td class="text-right" id="exdate<%=i%>" style="display: none;"><%=claimexdate%></td>
					<td class="text-center" id="camount<%=i%>" style="display: none;"><%=rs.getString("ClaimAmount")%></td>
					<td class="text-left" id="mfile<%=i%>" style="display: none;"><%=rs.getString("MediclaimFileName")%></td>

					<td class="text-center" id="contname<%=i%>" style="display: none;"><%=rs.getString("ContactImeediate")%></td>
					<td class="text-center" id="contno<%=i%>" style="display: none;"><%=rs.getString("ContactNoImmediate")%></td>
					<td class="text-left" id="cperadd<%=i%>" style="display: none;"><%=rs.getString("AddressContact")%></td>
					<td class="text-left" id="rel<%=i%>"  style="display: none;"><%=rs.getString("RelationShip")%></td>
				</tr>
				<%}%>
		</tbody>
	</table>
	<input type="hidden" name="cntcls" id="cntcls" value="<%=i%>">
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
		                        title: 'Attendance Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Contract Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Contract Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Contract Report ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Contract Report ',
							},
 
					],
				},
           ],
       
       });

   });
   
</script>
<script type="text/javascript">
function viewconDetails(id) 
{   
	var cnt=document.getElementById("cntcls").value;
	if(id =='cdet')
	{
		document.getElementById("imgcdet+").style.display='none';
		document.getElementById("imgcdet-").style.display="";
			document.getElementById("bdate").style.display="";
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("bdate"+i).style.display="";
			}
		
			document.getElementById("mstatus").style.display="";
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("mstatus"+i).style.display="";
			}
			
			document.getElementById("add").style.display="";
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("add"+i).style.display="";
			}
			
	}
	if(id=='creg')
			{
		document.getElementById("imgcreg+").style.display='none';
		document.getElementById("imgcreg-").style.display="";
		document.getElementById("cdate").style.display="";
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("cdate"+i).style.display="";
			}
		
			document.getElementById("cedate").style.display="";
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("cedate"+i).style.display="";
			}
			
			document.getElementById("camount").style.display="";
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("camount"+i).style.display="";
			}
	
		   
	}
	
	if(id=='bdet')
	{document.getElementById("imgbdet+").style.display='none';
	 document.getElementById("imgbdet-").style.display="";
		document.getElementById("accno").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("accno"+i).style.display="";
	}

	document.getElementById("bankname").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("bankname"+i).style.display="";
	}
	
	document.getElementById("brname").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("brname"+i).style.display="";
	}
	document.getElementById("ifcs").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("ifcs"+i).style.display="";
	}
	
	document.getElementById("pno").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("pno"+i).style.display="";
	}
   
}

	if(id=='mdet')
	{   document.getElementById("imgmdet+").style.display='none';
	document.getElementById("imgmdet-").style.display="";
	    document.getElementById("policyno").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("policyno"+i).style.display="";
	}

	document.getElementById("coname").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("coname"+i).style.display="";
	}
	
	document.getElementById("mfile").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("mfile"+i).style.display="";
	}
	document.getElementById("camount").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("camount"+i).style.display="";
	}
	
	document.getElementById("exdate").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("exdate"+i).style.display="";
	}
	}
	if(id=='icdet')
	{  document.getElementById("imgicdet+").style.display='none';
	document.getElementById("imgicdet-").style.display="";
		document.getElementById("contname").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("contname"+i).style.display="";
	}

	document.getElementById("contno").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("contno"+i).style.display="";
	}
	
	document.getElementById("cperadd").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("cperadd"+i).style.display="";
	}
	
	document.getElementById("rel").style.display="";
	for(var i=1;i<=cnt;i++)
	{
		document.getElementById("rel"+i).style.display="";
	}

}
}
	function hideconDetails(id) 
	{   
		var cnt=document.getElementById("cntcls").value;
		
		if(id =='cdet')
		{
			document.getElementById("imgcdet+").style.display="";
			document.getElementById("imgcdet-").style.display='none';
				document.getElementById("bdate").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("bdate"+i).style.display='none';
				}
			
				document.getElementById("mstatus").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("mstatus"+i).style.display='none';
				}
				
				document.getElementById("add").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("add"+i).style.display='none';
				}
				
		}
		if(id=='creg')
				{document.getElementById("imgcreg+").style.display="";
				document.getElementById("imgcreg-").style.display='none';
			    document.getElementById("cdate").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("cdate"+i).style.display='none';
				}
			
				document.getElementById("cedate").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("cedate"+i).style.display='none';
				}
				
				document.getElementById("camount").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("camount"+i).style.display='none';
				}
		
			   
		}
		
		if(id=='bdet')
		{document.getElementById("imgbdet+").style.display="";
		document.getElementById("imgbdet-").style.display='none';
			document.getElementById("accno").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("accno"+i).style.display='none';
		}

		document.getElementById("bankname").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("bankname"+i).style.display='none';
		}
		
		document.getElementById("brname").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("brname"+i).style.display='none';
		}
		document.getElementById("ifcs").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("ifcs"+i).style.display='none';
		}
		
		document.getElementById("pno").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("pno"+i).style.display='none';
		}
	   
	}

		if(id=='mdet')
		{ document.getElementById("imgmdet+").style.display="";
		   document.getElementById("imgmdet-").style.display='none';
			document.getElementById("policyno").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("policyno"+i).style.display='none';
		}

		document.getElementById("coname").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("coname"+i).style.display='none';
		}
		
		document.getElementById("mfile").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("mfile"+i).style.display='none';
		}
		document.getElementById("camount").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("camount"+i).style.display='none';
		}
		
		document.getElementById("exdate").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("exdate"+i).style.display='none';
		}
		}
		if(id=='icdet')
		{document.getElementById("imgicdet+").style.display="";
		   document.getElementById("imgicdet-").style.display='none';
			document.getElementById("contname").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("contname"+i).style.display='none';
		}

		document.getElementById("contno").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("contno"+i).style.display='none';
		}
		
		document.getElementById("cperadd").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("cperadd"+i).style.display='none';
		}
		
		document.getElementById("rel").style.display='none';
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("rel"+i).style.display='none';
		}

	}
}
	function DeleteRow(id)
	{
		    var agree=confirm("Do You Want to Delete this Record?");
		    if(agree)
		    {
			 var ajaxRequest;  // The variable that makes Ajax possible!
			    try
			    {	// Opera 8.0+, Firefox, Safari
					ajaxRequest = new XMLHttpRequest();
			    }  
				catch (e)
				{	// Internet Explorer Browsers
					try
					{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
					} 
					catch (e)
					{	try
						{
							ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
						} 
						catch (e)
						{	// Something went wrong
							alert("Your browser broke!");
							return false;
						}
					}
				}
				ajaxRequest.onreadystatechange = function()
				{
					if(ajaxRequest.readyState == 4)
					{	var reslt=ajaxRequest.responseText;
					  var data=reslt.trim();
						if(data="Yes")
						{					
	                        alert("Data Deleted Successfully.");
					    	window.location.reload();
						}
						if(data="No")
						{					
					    	window.location.reload();
						}
		           } 
				}
				var queryString = "?action=delete&id="+id;
				ajaxRequest.open("GET", "AjaxContractDelete.jsp" + queryString, true);
				ajaxRequest.send(null); 
		    }
		    else
		    {return false;
		    }
	 }	
</script>
<%@ include file="footer.jsp" %>
</body>
</html>