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
<%
// Variable Declaration
String datenew1="",datenew2="";
String targetClosure="",date1 = "",date2 = "",dept = "", user_id1 = "",tDate1 = "",tDate2 = "",department="",EmpName1="",seldept="";
String statVal="",chbxAll="",deptnew="",empnamenew="",fd="",td="",status="",issuestatusnew="",checkall="";
String Issue_Id="", ReportedDate="", ComplaintID="",CustomerType ="",IssueRaisedBy ="", CustomerName ="",Priority ="";
String SystemName ="",ActionPoint ="",OpenIssue  ="", Description ="",TargetClosureDate ="",TargetDate ="",Department ="",Concern ="",TaskType ="", ClosureDate ="",Status ="",OverdueDays="";
String ReportedDateNew="",TargetClosureDateNew="",TargetDateNew="",ClosureDateNew="",sqlConcernPerson="",sqlOpenIssue="";
String Bt=request.getParameter("button");
String name13="",a="('",b="')";

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
Connection conn = null;

ResultSet rs=null,rsIssueRaised=null,rsPriority=null,rsSystem=null,rsActionPoint=null,rsDepartment=null,rsTaskName=null,rsStatus=null,rsOverdue=null,rsConcernPerson=null;
Statement stIssueRaised=null,stPriority=null,stSystem=null,stActionPoint=null,stDepartment=null,stOverduedays=null;


try {
	conn = connection.getConnect("db_GlobalERP");    
	stIssueRaised=conn.createStatement();
	stPriority=conn.createStatement();
	stSystem=conn.createStatement();
	stActionPoint=conn.createStatement();
	stDepartment=conn.createStatement();
	stOverduedays=conn.createStatement();  
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{
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
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" name="companyName1" id="companyName1" onchange="consig();">
                          
         <%	String Bt1=request.getParameter("button");
  		

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
            
            <%} %>
            <%}
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
						<select class="form-select" id="EmpName" name="EmpName"  style="font-size: 11px">
						
						<%	String Bt2=request.getParameter("button");
  		

          System.out.println("-INNNNNNNNNNNN-------------"+Bt2);
          if(Bt2==null || Bt2=="null" || Bt2.equals("null"))
        	  {}
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
					</div>
			</div>
			
			             <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group ">
						<select class="form-select" name="issuestatus" id="issuestatus" style="font-size: 11px">
						<option value="All" selected>All</option>
						<option value="Open">Open</option>
						<option value="Close">Close</option>
						<option value="WIP">WIP</option>
						<option value="Reject">Reject</option>
						<option value="Hang">Hang</option>							
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
		<div class="row col-12 mt-4">		    
             <div class="col-md-2" style=" margin-top: 15px;" >
                   <button type="button" class="btn btn-primary" id="button" name="button" data-bs-toggle="modal" data-bs-target="#addMyModal">Add Open Issue</button>
             </div>
         </div>
 <br>
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
			<th>Issue ID</th>
			<th>Complaint ID</th>
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
try{
	
if(Bt==null || Bt=="null" || Bt.equals("null"))
{


}

else{
	name13 = request.getParameter("EmpName");
    System.out.println("name13..."+name13); 
   
    if(name13.equalsIgnoreCase("All")){
   	 
   	 name13=session.getAttribute("ContactPersonList").toString();       	 
   	 name13 = name13.replaceFirst(",","");
   	 name13 = name13.replaceAll(",","','");       	 
    }
    
    name13=a+name13+b;

	System.out.println("name13.....################"+name13);
statVal = request.getParameter("issuestatus");
chbxAll = request.getParameter("extAll");
if (statVal == null || statVal.equalsIgnoreCase("null")) {
	statVal = "All";
}
System.out.println("statVal=" + statVal);

if (chbxAll != null && chbxAll != "") {
	if (statVal == "All" || statVal.equals("All")) {
        sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" ";

	} else {
        sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and Status='"+statVal+"'";

	}
}  else {
	if (statVal == "All" || statVal.equals("All")) {
       sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and ReportedDate>='"+dataDate1+"' and ReportedDate<='"+dataDate2+"'";

	} else {
       sqlOpenIssue="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where Department like '%"+department+"%' and Concern in "+name13+" and Status='"+statVal+"' and ReportedDate>='"+dataDate1+"' and ReportedDate<='"+dataDate2+"'";

	}

}

rs = st.executeQuery(sqlOpenIssue);
System.out.println("Main Query is : "+sqlOpenIssue);

     int i=1;
     while(rs.next()){
   
   	  Issue_Id=rs.getString("Issue_SR_Id");   	  
   	  ReportedDate=rs.getString("ReportedDate");
   	 
   	  if(ReportedDate =="-" || ReportedDate.equalsIgnoreCase("-")){
   		  ReportedDateNew ="-";
	    		 
	    	 }else{
			    	 ReportedDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ReportedDate));
	    	 }
   	 ComplaintID=rs.getString("ComplaintID");
   	 if(ComplaintID==null || ComplaintID.contains(" ")){
   		 ComplaintID="-"; 
   	 }else{    		 
	    	 ComplaintID=rs.getString("ComplaintID");

   	 }
   	CustomerType=rs.getString("CustomerType");
   	  IssueRaisedBy=rs.getString("IssueRaisedBy");
   	  CustomerName=rs.getString("CustomerName");
   	  Priority=rs.getString("Priority");
   	  SystemName=rs.getString("SystemName");
   	  ActionPoint=rs.getString("ActionPoint");
   	  OpenIssue=rs.getString("OpenIssue");
   	  Description=rs.getString("Description");
   	  TargetClosureDate=rs.getString("TargetClosureDate");
   	 // System.out.println("Target date== "+TargetClosureDate);
   	//  TargetClosureDate=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetClosureDate));
   		 if(TargetClosureDate =="-" || TargetClosureDate.equalsIgnoreCase("-")){
	    		 TargetClosureDate ="-";
	    		 
	    	 }else{
		    	 TargetClosureDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetClosureDate));
	    	 }
	    		
   	  TargetDate=rs.getString("TargetDate");
   	//TargetDateNew=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TargetDate));
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
   	 // ClosureDateNew=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ClosureDate));

   	  if(ClosureDate.equals("-")){

   		  ClosureDateNew="-";
   	  }else{
   		  
		    	 ClosureDateNew=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ClosureDate));

   	  }

   	  Status=rs.getString("Status");
   	  
   	  
   	  String sqlOverduedays="SELECT DATEDIFF( current_date, TargetClosureDate) as OverdueDays,Status FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where  Status != 'Close' and Issue_SR_Id='"+Issue_Id+"'";
   	  
   	  rsOverdue = stOverduedays.executeQuery(sqlOverduedays);
   	  
   	 if(rsOverdue.next()){
   	  OverdueDays=rsOverdue.getString("OverdueDays");	  
   	 }
   	 if(Status.equalsIgnoreCase("Close")) {
	    	  OverdueDays="-";	  
	    	 }
   	 if(OverdueDays==null || OverdueDays.contains(" ")){
	    	  OverdueDays="-";	  
	    	 }
   	 
  
%>
<tr>
<td class="text-right"><%=i%></td>
<td class="text-right"><%=Issue_Id%></td>
<td class="text-right"><%=ComplaintID%></td>
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
<td class="text-right"><%=OverdueDays%></td>
     
</tr>
<%
i++;	
}
}
}catch(Exception e){
	e.printStackTrace();
}
%>
        
        </tbody>
 </table>
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
      <label for="dropdown"><b><font color="red" size="2">*</font><font color="red" size="2">*</font>Target Closure:</b></label>
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
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         fixedColumns: { 
	            left: 4      //To freeze two columns
	        }, 
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
<script>allSelected(this.value);</script>
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
function validation()
{
	//alert("in validation");
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
		alert("Please Select Customer/Internal");
		return false;
	}

	if (Issueby == "Choose") {
		alert("Please Select issue raised by");
		return false;
	}

	if (Custname == "Select") {
		alert("Please Select Customer Name");
		return false;
	}
	if (priority == "Choose") {
		alert("Please Select priority");
		return false;
	}
	if (system == "Choose System") {
		alert("Please Select System");
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
		  // alert("Original result"+reselt);
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
 <%@ include file="footer.jsp" %>
 </body>
</html>