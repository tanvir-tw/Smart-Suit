 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
 <%@include file="PostgressConn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="icon" type="image/png" href="images/favicon.png">
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">
<%
// Variable Declaration
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String department="",seldept="",sessiondept="",Sesrole1="",name="",name13="",Sesrole2="";
String mainquery = "";
int i=1;
String User="",UserID="",empcode="",HOD="",Department="",Assigned="",Submitted="",Missed="",Pending="",Approved="",Rejected="";
double Assign = 0,Submit = 0, Miss = 0, Pend = 0, Approve = 0 , Reject = 0;

name=session.getAttribute("EmpName").toString();
sessiondept=session.getAttribute("department").toString();
String todaysDate = session.getAttribute("today").toString();
seldept=request.getParameter("companyName1");
Sesrole1=session.getAttribute("role").toString();
	
String Nam = request.getParameter("EmpName");
String comid=session.getAttribute("CompanyMasterID").toString();
DecimalFormat df2 = new DecimalFormat("#0.00");

 // Connection Initialization
Connection con1 = null, conn1=null;
Statement st = null,st1=null,stmt=null,stmt1=null,st4 =null;
ResultSet rs = null;
try {
	con1 = connection.getConnect("db_GlobalERP");    
    st = con1.createStatement();
    st1 = con1.createStatement();
    
  //postgresql
    Class.forName(postgresDriver);
    conn1=DriverManager.getConnection(postgresString,postgresUser,postgresPass); 
    stmt = conn1.createStatement(); //all postgres queries
    stmt1 = conn1.createStatement(); //all postgres queries
    st4 = conn1.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");

	if (bt== null || bt.equals("null")) {		
		datex1 = todaysDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");

	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime = ""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time = ""+dt1+" 23:59:59";

%>
<%
int c=0;
String SessionList = "(0,";
String sqlopids = "select EmpCode,dotprojectid,KRAdotprojectid,Openprojectid from db_GlobalERP.UserMaster where ActiveStatus='Yes' and Openprojectid!='-' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString(); 
System.out.println("ids_query-->"+sqlopids);
ResultSet rs11=null;
try {
	rs11 = st.executeQuery(sqlopids);
     while(rs11.next()) {
    	 if(c==0){
 			SessionList +=	"'"+rs11.getString("Openprojectid")+"'";
 			
 		}else{
 		
 		    SessionList = SessionList+","+"'"+rs11.getString("Openprojectid")+"'";
 		}
 		c++;
	}
     
     SessionList += ")";
 	
 	SessionList = SessionList.replace("(0,","(");
 	
 	System.out.println("Session List:"+SessionList);

} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Status Report</h5>
    </div>
</div>

<form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-2"></div>
		    <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" name="companyName1" id="companyName1" onchange="consig();">
                             <%	
               if(bt==null)  //onload
        	  { %>
          
          <%if(Sesrole1.equals("AllAdmin")) {
           %>
           <option value="All">All</option>
          <%} 
            else
            {%>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%} %>
            <% }
            else 
            {//onsubmit
              
    	    if(Sesrole1.equals("AllAdmin")) {
           %>
            
             <option value="<%=seldept%>"><%=seldept%></option>
             <option value="All">All</option>
             
             <%} 
            else
            {%>
            <option value="<%=seldept%>"><%=seldept%></option>
            <%}  
    	    
            } %>
          
            <%
           
            String sql1="";
            
             if(Sesrole1.equals("AllAdmin"))
        	
        	{
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where  companymasterid="+comid+"  and ActiveStatus='Yes' and dotprojectid!='-'order by dept";
        	}
             
            else if (Sesrole1.equals("HOD")){
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+comid+"  and ActiveStatus='Yes' and dotprojectid!='-' order by dept";
             }
            else
            {
            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+comid+"  and ActiveStatus='Yes' and dotprojectid!='-' order by dept";
            }
            	 
           	
		System.out.println("*******"+sql1);
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			department=rsregno.getString("department");
			
			// System.out.println("department-->"+department);
			%>
			
			<option value="<%=department%>"><%=department%></option>
	         <%
	       
      }
		%>
                           </select>
                            <script>
                            const mySel = document.getElementById("companyName1");

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
		 
             <div class="col-md-2">
				  <label for="dropdown"><b>Name</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="EmpName" name="EmpName">
                             <%	
          if(bt==null || bt=="null" || bt.equals("null"))
        	  {%>
          <%if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD")) {
           %>
           <option value="All">All</option>
           
           <%} else
           {%>
           <option value="<%=name%>"><%=name%></option>
           <%} }
            else 
            {
            
            String EmpName1=request.getParameter("EmpName"); 
    	
    	    if(Sesrole1.equals("AllAdmin")) {
           %>
            
             <option value="<%=EmpName1%>"><%=EmpName1%></option>
                        <option value="All">All</option>
             
             <%} 
            else
            {%>
            <option value="<%=EmpName1%>"><%=EmpName1%></option>
            <%}  } %>
                           </select>
                                                     <script>
                            const mySel = document.getElementById("EmpName");

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
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return chk()">
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
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
 <br>
 <%

 if(bt==null){
	 
	    name13=session.getAttribute("EmpName").toString();
		Sesrole2=session.getAttribute("role").toString();
		seldept=request.getParameter("companyName1"); 
		
		if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
 	{
 		name13="All";	
 	}
 	else
 	{
 		name13=""+name13;
 	}
 	if(Sesrole2.equals("AllAdmin"))
		{
	     department="All";
		}
 	else
		{
			department=sessiondept;
		}
 	
 	if(name13.equals("All"))
	{
		name13="";
	}
	if(department.equals("All"))
	{
		department="";
	}
 	
 	//mainquery="select Empname as User,dotprojectid as UserID,empcode,HodReport as HOD ,Dept as Department,IFNULL((select sum(a.task_duration)  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id  where task_end_date >='"+dttime+"' and task_end_date <='"+dt1time+"'  and user_id=c.dotprojectid ),0) as Assigned,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and d.TaskStatus!='Duplicate' ),0) as Submited,IFNULL((select sum(task_duration) from dotproject.user_tasks a left join dotproject.tasks b on  a.task_id=b.task_id where  a.user_id=c.dotprojectid and task_end_date >='"+dt+"' and task_end_date <='"+dt1+"' and b.task_id not in (select distinct(TaskID) from db_GlobalERP."+comid+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid ) ),0) as Missed ,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"'  and d.TaskStatus='Pending' ),0) as Pending,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Approved' and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' )),0) as Approved ,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Rejected' and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' )),0) as Rejected from db_GlobalERP.UserMaster c where c.activestatus='Yes' and c.companymasterid='"+comid+"' and c.dept like '%"+department+"%' and c.EmpName like '%"+name13+"%'  and (c.HODReport like '%"+name13+"%' OR c.EmpName like '%"+name13+"%' ) order by c.Empname";
 	mainquery =   "SELECT  CONCAT(c.firstname, ' ', c.lastname) AS User,  c.id AS UserID,  COALESCE(SUM(a.estimated_hours), 0) AS Assigned,  COALESCE(SUM(CASE WHEN a.status_id = 12 THEN a.estimated_hours ELSE 0 END), 0) AS Submitted,  COALESCE(SUM(CASE WHEN a.done_ratio = 0 AND a.status_id = 1 THEN a.estimated_hours ELSE 0 END), 0) AS Missed FROM  users c  LEFT JOIN  work_packages a ON c.id = a.assigned_to_id AND a.due_date >= '"+dt.substring(0,10)+"' AND a.due_date <= '"+dt1.substring(0,10)+"'  LEFT JOIN  statuses b ON a.status_id = b.id WHERE c.id IN "+SessionList+" AND a.type_id=1   GROUP BY  c.id, c.firstname, c.lastname";
 	System.out.println("mainquery onload--->"+mainquery);
 	rs=stmt.executeQuery(mainquery);
 
 }else{
	 
	 Sesrole2=session.getAttribute("role").toString();
	 
	 if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
 	{
 		name13=Nam;	
 	}
 	else
 	{
 		name13=""+name13;
 	}
 	if(Sesrole2.equals("AllAdmin"))
 			{
 		        department=seldept;
 			}else
 			{
 				department=seldept;
 			}
 	
 	if(name13.equals("All"))
	{
		name13="";
	}
 	mainquery =   "SELECT  CONCAT(c.firstname, ' ', c.lastname) AS User,  c.id AS UserID,  COALESCE(SUM(a.estimated_hours), 0) AS Assigned,  COALESCE(SUM(CASE WHEN a.status_id = 12 THEN a.estimated_hours ELSE 0 END), 0) AS Submitted,  COALESCE(SUM(CASE WHEN a.done_ratio = 0 AND a.status_id = 1 THEN a.estimated_hours ELSE 0 END), 0) AS Missed FROM  users c  LEFT JOIN  work_packages a ON c.id = a.assigned_to_id AND a.due_date >= '"+dt.substring(0,10)+"' AND a.due_date <= '"+dt1.substring(0,10)+"'  LEFT JOIN  statuses b ON a.status_id = b.id WHERE c.id IN "+SessionList+" AND a.type_id=1   GROUP BY  c.id, c.firstname, c.lastname";
 	//mainquery="select Empname as User,dotprojectid as UserID,empcode,HodReport as HOD ,Dept as Department,IFNULL((select sum(a.task_duration)  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id  where task_end_date >='"+dttime+"' and task_end_date <='"+dt1time+"'  and user_id=c.dotprojectid ),0) as Assigned,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' and d.TaskStatus!='Duplicate' ),0) as Submited,IFNULL((select sum(task_duration) from dotproject.user_tasks a left join dotproject.tasks b on  a.task_id=b.task_id where  a.user_id=c.dotprojectid and task_end_date >='"+dttime+"' and task_end_date <='"+dt1time+"' and b.task_id not in (select distinct(TaskID) from db_GlobalERP."+comid+"taskmaildata where TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' and userid=c.dotprojectid ) ),0) as Missed ,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"'  and d.TaskStatus='Pending' ),0) as Pending,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Approved' and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' )),0) as Approved ,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+comid+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Rejected' and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' )),0) as Rejected from db_GlobalERP.UserMaster c where c.activestatus='Yes' and c.companymasterid='"+comid+"' and c.dept like '%"+department+"%' and c.EmpName like '%"+name13+"%'  and (c.HODReport like '%"+name13+"%' OR c.EmpName like '%"+name13+"%' ) order by c.Empname";
    System.out.println("mainquery onsubmit---"+mainquery);
 	rs=stmt.executeQuery(mainquery);
 }
 
 %>
<table id="example" class="display" style= "width: 100%">        
       <thead>
            <tr>
            <th  width="4%">SrNo.</th>
            <th>User</th>
			<th>UserID</th>
			<th>Assigned</th>
			<th>Submitted</th>
			<th>Missed</th>
			<th>Pending</th>
			<th>Approved</th>
         	<th>Rejected</th>
	        <th>Department</th>
	        <th>HOD</th>
	      </tr>
        </thead> 
        <tbody>
        <%
        while(rs.next()){
        
        User=rs.getString("User");  	
    	UserID=rs.getString("UserID");  	
    
    String statuscount = "SELECT  a.HodReport, a.Dept, COALESCE(SUM(CASE WHEN b.TaskStatus = 'Pending' THEN b.AssignedDuration ELSE 0 END), 0) AS Pending,  COALESCE(SUM(CASE WHEN b.TaskStatus = 'Approved' THEN b.AssignedDuration ELSE 0 END), 0) AS Approved, COALESCE(SUM(CASE WHEN b.TaskStatus = 'Rejected' THEN b.AssignedDuration ELSE 0 END), 0) AS Rejected FROM  db_GlobalERP.UserMaster a LEFT JOIN db_GlobalERP."+CompanyMasterId+"taskmaildataCopy b  ON b.UserId = a.dotprojectid  AND b.TaskEndDate >= '"+dt+"'  AND b.TaskEndDate <= '"+dt1+"' WHERE  a.Openprojectid = '"+UserID+"' GROUP BY a.HodReport, a.Dept";
    	System.out.println("statuscount_onload--->"+statuscount);
    	ResultSet rscnt = st1.executeQuery(statuscount);
    	if(rscnt.next()){
    		Pending=rscnt.getString("Pending");
    		Approved=rscnt.getString("Approved");
    		Rejected=rscnt.getString("Rejected");
    		HOD=rscnt.getString("HodReport");
    		Department=rscnt.getString("Dept");
    	}
    	
    	Assigned=rs.getString("Assigned");    	
    	Submitted=rs.getString("Submitted");    	
    	Missed=rs.getString("Missed");
    	
    	System.out.println("-HOD------->"+HOD);		
    	System.out.println("-Department------->"+Department);
    	
    	 Assign = Double.parseDouble(Assigned);
    	 Submit = Double.parseDouble(Submitted);
    	 Miss = Double.parseDouble(Missed);
    	Pend = Double.parseDouble(Pending);
    	Approve = Double.parseDouble(Approved);
    	Reject = Double.parseDouble(Rejected);
       %>
    	<tr>
    	    <td class="text-center"><%=i++%></td>
    	    <td class="text-left"><%=User %></td>
			<td class="text-center"><%=UserID %></td>
			<td class="text-center"><a href="OPTaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=department%>&User=<%=User%>&Status=Assigned&role=<%=Sesrole2%>"><%=df2.format(Assign)%></a></td>
			<td class="text-center"><a href="OPTaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=department%>&User=<%=User%>&Status=Submitted&role=<%=Sesrole2%>"><%=df2.format(Submit)%></a></td>
			<td class="text-center"><a href="OPTaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=department%>&User=<%=User%>&Status=Missed&role=<%=Sesrole2%>"><%=df2.format(Miss)%></a></td>
			<td class="text-center"><a href="OPTaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=department%>&User=<%=User%>&Status=Pending&role=<%=Sesrole2%>"><%=df2.format(Pend)%></a></td>
			<td class="text-center"><a href="OPTaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=department%>&User=<%=User%>&Status=Approved&role=<%=Sesrole2%>"><%=df2.format(Approve)%></a></td>
         	<td class="text-center"><a href="OPTaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=department%>&User=<%=User%>&Status=Rejected&role=<%=Sesrole2%>"><%=df2.format(Reject) %></a></td>
	        <td class="text-left"><%=department%></td>
	        <td class="text-left"><%=HOD %></td>
    	</tr>
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
	         /* fixedColumns: { 
	            left: 4      //To freeze two columns
	        },  */
	     //   keys: true,  //Keytable
	        stateSave: true,
	        
	        /* //for adding checkbox to first column
            columnDefs: [{
                orderable: false,
                className: 'select-checkbox',
                targets: 0
            }],
            select: {
                style: 'multi',
                selector: 'td:first-child'
            },
            order: [[1, 'asc']],
            //end adding checkbox to first column */

	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A3',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Task Status Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Task Status Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A3',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Task Status Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Task Status Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Task Status Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script type="text/javascript">
function consig()
{
	var dept=document.getElementById("companyName1").value;
	var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
			var finalres=reselt.split("#");
			document.getElementById("EmpName").innerHTML=finalres[0];
		 
		}
	
	}
	
	var queryString = "?dept="+dept;
	ajaxRequest.open("GET", "EmpAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 

}
	
	function chk(){
		
		var dept=document.getElementById("companyName1").value;
		if(dept=="Select")
			{
			alert("Please Select Department");
			return false;
			}
		
		var EmpName=document.getElementById("EmpName").value;
		if(EmpName=="Select")
			{
			alert("Please Select Name");
			return false;
			}
		
		 return validate(document.getElementById('data').value,document.getElementById('data1').value)
		
	}

</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>