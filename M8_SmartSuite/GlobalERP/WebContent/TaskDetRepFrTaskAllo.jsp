<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
  <%@page import="java.util.Date"%>
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
String query12="";

ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;
%>
<%!Connection conn = null;
%>
<%
String datenew1="";
String datenew2="";
String date1 = "";
String date2 = "";
String dept = "";
String user_id1 = "";
String user11="";
String tDate1 = "";
String tDate2 = "";
String UserID="";
String fromdate="";
String todate="";
String HOD="";
String Dept="";
String User="";
String Status="",s="";
String Role="";
String EmpName1="";
String department="";


try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    stmt=conn.createStatement();
    stmt1=conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 

String comid=session.getAttribute("CompanyMasterID").toString();
String Sesrole1=session.getAttribute("role").toString();
String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
String Bt3=request.getParameter("button");
System.out.println("----------In Button-------------11111111111"+Bt3);
		if(Bt3==null || Bt3=="null" || Bt3.equals("null"))
		{

	
	System.out.println("==in if==");
	datenew1 = request.getParameter("fromdate");
	datenew2 = request.getParameter("todate");

	 user11=request.getParameter("User");
	 UserID=request.getParameter("userId");
	System.out.println("UserID::"+UserID);
	 fromdate=request.getParameter("fromdate");
	System.out.println("fromdate::"+fromdate);
	 todate=request.getParameter("todate");
		System.out.println("todate::"+todate);
	 HOD=request.getParameter("HOD");
		System.out.println("HOD::"+HOD);
	 Dept=request.getParameter("Dept");
		System.out.println("Dept::"+Dept);
	 User=request.getParameter("User");
		System.out.println("User::"+User);
	 Status=request.getParameter("Status");
		System.out.println("Status::"+Status);
	 Role=request.getParameter("role");
		System.out.println("role::"+Role);
		if(Status.equals("Submited"))
		{
			Status="Submitted";
		} 

	Calendar cal = Calendar.getInstance();
	String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data2 = today_dt;
	String temp = data2;
	String toDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	//cal.add(Calendar.DATE, -1);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data1 = yesterday_dt;
	temp = data1;
	String fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	
	datenew1 = fromdate;
	datenew2 = todate;
	
	if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	{
		datenew1 = ""+datenew1;
		datenew2 = ""+datenew2;
	}
	else
	{
	tDate1 = datenew1;
	tDate2 = datenew2;
	}
}
else
{

	System.out.println("==in else==");
	datenew1 = request.getParameter("from_date1");
	datenew2 = request.getParameter("to_date1");
	user11=request.getParameter("User");
	UserID=request.getParameter("userId");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	HOD=request.getParameter("HOD");
	Dept=request.getParameter("Dept");
	User=request.getParameter("User");
	Status=request.getParameter("status");
	System.out.println("Status"+Status);
	Role=request.getParameter("role");
		
		
		if(Status.equals("Submited"))
		{
			Status="Submitted";
		}
			
 date1 = datenew1;
 date2 = datenew2;
 	tDate1 = date1;
	tDate2 = date2;
}

 %>
 <input type="hidden" name="Status" id="Status" value=""></input>  
  <!-- Missed Modal -->
<div class="modal fade" id="addMyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Task Missed</b></h4>
        <div class="row">
             <div class="col-md-5">
             <div class="row">
           <div class="col-md-3">
            <label for="uid" class="control-label"><b>UserID: </b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="usrid1" name="usrid1" readonly="readonly" class="form-control">
        </div>
        </div>
        </div>
          <div class="col-md-7">
         <div class="row">
           <div class="col-md-3">
            <label for="tid" class="control-label"><b>TaskID:</b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="tskid" name="tskid" readonly="readonly" class="form-control">
        </div>
        </div>
             </div> 
             </div>
             <div class="row mt-1">
  <div class="col-md-12 d-flex align-items-center">
    
    <!-- Label -->
    <div class="col-md-3">
      <label for="tsk1" class="control-label mb-0"><b>Task Description:</b></label>
    </div>
    <div class="col-md-9">
      <input type="text" id="tsk1" name="tsk1" readonly="readonly" class="form-control">
    </div>

  </div>
</div>

         <hr>
         <form name="form1" id="newModalForm" method="post" action="TaskNextKRA.jsp" enctype="multipart/form-data">

		

       <div class="row mt-3">
 <div class="col-md-3">				  
   <label for="dropdown"><b>Status(Current):</b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" name="status" id="status" onchange="fun();" style="width: 76%;" >
					       <option value="" disabled selected>Select</option>
    	  				<option id="Process">In Progress</option>
 
  	  	  				<option id="Submitted">Completed</option>
  	
  	  				</select>
      			<div class="col-md-3"></div>		
      </div>
      
      
      </div>
      </div>

      <div class="row mt-3">
 <div class="col-md-3">				  
   <label for="dropdown"><b>Comments:</b></label>
      </div>
   <div class="col-md-6">  
   <textarea class="form-control" id="comments31" name="comments31"  placeholder="Comments" style="font-size: 0.8rem;"></textarea>
</div>
      			<div class="col-md-3"></div>		
      </div>
      
      						<div class="row mt-3" id="per"></div>  <!-- For % Dropdown / readonly text  -->
						
						<div class="row mt-3">
						  <div class="col-md-3">
						     <label for="dropdown"><b>Upload Files:</b></label>
						     </div>
							<div class="col-md-9">			
							<div id="fileInputs">						
                            <div class="mb-2 d-flex align-items-center">
                                <span><input type="file" name="files" class="form-control" required></span>
                            </div>
                        </div>
                           <button type="button" class="btn btn-success btn-sm col-md-3" onclick="addFileInput()" id="addFile">Add</button>
                           
						</div>
						</div>
      </form>
       </div>
      
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="btnCloseIt">Close</button>
      	<button type="button" id="submit" class="btn btn-primary btn-sm" id="btnSaveIt" onclick="return approve1()">Save</button>
      </div>
    </div>
  </div>
</div>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Report </h5>
    </div>
</div>
<form name="custreport" id="custreport" method="post">	   
	<div class="row col-12">
		    <div class="col-md-1"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="companyName1" name="companyName1" onchange="consig();" >
                            <%	
					         	String Bt4=request.getParameter("button");
					          if(Bt4==null || Bt4=="null" || Bt4.equals("null"))
					        	  {%>
					
					          <%if(Sesrole1.equals("AllAdmin")) {
					           %>
					            <option value="<%=Dept%>"><%=Dept%></option>
					           	<option value="All">All</option>
					            
					            <%} 
					            else
					            { %>
					            <option value="<%=Dept%>"><%=Dept%></option>
					            <%} %>
					            <%}
					            else 
					            {
					            String seldept=request.getParameter("companyName1"); 
					    	    if(Sesrole1.equals("AllAdmin")) {
					           %>
					             <option value="<%=seldept%>"><%=seldept%></option>
					             <option value="All">All</option>
					             <%} 
					            else
					            {%>
					            <option value="<%=seldept%>"><%=seldept%></option>
					            <%}  } %>
					            <%
					           
					            String sql1="";
					             if(Sesrole1.equals("AllAdmin"))
					        	{
					            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and dotprojectid!='-'order by dept";
					        	}
					            else if (Sesrole1.equals("HOD"))
					             {
					            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and dotprojectid!='-' order by dept";
					             }
					            else
					            {
					            	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and dotprojectid!='-' order by dept";
					            }
					        ResultSet rsregno = st.executeQuery(sql1);
							while(rsregno.next())
							{
								department=rsregno.getString("department");
								%>			
								<option value="<%=department%>"><%=department%></option>
						         <%
					      }
							%>
                           </select>
                            <script>
                            const mySel = document.getElementById("companyName1");
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; 
                             } else if (savedValue) {
                              mySel.value = savedValue;
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value);
                               });
                             </script>			
		                </div>
			</div>	
			 <div class="col-md-2">
				  <label for="dropdown"><b>Name</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="EmpName" name="EmpName">
			               <%	String Bt2=request.getParameter("button");
          if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
        	  {%>
          <%if(Sesrole1.equals("AllAdmin")) {
           %>
                    <option value="<%=User%>"><%=User%></option>    
           			<option value="All">All</option>
           
           <%} else
           {%>
           			<option value="<%=User%>"><%=User%></option>
           <%} }
            else 
            {
  			EmpName1=request.getParameter("EmpName"); 
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
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; 
                             } else if (savedValue) {
                              mySel.value = savedValue;
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value);
                               });
                             </script>	
			  			</div>
			</div>
				<div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
<select class="form-select" id="status" name="status">
<%System.out.println("Status"+Status); %>
            <option ><%=Status %></option>
                        <%
            String sql14="";
	sql1="select distinct(TaskStatus) as status from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskStatus!='Duplicate'";

        System.out.println("*******"+sql1);
        ResultSet rsregno123 = st.executeQuery(sql1);
		while(rsregno123.next())
		{
			 
			s=rsregno123.getString("Status");
			
			
			%>
			<option value="<%=s%>"><%=s%></option>
	         <%
	        // customer=customer.replaceAll("&", "..");
      }
		 System.out.println("s--1223456789-0987755 > "+s);
		%>
  
</select>
   <script>
                            const mySel = document.getElementById("status");
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; 
                             } else if (savedValue) {
                              mySel.value = savedValue;
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value);
                               });
                             </script>
</div>
			     </div>
			               
			               
			               		
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="from_date1" id="data"  class="form-control" value="<%=datenew1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="to_date1"  class="form-control" value="<%=datenew2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
		</div>
	<input type="hidden" id="comid" name="comid" value="<%=comid%>" />
	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
	<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
	<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
	<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
	<input type="hidden" name="datenew1" id="datenew1" value=""></input>
  	<input type="hidden" name="datenew2" id="datenew2" value=""></input>       
  	<input type="hidden" name="HOD" id="HOD" value=""></input>   
    <input type="hidden" name="Dept" id="Dept" value=""></input>       
    <input type="hidden" name="Usern" id="Usern" value=""></input>  
	<input type="hidden" name="Status" id="Status" value="<%=Status%>"></input>       
    <input type="hidden" name="Role" id="Role" value=""></input>  

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
		
	
<table id="example" class="display" style="width:100%">
<thead>
<%

if(Status.equals("Assigned")||Status.equals("Missed"))
{
%>  
				<tr>
						<th width="4%">SrNo.</th>
						<th>User</th>
						<th>UserID</th>
						<th>TaskID</th>
						<th>TaskName</th>
						<th>Duration</th>
						<th>StartDate</th>
						<th>EndDate</th>
						<th>Status</th>
				</tr>
  
            <%} 
            else
            { %>

				<tr>
						<th width="4%">SrNo.</th>
						<th>User</th>
						<th>UserID</th>
						<th>TaskID</th>
						<th>TaskName</th>
						<th>Duration</th>
						<th>StartDate</th>
						<th>EndDate</th>
						<th>Percentage</th>
						<th>Comment</th>
						<th>Status</th>
			</tr>

              <%} %>
              </thead>

<tbody>
<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String CustomerCode="";
	String dotprojectid="";	
	String stp="Pending";

	//CompanyName ---->null
	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");		
		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	
String user="";
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	String name1=session.getAttribute("EmpName").toString();
	String department1=session.getAttribute("department").toString();
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		dt=dt+" 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew2));
		dt1=dt1+" 23:59:59";
		
		System.out.println("dt:- "+dt);
		System.out.println("dt1:- "+dt1);
		System.out.println("fromDate1:- "+datenew1);
		System.out.println("dtoday:- "+datenew2);		
		%>
		
		
<%
String name13="";
		String Bt=request.getParameter("button");
System.out.println("----------In Button-------------"+Bt);
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			 name13=session.getAttribute("EmpName").toString();
			String Sesrole2=session.getAttribute("role").toString();
			String seldept=request.getParameter("companyName1"); 
        	if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
        	{
        		name13=User;	
        	}
        	else
        	{
        		name13=""+name13;
        	}
        	if(Sesrole2.equals("AllAdmin"))
        			{
        		department=Dept;
            	System.out.println("departmentkkk :- "+department);

        			}
        	else
        	{
        		department=Dept;
            	System.out.println("departmentggfgh :- "+department);

        	}
        	
        	if(name13.equals("All"))

        	{
        		name13="";
        	}
        	
        if(Status.equals("Assigned"))
        {
        	
			System.out.println("IN Assigned");
 			query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+user11+"%'  and c.dept like '%"+department+"%'";
			rs=stmt.executeQuery(query12);
			int i=1;
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=User%></td>
						<td class="text-center"><%=UserID%></td>
						<td class="text-center"><%=TaskId%></td>
						<td class="text-left"><%=TaskName%></td>
						<td class="text-center"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-right"><%=Status%></td>
						
					 </tr>
			<%
			i++;
			}
        
        }
        else if(Status.equals("Missed"))
        {
			System.out.println("IN Missed");

 			query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+user11+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.KRAdotprojectid)  and c.dept like '%"+department+"%'";
			rs=stmt.executeQuery(query12);
			System.out.println("IN query12"+query12);

			int i=1;
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>
						
						<td class="text-right"><%=UserID%></td>
						<td class="text-center">
 							<a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td> 					
						<td class="text-left"><%=TaskName%></td>
						<td class="text-right"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-left"><%=Status%></td>
						
					 </tr>
			<%
			i++;
			}
        }
        
        else if(Status.equals("Submitted"))
        {
			 query12="select b.UserID as UserId,c.EmpName as User,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select KRAdotprojectid from db_GlobalERP.UserMaster where empname like '%"+user11+"%' and companymasterid= and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and c.activestatus='Yes' and b.TaskStatus!='Duplicate'  and dept like '%"+department+"%' order by b.taskid";
        	System.out.println("query12---"+query12);
			rs=stmt.executeQuery(query12);
			int i=1;
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
				Stat=rs.getString("Status");
				TaskPercent=rs.getString("TaskPercent");
				TaskComment=rs.getString("TaskComment");
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>
						
						<td class="text-center"><%=UserID%></td>
 						<td class="text-center">
 	 						<a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
 						<td class="text-left"><%=TaskName%></td>
						<td class="text-center"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-right"><%=TaskPercent%></td>
						<td class="text-left"><%=TaskComment%></td>
						<td class="text-left"><%=Status%></td>
						
					 </tr>
			<%
			i++;
			}
        }
        else
        {      	
 			query12="select b.UserID as UserId,c.EmpName as User,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+user11+"%' and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and c.activestatus='Yes' and b.TaskStatus like '%"+Status+"%'  and dept like '%"+department+"%' order by b.taskid";  	
        	System.out.println("query12---"+query12);
			rs=stmt.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
				Stat=rs.getString("Status");
				TaskPercent=rs.getString("TaskPercent");
				TaskComment=rs.getString("TaskComment");
				if(TaskComment==null || TaskComment.equalsIgnoreCase(" ")){
					TaskComment="-";
				}
				if(Stat==null || Stat.equalsIgnoreCase(" ")){
					Stat="-";
				}
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>
						
						<td class="text-center"><%=UserID%></td>
 						<td class="text-center">
  							<a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Stat%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
 						<td class="text-left"><%=TaskName%></td>
						<td class="text-center"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-right"><%=TaskPercent%></td>
						<td class="text-left"><%=TaskComment%></td>
						<td class="text-left"><%=Stat%></td>
						
			</tr>
			<%
			i++;
			}
        }
%>
    
			
		<% 
		}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		else
		{
			System.out.println("----------In Button-------------");

		String POStatus="Pending";
		String comid2=session.getAttribute("CompanyMasterID").toString();
		 name13=session.getAttribute("EmpName").toString();
		String Sesrole2=session.getAttribute("role").toString();					
		String seldept=request.getParameter("companyName1");     
		 Status=request.getParameter("status");     	

    	if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
    	{
    		name13=EmpName1;	
    	}
    	else
    	{
    		name13=""+name13;
    	}
    	if(Sesrole2.equals("AllAdmin"))
    			{
    		department=seldept;
    			}
    	else
    	{
    		department=seldept;
    	}
    	if(name13.equals("All"))
    	{
    		name13="";
    	}
    	
    if(Status.equals("Assigned"))
    {
    	
		System.out.println("IN Assigned");

 			query12="select c.EmpName as User ,a.task_status as Status,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+user11+"%'  and c.dept like '%"+department+"%'";
   
		System.out.println("query12---"+query12);
		rs=stmt.executeQuery(query12);
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
			Stat = rs.getString("Status");
			//Stat="-";
		%>
				<tr>
					<td class="text-right"><%=i%></td>
					<td class="text-left"><%=User%></td>
					
					<td class="text-right"><%=UserID%></td>
					<td class="text-right"><%=TaskId%></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-right"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-left"><%=Stat%></td>
				 </tr>
		<%
		i++;
		}
    
    }
    else if(Status.equals("Missed"))
    {
		System.out.println("IN Missed");

 	query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,a.task_status as Status  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+user11+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.KRAdotprojectid)  and c.dept like '%"+department+"%'";
    	System.out.println("query12---"+query12);
		rs=stmt.executeQuery(query12);		
		int i=1;	
		while(rs.next())
		{
		
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
			Stat = rs.getString("Status");
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					
					<td class="text-center"><%=UserID%></td>
					<td class="text-center">
						<a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Stat%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-right"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-left"><%=Stat%></td>
				 </tr>
		<%
		i++;
		}
    }
    else if(Status.equals("Submitted"))
    {
 		query12="select b.UserID as UserId,c.EmpName as User,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+user11+"%' and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and c.activestatus='Yes' and b.TaskStatus!='Duplicate'  and dept like '%"+department+"%' order by b.taskid";
    	System.out.println("query12---"+query12);
		rs=stmt.executeQuery(query12);
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
			Stat=rs.getString("Status");
			TaskPercent=rs.getString("TaskPercent");
			TaskComment=rs.getString("TaskComment");
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					
					<td class="text-center"><%=UserID%></td>
 					<td class="text-center">
   						<a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Stat%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-center"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-right"><%=TaskPercent%></td>
					<td class="text-left"><%=TaskComment%></td>
					<td class="text-left"><%=Stat%></td>
				 </tr>
		<%
		i++;
		}
    }
    else
    {
 		query12="select b.UserID as UserId,c.EmpName as User,a.task_id as TaskId,a.task_name as TaskName,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+user11+"%' and companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+session.getAttribute("CompanyMasterID").toString()+"' and c.activestatus='Yes' and b.TaskStatus like '%"+Status+"%'  and dept like '%"+department+"%' order by b.taskid";
    	System.out.println("query12---"+query12);
		rs=stmt.executeQuery(query12);
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
			Stat=rs.getString("Status");
			TaskPercent=rs.getString("TaskPercent");
			TaskComment=rs.getString("TaskComment");
			
			if(TaskComment==null || TaskComment.equalsIgnoreCase(" ")){
				TaskComment="-";
			}
			if(Stat==null || Stat.equalsIgnoreCase(" ")){
				Stat="-";
			}
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					
					<td class="text-center"><%=UserID%></td>
 					<td class="text-center">				
  						<a style="color: #0d6efd;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Stat%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-center"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-right"><%=TaskPercent%></td>
					<td class="text-left"><%=TaskComment%></td>
					<td class="text-left"><%=Stat%></td>
					
				 </tr>
		<%
		i++;
		}
    }
%>
	<% 
	}
		%>
</tbody>	
</table>
 </div> 

</body>
<script type="text/javascript">
function consig()
{
	var dept=document.getElementById("companyName1").value;
	var ajaxRequest;  // The variable that makes Ajax possible!
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
			catch (e)7
			{
				alert("Your browser broke!");
				return false;
			}
		}
	}
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
</script>
<script>

function approve1()
{
	var Dept=document.getElementById('Dept').value;
	var Usern=document.getElementById('Usern').value;
	var HOD=document.getElementById('HOD').value;
	var dd=document.getElementById('datenew1').value;
	var dd1=document.getElementById('datenew2').value;
 	var Status=document.getElementById("Status").value;
	var Role=document.getElementById('Role').value;
 	var userId=document.getElementById("usrid1").value;
	var User=document.getElementById("tsk1").value;
	var TaskID=document.getElementById("tskid").value;
	var satat=document.getElementById('status').value;
	var other=document.getElementById('other12').value;
	other = other.replace("%", "");
	var comment=document.getElementById('comments31').value;
	if(comment=="")
		{
		vali();		
		}
	 
	var li=location.assign("TaskNextKRA.jsp?userId1="+userId+"&User1="+User+"&Role="+Role+"&Usern="+Usern+"&TaskID1="+TaskID+"&Dept="+Dept+"&Status="+Status+"&datenew1="+dd+"&HOD="+HOD+"&datenew2="+dd1+"&satat1="+satat+"&other123="+other+"&comment1="+comment);
	alert("Loading...Do not click OK");
	}
</script>
<script>
function demo(datenew1,datenew2,HOD,Dept,User,Status,Role,TaskName,UserID,TaskId)
{
	document.getElementById('tsk1').value = TaskName;
   	document.getElementById('usrid1').value = UserID;
	document.getElementById('tskid').value = TaskId;
	document.getElementById('datenew1').value = datenew1;
    document.getElementById('datenew2').value = datenew2;
	document.getElementById('HOD').value = HOD;
	document.getElementById('Dept').value = Dept;
	document.getElementById('Usern').value = User;
	document.getElementById('Status').value = Status;
	document.getElementById('Role').value = Role;
}
</script>
<script>
function fun()
{
	var a=document.getElementById('status').value;
     if(a=='Completed')
 	  {
    	 var aa='<label class="control-label col-md-3" for="email">Percentage*:</label><input type="text" id="other12" name="other12" style="width:30%;" value="100%" readonly ></input></div>';
    	   document.getElementById('per').innerHTML=aa;
 	  }
     else if(a=='In Progress')
    	 {
    	 var bb='<label class="control-label col-md-3" for="email">Percentage*:</label><select name="other12" id="other12" style="width: 100px; height:20px; border: 1px solid black;"><option>25%</option><option>50%</option><option>75%</option</select>';
  	   document.getElementById('per').innerHTML=bb;
    	 }
}
</script>
<script>
function vali()
{
	var comment=document.getElementById("comment").value;
	if(comment=="")
		{
		alert("Enter comment");
		return false;
		}
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
	        // fixedColumns: { 
	     //       left: 3      //To freeze two columns
	     //   }, 
	        //keys: true,  //Keytable
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
	                         title: 'Task Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Task Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Task Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Task Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Task Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>

 <%@ include file="footer.jsp" %>
</html>