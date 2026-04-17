 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
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
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
Connection conn = null;
Statement st = null, stmt=null, stmt1=null;
ResultSet rs = null;
try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    stmt=conn.createStatement();
    stmt1=conn.createStatement();
    
} catch (Exception e) {
    e.printStackTrace();
} 
%>

<% 
String query12="";
String type=request.getParameter("status");

%>

<%
String dept = "";
String user_id1 = "";
String totalTask = request.getParameter("totalTask");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");
String department="";
//conn =DriverManager.getConnection("jdbc:mysql://"+host1+"/dotproject",user1,pass1);

String Sesrole1=session.getAttribute("role").toString();

%>

<%

System.out.println("Ses role :- "+Sesrole1);
String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
String todaysDate = session.getAttribute("today").toString();

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
 
 System.out.println("dt1dt1dt00000000000000 "+dt); 
 System.out.println("dt1dt1dt1 "+dt1);

%>


	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
	<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
	
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

           <%	String Bt1=request.getParameter("button");
          System.out.println("-INNNNNNNNNNNN-------------"+Bt1);
          if(Bt1==null || Bt1=="null" || Bt1.equals("null"))
        	  {%>
          
          <%if(Sesrole1.equals("AllAdmin")) {
           %>
           <option value="All">All</option>
          
            
            <%} 
            else
            {%>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%} %>
            <%}
            else 
            {
            System.out.println("INNN Elseeeeeeeee");
            String seldept=request.getParameter("companyName1"); 
    	    System.out.println("******seldept*"+seldept);
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
             
            else if (Sesrole1.equals("HOD")){
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
			 System.out.println("department-->"+department);
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
          <%if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD")) {
           %>
           <option value="All">All</option>
           
           <%} else
           {%>
           <option value="<%=name%>"><%=name%></option>
           <%} }
            else 
            {
            System.out.println("INNN Elseeeeeeeee");
            String EmpName1=request.getParameter("EmpName"); 
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
	String Nam = request.getParameter("EmpName");
	System.out.println("Nam"+Nam);
	%>	
<%
	String fromDate = "", toDate = "",fromDate1="";
	String CustomerCode="";
	String dotprojectid="";
	
	String stp="Pending";
	String comid=session.getAttribute("CompanyMasterID").toString();
	
	%>
	<input type="hidden" id="comid" name="comid" value="<%=comid%>" />
	<%
	DecimalFormat df2 = new DecimalFormat("#0.00");

%>
<%
String user="";
	String name1=session.getAttribute("EmpName").toString();
	String department1=session.getAttribute("department").toString();
	
String name13="";
		String Bt=request.getParameter("button");
		

System.out.println("----------In Button-------------"+Bt);
		if(Bt==null || Bt=="null" || Bt.equals("null"))
		{
			System.out.println("----------In Button-------------");

			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			 name13=session.getAttribute("EmpName").toString();
			String Sesrole2=session.getAttribute("role").toString();
			
			System.out.println("Role :- "+Sesrole2);
System.out.println("department-->"+department);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
        	
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
        	System.out.println("Name :- "+name13);
        	
        	if(name13=="All")
        	{
        		name13="";
        	}
        	if(department=="All")
        	{
        		department="";
        	}

query12="select Empname as User,dotprojectid as UserID,empcode,HodReport as HOD ,Dept as Department,IFNULL((select sum(a.task_duration)  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id  where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and user_id=c.dotprojectid ),0) as Assigned,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and d.TaskStatus!='Duplicate' ),0) as Submited,IFNULL((select sum(task_duration) from dotproject.user_tasks a left join dotproject.tasks b on  a.task_id=b.task_id where  a.user_id=c.dotprojectid and task_end_date >='"+dt+"' and task_end_date <='"+dt1+"' and b.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid ) ),0) as Missed ,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"'  and d.TaskStatus='Pending' ),0) as Pending,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Approved' and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' )),0) as Approved ,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Rejected' and TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' )),0) as Rejected from db_GlobalERP.UserMaster c where c.activestatus='Yes' and c.companymasterid=100000 and c.dept like '%"+department+"%' and c.EmpName like '%"+name13+"%'  and (c.HODReport like '%"+name13+"%' OR c.EmpName like '%"+name13+"%' ) order by c.Empname";

System.out.println("query12---"+query12);
rs=stmt.executeQuery(query12);

int i=1;

while(rs.next())
{
	String User="",UserID="",empcode="",HOD="",Department="",Assigned="",Submitted="",Missed="",Pending="",Approved="",Rejected="";
	User=rs.getString("User");
	System.out.println("-User------->"+User);
	
	UserID=rs.getString("UserID");
	System.out.println("-UserID------->"+UserID);
	
	empcode=rs.getString("empcode");
	System.out.println("-empcode------->"+empcode);
	
	Assigned=rs.getString("Assigned");
	System.out.println("-Assigned------->"+Assigned);
	
	Submitted=rs.getString("Submited");
	System.out.println("-Submitted------->"+Submitted);
	
	Missed=rs.getString("Missed");
	System.out.println("-Missed------->"+Missed);
	
	Pending=rs.getString("Pending");
	System.out.println("-Pending------->"+Pending);
	
	Approved=rs.getString("Approved");
	System.out.println("-Approved------->"+Approved);
	
	Rejected=rs.getString("Rejected");
	System.out.println("-Rejected------->"+Rejected);
	
	HOD=rs.getString("HOD");
	System.out.println("-HOD------->"+HOD);
	
	Department=rs.getString("Department");
	System.out.println("-Department------->"+Department);
	
	double Assign = Double.parseDouble(Assigned);
	double Submit = Double.parseDouble(Submitted);
	double Miss = Double.parseDouble(Missed);
	double Pend = Double.parseDouble(Pending);
	double Approve = Double.parseDouble(Approved);
	double Reject = Double.parseDouble(Rejected);
	
%>
   <tr>
			<td class="text-center"><%=i%></td>
			<td class="text-left"><%=rs.getString("User")%></td>
			<td class="text-center"><%=rs.getString("UserID")%></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Assigned&role=<%=Sesrole2%>"><%=df2.format(Assign)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Submited&role=<%=Sesrole2%>"><%=df2.format(Submit)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Missed&role=<%=Sesrole2%>"><%=df2.format(Miss)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Pending&role=<%=Sesrole2%>"><%=df2.format(Pend)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Approved&role=<%=Sesrole2%>"><%=df2.format(Approve)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Rejected&role=<%=Sesrole2%>"><%=df2.format(Reject)%></a></td>
			<td class="text-left"><%=rs.getString("Department")%></td>
			<td class="text-left"><%=rs.getString("HOD")%></td>
	
  </tr>
<%
i++;
}
      
		}
		else
		{
			System.out.println("----------In Button-------------Else");
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			 name13=session.getAttribute("EmpName").toString();
			String Sesrole2=session.getAttribute("role").toString();
			
			System.out.println("Role :- "+Sesrole2);
			
			
System.out.println("department-->"+department);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
        	
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
        	
        	System.out.println("Name :- "+name13);
        	
        	if(name13.equals("All"))
        	{
        		name13="";
        	}
			 seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);

query12="select Empname as User,dotprojectid as UserID,empcode,HodReport as HOD ,Dept as Department,IFNULL((select sum(a.task_duration)  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id  where task_end_date >='"+dttime+"' and task_end_date <='"+dt1time+"'  and user_id=c.dotprojectid ),0) as Assigned,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' and d.TaskStatus!='Duplicate' ),0) as Submited,IFNULL((select sum(task_duration) from dotproject.user_tasks a left join dotproject.tasks b on  a.task_id=b.task_id where  a.user_id=c.dotprojectid and task_end_date >='"+dttime+"' and task_end_date <='"+dt1time+"' and b.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' and userid=c.dotprojectid ) ),0) as Missed ,IFNULL((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"'  and d.TaskStatus='Pending' ),0) as Pending,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Approved' and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' )),0) as Approved ,IFNULL(((select sum(d.AssignedDuration) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata d where c.dotprojectid=d.userid and TaskStatus='Rejected' and TaskEndDate >='"+dttime+"' and TaskEndDate <='"+dt1time+"' )),0) as Rejected from db_GlobalERP.UserMaster c where c.activestatus='Yes' and c.companymasterid=100000 and c.dept like '%"+department+"%' and c.EmpName like '%"+name13+"%'  and (c.HODReport like '%"+name13+"%' OR c.EmpName like '%"+name13+"%' ) order by c.Empname";

System.out.println("query12 else ---"+query12);
rs=stmt.executeQuery(query12);

int i=1;

while(rs.next())
{
	String User="",UserID="",empcode="",HOD="",Department="",Assigned="",Submitted="",Missed="",Pending="",Approved="",Rejected="";
	User=rs.getString("User");
	System.out.println("-User------->"+User);
	
	UserID=rs.getString("UserID");
	System.out.println("-UserID------->"+UserID);
	
	empcode=rs.getString("empcode");
	System.out.println("-empcode------->"+empcode);
	
	Assigned=rs.getString("Assigned");
	System.out.println("-Assigned------->"+Assigned);
	
	Submitted=rs.getString("Submited");
	System.out.println("-Submitted------->"+Submitted);
	
	Missed=rs.getString("Missed");
	System.out.println("-Missed------->"+Missed);
	
	Pending=rs.getString("Pending");
	System.out.println("-Pending------->"+Pending);
	
	Approved=rs.getString("Approved");
	System.out.println("-Approved------->"+Approved);
	
	Rejected=rs.getString("Rejected");
	System.out.println("-Rejected------->"+Rejected);
	
	HOD=rs.getString("HOD");
	System.out.println("-HOD------->"+HOD);
	
	Department=rs.getString("Department");
	System.out.println("-Department------->"+Department);
	
	
	double Assign = Double.parseDouble(Assigned);
	double Submit = Double.parseDouble(Submitted);
	double Miss = Double.parseDouble(Missed);
	double Pend = Double.parseDouble(Pending);
	double Approve = Double.parseDouble(Approved);
	double Reject = Double.parseDouble(Rejected);
	
%>
			<tr>
			<td class="text-center"><%=i%></td>
			<td class="text-left"><%=rs.getString("User")%></td>
			<td class="text-center"><%=rs.getString("UserID")%></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Assigned&role=<%=Sesrole2%>"><%=df2.format(Assign)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Submited&role=<%=Sesrole2%>"><%=df2.format(Submit)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Missed&role=<%=Sesrole2%>"><%=df2.format(Miss)%></a></td>		
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Pending&role=<%=Sesrole2%>"><%=df2.format(Pend)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Approved&role=<%=Sesrole2%>"><%=df2.format(Approve)%></a></td>
			<td class="text-center"><a href="TaskDetReport.jsp?userId=<%=UserID%>&fromdate=<%=datex1%>&todate=<%=datex2%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Rejected&role=<%=Sesrole2%>"><%=df2.format(Reject)%></a></td>		
			<td class="text-left"><%=rs.getString("Department")%></td>
			<td class="text-left"><%=rs.getString("HOD")%></td>
  </tr>
<%
i++;
}
               	
		%>
		 
			<%
		}
		
	
		

%>
</tbody>	
</table>

</div>
		
		<%
}catch(Exception e ){
	e.printStackTrace();
}
		%>
		
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
	//alert("eeeeeeeeeeeeeeeeeeeeeeeeee");
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		   //alert("Original result"+reselt);
			var finalres=reselt.split("#");
			document.getElementById("EmpName").innerHTML=finalres[0];
			//alert("After trim"+finalres[0]);
			
			  
		 
		}
	
	}
	
	var queryString = "?dept="+dept;
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "EmpAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	
	//re(1);
	}
</script>
<script>
function senddata2(UserId,dt,dt1,HOD,Department,User,Status,Sesrole2)
{
	 //System.out.println("Inside senddata2");
	 alert("Hi");
	 //alert("Id :- "+id);
	 //alert("Name :- "+Name);
	 window.location="TaskDetReport.jsp?UserId="+UserId+"&fromdate="+dt"&todate="+dt1"&HOD="+HOD"&Dept="+Department"&User="+User"&Status="+Status"&Role="+Sesrole2"";
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
	        stateSave: true,
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
 <%@ include file="footer.jsp" %>
</body>
</html>