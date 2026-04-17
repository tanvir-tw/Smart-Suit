<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ page import=" java.util.Date"%>
 <%@page import="com.ConnectionClass"%> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
<script src="js/sweetalert.js"></script>
</head>
<body>

<% 
//Variable Declaration
int p=0;
String year="",month="",day="",action="",eName="";

// Connection Initialization
Connection conn = null;
Statement st = null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;

try {
	ConnectionClass connection= new ConnectionClass();

	conn = connection.getConnect("db_GlobalERP");    
   st = conn.createStatement();
   st1=conn.createStatement();
   st2=conn.createStatement();
   st3=conn.createStatement();
   st4=conn.createStatement();
   st5=conn.createStatement();
   st6=conn.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 
 %>

<%

try{
  year=request.getParameter("year");
  month=request.getParameter("month");
  day=request.getParameter("day");
  action=request.getParameter("action");
  eName=session.getAttribute("EmpName").toString();


//Add Holiday
if(action.equals("holiday"))
{
	String date=request.getParameter("date");
	String hname=request.getParameter("mycomments");

	String query="select MONTHNAME('"+date+"') as monthname,DAYNAME('"+date+"') as dayname,Year('"+date+"') as year,NOW() as today";
	ResultSet rs=st.executeQuery(query);
	String monthname="",dayname="",today="",year1="";
	
	if(rs.next())
	{
		monthname=rs.getString("monthname");
		dayname=rs.getString("dayname");
		today=rs.getString("today");
		year1=rs.getString("year");		
	}
	today=today.substring(0,19);
	
	String chk="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster where Date='"+date+"' and Status='Yes'";
	ResultSet rs21=st1.executeQuery(chk);
	if(rs21.next())
	{
		out.println("<script type=\"text/javascript\">");
	    out.println("alert('Holiday Already Added');");
	    out.println("location='HolidayMaster1.jsp';");
	    out.println("</script>");
	}
	
	else
		
	{
	
	String insert1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster(Year,month,Day,Date,HoildayName,EntryBy,EntryDate)values('"+year1+"','"+monthname+"','"+dayname+"','"+date+"','"+hname+"','"+eName+"','"+today+"')";
	int i=0,j=0;
	String insert2="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMasterHistory(Year,month,Day,Date,HoildayName,EntryBy,EntryDate)values('"+year1+"','"+monthname+"','"+dayname+"','"+date+"','"+hname+"','"+eName+"','"+today+"')";
	j=st2.executeUpdate(insert2);
	
	System.out.println(insert1);
	i=st3.executeUpdate(insert1);
	if(i>0)
	{
		out.println("<script type=\"text/javascript\">");
		   out.println("alert('Holiday Added Successfully');");
		   out.println("location='HolidayMaster1.jsp';");
		   out.println("</script>");
	}
	}
}
//Remove
else if(action.equals("remove"))
{
	
	String srno=request.getParameter("SrNo");	
	String year1="",month1="",Day="",Date="",HoildayName="",EntryBy="",EntryDate="",status="";

	String update="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster set Status='No'  where SrNo='"+srno+"'";
	
	int i=st.executeUpdate(update);

	String getdata="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster where SrNo='"+srno+"'";
	ResultSet rs12=st1.executeQuery(getdata);
	while(rs12.next())
	{
		year1=rs12.getString("year");
		month1=rs12.getString("month");
		Day=rs12.getString("Day");
		Date=rs12.getString("Date");
		HoildayName=rs12.getString("HoildayName");
		EntryBy=rs12.getString("EntryBy");
		EntryDate=rs12.getString("EntryDate");
		status=rs12.getString("Status");
		
	}

	SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date date=new Date();
	
	String inserthistory="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMasterHistory(Year,month,Day,Date,HoildayName,EntryBy,EntryDate,Status,MasterSrNo)values('"+year1+"','"+month1+"','"+Day+"','"+Date+"','"+HoildayName+"','"+eName+"','"+sd.format(date)+"','"+status+"','"+srno+"')";
	int j=0;
	 j=st2.executeUpdate(inserthistory);
		
		System.out.println("update query:"+update);
		System.out.println("get updated data:"+getdata);
		System.out.println("history query:"+inserthistory);
		
	
	 if(j>0)
	 {
		 out.println("<script type=\"text/javascript\">");
		   out.println("alert('Removed Successfully');");
		   out.println("location='HolidayMaster1.jsp';");
		   out.println("</script>");
	 }

}

//Add Weekoff
else
{

	String arr=request.getParameter("selected");

	String[] list=arr.split(",");
	
	int selection[]=new int[list.length];
			
	for(int l=0;l<list.length;l++)
	{		
		selection[l]=Integer.parseInt(list[l]);
		
	String datetopass=year+"-"+month+"-0"+day;
	
	String weekoff="select DATE_FORMAT(DATE('"+datetopass+"'),'%Y-%m-01') as First,LAST_DAY('"+datetopass+"') as Last ";	
	System.out.println("Query is:"+weekoff);
	
	 ResultSet rs=st.executeQuery(weekoff);
	String firstday="",lastday=""; 
	
	if(rs.next())
	{
		firstday=rs.getString("First");
		lastday=rs.getString("Last");
	
	}

 String query="select DATE_ADD('"+firstday+"', INTERVAL ROW DAY) as Date, row+1  as DayOfMonth from  ( SELECT @row := @row + 1 as row FROM  (select 0 union all select 1 union all select 3          union all select 4 union all select 5 union all select 6) t1, (select 0 union all select 1 union all select 3          union all select 4 union all select 5 union all select 6) t2,  (SELECT @row:=-1) t3 limit 31 ) b where  DATE_ADD('"+firstday+"', INTERVAL ROW DAY) between '"+firstday+"' and '"+lastday+"' and DAYOFWEEK(DATE_ADD('"+firstday+"', INTERVAL ROW DAY))='"+day+"'";

System.out.println("query is:"+query); 

ResultSet rs1=st1.executeQuery(query);
String d[]=new String[10];
int i=1;

String query12="select MONTHNAME('"+datetopass+"') as Month,NOW() as Today";

ResultSet rs2=st2.executeQuery(query12);
String monthname="",dayname="",today="";

if(rs2.next())
{
	monthname=rs2.getString("Month");
	today=rs2.getString("Today");
}

String MonthName="",Year1="",WeekDay="";
int j=0;

while(rs1.next())
{
	d[i]=rs1.getString("DayOfMonth");
	
	WeekDay=rs1.getString("Date");
	
    String DayName="SELECT DAYNAME('"+WeekDay+"') as DayName1,DAYOFMONTH('"+WeekDay+"') as DayCnt ,MONTHNAME('"+WeekDay+"') as MonthName,YEAR('"+WeekDay+"') as Year";
		ResultSet rsDayName=st3.executeQuery(DayName);
		System.out.println("DayName :-"+DayName);
		String NameOfDay="";
		String Sunday="Sunday";
		String DayCnt="";
		if(rsDayName.next())
		{
			NameOfDay=rsDayName.getString("DayName1");
			MonthName=rsDayName.getString("MonthName");
			MonthName=MonthName.substring(0, 3);
			Year1=rsDayName.getString("Year");
	
			DayCnt=rsDayName.getString("DayCnt");

		}
		
		
		String currYear=Year1;
		String Month=MonthName;
		
	 String dt1=today.substring(0,19);

	String chkvali="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster where Year='"+year+"' and month='"+monthname+"' and  date='"+WeekDay+"' and Status='Yes' " ;

	System.out.println("Quert for validation:"+chkvali);

	ResultSet rs21=st4.executeQuery(chkvali);

	if(rs21.next())
	{
				
			   out.println("<script type=\"text/javascript\">");
			   out.println("alert('WeekOff Already Added');");
			   out.println("location='HolidayMaster1.jsp';");
			   out.println("</script>");
	
	}

	 else
	{
		if(selection[l]==i)
		
		{
		
	String insert1="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMaster(Year,month,Day,Date,HoildayName,EntryBy,EntryDate)values('"+year+"','"+monthname+"','"+NameOfDay+"','"+WeekDay+"','WeekOff','"+eName+"','"+dt1+"')";

	String insert2="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"HolidayMasterHistory(Year,month,Day,Date,HoildayName,EntryBy,EntryDate)values('"+year+"','"+monthname+"','"+NameOfDay+"','"+WeekDay+"','WeekOff','"+eName+"','"+dt1+"')";

	System.out.println("Master :- "+insert1);
	System.out.println("History :- "+insert2);

	p=st5.executeUpdate(insert1);

	j=st6.executeUpdate(insert2);
		}
	
}

	i++;
   }

  }

   }

 if(p>=1)
{
	 out.println("<script type=\"text/javascript\">");
		out.println("alert('WeekOff Added Successfully');");
		out.println("window.location='HolidayMaster1.jsp';"); // Redirect only after user clicks OK
		   out.println("</script>");
}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>

</body>
</html>