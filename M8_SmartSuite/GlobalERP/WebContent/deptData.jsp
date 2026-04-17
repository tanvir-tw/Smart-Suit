<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.ConnectionClass"%>

<%
Connection con = null;
Statement st4=null, st1=null, st2=null, st3=null,st5=null,st6=null;

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

} catch (Exception e) {
    e.printStackTrace();
}
%>

	<%
String cmpCode=request.getParameter("cmpName");
String deptName=request.getParameter("deptName");
String underDept=request.getParameter("underDept");
String hod=request.getParameter("hod");
System.out.println("==="+cmpCode+"===="+deptName+"====="+underDept+"====="+hod+"===");
int deptCode=0,hodid=0,headofcompanyid=0;
int underdepthodid=0;
String sendMsg="";
try
{
	String uD="";
	int ud1=0;
	if(underDept.equalsIgnoreCase("select"))
	{
		
		//String sqlqryheadofcompany="SELECT * FROM `t_ourcompanydet` WHERE CompanyCode='"+cmpCode+"'";
		String sqlqryheadofcompany= "select empid from  db_leaveapplication.t_leaveadmin where email='md@transworld-compressor.com'";
		ResultSet rsGetHead=st3.executeQuery(sqlqryheadofcompany);
		System.out.println("company Head Query-->>>>"+sqlqryheadofcompany);
		while(rsGetHead.next())
		{
			headofcompanyid=rsGetHead.getInt("empid");
		}
		System.out.println("hod emp iddd---->"+headofcompanyid);
		ud1=headofcompanyid;
	}
	else
	{
	
	int ct=0;
	String delims12 = "[,]";
	String[] tokensEmail = underDept.split(delims12);
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
	}// end of else
	String sqlGet="select max(DeptCode) as DeptCode from t_department where ComapanyCode="+cmpCode+"";
	ResultSet rsGet=st1.executeQuery(sqlGet);
	while(rsGet.next())
	{
		deptCode=rsGet.getInt("DeptCode")+1;
	}
	System.out.println("----------------->>"+deptCode);
/* 	int twEmp=Integer.parseInt(session.getAttribute("empID").toString());
 */	
	int twEmp=Integer.parseInt(session.getAttribute("leaveempID").toString());
 System.out.println("\nSession User ID ===========> "+twEmp);

	int CompCode=Integer.parseInt(cmpCode);
	///
	String sqlGetempid="select empid  from t_leaveadmin where name='"+hod+"'";
	ResultSet rsGetempid=st2.executeQuery(sqlGetempid);
	System.out.println("empid queryy---->>>>"+sqlGetempid);
	while(rsGetempid.next())
	{
		hodid=rsGetempid.getInt("empid");
	}
	System.out.println("hod emp iddd---->"+hodid);
	
	//int HOD=Integer.parseInt(hod);
	
	String sqlInsert="insert into t_department (ComapanyCode ,DeptCode, DeptName, UnderDeptCode, HODId, Status, TWEmpID) values("+CompCode+", "+deptCode+", '"+deptName+"', "+ud1+", "+hodid+", 'active', "+twEmp+")";
	String sqlInsertHistory="insert into t_departmenthistory (CompanyCode ,DeptCode, UnderDeptCode, Status, Activity, TWEmpID) values("+CompCode+", "+deptCode+", "+ud1+", 'active', 'Activated',"+twEmp+")";
	st1.executeUpdate(sqlInsert);
	st1.executeUpdate(sqlInsertHistory);
	System.out.println("insert query-->"+sqlInsert);
	System.out.println("insert history qryy--->"+sqlInsertHistory);
	/////
	String getundepthodidsql="SELECT HODId from t_department where DeptCode='"+ud1+"'";
	ResultSet rs14=st6.executeQuery(getundepthodidsql);
	System.out.println("under dept hod id id query-->"+getundepthodidsql);
	if(rs14.next())
	{
		underdepthodid=rs14.getInt("HODId");
	}
	System.out.println(" underdept hod id -->"+underdepthodid);
	
	String sqlupdateuser="update t_leaveadmin set urole='hod', ReportingtoHod='"+underdepthodid+"' where  empid='"+hodid+"'";
	System.out.println("Hod updation query------>"+sqlupdateuser);
	st5.executeUpdate(sqlupdateuser);
	
	
	///////
	sendMsg="Department Created Successfully";
	//sendMsg="Department Edited Successfully";
	response.sendRedirect("alertGoTo.jsp?msg=Department Created Successfully&goto=departmentReport.jsp");
}
catch(Exception e)
{
	System.out.println("Exception-------->>"+e);
	sendMsg="Please Try Again";
}

%>