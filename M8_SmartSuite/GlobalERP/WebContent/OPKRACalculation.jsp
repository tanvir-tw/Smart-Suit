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
Statement sta = null, stb = null,stc = null, std = null;
Statement st_user_id = null,st1 = null;

Statement st2 = null,st3 = null, st4 = null, st5 = null,st6 = null;
Statement st7 = null, st8 = null, st9 = null,st10 = null,stmt=null,stmt1=null;
Statement stmt11 = null; //postgresql
Connection conn1 = null;

try {
		
		conn = connection.getConnect("db_GlobalERP");   
		stmt = conn.createStatement();
		stmt1 = conn.createStatement();
		st=conn.createStatement();
		sta=conn.createStatement();	
		stb=conn.createStatement();	
		stc=conn.createStatement();
		std=conn.createStatement();	
		st_user_id=conn.createStatement();	
		st1=conn.createStatement();
		st2=conn.createStatement();
		st3=conn.createStatement();
		st4=conn.createStatement();
		st5=conn.createStatement();
		st6=conn.createStatement();
		st7=conn.createStatement();
		st8=conn.createStatement();
		st9=conn.createStatement();
		st10=conn.createStatement();
		System.out.println("===========connection created=============");
		
		Class.forName(postgresDriver);
		conn1  = DriverManager.getConnection(postgresString,postgresUser,postgresPass); //postgresql
		stmt11 = conn1.createStatement();
		
	
	} catch (Exception e) {
		System.out.print("GetConnection Exception ---->" + e);
	}
%>
<%

String datenew1="";
String datenew2="";
String date1 = "";
String date2 = "";
String dept = "";
String user_id1 = "";
String tDate1 = "";
String tDate2 = "";

int k=2000;
dept = session.getAttribute("department").toString();
	System.out.println("==in else==");
	
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
	int cnt = 0;
	String Sesrole1=session.getAttribute("role").toString();
	String sessiondept=session.getAttribute("department").toString();
	System.out.println("Session Dept :- "+sessiondept);
	System.out.println("Sesrole1 Role :- "+Sesrole1);
	String sql_active = "";		
	
		if (Sesrole1.equals("HOD"))
		{
			System.out.println("INSIDE HOD");
			dept = request.getParameter("dept");
			System.out.println("Dep :- "+dept);
			if(dept!=null && dept.equals("AllDept"))
			{
				
		      sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where  ActiveStatus = 'Yes' and KRAdotprojectid!='-' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
			}
			else
			{
				sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and KRAdotprojectid!='-' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
			}
		}
		else
		{
			if (Sesrole1.equals("Hr"))
			{
				dept = request.getParameter("dept");
				System.out.println("Dep :- "+dept);
				
			  if (dept!=null && dept.equals("AllDept") ) 
				{
				sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' and KRAdotprojectid!='-'  ";
				}
			  else
			  {
				  sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and KRAdotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			  }
			}			
		}
		if(Sesrole1.equals("-"))
		{
			sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where dept = '"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
		}		
				
		if(Sesrole1.equals("AllAdmin"))
			
		{
			dept = request.getParameter("dept");
			System.out.println("Dep :- "+dept);
			
			if(dept!=null && dept.equals("All"))
			{
				dept="%%";
				
				sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"' and KRAdotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			}
			else
			{
			if(dept!=null)
			{
			sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept = '"+dept+"' and KRAdotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			}
			else
			{
				sql_active = "select KRAdotprojectid as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept = '"+dept+"' and KRAdotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
			}
			}
		}
	System.out.println("The KRADot Id query is ==>>"+sql_active);
	ResultSet rs_active = st_user_id.executeQuery(sql_active);
	while(rs_active.next()){
		++cnt;
		if(cnt == 1)
		{
			user_id1 = rs_active.getString("user_id");
		}else
		{
			user_id1 = user_id1 +","+ rs_active.getString("user_id");
		}
		
	}
		int counter=0;
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">KRA Index Report</h5>
    </div>
</div>
<form name="indexReport" method="get"  onsubmit="return confirmSubmit()" action="">
 <div class="row col-12">
		    <div class="col-md-3"></div>
             <div class="col-md-2">
				  <label for="dropdown"><b>Department</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="dept" name="dept">
                            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <% if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD"))
            {
            %>
            <option value="AllDept">AllDept</option>
            <%
            }
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
				<label for="from"><b>Month</b></label>
					<div class="input-group input-group-merge">
					<select class="form-select" id="month" name="month">
					<option value="Select">Select</option>
<%
String[][] months = {
        {"01","JAN"}, {"02","FEB"}, {"03","MAR"},
        {"04","APR"}, {"05","MAY"}, {"06","JUN"},
        {"07","JUL"}, {"08","AUG"}, {"09","SEP"},
        {"10","OCT"}, {"11","NOV"}, {"12","DEC"}
    };
String selectedMonth = request.getParameter("month"); // e.g. "03"

for(String[] m : months){
    String value = m[0];
    String label = m[1];
    String selectedmon = (value.equals(selectedMonth)) ? "selected" : "";
%>
<option value="<%=value%>" <%=selectedmon%>><%=label%></option>
<%
}
%>
</select>
		                  <script>
                            const mySel = document.getElementById("month");

                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localSorage.settItem("selValue", this.value); // 
                              });
                             </script>	
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>Select Year</b></label>
				<div class="input-group input-group-merge" >	
				<select class="form-select" id="year" name="year">
				<%
        String selectedYear = request.getParameter("year");
        if (selectedYear == null || selectedYear.isEmpty()) {
    %>
    <option value="Select">Select</option>
    <%
        }
        for (int year = 2016; year <= 2050; year++) {
            boolean isSelected = Integer.toString(year).equals(selectedYear);
    %>
    <option value="<%= year %>" <%= isSelected ? "selected" : "" %>><%= year %></option>
    <%
        }
    %>
</select>
		                  <script>
                            const mySel = document.getElementById("year");

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
				
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" >
			</div>
						
		</div>
		</form> 
<%
String year1=request.getParameter("year");

if(year1==null)
{
	year1="1999";
}
else 
{
	 year1=request.getParameter("year");
}
String month1=request.getParameter("month");
if(month1==null)
	
{
	month1="13";
	
}
else
{
	month1=request.getParameter("month");
}

DecimalFormat df = new DecimalFormat("0.00");
String fromDate = year1+"-"+month1+"-"+"01";
String toDate="";
String toDate1 ="select last_day ('"+fromDate+"') as monthname3";

ResultSet rsmonthname3=st4.executeQuery(toDate1);
rsmonthname3.next();
String mnth3=rsmonthname3.getString("monthname3");
toDate=mnth3;

	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
if(fromDate !=null && toDate !=null) {
	String fromDTime =fromDate+" 00:00:00";
	String toDTime =toDate+" 23:59:59";
	
%>
 <br>
<table id="example" class="display" style="width:100%">   
<thead>
	<tr>
            <th class="col-width-4">SrNo.</th>
			<th>User<br>Name</th>
			<th>Working<br>Days</th>
			<th>Total<br>Tasks(Hrs)</th>
			<th>A<br>Category</th>
			<th>B<br>Category</th>
			<th>C<br>Category</th>
			<th>D<br>Category</th>
			<th>A<br>Category %</th>
			<th>B<br>Category %</th>
			<th>C<br>Category %</th>
			<th>D<br>Category %</th>
			<th>Performance<br>Index %</th>
	</tr>
</thead>
<tbody>
<%
try{
int count =0;
String sql = "Select user_id, user_username from dotproject.users where user_id in ("+user_id1+") order by user_username ASC";

System.out.println("The query is ==>>"+sql);
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		String user_id = rs.getString("user_id");
		String user_name = rs.getString("user_username");
		
		String Openprojectid = "";
		//getOpenProjectId for query
		String sqlid = "select Openprojectid from db_GlobalERP.UserMaster where kradotprojectid='"+user_id+"'";
		ResultSet rsid = st10.executeQuery(sqlid);
		if(rsid.next()){
			Openprojectid = rsid.getString("Openprojectid");
		}
		
				double total_task = 0.0,a_cat = 0.0, b_cat = 0.0, c_cat = 0.0, d_cat = 0.0; double a_cat_per = 0.0,b_cat_per = 0.0, c_cat_per = 0.0,d_cat_per = 0.0,per_index = 0.0;
				String sql_total = "select count(*) as total_tasks from work_packages where assigned_to_id='"+Openprojectid+"' and due_date >='"+fromDTime+"' and due_date<='"+toDTime+"' and type_id=9 ";
				System.out.println("The query is ==>>"+sql_total);
				ResultSet rst = stmt11.executeQuery(sql_total);
				
				if(rst.next()){
		
			  		total_task = rst.getInt("total_tasks");
				}
			
				String sql_a = "select sum(AssignedDuration) as a_cat from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy where UserId='"+user_id+"' and DATE(TaskEndDate)>='"+fromDTime+"' and DATE(TaskEndDate)<='"+toDTime+"' and TaskPercent=100 and MailDateTime <= TaskEndDate and TaskStatus='Approved' ";
				System.out.println("The query for A Category is ==>>"+sql_a);
				ResultSet rsa = sta.executeQuery(sql_a);
				if(rsa.next()){
				
					a_cat = rsa.getDouble("a_cat");
				}
				String sql_b="select sum(AssignedDuration) as b_cat from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy  where  UserId='"+user_id+"' and date(TaskEndDate) >='"+fromDTime+"' AND  date(TaskEndDate) <='"+toDTime+"' and TaskPercent=100 and  MailDateTime > TaskEndDate and MailDate <= (SELECT DATE( date(TaskEndDate) + INTERVAL (5 - WEEKDAY( date(TaskEndDate) ) ) DAY))  and TaskStatus='Approved'";
				ResultSet rsb = stb.executeQuery(sql_b);
				if(rsb.next()){
					b_cat = rsb.getDouble("b_cat");
				}
			
				String sql_c="select sum(AssignedDuration) as c_cat from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy where  userId='"+user_id+"' and date(TaskEndDate) >='"+fromDTime+"' AND  date(TaskEndDate) <='"+toDTime+"' and TaskPercent=100 and  MailDateTime > TaskEndDate and MailDate > (SELECT DATE(DATE(TaskEndDate) + INTERVAL (5 - WEEKDAY(DATE(TaskEndDate))) DAY)) and MailDateTime <=(SELECT DATE(LAST_DAY(date(TaskEndDate) +INTERVAL 4 Day)))  and TaskStatus='Approved'";
				ResultSet rsc = stc.executeQuery(sql_c);
				if(rsc.next()){
					c_cat = rsc.getDouble("c_cat");
				}
				String sql_d = "select count(*) as d_cat from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildataCopy where  userId='"+user_id+"' and date(TaskEndDate)>='"+fromDTime+"' AND date(TaskEndDate)<='"+toDTime+"' and TaskPercent<>100  and TaskStatus='Approved'";
				System.out.println("The query for D Category is ==>>"+sql_d);
				ResultSet rsd = std.executeQuery(sql_d);
				
				if(rsd.next()){
				
					d_cat = rsd.getDouble("d_cat");
				}
				
				String daycount="select datediff('"+fromDTime+"','"+toDTime+"')";
				ResultSet rsd1 = std.executeQuery(sql_d);
				System.out.println("The query is ==>>"+sql_d);
				
				double total_task1=200;
				String EmpID="";
				String totdays="select format(count(*)/2,2) as days,EmpID  from db_leaveapplication.t_checkinout where EmpID in (select EmpCode from db_GlobalERP.UserMaster where KRAdotprojectid in ("+user_id+")) and CheckinDateTime >='"+fromDTime+"' and  CheckinDateTime <='"+toDTime+"' ";
				ResultSet rstotdays=st1.executeQuery(totdays);
				
				double days=0.00;
				while(rstotdays.next()){
					String monthname="select monthname('"+fromDate+"') as monthname ";
					ResultSet rsmonthname=st4.executeQuery(monthname);
					rsmonthname.next();
					String mnth=rsmonthname.getString("monthname");
					mnth=mnth.substring(0,3);
					String year="select year('"+fromDate+"') as year,DAYOFMONTH(LAST_DAY('"+fromDate+"')) as DayCount ";
					ResultSet rsyear=st5.executeQuery(year);
					String Year="";
					int daycnt=0;
					if(rsyear.next())
					{
						Year=rsyear.getString("year");
						daycnt=rsyear.getInt("DayCount");
					}
					String totdays1="select count(*) as days from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster where month like '%"+mnth+"%' and Year='"+Year+"' and Status='Yes'";
					
					System.out.println("Working Days Query :- "+totdays1);
					ResultSet rstotdays1=st3.executeQuery(totdays1);
					rstotdays1.next();
					
						days=rstotdays1.getDouble("days");
						days=daycnt-days;
						EmpID=rstotdays.getString("EmpID");
					
				String name="select Name from db_leaveapplication.t_leaveadmin where EmpID="+EmpID+"";
				ResultSet rsname=st6.executeQuery(name);
				System.out.println("Leave Name :- "+name);
				String leavename="";
				if(rsname.next())
				{
					 leavename=rsname.getString("name");	
				}
				double leaveday=0.00;
				double leaveday2=0.00;
				
				String leavedays="select * from db_leaveapplication.t_leaverequest where name='"+leavename+"'  and ((firstdayofleave >= '"+fromDate+"'  and firstdayofleave <= '"+toDate+"' ) or (dateofreporting >= '"+fromDate+"'  and dateofreporting <= '"+toDate+"')) and status='Approved' and typeofleave!='Office work' ";
				ResultSet rsleavedays=st3.executeQuery(leavedays);
				StringBuilder sb=new StringBuilder();
				String[] AttachFilePath= new String[300];
				String attch="";
				System.out.println("Leave Day :- "+leavedays);
				String firstleaveday="";
				String reportingleaveday="";
				String firstdaymonth="";
				String reportdaymonth="";
				String firtdayleavemnth="";
				String reportdayleavemnth="";
			    String daysapplied2="",typeofleave="";
				double daysapplied=0;
				int daysapplied1=0;
				int firstdaymonthcount=0;
				int reportmonthcount=0;
				String alldays1="";
				while(rsleavedays.next())
				{
					firstleaveday=rsleavedays.getString("firstdayofleave");
					reportingleaveday=rsleavedays.getString("dateofreporting");
					daysapplied2=rsleavedays.getString("daysapplied");
					typeofleave=rsleavedays.getString("typeofleave");
					daysapplied1=(int) Math.round(Double.parseDouble(daysapplied2));
					String monthname1="select monthname('"+firstleaveday+"') as monthname1 ,month('"+firstleaveday+"') as firstdaymonthcount ";
					ResultSet rsmonthname1=st4.executeQuery(monthname1);
					rsmonthname1.next();
					String mnth1=rsmonthname1.getString("monthname1");
					firtdayleavemnth=mnth1.substring(0,3);
					firstdaymonthcount=rsmonthname1.getInt("firstdaymonthcount");
					String monthname2="select monthname('"+reportingleaveday+"') as monthname2 ,month('"+reportingleaveday+"') as reportmonthcount ";
					ResultSet rsmonthname2=st4.executeQuery(monthname2);
					rsmonthname2.next();
					String mnth2=rsmonthname2.getString("monthname2");
					reportdayleavemnth=mnth2.substring(0,3);
					reportmonthcount=rsmonthname2.getInt("reportmonthcount");
					int datediff1=0;
					String leavedaycount="";
					int leavedaycount1=0;
					if(firtdayleavemnth.equals(reportdayleavemnth))
					{
						
						leaveday=rsleavedays.getDouble("daysapplied");
						leavedaycount=rsleavedays.getString("daysapplied");
						daysapplied1=(int) Math.round(Double.parseDouble(leavedaycount));
						if(daysapplied1 > 1)
						{
							for(int i=0;i<daysapplied1;i++)
							{
								leavedaycount="1";
								String dt1 = new SimpleDateFormat("dd-MMM-yyyy")
					               .format(new SimpleDateFormat("yyyy-MM-dd")
					                .parse(firstleaveday));
								String DayName1="SELECT DAYNAME('"+firstleaveday+"') as DayName1,DAYOFMONTH('"+firstleaveday+"') as DayCnt ,MONTHNAME('"+firstleaveday+"') as MonthName,YEAR('"+firstleaveday+"') as Year";
								ResultSet rsDayName1=st2.executeQuery(DayName1);
								String NameOfDay1="";
								String Sunday1="Sunday";
								String DayCnt1="";
								String MonthName1="";
								String Year2="";
								String daystatus="";
								
								if(rsDayName1.next())
								{
									NameOfDay1=rsDayName1.getString("DayName1");
									MonthName1=rsDayName1.getString("MonthName");
									MonthName1=MonthName1.substring(0, 3);
									Year2=rsDayName1.getString("Year");
									DayCnt1=rsDayName1.getString("DayCnt");
									if(leavedaycount.equals("0.5"))
									{	
											if(typeofleave.equals("Office work"))
											{
												daystatus="OFFALHFD";
											}
											else
											{
												daystatus="ALHFD";
											}
									}
									else if(leavedaycount.equals("1"))
									{
										if(NameOfDay1.equals(Sunday1))
												
										{
											if(typeofleave.equals("Office work"))
											{
												daystatus="OffAL";
											}
											else
											{
												daystatus="AL";
											}
										}
										
										else
										{
											if(typeofleave.equals("Office work"))
											{
												daystatus="OffAL";
											}
											else
											{
												daystatus="AL";
											}	
										}
										
									}
									String d1="D"+DayCnt1;
									String d2=d1+"="+"\'"+daystatus+"\'";
									alldays1=alldays1+","+d2;
								}
								
								String newfirstday="SELECT DATE_ADD('"+firstleaveday+"', INTERVAL 1 DAY) as NewFirstDay ";
								ResultSet rsnewfirstday=st8.executeQuery(newfirstday);
								if(rsnewfirstday.next())
								{
									firstleaveday=rsnewfirstday.getString("NewFirstDay");
									System.out.println("NewFirstDay IN Same Month  :-"+firstleaveday);
									leavedaycount="1";
								}
								
							}
						}
						else
						{
							if(daysapplied1==0)
							{
							}
							else
							{
							String DayName1="SELECT DAYNAME('"+firstleaveday+"') as DayName1,DAYOFMONTH('"+firstleaveday+"') as DayCnt ,MONTHNAME('"+firstleaveday+"') as MonthName,YEAR('"+firstleaveday+"') as Year";
							ResultSet rsDayName1=st2.executeQuery(DayName1);
							String NameOfDay1="",Sunday1="Sunday",DayCnt1="", MonthName1="",Year2="", daystatus="";
							
							if(rsDayName1.next())
							{
								NameOfDay1=rsDayName1.getString("DayName1");
								MonthName1=rsDayName1.getString("MonthName");
								MonthName1=MonthName1.substring(0, 3);
								Year2=rsDayName1.getString("Year");
								DayCnt1=rsDayName1.getString("DayCnt");
								
								if(leavedaycount.equals("0.5"))
								{
									
									if(typeofleave.equals("Office work"))
									{
										daystatus="OffALHFD";
									}
									else
									{
										daystatus="ALHFD";
									}
									
								}
								else if(leavedaycount.equals("1"))
								{
									if(typeofleave.equals("Office work"))
									{
										daystatus="OffAL";
									}
									else
									{
										daystatus="AL";
									}
								}
								
								String d1="D"+DayCnt1;
								String d2=d1+"="+"\'"+daystatus+"\'";
								alldays1=alldays1+","+d2;
								
							}
						}
						}
						leaveday2=leaveday2+leaveday;
						
						System.out.println("alldays1 in same month :- "+alldays1);
					}
					else
					{
						String lastdaycount="0";
						String daterange="select * from db_leaveapplication.t_leaverequest  WHERE '"+firstleaveday+"' < '"+fromDate+"' limit 1 "; 
						
						ResultSet rsdaterange=st7.executeQuery(daterange);
						if(rsdaterange.next())
						{
							System.out.println("in esle first if ");
							firstleaveday=fromDate;
						}			
					    String daterange1="select * from db_leaveapplication.t_leaverequest  WHERE '"+reportingleaveday+"' > '"+toDate+"'  "; 
						ResultSet rsdaterange1=st7.executeQuery(daterange1);
						if(rsdaterange1.next())
						{
							reportingleaveday=toDate;
							lastdaycount="1";
						}
						 String datediff=" select datediff('"+reportingleaveday+"','"+firstleaveday+"') as DateDiff      ";
						 ResultSet rstrpt=st2.executeQuery(datediff);
						 System.out.println("datediff====**=*********====>"+datediff);
						 if(rstrpt.next())
						 {
							 datediff1=rstrpt.getInt("DateDiff");
						 }
						 if(lastdaycount.equals("1") && datediff1 > 0 )
						 {
							 System.out.println("Inside Jugaddddddddddddd ");
							 leaveday=datediff1+1;
						 }
						 else
						 {
						if(reportingleaveday.equals(toDate) && datediff1==0 )
						{
							leaveday=Double.parseDouble(rsleavedays.getString("daysapplied"));
							
						}else
						{
						 leaveday=datediff1;
						}
						 }
						 if(leaveday > 1)
							{
								for(int i=0;i<leaveday;i++)
								{
									leavedaycount="1";
									String DayName1="SELECT DAYNAME('"+firstleaveday+"') as DayName1,DAYOFMONTH('"+firstleaveday+"') as DayCnt ,MONTHNAME('"+firstleaveday+"') as MonthName,YEAR('"+firstleaveday+"') as Year";
									ResultSet rsDayName1=st2.executeQuery(DayName1);
									String NameOfDay1="",Sunday1="Sunday", DayCnt1="", MonthName1="", Year2="",daystatus="";
									
									String dt2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(firstleaveday));
									
									if(rsDayName1.next())
									{
										NameOfDay1=rsDayName1.getString("DayName1");
										MonthName1=rsDayName1.getString("MonthName");
										MonthName1=MonthName1.substring(0, 3);
										Year2=rsDayName1.getString("Year");
										DayCnt1=rsDayName1.getString("DayCnt");
										
										if(leavedaycount.equals("0.5"))
										{
											if(typeofleave.equals("Office work"))
											{
												daystatus="OffALHFD";
											}
											else
											{
												daystatus="ALHFD";
											}
											
										}
										else if(leavedaycount.equals("1"))
										{
											if(NameOfDay1.equals(Sunday1))
												
											{
												if(typeofleave.equals("Office work"))
												{
													daystatus="OffAL";
												}
												else
												{
													daystatus="AL";
												}
												
											}
											
											else
											{
												if(typeofleave.equals("Office work"))
												{
													daystatus="OffAL";
												}
												else
												{
													daystatus="AL";
												}	
											}
										}
										
										String d1="D"+DayCnt1;
										String d2=d1+"="+"\'"+daystatus+"\'";
										alldays1=alldays1+","+d2;
									}
									
									String newfirstday="SELECT DATE_ADD('"+firstleaveday+"', INTERVAL 1 DAY) as NewFirstDay ";
									ResultSet rsnewfirstday=st8.executeQuery(newfirstday);
									if(rsnewfirstday.next())
									{
										firstleaveday=rsnewfirstday.getString("NewFirstDay");
										
									}
									
								}
							}
						 else
						 {
							 if(leaveday==0)
							 {
							 }
							 else
							 {							 
							 leavedaycount="1";
							 String DayName1="SELECT DAYNAME('"+firstleaveday+"') as DayName1,DAYOFMONTH('"+firstleaveday+"') as DayCnt ,MONTHNAME('"+firstleaveday+"') as MonthName,YEAR('"+firstleaveday+"') as Year";
								ResultSet rsDayName1=st2.executeQuery(DayName1);
								String NameOfDay1="",Sunday1="Sunday",DayCnt1="", MonthName1="",Year2="",daystatus="";
								
								String dt3 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd")
					                .parse(firstleaveday));
								
								System.out.println("Date Format  3 :-"+dt3);
								
								if(rsDayName1.next())
								{
									NameOfDay1=rsDayName1.getString("DayName1");
									MonthName1=rsDayName1.getString("MonthName");
									MonthName1=MonthName1.substring(0, 3);
									Year2=rsDayName1.getString("Year");
									DayCnt1=rsDayName1.getString("DayCnt");
									if(leavedaycount.equals("0.5"))
									{
										if(typeofleave.equals("Office work"))
										{
											daystatus="OffALHFD";
										}
										else
										{
											daystatus="ALHFD";
										}
									}
									else if(leavedaycount.equals("1"))
									{
										if(NameOfDay1.equals(Sunday1))
										{
											if(typeofleave.equals("Office work"))
											{
												daystatus="OffAL";
											}
											else
											{
												daystatus="AL";
											}	
										}
										else
										{
											if(typeofleave.equals("Office work"))
											{
												daystatus="OffAL";
											}
											else
											{
												daystatus="AL";
											}		
										}
									}
									
									String d1="D"+DayCnt1;
									String d2=d1+"="+"\'"+daystatus+"\'";
									alldays1=alldays1+","+d2;
								}
							 }
						 }
						 
						 leaveday2=leaveday2+leaveday;
						 System.out.println("alldays1 in NON NNNNNNNNNNNN same month :- "+alldays1);
					}
				}
				double  presentdays=days-leaveday2;
				if(total_task >0) {
					 a_cat_per = (a_cat * 100 / total_task1);
				 }else{
					 a_cat_per = 0.0;
				 }
				
				 if(total_task >0) {
					 b_cat_per = (b_cat * 75 / total_task1);
				 }else{
					 b_cat_per = 0.0;
				 }
				 
				if(total_task >0) {
					 c_cat_per = (c_cat * 50 / total_task1);
				 }else{
					 c_cat_per = 0.0;
				 }
				if(total_task >0) {
					 d_cat_per = (d_cat * 0 / total_task1);
				 }else{
					 d_cat_per = 0.0;
				 }
				per_index = a_cat_per + b_cat_per + c_cat_per + d_cat_per;
				System.out.println("The query is ==>>"+c_cat_per+" "+a_cat_per+" "+b_cat_per);
				String todaysDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			%>
			<tr>
			<td class="text-center"><%=++count%></td>
			<td class="text-left"><%= user_name%></td>
			<td class="text-center"><%= df.format(days)%></td>		
			<%if(total_task > 0) {  %>
				<td class="text-center"><%= (int)Math.round(total_task1)%></td>
			<%} else {%>
				<td class="text-center"><%= (int)Math.round(total_task1)%></td>
			<%} %>
			<%if(a_cat > 0) {  %>
				
				<td class="text-center"><%= df.format(a_cat)%></td>
			<%} else {
				System.out.println("The query is ==>>"+df.format(c_cat));
			%>
				<td class="text-center"><%= df.format(a_cat)%></td>
			<%} %>
			<%if(b_cat > 0) {  %>
				<td class="text-center"><%= df.format(b_cat)%></td>
			<%} else {%>
				<td class="text-center"><%= df.format(b_cat)%></td>
			<%} %>
			<%if(c_cat > 0) {  %>
				
				<td class="text-center"><%=df.format(c_cat)%></td>
			<%} else {
				System.out.println("The query is ==>>"+df.format(c_cat));
			%>
				<td class="text-center"><%=df.format(c_cat)%></td>
			<%} %>
			<%if(d_cat > 0) {  %>
				
				<td class="text-center"><%= df.format(d_cat)%></td>
			<%} else {%>
				<td class="text-center"><%= df.format(d_cat)%></td>
			<%} %>
			<td class="text-center"><%= df.format(a_cat_per) %></td>
			<td class="text-center"><%= df.format(b_cat_per) %></td>
			<td class="text-center"><%= df.format(c_cat_per) %></td>
			<td class="text-center"><%= df.format(d_cat_per) %></td>
			<td class="text-center"><%=df.format(per_index)  %></td>
			</tr>
			<%			
			if (Sesrole1.equals("Hr"))
			{
				String name23=session.getAttribute("EmpName").toString();
String maxcount="select max(Version) as Version from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"IndexMaster where EmpId='"+EmpID+"' and Month='"+mnth+"'and Year='"+rsyear.getString("year")+"' and KRAdotprojectid='"+user_id+"'";
				System.out.println("Version:"+maxcount);
				ResultSet rs21=stmt.executeQuery(maxcount);
				String version="";
				if(!rs21.next())
				{
					version="0";
				}
				else
				{
					version=rs21.getString("Version");
					if(version==null)
					{
						version="0";
					}
				}
				
				int v1=Integer.parseInt(version);
				v1++;
				String query123="select * from db_GlobalERP.UserMaster where KRAdotprojectid='"+user_id+"'";
				System.out.println("Empcode query"+query123);
				String empcode="";
				String department1="";
				
				ResultSet rs123=st9.executeQuery(query123);
				if(rs123.next())
				{
					empcode=rs123.getString("EmpCode");
					department1=rs123.getString("dept");
				}
				
				String query="Insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"IndexMaster(EmpId,EmpName,WorkingDays,ApprovedDays,PresentDays,KRAdotprojectid,KRAACategory,KRABCategory,KRACCategory,KRADCategory,KRAACategoryper,KRABCategoryper,KRACCategoryper,KRADCategoryper,PerformanceKRAIndex,Month,Year,Department,Version,EntryBy) \n"+
				"values('"+empcode+"','"+user_name+"','"+df.format(days)+"','"+df.format(leaveday2)+"','"+df.format(presentdays)+"','"+user_id+"','"+a_cat+"','"+b_cat+"','"+c_cat+"','"+d_cat+"','"+a_cat_per+"','"+b_cat_per+"','"+c_cat_per+"','"+d_cat_per+"','"+df.format(per_index)+"','"+mnth+"','"+rsyear.getString("year")+"','"+department1+"','"+v1+"','"+name23+"')";
				
				int i=0;
				 i=stmt1.executeUpdate(query);
				 
				 
				 if(i>0)
				 {
					 System.out.println("Insertion Done");
				 }
			} 
}
}//end of while
}catch(Exception e) {
	e.printStackTrace();
	System.out.println("The Exception is ==>>"+e);
}
%>
</tbody>
</table>

<%
}//end of condition
%>
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
	       /*   fixedColumns: { 
	            left: 3      //To freeze two columns
	        }, */ 
	        keys: true,  //Keytable
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
	                         title: 'KRA Index Report '+$("#month").val()+ '-' +$("#year").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'KRA Index Report '+$("#month").val()+ '-' +$("#year").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'KRA Index Report '+$("#month").val()+ '-' +$("#year").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'KRA Index Report '+$("#month").val()+ '-' +$("#year").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'KRA Index Report '+$("#month").val()+ '-' +$("#year").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script>
function confirmSubmit() {

	var dept = document.getElementById("dept").options[document.getElementById("dept").selectedIndex].value;
	if(dept=="select") {
			
			alert("Please select Department!");
		return false;
	}
	var month=document.getElementById("month").options[document.getElementById("month").selectedIndex].value;
	if(month=="Select")
		{
		alert("Please select Month!");
		return false;
		}
	var year=document.getElementById("year").options[document.getElementById("year").selectedIndex].value;
	if(year=="Select")
	{
	alert("Please select Year!");
	return false;
	}	
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>
