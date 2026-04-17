 <%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<%@include file="PostgressConn.jsp" %>
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
Connection con1=null, conn1=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt2=null, stmt3=null, stmt1 = null,st1=null,st2=null;

String datenew1="", datenew2="", date1 = "", date2 = "", dept = "", user_id1 = "", tDate1 = "", tDate2 = "";
String UserID="", fromdate="", todate="", HOD="", Dept="", User="", Status="",s="", Role="", EmpName1="";
String openprojectid = "", department="";

%>
<%
try {
	con1 = connection.getConnect("db_GlobalERP");    
    st = con1.createStatement();
    st1=con1.createStatement();
    st2=con1.createStatement();
    
    conn1=DriverManager.getConnection(postgresString,postgresUser,postgresPass); //postgresql
    
    stmt1 = conn1.createStatement(); //all postgres queries
    stmt2 = conn1.createStatement(); //all postgres queries
    stmt3 = conn1.createStatement(); //all postgres queries
    
} catch (Exception e) {
    e.printStackTrace();
} 
%>



<% 
String comid=session.getAttribute("CompanyMasterID").toString();
String query12="";

String type=request.getParameter("status");
System.out.println("-------->"+type);


String totalTask = request.getParameter("totalTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
System.out.println("user_id::"+user_id);

String user_name = request.getParameter("user_name");



System.out.println("The total Tasks is :"+totalTask);
System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The user_id is :"+user_id);
System.out.println("The username is :"+user_name);
String Sesrole1=session.getAttribute("role").toString();
%>
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
<%

String Bt1=request.getParameter("button");
System.out.println("----------In Button-------------11111111111"+Bt1);
		if(Bt1==null || Bt1=="null" || Bt1.equals("null"))
		{	
	System.out.println("==in if==");
	datenew1 = request.getParameter("fromdate");
	datenew2 = request.getParameter("todate");
	
	 UserID=request.getParameter("userid");
	System.out.println("UserID::"+UserID);
	openprojectid = UserID;
	 fromdate=request.getParameter("fromdate");
	 todate=request.getParameter("todate");
	 HOD=request.getParameter("HOD");
	 Dept=request.getParameter("Dept");
	 User=request.getParameter("User");
	 Status=request.getParameter("Status");
	 Role=request.getParameter("role");
		 
		if(Status.equals("Submited"))
		{
			System.out.println("IN SUBMITED");
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
		System.out.println("IN datenew1:: "+datenew1);

		datenew2 = ""+datenew2;
		System.out.println("IN datenew2:: "+datenew2);

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
	 UserID=request.getParameter("userid");
	System.out.println("UserID::"+UserID);
	openprojectid = UserID;
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
         <form name="form1" id="newModalForm" method="post" action="OPTaskNextKRA.jsp" enctype="multipart/form-data">
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
						 
		<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
		<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
      </form>
       </div>
      
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="btnCloseIt">Close</button>
      	<button type="button" id="submit" class="btn btn-primary btn-sm" id="btnSaveIt" onclick="return approve1()">Save</button>
      </div>
    </div>
  </div>
</div>
 

<div class="modal fade" id="addMyModall" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Task Assign</b></h4>
        <div class="row">
             <div class="col-md-5">
             <div class="row">
           <div class="col-md-3">
            <label for="uid" class="control-label"><b>UserID: </b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="usrid12" name="usrid12" readonly="readonly" class="form-control">
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
        <div class="row">
           <div class="col-md-3">
            <label for="tid" class="control-label"><b>Task Name:</b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="tsk11" name="tsk11" readonly="readonly" class="form-control">
        </div>
        </div>

         <hr>
         <form action="OPKRANextAdd.jsp"  method="get" >
           					 <input type="hidden"  name="datefrom" id="datefrom" value="" />
                	        <input type="hidden"  name="dateto" id="dateto" value="" />
                        	<input type="hidden"  name="HOD1" id="HOD1" value="" />
                        	<input type="hidden"  name="Dept1" id="Dept1" value="" />
                        	<input type="hidden"  name="usrid11" id="usrid11" value="" />
                        	<input type="hidden"  name="Usern1" id="Usern1" value="" />
                        	<input type="hidden"  name="Status1" id="Status1" value="" />
                        	<input type="hidden"  name="Task1" id="Task1" value="" />
		

     
      <div class="row mt-3">
 <div class="col-md-3">				  
   <label for="dropdown"><b>Task Description:</b></label>
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
      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="btnCloseIt">Close</button>
      	<button type="button" id="submit" class="btn btn-primary btn-sm" id="btnSaveIt1">Save</button>
      </div>
    </div>
  </div>
</div>
		
 <% 
String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637">KRA Task Report</h5>
    </div>
</div>
	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
		<form name="custreport" id="custreport" method="post">
		<div class="row col-12">
		    <div class="col-md-1"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" name="companyName1" id="companyName1" onchange="consig();" >
                                  <%	String Bt4=request.getParameter("button");  		
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
		System.out.println("*******"+sql1);
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
			            <%	String Bt2=request.getParameter("button");
  		

          System.out.println("-INNNNNNNNNNNN-------------"+Bt2);
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
            System.out.println("INNN Elseeeeeeeee");
             EmpName1=request.getParameter("EmpName"); 
    	    System.out.println("******EmpName*"+EmpName1);
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
           <option ><%=Status %></option>
                        <%
            String sql14="";
            
            	sql1="select distinct(TaskStatus) as status from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy where TaskStatus!='Duplicate'";
            
        System.out.println("*******"+sql1);
        ResultSet rsregno123 = st.executeQuery(sql1);
		while(rsregno123.next())
		{
			s=rsregno123.getString("status");			 
			 System.out.println("s-->"+s);
			%>
			<option value="<%=s%>"><%=s%></option>
			
	         <%
      }
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
</form>
		
<br>		
<%
System.out.println("status::"+Status);
%>		


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
			<th>TaskDescription</th>
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
<th>Description</th>
<th>Duration</th>
<th>StartDate</th>
<th>EndDate</th>
 <th>Percentage</th>
 <th>Comment</th>
<th>Attachment</th>
<th>Status</th>
<th>RejectedComment</th>
</tr>
</thead>
              <%} %>

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
		
		%>
		

	
<%
String name13="";
		String Bt=request.getParameter("button");
System.out.println("----------In Button-------------"+Bt);
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			// name13=User;
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
        			}
        	else
        	{
        		department=Dept;
        	}
    
        	if(name13.equals("All"))

        	{
        		name13="";
        	}
        	
        	
        if(Status.equals("Assigned"))
        {
        	
			System.out.println("IN Assigned");
			query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as TaskDescription ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id = 9 order by a.id asc";			
			System.out.println("query12---"+query12);
			rs=stmt1.executeQuery(query12);
			int i=1;
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
				String TaskDescription="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				TaskDescription=rs.getString("TaskDescription");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=UserID%></td>
						<td class="text-left"><%=User%></td>
						<%
					if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD")) {
						%>
						<td class="text-center"><a data-bs-toggle="modal" data-bs-target="#addMyModall" style="cursor: pointer;color: #0d6efd;" onclick="return demoo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
						<% } else{ %>
						<td class="text-center"><%=TaskId%></td>
						<% } %>
						<td class="text-left"><%=TaskName%></td>
						<td class="text-left"><%=TaskDescription%></td>
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
		System.out.println("IN Missed");

		query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as TaskDescription ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id= 9 and a.status_id = 1 order by a.id asc"; 
		System.out.println("query12---"+query12);
		rs=stmt2.executeQuery(query12);
		
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
			String TaskDescription="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			TaskDescription=rs.getString("TaskDescription");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
												
			%>
			<tr>
							<td class="text-center"><%=i%></td>
							<td class="text-center"><%=UserID%></td>
							<td class="text-left"><%=User%></td>
							<td class="text-center">
 								<a data-bs-toggle="modal" data-bs-toggle="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>					
							<td class="text-left"><%=TaskName%></td>
							<td class="text-left"><%=TaskDescription%></td>
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
			System.out.println("IN Submitted");
			 query12="SELECT a.id AS TaskId, a.assigned_to_id AS UserID, CONCAT(b.firstname, ' ', b.lastname) AS User, a.subject AS TaskName, a.description AS TaskDescription, TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate, TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours AS Duration, a.done_ratio AS TaskPercent, c.comments  as TaskComment FROM  work_packages a JOIN  users b  ON  a.assigned_to_id = b.id JOIN  time_entries c  ON  a.id = c.work_package_id WHERE  a.assigned_to_id = '"+openprojectid+"'  AND a.due_date >= '"+dt+"'  AND a.due_date <= '"+dt1+"' AND a.status_id = 12  and a.type_id = 9 ORDER BY  a.id ASC";
	        	System.out.println("query12---"+query12);
				rs=stmt3.executeQuery(query12);
				
				int i=1;
				while(rs.next())
				{
					String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
					String TaskDescription="";
					User=rs.getString("User");
					UserID=rs.getString("UserID");
					String[] TA=TaskAttachment.split(",");
					TaskId=rs.getString("TaskId");
					TaskName=rs.getString("TaskName");
					TaskDescription=rs.getString("TaskDescription");
					Duration=rs.getString("Duration");
					StartDate=rs.getString("StartDate");
					EndDate=rs.getString("EndDate");
					Stat="Submitted";
					TaskPercent=rs.getString("TaskPercent");
					TaskComment=rs.getString("TaskComment");
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=UserID%></td>
						<td class="text-left"><%=User%></td> 			
 						<td class="text-center">
 							<a data-bs-toggle="modal" data-bs-toggle="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
 						<td class="text-left"><%=TaskName%></td>
 						<td class="text-left"><%=TaskDescription%></td>
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
					 	<td class="text-left">-</td>
					 </tr>
			<%
			i++;
			}
        }
        else
        {
			System.out.println("IN else");
			query12="SELECT distinct(a.taskId) as TaskId,a.UserId,b.EmpName AS USER,a.TaskName,a.TaskDescription AS TaskDescription,a.AssignedDuration AS Duration, a.TaskPercent,a.TaskComment AS TaskComment,a.TaskAttachment,DATE_FORMAT(a.TaskStartDate,'%d-%b-%Y %T' ) AS StartDate,DATE_FORMAT(a.TaskEndDate,'%d-%b-%Y %T') AS EndDate,a.TaskRejectionComment AS RejectionReason ,a.TaskStatus AS STATUS  FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy  a JOIN db_GlobalERP.UserMaster b  ON a.UserID=b.KRAdotprojectid  WHERE  b.empname LIKE '%"+name13+"%' AND b.companymasterid=100000 AND b.activestatus='Yes'  AND b.dept LIKE '%"+department+"%'  AND  a.TaskEndDate >='"+dt+"' AND a.TaskEndDate <='"+dt1+"' AND a.TaskStatus LIKE '%"+Status+"%' ORDER BY a.TaskID ";	
            System.out.println("query12---"+query12);
			rs=st1.executeQuery(query12);
			int i=1;
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
				String TaskDescription="",RejectionComment="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				TaskDescription=rs.getString("TaskDescription");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
				Stat=rs.getString("Status");
				TaskAttachment=rs.getString("TaskAttachment");
				String[] TA=TaskAttachment.split(",");
				Arrays.toString(TA);
				TaskPercent=rs.getString("TaskPercent");
				TaskComment=rs.getString("TaskComment");
				RejectionComment=rs.getString("RejectionReason");
			%>
			<tr>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=UserID%></td>
						<td class="text-left"><%=User%></td>
 						<td class="text-center">
  							<a data-bs-toggle="modal" data-bs-toggle="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
 						<td class="text-left"><%=TaskName%></td>
 						<td class="text-left"><%=TaskDescription%></td>
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
					<td class="text-left"><%=RejectionComment%></td>
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
    	
    	System.out.println("Date :- "+datenew1);
    	
    	System.out.println("Date :- "+datenew2);
    	System.out.println("Name :- "+name13);
    	
    	if(name13.equals("All"))
    	{
    		name13="";
    	}
    	
    if(Status.equals("Assigned"))
    {
    	
		System.out.println("IN Assigned");
		query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as TaskDescription ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id = 9 order by a.id asc";			
		System.out.println("query12---"+query12);
		rs=stmt1.executeQuery(query12);
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
			String TaskDescription="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			TaskDescription=rs.getString("TaskDescription");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-center"><%=UserID%></td>
					<td class="text-left"><%=User%></td>
					<%
				if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD")) {
					%>
					<td class="text-center"><a data-bs-toggle="modal" data-bs-target="#addMyModall" style="cursor: pointer;color: #0d6efd;" onclick="return demoo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
					<% } else{ %>
					<td class="text-center"><%=TaskId%></td>
					<% } %>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=TaskDescription%></td>
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
		System.out.println("IN Missed");

		query12="select a.id as TaskId,a.assigned_to_id as UserID,CONCAT(b.firstname, ' ', b.lastname) AS User,a.subject as TaskName,a.description as TaskDescription ,  TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate,TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours as Duration from work_packages a JOIN users  b ON a.assigned_to_id = b.id where a.assigned_to_id="+openprojectid+" and due_date >= '"+dt+"' and due_date <='"+dt1+"' and a.type_id= 9 and a.status_id = 1 order by a.id asc"; 
		System.out.println("query12---"+query12);
		rs=stmt2.executeQuery(query12);
		
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="";
			String TaskDescription="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			TaskDescription=rs.getString("TaskDescription");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
												
			%>
			<tr>
							<td class="text-center"><%=i%></td>
							<td class="text-center"><%=UserID%></td>
							<td class="text-left"><%=User%></td>
							<td class="text-center">
 								<a data-bs-toggle="modal" data-bs-toggle="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>					
							<td class="text-left"><%=TaskName%></td>
							<td class="text-left"><%=TaskDescription%></td>
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
		System.out.println("IN Submitted");
		 query12="SELECT a.id AS TaskId, a.assigned_to_id AS UserID, CONCAT(b.firstname, ' ', b.lastname) AS User, a.subject AS TaskName, a.description AS TaskDescription, TO_CHAR(a.start_date, 'DD-Mon-YYYY HH24:MI:SS') AS StartDate, TO_CHAR(a.due_date, 'DD-Mon-YYYY 23:59:59') AS EndDate, a.estimated_hours AS Duration, a.done_ratio AS TaskPercent, c.comments  as TaskComment FROM  work_packages a JOIN  users b  ON  a.assigned_to_id = b.id JOIN  time_entries c  ON  a.id = c.work_package_id WHERE  a.assigned_to_id = '"+openprojectid+"'  AND a.due_date >= '"+dt+"'  AND a.due_date <= '"+dt1+"' AND a.status_id = 12  and a.type_id = 9 ORDER BY  a.id ASC";
       	System.out.println("query12---"+query12);
			rs=stmt3.executeQuery(query12);
			
			int i=1;
			while(rs.next())
			{
				String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
				String TaskDescription="";
				User=rs.getString("User");
				UserID=rs.getString("UserID");
				String[] TA=TaskAttachment.split(",");
				TaskId=rs.getString("TaskId");
				TaskName=rs.getString("TaskName");
				TaskDescription=rs.getString("TaskDescription");
				Duration=rs.getString("Duration");
				StartDate=rs.getString("StartDate");
				EndDate=rs.getString("EndDate");
				Stat="Submitted";
				TaskPercent=rs.getString("TaskPercent");
				TaskComment=rs.getString("TaskComment");
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-center"><%=UserID%></td>
					<td class="text-left"><%=User%></td> 			
					<td class="text-center">
						<a data-bs-toggle="modal" data-bs-toggle="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
					<td class="text-left"><%=TaskName%></td>
					<td class="text-left"><%=TaskDescription%></td>
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
				 	<td class="text-left">-</td>
				 </tr>
		<%
		i++;
		}
   }
    else
    {
		System.out.println("IN else");
		query12="SELECT distinct(a.taskId) as TaskId,a.UserId,b.EmpName AS USER,a.TaskName,a.TaskDescription AS TaskDescription,a.AssignedDuration AS Duration, a.TaskPercent,a.TaskComment AS TaskComment,a.TaskAttachment,DATE_FORMAT(a.TaskStartDate,'%d-%b-%Y %T' ) AS StartDate,DATE_FORMAT(a.TaskEndDate,'%d-%b-%Y %T') AS EndDate,a.TaskRejectionComment AS RejectionReason ,a.TaskStatus AS STATUS  FROM  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy  a JOIN db_GlobalERP.UserMaster b  ON a.UserID=b.KRAdotprojectid  WHERE  b.empname LIKE '%"+name13+"%' AND b.companymasterid=100000 AND b.activestatus='Yes'  AND b.dept LIKE '%"+department+"%'  AND  a.TaskEndDate >='"+dt+"' AND a.TaskEndDate <='"+dt1+"' AND a.TaskStatus LIKE '%"+Status+"%' ORDER BY a.TaskID ";	
        System.out.println("query12---"+query12);
		rs=st1.executeQuery(query12);
		int i=1;
		while(rs.next())
		{
			String TaskId="",TaskName="",Duration="",StartDate="",EndDate="",Stat="",TaskPercent="",TaskComment="",TaskAttachment="";
			String TaskDescription="",RejectionComment="";
			User=rs.getString("User");
			UserID=rs.getString("UserID");
			TaskId=rs.getString("TaskId");
			TaskName=rs.getString("TaskName");
			TaskDescription=rs.getString("TaskDescription");
			Duration=rs.getString("Duration");
			StartDate=rs.getString("StartDate");
			EndDate=rs.getString("EndDate");
			Stat=rs.getString("Status");
			TaskAttachment=rs.getString("TaskAttachment");
			String[] TA=TaskAttachment.split(",");
			Arrays.toString(TA);
			TaskPercent=rs.getString("TaskPercent");
			TaskComment=rs.getString("TaskComment");
			RejectionComment=rs.getString("RejectionReason");
		%>
		<tr>
					<td class="text-center"><%=i%></td>
					<td class="text-center"><%=UserID%></td>
					<td class="text-left"><%=User%></td>
						<td class="text-center">
							<a data-bs-toggle="modal" data-bs-toggle="#addMyModal" onclick="return demo('<%=datenew1%>','<%=datenew2%>','<%=HOD%>','<%=department%>','<%=User%>','<%=Status%>','<%=Role%>','<%=TaskName%>','<%=UserID%>','<%=TaskId%>')"><%=TaskId%></a></td>
						<td class="text-left"><%=TaskName%></td>
						<td class="text-left"><%=TaskDescription%></td>
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
				<td class="text-left"><%=RejectionComment%></td>
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
	                         title: 'KRA Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'KRA Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'KRA Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'KRA Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'KRA Description Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script>

function approve1()
{
	//alert("hello");
	
	var Dept=document.getElementById('Dept').value;
	document.getElementById('DeptHidden').value=Dept;
	console.log("DeptHidden : "+Dept);
//alert("DeptHidden "+Dept);

var Usern=document.getElementById('Usern').value;
document.getElementById('UsernHidden').value=Usern;
console.log("UsernHidden : "+Usern);
//alert("UsernHidden=== "+Usern);
//alert(Usern);
	
	var HOD=document.getElementById('HOD').value;
	document.getElementById('HODHidden').value=HOD;
	console.log("HODHidden : "+HOD);
	//alert("HODHidden=== "+HOD);

//alert(HOD);
	var dd=document.getElementById('datenew1').value;
	document.getElementById('datenew1Hidden').value=dd;
	console.log("datenew1Hidden : "+dd);
	//alert("datenew1Hidden=== "+dd);

//alert(dd);
	
	var dd1=document.getElementById('datenew2').value;
	document.getElementById('datenew2Hidden').value=dd1;
	console.log("datenew2Hidden : "+dd1);
	//alert("datenew2Hidden=== "+dd1);
	
	
//alert(dd1);
	
 	var Status=document.getElementById("Status").value;
 	document.getElementById('StatusHidden').value=Status;
	console.log("StatusHidden : "+Status);
	//alert("StatusHidden=== "+Status);
	

	var Role=document.getElementById('Role').value;
	document.getElementById('RoleHidden').value=Role;
	console.log("RoleHidden : "+Role);
	//alert("RoleHidden=== "+Role);
	

 	var userId=document.getElementById("usrid1").value;
 	document.getElementById('usrid1hidden').value=userId;
	console.log("usrid1hidden : "+userId);
	//alert("usrid1hidden=== "+userId);
	//alert(userId);

	var User=document.getElementById("tsk1").value;
	document.getElementById('tsk1hidden').value=User;
	console.log("tsk1hidden : "+User);
	//alert("tsk1hidden=== "+User);
	//alert(User);

	var TaskID=document.getElementById("tskid").value;
	document.getElementById('tskidhidden').value=TaskID;
	console.log("tskidhidden : "+TaskID);
	//alert("tskidhidden=== "+TaskID);
	//alert(TaskID);
	
	var satat=document.getElementById('status').value;
	document.getElementById('satathidden').value=satat;
	console.log("statushidden : "+satat);
	//alert("statushidden=== "+satat);
	//alert(satat);
	
	var other=document.getElementById('other12').value;
	
	//alert(other);
	
	other = other.replace("%", "");
	document.getElementById('other12hidden').value=other;
	console.log("other12hidden : "+other);
	//alert("other12hidden=== "+other);
	
	
	var comment=document.getElementById('comments31').value;
	document.getElementById('comments31hidden').value=comment;
	console.log("comments31hidden : "+comment);
	//alert("comments31hidden=== "+comment);
	
	//alert(comment);
	if(comment=="")
		{
		vali();
		
		}
	document.getElementById("newModalForm").submit(); 
// var li=location.assign("TaskNext.jsp?userId1="+userId+"&User1="+User+"&Role="+Role+"&Usern="+Usern+"&TaskID1="+TaskID+"&Dept="+Dept+"&Status="+Status+"&datenew1="+dd+"&HOD="+HOD+"&datenew2="+dd1+"&satat1="+satat+"&other123="+other+"&comment1="+comment);
alert("Loading...Please click OK");
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
   // alert(a);


     if(a=='Completed')
 	  {

    	 var aa='<label class="control-label col-md-3" for="email">Percentage*:</label><input type="text" id="other12" name="other12" style="width:30%;" value="100%" readonly align="left"></input></div>';
    	 
    	   document.getElementById('per').innerHTML=aa;
    	  
    	 
 	  }
     else if(a=='In Progress')
    	 {
    	 var bb='<label class="control-label col-md-3" for="email">Percentage*:</label><select name="other12" id="other12" style="width: 100px; height:20px; border: 1px solid black;" align="left"><option>25%</option><option>50%</option><option>75%</option</select>';

    //	 var bb='<input type="text" id="other12" name="other12" style="width:100%;"></input>  </div>';
  	   document.getElementById('per').innerHTML=bb;


    	 }
}
</script>
<script>
function vali()
{
	//alert("IN");
	var comment=document.getElementById("comment").value;

	if(comment=="")
		{
		alert("Enter comment");
		return false;
		}
	
	
	
	}


</script>
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
$(function() {
	var vale=$("#status").val();
	 // alert(vale);
	  if(vale=="Select")
		  {
		 // alert("IN");
		  }
	  vale="";
	  //alert(vale);
	  
		document.getElementById('status').value = vale;
		//alert(status);
			

		var vale2=$("#status").val();
		//	alert(vale2);


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
function demoo(datenew1,datenew2,HOD,Dept,User,Status,TaskName,UserID,TaskId)
{
	document.getElementById("tsk11").value = TaskName;
   	document.getElementById("usrid11").value = UserID;
	document.getElementById("usrid12").value = UserID;
	document.getElementById("tskid1").value = TaskId;
	document.getElementById("datefrom").value = datenew1;
    document.getElementById("dateto").value = datenew2; 
	document.getElementById("HOD1").value = HOD;
	document.getElementById("Dept1").value = Dept;
	document.getElementById("Usern1").value = User;
	document.getElementById("Status1").value = Status;
	document.getElementById("Task1").value = TaskId;
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>
