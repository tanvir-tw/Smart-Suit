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
	Statement st10=null, st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null;
	String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="";
	String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
	String todaysDate = session.getAttribute("today").toString(); 
	String Dept=session.getAttribute("leaveempdept").toString();
	String Role=session.getAttribute("leaveemprole").toString();
	System.out.println("the dept is >>>>>:"+Dept);
	System.out.println("the Role is >>:"+Role);
	try {

		conn = connection.getConnect("db_leaveapplication");    
		st10 = conn.createStatement();
		st1 = conn.createStatement();
	    st2 = conn.createStatement();
	    st3 = conn.createStatement();
	    st4 = conn.createStatement();
	    st5 = conn.createStatement();
	    st6 = conn.createStatement();
	    st7 = conn.createStatement();
	    st8 = conn.createStatement();
	    st9 = conn.createStatement();
	   
	} catch (Exception e) {
	    e.printStackTrace();
	} 

	try{
		bt=request.getParameter("button");
			
			if (bt== null || bt.equals("null")) {		
				datex1 = monthFirstDate;
				datex2 = todaysDate;
			} else {	
				datex1 = request.getParameter("data");
				datex2 = request.getParameter("data1");
			}

		 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
		
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Applicant Report</h5>
    </div>
</div>
	<%
if(Dept.equals("Sales&Marketing") || Dept.equals("Service") || Dept.equals("Development") || Dept.equals("RnD") || Dept.equals("Software")) {
%>
 <form name="AttendanceReport" id="AttendanceReport" method="get">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
			<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1">
			</div>			
		</div>
	</form>
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>
	<br/>
	<%
int DeptHod=0;
	System.out.println("SqlDept      &&&&&&&&&&&&:");
if(request.getQueryString()!=null) {
	
	try
	{
		
		String SqlDept="Select DeptCode from t_department where DeptName='"+Dept+"'";
		System.out.println("SqlDept      &&&&&&&&&&&&:"+SqlDept);
		ResultSet rs6= st6.executeQuery(SqlDept);
		while(rs6.next())
		  {
			  	DeptHod = rs6.getInt("DeptCode");
			  	System.out.println("the DeptHod is :"+DeptHod);
			  }
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	%>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
				<th class="col-width-4">SrNo.</th>
				<th>ID</th>
	            <th>Applicant Name</th>
	            <th>Contact No</th>
	            <th>Qualification</th>
	             <th>Experience In Months</th>
			</tr>
			</thead>
			<tbody>
		<%
	System.out.println(">>>>>>>>>>>>:"+request.getParameter("data1"));
	System.out.println(">>>>>>>>>>>>:"+request.getParameter("data"));
		String Query = "select * from t_applicant_details where UpdatedDateTime between '"+dt+" 00:00:00'  and '"+dt1+" 23:59:59' AND DeptID='"+DeptHod+"'";
	System.out.println("query is :"+Query);
	ResultSet rs1 = st1.executeQuery(Query);
	int i =1;
	while(rs1.next()) {
		String EmpId1 = rs1.getString("EmpID");
		String empName1  = rs1.getString("Name");
		String contactNumber = rs1.getString("ContactNo");
		%>
		<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-center"><%=rs1.getString("EmpID")%></td>
			<td class="text-center"><a href="application_report.jsp?emp_id=<%=EmpId1%>" target="_blank"><%=empName1%></a></td>
			<td class="text-center"><%=contactNumber%></td>

			<%
				System.out.println("in query paramernt"); 
					 String Qual="select Degree from t_empeduqualification where RId in (select Max(RId) from t_empeduqualification where EmpID='"+EmpId1+"')";
					 System.out.println("query is :"+Qual); 
					ResultSet rsq=st10.executeQuery(Qual);
					  if(rsq.next())
					  {
						  String degree = rsq.getString("Degree");
						  %>
						<td class="text-left"><%=degree %></td>
						<%
						  }
					  else
					  {
					%>
			<td class="text-left">-</td>
			<%} %>

			<% 	int experience=0;
	   						
								String exp="SELECT DATEDIFF(STR_TO_DATE(Todate,'%d-%M-%Y'),STR_TO_DATE(FromDate,'%d-%M-%Y')) /30 AS experience FROM t_workexperience WHERE EmpID='"+EmpId1+"'";
								System.out.println("query is iiiiiiiiiiiiiiiiiii:"+exp);
								ResultSet rsmt=st2.executeQuery(exp);
								while(rsmt.next()) {
									
									experience = experience + rsmt.getInt("experience");
									System.out.println("experience is :"+experience); 
	   						}	
		%>

			<td class="text-center"><%= experience%></td>
		</tr>

		<%		
			i++;	
		
	}
	
	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK:"+i);		
	
} %>
	</tbody>
	</table>

	<%
	
} 
	
// for hr login
else if(Dept.equals("Accounts") && Role.equals("HR")) {
	%>
<form name="AttendanceReport" id="AttendanceReport" method="post">
		    <div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="dept_select" name="dept_select">
				               	<option value="All">All</option>
								<option value="Sales&Marketing">Sales & Marketing</option>
								<option value="Service">Service</option>
								<option value="Accounts">Accounts</option>
								<option value="Development">Development</option>
								<option value="RnD">RnD</option>
								<option value="Software">Software</option>
			               </select>
			             </div>
			           </div>
	
					<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-1">
			</div>			
		</div>
</form> 
<br>
	<%
int DeptHod=0;
if(request.getQueryString()!=null) {
	
	
	String dept_name = request.getParameter("dept_select");
	System.out.println("the dept_name is :"+dept_name);
	if(dept_name.equals("Sales&Marketing") || dept_name.equals("Service") || dept_name.equals("Accounts") || dept_name.equals("Development") || dept_name.equals("RnD") || dept_name.equals("Software")) {
try
{
	String SqlDept="Select DeptCode from t_department where DeptName='"+dept_name+"'";
	ResultSet rs6= st3.executeQuery(SqlDept);
	
	while(rs6.next())
	  {
		  	DeptHod = rs6.getInt("DeptCode");
		  	System.out.println("the DeptHod is :"+DeptHod);
		  }
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
<table id="example" class="display" style="width:100%;">        
       <thead>
		<tr>
				<th class="col-width-4">SrNo.</th>
				<th>ID</th>
	            <th>Applicant Name</th>
	            <th>Contact No</th>
	            <th>Qualification</th>
	             <th>Experience In Months</th>
			</tr>
			</thead>
			<tbody>
		<%

System.out.println(">>>>>>>>>>>>:"+request.getParameter("data1"));
System.out.println(">>>>>>>>>>>>:"+request.getParameter("data"));
String Query = "select * from t_applicant_details where UpdatedDateTime between '"+dt+" 00:00:00'  and '"+dt1+" 23:59:59' AND DeptID='"+DeptHod+"'";
System.out.println("query is :"+Query);
ResultSet rs = st9.executeQuery(Query);
int i =1;
while(rs.next()) {
	%>
		<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-center"><%=rs.getString("EmpID")%></td>
			<td class="text-left"><a href="http://<%= host1 %>:8080/Transworld/application_report.jsp?emp_id=<%=rs.getString("EmpID")%>"	target="_blank"><%=rs.getString("Name")%></a></td>
			<td class="text-center"><%=rs.getString("ContactNo")%></td>

			<%
			System.out.println("in if"); 
				 String Qual="select Degree from t_empeduqualification where RId in (select Max(RId) from t_empeduqualification where EmpID='"+rs.getString("EmpID")+"')";
				 System.out.println("query is :"+Qual); 
				ResultSet rsq=st4.executeQuery(Qual);
				  if(rsq.next())
				  {
					  %>
			<td class="text-center"><%=rsq.getString("Degree") %></td>
			<%
					  }
				  else
				  {
				%>
			<td class="text-left">-</td>
			<%} %>

			<% 	int experience=0;
   						
							String exp="SELECT DATEDIFF(STR_TO_DATE(Todate,'%d-%M-%Y'),STR_TO_DATE(FromDate,'%d-%M-%Y')) /30 AS experience FROM t_workexperience WHERE EmpID='"+rs.getString("EmpID")+"'";
							System.out.println("query is :"+exp);
							ResultSet rs3=st5.executeQuery(exp);
							while(rs3.next()) {
								experience = experience + rs3.getInt("experience");
								System.out.println("experience is :"+experience); 
   						}	
				   			%>
			<td class="text-left"><%= experience%></td>
		</tr>
		<%		
		i++;
		}
%>
</tbody>
	</table>
	<%
}
	else {
			%>
<table id="example" class="display" style="width:100%;">        
       <thead>
		<tr>
				<th class="col-width-4">SrNo.</th>
				<th>ID</th>
	            <th>Applicant Name</th>
	            <th>Contact No</th>
	            <th>Qualification</th>
	             <th>Experience In Months</th>
			</tr>
			</thead>
			<tbody>		
			<%
			System.out.println(">>>>>>>>>>>>:"+request.getParameter("data1"));
			System.out.println(">>>>>>>>>>>>:"+request.getParameter("data"));
			String Query = "select * from t_applicant_details where UpdatedDateTime between '"+dt+" 00:00:00'  and '"+dt1+" 23:59:59'";
			System.out.println("query is :"+Query);
			ResultSet rs = st6.executeQuery(Query);
			int i =1;
			while(rs.next()) {
				%>


		<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-center"><%=rs.getString("EmpID")%></td>
			<td class="text-left"><a href="http://<%= host1 %>:8080/Transworld/application_report.jsp?emp_id=<%=rs.getString("EmpID")%>" target="_blank"><%=rs.getString("Name")%></a></td>
			<td class="text-center"><%=rs.getString("ContactNo")%></td>
			<%
			System.out.println("in lese"); 
							 String Qual="select Degree from t_empeduqualification where RId in (select Max(RId) from t_empeduqualification where EmpID='"+rs.getString("EmpID")+"')";
							 System.out.println("query is :"+Qual); 
							ResultSet rsq=st7.executeQuery(Qual);
							  if(rsq.next())
							  {
								  %>
			<td class="text-left"><%=rsq.getString("Degree") %></td>
			<%
							}
							  else
							  {
							%>
			<td class="text-left">-</td>
			<%} %>

			<% 	int experience=0;
			   						    try
			   						    {
										String exp="SELECT DATEDIFF(STR_TO_DATE(Todate,'%d-%M-%Y'),STR_TO_DATE(FromDate,'%d-%M-%Y')) /30 AS experience FROM t_workexperience WHERE EmpID='"+rs.getString("EmpID")+"'";
										System.out.println("query is :"+exp);
										ResultSet rs3=st8.executeQuery(exp);
										while(rs3.next()) {
											
											experience = experience + rs3.getInt("experience");
											System.out.println("experience is :"+experience); 
										}	
			   						    }
			   						    catch(Exception e)
			   						    {
			   						    	System.out.println("Exception is :"+e); 
			   						    }
							   			%>

			<td class="text-left"><%= experience%></td>
		</tr>
		<%		
					i++;
					}
			%>
			</tbody>
	</table>
	<%
		}		
}	
}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
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
		                        title: 'Applicant Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Applicant Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Applicant Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Applicant Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Applicant Report '+$("#data").val()+' to ' +$("#data1").val(),
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