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

	 datex1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startDate));
	 datex2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(endDate));

	 
	String userlist = "(0,";
	 int c=0;

	 String sql4 = "select KRAdotprojectid  from db_GlobalERP.UserMaster where dept!='null' and ActiveStatus = 'Yes' and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and KRAdotprojectid!='-' and KRAdotprojectid!=''";
	System.out.println("sessionlist---->"+sql4);
	ResultSet rs4 = st1.executeQuery(sql4);
	while(rs4.next())
	{
		if(c==0){
			userlist +=	"'"+rs4.getString("KRAdotprojectid")+"'";
			
		}else{
		
		    userlist = userlist+","+"'"+rs4.getString("KRAdotprojectid")+"'";
		}
		c++;
	}


	userlist += ")";

	userlist = userlist.replace("(0,","(");

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
      <h5 class="content-header-title text-center mb-0" style="color: #060637">User-wise KRA Summary Report From <%=datex1%> To <%=datex2%></h5>
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
				<th>Total Duration</th>
            </tr>
        </thead> 
        <tbody>   
<%
  int counter=1;
  //String sql1= "select b.user_id,task_project,project_name,sum(task_duration) as duration from dotproject.tasks a  join dotproject.user_tasks b on a.task_id = b.task_id join dotproject.projects c  on a.task_project=c.project_id where  task_end_date >='"+startDate+" 00:00:00'  and task_end_date <='"+endDate+" 23:59:59' and task_project="+projectId+"  group by b.user_id order by b.user_id";
   String sql1= "select b.user_id,task_project,project_name,sum(task_duration) as duration from dotproject.tasks a  join dotproject.user_tasks b on a.task_id = b.task_id join dotproject.projects c  on a.task_project=c.project_id where  task_end_date >='"+startDate+" 00:00:00'  and task_end_date <='"+endDate+" 23:59:59' and task_project="+projectId+" and b.user_id in "+userlist+"   group by b.user_id order by b.user_id";
  System.out.println("sql1----->"+sql1);
  ResultSet rs1 = st1.executeQuery(sql1);
  while(rs1.next()){
	  projectId = rs1.getString("task_project");
	  userId = rs1.getString("user_id");
	  projectName = rs1.getString("project_name");
	  totalTaskDuration = rs1.getInt("duration");
	  
	  String sql2="select EmpName,Dept from db_GlobalERP.UserMaster where KRAdotprojectid='"+userId+"'";
	  System.out.println("sql2----->"+sql2);
	  ResultSet rs2 = st2.executeQuery(sql2);
	  if(rs2.next()){
		  empName = rs2.getString("EmpName");
		  dept = rs2.getString("Dept");
		 
		}else{
		  empName = "-";
		  dept="-";
	  }
	  
	  %>
<tr>
 		<td class="text-center"><%=counter++%></td>
	    <td class="text-center"><%=projectId%></td>
	    <td class="text-left"><%=projectName%></td>
	    <td class="text-center"><%=userId%></td>
	    <td class="text-left"><%=empName%></td>
		<td class="text-left"><%=dept%></td>
		<td class="text-center"><a href="KRAUserDrilldownReport.jsp?date1=<%=startDate%>&date2=<%=endDate%>&projectId=<%=projectId%>&userId=<%=userId%>&projectName=<%=projectName%>"><%=totalTaskDuration%></a></td>

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
	                         title: 'Userwise KRA Summary Report From <%=datex1%> To <%=datex2%>',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Userwise KRA Summary Report From <%=datex1%> To <%=datex2%>',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Userwise KRA Summary Report From <%=datex1%> To <%=datex2%>',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Userwise KRA Summary Report From <%=datex1%> To <%=datex2%>',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Userwise KRA Summary Report From <%=datex1%> To <%=datex2%>', 
	                         
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