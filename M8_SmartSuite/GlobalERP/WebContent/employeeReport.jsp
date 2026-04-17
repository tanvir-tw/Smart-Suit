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
String bt="";

Connection conn = null;
Statement st1 = null;


try {
	conn = connection.getConnect("db_leaveapplication");    
    st1 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%> 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">New Joinee Report</h5>
    </div>
</div>
<form action="" method="post" name="employeeReport">
<div class="row col-12">
		    <div class="col-md-5"></div>
				<div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="dropdown" name="dropdown">
                             <%
      bt=request.getParameter("button");
      System.out.println(" dropdown :- " +bt);
      if(bt==null || bt==" " || bt==""){  //onload %>
                            <option value="All" selected>All</option>
					        <option value="Yes" >Active</option>
					        <option value="No">De-active</option> 
					        
        <%}else{ 
        
        if(request.getParameter("dropdown").equals("Yes")){ %>
        	 
             <option value="Yes" selected>Active</option>
			 <option value="No">De-active</option>
			 
 <%  }
        else{%> 
                 <option value="No" selected>De-active</option>
			     <option value="Yes">Active</option>
        <%} 
        }%>
                           </select>
                            <script>
                            const mySel = document.getElementById("dropdown");

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
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			<div class="col-md-4"></div>
</div>
</form>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a href="addNewEmployee.jsp" style="color:blue; text-decoration:  none;">Add</a>
	    </div>
		<div class="col-10"></div>
	</div>
<table id="example" class="display" style="width: 100%;"> 
   <thead>
	<tr>
		<th>Delete</th>
	    <th>Edit</th>
		<th>Contractor ID</th>
		<th>Name</th>
		<th>User Name</th>
		<th>Email</th>
		<th>Type of user</th>
		<th>Type of Department</th>
		<th>Status</th>
		<th>Entered By</th>
		<th>Date</th>
		<th>Week Off</th>
		<th>Report Time</th>
		<th>Exit Time</th>
	   <th>Work From Home</th>
</tr>
</thead>

<tbody>
<%
 String date="", ssql="";
 String status=request.getParameter("dropdown");
 
  if(status==null) //onload
 {
  ssql = "select * from  t_leaveadmin where Status like  '%%'  ORDER BY `EmpID` ASC ";
 }else
 {
	 ssql = "select * from  t_leaveadmin where Status= '"+status+"'  ORDER BY `EmpID` ASC "; 
 }
System.out.println("ssql"+ssql);
ResultSet rs = st1.executeQuery(ssql);
 while(rs.next())
 {  
	 String[] days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};

	 String weekOffStr = rs.getString("weekOff");
	 String weekOff1 = "Not Set";

	 if(weekOffStr != null && !weekOffStr.equalsIgnoreCase("null"))
	 {
	     int weekOff = Integer.parseInt(weekOffStr);
	     if(weekOff >=0 && weekOff < days.length)
	     {
	         weekOff1 = days[weekOff];
	     }
	 }
	 
 try
   { 
	 date = new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rs.getString("inserteddatetime")));
   }
 catch(Exception e){
	e.printStackTrace();
 }
 String color="";
 if (rs.getString("Status").equalsIgnoreCase("No")) {
		color = "#FF8080";
	} else 
	{
		color = "#CCFF99";
	}
 %>
 
<tr style="background: <%=color%>;">
	<td class="text-center"><a href="#" style="font-weight: bold; color: black;" onclick="DeleteRow('<%=rs.getString("EmpID")%>','<%=rs.getString("Status")%>');">
	<i class='bx bxs-trash' style="color:red;font-size: 20px;"></i></a></td>
	<td class="text-center"><a href="#"  onclick="EditEmp('<%=rs.getString("EmpID")%>','<%=rs.getString("Status") %>','<%=rs.getString("Name") %>');"><i class='bx bxs-edit' style="color:green;font-size: 20px;"></i></a></td>
	<td class="text-center"><%=rs.getString("EmpID")%></td>
	<td class="text-left">
	 <div style="width:100px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
        <%=rs.getString("Name")%>
    </div>
	</td>
	<td class="text-left"><%=rs.getString("UName")%></td>
	<td class="text-left"><%=rs.getString("Email")%></td>
	<td class="text-left"><%=rs.getString("URole")%></td>
	<td class="text-left"><%=rs.getString("TypeValue")%></td>
	<td class="text-left"><%=rs.getString("Status")%></td>
	<td class="text-left"><%=rs.getString("ERPUser")%></td>
	<td class="text-left">
    <div style="width:100px; white-space:normal; word-wrap:break-word; overflow-wrap:break-word;">
        <%=date%>
    </div>
</td>
	<%-- <td class="text-left"><%=date%></td> --%>
	<td class="text-left"><%=weekOff1%></td>
	<td class="text-right"><%=rs.getString("ReportTime")%></td>
	<td class="text-right"><%=rs.getString("exittime")%></td>
	<td class="text-center">
 <%if(rs.getString("IsWorkFromHome").contains("Yes")){
%>
<input type="checkbox" name="workhome" id="workhome" onclick="oncheck(this);" value="<%=rs.getString("Name") %>" checked></td>
<%}else{%>
	<input type="checkbox" id="workhome" value="<%=rs.getString("Name") %>" onclick="oncheck(this);">
 </td>
<%}%>
 </tr>
<% }
%>
</tbody>
</table>

</div>


<script type="text/javascript">
function DeleteRow(id,Status)
{
	if(Status=="No")
	{
		alert("Employee Already Deactivated");
		return false;
	}
	else
	{
	
	var agree=confirm("Do You Want to Delete this Record?");
	    //alert(agree);
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
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{	//alert("ddddddddddddddddddddddd");
				if(ajaxRequest.readyState == 4)
				{	var reslt=ajaxRequest.responseText;
				   //alert(">>>    "+reslt);
				  var data=reslt.trim();
					if(data="Yes")
					{					
                        alert("Data Deleted Successfully.");
				    	window.location.reload();
					}
					if(data="No")
					{					
                       // alert("Data Not Deleted Successfully.");
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=delete&id="+id;
			ajaxRequest.open("GET", "AjaxContractDelete1.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
	}//end of else
 }//
 function EditEmp(id,status,name)
 {
	// alert("st"+status);
	 if(status=="Yes")
	 {
 	var agree=confirm("Do You Want to Edit this Record?");
 	    if(agree)
 	    {
 	    	window.location.href="editEmp.jsp?EmpID="+id+"&status="+status+"&name="+name;
 		}
 	    else
 	    {
 	    	return false;
 	    }
	 }
	 else
	 {
		 
		 alert(" Selected Employee is deactivated!!! ");
		 var conf=confirm("Still you want to edit this employee..");
		 if(conf)
		 {
			 window.location.href="editEmp.jsp?EmpID="+id+"&status="+status+"&name="+name;
		 }
		 else
	 	    {return false;
	 	    }
	 }
  }
 
 function oncheck(id)
 {	
 	var state=id.checked;
 	var employee=id.value;
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
 			 	alert("Apply Successfully");
                 window.location.reload();
 			}
 			if(data="No")
 			{					
               window.location.reload();
 			}
        } 
 	}
 	var queryString = "?state="+state+"&emp="+employee;
 	ajaxRequest.open("GET", "AjaxWorkFromHome.jsp" + queryString, true);
 	ajaxRequest.send(null);
 }
 	
</script>
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
		                        title: 'New Joinee Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'New Joinee Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'New Joinee Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'New Joinee Report ',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'New Joinee Report ',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>

<%@ include file="footer.jsp"%>
</body>
</html>