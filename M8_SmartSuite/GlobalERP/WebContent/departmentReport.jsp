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
  String date="";
  String name="",empname="",hodname="",udeptname="";
  int i=0;
Connection con = null;
Statement stmt=null,st1=null, st2=null,st3=null;
try {

	con = connection.getConnect("db_leaveapplication");   
	System.out.println("con               :::::::::::::::::: "+con);
	stmt = con.createStatement();
	st1 = con.createStatement();
	st2 = con.createStatement();
     
} catch (Exception e) {
   e.printStackTrace();
}

%>
<%
	 String sql = "select * from t_department";
	 ResultSet rs = stmt.executeQuery(sql);
	 %>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Department Report</h5>
    </div>
    <br>
     <div class="row align-items-center">

    <!-- Buttons -->
    <div class="col-md-3">
     <div class="d-flex flex-column flex-sm-row gap-2">
            <a href="deptCreation.jsp" class="btn btn-primary " id="button" >ADD</a>
        </div>
        <br>
    </div>
    </div>
</div>
		<form action="" method="post" name="departmentReport">		
		 <table id="example" class="display" style="width: 100%">  
<thead>
<tr>
<th>Sr No.</th>
<th>Edit</th>
<th>Delete</th>
<th>CompanyName</th>
<th>Department Code</th>
<th>Department Name</th>
<th>UnderDept Name</th>
<th>HOD Name</th>
<th>Status</th>
<th>Entered By</th>
<th>Updated Date & Time</th>
</tr>
</thead>
<tbody>
<% 

 while(rs.next())
 {  String sql1 = "select OurCompanyName from t_ourcompanydet where CompanyCode='"+rs.getString("ComapanyCode")+"'";
 	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		name = rs1.getString(1);
		System.out.print("name============>"+name);
	}
	String sqlempname = "select Name from t_leaveadmin where empid='"+rs.getString("TWEmpID")+"'";
 	ResultSet rs2= st2.executeQuery(sqlempname);
	if(rs2.next())
	{
		empname = rs2.getString(1);
		System.out.print("Emp name============>"+empname);
	}
	
	String sqlHOD="select Name from t_leaveadmin where EmpID='"+rs.getString("HODId")+"'";
			
		ResultSet rsHOD=st1.executeQuery(sqlHOD);
		
		if(rsHOD.next())
		{
			hodname=rsHOD.getString(1);
		}
		
		String sqludept="select DeptName from t_department where DeptCode='"+rs.getString("UnderDeptCode")+"'";
		
		ResultSet rsdept=st1.executeQuery(sqludept);
		System.out.println("und dept name"+sqludept);
		if(rsdept.next())
		{
			udeptname=rsdept.getString(1);
		}	
 try
   { 
	 date = new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rs.getString("UpdateDatetime")));
   }
 catch(Exception e){}
 String color="";
 if (rs.getString("Status").equalsIgnoreCase("active")) {
		color = "#CCFF99";

	} else 
	{

		color = "#FF8080";
	}
	System.out.println("colorrrrrrr"+color+"date-->"+date);
 %>
<%
String rid = rs.getString("RId");
String companyCode = rs.getString("ComapanyCode");
String deptCode = rs.getString("DeptCode");
String deptName = rs.getString("DeptName");
String underDeptCode = rs.getString("UnderDeptCode");
String status = rs.getString("Status");
String updateDateTime = rs.getString("UpdateDatetime");
String empId = rs.getString("TWEmpID");
String hodId = rs.getString("HODId");
%>
<tr style="background: <%=color%>;">
<td class="text-center"><%=rid%></td>

<td class="text-center">
<a href="editDepartment.jsp?dptcode=<%=deptCode%>&companyname=<%=name%>&companycode=<%=companyCode%>&deptname=<%=deptName%>&hod=<%=hodname%>&udeptname=<%=udeptname%>&udeptcode=<%=underDeptCode%>&status=<%=status%>">
<i class='bx bxs-edit' style="color:green;font-size:20px;"></i>
</a>
</td>

<td class="text-center">
<a href="#" onclick="DeleteRow('<%=deptCode%>','<%=companyCode%>','<%=status%>');">
<i class='bx bxs-trash' style="color:red;font-size:20px;"></i>
</a>
</td>

<td class="text-left"><%=name%></td>
<td class="text-center"><%=deptCode%></td>
<td class="text-left"><%=deptName%></td>
<td class="text-left"><%=udeptname%></td>
<td class="text-left"><%=hodname%></td>
<td class="text-left"><%=status%></td>
<td class="text-left"><%=empname%></td>
<td class="text-right"><%=date%></td>
</tr>
<%} %>
</tbody>

</table>		
		</form>

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
	         fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, 
	        keys: true,  //Keytable
	        stateSave: true,
	       lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
								title: 'department Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'department Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'department Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'department Report ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'department Report ',
							},
					],
				},
				
           ], 
       
       });
   });
</script>
<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
        var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.departmentReport.action ="excel.jsp";    

          document.forms["departmentReport"].submit();      

} 
//
function DeleteRow(id,compcode,Status)
{
	    	if(Status=="Deactive")
	{
		alert("Department already deactivated");
		return false;
	}
	else
	{
	var agree=confirm("Do You Want to Deactivate this Record?");
	    if(agree)
	    {
		 var ajaxRequest;  
		    try
		    {	
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{	
				try
				{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{	try
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
				{	var reslt=ajaxRequest.responseText;
				  var data=reslt.trim();
					if(data="Yes")
					{					
                        alert("Department Deactivated Successfully.");
				    	window.location.reload();
					}
					if(data="No")
					{					
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=delete&id="+id+"&companycode="+compcode;
			ajaxRequest.open("GET", "AjaxDepartmentDelete.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }

	}//end of else
 }	
</script>
  <%@ include file="footer.jsp" %>
 </body>
</html>