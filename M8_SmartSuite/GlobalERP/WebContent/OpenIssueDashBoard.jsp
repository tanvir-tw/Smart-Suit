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
 .priority-header {
  background: linear-gradient(135deg, #1582AB, #1CA9C9); /* Gradient blue */
  color: white;
  text-align: center;
  padding: 12px;
  font-size: 15px;
  font-weight: 600;
  border-right: 1px solid #fff;
}

.text-center{
font-size: 13px;
}

.priority-header:last-child {
  border-right: none;
}

</style>
    
</head>
 <body style="background-color:azure;">
 <%
Connection con;
ResultSet rs=null;
Statement stmt=null;

String datenew1="",datenew2="";
String date1 = "",date2 = "",tDate1 = "",tDate2 = "";

String priority="",Status="";
int i=0,statusCount=0;
int UIOpenCount=0,UICloseCount=0,UIWIPCount=0,UIRejectCount=0,UIHangCount=0;
int UNIOpenCount=0,UNICloseCount=0,UNIWIPCount=0,UNIRejectCount=0,UNIHangCount=0;
int NUIOpenCount=0,NUICloseCount=0,NUIWIPCount=0,NUIRejectCount=0,NUIHangCount=0;
int NUNIOpenCount=0,NUNICloseCount=0,NUNIWIPCount=0,NUNIRejectCount=0,NUNIHangCount=0;
int TotalUI=0,TotalUNI=0,TotalNUI=0,TotalNUNI=0;
int GrandTotalOpen=0,GrandTotalClose=0,GrandTotalWIP=0,GrandTotalReject=0,GrandTotalHang=0,GrandTotal=0;

// Connection Initialization

try {
	con = connection.getConnect("db_GlobalERP");    
 	stmt=con.createStatement();
} catch (Exception e) {
 e.printStackTrace();
} 

String type=request.getParameter("status");
datenew1 = request.getParameter("data");
datenew2 = request.getParameter("data1");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");
String Sesrole1=session.getAttribute("role").toString();


System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The datenew1 is :"+datenew1);
System.out.println("The datenew2 is :"+datenew2);
%>
<%
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
System.out.println("Date1 :-"+tDate1);
System.out.println("Date2 :-"+tDate2);

DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
String dataDate1=df1234.format(df123.parse(datenew1));
System.out.println("Data date 1 = "+dataDate1);
String dataDate2=df1234.format(df123.parse(datenew2));


String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h2 class="content-header-title text-center mb-0" style="color: #060637;font-size:20px">Priority wise Dashboard</h2>
    </div>
</div>
  <form name="openissuereport" id="openissuereport" method="post">
  	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
	<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />

		    <div class="row col-12">
		    <div class="col-md-4"></div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datenew1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datenew2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-2"></div>
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
 try{
 String sql="select count(Status) as statusCount,Status,Priority  FROM db_GlobalERP.100000OpenIssueTracker where ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"' and Status !='-' and Priority!='-' group by Priority,status order by status,Priority";
 System.out.println("Sql Query == "+sql);
 rs=stmt.executeQuery(sql);
 while(rs.next())
 {
	 priority=rs.getString("Priority");	 
	 Status=rs.getString("Status");	 
	 statusCount=rs.getInt("statusCount");	 
	 
	 if(priority.equalsIgnoreCase("Urgent and Important"))
	 {
		 if(Status.equalsIgnoreCase("Open"))
		 {
			 UIOpenCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Close"))
		 {
			 UICloseCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("WIP"))
		 {
			 UIWIPCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Reject"))
		 {
			 UIRejectCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Hang"))
		 {
			 UIHangCount=statusCount;
		 }
	 }
	 else if(priority.equalsIgnoreCase("Urgent and Not Important"))
	 {
		 System.out.println("Inside the Urgent and Not Important "); 
		 if(Status.equalsIgnoreCase("Open"))
		 {
			 UNIOpenCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Close"))
		 {
			 UNICloseCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("WIP"))
		 {
			 UNIWIPCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Reject"))
		 {
			 UNIRejectCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Hang"))
		 {
			 UNIHangCount=statusCount;
		 }
	 }
	 else if(priority.equalsIgnoreCase("Not Urgent and Important"))
	 {
		 System.out.println("Inside the Not Urgent and Important "); 
		 if(Status.equalsIgnoreCase("Open"))
		 {
			 NUIOpenCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Close"))
		 {
			 NUICloseCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("WIP"))
		 {
			 NUIWIPCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Reject"))
		 {
			 NUIRejectCount=statusCount;
		 }
		 if(Status.equalsIgnoreCase("Hang"))
		 {
			 NUIHangCount=statusCount;
		 }
	 }
	 else if(priority.equalsIgnoreCase("Not Urgent and Not Important"))
	 {
		 System.out.println("Inside the Not Urgent and Not Important................"); 
		 if(Status.equalsIgnoreCase("Open"))
		 {
			 NUNIOpenCount=NUNIOpenCount+statusCount;
		 }
		 if(Status.equalsIgnoreCase("Close"))
		 {
			 NUNICloseCount=NUNICloseCount+statusCount;
		 }
		 if(Status.equalsIgnoreCase("WIP"))
		 {
			 NUNIWIPCount=NUNIWIPCount+statusCount;
		 }
		 if(Status.equalsIgnoreCase("Reject"))
		 {
			 NUNIRejectCount=NUNIRejectCount+statusCount;
		 }
		 if(Status.equalsIgnoreCase("Hang"))
		 {
			 NUNIHangCount=NUNIHangCount+statusCount;
		 } 
	 } 
		 //Total count of Urgent and Imp priority
		 TotalUI=UIOpenCount+UICloseCount+UIWIPCount+UIRejectCount+UIHangCount;
		 System.out.println("Total count of Urgent and IMP="+TotalUI);
		 TotalUNI=UNIOpenCount+UNICloseCount+UNIWIPCount+UNIRejectCount+UNIHangCount;
		 TotalNUI=NUIOpenCount+NUICloseCount+NUIWIPCount+NUIRejectCount+NUIHangCount;
		 TotalNUNI=NUNIOpenCount+NUNICloseCount+NUNIWIPCount+NUNIRejectCount+NUNIHangCount;
		 System.out.println("Total count of Not Urgent and Not IMP="+TotalNUNI);

		GrandTotalOpen=UIOpenCount+UNIOpenCount+NUIOpenCount+NUNIOpenCount;
		GrandTotalClose=UICloseCount+UNICloseCount+NUICloseCount+NUNICloseCount;
		GrandTotalWIP=UIWIPCount+UNIWIPCount+NUIWIPCount+NUNIWIPCount;
		GrandTotalReject=UIRejectCount+UNIRejectCount+NUIRejectCount+NUNIRejectCount;
		GrandTotalHang=UIHangCount+UNIHangCount+NUIHangCount+NUNIHangCount;
	
		GrandTotal=GrandTotalOpen+GrandTotalClose+GrandTotalWIP+GrandTotalReject+GrandTotalHang;
		 System.out.println("***************************************************************************************************");

    	i++; 
     }
 
%>

  <div class="row">
     <div class="col-md-2"></div>
     <div class="col-md-8">
 <div class="row">

<div class="container-fluid mt-4">
  <div class="card shadow-lg rounded-3">
 
    <div class="card-body">
      <table id="issueTable" class="table table-striped table-bordered align-middle text-center">
<thead class="table-dark">
  <tr>
    <th class="priority-header">Status / Priority</th>
    <th class="priority-header">Urgent & Important</th>
    <th class="priority-header">Urgent & Not Important</th>
    <th class="priority-header">Not Urgent & Important</th>
    <th class="priority-header">Not Urgent & Not Important</th>
    <th class="priority-header">Grand Total</th>
  </tr>
</thead>

        <tbody>
          <% 
            String a="Urgent and Important",b="Urgent and Not Important",c="Not Urgent and Important",d="Not Urgent and Not Important";
          %>
              <tr>
      <th>Open</th>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Open"%>&priority=<%=a%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UIOpenCount%></a></td>
     <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Open"%>&priority=<%=b%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>" ><%=UNIOpenCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Open"%>&priority=<%=c%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>" ><%=NUIOpenCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Open"%>&priority=<%=d%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>" ><%=NUNIOpenCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Open"%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>" ><%=GrandTotalOpen%></a></td>
      
    </tr>
    <tr>
      <th class="table-info fw-bold">Close</th>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Close"%>&priority=<%=a%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UICloseCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Close"%>&priority=<%=b%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UNICloseCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Close"%>&priority=<%=c%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUICloseCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Close"%>&priority=<%=d%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUNICloseCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Close"%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=GrandTotalClose%></a></td>
    </tr>
    <tr>
      <th>Work in progress(WIP)</th>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="WIP"%>&priority=<%=a%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UIWIPCount%></a></td>
       <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="WIP"%>&priority=<%=b%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UNIWIPCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="WIP"%>&priority=<%=c%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUIWIPCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="WIP"%>&priority=<%=d%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUNIWIPCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="WIP"%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=GrandTotalWIP%></a></td>
    </tr>
     <tr>
      <th class="table-info fw-bold">Reject</th>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Reject"%>&priority=<%=a%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UIRejectCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Reject"%>&priority=<%=b%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UNIRejectCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Reject"%>&priority=<%=c%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUIRejectCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Reject"%>&priority=<%=d%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUNIRejectCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Reject"%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=GrandTotalReject%></a></td>
    </tr>
     <tr>
      <th>Hang</th>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Hang"%>&priority=<%=a%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UIHangCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Hang"%>&priority=<%=b%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=UNIHangCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Hang"%>&priority=<%=c%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUIHangCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Hang"%>&priority=<%=d%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=NUNIHangCount%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?status=<%="Hang"%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=GrandTotalHang%></a></td>
    </tr>
      <tr  style="background-color:#D8E5F3;">
      <th>Grand Total</th>
      <td class="text-center"><a href="OpenIssueDetails.jsp?&priority=<%=a%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=TotalUI%></a></td>
       <td class="text-center"><a href="OpenIssueDetails.jsp?&priority=<%=b%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=TotalUNI%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?&priority=<%=c%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=TotalNUI%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?&priority=<%=d%>&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=TotalNUNI%></a></td>
      <td class="text-center"><a href="OpenIssueDetails.jsp?&FromDate=<%=dataDate1%>&ToDate=<%=dataDate2%>"><%=GrandTotal%></a></td>
      
    </tr>
          

          
         
        </tbody>
      </table>
    </div>
  </div>
</div>


 <br>
 <br>
 <br>
 </div>
 </div>
 <div class="col-md-2"></div>
</div>
</div>
           
	



 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>

 <%@ include file="footer.jsp" %>
 </body>
</html>