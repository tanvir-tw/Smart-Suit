<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@page import="java.util.Date"%>
 <%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
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
String query12="",datenew1="",datenew2="",date1 = "", date2 = "",tDate1 = "", tDate2 = "", fromdate="", todate="";
String dept = "",user_id1 = "", UserID="", HOD="",  Dept="", User="", Status="",stat="", Role="";
String department="",EmpName1="",project_id="",task_project="";
String comid = session.getAttribute("CompanyMasterID").toString();

 // Connection Initialization
Connection conn = null;
Statement st = null, st1=null,  stmt=null, stmt1=null, stmain=null,stmain1=null, stmain2=null;
ResultSet rs=null,rs1=null;

try {
	conn = connection.getConnect("dotproject");    
    st = conn.createStatement();
    stmt=conn.createStatement();
    stmt1=conn.createStatement();
    stmain1=conn.createStatement();
    stmain2=conn.createStatement();
    st1=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
	String type=request.getParameter("status");
	String user_name = request.getParameter("user_name");
	String totalTask = request.getParameter("totalTask");
	String frmDate = request.getParameter("frmDate");
	String toTime = request.getParameter("toTime");
	String user_id = request.getParameter("user_id");
	System.out.println("user_id::"+user_id);
	String Sesrole1=session.getAttribute("role").toString();
	String name=session.getAttribute("EmpName").toString();
	String sessiondept=session.getAttribute("department").toString();

	String Bt1=request.getParameter("button");
	System.out.println("----------In Button-------------11111111111"+Bt1);
			if(Bt1==null || Bt1=="null" || Bt1.equals("null"))
			{
		System.out.println("==in if==");
		datenew1 = request.getParameter("fromdate");
		datenew2 = request.getParameter("todate");
		
		UserID=request.getParameter("userId");
		System.out.println("UserID::"+UserID);
		fromdate=request.getParameter("fromdate");
		todate=request.getParameter("todate");
		HOD=request.getParameter("HOD");
		Dept=request.getParameter("Dept");
		User=request.getParameter("User");
		Status=request.getParameter("Status");
		Role=request.getParameter("role");	
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
		System.out.println("IN datenew1"+datenew1);

		datenew2 = request.getParameter("to_date1");
		System.out.println("IN datenew12"+datenew2);
		
		 UserID=request.getParameter("userId");
		 fromdate=request.getParameter("fromdate");
		 todate=request.getParameter("todate");
		 HOD=request.getParameter("HOD");
		 Dept=request.getParameter("Dept");
		 User=request.getParameter("User");
		 Status=request.getParameter("status");
		 Role=request.getParameter("role");
			
			if(Status.equals("Submited"))
			{
				System.out.println("IN SUBMITED");
				Status="Submitted";
			}
				
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
	}
	 %>

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
         <form name="form1" id="newModalForm" method="post" action="TaskNext.jsp" enctype="multipart/form-data">
         <%int counter=0;%>
    	<input type="hidden"  name="counter" id="counter" value="<%=counter%>"></input>
   		<input type="hidden"  name="DeptHidden" id="DeptHidden" ></input>
   		<input type="hidden"  name="UsernHidden" id="UsernHidden" ></input>
		<input type="hidden"  name="HODHidden" id="HODHidden" ></input>
		<input type="hidden"  name="datenew1Hidden" id="datenew1Hidden" ></input>
		<input type="hidden"  name="datenew2Hidden" id="datenew2Hidden" ></input>
		<input type="hidden"  name="StatusHidden" id="StatusHidden" ></input>
		<input type="hidden"  name="RoleHidden" id="RoleHidden" ></input>
		<input type="hidden"  name="usrid1hidden" id="usrid1hidden" ></input>
		<input type="hidden"  name="tsk1hidden" id="tsk1hidden" ></input>
		<input type="hidden"  name="tskidhidden" id="tskidhidden" ></input>
		<input type="hidden"  name="satathidden" id="satathidden" ></input>
		<input type="hidden"  name="other12hidden" id="other12hidden" ></input>
		<input type="hidden"  name="comments31hidden" id="comments31hidden" ></input>	
		<input type="hidden"  name="flagvalue" id="flagvalue" value="<%=counter%>"></input>
		
      <div class="row">
      <div class="col-md-3">				  
      <label for="dropdown"><b>Project ID: </b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="pid" name="pid">
					       <option value="Select">Select</option>
                            <%
                            String project ="";
							 project ="select project_id,project_name FROM dotproject.projects";	
							ResultSet rs11 = stmain2.executeQuery(project);
					
							while (rs11.next()) {
							    String project_name = rs11.getString("project_name");
							      project_id = rs11.getString("project_id");
							%>
							    <option value="<%=project_id%>"><%=project_name%> - <%=project_id%></option>
							<%
							}
		%>  
                              
                              	
                           </select>
                            <script>
                            const mySel1 = document.getElementById("pid");

                            // Check if btn (bt) is null
                             const isBtNull = <%= Bt1 == null %>;

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel1.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel1.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel1.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
                             
                             
		                </div>
		                
			</div>		
			<div class="col-md-3"></div>		
      </div>
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
        <!-- First input with Remove button -->
        <div class="mb-2 d-flex align-items-center">
            <input type="file" name="files" class="form-control" required>
            <button type="button" class="btn btn-danger btn-sm ms-2" onclick="clearFileInput(this)">Remove</button>
            
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


 <!-- Assigned Modal -->
<div class="modal fade" id="addMyModall" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Task Assigned</b></h4>
        <div class="row">
             <div class="col-md-5">
             <div class="row">
           <div class="col-md-3">
            <label for="uid" class="control-label"><b>UserID: </b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="usrid11" name="usrid11" readonly="readonly" class="form-control">
        </div>
        </div>
        </div>
          <div class="col-md-7">
         <div class="row">
           <div class="col-md-3">
            <label for="tid" class="control-label"><b>TaskID:</b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="tskid1" name="tskid1" readonly="readonly" class="form-control">
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
      <input type="text" id="tsk11" name="tsk11" readonly="readonly" class="form-control">
    </div>

  </div>
</div>

         <hr>
         <form name="form11" id="newModalFormm" method="post">
						    <input type="hidden"  name="datefrom" id="datefrom" ></input>
                			<input type="hidden"  name="dateto" id="dateto" ></input>
                        	<input type="hidden"  name="hod" id="hod" ></input>
                        	<input type="hidden"  name="dep" id="dep" ></input>
                        	<input type="hidden"  name="usr" id="usr" ></input>
                        	<input type="hidden"  name="stst" id=""></input>
                        	<input type="hidden"  name="rol" id="rol" ></input>
		

      <div class="row mt-3">
 <div class="col-md-3">				  
   <label for="dropdown"><b>Comments:</b></label>
      </div>
   <div class="col-md-6">  
   <textarea class="form-control" id="comments311" name="comments311"  placeholder="Comments" style="font-size: 0.8rem;"></textarea>
</div>
      			<div class="col-md-3"></div>		
      </div>
      
      						<div class="row mt-3" id="per"></div>  
						
						
      </form>
       </div>
      
      <div class="modal-footer">
	      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="btnCloseIt1">Close</button>
	      	<button type="button" id="submit" class="btn btn-primary btn-sm" id="btnSaveIt1" onclick="return approve11()">Save</button>
      </div>
    </div>
  </div>
</div>





<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Status Report</h5>
    </div>
</div>

  <form name="custreport" id="custreport" method="post">
  <input type="hidden" name="datenew1" id="datenew1" value=""></input>
<input type="hidden" name="datenew2" id="datenew2" value=""></input>       
<input type="hidden" name="HOD" id="HOD" value=""></input>   
<input type="hidden" name="Dept" id="Dept" value=""></input>       
<input type="hidden" name="Usern" id="Usern" value=""></input>  
<input type="hidden" name="Status" id="Status" value=""></input>       
<input type="hidden" name="Role" id="Role" value=""></input>       
<input type="hidden" name="datenew11" id="datenew11" value=""></input>
<input type="hidden" name="datenew21" id="datenew21" value=""></input>       
<input type="hidden" name="HOD1" id="HOD1" value=""></input>   
<input type="hidden" name="Dept1" id="Dept1" value=""></input>       
<input type="hidden" name="Usern1" id="Usern1" value=""></input>  
<input type="hidden" name="Status1" id="Status1" value=""></input>       
<input type="hidden" name="Role1" id="Role1" value=""></input> 
<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
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
<option value="<%=Status %>"><%=Status %></option>
  <%
    //Status = request.getParameter("Status");
    String sql2 = "select distinct(TaskStatus) as status from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskStatus!='Duplicate'";
    ResultSet rsregno123 = st.executeQuery(sql2);
    while(rsregno123.next()) {			 
      stat = rsregno123.getString("status");
  %>
    <option value="<%=stat%>" <% if(Status.equalsIgnoreCase(stat)){ %> Selected <%}%> ><%=stat%></option>
  <%
    }
  %>
</select>
   <script>
                            const mySel = document.getElementById("status");
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                            // mySel.value = "Select"; 
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
<table id="example" class="display" style="width:100%">        
<thead>
       <%
       if(Status.equals("Assigned")||Status.equals("Missed"))
       {
       %>
            <tr>
	            <th  width="4%">SrNo.</th>
	            <th>User</th>
				<th>UserID</th>
				<th>TaskID</th>
				<th>TaskName</th>
				<th>Description</th>
				<th>Duration</th>
				<th>StartDate</th>
	         	<th>EndDate</th>
		        <th>Status</th>
	        </tr>
           <% }else if(Status.equals("Rejected")) {  %> 
            <tr>
	            <th  width="4%">SrNo.</th>
	            <th>User</th>
				<th>UserID</th>
				<th>TaskID</th>
				<th>TaskName</th>
				<th>Description</th>
				<th>Duration</th>
				<th>StartDate</th>
	         	<th>EndDate</th>
	         	<th>Percentage</th>
	         	<th>Comment</th>
	         	<th>Attachment</th>
		        <th>Status</th>
		        <th>Rejection Reason</th>
	        </tr>
            <% }else{ %>
            <tr>
	            <th width="4%">SrNo.</th>
	            <th>User</th>
				<th>UserID</th>
				<th>TaskID</th>
				<th>TaskName</th>
				<th>Description</th>
				<th>Duration</th>
				<th>StartDate</th>
	         	<th>EndDate</th>
	         	<th>Percentage</th>
	         	<th>Comment</th>
	         	<th>Attachment</th>
		        <th>Status</th>
	        </tr>
            <% } %>
        
       <tbody>
       <%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String CustomerCode="";
	String dotprojectid="";
	String stp="Pending";

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
		System.out.println("Data 1-->"+data1);	
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
	<%
	Date d=new Date();
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

		%>
<%
String name13="";
String Bt=request.getParameter("button");
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
	
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			 name13=session.getAttribute("EmpName").toString();
			String Sesrole2=session.getAttribute("role").toString();
			System.out.println("Role :- "+Sesrole2);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);        	
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
 		query12="select distinct(a.task_id) as TaskId,c.EmpName as User ,c.dotprojectid as UserID,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";		
			System.out.println("query12---"+query12);
			rs=stmt.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",task_description="",Duration="",StartDate="",EndDate="";
				
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");				
				TaskName=rs.getString("TaskName");				
				Duration=rs.getString("Duration");				
				StartDate=rs.getString("StartDate");				
				EndDate=rs.getString("EndDate");				
				task_description=rs.getString("task_description");				
				String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
				ResultSet rs21 = stmain1.executeQuery(project1);

		if (rs21.next()) {
		      task_project = rs21.getString("task_project");	    
		}
			
			%>               
         <tr> 
					
									<td class="text-center"><%=i%></td>
						<td class="text-left"><%=rs.getString("User")%></td>
						<td class="text-right"><%=rs.getString("UserID")%></td>
						
						<%     
							if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
						{%>
						<td class="text-right"> <a data-bs-toggle="modal" style="color: #0d6efd;cursor:pointer;" data-bs-target="#addMyModall" onclick="return demoo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>','<%=task_project%>')"><%=rs.getString("TaskId")%></a></td>
							
				<%	}else
				{%>
						<td class="text-right"><%=TaskId%></td>
					
				<%}
 %>
						<td class="text-left"><%=TaskName%></td>
						<td class="text-left"><%=task_description%></td>
						<td class="text-right"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-left"><%=Status%></td>
						
					 </tr>
			<%
			i++;
			}
        
        }
        else if(Status.equals("Missed"))
        {
 			query12="select distinct(a.task_id) as TaskId,c.EmpName as User ,c.dotprojectid as UserID,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid)  and c.dept like '%"+department+"%'";
        	System.out.println("query12---"+query12);
			rs=stmt.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",task_description="",EndDate="";
				
				User=rs.getString("User");				
				UserID=rs.getString("UserID");				
				TaskId=rs.getString("TaskId");				
				TaskName=rs.getString("TaskName");		
				task_description=rs.getString("task_description");
				Duration=rs.getString("Duration");				
				StartDate=rs.getString("StartDate");				
				EndDate=rs.getString("EndDate");				
				String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
				ResultSet rs21 = stmain1.executeQuery(project1);

		if(rs21.next()) {
		      task_project = rs21.getString("task_project");
		    
		    System.out.println("Project Id query "+task_project);
		}
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>
						<td class="text-right"><%=UserID%></td>
						<td style="font-size: 11px;" class="text-center">
 							<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>','<%=task_project%>')"><%=rs.getString("TaskId")%></a></td> 					
						<td class="text-left"><%=TaskName%></td>
						<td class="text-left"><%=task_description%></td>					
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
		 	query12="select distinct(a.task_id) as TaskId,b.UserID as UserId,c.EmpName as User,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,b.TaskAttachment as TaskAttachment,b.TaskPercent as TaskPercent,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+name13+"%' and companymasterid='"+comid+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+comid+"' and c.activestatus='Yes' and b.TaskStatus!='Duplicate'  and dept like '%"+department+"%' order by b.taskid";
        	System.out.println("query12---"+query12);
			rs=stmt.executeQuery(query12);
			
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="", task_description=null;
				User=rs.getString("User");
				UserID=rs.getString("UserID");				
				TaskAttachment=rs.getString("TaskAttachment");			
				String[] TA=TaskAttachment.split(",");							
				TaskId=rs.getString("TaskId");				
				TaskName=rs.getString("TaskName");				
				Duration=rs.getString("Duration");				
				StartDate=rs.getString("StartDate");				
				EndDate=rs.getString("EndDate");				
				Stat=rs.getString("Status");				
				TaskPercent=rs.getString("TaskPercent");				
				TaskComment=rs.getString("TaskComment");
				task_description=rs.getString("task_description");
				
				String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
				ResultSet rs21 = stmain1.executeQuery(project1);

		if(rs21.next()) {
		      task_project = rs21.getString("task_project");		    
		}
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>
						<td class="text-right"><%=UserID%></td>
 						<td style="font-size: 11px;" class="text-center">
 							<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>','<%=task_project%>')"><%=rs.getString("TaskId")%></a></td>
 						<td class="text-left"><%=TaskName%></td>
 						<td class="text-left"><%=task_description%></td>
						<td class="text-right"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-right"><%=TaskPercent%></td>
						<td class="text-left"><%=TaskComment%></td>
						<td class="text-left">
							 <%for (int k=0;k<TA.length;k++){%>
							 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
										<%} %></td> 
						<td class="text-left"><%=Stat%></td>
					 </tr>
			<%
			i++;
			}
        
        
        }
        else if(Status.equals("Rejected"))
        {
		 	query12="SELECT distinct(a.task_id) as TaskId,b.UserID AS UserId,c.EmpName AS USER,a.task_name AS TaskName,a.task_description AS task_description,a.task_duration AS Duration,b.TaskPercent AS TaskPercent,b.TaskComment AS TaskComment,b.TaskAttachment AS TaskAttachment,DATE_FORMAT(a.task_start_date,'%d-%b-%Y %T' ) AS StartDate,DATE_FORMAT(a.task_end_date,'%d-%b-%Y %T') AS EndDate,b.TaskRejectionComment AS RejectionReason ,b.TaskStatus AS STATUS  FROM dotproject.tasks a JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  ON a.task_id=b.TaskID LEFT JOIN db_GlobalERP.UserMaster c ON b.UserId=c.dotprojectid WHERE  b.userid IN (SELECT dotprojectid FROM db_GlobalERP.UserMaster WHERE empname LIKE '%"+name13+"%' AND companymasterid='"+comid+"' AND activestatus='Yes'  AND dept LIKE '%"+department+"%')  AND  a.task_start_date >='"+dt+"' AND a.task_end_date <='"+dt1+"' AND c.companymasterid='"+comid+"' AND c.activestatus='Yes' AND b.TaskStatus LIKE '%Rejected%'  AND dept LIKE '%"+department+"%' ORDER BY b.taskid ";
			rs=stmt.executeQuery(query12);
			int i=1;
			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="",RejectionReason="",task_description =null;
				User=rs.getString("User");				
				UserID=rs.getString("UserID");
				TaskAttachment=rs.getString("TaskAttachment");			
				String[] TA=TaskAttachment.split(",");
				TaskId=rs.getString("TaskId");				
				TaskName=rs.getString("TaskName");				
				Duration=rs.getString("Duration");				
				StartDate=rs.getString("StartDate");				
				EndDate=rs.getString("EndDate");				
				Stat=rs.getString("Status");				
				TaskPercent=rs.getString("TaskPercent");				
				TaskComment=rs.getString("TaskComment");				
				RejectionReason=rs.getString("RejectionReason");			
				task_description = rs.getString("task_description");
				String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
				ResultSet rs21 = stmain1.executeQuery(project1);

		if(rs21.next()) {
		      task_project = rs21.getString("task_project");
		}
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>	
						<td class="text-right"><%=UserID%></td>
 						<td style="font-size: 11px;" class="text-center">
 							<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>','<%=task_project%>')"><%=rs.getString("TaskId")%></a></td>
						<td class="text-left"><%=TaskName%></td>
 						<td class="text-left"><%=task_description%></td>	
						<td class="text-right"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-right"><%=TaskPercent%></td>
						<td class="text-left"><%=TaskComment%></td>
						<td class="text-left">
	 
	 <%for (int k=0;k<TA.length;k++) {%>
	 					<a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
				<%} %></td> 
				
						<td class="text-left"><%=Stat%></td>
						<td class="text-left"><%=RejectionReason%></td>
						
					 </tr>
			<%
			i++;
			}
        
        
        }
        else
        {
 		query12="select distinct(a.task_id) as TaskId,b.UserID as UserId,c.EmpName as User,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskComment as TaskComment,b.TaskAttachment as TaskAttachment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+name13+"%' and companymasterid='"+comid+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+comid+"' and c.activestatus='Yes' and b.TaskStatus like '%"+Status+"%'  and dept like '%"+department+"%' order by b.taskid";  	      	
			rs=stmt.executeQuery(query12);			
			int i=1;			
			while(rs.next())
			{
			
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="", task_description=null;
				User=rs.getString("User");				
				UserID=rs.getString("UserID");								
				TaskId=rs.getString("TaskId");				
				TaskName=rs.getString("TaskName");				
				Duration=rs.getString("Duration");				
				StartDate=rs.getString("StartDate");				
				EndDate=rs.getString("EndDate");				
				Stat=rs.getString("Status");				
				TaskAttachment=rs.getString("TaskAttachment");				
				String[] TA=TaskAttachment.split(",");				
				Arrays.toString(TA);			
				TaskPercent=rs.getString("TaskPercent");				
				TaskComment=rs.getString("TaskComment");								
				String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
				System.out.println("Project Id query "+project1);
				ResultSet rs21 = stmain1.executeQuery(project1);

		if(rs21.next()) {
		      task_project = rs21.getString("task_project");    
		}
			
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-left"><%=User%></td>
						<td class="text-right"><%=UserID%></td>
 						<td style="font-size: 11px;" class="text-center">
							 <a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=rs.getString("User")%>','<%=Status%>','<%=Role%>','<%=rs.getString("TaskName")%>','<%=rs.getString("UserID")%>','<%=rs.getString("TaskId")%>','<%=task_project%>')"><%=rs.getString("TaskId")%></a></td>
						<td class="text-left"><%=TaskName%></td>
 						<td class="text-left"><%=task_description%></td>
						<td class="text-right"><%=Duration%></td>
						<td class="text-right"><%=StartDate%></td>
						<td class="text-right"><%=EndDate%></td>
						<td class="text-right"><%=TaskPercent%></td>
						<td class="text-left"><%=TaskComment%></td>					
						<td class="text-left">
							 <%for (int k=0;k<TA.length;k++) {%>
							 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
										<%} %>	</td> 
						<td class="text-left"><%=Stat%></td>
						
					 </tr>
			<%
			i++;
			}     
        }
%>			
		<% 
		}		else
		{
		System.out.println("----------In Button-------------");

		String POStatus="Pending";
		String comid2=session.getAttribute("CompanyMasterID").toString();
		
		 name13=session.getAttribute("EmpName").toString();
		String Sesrole2=session.getAttribute("role").toString();			
		String seldept=request.getParameter("companyName1");     	
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
 		query12="select distinct(a.task_id) as TaskId, c.EmpName as User ,c.dotprojectid as UserID,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";  
		
		rs=stmt.executeQuery(query12);	
		int i=1;		
		while(rs.next())
		{					
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",task_description=null;
			User=rs.getString("User");			
			UserID=rs.getString("UserID");			
			TaskId=rs.getString("TaskId");			
			TaskName=rs.getString("TaskName");
			Duration=rs.getString("Duration");			
			StartDate=rs.getString("StartDate");			
			EndDate=rs.getString("EndDate");			
			task_description = rs.getString("task_description");
			String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
			ResultSet rs21 = stmain1.executeQuery(project1);

	if(rs21.next()) {
	      task_project = rs21.getString("task_project");    
	}
		%>
		
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					<td class="text-right"><%=UserID%></td>
<%        				if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
							{%>
					<td class="text-right"> <a data-bs-toggle="modal" data-bs-target="#addMyModall" style="color: #0d6efd;cursor:pointer;" onclick="return demoo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>','<%=task_project%>')"><%=TaskId%></a></td>
							
					<%	}else
					{%>
					<td class="text-right"><%=TaskId%></td>
				<%}
 %>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=task_description%></td>				
					<td class="text-right"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-left"><%=Status%></td>					
				 </tr>
		<%
		i++;
		}
    
    }
    else if(Status.equals("Missed"))
    {
   
 		query12="select distinct(a.task_id) as TaskId, c.EmpName as User ,c.dotprojectid as UserID,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid)  and c.dept like '%"+department+"%'";
    	System.out.println("Missed---"+query12);
		rs=stmt.executeQuery(query12);	
		int i=1;		
		while(rs.next())
		{
	
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",task_description =null;
			User=rs.getString("User");			
			UserID=rs.getString("UserID");					
			TaskId=rs.getString("TaskId");			
			TaskName=rs.getString("TaskName");			
			Duration=rs.getString("Duration");			
			StartDate=rs.getString("StartDate");			
			EndDate=rs.getString("EndDate");			
			task_description = rs.getString("task_description");
			String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
			ResultSet rs21 = stmain1.executeQuery(project1);

	if(rs21.next()) {
	      task_project = rs21.getString("task_project");	    
	}
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					<td class="text-right"><%=UserID%></td>
					<td style="font-size: 11px;" class="text-center">										
						<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>		
					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=task_description%></td>
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
 		query12="select distinct(a.task_id) as TaskId,b.UserID as UserId,c.EmpName as User,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskAttachment as TaskAttachment,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+name13+"%' and companymasterid='"+comid+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+comid+"' and c.activestatus='Yes' and (b.TaskStatus LIKE '%Submitted%' or b.TaskStatus LIKE '%Pending%'  or b.TaskStatus LIKE '%Rejected%' ) and dept like '%"+department+"%' order by b.taskid";        
    	System.out.println("Submitted---"+query12);
		rs=stmt.executeQuery(query12);
		
		int i=1;	
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="",task_description=null;
			User=rs.getString("User");			
			UserID=rs.getString("UserID");			
			TaskAttachment=rs.getString("TaskAttachment");			
			String[] TA=TaskAttachment.split(",");					
			TaskId=rs.getString("TaskId");			
			TaskName=rs.getString("TaskName");			
			Duration=rs.getString("Duration");			
			StartDate=rs.getString("StartDate");			
			EndDate=rs.getString("EndDate");			
			Stat=rs.getString("Status");			
			TaskPercent=rs.getString("TaskPercent");			
			TaskComment=rs.getString("TaskComment");			
			String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
			System.out.println("Project Id query "+project1);
			ResultSet rs21 = stmain1.executeQuery(project1);

	if(rs21.next()) {
	      task_project = rs21.getString("task_project");
	}
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					<td class="text-right"><%=UserID%></td>
					<td style="font-size: 11px;" class="text-center">
	 					<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>','<%=task_project%>')"><%=TaskId%></a></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=task_description%></td>					
					<td class="text-right"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-right"><%=TaskPercent%></td>
					<td class="text-left"><%=TaskComment%></td>
 					<td class="text-left">
						 <%for (int k=0;k<TA.length;k++) {%>
						 	<a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
						<%} %>	</td> 
					
					<td class="text-left"><%=Status%></td>
					
				 </tr>
		<%
		i++;
		}
    
    
    }else if(Status.equals("Rejected"))
    {  	
 		query12="SELECT distinct(a.task_id) as TaskId,b.UserID AS UserId,c.EmpName AS USER,a.task_name AS TaskName,a.task_description AS task_description,a.task_duration AS Duration,b.TaskPercent AS TaskPercent,b.TaskComment AS TaskComment,b.TaskAttachment AS TaskAttachment,DATE_FORMAT(a.task_start_date,'%d-%b-%Y %T' ) AS StartDate,DATE_FORMAT(a.task_end_date,'%d-%b-%Y %T') AS EndDate,b.TaskRejectionComment AS RejectionReason ,b.TaskStatus AS STATUS  FROM dotproject.tasks a JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  ON a.task_id=b.TaskID LEFT JOIN db_GlobalERP.UserMaster c ON b.UserId=c.dotprojectid WHERE  b.userid IN (SELECT dotprojectid FROM db_GlobalERP.UserMaster WHERE empname LIKE '%"+name13+"%' AND companymasterid='"+comid+"' AND activestatus='Yes'  AND dept LIKE '%"+department+"%')  AND  a.task_start_date >='"+dt+"' AND a.task_end_date <='"+dt1+"' AND c.companymasterid='"+comid+"' AND c.activestatus='Yes' AND b.TaskStatus LIKE '%Rejected%'  AND dept LIKE '%"+department+"%' ORDER BY b.taskid ";
    	System.out.println("Rejected---"+query12);
		rs=stmt.executeQuery(query12);
		
		int i=1;
		
		while(rs.next())
		{	
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="",RejectionReason="",task_description=null;
			User=rs.getString("User");			
			UserID=rs.getString("UserID");			
			TaskAttachment=rs.getString("TaskAttachment");			
			String[] TA=TaskAttachment.split(",");		
			TaskId=rs.getString("TaskId");			
			TaskName=rs.getString("TaskName");			
			Duration=rs.getString("Duration");			
			StartDate=rs.getString("StartDate");			
			EndDate=rs.getString("EndDate");			
			Stat=rs.getString("Status");			
			TaskPercent=rs.getString("TaskPercent");			
			TaskComment=rs.getString("TaskComment");			
			RejectionReason=rs.getString("RejectionReason");		
			task_description = rs.getString("task_description");
			String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
			System.out.println("Project Id query "+project1);
			ResultSet rs21 = stmain1.executeQuery(project1);

	if(rs21.next()) {
	      task_project = rs21.getString("task_project");
	}
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>
					<td class="text-right"><%=UserID%></td>					
					<td style="font-size: 11px;" class="text-center">
   						<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>','<%=task_project%>')"><%=TaskId%></a></td>
 					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=task_description%></td>
					<td class="text-right"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-right"><%=TaskPercent%></td>
					<td class="text-left"><%=TaskComment%></td>
 					<td class="text-left">
					 <%for (int k=0;k<TA.length;k++) {%>
					 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
								<%} %>	</td> 					
					<td class="text-left"><%=Status%></td>
					<td class="text-left"><%=RejectionReason %></td>					
				 </tr>
		<%
		i++;
		}
    }
    else
    {	
 		query12="select distinct(a.task_id) as TaskId,b.UserID as UserId,c.EmpName as User,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,b.TaskPercent as TaskPercent,b.TaskAttachment as TaskAttachment,b.TaskComment as TaskComment,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate,b.TaskStatus as Status  from dotproject.tasks a join db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata  b  on a.task_id=b.TaskID left join db_GlobalERP.UserMaster c on b.UserId=c.dotprojectid where  b.userid in (select dotprojectid from db_GlobalERP.UserMaster where empname like '%"+name13+"%' and companymasterid='"+comid+"' and activestatus='Yes'  and dept like '%"+department+"%')  and  a.task_start_date >='"+dt+"' and a.task_end_date <='"+dt1+"' and c.companymasterid='"+comid+"' and c.activestatus='Yes' and b.TaskStatus like '%"+Status+"%'  and dept like '%"+department+"%' order by b.taskid";
    	System.out.println("query12---"+query12);
		rs=stmt.executeQuery(query12);
		
		int i=1;	
		while(rs.next())
		{	
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="",task_description="";
			User=rs.getString("User");			
			UserID=rs.getString("UserID");			
			TaskAttachment=rs.getString("TaskAttachment");			
			String[] TA=TaskAttachment.split(",");		
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");			
			Duration=rs.getString("Duration");		
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");			
			Stat=rs.getString("Status");			
			TaskPercent=rs.getString("TaskPercent");			
			TaskComment=rs.getString("TaskComment");	
			task_description= rs.getString("task_description");
			String project1 ="select task_project FROM dotproject.tasks where task_id ='"+TaskId+"' ";	
			System.out.println("Project Id query "+project1);
			ResultSet rs21 = stmain1.executeQuery(project1);

	if(rs21.next()) {
	      task_project = rs21.getString("task_project");	    
	}
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-left"><%=User%></td>		
					<td class="text-right"><%=UserID%></td> 
 					<td style="font-size: 11px;" class="text-center">
						<a data-bs-toggle="modal" data-bs-target="#addMyModal" style="color: #0d6efd;cursor:pointer;" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>','<%=task_project%>')"><%=TaskId%></a></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=task_description%></td>					
					<td class="text-right"><%=Duration%></td>
					<td class="text-right"><%=StartDate%></td>
					<td class="text-right"><%=EndDate%></td>
					<td class="text-right"><%=TaskPercent%></td>
					<td class="text-left"><%=TaskComment%></td>
 					<td class="text-left">
						 <%for (int k=0;k<TA.length;k++) {%>
						 <a href=Downloadtaskattachment.jsp?filename=<%=TA[k]%> target="_blank"><%=TA[k]%><% if(k<(TA.length-1)){%><%=","%><%} %></a>
									<%} %>	</td> 
					<td class="text-left"><%=Status%></td>
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
 <input type="hidden" id="comid" name="comid" value="<%=comid%>" />
 </div>
 
<!-- Modal -->
<div class="modal fade" id="SampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Approve Action</b></h4>
        <div class="row">
             <div class="col-md-5">
                <div class="row">
                   <div class="col-md-5">
                      <label for="eid" class="control-label"><b>Id : </b></label>
                   </div>
                   <div class="col-md-7">
                      <input type="text" id="eid" name="eid" readonly="readonly" class="form-control">
                  </div>
               </div>
           </div>
            <div class="col-md-7">
               <div class="row">
                  <div class="col-md-6">
                      <label for="name" class="control-label"><b>Name : </b></label>
                  </div>
                  <div class="col-md-6">
                      <input type="text" id="ename" name="ename" readonly="readonly" class="form-control">
                  </div>
              </div>
            </div> 
       </div>
       <div class="row mt-1">
             <div class="col-md-5">
                 <div class="row">
                     <div class="col-md-5">
                         <label for="date" class="control-label"><b>Date :</b></label>
                     </div>
                     <div class="col-md-7">
                         <input type="text" id="date" name="date" readonly="readonly" class="form-control">
                     </div>
                 </div>
             </div>
             <div class="col-md-7">
                 <div class="row">
                     <div class="col-md-6">
                          <label for="status" class="control-label"><b>ActualStatus :</b></label>
                    </div>
                    <div class="col-md-6">
                          <input type="text" id="status" name="status" readonly="readonly" class="form-control">
                    </div>
                </div>
             </div>
         </div>
         <hr>
         <div class="row mt-3">
             <div class="col-md-3">				  
                  <label for="dropdown"><b>Comments : </b></label>
             </div>
             <div class="col-md-6">  
                  <textarea class="form-control" id="mycomments" name="mycomments"></textarea>
             </div>
      	   	<div class="col-md-3"></div>		
        </div>
     </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm">Submit</button>
      </div>
    </div>
  </div>
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
	         //fixedColumns: { 
	        //    left: 3      //To freeze two columns
	      //  }, 
	      //  keys: true,  //Keytable
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
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{	
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
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
	var ajaxRequest;
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
		{
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
	document.getElementById('DeptHidden').value=Dept;
	
	var Usern=document.getElementById('Usern').value;
	document.getElementById('UsernHidden').value=Usern;
	
	var HOD=document.getElementById('HOD').value;
	document.getElementById('HODHidden').value=HOD;

	var dd=document.getElementById('datenew1').value;
	document.getElementById('datenew1Hidden').value=dd;
	
	var dd1=document.getElementById('datenew2').value;
	document.getElementById('datenew2Hidden').value=dd1;
	
 	var Status=document.getElementById("Status").value;
 	document.getElementById('StatusHidden').value=Status;
	
	var Role=document.getElementById('Role').value;
	document.getElementById('RoleHidden').value=Role;

 	var userId=document.getElementById("usrid1").value;
 	document.getElementById('usrid1hidden').value=userId;

	var User=document.getElementById("tsk1").value;
	document.getElementById('tsk1hidden').value=User;

	var TaskID=document.getElementById("tskid").value;
	document.getElementById('tskidhidden').value=TaskID;
	
	var satat=document.getElementById('status').value;
	document.getElementById('satathidden').value=satat;
	
	var other=document.getElementById('other12').value;
	other = other.replace("%", "");
	document.getElementById('other12hidden').value=other;
	console.log("other12hidden : "+other);	
	
	var comment=document.getElementById('comments31').value;
	document.getElementById('comments31hidden').value=comment;
	
	if(comment=="")
		{
		vali();
		}
								 
	document.getElementById("newModalForm").submit(); 
		alert("Loading...Please click OK");
	}

function approve11()
{
 	var userId=document.getElementById("usrid11").value;
 	var tskid1=document.getElementById("tskid1").value;
 	var comments311=document.getElementById("comments311").value;
 	var datefrom=document.getElementById("datenew11").value;	
	var dateto=document.getElementById("datenew21").value;
	var hod=document.getElementById("HOD1").value;	
	var dep=document.getElementById("Dept1").value;
	var stst=document.getElementById("Status1").value;
	var usr=document.getElementById("Usern1").value;
	var rol=document.getElementById("Role1").value;

	var li=location.assign("TaskNextAdd.jsp?userId1="+userId+"&tskid1="+tskid1+"&comments311="+comments311+"&datefrom="+datefrom+"&dateto="+dateto+"&hod="+hod+"&dep="+dep+"&stst="+stst+"&usr="+usr+"&rol="+rol);
	alert("Loading...Please click OK");
	}
</script>
<script>

function demo(datenew1,datenew2,HOD,Dept,User,Status,Role,TaskName,UserID,TaskId,pid)
{
	var a="",b="",c="",d="",e="",f="",g="",h="",i="",j="",k="";	
	document.getElementById('tsk1').value = a;
   	document.getElementById('usrid1').value = b;
	document.getElementById('tskid').value = c;	
	document.getElementById('datenew1').value = d;	
    document.getElementById('datenew2').value = e;
	document.getElementById('HOD').value = f;	
	document.getElementById('Dept').value = g;	
	document.getElementById('Usern').value = h;	
	document.getElementById('Status').value = i;	
	document.getElementById('Role').value = j;
	document.getElementById('pid').value = k; 	
	
	a= TaskName;
   	b = UserID;
	c = TaskId;	
	d = datenew1;	
    e = datenew2;
	f = HOD;	
	g = Dept;	
	h = User;	
	i = Status;	
	j = Role;
	k = pid;
	
	document.getElementById('tsk1').value = a;
   	document.getElementById('usrid1').value = b;
	document.getElementById('tskid').value = c;	
	document.getElementById('datenew1').value = d;	
    document.getElementById('datenew2').value = e;
	document.getElementById('HOD').value = f;	
	document.getElementById('Dept').value = g;	
	document.getElementById('Usern').value = h;	
	document.getElementById('Status').value = i;	
	document.getElementById('Role').value = j;
	document.getElementById('pid').value = k; 
}


</script>


<script>
function demoo(datenew1,datenew2,HOD,Dept,User,Status,Role,TaskName,UserID,TaskId,pid)
{
	var a="",b="",c="",d="",e="",f="",g="",h="",i="",j="",k="";	
	document.getElementById('tsk11').value = a;
   	document.getElementById('usrid11').value = b;
	document.getElementById('tskid1').value = c;	
	document.getElementById('datenew11').value = d;	
    document.getElementById('datenew21').value = e;
	document.getElementById('HOD1').value = f;	
	document.getElementById('Dept1').value = g;	
	document.getElementById('Usern1').value = h;	
	document.getElementById('Status1').value = i;	
	document.getElementById('Role1').value = j; 
	document.getElementById('pid').value = k; 
	
	a = TaskName;
   	b = UserID;
	c = TaskId;	
	d = datenew1;	
    e = datenew2;
	f = HOD;	
	g = Dept;	
	h = User;	
	i = Status;	
	j = Role; 
	k = pid;
	document.getElementById('tsk11').value = a;
   	document.getElementById('usrid11').value = b;
	document.getElementById('tskid1').value = c;	
	document.getElementById('datenew11').value = d;	
    document.getElementById('datenew21').value = e;
	document.getElementById('HOD1').value = f;	
	document.getElementById('Dept1').value = g;	
	document.getElementById('Usern1').value = h;	
	document.getElementById('Status1').value = i;	
	document.getElementById('Role1').value = j; 
	document.getElementById('pid').value = k; 
}
</script>

<script>
function fun() {
    var a = document.getElementById('status').value;

    if (a === 'Completed') {
        var aa = `
        <div class="row">
            <div class="col-md-3">
                <label for="other12" class="control-label"><b>Percentage:</b></label>
            </div>            
            
            <div class="col-md-6">
                <input type="text" id="other12" name="other12" value="100%" class="form-control" style="font-size: 0.8rem;width: 107%;margin-left: 5px;" readonly>
                
            </div>
        </div>`;
        document.getElementById('per').innerHTML = aa;

    } else if (a === 'In Progress') {
        var bb = `
        <div class="row">
            <div class="col-md-3">
                <label for="other12" class="control-label"><b>Percentage:</b></label>
            </div>
            <div class="col-md-6">
            
                <select name="other12" id="other12" class="form-select" style="font-size: 0.8rem;width: 107%;margin-left: 5px;">
                    <option>25%</option>
                    <option>50%</option>
                    <option>75%</option>
                </select>
            </div>
        </div>`;
        document.getElementById('per').innerHTML = bb;
    } else {
        document.getElementById('per').innerHTML = ""; // clear if nothing selected
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
<script>
$(function() {
	var vale=$("#status").val();
	  if(vale=="Select")
		  {
		  }
	  vale="";	  
		document.getElementById('status').value = vale;			
		var vale2=$("#status").val();

	  $("#newModalForm").validate({
		  
	    rules: {
	    	comments31: {
	        required: true,
	      },
	      status: "required"
	    },
	    messages: {
	    	comments31: {
	        required: "Please Enter Comments",
	      },
	      status: "Select Status"
	      }    	 
	  });	  
	});
</script> 
  <script>
  	document.getElementById('pid').addEventListener('change', function () {
    var selectedText = this.options[this.selectedIndex].text;
    
    if (this.value !== "Select") {
      var projectName = selectedText.split('-')[0].trim();
      document.getElementById('selectedProjectName').innerText = "Selected Project: " + projectName;
    } else {
      document.getElementById('selectedProjectName').innerText = "";
    }
  });
</script>
<script>
    function addFileInput() {
        let fileInputs = document.querySelectorAll('#fileInputs .mb-2');
        if (fileInputs.length < 4) {
            let div = document.createElement('div');
            div.className = "mb-2 d-flex align-items-center";
            div.innerHTML = '<input type="file" name="files" class="form-control" required>' +
                            '<button type="button" class="btn btn-danger btn-sm ms-2" onclick="clearFileInput(this)">Remove</button>';
            document.getElementById('fileInputs').appendChild(div);
        } else {
            alert('You can upload a maximum of 4 files.');
        }
    }

    function clearFileInput(button) {

        let input = button.parentElement.querySelector('input[type="file"]');
        input.value = ""; // clear selected file
        button.parentElement.remove();
    }
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>