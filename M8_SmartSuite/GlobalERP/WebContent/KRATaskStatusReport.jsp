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
// Variable Declaration
String datenew1="", datenew2="", date1 = "", date2 = "", tDate1 = "", tDate2 = "", fromDate = "", toDate = "",fromDate1="", data2="",data1="";
String datex1="",datex2="",bt="",dt="",dt1="",dttime="",dt1time="";
String dept = "", user_id1 = "", department="",sql1="",  CustomerCode="", dotprojectid="", query12="";

String stp="Pending";

datenew1 = request.getParameter("data");
datenew2 = request.getParameter("data1");
String totalTask = request.getParameter("totalTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String Sesrole1=session.getAttribute("role").toString();
String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
String comid=session.getAttribute("CompanyMasterID").toString();

 // Connection Initialization
Connection conn = null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
if(datenew1==null){
	
	System.out.println("==in if==");
	Calendar cal = Calendar.getInstance();
	String today_dt = new SimpleDateFormat("dd-MMM-yyyy") .format(cal.getTime());
	data2 = today_dt;
	String temp = data2;
	 toDate = new SimpleDateFormat("yyyy-MM-dd") .format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	//cal.add(Calendar.DATE, -1);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy") .format(cal.getTime());
	 data1 = yesterday_dt;
	temp = data1;
	 fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	 fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	
	datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	
	if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	{
		datenew1 = fromDate1;
		datenew2 = ""+datenew2;
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
String dataDate2=df1234.format(df123.parse(datenew2));

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

	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";

%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">KRA Task Status Report</h5>
    </div>
</div>
  <form name="formreport" id="formreport" method="post">
		    <div class="row col-12">
		    <div class="col-md-2"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select"name="companyName1" id="companyName1" onchange="consig();">
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
           
            if(Sesrole1.equals("AllAdmin"))
       	
       	{
           	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and KRAdotprojectid!='-'order by dept";
       	}
            
           else if (Sesrole1.equals("HOD")){
           	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and KRAdotprojectid!='-' order by dept";
            }
           else
           {
           	sql1="select distinct(dept) as department  from db_GlobalERP.UserMaster where EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"  and ActiveStatus='Yes' and KRAdotprojectid!='-' order by dept";
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
          <%if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD")) {
           %>
           		<option value="All">All</option>
           
           <%} else
           {%>
           <option value="<%=name%>"><%=name%></option>
           <%} }
            else 
            {
            String EmpName1=request.getParameter("EmpName"); 
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
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
						
		</div>
<input type="hidden" id="comid" name="comid" value="<%=comid%>" />    		
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />
<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
</form> 
 <br>
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
            <th>SrNo</th>
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
	String data11 = request.getParameter("data");
	System.out.println("data11::"+data11);
	String data12 = request.getParameter("data1");	
	System.out.println("data12"+data12);
	String Nam = request.getParameter("EmpName");
	System.out.println("Nam"+Nam);

	%>		
	<%
	
	String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy") .format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd") .format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy") .format(cal.getTime());
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
		System.out.println("fromDate 1-->"+fromDate);
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
		
		 dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		dt=dt+" 00:00:00";
		 dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew2));
		dt1=dt1+" 23:59:59";
		
		String datef = new SimpleDateFormat("dd-MMM-yyyy")
		.format(new SimpleDateFormat("yyyy-MM-dd")
				.parse(dt));
		
		String datet = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(dt1));
		
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
        	
        	if(name13=="All")
        	{
        		name13="";
        	}
        	if(department=="All")
        	{
        		department="";
        	}

	CallableStatement cs=(CallableStatement) conn.prepareCall("{call db_GlobalERP.KRAStatus2('"+session.getAttribute("CompanyMasterID").toString()+"','"+department+"','"+name13+"', '"+dt+"', '"+dt1+"')}");
	ResultSet rscs= cs.executeQuery();
	System.out.println("cs---"+cs); 

	int i=1;

	while(rscs.next())	
	
{
	String User="",UserID="",empcode="",HOD="",Department="",Assigned="",Submitted="",Missed="",Pending="",Approved="",Rejected="";
	User=rscs.getString("User");
	
	UserID=rscs.getString("UserID");
	Assigned=rscs.getString("Assigned");
	Submitted=rscs.getString("Submited");
	Missed=rscs.getString("Missed");
	Pending=rscs.getString("Pending");
	Approved=rscs.getString("Approved");
	Rejected=rscs.getString("Rejected");
	HOD=rscs.getString("HOD");
	Department=rscs.getString("Department");
%>
        <tr> 
         	<td  class="text-center"><%=i%></td>
			<td  class="text-center"><%=User%></td>
			<td  class="text-center"><%=UserID%></td>
			<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Assigned&role=<%=Sesrole2%>"><%=Assigned%></a></td>
			<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Submitted&role=<%=Sesrole2%>"><%=Submitted%></a></td>
			<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Missed&role=<%=Sesrole2%>"><%=Missed%></a></td>
			<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Pending&role=<%=Sesrole2%>"><%=Pending%></a></td>
			<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Approved&role=<%=Sesrole2%>"><%=Approved%></a></td>
			<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Rejected&role=<%=Sesrole2%>"><%=Rejected%></a></td>
			<td  class="text-center"><%=Department%></td>
			<td  class="text-center"><%=HOD%></td>
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
			
			String seldept=request.getParameter("companyName1"); 
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
        	if(name13.equals("All"))
        	{
        		name13="";
        	}
        	
			data11=tDate1;
			data12=tDate2;
			data11 = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(datenew1));
			data11=data11+" 00:00:00";
	     	data12 = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(datenew2));
	     	
	     	data12=data12+" 23:59:59";		 
			
			 seldept=request.getParameter("companyName1"); 
			 fromDate=fromDate+" 00:00:00";		
			 
			 toDate=toDate+" 23:59:59";


 CallableStatement cs=(CallableStatement) conn.prepareCall("{call db_GlobalERP.KRATaskStatusReport('"+session.getAttribute("CompanyMasterID").toString()+"','"+department+"', '"+name13+"', '"+fromDate+"', '"+toDate+"')}");
	 ResultSet rscs1= cs.executeQuery();
	System.out.println("cs---"+cs); 	

	int i=1;

	while(rscs1.next())		
{
	String User="",UserID="",empcode="",HOD="",Department="",Assigned="",Submitted="",Missed="",Pending="",Approved="",Rejected="";
	User=rscs1.getString("User");
	UserID=rscs1.getString("UserID");
	Assigned=rscs1.getString("Assigned");
	Submitted=rscs1.getString("Submited");
	Missed=rscs1.getString("Missed");
	Pending=rscs1.getString("Pending");
	Approved=rscs1.getString("Approved");
	Rejected=rscs1.getString("Rejected");
	HOD=rscs1.getString("HOD");
	Department=rscs1.getString("Department");
%>
		
<tr>
			<td  class="text-center"><%=i%></td>
			<td  class="text-center"><%=User%></td>
			<td  class="text-center"><%=UserID%></td>
<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Assigned&role=<%=Sesrole2%>"><%=Assigned%></a></td>
<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Submitted&role=<%=Sesrole2%>"><%=Submitted%></a></td>
<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Missed&role=<%=Sesrole2%>"><%=Missed%></a></td>
		
<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Pending&role=<%=Sesrole2%>"><%=Pending%></a></td>
		
		
		
<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Approved&role=<%=Sesrole2%>"><%=Approved%></a></td>
<td  class="text-center"><a href="TaskDetailsReport.jsp?userId=<%=UserID%>&fromdate=<%=datef%>&todate=<%=datet%>&HOD=<%=HOD%>&Dept=<%=Department%>&User=<%=User%>&Status=Rejected&role=<%=Sesrole2%>"><%=Rejected%></a></td>
			
			<td  class="text-center"><%=Department%></td>
			<td  class="text-center"><%=HOD%></td>
	
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
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	         //fixedColumns: { 
	          //  left: 4      //To freeze two columns
	       // }, 
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
	                         title: 'KRA Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'KRA Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'KRA Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'KRA Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'KRA Task Status Report '+$("#data").val()+ ' to ' +$("#data1").val(),
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
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>