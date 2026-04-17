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
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String projectId="" , projectName="";
int totalTaskDuration=0;
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="";
String userlist = "(0,";
int c=0;

Connection conn = null;
Statement st1=null,st2=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
	st2 = conn.createStatement();
   
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

String sql3 = "select dotprojectid  from db_GlobalERP.UserMaster where dept!='null' and ActiveStatus = 'Yes' and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and dotprojectid!='-' and dotprojectid!=''";
System.out.println("sessionlist---->"+sql3);
ResultSet rs3 = st1.executeQuery(sql3);
while(rs3.next())
{
	if(c==0){
		userlist +=	"'"+rs3.getString("dotprojectid")+"'";
		
	}else{
	
	    userlist = userlist+","+"'"+rs3.getString("dotprojectid")+"'";
	}
	c++;
}


userlist += ")";

userlist = userlist.replace("(0,","(");

%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Project-wise Task Summary Report</h5>
    </div>
</div>
  <form name="summaryreport" id="summaryreport" method="post">
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
			<div class="col-md-2"></div>	
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

 <br>
  <div class="container" style="width:70%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Project Id</th>
            <th >Project Name</th>
            <th>Total Duration</th>            
            </tr>
        </thead> 
        <tbody>
        
<%
int counter=1;
String sql1= "select task_project,project_name,sum(task_duration) as duration from dotproject.tasks a  join dotproject.user_tasks b on a.task_id = b.task_id join dotproject.projects c  on a.task_project=c.project_id where  task_end_date >='"+dt+" 00:00:00'  and task_end_date <='"+dt1+" 23:59:59' and b.user_id in "+userlist+"   group by task_project order by task_project";
System.out.println("sql1----->"+sql1);
ResultSet rs1 = st2.executeQuery(sql1);
while(rs1.next()){
	  projectId = rs1.getString("task_project");
	  projectName = rs1.getString("project_name");
	  totalTaskDuration = rs1.getInt("duration");
							
%>
<tr>
	
	<td class="text-center"><%=counter++%></td>
	<td class="text-center"><%=projectId%></td>
	<td class="text-left"><a href="UserwiseTaskReport.jsp?date1=<%=dt%>&date2=<%=dt1%>&projectId=<%=projectId%>"><%=projectName%></a></td>
	<td class="text-center"><%=totalTaskDuration%></td>
	</tr>
	<%
	
} 

%>      
        </tbody>
 </table>
 </div>
</div>
 
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>

  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-5"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
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
	                         title: 'Projectwise Task Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Projectwise Task Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Projectwise Task Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Projectwise Task Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Projectwise Task Summary Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
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