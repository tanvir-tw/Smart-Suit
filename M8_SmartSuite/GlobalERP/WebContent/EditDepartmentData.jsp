<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.ConnectionClass"%>

<%
Connection con = null;
Statement st4=null, st1=null, st2=null, st3=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null;
try {
 ConnectionClass connection = new ConnectionClass();
	 con = connection.getConnect("db_leaveapplication");
	System.out.println("con :::::::::::::::::: " + con);

    
    st1 = con.createStatement();
    st2 = con.createStatement();
    st3 = con.createStatement(); 
    st4= con.createStatement();
    st5= con.createStatement();
    st6= con.createStatement();
    st7=con.createStatement();
    st8=con.createStatement();
    st9=con.createStatement();
    st10=con.createStatement();
    st11=con.createStatement();

} catch (Exception e) {
    e.printStackTrace();
}
%>

	<%
//String dcode=request.getParameter("deptcode");
String department=request.getParameter("dept");
String dcode=request.getParameter("deptcode");
String cmpName=request.getParameter("cmpName");
String cmpCode=request.getParameter("cmpcode");
String undDeptCode=request.getParameter("underDept");
String hodCode=request.getParameter("hod");
String status=request.getParameter("status");
//String action=request.getParameter("action");
String sqlUpdate="",currentHodEmailId="",previousHodEmailId="";
int currentHodId=0,underdepthodid=0;
	
System.out.print("under edit department");
System.out.println("deptcode======"+department+"==== cmpCode-------"+cmpCode+"===undDeptCode==="+undDeptCode+"====hodCode===="+hodCode+"====status====="+status+"======");

int deptCode=0,ud1=0;
String sendMsg="";
String cCode="",dCode="";
int twEmp1=0,CompCode1=0,HOD1=0,underDeptCode1=0,hodid=0;
try
{
	int ct=0;
	String delims12 = "[,]";
	String uD="";
	String[] tokensEmail = undDeptCode.split(delims12);
	for(String t : tokensEmail)
	{
		if(ct==0)
		{
			uD=t;
		}
		else
		{
			//CompCode=t;
		}
		ct++;
		
	}
	ud1=Integer.parseInt(uD);
	System.out.println("underdepartment code:-------------->"+ud1);

 twEmp1=Integer.parseInt(session.getAttribute("leaveempID").toString());
CompCode1=Integer.parseInt(cmpCode);
	deptCode=Integer.parseInt(dcode);
	String sqlGetempid="select empid  from t_leaveadmin where name='"+hodCode+"'";
	ResultSet rsGetempid=st3.executeQuery(sqlGetempid);
	System.out.println("empid queryy---->>>>"+sqlGetempid);
	while(rsGetempid.next())
	{
		hodid=rsGetempid.getInt("empid");
	}
	System.out.println("hod emp iddd---->"+hodid);
	
	
}catch(Exception e)
{
	System.out.println("Exception 123-------->>"+e);
	
}
try
{
	System.out.print("111");
	
String getdepthodsql="SELECT HODId from t_department where DeptCode='"+deptCode+"'";
ResultSet rs9=st4.executeQuery(getdepthodsql);
System.out.println("current hod id query-->"+getdepthodsql);
if(rs9.next())
{
	currentHodId=rs9.getInt("HODId");
}
System.out.println(" current Hod Id -->"+currentHodId);

String getprevhodemailsql="SELECT email from t_leaveadmin where empid='"+currentHodId+"'";
ResultSet rs10=st5.executeQuery(getprevhodemailsql);
System.out.println("current hod id query-->"+getprevhodemailsql);
if(rs10.next())
{
	previousHodEmailId=rs10.getString("email");
}
System.out.println(" prev  Hod email Id -->"+previousHodEmailId);


String getdepthodemailsql="SELECT email from t_leaveadmin where name='"+hodCode+"'  and status='Yes'";
ResultSet rs11=st6.executeQuery(getdepthodemailsql);
System.out.println("current hod email id query-->"+getdepthodemailsql);
if(rs11.next())
{
	currentHodEmailId=rs11.getString("email");
}
String updateleavereqhodemailsql="update t_leaverequest set hod='"+currentHodEmailId+"' where hod='"+previousHodEmailId+"'";
 int suc=st7.executeUpdate(updateleavereqhodemailsql);
System.out.println("leave request update query ---->"+updateleavereqhodemailsql+"---flag--"+suc); 

	System.out.print("222");
	String sqlInsert="update t_department set DeptName='"+department+"',UnderDeptCode='"+ud1+"', HODId='"+hodid+"', Status='"+status+"', TWEmpID='"+twEmp1+"' where  ComapanyCode='"+CompCode1+"' and DeptCode='"+deptCode+"'";
	System.out.println("department updation query-->"+sqlInsert);
	String sqlInsertHistory="insert into t_departmenthistory (CompanyCode ,DeptCode, UnderDeptCode, Status, Activity, TWEmpID) values("+CompCode1+", "+deptCode+", "+ud1+", '"+status+"', 'updated',"+twEmp1+")";
	st1.executeUpdate(sqlInsert);
	st2.executeUpdate(sqlInsertHistory);
	System.out.println("department history insert qry-->"+sqlInsertHistory);
	String getundepthodidsql="SELECT HODId from t_department where DeptCode='"+ud1+"'";
	ResultSet rs14=st9.executeQuery(getundepthodidsql);
	System.out.println("under dept hod id id query-->"+getundepthodidsql);
	if(rs14.next())
	{
		underdepthodid=rs14.getInt("HODId");
	}
	System.out.println(" underdept hod id -->"+underdepthodid);
	
	String sqlupdateuser="update t_leaveadmin set urole='hod', ReportingtoHod='"+underdepthodid+"' where  empid='"+hodid+"'";
	System.out.println("Hod updation query------>"+sqlupdateuser);

	int flghod=st8.executeUpdate(sqlupdateuser);
	System.out.println("Hod updation query--- Count--->"+flghod); 
	/*  Assigining previous Hod as contractor  */
	String updateleaveadminHodsql="update t_leaveadmin set urole=' contractor' where email='"+previousHodEmailId+"'";
	int suc2=st11.executeUpdate(updateleaveadminHodsql);
	System.out.println("previous Hod updation update query ---->"+updateleaveadminHodsql+"---flag--"+suc2);
	
	/*  code for updating reporting to hod for all User in that Department */
	
	String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+hodid+"' where  typevalue='"+department+"' and urole!='hod'";
	System.out.println("Reporting to hod  updation query------>"+sqlupdateReportingtoHoduser);
 int flgforreport=st10.executeUpdate(sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod query--->"+sqlupdateReportingtoHoduser); 
	System.out.println("updated reporting to hod count"+flgforreport); 
	sendMsg="Department Edited Successfully";
	response.sendRedirect("alertGoTo.jsp?msg=Department Report Updated Successfully&goto=departmentReport.jsp");
	
}
catch(Exception e)
{
	System.out.println("Exception-------->>"+e);
	sendMsg="Please Try Again";
}
%>