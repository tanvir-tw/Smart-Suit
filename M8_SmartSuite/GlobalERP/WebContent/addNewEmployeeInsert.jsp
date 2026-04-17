<%@page import="com.ConnectionClass"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn= null;
	ConnectionClass conneciton = new ConnectionClass();
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st14=null,st15=null,
			st16=null,st17=null,st18=null,st19=null,st20=null,st21=null,st22=null,st23=null,st24=null, st13=null;
	//st10=null,st11=null,st12=null,;

	try{
		conn = conneciton.getConnect("db_leaveapplication");
		
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
		st11=conn.createStatement();
		st12=conn.createStatement();
		st14=conn.createStatement();
		st15=conn.createStatement();
		st13=conn.createStatement();
		st16=conn.createStatement();
		st17=conn.createStatement();
		st18=conn.createStatement();
		st19=conn.createStatement();
		st20=conn.createStatement();
		st21=conn.createStatement();
		st22=conn.createStatement();
		st23=conn.createStatement();
		st24=conn.createStatement();
		
	}catch(Exception e){
		e.printStackTrace();
	}
String action=request.getParameter("action");
System.out.print("action======"+action);

if(action.contains("addemp"))
{
	int currentHodId=0;
	String currentHodEmailId="",newHodId="",newHodEmailId="";
String confirm=request.getParameter("confirm");
out.println("confirm"+confirm);

String name=request.getParameter("name");
String cName=request.getParameter("cName");
System.out.println("name"+name+ "cname"+cName);
String username=request.getParameter("username");
String email=request.getParameter("email");
out.println("username"+username);
String pass=request.getParameter("pass");
out.println("pass"+pass);
String typeOfUser=request.getParameter("typeOfUser");
out.println("typeOfUser"+typeOfUser);
String deptCode=request.getParameter("deptName");
System.out.println("Department_selected---->"+deptCode);
String empid=request.getParameter("empid");
String hod=request.getParameter("hodid");
System.out.println("hod"+hod);
String typeofleave="",inserted="";
String weekoff=request.getParameter("weekoff");
System.out.println("weekoff======"+weekoff);
Boolean innerflag=false;

int reportigHodId=0;
String deptName="",underdeptcode="";
 int respectivehodId=0;
String sqldeptName="select deptName from t_department where DeptCode='"+deptCode+"'  and status='Active'";

ResultSet rs7=st1.executeQuery(sqldeptName);
System.out.println("sql query-- for dept name-> "+sqldeptName);
if(rs7.next())
{
	deptName=rs7.getString("deptName");
}
System.out.println("deptName--->"+deptName);

if(typeOfUser.equalsIgnoreCase("contractor"))
{
	System.out.println("Inside contractor");
	String sqlreportingHodId="SELECT HODId FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st2.executeQuery(sqlreportingHodId);
	System.out.println("Inside contractor"+sqlreportingHodId);
	if(rs6.next())
	{
		reportigHodId=rs6.getInt("HODId");
	}
	System.out.println("Inside contractor"+reportigHodId);

}
else
{
	System.out.println("Inside HOD");
	String sqlreportingHodId="SELECT UnderDeptCode FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st3.executeQuery(sqlreportingHodId);

	if(rs6.next())
	{
		underdeptcode=rs6.getString("UnderDeptCode");
	}

	System.out.println("Inside UnderDeptCode"+underdeptcode);
	
	String sqlrespectiveHodID="SELECT HODId from t_department where DeptCode='"+underdeptcode+"'";
	
	ResultSet rs8=st4.executeQuery(sqlrespectiveHodID);
	
	if(rs8.next())
	{
		reportigHodId=rs8.getInt("HODId");
	}
	reportigHodId=Integer.parseInt(hod);

	System.out.println("Inside UnderDeptCode1"+reportigHodId);
	//updating hod  for department and leaverequest
	
	String getdepthodsql="SELECT HODId from t_department where DeptCode='"+deptCode+"'";
	ResultSet rs9=st5.executeQuery(getdepthodsql);
	System.out.println("current hod id query-->"+getdepthodsql);
	if(rs9.next())
	{
		currentHodId=rs9.getInt("HODId");
	}
	currentHodId=Integer.parseInt(hod);

	System.out.println(" current Hod Id -->"+currentHodId);
	String getdepthodemailsql="SELECT email from t_leaveadmin where empid='"+currentHodId+"' and status='Yes'";
	ResultSet rs10=st6.executeQuery(getdepthodemailsql);
	System.out.println("current hod email id query-->"+getdepthodemailsql);
	if(rs10.next())
	{
		currentHodEmailId=rs10.getString("email");
	}
	
	String updateleavereqhodemailsql="update t_leaverequest set hod='"+currentHodEmailId+"' where emailid='"+email+"'";
	 int suc=st11.executeUpdate(updateleavereqhodemailsql);
	System.out.println("leave request update query ---->"+updateleavereqhodemailsql+"      ---flag--"+suc); 
	
	String updatedepthodemailsql="update t_department set hodid='"+empid+"' where DeptCode='"+deptCode+"'";
 	int suc1=st11.executeUpdate(updatedepthodemailsql);
	System.out.println("department update query ---->"+updatedepthodemailsql+"---flag--"+suc1); 
	
	/*  Assigining previous Hod as contractor  */
	String updateleaveadminHodsql="update t_leaveadmin set urole=' contractor' where email='"+currentHodEmailId+"'";
 	int suc2=st7.executeUpdate(updateleaveadminHodsql);
	System.out.println("previous Hod updation update query ---->"+updateleaveadminHodsql+"---flag--"+suc2);
	 
	/*  code for updating reporting to hod for all User in that Department */

// 	String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+empid+"' where  typevalue='"+deptName+"'";
	String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+hod+"' where  empid='"+empid+"'";

	System.out.println("Reporting to hod  updation query------>"+sqlupdateReportingtoHoduser);
	int flgforreport=st8.executeUpdate(sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod query--->"+sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod count"+flgforreport); 

	
	
}//end of Hod else

java.util.Date d= new java.util.Date();
out.println(d);
String datetoday=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
out.println(datetoday);
Boolean flag=false;
String sql1="select * from t_leaveadmin where empid='"+empid+"'";
ResultSet rs=st9.executeQuery(sql1);
if(rs.next()){
	response.sendRedirect("addNewEmployee.jsp?already=yes");
	
}
else
{
	reportigHodId=Integer.parseInt(hod);
	System.out.println("Inside insertquery reportigHodId"+reportigHodId);

	System.out.println("Inside insertquery");
String sql="insert into t_leaveadmin(empid,Name,UName,pass,Email,URole,TypeValue,weekOff,ERPUser,reportingtohod) values ('"+empid+"','"+cName+"','"+username+"','"+pass+"','"+email+"','"+typeOfUser+"','"+deptName+"','"+weekoff+"','"+session.getAttribute("leaveempname")+"','"+reportigHodId+"')  ";
String sqlInsertHistory="insert into t_leaveadminhistory(empid,Name,UName,pass,Email,URole,TypeValue,weekOff,ERPUser) values ('"+empid+"','"+cName+"','"+username+"','"+pass+"','"+email+"','"+typeOfUser+"','"+deptName+"','"+weekoff+"','"+session.getAttribute("leaveempname")+"')";

out.println("sql--->"+sql);
 int i=0;
i=st10.executeUpdate(sql);
st4.executeUpdate(sqlInsertHistory);
System.out.println("Inside contractor-->Insert query"+sql);
System.out.println("Inside contractor"+sqlInsertHistory); 
response.sendRedirect("alertGoTo.jsp?msg=Contractor Added successfully &goto=employeeReport.jsp");

}
}//end of add employee


///*********************** Edit employee code ********************
if(action.contains("editemp"))
{
	int currentHodId=0;
	String currentHodEmailId="",newHodId="",newHodEmailId="";
	//String currentHodId="",currentHodEmailId="",newHodId="",newHodEmailId="";
	System.out.print("edit");

	String EmpID=request.getParameter("EmpID");
	String Name=request.getParameter("Name");
	String UName=request.getParameter("UName");
	String URole=request.getParameter("URole");
	String Email=request.getParameter("Email");
	String TypeValue=request.getParameter("TypeValue");
	String weekOff=request.getParameter("weekOff");
	String reportingto=request.getParameter("reportingto");
	String deptCode=request.getParameter("deptName");
	System.out.println("Department_selected---->"+deptCode);
	String empid=request.getParameter("empid");
	String user_status=request.getParameter("status");
	out.println("User Status--->"+user_status);
	
	String hod=request.getParameter("hodid");
	System.out.println("hod"+hod);
////////////


int reportigHodId=0;
String deptName="",underdeptcode="";

String sqldeptName="select deptName from t_department where DeptCode='"+deptCode+"'  and status='Active'";

ResultSet rs7=st11.executeQuery(sqldeptName);
if(rs7.next())
{
	deptName=rs7.getString("deptName");
}
System.out.println("deptName--->"+deptName);



if(URole.equalsIgnoreCase("contractor"))
{
	System.out.println("Inside contractor");
	String sqlreportingHodId="SELECT HODId FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st12.executeQuery(sqlreportingHodId);
	System.out.println("Inside contractor"+sqlreportingHodId);
	if(rs6.next())
	{
		reportigHodId=rs6.getInt("HODId");
	}
	reportigHodId=Integer.parseInt(hod);

	System.out.println("Inside contractor"+reportigHodId);

	
	//New code added to update hod id

	String getdepthodemailsql="SELECT email from t_leaveadmin where empid='"+reportigHodId+"'  and status='Yes'";
	ResultSet rs10=st13.executeQuery(getdepthodemailsql);
	System.out.println("current hod email id query-->"+getdepthodemailsql);
	if(rs10.next())
	{
		currentHodEmailId=rs10.getString("email");
	}

	String updateleavereqhodemailsql="update t_leaverequest set hod='"+currentHodEmailId+"' where emailid='"+Email+"'";
	int suc=st11.executeUpdate(updateleavereqhodemailsql);
	System.out.println("leave request update query ---->"+updateleavereqhodemailsql+"---flag--"+suc);

	
}
else
{
	System.out.println("Inside HOD");
	String sqlreportingHodId="SELECT UnderDeptCode FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st14.executeQuery(sqlreportingHodId);

	if(rs6.next())
	{
		underdeptcode=rs6.getString("UnderDeptCode");
	}

	System.out.println("Inside UnderDeptCode"+underdeptcode);
	
	String sqlrespectiveHodID="SELECT HODId from t_department where DeptCode='"+underdeptcode+"'";
	
	ResultSet rs8=st15.executeQuery(sqlrespectiveHodID);
	
	if(rs8.next())
	{
		reportigHodId=rs8.getInt("HODId");
	}
	reportigHodId=Integer.parseInt(hod);

	System.out.println("Inside UnderDeptCode1"+reportigHodId);
	
//updating hod  for department and leaverequest
	
	String getdepthodsql="SELECT HODId from t_department where DeptCode='"+deptCode+"'";
	ResultSet rs9=st16.executeQuery(getdepthodsql);
	System.out.println("current hod id query-->"+getdepthodsql);
	if(rs9.next())
	{
		currentHodId=rs9.getInt("HODId");
	}
	currentHodId=Integer.parseInt(hod);

	System.out.println(" current Hod Id -->"+currentHodId);
	String getdepthodemailsql="SELECT email from t_leaveadmin where empid='"+currentHodId+"'  and status='Yes'";
	ResultSet rs10=st17.executeQuery(getdepthodemailsql);
	System.out.println("current hod email id query-->"+getdepthodemailsql);
	if(rs10.next())
	{
		currentHodEmailId=rs10.getString("email");
	}
	String updateleavereqhodemailsql="update t_leaverequest set hod='"+currentHodEmailId+"' where emailid='"+Email+"'";
	int suc=st18.executeUpdate(updateleavereqhodemailsql);
	System.out.println("leave request update query ---->"+updateleavereqhodemailsql+"---flag--"+suc);
	
	String updateDepthodemailsql="update t_department set hodid='"+EmpID+"' where DeptCode='"+deptCode+"'";
	int suc1=st19.executeUpdate(updateDepthodemailsql);
	System.out.println("leave request update query ---->"+updateDepthodemailsql+"---flag--"+suc1);
	/*  Assigining previous Hod as contractor  */
	String updateleaveadminHodsql="update t_leaveadmin set urole=' contractor' where email='"+currentHodEmailId+"'";
	int suc2=st20.executeUpdate(updateleaveadminHodsql);
	System.out.println("previous Hod updation update query ---->"+updateleaveadminHodsql+"---flag--"+suc2);
		//String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+EmpID+"' where  typevalue='"+deptName+"'";
	String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+hod+"' where  empid='"+EmpID+"'";

		System.out.println("Reporting to hod  updation query------>"+sqlupdateReportingtoHoduser);
	int flgforreport=st21.executeUpdate(sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod query--->"+sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod count"+flgforreport);

}//end of HOD else

	try
	{
		String pass="";
		reportigHodId=Integer.parseInt(hod);

		String sql="select * from t_leaveadmin where empid='"+EmpID+"'";
		
		ResultSet rs=st22.executeQuery(sql);
		while(rs.next())
		{
			pass=rs.getString("pass");
		}
		String sqledit="update t_leaveadmin set Name='"+Name+"',UName='"+UName+"',Email='"+Email+"',URole='"+URole+"',TypeValue='"+deptName+"',weekOff='"+weekOff+"',ERPUser='"+session.getAttribute("leaveempname")+"',reportingtohod='"+reportigHodId+"',status='"+user_status+"' where EmpID='"+EmpID+"'";
		System.out.println("sqledit======update query ****************************************** "+sqledit);
		String sqlInsertHistory="insert into t_leaveadminhistory(empid,Name,UName,pass,Email,URole,TypeValue,weekOff,ERPUser,status) values ('"+EmpID+"','"+Name+"','"+UName+"','"+pass+"','"+Email+"','"+URole+"','"+deptName+"','"+weekOff+"','"+session.getAttribute("leaveempname")+"','"+user_status+"')";
		
		st23.executeUpdate(sqledit);
		st24.executeUpdate(sqlInsertHistory);
				
	}
	catch(Exception e)
	{
		System.out.println("Exception-------->>"+e);
	}
	finally
	{
		conn.close();
		response.sendRedirect("alertGoTo.jsp?msg=Contractor successfully updated&goto=employeeReport.jsp");
	}
}

%>
</body>
</html>