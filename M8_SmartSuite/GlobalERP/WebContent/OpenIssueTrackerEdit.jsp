 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
 <%@ page import="java.util.Date" %>
<%@ include file="headernew.jsp" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
    
    <style>
  #Addopenissueform  select , .myinput{
        text-align: center;
        padding: 4px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid rgb(153, 149, 149);
        outline: none;
        margin-right:5px;
       	width: 205px; 
        margin-bottom: 10px;
    } 
    
    #targetclosedate{
        text-align: center;
        padding: 4px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid rgb(153, 149, 149);
        outline: none;
        margin-right: 10px;
        /* width: 250px; */
        margin-bottom: 10px;
    }
    
    #targetclosedate1{
        text-align: center;
        padding: 4px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid rgb(153, 149, 149);
        outline: none;
        margin-right: 10px;
        /* width: 250px; */
        margin-bottom: 10px;
    }
    #targetclosedate2{
        text-align: center;
        padding: 4px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid rgb(153, 149, 149);
        outline: none;
        margin-right: 10px;
        width: 250px;
        margin-bottom: 10px;
    }
    
    
     #edittargetclosedate{
        text-align: center;
        padding: 4px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid rgb(153, 149, 149);
        outline: none;
        margin-right: 10px;
       /*  width: 250px; */
        margin-bottom: 10px;
    }
    
      #Addopenissueform  .lable{
        text-align: end;
        width: 206px;
    } 

    .ui-datepicker-month, .ui-datepicker-year{
        text-align: center; 
        width: 40px;
    }

    .ui-datepicker-close{
        display: none;
    }

.popup {
    background-color: white;
    position: absolute;
    visibility: hidden;
    z-index: 9999;   /* bring popup above datatable */
    border: 1px solid #ccc;
    padding: 5px;
    white-space: nowrap; /* keep text in one line */
}
		.form-select{
		font-size:0.7rem;
		}
  </style>
</head>
<%
// Variable Declaration
String query12=""; 
int ck =1;
String datenew1="",datenew2="",deptnew="",empnamenew="",fd="",td="",status="",issuestatusnew="",checkall="";
String targetClosure="",date1 = "",date2 = "",dept = "",tDate1 = "",tDate2 = "",department="",EmpName1="",seldept="",Concern="";
String statVal="",chbxAll = "";

String type=request.getParameter("status");
System.out.println("-------->"+type);
datenew1 = request.getParameter("from_date1");
datenew2 = request.getParameter("to_date1");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");

fd = request.getParameter("from_date1");
td = request.getParameter("to_date1");
deptnew = request.getParameter("companyName1");
empnamenew = request.getParameter("EmpName");
status = request.getParameter("status");
issuestatusnew = request.getParameter("issuestatus");
checkall=request.getParameter("extAll");
String Sesrole1=session.getAttribute("role").toString();

// Connection Initialization
Connection con1 = null;
ResultSet rs=null,rsIssueRaised=null,rsPriority=null,rsSystem=null,rsActionPoint=null,rsDepartment=null,rsTaskName=null,rsStatus=null,rsOverdue=null,rsConcernPerson=null;
Statement stmt=null,stIssueRaised=null,stPriority=null,stSystem=null,stActionPoint=null,stDepartment=null,stTaskName=null,stStatus=null,stOverduedays=null,stConcernPerson=null,st_user_id=null;
Statement st = null,st1=null;

try {
	con1 = connection.getConnect("db_GlobalERP"); 
	st=con1.createStatement();
	st1=con1.createStatement();
	stmt=con1.createStatement();
	stIssueRaised=con1.createStatement();
	stPriority=con1.createStatement();
	stSystem=con1.createStatement();
	stActionPoint=con1.createStatement();
	stDepartment=con1.createStatement();
	stTaskName=con1.createStatement();
	stStatus=con1.createStatement();
	stOverduedays=con1.createStatement();
	stConcernPerson=con1.createStatement();
	st_user_id=con1.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
	if(status==null){
		
		if(datenew1==null){
		
		System.out.println("==in if==");

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
		
		datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		
		if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
		{
			tDate1 = datenew1;
			tDate2 = datenew2;
		}
		else
		{
		tDate1 = datenew1;
		tDate2 = datenew2;
		}
		
	}
	else{
	System.out.println("==in else==");
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
	}

	}else{
		System.out.println("in status else :-"+fd+"   "+td);

		datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fd));

		datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(td));	
		
		
		
		tDate1=fd;
		tDate2=td;	
		
	}

	System.out.println("Date1 :-"+tDate1);
	System.out.println("Date2 :-"+tDate2);


	DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
	String dataDate1=df1234.format(df123.parse(datenew1));
	String dataDate2=df1234.format(df123.parse(datenew2));


	String name=session.getAttribute("EmpName").toString();
	String sessiondept=session.getAttribute("department").toString();
	dept = session.getAttribute("department").toString();
	
	
	

%>
 <body style="background-color:azure;">
 <input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Open Issue Tracker Report</h5>
    </div>
</div>

<form name="openissuereport" id="openissuereport" method="post">
		    <div class="row col-12" id="ext_row">     
             <div class="col-md-2 ms-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" name="companyName1" id="companyName1" onchange="consig();">
                          
         <%	String Bt1=request.getParameter("button");
  		

				           /* 	String Bt1=request.getParameter("button2"); */
					  		
				           if(status==null){

				          System.out.println("-INNNNNNNNNNNN-------------"+Bt1);
				          if(Bt1==null || Bt1=="null" || Bt1.equals("null"))
				        	  {  
				        
				        	  
				        	  %>

				                        <option value="Select">Select</option>
				          
				          <%if(Sesrole1.equals("AllAdmin")) {
				           %>
				           <option value="All">All</option>
				          
				            
				            <%} 
				            else
				            {%>
				<%--             <option value="<%=sessiondept%>"><%=sessiondept%></option>
				 --%>            <%} %>
				            <%
				            
				        		 
				        	  }
				            else 
				            {
				            System.out.println("INNN Elseeeeeeeee");
				            seldept=request.getParameter("companyName1"); 
				    	    System.out.println("******seldept*"+seldept);
				    	    if(Sesrole1.equals("AllAdmin")) {
				           %>
				            
				             <option value="<%=seldept%>"><%=seldept%></option>
				                        <option value="All">All</option>
				             
				             <%} 
				            else
				            {%>
				            <option value="<%=seldept%>"><%=seldept%></option>
				            <%}  } 
				            
				            
				           }else{
				        	   if(Sesrole1.equals("AllAdmin")) {
				                   %>
				                    
				               <option value="<%=deptnew%>"><%=deptnew%></option>
				                                <option value="All">All</option>
				                     
				                     <%} 
				                    else
				                    {%>
				               <option value="<%=deptnew%>"><%=deptnew%></option>
				                    <%} 
				        	   
				        	   
				        	   
				        	   %>

				   <%     	   
				           }
				            
				            %>
				          
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
							// customer=customer.replaceAll("&", "*");
							 //customer=customer.replaceAll("&", "*");
							 
							 System.out.println("department-->"+department);
							%>
							
							<option value="<%=department%>"><%=department%></option>
					         <%
					        // customer=customer.replaceAll("&", "..");
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
				
             <div class="col-md-2">
				  <label for="dropdown"><b>Name</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" id="EmpName" name="EmpName">
						<%	String Bt2=request.getParameter("button");
  		

						  /* 	String Bt2=request.getParameter("button2"); */
					  		
							if(status==null){

				          System.out.println("-INNNNNNNNNNNN-------------"+Bt2);
				          if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
				        	  {
				     
				          }
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
				            <%}  } 
				            
				            }else{
				            	 if(Sesrole1.equals("AllAdmin")) {
				           %>
				            
				             <option value="<%=empnamenew%>"><%=empnamenew%></option>
				                        <option value="All">All</option>
				             
				             <%} 
				            else
				            {%>
				            <option value="<%=empnamenew%>"><%=empnamenew%></option>
				            <%}  
				            }%>
            
						</select>
					</div>
			</div>
			
			             <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" name="issuestatus" id="issuestatus" >
						<%
						if(status==null){
							
						  if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
			        	  {
							%>  <option value="All">All</option>
								<option value="Open">Open</option>
								<option value="Close">Close</option>
								<option value="WIP">WIP</option>
								<option value="Reject">Reject</option>
								<option value="Hang">Hang</option>	
			          <%}
			            else 
			            {
			            	String issuestatus1=request.getParameter("issuestatus");
			            	%>
			            				            	
			            	<option value="All" <% if(issuestatus1.equalsIgnoreCase("All")){ %> Selected <%}%>>All</option>
							<option value="Open" <% if(issuestatus1.equalsIgnoreCase("Open")){ %> Selected <%}%>>Open</option>
							<option value="Close" <% if(issuestatus1.equalsIgnoreCase("Close")){ %> Selected <%}%>>Close</option>
							<option value="WIP" <% if(issuestatus1.equalsIgnoreCase("WIP")){ %> Selected <%}%>>WIP</option>
							<option value="Reject" <% if(issuestatus1.equalsIgnoreCase("Reject")){ %> Selected <%}%>>Reject</option>
							<option value="Hang" <% if(issuestatus1.equalsIgnoreCase("Hang")){ %> Selected <%}%>>Hang</option>			
						
						<% 
			            }
						}
						else{ %>
						
						<option value="All" <% if(issuestatusnew.equalsIgnoreCase("All")){ %> Selected <%}%>>All</option>
						<option value="Open" <% if(issuestatusnew.equalsIgnoreCase("Open")){ %> Selected <%}%>>Open</option>
						<option value="Close" <% if(issuestatusnew.equalsIgnoreCase("Close")){ %> Selected <%}%>>Close</option>
						<option value="WIP" <% if(issuestatusnew.equalsIgnoreCase("WIP")){ %> Selected <%}%>>WIP</option>
						<option value="Reject" <% if(issuestatusnew.equalsIgnoreCase("Reject")){ %> Selected <%}%>>Reject</option>
						<option value="Hang" <% if(issuestatusnew.equalsIgnoreCase("Hang")){ %> Selected <%}%>>Hang</option>			
					
						<%} %>						
						</select>
						</div>
						</div>
			
						
			 <div class="col-md-1" style="width:3%;">
				<label class="form-check-label" for="all"><b>All</b></label>
					<div class="form-check">
					<%if(status==null){
						  if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
			        	  {
							%> 
							<input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="yes" onclick="allSelected(this.value);"> 			        
			          <%}
			            else 
			            {
                         if(checkall==null){
								%>
								<input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="yes" onclick="allSelected(this.value);">
								
								<%	
							}else{
								%>
								<input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="yes" onclick="allSelected(this.value);">
						<% 	}
			          }
						}else{
							if(checkall.equalsIgnoreCase("yes")){
								%>
								<input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="yes" onclick="allSelected(this.value);">
								<%	
							}else{
								%>
								<input class="form-check-input" type="checkbox" name="extAll" id="extAll" value="yes" onclick="allSelected(this.value);">
						<% 	}
				
						} %>	
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
     			   button      : "trigger"       // ID of the button
     	        } );
</script>

<%

String companyName1=request.getParameter("companyName1");
System.out.println("department value"+companyName1);
String empname = request.getParameter("EmpName");
%>
 <form name="checkboxform" method="post" action="CloseMultiOpenIssue.jsp">
	<div class="row col-12 mt-4 mb-2">
    <div class="col-md-2" style="width:15%;">
        <button type="button" class="btn btn-primary" id="button" name="button" data-bs-toggle="modal" data-bs-target="#addMyModal">
            Add Open Issue
        </button>
    </div>
    <div class="col-md-2">
            <input type="submit" id="button" name="button" value="Close All" class="btn btn-primary" style="width:125px;" />
    </div>
</div>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
			<th>  
			<a href="#" onclick="checkAll()">
    			<font color="white">Chk &nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;</font>
  			</a>
  			<a href="#" onclick="unCheckAll()">
   	 		<font color="white">UnChk</font>
 			 </a>
 			 </th>
			<td><b>Issue ID</b></td>
			<td style="display: none;"><b>Issue ID</b></td>  <!--dummy compID id for export button only -->
			<td><b>Complaint ID</b></td> 
			<th>Reported</th>
			<th>Customer Type</th>
			<th>Issue Raised By</th>
			<th>Customer Name</th>
			<th>Priority</th>
			<th>System</th>
			<th>Action Point</th>
			<th>Open Issue</th>
			<th><div style="width:200px;">Description</div></th>
			<th>Target Closure</th>
			<th>Target</th>
			<th>Department</th>
			<th>Concern Person</th>
			<th>Task Type</th>
			<th>Closure</th>
			<th>Status</th>
			<th>Overdue Days</th>
            
            </tr>
        </thead> 
        <tbody>
   
<%
String Issue_Id="";
String ComplaintID="";
String ReportedDate="";
String CustomerType ="";
String IssueRaisedBy ="";
String CustomerName ="";
String Priority ="";
String SystemName ="";
String ActionPoint ="";
String OpenIssue  ="";
String Description ="";
String TargetClosureDate ="";
String TargetDate ="";
String Department ="";
String TaskType ="";
String ClosureDate ="";
String Status ="";
String OverdueDays="";
String ReportedDateNew="",TargetClosureDateNew="",TargetDateNew="",ClosureDateNew="";
String sqlConcernPerson="";
String sqlOpenIssue="";
String Bt=request.getParameter("button");
String name13="",a="('",b="')";


if(status==null){
if(Bt==null || Bt=="null" || Bt.equals("null"))
	{
	
	}

else{
	
	 name13 = request.getParameter("EmpName");
     System.out.println("name13..."+name13); 
     
      if(name13.equalsIgnoreCase("All")){
    	 
    	 System.out.println("in if name13");

    	 name13=session.getAttribute("ContactPersonList").toString();
    	
    	 name13 = name13.replaceFirst(",","");
    	 
    	 name13 = name13.replaceAll(",","','");
    	 
    	
     }
      
      name13=a+name13+b;

 	 System.out.println("emp list....."+name13);
 
	 statVal = request.getParameter("issuestatus");
	 chbxAll = request.getParameter("extAll");
	if (statVal == null || statVal.equalsIgnoreCase("null")) {
		statVal = "All";
	}
	System.out.println("statVal=" + statVal);
	 System.out.println("statVal...."+statVal+"chbxAll...."+chbxAll);

	if (chbxAll != null && chbxAll != "") {
		if (statVal == "All" || statVal.equals("All")) {
	         sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" ";

		} else {
	         sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and Status='"+statVal+"'";

		}
	}  else {
		
		 System.out.println("inside not null first....");

		if (statVal == "All" || statVal.equals("All")) {
	        sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and ReportedDate>='"+dataDate1+"' and ReportedDate<='"+dataDate2+"'";

		} else {
	        sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and Status='"+statVal+"' and ReportedDate>='"+dataDate1+"' and ReportedDate<='"+dataDate2+"'";

		}

	}

  

		
System.out.println("Query is : "+sqlOpenIssue);
 
 rs = st1.executeQuery(sqlOpenIssue);

		      int i=1;
		     
		      while(rs.next()){
		    
		    	  Issue_Id=rs.getString("Issue_SR_Id");
		    	  //System.out.println("Issue_Id is : "+Issue_Id);
		    	  
		    	  ComplaintID=rs.getString("ComplaintID");
		    	  
		    	  if(ComplaintID==null || ComplaintID.contains(" ")){
		    		  ComplaintID="-";	  
			    	 }
		    	  else{
			    	  ComplaintID=rs.getString("ComplaintID");

		    	  }
		    	  ReportedDate=rs.getString("ReportedDate");
		    	  if(ReportedDate =="-" || ReportedDate.equalsIgnoreCase("-")){
		    		  ReportedDateNew ="-";
			    		 
			    	 }else{
					    	 ReportedDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ReportedDate));
			    	 }
		    	  
		    	  CustomerType=rs.getString("CustomerType");
		    	  IssueRaisedBy=rs.getString("IssueRaisedBy");
		    	  CustomerName=rs.getString("CustomerName");
		    	  Priority=rs.getString("Priority");
		    	  SystemName=rs.getString("SystemName");
		    	  ActionPoint=rs.getString("ActionPoint");
		    	  OpenIssue=rs.getString("OpenIssue");
		    	  Description=rs.getString("Description");
		     //     String Description1 = Description.replaceAll("\n", "");
		          String Description1 = Description.replaceAll("\\r?\\n", " ");
		          Description1= Description1.replaceAll("'", "");
		          Description1= Description1.replaceAll("\"", "");
		          Description1= Description1.replaceAll("&", " ");

				     System.out.println("Description1== "+Description1);

		    	  TargetClosureDate=rs.getString("TargetClosureDate");
		    	 // System.out.println("Target date== "+TargetClosureDate);
		    	 if(TargetClosureDate =="-" || TargetClosureDate.equalsIgnoreCase("-")){
		    		 TargetClosureDate ="-";
		    		 
		    	 }else{
			    	 TargetClosureDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetClosureDate));
		    	 }
		    			  
		    	 
		    	  TargetDate=rs.getString("TargetDate");
			     System.out.println("Target date== "+TargetDate);

		    	  if(TargetDate.equals("-")){
					     System.out.println("Target date New== if");
 
		    		  TargetDateNew="-";
		    	  }
		    	  else{
					     System.out.println("Target date New== else");

		    	TargetDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetDate));
		    	  }
				     System.out.println("Target date New== "+TargetDateNew);

		    	  
		    	  Department=rs.getString("Department");
		    	  Concern=rs.getString("Concern");
		    	  TaskType=rs.getString("TaskType");
		    	  ClosureDate=rs.getString("ClosureDate");
		    	  
		    	  if(ClosureDate.equals("-")){

		    		  ClosureDateNew="-";
		    	  }else{
		    		  
				    	 ClosureDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ClosureDate));

		    	  }
		    	  Status=rs.getString("Status");
		    	  
		    	  
		    	  String sqlOverduedays="SELECT DATEDIFF(current_date, TargetClosureDate) as OverdueDays,Status FROM db_GlobalERP.100000OpenIssueTracker where  Status != 'Close' and Issue_SR_Id='"+Issue_Id+"'";
				     System.out.println("sqlOverduedays== "+sqlOverduedays);

		    	  rsOverdue = stOverduedays.executeQuery(sqlOverduedays);
		    	  
		    	 if(rsOverdue.next()){
		    	  OverdueDays=rsOverdue.getString("OverdueDays");	
				     System.out.println("OverdueDays== "+OverdueDays);

		    	 }
		    	 if(Status.equalsIgnoreCase("Close")) {
			    	  OverdueDays="-";	  
			    	 }
		    	 if(OverdueDays==null || OverdueDays.contains(" ")){
			    	  OverdueDays="-";	  
			    	 }
		    	 
			     System.out.println("OverdueDays== "+OverdueDays);

       %>

<tr>
<td class="text-center"><%=i%></td>


<td class="text-right">
<input type="checkbox" name="Issue_SR_Id" value="<%=Issue_Id%>" class="chkbx" />
    <div align="right">
        <input type="text" id="net_id1<%=ck %>" name="net_id1<%=ck %>" style="display:none; width:70px; padding: 4px 5px 2px 5px; border:none; text-align:right; font: normal 11px Arial, Helvetica, sans-serif;" value="<%=ck %>" readonly/>
    </div>
</td>
<td class="text-right">
                    <div align="right">
	                    <a href="#" onmouseover="showMenu(<%=i%>,true);" onmouseout="hideMenu(<%=i%>,true);"><%=Issue_Id%>
                    <div class="popup" id="popup<%=i%>">
						<table border="1" cellpedding=4 class=mytable onmouseover="showMenu(<%=i%>,true);" onmouseout="hideMenu(<%=i%>,true);">
					        <tr style="width: 10px"><td><a href="#" data-bs-toggle="modal" data-bs-target="#editModel" onclick="return demo('<%=Issue_Id%>','<%=ComplaintID%>','<%=ReportedDateNew%>','<%=CustomerType%>','<%=IssueRaisedBy%>','<%=CustomerName%>','<%=Priority%>','<%=SystemName%>','<%=ActionPoint%>','<%=OpenIssue%>','<%=Description1%>','<%=TargetClosureDate%>','<%=TargetDateNew%>','<%=Department%>','<%=Concern%>','<%=TaskType%>','<%=ClosureDateNew%>','<%=Status%>'),toggleDetails(<%=i%>,false);">Edit</a></td></tr>
					        <% if(!Status.equalsIgnoreCase("Close")) {%><tr style="width: 10px"><td><a href="CloseOpenIssue.jsp?issueid=<%=Issue_Id%>&ReportedDate=<%=ReportedDate%>&dept=<%=department%>&name=<%=empname%>&issuestatus=<%=statVal%>&checkall=<%=chbxAll%>&fd=<%=dataDate1%>&td=<%=dataDate2%>" onclick="return IssueClose(<%=Issue_Id%>),toggleDetails(<%=i%>,false);">Close</a></td></tr>
						<%} %>
						</table>
				    </div>
				    </a>
				    </div>
</td>

<td style="display: none;"><%=Issue_Id%></td>
<td class="text-center"><%=ComplaintID%></td>
<td class="text-right"><%=ReportedDateNew%></td>
<td class="text-left"><%=CustomerType%></td>
<td class="text-left"><%=IssueRaisedBy%></td>
<td class="text-left"><%=CustomerName%></td>
<td class="text-left"><%=Priority%></td>
<td class="text-left"><%=SystemName%></td>
<td class="text-left"><%=ActionPoint%></td>
<td class="text-left"><%=OpenIssue%></td>
<td class="text-left"><div style="width:200px;"><%=Description%></div></td>
<td class="text-right"><%=TargetClosureDate%></td>
<td class="text-right"><%=TargetDateNew%></td>
<td class="text-left"><%=Department%></td>
<td class="text-left"><%=Concern%></td>
<td class="text-left"><%=TaskType%></td>
<td class="text-right"><%=ClosureDateNew%></td>
<td class="text-left"><%=Status%></td>
<td class="text-center"><%=OverdueDays%></td>	

     
</tr>
<%
     i++;	
ck++;
         }
		      
		    }
}else{
	
	 name13 = request.getParameter("EmpName");
    System.out.println("name13..."+name13); 
    
     if(name13.equalsIgnoreCase("All")){
   	 
   	 System.out.println("in if name13");

   	 name13=session.getAttribute("ContactPersonList").toString();
   	
   	 name13 = name13.replaceFirst(",","");
   	 
   	 name13 = name13.replaceAll(",","','");
   	 
   	
    }
     
     name13=a+name13+b;

	 System.out.println("emp list....."+name13);

	 statVal = request.getParameter("issuestatus");
	 chbxAll = request.getParameter("extAll");
	 
	 
	 System.out.println("statVal...."+statVal+"chbxAll...."+chbxAll);

	
		if ( !(chbxAll.equalsIgnoreCase("null"))) {

		if (statVal == "All" || statVal.equals("All")) {
	         sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" ";

		} else {
	         sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and Status='"+statVal+"'";

		}
	}  else {
		
		 System.out.println("inside not null ####################################....");

		if (statVal == "All" || statVal.equals("All")) {
	        sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and ReportedDate>='"+dataDate1+"' and ReportedDate<='"+dataDate2+"'";

		} else {
	        sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and Status='"+statVal+"' and ReportedDate>='"+dataDate1+"' and ReportedDate<='"+dataDate2+"'";
		}

	}

 

		
System.out.println("Query is : "+sqlOpenIssue);

rs = st1.executeQuery(sqlOpenIssue);

		      int i=1;
		      while(rs.next()){
		    
		    	  Issue_Id=rs.getString("Issue_SR_Id");
		    	  //System.out.println("Issue_Id is : "+Issue_Id);
		    	  
		    	  ComplaintID=rs.getString("ComplaintID");
		    	  
		    	  if(ComplaintID==null || ComplaintID.contains(" ")){
		    		  ComplaintID="-";	  
			    	 }
		    	  else{
			    	  ComplaintID=rs.getString("ComplaintID");

		    	  }
		    	  ReportedDate=rs.getString("ReportedDate");
		    	  if(ReportedDate =="-" || ReportedDate.equalsIgnoreCase("-")){
		    		  ReportedDateNew ="-";
			    		 
			    	 }else{
					    	 ReportedDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ReportedDate));
			    	 }
		    	
		    	  
		    	  CustomerType=rs.getString("CustomerType");
		    	  IssueRaisedBy=rs.getString("IssueRaisedBy");
		    	  CustomerName=rs.getString("CustomerName");
		    	  Priority=rs.getString("Priority");
		    	  SystemName=rs.getString("SystemName");
		    	  ActionPoint=rs.getString("ActionPoint");
		    	  OpenIssue=rs.getString("OpenIssue");
		    	  Description=rs.getString("Description");
		     //     String Description1 = Description.replaceAll("\n", "");
		          String Description1 = Description.replaceAll("\\r?\\n", " ");
		          Description1= Description1.replaceAll("'", "");
		          Description1= Description1.replaceAll("\"", "");
		          Description1= Description1.replaceAll("&", " ");

				     System.out.println("Description1== "+Description1);

		    	  TargetClosureDate=rs.getString("TargetClosureDate");
		    	 // System.out.println("Target date== "+TargetClosureDate);
		    	 if(TargetClosureDate =="-" || TargetClosureDate.equalsIgnoreCase("-")){
		    		 TargetClosureDate ="-";
		    		 
		    	 }else{
			    	 TargetClosureDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetClosureDate));
		    	 }
		    			  
		    	 
		    	  TargetDate=rs.getString("TargetDate");
			     System.out.println("Target date== "+TargetDate);

		    	  if(TargetDate.equals("-")){
					     System.out.println("Target date New== if");

		    		  TargetDateNew="-";
		    	  }
		    	  else{
					     System.out.println("Target date New== else");

		    	TargetDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetDate));
		    	  }
				     System.out.println("Target date New== "+TargetDateNew);

		    	  
		    	  Department=rs.getString("Department");
		    	  Concern=rs.getString("Concern");
		    	  TaskType=rs.getString("TaskType");
		    	  ClosureDate=rs.getString("ClosureDate");
		    	  
		    	  if(ClosureDate.equals("-")){

		    		  ClosureDateNew="-";
		    	  }else{
		    		  
				    	 ClosureDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ClosureDate));

		    	  }
		    	  Status=rs.getString("Status");
		    	  
		    	  
		    	  String sqlOverduedays="SELECT DATEDIFF(current_date, TargetClosureDate) as OverdueDays,Status FROM db_GlobalERP.100000OpenIssueTracker where  Status != 'Close' and Issue_SR_Id='"+Issue_Id+"'";
				     System.out.println("sqlOverduedays== "+sqlOverduedays);

		    	  rsOverdue = stOverduedays.executeQuery(sqlOverduedays);
		    	  
		    	 if(rsOverdue.next()){
		    	  OverdueDays=rsOverdue.getString("OverdueDays");	
				     System.out.println("OverdueDays== "+OverdueDays);

		    	 }
		    	 if(Status.equalsIgnoreCase("Close")) {
			    	  OverdueDays="-";	  
			    	 }
		    	 if(OverdueDays==null || OverdueDays.contains(" ")){
			    	  OverdueDays="-";	  
			    	 }
		    	 
			     System.out.println("OverdueDays== "+OverdueDays);

      %>


<tr>
<td class="text-center"><%=i%></td>


<td class="text-right">
<input type="checkbox" name="Issue_SR_Id" value="<%=Issue_Id%>" class="chkbx" />
    <div align="right">
        <input type="text" id="net_id1<%=ck %>" name="net_id1<%=ck %>" style="display:none; width:70px; padding: 4px 5px 2px 5px; border:none; text-align:right; font: normal 11px Arial, Helvetica, sans-serif;" value="<%=ck %>" readonly/>
    </div>
</td>
<td class="text-right">
  <div align="right">
	                    <a href="#" onmouseover="showMenu(<%=i%>,true);" onmouseout="hideMenu(<%=i%>,true);"><%=Issue_Id%>
                   <div class="popup" id="popup<%=i%>">
						<table border="1" cellpedding=4 class=mytable onmouseover="showMenu(<%=i%>,true);" onmouseout="hideMenu(<%=i%>,true);">
					        <tr style="width: 10px"><td><a href="#" data-toggle="modal" data-target="#editModel" onclick="return demo('<%=Issue_Id%>','<%=ComplaintID%>','<%=ReportedDateNew%>','<%=CustomerType%>','<%=IssueRaisedBy%>','<%=CustomerName%>','<%=Priority%>','<%=SystemName%>','<%=ActionPoint%>','<%=OpenIssue%>','<%=Description1%>','<%=TargetClosureDate%>','<%=TargetDateNew%>','<%=Department%>','<%=Concern%>','<%=TaskType%>','<%=ClosureDateNew%>','<%=Status%>'),toggleDetails(<%=i%>,false);">Edit</a></td></tr>
					        <tr style="width: 10px"><td><a href="CloseOpenIssue.jsp?issueid=<%=Issue_Id%>&ReportedDate=<%=ReportedDate%>&dept=<%=department%>&name=<%=empname%>&issuestatus=<%=statVal%>&checkall=<%=chbxAll%>&fd=<%=dataDate1%>&td=<%=dataDate2%>" onclick="return IssueClose(<%=Issue_Id%>),toggleDetails(<%=i%>,false);">Close</a></td></tr>
						</table>
				    </div>
				    </a>
				    </div>



</td>

<td style="display: none;"><%=Issue_Id%></td>
<td class="text-center"><%=ComplaintID%></td>
<td class="text-right"><%=ReportedDateNew%></td>
<td class="text-left"><%=CustomerType%></td>
<td class="text-left"><%=IssueRaisedBy%></td>
<td class="text-left"><%=CustomerName%></td>
<td class="text-left"><%=Priority%></td>
<td class="text-left"><%=SystemName%></td>
<td class="text-left"><%=ActionPoint%></td>
<td class="text-left"><%=OpenIssue%></td>
<td class="text-left"><div style="width:200px;"><%=Description%></div></td>
<td class="text-right"><%=TargetClosureDate%></td>
<td class="text-right"><%=TargetDateNew%></td>
<td class="text-left"><%=Department%></td>
<td class="text-left"><%=Concern%></td>
<td class="text-left"><%=TaskType%></td>
<td class="text-right"><%=ClosureDateNew%></td>
<td class="text-left"><%=Status%></td>
<td class="text-center"><%=OverdueDays%></td>

     
</tr>
<%
    i++;
ck++;
        }
		      
		    }
%>  
      
        </tbody>
 </table>
 	    <input type="hidden" name="ReportedDate" value="<%=ReportedDate%>">
	    <input type="hidden" name="dept" value="<%=dept%>">
	    <input type="hidden" name="name" value="<%=name%>">
        <input type="hidden" id="dept" name="dept" value="<%=department%>"></input>
		<input type="hidden" id="ename" name="ename" value="<%=empname%>"></input>
		<input type="hidden" id="issuestatus" name="issuestatus" value="<%=statVal%>"></input>
		<input type="hidden" id="chbk" name="chbk" value="<%=chbxAll%>"></input>
		<input type="hidden" id="fd" name="fd" value="<%=dataDate1%>"></input>
		<input type="hidden" id="td" name="td" value="<%=dataDate2%>"></input>
 
 
 </form>
 </div>
<!-- Add Open Issue Modal popup Start -->
<div class="modal fade" id="addMyModal" tabindex="-1" aria-labelledby="#addMyModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
        <form class="form-inline" id="Addopenissueform" action="OpenIssueTrackerAction.jsp" onsubmit="return validation();">
    
       <div class="modal-body">
              <h4 class="text-center" id ="addMyModal" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Open Issue Tracker</b></h4>
       
      <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Customer/Internal:</b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select " id="customeInternal" name="customeInternal" onchange="gtcust()">
								<option selected>Choose</option>
								<option value="Customer">Customer</option>
								<option value="Internal">Internal</option>
							</select>
                           
		                </div>
			</div>		
			<div class="col-md-2"></div>		
      </div>
            <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Issue Raised By: </b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="issueraisedby" name="issueraisedby">
                             <option selected>Choose</option>
								<%String sqlIssueRaised="select IsuueRaisedBy from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"IsuueRaisedByMaster";
								rsIssueRaised=stIssueRaised.executeQuery(sqlIssueRaised);
								while(rsIssueRaised.next())
								{
								%>
								<option value="<%=rsIssueRaised.getString("IsuueRaisedBy")%>"><%=rsIssueRaised.getString("IsuueRaisedBy")%></option>
								<%} %>	
                           </select>
                           
		                </div>
			</div>		
<div class="col-md-2"></div>
      </div>
            <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Customer Name:</b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="customername" name="customername">
                              <%
								String customername=request.getParameter("customername");
						if(customername!=null)
						{
							%>
							<option value="<%=customername%>" selected><%=customername%></option>
							<%
							} 
						%>	
                           </select>
                           
		                </div>
			</div>		
<div class="col-md-2"></div>		
      </div>
      
            <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Priority: </b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="priority" name="priority">
                             <%
							   String sqlPriority="select PriorityName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PriorityMaster";
							   rsPriority=stPriority.executeQuery(sqlPriority);
							   while(rsPriority.next())
							   {
						    %>
						      <option value="<%=rsPriority.getString("PriorityName")%>"><%=rsPriority.getString("PriorityName")%></option>
						   
							<% } %>	
                           </select>
                           
		                </div>
			</div>		
			<div class="col-md-2"></div>		
      </div>
      
      
            <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>System:</b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="system" name="system">
                             <%
							  String sqlSystem="select SystemName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"SystemMaster";
							   rsSystem=stSystem.executeQuery(sqlSystem);
							   while(rsSystem.next())
							   {
							%>
					           <option value="<%=rsSystem.getString("SystemName")%>"><%=rsSystem.getString("SystemName")%></option>
							 <%
							   }
							 %>	
                           </select>
                           
		                </div>
			</div>		
			<div class="col-md-2"></div>		
      </div>
      
            <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Action Point:</b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="actionpoint" name="actionpoint">
                             <option selected>Choose Action Point</option>
								<%
								  String sqlActionPoint="select ActionName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ActionPointMaster";
								  rsActionPoint=stActionPoint.executeQuery(sqlActionPoint);
								  while(rsActionPoint.next())
								  {
								%>
							    <option value="<%=rsActionPoint.getString("ActionName")%>"><%=rsActionPoint.getString("ActionName")%></option>
								<%
							   }
							  %>
                           </select>
                           
		                </div>
			</div>		
			<div class="col-md-2"></div>		
      </div>
      
      <div class="row mt-3">
  <div class="col-md-4">
    <label for="Department">
      <b><font color="red" size="2">*</font> Open Issue - Report Name:</b>
    </label>
  </div>
  <div class="col-md-6">
    <input type="text" class="form-control" id="reportname" name="reportname" placeholder="Add Report Name" style="border: 1px solid #ced4da;">
  </div>
  <div class="col-md-2"></div>
</div>
      
      
      
      <div class="row mt-3">
 <div class="col-md-4">				  
   <label for="dropdown"><b><font color="red" size="2">*</font>Description:</b></label>
      </div>
   <div class="col-md-6">  
   <textarea class="form-control" id="description" name="description" placeholder="Add Description Related Your Task....."></textarea>

</div>
      			<div class="col-md-2"></div>		
      
      </div>
            <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Target Closure:</b></label>
      </div>
   <div class="col-md-6">  
   <input type="date" class="form-control" id="targetclosedate" name="targetclosedate" placeholder="Add Description Related Your Task....." style="border: 1px solid #ced4da;"></input>
<script>
								$(function() {
									$("#targetclosedate").datepicker();
									$("#targetclosedate").datepicker('setDate', 'today');
									$( "#targetclosedate" ).datepicker( "option", "dateFormat", "dd-mm-yy" );
									 $('#targetclosedate').datepicker({
									        minDate: 0,
									    });
								});
							</script>
</div>	
			<div class="col-md-2"></div>		
      </div>
      
      
      <div class="row mt-2">
      <div class="col-md-4">				  
      <label for="dropdown"><b><font color="red" size="2">*</font>Department</b></label>
      </div>
   <div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="Department" name="Department" onchange="concernpersonName();">
                            <option value="Select Department">Select Department</option>
								
								<option value="All">All</option>
								<%String sqlDepartment="select DepartmentName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"DepartmentMaster";
								rsDepartment=stDepartment.executeQuery(sqlDepartment);
								while(rsDepartment.next())
								{
								%>
								<option value="<%=rsDepartment.getString("DepartmentName")%>"><%=rsDepartment.getString("DepartmentName")%></option>
								<%} %>	
                           </select>
                           
		                </div>
			</div>		
			<div class="col-md-2"></div>		
      </div>
       
      
      <div class="row mt-3">
 <div class="col-md-4">				  
   <label for="dropdown"><b><font color="red" size="2">*</font>Concern Person :</b></label>
      </div>
<div class="col-md-6">
						<div class="input-group input-group-merge">
					       <select class="form-select" id="concernperson" name="concernperson">
                            <%
									String person=request.getParameter("concernperson");
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
			</div>
      			<div class="col-md-2"></div>		
      
      </div>
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="submit" id="submit" class="btn btn-primary btn-sm">Submit</button>
        
        

      </div>
      
        <input type="hidden" id="dept" name="dept" value="<%=companyName1%>"></input>
		<input type="hidden" id="ename" name="ename" value="<%=empname%>"></input>
		<input type="hidden" id="issuestatus" name="issuestatus" value="<%=statVal%>"></input>
		<input type="hidden" id="chbk" name="chbk" value="<%=chbxAll%>"></input>
		<input type="hidden" id="fd" name="fd" value="<%=dataDate1%>"></input>
		<input type="hidden" id="td" name="td" value="<%=dataDate2%>"></input>
		<input type="hidden" name="fd" value="<%=fd%>">
    	<input type="hidden" name="td" value="<%=td%>">
      </form>
    </div>

  </div>
</div>

<!--edit modal pop up   -->
 
 <div class="modal fade" id="editModel" tabindex="-1" aria-labelledby="#editModel" aria-hidden="true" style="width: 90%;">
  <div class="modal-dialog">
    <div class="modal-content" id="content"  style=" width: 700px;">
        <form class="form-inline" id="Addopenissueform" name="Addopenissueform" action="OpenIssueTrackerEditAction.jsp" onsubmit="return Editvalidation();">
       <div class="modal-body" >       
              <h4 class="text-center" id ="editModel"><b>Edit Open Issue Tracker</b></h4>
       
          <div class="row mt-3">

  <!-- Issue ID -->
  <div class="col-md-4">
    <label for="editissueid">
      <b><font color="red" size="2">*</font>Issue ID</b>
    </label>
    <input type="text" class="form-control" id="editissueid" name="editissueid"
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

  <!-- Complaint ID -->
  <div class="col-md-4">
    <label for="complaintid">
      <b><font color="red" size="2">*</font>Complaint ID:</b>
    </label>
    <input type="text" class="form-control" id="complaintid" name="complaintid"
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

  <!-- Reported Date -->
  <div class="col-md-4">
    <label for="editreportdate">
      <b><font color="red" size="2">*</font>Reported Date:</b>
    </label>
    <input type="text" class="form-control" id="editreportdate" name="editreportdate"
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

</div>


       
<div class="row mt-3">

  <!-- Customer/Internal -->
  <div class="col-md-4">
    <label for="editcustomer">
      <b><font color="red" size="2">*</font>Customer/Internal:</b>
    </label>
    <input type="text" class="form-control" id="editcustomer" name="editcustomer" 
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

  <!-- Issue Raised By -->
  <div class="col-md-4">
    <label for="editissueraisedby"><b>Issue Raised By:</b></label>
    <input type="text" class="form-control" id="editissueraisedby" name="editissueraisedby" 
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

  <!-- Customer Name -->
  <div class="col-md-4">
    <label for="editcustomername"><b>Customer Name:</b></label>
    <input type="text" class="form-control" id="editcustomername" name="editcustomername" 
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

</div>


    <div class="row mt-3">

  <!-- Priority -->
  <div class="col-md-4">
    <label for="editpriority">
      <b><font color="red" size="2">*</font>Priority:</b>
    </label>
    <select class="form-select" id="editpriority" name="editpriority" style="font-size: 12px;">
      <option selected>Choose</option>
      <%
        String sqlPriority1 = "select PriorityName from db_GlobalERP."
                            + session.getAttribute("CompanyMasterID").toString() 
                            + "PriorityMaster";
        rsPriority = stPriority.executeQuery(sqlPriority1);
        while(rsPriority.next()) {
      %>
        <option value="<%=rsPriority.getString("PriorityName")%>">
          <%=rsPriority.getString("PriorityName")%>
        </option>
      <% } %>
    </select>
  </div>

  <!-- System -->
  <div class="col-md-4">
    <label for="editsystem">
      <b><font color="red" size="2">*</font>System:</b>
    </label>
    <input type="text" class="form-control" id="editsystem" name="editsystem"
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

  <!-- Action Point -->
  <div class="col-md-4">
    <label for="editactionpoint">
      <b><font color="red" size="2">*</font>Action Point:</b>
    </label>
    <select class="custom-select" id="editactionpoint" name="editactionpoint" style="width: 205px;font-size: 12px;">
      <option selected>Choose</option>
      <%
        String sqlActionPoint1 = "select ActionName from db_GlobalERP."
                               + session.getAttribute("CompanyMasterID").toString()
                               + "ActionPointMaster";
        rsActionPoint = stActionPoint.executeQuery(sqlActionPoint1);
        while(rsActionPoint.next()) {
      %>
        <option value="<%=rsActionPoint.getString("ActionName")%>">
          <%=rsActionPoint.getString("ActionName")%>
        </option>
      <% } %>
    </select>
  </div>








</div>


<div class="row mt-3">

  <!-- Open Issue - Report Name -->
  <div class="col-md-4">
    <label for="editreportname">
      <b><font color="red" size="2">*</font>Open Issue - Report Name:</b>
    </label>
    <input type="text" class="form-control" id="editreportname" name="editreportname"
           value="" readonly="readonly" style="border: 1px solid #ced4da;">
  </div>

  <!-- Description -->
  <div class="col-md-4">
    <label for="editdescription">
      <b><font color="red" size="2">*</font>Description:</b>
    </label>
    <textarea class="form-control" id="editdescription" name="editdescription"
              readonly="readonly" style="border: 1px solid #ced4da;font-size: 12px;"></textarea>
  </div>

  <!-- Target Closure -->
  <div class="col-md-4">
    <label for="edittargetclosedate">
      <b><font color="red" size="2">*</font>Target Closure:</b>
    </label>
    <input type="date" class="form-control" id="edittargetclosedate" name="edittargetclosedate"
           style="border: 1px solid #ced4da;">

    <script>
      $(function() {
        $("#edittargetclosedate").datepicker({
          dateFormat: "dd-mm-yy",
          minDate: 0
        });
      });
    </script>
  </div>

</div>

  <div class="row mt-3">

  <!-- Target Date -->
  <div class="col-md-4">
    <label for="targetclosedate1">
      <b><font color="red" size="2">*</font>Target Date:</b>
    </label>
    <input type="date" class="form-control" id="targetclosedate1" name="targetclosedate1"
           style="border: 1px solid #ced4da;">

    <script>
      $(function() {
        $("#targetclosedate1").datepicker({
          dateFormat: "dd-mm-yy",
          minDate: 0
        });
      });
    </script>
  </div>

  <!-- Department -->
  <div class="col-md-4">
    <label for="editDepartment">
      <b><font color="red" size="2">*</font>Department:</b>
    </label>
    <select class="form-select" id="editDepartment" name="editDepartment" onchange="deptemp();">
      <option value="Select">Select</option>
      <option value="<%=sessiondept%>"><%=sessiondept%></option>
    </select>
  </div>

  <!-- Concern Person -->
  <div class="col-md-4">
    <label for="editconcernperson">
      <b><font color="red" size="2">*</font>Concern Person:</b>
    </label>
    <select class="form-select" id="editconcernperson" name="editconcernperson" sty>
      <!-- Dynamically filled -->
    </select>
  </div>

  <!-- Task Type -->

</div>


<div class="row mt-3">

  <div class="col-md-4">
    <label for="tasktype">
      <b><font color="red" size="2">*</font>Task Type:</b>
    </label>
    <select class="form-select" id="tasktype" name="tasktype">
      <option selected>Select</option>
      <%
        String sqlTaskType = "select TaskName from db_GlobalERP."
                           + session.getAttribute("CompanyMasterID").toString()
                           + "TaskMaster where Department='" + sessiondept + "'";
        System.out.println("sqlTaskType:::::::::" + sqlTaskType);
        rsTaskName = stTaskName.executeQuery(sqlTaskType);
        while(rsTaskName.next()) {
      %>
        <option value="<%=rsTaskName.getString("TaskName")%>">
          <%=rsTaskName.getString("TaskName")%>
        </option>
      <% } %>
    </select>
  </div>
  <!-- Task Allocation Year -->
  <div class="col-md-4">
    <label for="year"><b><font color="red" size="2">*</font>Task Allocation Year :</b></label>
    <select class="custom-select" id="year" name="year"
            onchange="GetMonthName();"
            style="width: 100%; height: 30px; font-size: 13px;">
      <option value="Select">Select</option>
      <%
        int currentYear = java.time.LocalDate.now().getYear();
        for(int k = currentYear; k <= 2050; k++) {
      %>
        <option value="<%=k %>"><%=k %></option>
      <% } %>
    </select>
  </div>

  <!-- Month -->
  <div class="col-md-4">
    <label for="month"><b><font color="red" size="2">*</font>Month :</b></label>
    <select class="custom-select" id="month" name="month"
            onchange="GetFirstAndLastDayOfMonth();"
            style="width: 100%; height: 30px; font-size: 13px;">
      <option value="Select">Select</option>
      <option value="01">JAN</option>
      <option value="02">FEB</option>
      <option value="03">MAR</option>
      <option value="04">APR</option>
      <option value="05">MAY</option>
      <option value="06">JUN</option>
      <option value="07">JUL</option>
      <option value="08">AUG</option>
      <option value="09">SEP</option>
      <option value="10">OCT</option>
      <option value="11">NOV</option>
      <option value="12">DEC</option>
      <%
        if(request.getParameter("month") != null){
          String mon=request.getParameter("month");
          if(mon.equals("01")) mon="JAN";
          else if(mon.equals("02")) mon="FEB";
          else if(mon.equals("03")) mon="MAR";
          else if(mon.equals("04")) mon="APR";
          else if(mon.equals("05")) mon="MAY";
          else if(mon.equals("06")) mon="JUN";
          else if(mon.equals("07")) mon="JUL";
          else if(mon.equals("08")) mon="AUG";
          else if(mon.equals("09")) mon="SEP";
          else if(mon.equals("10")) mon="OCT";
          else if(mon.equals("11")) mon="NOV";
          else if(mon.equals("12")) mon="DEC";
      %>
        <option value="<%=mon%>" selected><%=mon%></option>
      <% } %>
    </select>
  </div>

  <!-- Status -->


</div>

<div class="row mt-3">

  <div class="col-md-4">
    <label for="editstatus"><b><font color="red" size="2">*</font>Status :</b></label>
    <select class="form-select" id="editstatus" name="editstatus">
      <option selected>Select</option>
      <%
        String sqlStatus="select StatusName from db_GlobalERP."
                         + session.getAttribute("CompanyMasterID").toString()
                         + "StatusMaster where StatusName!='Close'";
        rsStatus=stStatus.executeQuery(sqlStatus);
        while(rsStatus.next()) {
      %>
        <option value="<%=rsStatus.getString("StatusName")%>">
          <%=rsStatus.getString("StatusName")%>
        </option>
      <% } %>
    </select>
  </div>
  </div>

<!-- Second Row (Closure Date) -->
<div class="row">
  <div class="col-md-4" id="closuredate" style="visibility:hidden;">
    <label for="targetclosedate2">
      <b><font color="red" size="2">*</font>Closure Date :</b>
    </label>
    <input type="date" class="form-control" id="targetclosedate2"
           name="targetclosedate2" readonly="readonly"
           style="border: 1px solid #ced4da;" />
  </div>
</div>

<script>
  $(function() {
    $("#targetclosedate2").datepicker({
      dateFormat: "dd-mm-yy"
    });
  });

  document.getElementById('editstatus').addEventListener('change', function(e) {
    const box = document.getElementById('closuredate');
    box.style.visibility = (e.target.value === 'Close') ? 'visible' : 'hidden';
  });
</script>
 
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="submit" id="submit" class="btn btn-primary btn-sm">Submit</button>
      </div>
      	<input type="hidden" id="firstday" name="firstday" value=""></input>
		<input type="hidden" id="lastday" name="lastday" value=""></input>
      	<input type="hidden" id="dept" name="dept" value="<%=department%>"></input>
		<input type="hidden" id="ename" name="ename" value="<%=empname%>"></input>
		<input type="hidden" id="issuestatus" name="issuestatus" value="<%=statVal%>"></input>
		<input type="hidden" id="chbk" name="chbk" value="<%=chbxAll%>"></input>
		<input type="hidden" id="fd" name="fd" value="<%=dataDate1%>"></input>
		<input type="hidden" id="td" name="td" value="<%=dataDate2%>"></input>
</div>		
		 </form>
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
	       displayLength: 10,
	        //scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	     //   scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        /*  fixedColumns: { 
	            left: 4      //To freeze two columns
	        },  */
	        keys:true,
	        stateSave: true,
	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)	  
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
	                         title: 'Open Issue Tracker Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Open Issue Tracker Report'+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Open Issue Tracker Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Open Issue Tracker Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Open Issue Tracker Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script>
function chk() {
     var checkboxes =
document.querySelectorAll('input[name="Issue_SR_Id"]');
     var anyChecked = false;

     for (var i = 0; i < checkboxes.length; i++) {
         if (checkboxes[i].checked) {
             anyChecked = true;
             break;  // no need to continue once found
         }
     }

     if (!anyChecked) {
         alert('Please select at least one task for allocation.');
         return false;
     }

     return true;
}


function checkAll() {
//    alert("in check");
     var checkboxes = document.getElementsByClassName("chkbx");
     for (var i = 0; i < checkboxes.length; i++) {
         checkboxes[i].checked = true;
     }
}

function unCheckAll() {
//alert("in uncheck");
     var checkboxes = document.getElementsByClassName("chkbx");
     for (var i = 0; i < checkboxes.length; i++) {
         checkboxes[i].checked = false;
     }
}

</script>
<script>
function consig()
{
	var dept=document.getElementById("companyName1").value;
	
		
	//alert("dept---------"+dept);
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
		  // alert("Original result"+reselt);
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
	
function deptemp()
{
	var dept=document.getElementById("editDepartment").value;
	
		
	//alert("dept---------"+dept);
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
		{ 
			//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		  // alert("Original result"+reselt);
			var finalres=reselt.split("#");
			document.getElementById("editconcernperson").innerHTML=finalres[0];
			//alert("After trim"+finalres[0]);
 
		}
	
	}
	
	var queryString = "?dept="+dept;
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "EmpAjax1.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	
	//re(1);
	}

</script>
<script>allSelected(this.value);</script>
<script type="text/javascript">
function concernperson()
{
	var dept=document.getElementById("editDepartment").value;
	
		
	//alert("dept---------"+dept);
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
		{ 
			//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		  // alert("Original result"+reselt);
			document.Addopenissueform.editconcernperson.innerHTML=reselt;
			//alert("After trim"+finalres[0]);
	 
		}
	
	}
	
	var queryString = "?dept="+dept;   // Pass value to ajax page..........
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "ConcernAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	
	//re(1);
	}
	

function IssueClose(issueId) 
{
	//alert("in function");
	 var agree=confirm("Are you sure you want to close this complaint?");
	  if (agree)
		  return true ;
	  else
		  return false ;
}

function showMenu(id, show) {
	//show menu
	//alert("++id+"+id+"+++show+"+show+"+++");
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
		
	} else {
		popup.style.visibility = "hidden";
	}
}

function hideMenu(id, show) {
	//show menu
	//alert("++id+"+id+"+++show+"+show+"+++");
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "hidden";
		popup.setfocus();
		
	} else {
		popup.style.visibility = "show";
	}
}

function toggleDetails(id, show)
{
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
		
	} else {
		popup.style.visibility = "hidden";
	}
}

</script>

<script>
function allSelected(allVal) {
	if (document.openissuereport.extAll.checked) {
		document.getElementById("frmDT").style.display = 'none';
		document.getElementById("ToDT").style.display = 'none';
		document.getElementById("ext_row").style.marginLeft = "20%";
	} else {
		document.getElementById("frmDT").style.display = "";
		document.getElementById("ToDT").style.display = "";
		document.getElementById("ext_row").style.marginLeft = "0%";
	}
}
function demo(issueId,complaintId,reportDate,customer_internal,issueraise,customername,priority,system,action,openissue,discription,targetcloser,targetdate,department,concern,tasktype,closerdate,status,overdays){
	alert("Are you sure ? "); 	
	
	var a="",b="",c="",d="",e="",f="",g="",h="",i="",j="",k="",l="",m="",n="",o="",p="",q="",r="",s="";
	document.getElementById('editissueid').value = a;
	document.getElementById('complaintid').value = b;
	document.getElementById('editreportdate').value = c;
	document.getElementById('editcustomer').value = d;
	document.getElementById('editissueraisedby').value = e;
	document.getElementById('editcustomername').value = f;
	document.getElementById('editpriority').value = g;

	document.getElementById('editsystem').value = h;
	document.getElementById('editactionpoint').value = i;
	document.getElementById('editreportname').value = j;
	document.getElementById('editdescription').value = k;

	document.getElementById('edittargetclosedate').value = l;
	document.getElementById('targetclosedate1').value = m;
	document.getElementById('editDepartment').value =n;
	document.getElementById('editconcernperson').innerHTML =o;
		document.getElementById('tasktype').value = p;
	document.getElementById('targetclosedate2').value = q;
	document.getElementById('editstatus').value = r;
	
		
		
	a=issueId;
	b=complaintId;
	c=reportDate;
	d=customer_internal;
	e=issueraise;
	f=customername;
	g=priority;
	h=system;
	i=action;
	j=openissue;
	k=discription;
	l=targetcloser;
	m=targetdate;
	n=department;
	o=concern;
	p=tasktype;
	q=closerdate;
	r=status;
	s=overdays;
 	//	alert(a);
		//	alert(b);
		//	alert(k);

		
		
	document.getElementById('editissueid').value = a;
	document.getElementById('complaintid').value = b;
	document.getElementById('editreportdate').value = c;
	document.getElementById('editcustomer').value = d;
	document.getElementById('editissueraisedby').value = e;
	document.getElementById('editcustomername').value = f;
	document.getElementById('editpriority').value = g;

	document.getElementById('editsystem').value = h;
	document.getElementById('editactionpoint').value = i;
	document.getElementById('editreportname').value = j;
	document.getElementById('editdescription').value = k;
	
	if(targetcloser =="-" || targetcloser == ""){
		//document.getElementById('editpriority').value = priority;
	}
	else{
		document.getElementById('edittargetclosedate').value = l;

	}
	
	
	if(targetdate =="-" || targetdate == ""){
		//document.getElementById('editpriority').value = priority;
	}
	else{
		document.getElementById('targetclosedate1').value = m;

	}
	
	document.getElementById('editDepartment').value =n;
/* 	if(department=="-"){
		//document.getElementById('editpriority').value = priority;
	}
	else{
		document.getElementById('ed').value = department;
		alert("department :- "+department);

		//document.getElementById('editDepartment').innerHTML = "<select> <option value='"+department+"''>"+department+"</option> </select>";

	} */
	//document.getElementById('editconcernperson').value = concern;
	document.getElementById('editconcernperson').innerHTML = "<select> <option value='"+o+"''>"+o+"</option> </select>";

	//alert("concern :- "+concern);

	document.getElementById('tasktype').value = p;
	document.getElementById('targetclosedate2').value = q;
	document.getElementById('editstatus').value = r;
	
/*  	document.getElementById('editoverduedays').value = overdays; 
 */ 
	return true;
}

</script>
<script>
function gtcust(){
//	alert("in get customer...")
	var type=document.getElementById("customeInternal").value;
	
		
	//alert("type---------"+type);
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
		{ 
			//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		     //alert("Original result:"+reselt);
			//document.Addopenissueform.customername.innerHTML=reselt;
			document.getElementById("customername").innerHTML=reselt;

			//alert("After trim"+finalres[0]);
	 
		}
	
	}
	
	var queryString = "?type="+type;   // Pass value to ajax page..........
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "CustNameAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 

}
</script>
<script>

function GetFirstAndLastDayOfMonth() {
	//alert("in function");
	var year=document.getElementById("year").value;
	//alert(year);
	var month=document.getElementById("month").value;
	//alert(month);

	var months = {
	        "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
	        "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
	        "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12"
	    };

	//alert(parseInt(months[month]));
	  // Create a new date object with the given year and month
	  const date = new Date(year, parseInt(months[month]) - 1, 1);

	  // Get the first day of the month
	  const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
		//alert(firstDay);

	  // Move to the next month
	  date.setMonth(date.getMonth() + 1);

	  // Subtract 1 day to get the last day of the current month
	  const lastDay = new Date(date.getTime() - 1);
		//alert(lastDay);

		var fd = new Date(firstDay);	    
	    //alert(fd);
	    	    
	   var mnth = ("0" + (fd.getMonth() + 1)).slice(-2);
	    var  day = ("0" + fd.getDate()).slice(-2);
	   var ftd= [fd.getFullYear(), mnth, day].join("-");

	  // alert(ftd);
	   
	    var td = new Date(lastDay);
   	    
		   var mnth1 = ("0" + (td.getMonth() + 1)).slice(-2);
		    var  day1 = ("0" + td.getDate()).slice(-2);
		   var ttd= [td.getFullYear(), mnth1, day1].join("-");

		 //  alert(ttd);
		
		document.getElementById('firstday').value = ftd;
		document.getElementById('lastday').value = ttd;

	}

</script>
<script>
function validation()
{
	var custInt = document.getElementById("customeInternal").value;
	var Issueby = document.getElementById("issueraisedby").value;
	var Custname = document.getElementById("customername").value;
	var priority = document.getElementById("priority").value;
	var system = document.getElementById("system").value;
	var actionpoint = document.getElementById("actionpoint").value;
	var reportname = document.getElementById("reportname").value;
	var description = document.getElementById("description").value;
	var targetclosedate = document.getElementById("targetclosedate").value;
	var Department = document.getElementById("Department").value;
	var concernperson = document.getElementById("concernperson").value;
		

	if (custInt == "Choose") {
		alert("Please select Customer/Internal");
		return false;
	}

	if (Issueby == "Choose") {
		alert("Please select issue raised by");
		return false;
	}

	if (Custname == "Select") {
		alert("Please select Customer Name");
		return false;
	}
	if (priority == "Choose") {
		alert("Please select priority");
		return false;
	}
	if (system == "Choose System") {
		alert("Please select System");
		return false;
	}
	if (actionpoint == "Choose Action Point") {
		alert("Please select Action Point");
		return false;
	}
	if (reportname == "") {
		alert("Please Enter Report Name");
		return false;
	}
	
	if (description == "" || description.length == 0 || description==null) {
		alert("Please Enter Description");
		return false;
	}
	if (targetclosedate == "") {
		alert("Please Select Target Closure");
		return false;
	} 
	
	if (Department == "Select Department") {
		alert("Please Select Department");
		return false;
	}
	if (concernperson == "" || concernperson== "Select") {
		alert("Please Select Concern Person");
		return false;
	}
}


function Editvalidation()
{
	var Issueby = document.getElementById("editissueraisedby").value;
	//alert("Issueby "+Issueby);
	var priority = document.getElementById("editpriority").value;
	//alert("priority "+priority);

	var actionpoint = document.getElementById("editactionpoint").value;
	//alert("actionpoint "+actionpoint);

	var edittargetclosedate = document.getElementById("edittargetclosedate").value;
	//alert("edittargetclosedate "+edittargetclosedate);

	var targetclosedate1 = document.getElementById("targetclosedate1").value;
	//alert("targetclosedate1 "+targetclosedate1);

	var tasktype = document.getElementById("tasktype").value;
	//alert("tasktype "+tasktype);

	var month = document.getElementById("month").value;
	//alert("month "+month);

	var year = document.getElementById("year").value;
	//alert("year "+year);

	var status = document.getElementById("editstatus").value;
	//alert("status "+status);
	

	if (Issueby == "Choose") {
		alert("Please select issue raised by");
		return false;
	}
	if (priority == "Choose" || priority == "") {
		alert("Please select priority");
		return false;
	}
	if (actionpoint == "Choose" || actionpoint == "") {
		alert("Please select Action Point");
		return false;
	}
	
	if (edittargetclosedate == "") {
		alert("Please select Target Closure Date");
		return false;
	}
	if (targetclosedate1 == "") {
		alert("Please select Target Date");
		return false;
	} 
	
	if (tasktype == "Select" || tasktype =="" ) {
		alert("Please Select tasktype");
		return false;
	}
	if (month == "Select") {
		alert("Please Select Month");
		return false;
	}
	if (year == "Select") {
		alert("Please Select Year");
		return false;
	}
	
	if (status == "" || status == "Select") {
		alert("Please Select Status");
		return false;
	}
	
	

}
function concernpersonName()
{
	//alert("in function");
	var dept=document.getElementById("Department").value;
	
		
	//alert("dept---------"+dept);
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
		{ 
			//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		   //alert("Original result"+reselt);
		   document.getElementById("concernperson").innerHTML=reselt;

	 
		}
	
	}
	
	var queryString = "?dept="+dept;   // Pass value to ajax page..........
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "ConcernAjax.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	
	//re(1);
	}
	
</script>
<script>
function GetMonthName()
{
	//alert("in function");
	var year=document.getElementById("year").value;
	
		
	//alert("year---------"+year);
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
		{ 
			//alert("######################### ");
			
		   var reselt=ajaxRequest.responseText;
		 //  alert("Original result"+reselt);
		   document.getElementById("month").innerHTML=reselt;

	 
		}
	
	}
	
	var queryString = "?year="+year;   // Pass value to ajax page..........
     //alert("Query String ---"+queryString);
	ajaxRequest.open("GET", "AjaxGetMonthName.jsp"+queryString, true);
	ajaxRequest.send(null); 
   
	//re(1);
}
	
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>