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
    <style>
    div.calendar {
        z-index: 9999 !important;
    }
</style>
    
</head>
 <body style="background-color:azure;">
<%
// Variable Declaration
String datex1="",datex2="",bt="",dt="",dt1="",dttime="",dt1time="";

String  department = "", UserName = "", EmpCode = "", HOD = "", Dept = "",
AssignedKRA = "", KRAid = "", Assigned = "", UserID = "", UserIDKRA = "",
DepartmentAll = "", EmpNameAll = "", HODAll = "";

String comid=session.getAttribute("CompanyMasterID").toString();
String Sesrole1=session.getAttribute("role").toString();
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("PresentMonthLast").toString(); 

// Connection Initialization
Connection conn = null;
Statement st = null,stt = null,stt2 = null;
ResultSet rsDepartment=null;
Statement stDepartment=null;
ResultSet rsDepartment1=null;
Statement stDepartment1=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	st=conn.createStatement();
	stt=conn.createStatement();
	stt2=conn.createStatement();
	stDepartment=conn.createStatement();
	stDepartment1=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{	
	String name=session.getAttribute("EmpName").toString();
	bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
		System.out.println("datex1 :  "+datex1  +"  datex2 :  "+datex2);
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";
 System.out.println("dttime :  "+dttime +"   dt1time :  "+dt1time);
%>

<div class="modal fade" id="addTaskModal" tabindex="-1" aria-labelledby="#addMyModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <form name="form1" id="AddTaskform" method="post" action="insertTask.jsp">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Add Tasks</b></h4>
	<div class="row mt-1">
  	<div class="col-md-12 d-flex align-items-center">   
    <div class="col-md-4">
      <label for="tsk1" class="control-label mb-0"><b>Department:</b></label>
    </div>
    					<div class="col-md-6">
    						<select class="form-select" id="Department" name="Department"  onchange="concernpersonName();" style="font-size: 0.8rem;" >
								<option selected>Select Department</option>
								<option value="All">All</option>
								<%String sqlDepartment="select DepartmentName from db_GlobalERP."+comid+"DepartmentMaster";
								rsDepartment1=stDepartment1.executeQuery(sqlDepartment);
								while(rsDepartment1.next())
								{
								%>
								<option value="<%=rsDepartment1.getString("DepartmentName")%>"><%=rsDepartment1.getString("DepartmentName")%></option>
								<%} %>
							</select>
					
						    </div>
						     <div class="col-md-4"></div>

					  </div>
					</div>                      
					  <div class="row mt-1">
					  <div class="col-md-12 d-flex align-items-center">
					
					    <!-- Label -->
					    <div class="col-md-4">
					      <label for="tsk1" class="control-label mb-0"><b>Assigned To:</b></label>
					    </div>
					    <div class="col-md-6">
					    <select class="form-select" name="AssignedTo" id="AssignedTo" name="AssignedTo" onchange="userid();" style="font-size: 0.8rem;" >

						 <% String person=request.getParameter("concernperson");
							System.out.println("personName"+person);
						if(person!=null)
						{
							%>
							<option value="<%=person%>" selected><%=person%></option>
							<%
							} 
						%>
						</select>    
						</div>
						 <div class="col-md-4"></div>

				  </div>
				</div>
				
				  <div class="row mt-1">
				  <div class="col-md-12 d-flex align-items-center">
				    
				    <!-- Label -->
				    <div class="col-md-4">
				      <label for="tsk1" class="control-label mb-0"><b>User ID:</b></label>
				    </div>
				    <div class="col-md-6">
				      <input type="text" class="form-control" id="userId" name="userId"  readonly="readonly"  style="border: 1px solid #ced4da;">
				      
				    </div>
				     <div class="col-md-4"></div>
				  </div>
				</div>
				 
				   <div class="row mt-1">
				  <div class="col-md-12 d-flex align-items-center">
				    
				    <!-- Label -->
				    <div class="col-md-4">
				      <label for="tsk1" class="control-label mb-0"><b>Project ID:</b></label>
				    </div>
				    <div class="col-md-6">
				      <input type="text" class="form-control" id="ProjectId" name="ProjectId" style="border: 1px solid #ced4da;">   
				    </div>
				     <div class="col-md-4"></div>
				  </div>
				</div>
		      <div class="row mt-1">
		        <div class="col-md-12 d-flex align-items-center">
		      
		 <div class="col-md-4">				  
		   <label for="dropdown"><b>Task Description:</b></label>
		      </div>
		   <div class="col-md-6">  
		   <textarea class="form-control" id="description" name="description"  placeholder="add task description" style="font-size: 0.8rem;"></textarea>
		</div>
		      			<div class="col-md-2"></div>		
		      </div>
		  </div>    
      	 <div class="row mt-1">
      	   <div class="col-md-12 d-flex align-items-center">
      	 
		      	<div class="col-md-4">				  
		      		<label for="dropdown"><b>Duration (in Hrs): </b></label>
		      	</div>
   				<div class="col-md-6">
							    <input type="text" class="form-control" id="duration" name="duration" value="" style="border: 1px solid #ced4da;">
							                                                                  
				</div>		
				<div class="col-md-2"></div>		
      		</div>
      		</div>
      		
      			 <div class="row mt-1">
      			   <div class="col-md-12 d-flex align-items-center">
      			 
		      	<div class="col-md-4">				  
		      		<label for="dropdown1"><b>From Date: </b></label>
		      	</div>
   				<div class="col-md-6">
					<input type="text" class="form-control" id="fromdate" name="fromdate" value="<%=datex1%>"style="border: 1px solid #ced4da;">
			
				</div>		
				<div class="col-md-2"></div>		
      		</div>
      		</div>
      		
      		 <div class="row mt-1">
      		   <div class="col-md-12 d-flex align-items-center">
      		 
		      	<div class="col-md-4">				  
		      		<label for="dropdown"><b>To Date: </b></label>
		      	</div>
   				<div class="col-md-6">
							    <input type="text" class="form-control" id="todate" name="todate" value="<%=datex2%>" style="border: 1px solid #ced4da;">
							   
		                		<input type="hidden" id="TaskType" name="TaskType" value="PI">
				</div>		
				<div class="col-md-2"></div>		
      		</div>
      		</div>	
      		<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "fromdate",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger3"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "todate",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger2"       // ID of the button
     	        } );
</script>
       </div>
      
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
      	<button type="submit" id="submit" class="btn btn-primary btn-sm"  onclick="return chk1()">Save</button>
      </div>
           </form>
    </div>
  </div>
</div>
<!--KRA Modal  -->

<div class="modal fade" id="addKRAModal" tabindex="-1" aria-labelledby="#addMyModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
             <form name="form1" id="AddKRAform" method="post" action="insertTask.jsp" >    
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Add KRA</b></h4>
<div class="row mt-1">
  <div class="col-md-12 d-flex align-items-center">
    
    <!-- Label -->
    <div class="col-md-4">
      <label for="tsk1" class="control-label mb-0"><b>Department:</b></label>
    </div>
    <div class="col-md-6">
    <select class="form-select" id="Department1" name="Department1"  onchange="concernpersonName1();" style="font-size: 0.8rem;" >    
								<option selected>Select Department</option>															
								<option value="All">All</option>
								<%String sqlDepartment1="select distinct Dept from db_GlobalERP.UserMaster where companymasterid ='"+comid+"' and activestatus = 'Yes'";
								rsDepartment=stDepartment.executeQuery(sqlDepartment1);
								while(rsDepartment.next())
								{
								%>
								<option value="<%=rsDepartment.getString("DepartmentName")%>"><%=rsDepartment.getString("DepartmentName")%></option>
								<%} %>							</select>
					
						    </div>
						     <div class="col-md-4"></div>

  </div>
</div>                      
  <div class="row mt-1">
  <div class="col-md-12 d-flex align-items-center">

    <!-- Label -->
    <div class="col-md-4">
      <label for="tsk1" class="control-label mb-0"><b>Assigned To:</b></label>
    </div>
    <div class="col-md-6">
    <select class="form-select" id="AssignedTo1" name="AssignedTo1" onchange="userid1();" style="font-size: 0.8rem;" >
 <% String person1=request.getParameter("concernperson");
							System.out.println("personName"+person1);
						if(person1!=null)
						{
							%>
							<option value="<%=person1%>" selected><%=person1%></option>
							<%
							} 
						%>
						</select>    
						</div>
						 <div class="col-md-4"></div>
  </div>
</div>

  <div class="row mt-1">
  <div class="col-md-12 d-flex align-items-center">
    
    <!-- Label -->
    <div class="col-md-4">
      <label for="tsk1" class="control-label mb-0"><b>User ID:</b></label>
    </div>
    <div class="col-md-6">
      <input type="text" class="form-control" id="userId1" name="userId1"  readonly="readonly"  style="border: 1px solid #ced4da;">
      
    </div>
     <div class="col-md-4"></div>
  </div>
</div>
 
   <div class="row mt-1">
  <div class="col-md-12 d-flex align-items-center">
    
    <!-- Label -->
    <div class="col-md-4">
      <label for="tsk1" class="control-label mb-0"><b>Project ID:</b></label>
    </div>
    <div class="col-md-6">
      <input type="text" class="form-control" id="ProjectId1" name="ProjectId1" style="border: 1px solid #ced4da;">   
    </div>
     <div class="col-md-4"></div>
  </div>
</div>
      <div class="row mt-1">
        <div class="col-md-12 d-flex align-items-center">
      
 <div class="col-md-4">				  
   <label for="dropdown"><b>Task Description:</b></label>
      </div>
   <div class="col-md-6">  
   <textarea class="form-control" id="description1" name="description1"  placeholder="add task description" style="font-size: 0.8rem;"></textarea>
</div>
      			<div class="col-md-2"></div>		
      </div>
  </div>    
      	 <div class="row mt-1">
      	   <div class="col-md-12 d-flex align-items-center">
      	 
		      	<div class="col-md-4">				  
		      		<label for="dropdown"><b>Duration (in Hrs): </b></label>
		      	</div>
   				<div class="col-md-6">
							    <input type="text" class="form-control" id="duration1" name="duration1" value="" style="border: 1px solid #ced4da;">
							                                                                  
				</div>		
				<div class="col-md-2"></div>		
      		</div>
      		</div>
      		
      			 <div class="row mt-1">
      			   <div class="col-md-12 d-flex align-items-center">
      			 
		      	<div class="col-md-4">				  
		      		<label for="dropdown"><b>From Date: </b></label>
		      	</div>
   				<div class="col-md-6">
							    <input type="text" class="form-control" id="fromdate1" name="fromdate1" value="<%=datex1 %>" style="border: 1px solid #ced4da;">			                                                  
		                
				</div>		
				<div class="col-md-2"></div>		
      		</div>
      		</div>
      		
      		 <div class="row mt-1">
      		   <div class="col-md-12 d-flex align-items-center">
      		 
		      	<div class="col-md-4">				  
		      		<label for="dropdown"><b>To Date: </b></label>
		      	</div>
   				<div class="col-md-6">
							    <input type="text" class="form-control" id="todate1" name="todate1" value="<%=datex2 %>" style="border: 1px solid #ced4da;">
								                                         
									<input type="hidden" id="TaskType" name="TaskType" value="KRA">
				</div>		
				<div class="col-md-2"></div>		
      		</div>
      		</div>	
				<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "todate1",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger3"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "fromdate1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger2"       // ID of the button
     	        } );
</script>		
						
       </div>
      
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
      	<button type="submit" id="submit" class="btn btn-primary btn-sm"  onclick="return chk1()">Save</button>
      </div>
           </form>
      
    </div>
  </div>
</div>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Allocation Report</h5>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-3"></div>
		    <%if(Sesrole1.equals("AllAdmin") || Sesrole1.equalsIgnoreCase("HOD")) { %>
		    <div class="col-md-1">
			<label></label>
					<div class="input-group input-group-merge" style="width:250px;">
						<button type="button" class="btn btn-primary" id="button"  data-bs-toggle="modal" data-bs-target="#addTaskModal" style="font-size: 13px;">Add Task</button>
					</div>
			</div>
			<div class="col-md-1">
			<label></label>
					<div class="input-group input-group-merge" style="width:250px;">
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addKRAModal" id="button" style="font-size: 13px;">Add KRA</button>
					
				</div>
			</div>
			<%} %>
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
			<div class="col-md-1"></div>
		</div>
		<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
		<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
		<input type="hidden" id="comid" name="comid" value="<%=comid%>" />
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

		%>
		<%
String Sesrole2=session.getAttribute("role").toString();
		String Bt=request.getParameter("button");
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
			System.out.println("----------In Button-------------");

			String POStatus="Pending";
			String name13=session.getAttribute("EmpName").toString();						
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
		%>
<div class = "container" style="width: 80%">
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            	<th>Id</th>
            	<th>User</th>
            	<th>Department</th>
            	<th>PI</th>
            	<th>KRA</th>	        
            </tr>
        </thead> 
        <tbody>
         <%			 			 
			 if(Sesrole2.equals("AllAdmin") || Sesrole2.equalsIgnoreCase("HR")){
				 DepartmentAll="";
				 EmpNameAll="";
				 HODAll="";
				 
			 }
			 else if(Sesrole2.equals("HOD")){
				 DepartmentAll="";
				 EmpNameAll=SesmUsername;
				 HODAll=SesmUsername;
			 }			
			 String sqlTaskAllocation="select Empname as User,dotprojectid as UserID,c.kradotprojectid as KRAid,empcode,HodReport as HOD "
					 +",Dept as Department,IFNULL((select sum(a.task_duration)  from "
							 +"dotproject.tasks a left join dotproject.user_tasks b on " 
							 +"a.task_id=b.task_id  where task_end_date >='"+dttime+"' and "
							 +"task_end_date <='"+dt1time+"'  and user_id=c.dotprojectid ),0) "
							 +"as Assigned from db_GlobalERP.UserMaster c where c.activestatus='Yes' "
							 +"and c.companymasterid='"+comid+"' and c.dept like '%"+DepartmentAll+"%' and "
							 +"(c.HODReport like '%"+HODAll+"%' OR c.EmpName like '%"+EmpNameAll+"%' ) order by c.Empname";

			  System.out.println("Query is : "+sqlTaskAllocation);
			  ResultSet rs = st.executeQuery(sqlTaskAllocation);

		      int i=1;
		      while(rs.next()){
		    	  EmpCode=rs.getString("empcode");
		    	  UserID=rs.getString("UserID");
		    	  UserName=rs.getString("User");
		    	  HOD=rs.getString("HOD");
		    	  KRAid=rs.getString("KRAid");

		    	  Dept=rs.getString("Department");
		    	  Assigned=rs.getString("Assigned");
		    	  int AssignedNew= new Double(Assigned).intValue();
		    	  System.out.println("Records :- "+EmpCode+" , "+UserName+" , "+HOD+" , "+Dept+" , "+AssignedNew+" , "+KRAid+" ");
		    	  
		    	  String sqlTaskAllocation1="select Empname as User,kradotprojectid as UserID,empcode,HodReport as HOD "
							 +",Dept as Department,IFNULL((select sum(a.task_duration)  from "
									 +"dotproject.tasks a left join dotproject.user_tasks b on " 
									 +"a.task_id=b.task_id  where task_end_date >='"+dttime+"' and "
									 +"task_end_date <='"+dt1time+"'  and user_id=c.kradotprojectid ),0) "
									 +"as Assigned from db_GlobalERP.UserMaster c where c.activestatus='Yes' "
									 +"and c.companymasterid='"+comid+"' and c.dept like '%"+DepartmentAll+"%' and c.kradotprojectid='"+KRAid+"' and "
									 +"(c.HODReport like '%"+HODAll+"%' OR c.EmpName like '%"+EmpNameAll+"%' ) order by c.Empname";

					  System.out.println("Query is1 : "+sqlTaskAllocation1);
					  ResultSet rsss = stt.executeQuery(sqlTaskAllocation1);
					  int AssignedNewKRA=0;
				      if(rsss.next()){
				    	  UserIDKRA=rsss.getString("UserID");
				    	  AssignedKRA=rsss.getString("Assigned");
				    	   AssignedNewKRA= new Double(AssignedKRA).intValue();
				      }
		    	  
		    	  
			 %>
         <tr> 
  				<td class="text-center"><%=i%></td>
				<td  class="text-center"><%=EmpCode%></td>
            	<td class="text-left"><%=UserName%></td>
            	<td class="text-left"><%=Dept%></td>
            	
            	 <td  class="text-center">
            	<a href="TaskDetRepFrTaskAllo.jsp?userid=<%=UserID %>&fromdate=<%=datex1 %>&todate=<%=datex2 %>&HOD=<%=HOD%>&Dept=<%=Dept %>&User=<%=UserName %>&Status=Assigned&role=<%=Sesrole2%>">
            	 <%=AssignedNew%></a></td>           	           	
            	 <td  class="text-center">
            	<a href="KRADetRepFrTaskAllo.jsp?userid=<%=UserIDKRA %>&fromdate=<%=datex1 %>&todate=<%=datex2 %>&HOD=<%=HOD%>&Dept=<%=Dept %>&User=<%=UserName %>&Status=Assigned&role=<%=Sesrole2%>">
            	 <%=AssignedNewKRA%></a></td>
				</tr>
				<%
                   i++;      
     			 }                                  
                  %>  
        </tbody>
 </table>
 </div>
 <% 		
		}
		else
		{						
			String seldept=request.getParameter("companyName1"); 
			%>
			<div class = "container" style="width: 80%">
			<table id="example" class="display" style="width:100%;">  
			<thead>
			<tr>
            <th class="col-width-4">SrNo.</th>
            	<th>Id</th>
            	<th>User</th>
            	<th>Department</th>
            	<th>PI</th>
            	<th>KRA</th>	        
            </tr>
			</thead>
			<tbody>
			<%
			 if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HR")){
				 DepartmentAll="";
				 EmpNameAll="";
				 HODAll="";
			 }
			 else if(Sesrole2.equals("HOD")){
				 DepartmentAll="";
				 EmpNameAll=SesmUsername;
				 HODAll=SesmUsername;
			 }
			 String sqlTaskAllocation="select Empname as User,dotprojectid as UserID,c.kradotprojectid as KRAid,empcode,HodReport as HOD "
					 +",Dept as Department,IFNULL((select sum(a.task_duration)  from "
							 +"dotproject.tasks a left join dotproject.user_tasks b on " 
							 +"a.task_id=b.task_id  where task_end_date >='"+dttime+"' and "
							 +"task_end_date <='"+dt1time+"'  and user_id=c.dotprojectid ),0) "
							 +"as Assigned from db_GlobalERP.UserMaster c where c.activestatus='Yes' "
							 +"and c.companymasterid='"+comid+"' and c.dept like '%"+DepartmentAll+"%' and "
							 +"(c.HODReport like '%"+HODAll+"%' OR c.EmpName like '%"+EmpNameAll+"%' ) order by c.Empname";

			  System.out.println("Query is : "+sqlTaskAllocation);
			  ResultSet rs = st.executeQuery(sqlTaskAllocation);
		      int i=1;
		      while(rs.next()){
		    	  EmpCode=rs.getString("empcode");
		    	  UserID=rs.getString("UserID");
		    	  UserName=rs.getString("User");
		    	  HOD=rs.getString("HOD");
		    	  KRAid=rs.getString("KRAid");
		    	  Dept=rs.getString("Department");
		    	  Assigned=rs.getString("Assigned");
		    	  int AssignedNew= new Double(Assigned).intValue();
		    	  System.out.println("Records :- "+EmpCode+" , "+UserName+" , "+HOD+" , "+Dept+" , "+AssignedNew+" , ");
		    	  String sqlTaskAllocation1="select Empname as User,kradotprojectid as UserID,empcode,HodReport as HOD "
							 +",Dept as Department,IFNULL((select sum(a.task_duration)  from "
									 +"dotproject.tasks a left join dotproject.user_tasks b on " 
									 +"a.task_id=b.task_id  where task_end_date >='"+dttime+"' and "
									 +"task_end_date <='"+dt1time+"'  and user_id=c.kradotprojectid ),0) "
									 +"as Assigned from db_GlobalERP.UserMaster c where c.activestatus='Yes' "
									 +"and c.companymasterid='"+comid+"' and c.dept like '%"+DepartmentAll+"%' and c.kradotprojectid='"+KRAid+"' and "
									 +"(c.HODReport like '%"+HODAll+"%' OR c.EmpName like '%"+EmpNameAll+"%' ) order by c.Empname";

					  System.out.println("Query is1 : "+sqlTaskAllocation1);
					  ResultSet rsss = stt2.executeQuery(sqlTaskAllocation1);
					  int AssignedNewKRA=0;
				      if(rsss.next()){
				    	  UserIDKRA=rsss.getString("UserID");
				    	  AssignedKRA=rsss.getString("Assigned");
				    	   AssignedNewKRA= new Double(AssignedKRA).intValue();
				      }
			 %>
			 
			<tr>		
			<td class="text-center"><%=i%></td>
				<td class="text-center"><%=EmpCode%></td>
            	<td class="text-left"><%=UserName%></td>
            	<td class="text-left"><%=Dept%></td>
            	<td class="text-center">
            	<a href="TaskDetRepFrTaskAllo.jsp?userid=<%=UserID %>&fromdate=<%=datex1 %>&todate=<%=datex2 %>&HOD=<%=HOD%>&Dept=<%=Dept %>&User=<%=UserName %>&Status=Assigned&role=<%=Sesrole2%>">
            	 <%=AssignedNew%></a></td>
            	 
            	 <td class="text-center">
            	<a href="KRADetRepFrTaskAllo.jsp?userid=<%=UserIDKRA %>&fromdate=<%=datex1 %>&todate=<%=datex2 %>&HOD=<%=HOD%>&Dept=<%=Dept %>&User=<%=UserName %>&Status=Assigned&role=<%=Sesrole2%>">
            	 <%=AssignedNewKRA%></a></td>          	
            </tr>           
             <%
                   i++;      
     			 } 
                  %>     
             </tbody>
		<% }
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
								title: 'Task Allocation Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Task Allocation Report from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Task Allocation Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Task Allocation Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Task Allocation Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
 <script>
  function concernpersonName()
  {
  	var dept=document.getElementById("Department").value;
  	var ajaxRequest; 
  	try
  	{
  		ajaxRequest = new XMLHttpRequest();
  	}  
  	catch (e)
  	{
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
  				alert("Your browser broke!");
  				return false;
  			}
  		}
  	}
  	ajaxRequest.onreadystatechange = function()
  	{
  		if(ajaxRequest.readyState == 4)
  		{ 
  		   var reselt=ajaxRequest.responseText;
  		   document.getElementById("AssignedTo").innerHTML=reselt;
  		}
  	
  	}
  	var queryString = "?dept="+dept;  
  	ajaxRequest.open("GET", "ConcernAjax.jsp"+queryString, true);
  	ajaxRequest.send(null); 
  	}
  function concernpersonName1()
  {
  	var dept=document.getElementById("Department1").value;
  	var ajaxRequest; 
  	try
  	{
  		ajaxRequest = new XMLHttpRequest();
  	}  
  	catch (e)
  	{
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
  				alert("Your browser broke!");
  				return false;
  			}
  		}
  	}
  	ajaxRequest.onreadystatechange = function()
  	{
  		if(ajaxRequest.readyState == 4)
  		{ 
  			
  		   var reselt=ajaxRequest.responseText;
  		   document.getElementById("AssignedTo1").innerHTML=reselt;
  		}
  	
  	}
  	
  	var queryString = "?dept="+dept;  
  	ajaxRequest.open("GET", "ConcernAjax.jsp"+queryString, true);
  	ajaxRequest.send(null); 
  	}
  function userid()
  {
  	var AssignedTo=document.getElementById("AssignedTo").value;
  	var ajaxRequest; 
  	try
  	{
  		ajaxRequest = new XMLHttpRequest();
  	}  
  	catch (e)
  	{
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
  				alert("Your browser broke!");
  				return false;
  			}
  		}
  	}
  	ajaxRequest.onreadystatechange = function()
  	{
  		if(ajaxRequest.readyState == 4)
  		{ 
  		   var reselt=ajaxRequest.responseText;
  		   document.getElementById("userId").value=reselt;
  		}
  	}
  	
  	var queryString = "?task=PI&AssignedTo="+AssignedTo;  
  	ajaxRequest.open("GET", "UserIdAjax.jsp"+queryString, true);
  	ajaxRequest.send(null);  	
  	}
  function userid1()
  {
  	var AssignedTo=document.getElementById("AssignedTo1").value;
  	var ajaxRequest; 
  	try
  	{
  		
  		ajaxRequest = new XMLHttpRequest();
  	}  
  	catch (e)
  	{
  		
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
  				
  				alert("Your browser broke!");
  				return false;
  			}
  		}
  	}
  	 	
  	ajaxRequest.onreadystatechange = function()
  	{
  		if(ajaxRequest.readyState == 4)
  		{ 
  		   var reselt=ajaxRequest.responseText;
  		   document.getElementById("userId1").value=reselt;
  		}
  	
  	}
  	
  	var queryString = "?task=KRA&AssignedTo="+AssignedTo;  
  	ajaxRequest.open("GET", "UserIdAjax.jsp"+queryString, true);
  	ajaxRequest.send(null); 
     
  	}
  </script>
 <%@ include file="footer.jsp" %>
 </body>
</html>