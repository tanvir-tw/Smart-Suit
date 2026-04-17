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
String datenew1="",datenew2="",date1 = "",date2 = "",dept = "",user_id1 = "",tDate1 = "",tDate2 = "",detp123="",department="";
String sql1="";
// Variable Declaration
datenew1 = request.getParameter("from_date1");
datenew2 = request.getParameter("to_date1");
String totalTask = request.getParameter("totalTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");
 String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String sessiondept=session.getAttribute("department").toString();
String indxtype2 = request.getParameter("indxtype");
String dept2 = request.getParameter("dept");
String ename2 = request.getParameter("ename");
String frdate2 = request.getParameter("frdate");
String todate2 = request.getParameter("todate");

 // Connection Initialization
Connection conn = null;
Statement st = null,st1 = null,st11=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	st=conn.createStatement();
	st1=conn.createStatement();
	st11=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%

String daydata="select DATE_FORMAT(DATE(NOW() - INTERVAL 1 Month),'%Y-%m-01') as First,LAST_DAY(NOW() - INTERVAL 1 Month) as Last,NOW() As Today";
ResultSet rsdaydata=st1.executeQuery(daydata);
String FirstDay="",LastDay="";
String Curr="",Prev1="",Prev2="",today="";
if(rsdaydata.next())
{
	  FirstDay=rsdaydata.getString("First");
	  LastDay=rsdaydata.getString("Last");
	  today=rsdaydata.getString("Today");
}
try{

 if(datenew1==null){
		
		System.out.println("==in if==");
		datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		tDate1 = datenew1;
		tDate2 = datenew2;
		detp123=request.getParameter("companyName1");
		if(detp123==null || detp123.equals(null) || detp123.equals("null"))
		{		
		}
		else
		{
			
		}
	}
	else{
	System.out.println("==in else==");
	datenew1 = request.getParameter("from_date1");
	datenew2 = request.getParameter("to_date1");
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
	}

	DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
	String dataDate1=df1234.format(df123.parse(datenew1));
	String dataDate2=df1234.format(df123.parse(datenew2));

	String Sesrole1=session.getAttribute("role").toString();
	System.out.println("Ses role :- "+Sesrole1);
	String name=session.getAttribute("EmpName").toString();
	if(Sesrole1.equalsIgnoreCase("Alladmin") || sessiondept.equalsIgnoreCase("All"))
		
	{
		name="Vikram Puri";
	}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Approval Report</h5>
    </div>
</div>
<form name="indexReport" method="get"  action="">
		    <div class="row col-12" id="ext_row">
		    <div class="col-md-1"></div>     
             <div class="col-md-1 ms-2">
				  <label for="dropdown"><b>IndexType</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" name="Index" id="Index">
                          
         <%String Index=request.getParameter("Index");
         String Index1="";
    		System.out.println("Selected Index :- "+Index); 
    		if(Index==null)
    		{
    			Index="PI";
    		%>
    		<option value="<%=Index%>"><%=Index%></option>
    		<option value="KRA">KRA</option>
    		<%} else{
    			if(Index.equals("PI"))
    			{
    				Index1="KRA";	
    			}else
    			{
    				Index1="PI";
    			}	   			
    		%>
    		<option value="<%=Index%>"><%=Index%></option>
            <option value="<%=Index1%>"><%=Index1%></option> 
            
            <%} %>
           </select>
                            <script>
                            const mySel = document.getElementById("Index");

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
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" name="companyName1" id="companyName1" onchange="empname()">
						<%
						    String Bt1 = request.getParameter("button");
						     dept = request.getParameter("companyName1");
						    String sessionDept = (String) session.getAttribute("sessiondept");
									
							String currentDept;
						    if (Bt1 == null || Bt1.equals("null")) {
						        if (Sesrole1.equals("AllAdmin")) {
						            currentDept = "Select";
						        } else {
						            currentDept = dept;
						        }
						    } else {
						        currentDept = dept;
						    }					
						    if (currentDept != null) {
						%>
						        <option value="<%= currentDept %>"><%= currentDept %></option>
						<%
						    } else {
						%>
						        <option value="Select">Select</option>
						<%
						    }
												    
						    if (Sesrole1.equals("AllAdmin")) {
						        sql1 = "SELECT DISTINCT(dept) AS department FROM db_GlobalERP.UserMaster WHERE companymasterid=" + session.getAttribute("CompanyMasterID").toString() + " AND ActiveStatus='Yes' AND  (dotprojectid!='-' or KRAdotprojectid!='-')  ORDER BY dept";
						    } else if (Sesrole1.equals("HOD")) {
						        sql1 = "SELECT DISTINCT(dept) AS department FROM db_GlobalERP.UserMaster WHERE companymasterid=" + session.getAttribute("CompanyMasterID").toString() + " AND ActiveStatus='Yes' AND  (dotprojectid!='-' or KRAdotprojectid!='-')  ORDER BY dept";
						   System.out.println("sql : " +sql1);
						    } else {
						        sql1 = "SELECT DISTINCT(dept) AS department FROM db_GlobalERP.UserMaster WHERE EmpName='" + session.getAttribute("EmpName").toString() + "' AND companymasterid=" + session.getAttribute("CompanyMasterID").toString() + " AND ActiveStatus='Yes' AND  (dotprojectid!='-' or KRAdotprojectid!='-')  ORDER BY dept";
						    }
						    ResultSet rsregno = st.executeQuery(sql1);
						    while (rsregno.next()) {
						         department = rsregno.getString("department");						
						        if (!department.equals(currentDept)) {
						%>
						            <option value="<%= department %>"><%= department %></option>
						<%
						        }
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
						<%	String Bt2=request.getParameter("sub");
           				String EmpName1=request.getParameter("EmpName");
          				if(Bt2==null || Bt2=="null" || Bt2.equals("null"))//onload
					        	  {  %>
					          <%if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD")) {  
					        	
					        	if(EmpName1!=null){  %>
					        	  <option value="<%=EmpName1%>" selected><%=EmpName1%></option>
					        	  
					           <%} %>
					           <option value="Select">Select</option>
					           <%} else
					           {%>
					           <option value="<%=name%>"><%=name%></option>
					           <%} }
					            else
					            {					            
					    	    if(Sesrole1.equals("AllAdmin")) {
					           %>				            
					             <option value="<%=EmpName1%>"><%=EmpName1%></option>
					             <option value="Select">Select</option>
					             
					             <%} 
					            else
					            { %>
					            <option value="<%=EmpName1%>" selected><%=EmpName1%></option>
					            <%
					            
					            if(session.getAttribute("EmployeeList")!=null){
					            	String list =session.getAttribute("EmployeeList").toString();
					            	out.print(list);
					            }
					            }  					    	    
					            } %>        			
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
 
			<div class="col-md-2" id="frmDT" style="display:'';">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="from_date1" id="data"  class="form-control" value="<%=datenew1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			
			<div class="col-md-2" id="ToDT" style="display:'';">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="to_date1"  class="form-control" value="<%=datenew2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				 				
 				</div>
		    </div>
				
			<div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="sub" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>
</form> 
 <%
	String IdexType=request.getParameter("Index");	
	String dept1=request.getParameter("companyName1");	
	String EmpName=request.getParameter("EmpName");	
	String fromDate = request.getParameter("from_date1");
	String toDate = request.getParameter("to_date1");	
 %>
 <div class="row col-12 mt-4 mb-2">
    <div class="col-md-2" style="width:8%;">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="getcheckedrow('<%=IdexType%>', '<%=dept1%>', '<%=EmpName%>', '<%=fromDate%>', '<%=toDate%>')"> Approve </button>
    </div>
    <div class="col-md-2">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="getcheckedrow1('<%=IdexType%>', '<%=dept1%>', '<%=EmpName%>', '<%=fromDate%>', '<%=toDate%>')"> Reject </button>
    </div>
</div>

<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
			<th>
				<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
				<font color="white" style="font-size:12px;">Chk &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
				<a href="#" onclick="unCheckAll()"> <font color="white" style="font-size:12px;">UnChk</font></a>
			</th>
			<th>ID</th>
			<th>Task Name</th>
			<th>Description</th>
			<th>Comment</th>
			<th>Status</th>
			<th>Attachment</th>
			<th>Start</th>
			<th>End</th>
			<th>Duration</th>
			<th>Mail</th>
			<th>Department</th>
			<th>Approval</th>
	        
            </tr>
        </thead> 
        <tbody>
       <%
		String username="";
		int cnt = 0;
		int ck=0;
		if(fromDate !=null && toDate !=null) {
			fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDate));
			toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate));
			String fromDTime =fromDate+" 00:00:00";
			String toDTime =toDate+" 00:00:00";
		
		String  task_id = "",task_name = "",task_owner = "",task_strtDateTime = "",Task_dur = "",taskEndDateTime = "",Task_per_com = "",task_project="";
		String maildatetime="",TaskStatus="",TaskComment="",TaskAttachment="";
		int taskpercent=0;
		String taskpercent1="";
		String taskperStatus="";
		double Task_dur1=0.00;
		
		if(dept1.equals("All"))
		{
			dept1="%%";
		}
		else
		{
			dept1=request.getParameter("companyName1");
		}		
	String sql_total="";
	String dotprojectid="";
	if(IdexType.equals("PI"))
	{
		dotprojectid="b.dotprojectid";
	}
	else if(IdexType.equals("KRA"))
	{
		dotprojectid="b.KRAdotprojectid";
	}
		if(dept1.equals("All"))
		{
			sql_total="select distinct (a.TaskID) as TaskID ,a.TaskName , a.TaskCreater ,a.TaskComment,a.TaskStartDate,a.AssignedDuration,a.TaskEndDate,a.MailDateTime,a.UserDepartment,a.UserId,b.EmpName,a.TaskStatus,a.TaskAttachment,a.TaskPercent from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata a , db_GlobalERP.UserMaster b  where date(a.taskenddate) >='"+fromDTime+"' AND date(a.taskenddate) <='"+toDTime+"' and a.TaskStatus='Pending'  and b.dept='"+dept1+"'  and a.UserId="+dotprojectid+"  and b.HODReport='"+name+"'  and b.ActiveStatus='Yes' order by UserId,TaskStartDate ";
		}
		else
		{
			if(EmpName.equals("All")){
				sql_total="select distinct (a.TaskID) as TaskID ,a.TaskName , a.TaskCreater ,a.TaskComment,a.TaskStartDate,a.AssignedDuration,a.TaskEndDate,a.MailDateTime,a.UserDepartment,a.UserId,b.EmpName,a.TaskStatus,a.TaskAttachment,a.TaskPercent from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata a , db_GlobalERP.UserMaster b  where date(a.taskenddate) >='"+fromDTime+"' AND date(a.taskenddate) <='"+toDTime+"' and a.TaskStatus='Pending'  and b.dept='"+dept1+"' and a.UserId="+dotprojectid+"  and b.HODReport='"+name+"'  and b.ActiveStatus='Yes' order by UserId,TaskStartDate ";
			}else{
				sql_total="select distinct (a.TaskID) as TaskID ,a.TaskName , a.TaskCreater ,a.TaskComment,a.TaskStartDate,a.AssignedDuration,a.TaskEndDate,a.MailDateTime,a.UserDepartment,a.UserId,b.EmpName,a.TaskStatus,a.TaskAttachment,a.TaskPercent from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata a , db_GlobalERP.UserMaster b  where date(a.taskenddate) >='"+fromDTime+"' AND date(a.taskenddate) <='"+toDTime+"' and a.TaskStatus='Pending'  and b.dept='"+dept1+"' and b.EmpName='"+EmpName+"'  and a.UserId="+dotprojectid+"  and b.HODReport='"+name+"'  and b.ActiveStatus='Yes' order by UserId,TaskStartDate ";
			}
		}
		ResultSet rs = st.executeQuery(sql_total);
		System.out.println("The query is ==>>"+sql_total);
		DecimalFormat df = new DecimalFormat("0.00");
		while(rs.next()){
			++cnt;
			ck++;
			task_id = rs.getString("TaskID");
			String task_description="";
			String sqll="select * from dotproject.tasks where task_id='"+task_id+"'";	
			ResultSet rss = st11.executeQuery(sqll);
			System.out.println("The sqll is ==>>"+sqll);
			while(rss.next()){
				task_description = rss.getString("task_description");
			}			
			task_name = rs.getString("a.TaskName");
			task_owner = rs.getString("a.TaskCreater");
			TaskComment=rs.getString("a.TaskComment");
			task_strtDateTime = rs.getString("a.TaskStartDate");
			Task_dur1 = rs.getDouble("a.AssignedDuration");
			taskEndDateTime = rs.getString("a.TaskEndDate");
			maildatetime= rs.getString("a.MailDateTime");
			Task_per_com = rs.getString("a.UserDepartment");
			task_project=rs.getString("a.UserId");
			username=rs.getString("b.EmpName");
			TaskStatus=rs.getString("a.TaskStatus");
			TaskAttachment=rs.getString("a.TaskAttachment");
			System.out.println("TaskAttachment is ------->"+TaskAttachment);
			String[] TA=TaskAttachment.split(",");
			taskpercent1=rs.getString("a.TaskPercent");
			if(taskpercent1.equals("-"))
			{
				taskpercent=0;
			}else{
			taskpercent=rs.getInt("a.TaskPercent");
			}							
			System.out.println("Task Percent------->"+taskpercent);
			 if(taskpercent==100)
			{
				taskperStatus="Completed";
			}
			if(taskpercent==75||taskpercent==50||taskpercent==25)
			{
				taskperStatus="In Progress";
			} 
		%> 
		
         <tr> 
			<td class="text-right"><%= cnt %></td>
			<td class="text-center"><input type="checkbox"  name="chkbx"   id="chkbx<%=ck %>"  /></td>
		    <td class="text-center" ><div class="text-right" id="net_id1<%=ck %>"><%=task_id %></div></td>
			<td class="text-left"><%=task_name %></td>
			<td class="text-left"><%=task_description %></td>	
			<td class="text-left"><%=TaskComment %></td>
			<td class="text-left"><%=taskperStatus%></td>		
			<td class="text-right">	 
				 <%for (int k=0;k<TA.length;k++) {
				 
					 if(TA[k].equals("-"))
					 {
						out.println("-");	
					 }
					 
					 else
					 {
						 String attachmentName = "A" + (k + 1);
				 %>
				 		<a href="Downloadtaskattachment.jsp?filename=<%=TA[k]%>" target="_blank" title="<%=TA[k]%>">
			                <%=attachmentName%><% if (k < (TA.length - 1)) { %>,<% } %>
			            </a>			
							<%}		 
				 } %>
				 </td> 
			<td  class="text-right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_strtDateTime)) %></td>
			<td  class="text-right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(taskEndDateTime))  %></td>
			<td  class="text-right"><%= df.format(Task_dur1)%></td>
			<td  class="text-right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(maildatetime))  %></td>
			
			<td  class="text-center"><%= Task_per_com  %></td>
			<td  class="text-left"><%=TaskStatus   %></td>			
		</tr>
        <% } %>
<%}%>
</tbody>
 </table>
 </div>
  <input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>
<input type="hidden" name="userName" id="userName" value="<%=username %>"/>	
 

 <br>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        //scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	     //   scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A2',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Task Approval Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Task Approval Report from '+$("#data").val()+ ' to ' +$("#data1").val(),
                                orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Task Approval Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Task Approval Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Task Approval Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
					],
				},
           ], 
       
       });

   });
   
</script>
<script>
function checkAll()
{

	//alert("ok");
	var field = document.getElementById("checkedNumber").value;

//	var field=document.getElementsByName("chkbx");
//	alert("ok"+field);
	var i, chk=1;
	try{
	for (i = 0; i < field; i++)
	{
		 if(document.getElementById("chkbx"+chk).checked == false)
		 {
			 document.getElementById("chkbx"+chk).checked = true;
		 }
		 chk++;
		
	}
}catch(e)
{
}
}

function unCheckAll()
{

	//alert("ok");
var field = document.getElementById("checkedNumber").value;

//var field=document.getElementsByName("chkbx");
//alert("ok"+field);
var kj=1,i;
try{
for (i = 0; i < field; i++)
{
	
	 if(document.getElementById("chkbx"+kj).checked == true )
	 {
		 document.getElementById("chkbx"+kj).checked = false;
	 }
	 kj++;
}
}catch(e){}
}





function empname()
{
	var dept=document.getElementById("companyName1").value;
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
			var finalres=reselt.split("#");
			document.getElementById("EmpName").innerHTML=finalres[0];
		}
	}
	
	var queryString = "?dept="+dept;
	ajaxRequest.open("GET", "EmpAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 
	}

function getcheckedrow(indxtype,dept,ename,frdate,todate)
{
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
	{
			flag="success";
		}
	k++;	
	}
	if(flag == "success")
	{
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";		
		for(cnt=0;cnt<chklength.length;cnt++)
		{			
			if(document.getElementById("chkbx"+i).checked)
			{
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			}
			i++;
		}
		DeleteRow(id,indxtype,dept,ename,frdate,todate);
	}
	else
	{
		alert("Please Check Task Id ");
	}
}

function DeleteRow(id,indxtype,dept,ename,frdate,todate)
{
	var agree=confirm("Do You Want To Approve Task ?");
	    if(agree)
	    {	    	
	    	window.location="ActionApprovedTask.jsp?action=approve&id="+id+"&indxtype="+indxtype+"&dept="+dept+"&ename="+ename+"&frdate="+frdate+"&todate="+todate+"";
	    }
	    else
	    {
	    	return false;
	    }
 }

function getcheckedrow1(indxtype,dept,ename,frdate,todate)
{
	var cnt1=0,cnt2=0,k=1,flag="t",flag1="t",l=1;
	var id="";
	var chklength=document.getElementsByName("chkbx");
	for(cnt1=0;cnt1<chklength.length;cnt1++)
	{
		if( document.getElementById("chkbx"+k).checked == true )
		{
			flag="success";
		}
	k++;	
	}

	if(flag == "success")
	{
		var i=1,j,cnt=0;
		id="";
		var approvalComment="";				
		for(cnt=0;cnt<chklength.length;cnt++)
		{			
			if(document.getElementById("chkbx"+i).checked)
			{
				id=id+","+document.getElementById("net_id1"+i).innerHTML;
			}
			i++;
		}
		DeleteRow1(id,cnt,indxtype,dept,ename,frdate,todate);
	}
	else
	{
		alert("Please Check Task Id ");
	}
	
}
function DeleteRow1(id,cnt,indxtype,dept,ename,frdate,todate)
{
var userName=document.getElementById("userName").value;
	var agree=confirm("Do You Want To Reject Task ?");
	    if(agree)
	    {	    	 	    	
	    	window.location="ApprovedTask.jsp?action=reject&id="+id+"&cnt="+cnt+"&userName="+userName+"&indxtype="+indxtype+"&dept="+dept+"&ename="+ename+"&frdate="+frdate+"&todate="+todate;			
	    }
	    else
	    {
	    	return false;
	    }
 }		
	</script>


 <%@ include file="footer.jsp" %>
 </body>
</html>