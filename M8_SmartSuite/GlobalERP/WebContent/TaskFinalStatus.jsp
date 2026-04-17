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

String comid=session.getAttribute("CompanyMasterID").toString();

String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="",stp="",EmpCode1="";
String UserId="",Name="",PiK="",taskid="",taskStatus="",task_start_date="",task_end_date="",Upload="",Submit="";
String Approved="",ApprovedBy="",Desc="",task_duration="",PIID="",KRAID="";
int i = 1;
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
		stp="Select";

	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");

		stp=request.getParameter("companyName1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Task Final Status</h5>
    </div>
</div>
  <form name="AttendanceReport" id="AttendanceReport" method="post">
		    <div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>User</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="companyName1" name="companyName1">
			               <%if(bt==null){ %>
			               <option value="Select">Select</option>
       <%}
							String EmpName = "",EmpCode="";
							System.out.println("stp"+stp);
							/* 	String sql1 = "select distinct(AuthorisationStatus) as Status from db_GlobalERP."
										+ session.getAttribute("CompanyMasterID").toString()
										+ "authorisepo_det  order by AuthorisationStatus"; */
								String sql1 = "select distinct(EmpName),EmpCode from db_GlobalERP.UserMaster where companymasterid='"+comid+"' and ActiveStatus='Yes' and EmpName!='null' order by EmpName";
								System.out.println("*******" + sql1);
								ResultSet rsregno = st.executeQuery(sql1);
								while (rsregno.next()) {

									EmpName = rsregno.getString("EmpName");
									EmpCode=rsregno.getString("EmpCode");
									
						%>
						<option value="<%=EmpCode%>" <%if(EmpCode.equalsIgnoreCase(stp)){%>Selected<%}%>><%=EmpName%></option>
					
						<%
								}
						%>
                                  </select>
                            <script>
                            const mySel = document.getElementById("companyName1");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                           //  mySel.value = "Select"; // Default to "Select" if btn is null
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

 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
            <th>Id</th>
            <th>Name</th>
            <th>PI/KRA</th>				
            <th>TaskID</th>		
            <th>From</th>
            <th>To</th>
            <th>Submit</th>
            <th>Status</th>
            <th>Approved</th>
            <th>ApprovedBy</th>
            <th>Desc</th>
            <th>Duration</th>
            </tr>
        </thead> 
        <tbody>
        
  <% 
  if(bt==null)
	{
		System.out.println("----------In Button-------------");
		EmpCode1=" ";
	}else{
		
		EmpCode1=request.getParameter("companyName1");
		//String Action="onload";
	}
  
  String sql11 = "select * from db_GlobalERP.UserMaster where companymasterid='"+comid+"' and ActiveStatus='Yes' and Empcode='"+EmpCode1+"' order by EmpName";
	System.out.println("*******" + sql11);
	ResultSet rsregno1 = st1.executeQuery(sql11);
	if (rsregno1.next()) {
		PIID=rsregno1.getString("dotprojectid");
		KRAID=rsregno1.getString("KRAdotprojectid");
		Name=rsregno1.getString("EmpName");
		
	}
   
	String data12="select b.UserId as UserId,b.taskid as ID,b.taskstatus as Status,a.task_start_date as Start,a.task_end_date as End,a.task_updated_date_time as Upload,a.task_duration as Duration,b.MailDateTime as Submit,b.TaskComment  from dotproject.tasks a, db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata b where a.task_id=b.TaskID and TaskEndDate >='"+dt+" 00:00:00' and TaskEndDate <='"+dt1+" 23:59:59' and b.UserId in ('"+PIID+"','"+KRAID+"') order by b.UserID,b.taskid";
	System.out.println("*******" + data12);
	//ResultSet rsdata=st1.executeQuery(data12);
	ResultSet rsdata = st1.executeQuery(data12);
	while(rsdata.next())
	{
		UserId=rsdata.getString("UserId");
		taskid=rsdata.getString("ID");
		task_start_date=rsdata.getString("Start");
		task_start_date = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
				.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(task_start_date));
		task_end_date=rsdata.getString("End");
		task_end_date = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
				.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(task_end_date));
		
		task_duration=rsdata.getString("Duration");
		Desc=rsdata.getString("b.TaskComment");
		Submit=rsdata.getString("Submit");
		Submit = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
				.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(Submit));
		Upload=rsdata.getString("Upload");
		taskStatus=rsdata.getString("Status");
		
		Approved="-";ApprovedBy="-";
		String tasklog="select * from db_GlobalERP.dotprojectTaskLogs where task_id='"+taskid+"' order by LogDate desc limit 1";
		ResultSet rstasklog=st2.executeQuery(tasklog);
		if(rstasklog.next())
		{
			//taskStatus=rstasklog.getString("Status");
			Approved=rstasklog.getString("LogDate");
			Approved = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(Approved));
			ApprovedBy=rstasklog.getString("Approvedby");
		}
	%>
	
<tr>
               <td class="text-center"><%=i%></td>
	           <td class="text-center"><%=EmpCode1%></td>
				<td class="text-left"><%=Name %></td>
				<td class="text-center"><%=UserId %></td>
				<td class="text-center"><%=taskid%></td>
				<td class="text-right"><%=task_start_date%></td>
				<td class="text-right"><%=task_end_date%></td>
				<td class="text-right"><%=Submit %></td>
				<td class="text-left"><%=taskStatus %></td>
				<td class="text-right"><%=Approved %></td>
				<td class="text-left"><%=ApprovedBy %></td>
				<td class="text-left"><%=Desc %></td>
				<td class="text-center"><%=task_duration%></td>

<%
i++;
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
					 orientation: 'Portrait',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
		                        title: 'Task Final Status Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Task Final Status Report '+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'Portrait',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Task Final Status Report '+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Task Final Status Report '+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Task Final Status Report '+$("#data").val()+' to ' +$("#data1").val(),
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