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
<script src="jsnew/sweetalert.js"></script>
</head>
<body>
<% 
//Variable Declaration
String EntryBy = session.getAttribute("EmpName").toString();
String action="",dtdt="",dt1dt1="",departmentNew1="",id2="",date2="",dt9="",dt24="";
String UserName="",CustomerName="",CheckIn="",CheckOut="",ActualWorkHrs="",Day="",DutyIn="",DutyOut="",WorkingHrs="";

// Connection Initialization
Connection conn = null;
Statement st = null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null;

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
   st7=conn.createStatement();

} catch (Exception e) {
   e.printStackTrace();
} 
 %>
 
<%

try{

 action=request.getParameter("action");

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
Date date1 = new Date();
 dtdt = request.getParameter("checkDate");
 dt1dt1=request.getParameter("checkDate1");
 departmentNew1=request.getParameter("departmentNew");
 id2=request.getParameter("id");
 date2=request.getParameter("date");
 dt9 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
       .parse(date2));
String dt10[]=dt9.split("-");
String dtfinal=dt10[1];String currentt="";String current="";

 dt24 = new SimpleDateFormat("yyyy-M-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
       .parse(date2));
String monthsplit[]=dt24.split("-");
String year1=monthsplit[0];
String month4=monthsplit[1];
int month2=Integer.parseInt(month4);
System.out.println("month2 is:" + month2);
int year2=Integer.parseInt(year1);
System.out.println("year2 is:-"+ year2);

//************************************logic to calculate count of approvals for financial year*****************//
int maxapproval=6;
int yr1=0,yr2=0;
if(month2>3){
	 yr1=year2;
	 System.out.println("year1 is:-"+ yr1);
	    
	 yr2=year2+1;
	System.out.println("year2final is:-"+ yr2);
	  
}
else
{
	 yr1=year2-1;
	 System.out.println("year1 for less than 3 is:-"+ yr1);
	 yr2=year2;
	 System.out.println("year2final for less than 3 is:-"+ yr2);
	
}

String y1=Integer.toString(yr1);

String y2=Integer.toString(yr2);
String frdate=y1+"-"+"04"+"-"+"01";

String todate=y2+"-"+"03"+"-"+"31";


String sql="select count(*) as count from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster where  EntryDate >='"+frdate+" "+"00:00:00"+"' and EntryDate <='"+todate+" "+"23:59:59"+"' and ID='"+id2+"' and NewStatus!='-' ";
System.out.println("sql is:"+sql);
ResultSet rsStatus2=st.executeQuery(sql);
while(rsStatus2.next())
{
current=rsStatus2.getString("count");
System.out.println("current is" + current);
}
int current2=Integer.parseInt(current);
System.out.println("current2 is-->>" + current2);

int pending=maxapproval-current2;
System.out.println("pending is:"+pending);	
		
//************************************logic to calculate count of approvals for selected month*****//
String sql8="select DATE_FORMAT(DATE('"+dt9+"'),'%Y-%m-01') as First,LAST_DAY(DATE_FORMAT(DATE('"+dt9+"'),'%Y-%m-01')) as Last,NOW() As Today";
System.out.println("sql8 is"+ sql8);
ResultSet rsStatus6=st1.executeQuery(sql8);
String Last="";
String First="";
if(rsStatus6.next())
{
 Last=rsStatus6.getString("Last");
System.out.println("last is" + Last);
 First=rsStatus6.getString("First");
System.out.println("First is" + First);
}

String sql4="select count(*) as count from  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster where   STR_TO_DATE(Date,'%d-%b-%Y') >='"+First+" "+"00:00:00"+"' and  STR_TO_DATE(Date,'%d-%b-%Y') <='"+Last+" "+"23:59:59"+"' and ID='"+id2+"' and NewStatus!='-' ";
System.out.println("sql is:"+sql4);
ResultSet rsStatus4=st2.executeQuery(sql4);

while(rsStatus4.next())
{
currentt=rsStatus4.getString("count");
System.out.println("current is" + currentt);
}


int countselcurrmon=Integer.parseInt(currentt);

System.out.println("new current4 is-->>" + countselcurrmon);

if((countselcurrmon==0) && (pending>0)){


if(action.equals("Approve"))
{

String id=request.getParameter("id");
String name=request.getParameter("Name");
String preStatus=request.getParameter("preStatus");
String newStatus=request.getParameter("newStatus");
String date=request.getParameter("date");

String Comments=request.getParameter("comment");
String dt = request.getParameter("checkDate");
String dt1=request.getParameter("checkDate1");
String departmentNew=request.getParameter("departmentNew");

System.out.println("checkDate is:"+dt);

System.out.println("checkDate 1  is:"+dt1);


 String dt2 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
        .parse(date));
 
 
String month="",Year="";
String countday="SELECT DAYNAME('"+dt2+"') as DayName1,DAYOFMONTH('"+dt2+"') as DayCnt ,MONTHNAME('"+dt2+"') as MonthName,YEAR('"+dt2+"') as Year";
System.out.println(countday);
ResultSet rs12=st3.executeQuery(countday);
if(rs12.next())
{
	month=rs12.getString("MonthName");
	Year=rs12.getString("Year");
}
month=month.substring(0,3);
System.out.println("MOnth is:"+month);
System.out.println("Year is:"+Year);


System.out.println(date);

String str="select EmpID as ID,EmpName as USerName,Name,EntryComments as Comments,CustomerName,DATE_FORMAT(checkDate,'%d-%b-%Y') as Date,min(checkTime) as CheckIn,max(checkTime) as CheckOut,TIME_FORMAT(TIMEDIFF(max(checkTime),min(checkTime)),'%T') as ActualWorkHrs,DAYNAME(checkDate) as Day,TIME_FORMAT(LEAST(max(checkTime),TOut),'%T') as DutyOut,TIME_FORMAT(GREATEST(min(checkTime),TIn),'%T')as DutyIn,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as WorkingHours,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as Status,'"+month+"' as Month ,'"+Year+"' as Year  from db_leaveapplication.t_checkinout where EmpID in (select EmpID from db_leaveapplication.t_leaveadmin where status = 'Yes' and TypeValue like '%%' and EmpID='"+id+"') and checkDate ='"+dt1+"'group by checkDate ,EmpID ";

System.out.println(str);
ResultSet rs1=st4.executeQuery(str);
if(rs1.next())
{
	UserName=rs1.getString("USerName");
	CustomerName=rs1.getString("CustomerName");
	CheckIn=rs1.getString("CheckIn");
	CheckOut=rs1.getString("CheckOut");
	ActualWorkHrs=rs1.getString("ActualWorkHrs");
	Day=rs1.getString("Day");
	DutyIn=rs1.getString("DutyIn");
	DutyOut=rs1.getString("DutyOut");
	WorkingHrs=rs1.getString("WorkingHours");
	
}

String query="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster where ID='"+id+"' and Month='"+month+"' and Year='"+Year+"'and Date='"+date+"'";

String histquery="";

System.out.println(query);
String sql_query="";

ResultSet rs123=st5.executeQuery(query);
if(rs123.next())
{
	
	sql_query="update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster set NewStatus='"+newStatus+"',EntryBy='"+EntryBy+"',Comments='"+Comments+"' where ID='"+id+"' and Month='"+month+"' and Year='"+Year+"'and Date='"+date+"'";

}

else
{
	sql_query="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster(ID,UserName,Name,CustomerName,Date,CheckIn,CheckOut,ActualWorkHrs,Day,DutyOut,DutyIn,WorkingHours,Status,Month,Year,EntryBy,Comments,NewStatus,EntryDate)values('"+id+"','"+UserName+"','"+name+"','"+CustomerName+"','"+date+"','"+CheckIn+"','"+CheckOut+"','"+ActualWorkHrs+"','"+Day+"','"+DutyOut+"','"+DutyIn+"','"+WorkingHrs+"','"+preStatus+"','"+month+"','"+Year+"','"+EntryBy+"','"+Comments+"','"+newStatus+"','"+formatter.format(date1)+"')";
	
}

System.out.println(sql_query);
int i=0;
i=st6.executeUpdate(sql_query);
if(i>0)
{
	System.out.println("Query done");
}

histquery="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMasterHistory(ID,UserName,Name,CustomerName,Date,CheckIn,CheckOut,ActualWorkHrs,Day,DutyOut,DutyIn,WorkingHours,Status,Month,Year,EntryBy,Comments,NewStatus,EntryDate) select ID,UserName,Name,CustomerName,Date,CheckIn,CheckOut,ActualWorkHrs,Day,DutyOut,DutyIn,WorkingHours,Status,Month,Year,EntryBy,Comments,NewStatus,EntryDate from 100000AttendanceStatusMaster where ID='"+id+"' and Month='"+month+"' and Year='"+Year+"'and Date='"+date+"'";
System.out.println(histquery);

int j=0;
j=st7.executeUpdate(histquery);
if(j>0)
{
	
	
	out.println("<script type=\"text/javascript\">");
	   out.println("alert('Status Changed');");

	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("window.location='AttendanceReport.jsp?chkdate="+dt+"&chkdate1="+dt1+"&departmentNew="+departmentNew+"';");
		out.println("});");

	   out.println("</script>");
	System.out.println("Status Change");
}
}
}
else
{
	out.println("<script type=\"text/javascript\">");
	   out.println("alert('You have exceeded the count of approvals');");
	   
	  // swal("Good job!", "You clicked the button!", "success");
	   out.println("window.location='AttendanceReport.jsp?chkdate="+dtdt+"&chkdate1="+dt1dt1+"&departmentNew="+departmentNew1+"';");
	   out.println("</script>");
	System.out.println("Status Change");
	
}
}
catch(Exception e)
{
	e.printStackTrace();
}

%>

</body>
</html>