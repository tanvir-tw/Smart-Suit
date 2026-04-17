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
    #approve {
    text-decoration: none;
    font-size: inherit;
    font-weight: bold;
    }

</style>
</head>
<body style="background-color:azure;">
<%
// Variable Declaration
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String name=session.getAttribute("EmpName").toString();
String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
String dept = session.getAttribute("department").toString();

String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="",departmentNew="";
String Id="",USerName="",Name="",Comments="",CustomerName="",Date="",CheckIn="",CheckOut="",ActualWorkHrs="",Day="",DutyOut="",DutyIn="",WorkingHours="",Status="";
String token_int[]=null;
String dt4="";
double hrs_cal=0.00,min_cal=0.00,tot_sec1=0.00,sec_cal=0.00;

 // Connection Initialization
Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;

try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    st10 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");

		departmentNew=request.getParameter("departmentNew");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));

 String selected1=request.getParameter("dept");

 System.out.println(" selected1 department  :-  "+selected1);

 if(selected1==null && departmentNew!=null)
 {
 	selected1=departmentNew;
 }
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Attendance Report</h5>
    </div>
</div>
  <form name="AttendanceReport" id="AttendanceReport" method="post">
		    <div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="dept" name="dept">
        <%if(bt==null || bt==" " || bt=="")
        { 
        	departmentNew=request.getParameter("departmentNew");
        if(departmentNew==null)
        {
        	selected1=dept;

        %>
        <% if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
            {
            %>
            <option value="AllDept">AllDept</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%
            }else
            {
            	%>
                <option value="<%=sessiondept%>"><%=sessiondept%></option>
                <%
            }
        }
        else
        {
        	if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
            {
            %>
            <option value="<%=departmentNew%>"><%=departmentNew%></option>
            <option value="AllDept">AllDept</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%
            }else
            {
            	%>
                <option value="<%=sessiondept%>"><%=sessiondept%></option>
                <%
            }
        }
        } else
        {
          if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
            {
            %> 
              <option value="<%=selected1%>"><%=selected1%></option>
        	<option value="AllDept">AllDept</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%} else{%>     
        
        <option value="<%=sessiondept%>"><%=sessiondept%></option>
           <%} }%> 
            
            <% 
            String sql1="";
            String department="";
            
            if (Sesrole1.equals("Hr"))
            {
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept";
            }
            else 
            	{
            	if (Sesrole1.equals("HOD")){
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dept!='"+sessiondept+"'  and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept";
            			
             }
            else
            {
            	if(Sesrole1.equals("AllAdmin"))
            	{
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'   and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept ";
            	}
            	else
            	{
            		sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'  and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept ";
            	}
            }
          }
        ResultSet rsregno = st1.executeQuery(sql1);
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
                            const mySel = document.getElementById("dept");

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
<%
dept = session.getAttribute("department").toString();
String sessionname=session.getAttribute("EmpName").toString();
int cnt=0;
String sql_active=null;
String user_id1 = "";

if (Sesrole1.equals("HOD")||Sesrole1.equals("AllAdmin"))
{
	dept = request.getParameter("dept");
	if(dept!=null && dept.equals("AllDept"))
	{
		
      sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where  ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
	}
		else
	{
		if(dept==null && departmentNew==null){
			
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept!='"+dept+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
		}
		else
		{
		if(departmentNew==null || dept!=null)
		{
			sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept='"+dept+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
		}
		else
		{if(departmentNew.equals("AllDept") || departmentNew.equals("All"))
			{
sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept like '%%' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
			}else
{
			sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept='"+departmentNew+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}
		}
		}
	}
	
}
else
{
	if (Sesrole1.equals("Hr"))
	{
		dept = request.getParameter("dept");
		
	  if (dept!=null && (dept.equals("AllDept") || dept.equals("All")) ) 
		{
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' ";
		}
	  else
	  {
		  sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept= '"+dept+"' and ActiveStatus = 'Yes'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	  }
	}
}
if(Sesrole1.equals("-"))
{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}

		
if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("Hr") )
	
{
	dept = request.getParameter("dept");
		
	if(dept!=null && (dept.equals("All") || dept.equals("AllDept")))
	{
		dept="%%";
		
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	else
	{
	if(dept!=null)
	{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept = '"+dept+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	else
	{
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	}
}
ResultSet rs_active = st2.executeQuery(sql_active);

while(rs_active.next()){
++cnt;
if(cnt == 1)
{
	
		user_id1 = rs_active.getString("user_id");	
	
		user_id1="\'"+user_id1+"\'";
	
}else
{

		user_id1 = user_id1 +",\'"+rs_active.getString("user_id")+"\'";
}

}


String month="",Year="";

String countday="SELECT DAYNAME('"+dt+"') as DayName1,DAYOFMONTH('"+dt+"') as DayCnt ,MONTHNAME('"+dt+"') as MonthName,YEAR('"+dt+"') as Year";

ResultSet rs12=st3.executeQuery(countday);
if(rs12.next())
{
	month=rs12.getString("MonthName");
	Year=rs12.getString("Year");
}

month=month.substring(0,3);

if(role.equals("HOD")||role.equals("AllAdmin"))
{
%>
<a href="AttendanceViewApproval.jsp" style="text-decoration:none;"><b>View All Approval</b></a>

<% 
}
%>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>ID</th>
            <th>Name</th>
            <th>Date</th>
            <th>Comment</th>
             <th>CustomerName</th>
            <th>CheckIn</th>
            <th>CheckOut</th>
            <th>ActualWorkHrs</th>
            <th>Day</th>
            <th>DutyIn</th>
            <th>DutyOut </th>
            <th>WorkingHours </th> 
            <th>Status</th>
            <th>NewStatus</th>
            <th>Comments</th>
<%

if(role.equals("HOD")||role.equals("AllAdmin"))
{
	%>
	<th> Action</th>
	
	<% 
}

%>
            </tr>
        </thead> 
        <tbody>
<%
String data="select distinct(EmpID) as EmpID from db_leaveapplication.t_leaveadmin a ,db_GlobalERP.UserMaster b  where a.status = 'Yes' and a.EmpId=b.EmpCode and b.ActiveStatus='Yes' and b.companymasterid=100000 and b.EmpCode in ("+user_id1+") "; 

System.out.println("check-------->"+data);
ResultSet rs21=st4.executeQuery(data);
while(rs21.next())
{

String eid=rs21.getString("EmpID");

String data12="select distinct(ContractorId) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId='"+eid+"' ";
ResultSet rsData=st5.executeQuery(data12);
if(rsData.next())
{
String attendance="select EmpID as ID,EmpName as USerName,Name,EntryComments as Comments,CustomerName,DATE_FORMAT(checkDate,'%d-%b-%Y') as Date,min(checkTime) as CheckIn,max(checkTime) as CheckOut,TIME_FORMAT(TIMEDIFF(max(checkTime),min(checkTime)),'%T') as ActualWorkHrs,DAYNAME(checkDate) as Day,TIME_FORMAT(LEAST(max(checkTime),TOut),'%T') as DutyOut,TIME_FORMAT(GREATEST(min(checkTime),TIn),'%T')as DutyIn,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as WorkingHours,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as Status,'"+month+"' as Month ,'"+Year+"' as Year  from db_leaveapplication.t_checkinout where EmpID in (select EmpID from db_leaveapplication.t_leaveadmin where status = 'Yes' and TypeValue like '%%' and EmpID='"+eid+"') and checkDate >='"+dt+"' and checkDate <='"+dt1+"' group by checkDate ,EmpID ";
 ResultSet rsdata=st6.executeQuery(attendance);
int i=1;

while(rsdata.next())
{
	try{
	Id=rsdata.getString("Id");
	USerName=rsdata.getString("USerName");
	Name=rsdata.getString("Name");
	Date=rsdata.getString("Date");
    Comments=rsdata.getString("Comments");
	CustomerName=rsdata.getString("CustomerName");
	CheckIn=rsdata.getString("CheckIn");
	CheckOut=rsdata.getString("CheckOut");
	ActualWorkHrs=rsdata.getString("ActualWorkHrs");
	Day=rsdata.getString("Day");
	DutyIn=rsdata.getString("DutyIn");
	DutyOut=rsdata.getString("DutyOut");
	WorkingHours=rsdata.getString("WorkingHours");
	Status=rsdata.getString("Status");
	
	dt4= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Date));
	
	if(Comments==null)
	{
		Comments="-";
	}
	}
	catch(Exception e)
	{
		System.out.print(e);
	}
		
	 token_int=WorkingHours.split(":");
						
							
							hrs_cal=Double.parseDouble(token_int[0]);
							min_cal=Double.parseDouble(token_int[1]);
							sec_cal=Double.parseDouble(token_int[2]);
							hrs_cal=hrs_cal * 60 *60;
							min_cal=min_cal * 60;
	
							tot_sec1=hrs_cal+min_cal+sec_cal;
												
	int secondMax=0,Max=0,Min=0;						
		
	String maxd="select max(MaxSec) as SecondMax,Min(MaxSec) as minSec from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"workingHoursStatusMaster where MaxSec NOT in (Select Max(MaxSec) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"workingHoursStatusMaster)";
	ResultSet rsd=st7.executeQuery(maxd);
	if(rsd.next())
	{
		secondMax=rsd.getInt("SecondMax");
		Min=rsd.getInt("minSec");
		
	}
	
	
	String max="select Max(MaxSec) as MaxSec from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"workingHoursStatusMaster ";
	
		ResultSet rsd1=st8.executeQuery(max);
		if(rsd1.next())
		{
			Max=rsd1.getInt("MaxSec");
			
		}
		
		String checkdate="select EmpID as ID,EmpName as USerName,Name,EntryComments as Comments,CustomerName,DATE_FORMAT(checkDate,'%d-%b-%Y') as Date,min(checkTime) as CheckIn,max(checkTime) as CheckOut,TIME_FORMAT(TIMEDIFF(max(checkTime),min(checkTime)),'%T') as ActualWorkHrs,DAYNAME(checkDate) as Day,TIME_FORMAT(LEAST(max(checkTime),TOut),'%T') as DutyOut,TIME_FORMAT(GREATEST(min(checkTime),TIn),'%T')as DutyIn,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as WorkingHours,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as Status,'"+month+"' as Month ,'"+Year+"' as Year  from db_leaveapplication.t_checkinout where EmpID in (select EmpID from db_leaveapplication.t_leaveadmin where status = 'Yes' and TypeValue like '%%' and EmpID='"+eid+"') and checkDate >='"+dt4+"' and checkDate <='2018-07-16'  group by checkDate ,EmpID "; 
		ResultSet rschk=st9.executeQuery(checkdate);			
				
					if(rschk.next())
						{			
						if(tot_sec1>=30600)
						{
							Status="Present";
							
						}else if(tot_sec1>=29700 && tot_sec1<30600)
						{
							Status="Late";
							
						}else if(tot_sec1>=16200 && tot_sec1<28800)
						{
							Status="Half Day";
							
						}else if(tot_sec1< 16200)
						{
							Status="Absent";
							
						}
						
						}
						else
						{

							if(tot_sec1>=Max)
							{
								Status="Present";
							}
							else if(tot_sec1>=secondMax && tot_sec1<Max)
							{
								Status="Late";
							}
							else if(tot_sec1>=Min && tot_sec1<secondMax)
							{
								Status="HalfDay";
							}
							else if(tot_sec1<Min)
							{
								Status="Absent";
							}
						
						}	
							
%>
<tr>
	<td class="text-center"><%=i%></td>
	<td class="text-center"><%=Id%></td>
	<td class="text-left"><%=Name%></td>
	<td class="text-right"><%=Date%></td>
    <td class="text-left"><%=Comments%></td>
	<td class="text-left"><%=CustomerName%></td>
	<td class="text-center"><%=CheckIn%></td>
	<td class="text-center"><%=CheckOut%></td>
	<td class="text-center"><%=ActualWorkHrs%></td>
	<td class="text-left"><%=Day%></td>
	<td class="text-center"><%=DutyIn%></td>
	<td class="text-center"><%=DutyOut%></td>
	<td class="text-center"><%=WorkingHours%></td>
	<td class="text-left"><%=Status %></td>
	<%
	String new_Status="",comments="";
	String updatedstatus="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster where Date='"+Date+"' and ID='"+Id+"' and Month='"+month+"' and Year='"+Year+"'";
	ResultSet rsStatus=st10.executeQuery(updatedstatus);
	if(rsStatus.next())
	{
		new_Status=rsStatus.getString("NewStatus");
		comments=rsStatus.getString("Comments");
	}
	else
	{
		new_Status="-";
		comments="-";
	}
	%>
	<td class="text-left"><%=new_Status%></td>
	<td class="text-left"><%=comments%></td>
<%
if(role.equals("HOD")||role.equals("AllAdmin"))
{
	if(!(Status.equals("Late")||Status.equals("Present")) && (!sessionname.equals(Name)))		
	 { 
		%>
		<td class="text-left">	
	<button id="approve" type="button" class="btn btn-link text-success p-0" data-bs-toggle="modal" data-bs-target="#ApproveModal"
    onclick="senddata('<%=Id %>','<%=Date %>','<%=Status %>','<%=Name %>','<%=new_Status %>','<%=dt %>','<%=dt1%>','<%=selected1%>')">
    Approve</button>
	
	<% 

	%>
	
</td>
		<%
	}
	else
	{
		%>
		<td>-</td>
		<% 
	}
	
	
}
%>
<%
i++;
}
}
else
{
	
}
}
%>
  </tbody>
 </table>
 </div>

<!-- Approve Modal -->
<div class="modal fade" id="ApproveModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Approve Action</b></h4>
        <div class="row">
             <div class="col-md-5">
             <div class="row">
           <div class="col-md-3">
            <label for="eid" class="control-label"><b>Id : </b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="eid" name="eid" readonly="readonly" class="form-control">
        </div>
        </div>
        </div>
          <div class="col-md-7">
         <div class="row">
           <div class="col-md-3">
            <label for="name" class="control-label"><b>Name : </b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="ename" name="ename" readonly="readonly" class="form-control">
        </div>
        </div>
             </div> 
             </div>
              <div class="row mt-1">
             <div class="col-md-5">
             <div class="row">
           <div class="col-md-3">
            <label for="date" class="control-label"><b>Date:</b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="date" name="date" readonly="readonly" class="form-control">
        </div>
        </div>
        </div>
        <div class="col-md-7">
         <div class="row">
           <div class="col-md-3">
            <label for="status" class="control-label"><b>Status :</b></label>
        </div>
        <div class="col-md-9">
            <input type="text" id="status" name="status" readonly="readonly" class="form-control">
        </div>
        </div>
              </div>
            <input type="hidden" id="chkdt" name="chkdt" value=""/>
            <input type="hidden" id="chkdt1" name="chkdt1" value=""/>
            <input type="hidden" id="departmentNew" name="departmentNew" value=""/>
         </div>
         <hr>
      <div class="row">
      <div class="col-md-3">				  
      <label for="dropdown"><b>ChangeStatus : </b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="status1" name="status1">
                              <option value="Present">Present</option>
     	                      <option value="Absent">Absent</option>
     	                      <option value="HalfDay">HalfDay</option>
     	                      <option value="Late">Late</option>	
                           </select>
                            <script>
                            const mySel1 = document.getElementById("basicSelect");

                            // Check if btn (bt) is null
                             const isBtNull = <%= bt == null %>;

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
        <button type="button" id="submit" class="btn btn-primary btn-sm" onclick="return approve();">Submit</button>
      </div>
    </div>
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
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         fixedColumns: { 
	            left: 4      //To freeze two columns
	        }, 
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
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Attendance Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script>

function senddata(id,data,status,Name,new_status,chkdt,chkdt1,departmentNew)
{	
	document.getElementById("chkdt").value = chkdt;
		
	document.getElementById("chkdt1").value = chkdt1;
	
	document.getElementById("departmentNew").value = departmentNew;

	document.getElementById("ename").value = Name;
	document.getElementById("eid").value = id;
	
	document.getElementById("date").value = data;
	
	if(new_status=='-')
		{
		document.getElementById("status").value = status;
	document.getElementById("status1").value = status;
	}
	else
		{
		document.getElementById("status").value = status;
		document.getElementById("status1").value = new_status;
		}
	
}

</script>
<script>
function approve()
{
	
	var Ename=document.getElementById("ename").value;
	var Eid=document.getElementById("eid").value;
	var Status=document.getElementById("status").value;
	var Date=document.getElementById("date").value;
	
	var checkDate=document.getElementById("chkdt").value;
	
	var checkDate1=document.getElementById("chkdt1").value;

	var departmentNew=document.getElementById("departmentNew").value;
    var comments=document.getElementById("mycomments").value;
	
	if(comments=="")
		{
		alert("Please Enter Comments");
		return false;
		}
	
	
	var statusnew=document.getElementById("status1").value;

	var action="Approve";
	location.assign("AttendanceAction.jsp?id="+Eid+"&action="+action+"&Name="+Ename+"&preStatus="+Status+"&newStatus="+statusnew+"&date="+Date+"&comment="+comments+"&checkDate="+checkDate+"&checkDate1="+checkDate1+"&departmentNew="+departmentNew+"");
}

</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>