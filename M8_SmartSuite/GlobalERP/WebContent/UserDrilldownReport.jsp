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
int totalTaskDuration=0;
String startDate="",endDate="", projectId="" , projectName="",empName="",datex1="",datex2="",userId="",dept="";
String TaskID="",UserId="",EmpName="",MailDateTime="",TaskName="",TaskComment="",AssignedDuration="";
int counter=1;
String taskid="",status="";

Connection conn = null;
Statement st1=null,st2=null,st3=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 

try{
	
	startDate = request.getParameter("date1");
	endDate = request.getParameter("date2");
	projectId = request.getParameter("projectId");
	userId = request.getParameter("userId");
	projectName = request.getParameter("projectName");

	 datex1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startDate));
	 datex2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(endDate));	

%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Summary for <%=projectName%> From <%=datex1%> To <%=datex2%></h5>
    </div>
</div>

 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Project Id</th>
            <th>Project Name</th>
            <th>User Id</th>   
			<th>User</th>
			<th>Department</th>
			<th>Task Id</th>
			<th>Date Time</th>
			<th>Task Name</th>
			<th>Description</th>
			<th>Duration</th>
			<th>Status</th>
            </tr>
        </thead> 
        <tbody>
        
<%

String sqlmain= "select distinct(a.task_id) as taskid from dotproject.tasks a join dotproject.user_tasks b on a.task_id = b.task_id join dotproject.projects c on a.task_project=c.project_id where task_end_date >='"+startDate+" 00:00:00' and task_end_date <='"+endDate+"23:59:59' and task_project='"+projectId+"' and b.user_id='"+userId+"'  order by b.user_id";
System.out.println("sqlmain----->"+sqlmain);
ResultSet rsmain = st3.executeQuery(sqlmain);
while(rsmain.next()){
	
taskid=rsmain.getString("taskid");	

  // String sql1= "select distinct(TaskID),UserId,MailDateTime,TaskName,TaskComment,AssignedDuration from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where userid='"+userId+"' and TaskStatus in ('Pending','Approved') and taskid in (select distinct(task_id) from dotproject.tasks where task_project='"+projectId+"' and task_end_date >='"+startDate+"' and task_end_date<='"+endDate+"')";
   String sql1= "select distinct(TaskID),UserId,MailDateTime,TaskName,TaskComment,AssignedDuration from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where userid='"+userId+"' and TaskStatus in ('Pending','Approved') and TaskID='"+taskid+"' and TaskEndDate>='"+startDate+" 00:00:00' and TaskEndDate <='"+endDate+" 23:59:59' ";

   System.out.println("sql1----->"+sql1);
  ResultSet rs1 = st1.executeQuery(sql1);
  if(rs1.next()){
	  
	  TaskID = rs1.getString("TaskID");
	  MailDateTime = rs1.getString("MailDateTime");
	  TaskName = rs1.getString("TaskName");
	  TaskComment = rs1.getString("TaskComment");
	  AssignedDuration = rs1.getString("AssignedDuration");

	  String sql11="select EmpName,Dept from db_GlobalERP.UserMaster where dotprojectid='"+userId+"'";
	  System.out.println("sql11----->"+sql11);
	  ResultSet rs11 = st1.executeQuery(sql11);
	  if(rs11.next()){
		  EmpName = rs11.getString("EmpName");
		  dept = rs11.getString("Dept");
		 
		}else{
			EmpName = "-";
		  dept="-";
	  }
	  
	  if(MailDateTime.equalsIgnoreCase("-")){
		  status="Assigned";
		  
	  }else{
		  
		  status="Submitted";

	  }
	  

     } 
else{
	  
  String sql2= "select * from dotproject.tasks where task_id='"+taskid+"' and task_end_date>='"+startDate+" 00:00:00' and task_end_date <='"+endDate+" 23:59:59'";
  System.out.println("sql2----->"+sql2);
 ResultSet rs2 = st2.executeQuery(sql2);
 if(rs2.next()){
	  
	  TaskID = rs2.getString("task_id");
	MailDateTime = "-";
	  TaskName = rs2.getString("task_name");
	  TaskComment = rs2.getString("task_description");
	  AssignedDuration = rs2.getString("task_duration");

	  String sql22="select EmpName,Dept from db_GlobalERP.UserMaster where dotprojectid='"+userId+"'";
	  System.out.println("sql22----->"+sql22);
	  ResultSet rs22 = st2.executeQuery(sql22);
	  if(rs22.next()){
		  EmpName = rs22.getString("EmpName");
		  dept = rs22.getString("Dept");
		 
		}else{
			EmpName = "-";
		  dept="-";
	  }
	  
	  if(MailDateTime.equalsIgnoreCase("-")){
		  status="Assigned";
		  
	  }else{
		  
		  status="Submitted";

	  }
	  
 }
}
  
  System.out.println("EmpName----->"+EmpName);

	  %>
<tr>
	    <td class="text-center"><%=counter++%></td>
	    <td class="text-center"><%=projectId%></td>
	    <td class="text-left"><%=projectName%></td>
	    <td class="text-center"><%=userId%></td>
	    <td class="text-left"><%=EmpName%></td>
	     <td class="text-left"><%=dept%></td>
	    <td class="text-right"><%=TaskID%></td>
		<td class="text-left"><%=MailDateTime%></td>
		<td class="text-left"><%=TaskName%></td>
		<td class="text-left"><%=TaskComment%></td>
		<td class="text-center"><%=AssignedDuration%></td>
		<td class="text-left"><%=status%></td>	
	<%
	
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
	                         title: 'Task Summary From <%=datex1%> To <%=datex2%>', 
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Task Summary From <%=datex1%> To <%=datex2%>', 
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Task Summary From <%=datex1%> To <%=datex2%>', 
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Task Summary From <%=datex1%> To <%=datex2%>', 
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Task Summary From <%=datex1%> To <%=datex2%>', 
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