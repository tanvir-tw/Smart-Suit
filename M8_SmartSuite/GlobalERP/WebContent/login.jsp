<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@page import="com.ConnectionClass"%>

<%!
//Connection Initialization
Connection conn = null;
Connection conn1 = null;
Statement st1 = null,st2=null,st3=null,st4=null,stdate=null, stleave=null;
String empCode ="";
%>

<%
try {
    ConnectionClass connection= new ConnectionClass();
    conn = connection.getConnect("db_GlobalERP");
    conn1 = connection.getConnect("db_leaveapplication");
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    stdate = conn.createStatement();
    stleave = conn1.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 
%>
<%
try{

int UserTypeCode=0;
String username=request.getParameter("username");
String pass=request.getParameter("pass");
String sessionid=session.getId().toString();
String updated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String 	clientip=request.getRemoteAddr();

PreparedStatement pst=conn.prepareStatement("select * from UserMaster where UserName="+"?"+" and binary password="+"?"+"and ActiveStatus="+"?"+"");
pst.setString(1,username);
pst.setString(2,pass);
pst.setString(3,"Yes");
System.out.println("Entry");

ResultSet rst=pst.executeQuery();

if(rst.next())
{
	
	   	empCode = rst.getString("EmpCode");
	    System.out.println("EmpCode : " + empCode);
	
	UserTypeCode=Integer.parseInt(rst.getString("UserTypeCode"));
	session.setAttribute("user",username);
	System.out.println("USERNAME=>"+session.getAttribute("user"));
	session.setAttribute("userLevel",rst.getString("UserLevel"));
	session.setAttribute("role",rst.getString("Role"));
	session.setAttribute("EMP_FullNAME",rst.getString("EmpName"));
	session.setAttribute("CompanyMasterID", rst.getString("companymasterid"));
	session.setAttribute("flag","flag");
	session.setAttribute("department",rst.getString("dept"));
	
	
	try{
		String sqlDeatils13="select * from db_GlobalERP.UserTypeMaster as a, db_GlobalERP.AccesControlList as b where a.UserTypeCode="+UserTypeCode+" and a.AccessCode=b.AccessCode";
		System.out.println("*********"+sqlDeatils13);
		ResultSet rsDetails123=st3.executeQuery(sqlDeatils13);
		if(rsDetails123.next())
		{
					session.setAttribute("SuperAdmin",rsDetails123.getString("SuperAdmin"));
					session.setAttribute("Admin",rsDetails123.getString("Admin"));
					session.setAttribute("Sales",rsDetails123.getString("Sales"));
					session.setAttribute("Purchase",rsDetails123.getString("Purchase"));
					session.setAttribute("Claim",rsDetails123.getString("Claim"));
					session.setAttribute("Account",rsDetails123.getString("Account"));
					session.setAttribute("Collection",rsDetails123.getString("Collection"));
					session.setAttribute("SalesAdmin",rsDetails123.getString("SalesAdmin"));
					session.setAttribute("PurchaseAdmin",rsDetails123.getString("PurchaseAdmin"));
					session.setAttribute("ClaimAdmin",rsDetails123.getString("ClaimAdmin"));
					session.setAttribute("AccountAdmin",rsDetails123.getString("AccountAdmin"));
					session.setAttribute("CollectionAdmin",rsDetails123.getString("CollectionAdmin"));
					session.setAttribute("HRModule",rsDetails123.getString("HRModule"));
					
		}
		}catch(Exception e)
		{
			
		}
	
	try{
		String leavesql = "select * from t_leaveadmin where EmpID='"+empCode+"' and Status='Yes'";
		System.out.println("leavesql "+ leavesql);
		ResultSet rst1 = stleave.executeQuery(leavesql);
		if(rst1.next())
		{
			session.setAttribute("leaveusername",username);
			session.setAttribute("leavepass",pass);
			session.setAttribute("leaveempname",rst1.getString("Name"));
			session.setAttribute("leaveemail",rst1.getString("Email"));
			session.setAttribute("leaveemprole",rst1.getString("URole"));
			session.setAttribute("leaveempdept",rst1.getString("TypeValue"));
			session.setAttribute("leaveempID",rst1.getString("EmpID"));
			session.setAttribute("leaveReportingtoHod",rst1.getString("ReportingtoHod"));
			session.setAttribute("leaveIsWorkFromHome",rst1.getString("IsWorkFromHome"));
			session.setAttribute("leaveuserhod",rst1.getString("ReportingtoHod"));
			session.setAttribute("leaveemail",rst1.getString("Email"));
			session.setAttribute("leaveemprole",rst1.getString("URole"));
			session.setAttribute("leaveempdept",rst1.getString("TypeValue"));
		}
		else
		{

		}
	}catch(Exception e)
	{
		e.printStackTrace();
	}

	
	try{
	String sqlDeatils1="SELECT * FROM CompanyMaster where companymid="+rst.getString("companymasterid")+"";
	System.out.println("*********((((((((((((    "+sqlDeatils1);
	ResultSet rsDetails12=st2.executeQuery(sqlDeatils1);
	if(rsDetails12.next()){
		
		System.out.println("Tally SID======"+rsDetails12.getString("TallySID"));
		System.out.println("Tally PID======"+rsDetails12.getString("TallyPID"));
		session.setAttribute("TallySID",rsDetails12.getString("TallySID"));
		session.setAttribute("TallyPID",rsDetails12.getString("TallyPID"));
		session.setAttribute("website",rsDetails12.getString("website"));
		session.setAttribute("CompanyType",rsDetails12.getString("CompanyType"));
		
		
	}
	}catch(Exception e)
	{
		
	}
	
	
	String sqlDeatils="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where UserName='"+username+"' and Password='"+pass+"' ";
	System.out.println("*********((((((((((((    "+sqlDeatils);
	ResultSet rsDetails=st1.executeQuery(sqlDeatils);
	if(rsDetails.next()){
		session.setAttribute("EmpName",rsDetails.getString("MarketingRepName"));
		session.setAttribute("EmpCode",rsDetails.getString("MarketingRepCode"));
		session.setAttribute("EmpEmail",rsDetails.getString("MarketingRepEMail"));
		if(rsDetails.getString("MarketingRepPhNo").length()>8)
			session.setAttribute("EmpMobileNumber",rsDetails.getString("MarketingRepPhNo"));
		else if(!(rst.getString("mobileno").equalsIgnoreCase("-")))
			session.setAttribute("EmpMobileNumber",rst.getString("mobileno"));
		else
			session.setAttribute("EmpMobileNumber","Mobile number not available in system");
		session.setAttribute("isMarketingRepresentive",true);
		
	}
	else
	{
		  if(!(rst.getString("mobileno").equalsIgnoreCase("-")))
			session.setAttribute("EmpMobileNumber",rst.getString("mobileno"));
		else
			session.setAttribute("EmpMobileNumber","Mobile number not available in system");

		session.setAttribute("EmpName",rst.getString("EmpName"));
		session.setAttribute("EmpCode",rst.getString("EmpCode"));
		session.setAttribute("EmpEmail",rst.getString("email"));
	}
	if(username.equalsIgnoreCase("Puri")){
		session.setAttribute("EmpMobileNumber","9890639379");
		System.out.print("MOB NO ()()()()()()()()("+username);
	}
	
	
	String datesql ="select DATE_FORMAT(DATE(NOW() - INTERVAL 1 Month),'%Y-%m-01') as LastMonthFirst,LAST_DAY(NOW() - INTERVAL 1 Month) as LastMonthLast,DATE(NOW()) As Today,DATE(NOW() - INTERVAL 1 Month) as OneMonthBack,DATE_FORMAT(DATE(NOW()),'%Y-%m-01') as CurrentMonthFirst,LAST_DAY(NOW()) as CurrentMonthLast,DATE_FORMAT(DATE(NOW()) - INTERVAL 7 Day,'%Y-%m-%d %T') as 7daysBack,DATE_FORMAT(DATE(NOW()) - INTERVAL 15 Day,'%Y-%m-%d %T') as 15daysBack,DATE_FORMAT(NOW()-INTERVAL 48 Hour,'%Y-%m-%d %T') as 48hrsBack,DATE_FORMAT(NOW() - INTERVAL 24 Hour,'%Y-%m-%d %T') as 24hrsBack,DATE(now() - INTERVAL 1 Day) as Yesterday,DATE_FORMAT(DATE(NOW()) - INTERVAL 1 Day,'%Y-%m-%d 23:59:59') as YesterdayDateTime";
	  ResultSet rsdate = stdate.executeQuery(datesql);
			if(rsdate.next()){
				//YYYY-MM-DD
				session.setAttribute("LastMonthFirst",rsdate.getString("LastMonthFirst"));
				session.setAttribute("LastMonthLast",rsdate.getString("LastMonthLast"));
				session.setAttribute("Today",rsdate.getString("Today"));
				session.setAttribute("Yesterday",rsdate.getString("Yesterday"));
				session.setAttribute("YesterdayDateTime",rsdate.getString("YesterdayDateTime"));
				session.setAttribute("OneMonthBack",rsdate.getString("OneMonthBack"));
				session.setAttribute("CurrentMonthFirst",rsdate.getString("CurrentMonthFirst"));
				session.setAttribute("CurrentMonthLast",rsdate.getString("CurrentMonthLast"));
				session.setAttribute("7DaysBack",rsdate.getString("7daysBack"));
				session.setAttribute("15DaysBack",rsdate.getString("15daysBack"));
				session.setAttribute("24hoursBack",rsdate.getString("24hrsBack"));
				session.setAttribute("48hoursBack",rsdate.getString("48hrsBack"));	
				
				//DD-MMM-YYYY 
				session.setAttribute("PrevMonthFirst", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("LastMonthFirst"))));
				session.setAttribute("PrevMonthLast", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("LastMonthLast"))));
				session.setAttribute("today", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("Today"))));
				session.setAttribute("yesterday", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("Yesterday"))));	
				session.setAttribute("onemonthback", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("OneMonthBack"))));
				
				session.setAttribute("PresentMonthFirst", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("CurrentMonthFirst"))));
				session.setAttribute("PresentMonthLast", new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsdate.getString("CurrentMonthLast"))));
				
				session.setAttribute("yesterdaydttime", new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdate.getString("YesterdayDateTime"))));
				session.setAttribute("7daysback", new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdate.getString("7daysBack"))));
				session.setAttribute("15daysback", new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdate.getString("15daysBack"))));
				session.setAttribute("24hrsback", new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdate.getString("24hrsBack"))));
				session.setAttribute("48hrsback", new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdate.getString("48hrsBack"))));
			}

	
	
	try{	
	String sqlLogin="insert into "+session.getAttribute("CompanyMasterID").toString()+"logindetails (UserName,SessionId,Updated,LogInDetails,UserIp) values ('"+username+"','"+sessionid+"','"+updated+"','"+updated+"','"+clientip+"')";
	st1.executeUpdate(sqlLogin);
	System.out.println("LOGIN QUERy  "+sqlLogin);
	}catch(Exception e){e.printStackTrace();}	
	
	
	
	
	System.out.println(""+session.getAttribute("isMarketingRepresentive"));

	if(session.getAttribute("department").equals("Marketing")  || session.getAttribute("EmpName").equals("Nilesh Doshi") )
	{
		
	System.out.println("   "+session.getAttribute("EmpName"));	
	System.out.println("IN IF  ");	
	response.sendRedirect("DashBoardForMarkt.jsp");
	}
	else if(session.getAttribute("department").equals("Claim") ) 
	{
		System.out.println("IN Claim    ");
		response.sendRedirect("claimReport.jsp?action=view");
			
	}
	
	else 
	{
		System.out.println("IN ELSE    ");
		response.sendRedirect("LandingPage.jsp");
			
	}
	return;
}
else
{
	response.sendRedirect("index.jsp?err=err1");
	return;
}
}catch(Exception e)
{
	out.print("Exception--->"+e);
	response.sendRedirect("LandingPage.jsp");
}

%>

</body>