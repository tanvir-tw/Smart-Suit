<%@page import="org.xhtmlrenderer.css.parser.property.PrimitivePropertyBuilders.Src"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- <%@page import ="java.sql.*, com.erp.beans.Fetch" %> --%>
    <%@page import ="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>

function Redirect()
{
	alert("This Employee record is already available for current month ");
    window.location="ScoreCardReport.jsp";
}

function RedirectInsert()
{
	alert("Submitted Successfully ");
    window.location="ScoreCardReport.jsp";
}

function RedirectUpdate()
{
	alert("Updated Successfully");
    window.location="ViewScores.jsp";
}
function RedirectError()
{
	alert("Fail to submit Record");
    window.location="ScoreCardReport.jsp";
}

	
</script>
</head>
<body>

 <%!
Connection con1;
 String host = System.getenv("DB_GLOBALERP_HOST");
 String user = System.getenv("DB_GLOBALERP_USER");
 String pass = System.getenv("DB_GLOBALERP_PASS");
%>
<% 

String DB_Driver="com.mysql.cj.jdbc.Driver";
String DB_NAME="jdbc:mysql://"+host+"/db_GlobalERP";
String DB_NAME1="jdbc:mysql://"+host+"/newblankerp"; 

String DB_USERNAME=user;
String DB_PASSWORD=pass;

		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		
		%>
<%
	String flag=request.getParameter("flag");
String user=session.getAttribute("EmpName").toString();
String department=session.getAttribute("department").toString();

String ProficiencyScore=request.getParameter("ProficiencyScore");
int ProficiencyScoreI=Integer.parseInt(ProficiencyScore);
String ProficiencyCmt=request.getParameter("ProficiencyCmt");

String CommunicationScore=request.getParameter("CommunicationScore");
int CommunicationScoreI=Integer.parseInt(CommunicationScore);

String CommunicationCmt=request.getParameter("CommunicationCmt");

String CommitmentScore=request.getParameter("CommitmentScore");
int CommitmentScoreI=Integer.parseInt(CommitmentScore);


String CommitmentCmt=request.getParameter("CommitmentCmt");
String DependabilityScore=request.getParameter("DependabilityScore");
int DependabilityScoreI=Integer.parseInt(DependabilityScore);

String DependabilityCmt=request.getParameter("DependabilityCmt");
String TurnOutScore=request.getParameter("TurnOutScore");
int TurnOutScoreI=Integer.parseInt(TurnOutScore);

String TurnOutCmt=request.getParameter("TurnOutCmt");
String PunctualityScore=request.getParameter("PunctualityScore");
int PunctualityScoreI=Integer.parseInt(PunctualityScore);

String PunctualityCmt=request.getParameter("PunctualityCmt");
String emp=request.getParameter("empName");

String month=request.getParameter("month");
String year=request.getParameter("year");
System.out.println(month);
System.out.println(year);
String FromDate1="", FromDate="", ToDate1="", ToDate="";

if(month.equals("JAN")){ ToDate1="31 JAN "; FromDate1="1 JAN ";}
else if(month.equals("FEB")){ ToDate1="28 FEB "; FromDate1="1 FEB ";}
else if(month.equals("MAR")){ ToDate1="31 MAR "; FromDate1="1 MAR ";}
else if(month.equals("APR")){ ToDate1="30 APR "; FromDate1="1 APR ";}
else if(month.equals("MAY")){ ToDate1="31 MAY "; FromDate1="1 MAY ";}
else if(month.equals("JUN")){ ToDate1="30 JUN "; FromDate1="1 JUN ";}
else if(month.equals("JLY")){ ToDate1="31 JLY "; FromDate1="1 JLY ";}
else if(month.equals("AUG")){ ToDate1="31 AUG "; FromDate1="1 AUG ";}
else if(month.equals("SEPT")){ ToDate1="30 SEPT "; FromDate1="1 SEPT ";}
else if(month.equals("OCT")){ ToDate1="31 OCT "; FromDate1="1 OCT ";}
else if(month.equals("NOV")){ ToDate1="30 NOV "; FromDate1="1 NOV ";}
else if(month.equals("DEC")){ ToDate1="31 DEC "; FromDate1="1 DEC ";}

	 ToDate=ToDate1+year;
	 FromDate=FromDate1+year;
 java.util.Date now = new java.util.Date();
              
              String EnteredDate1 = now.getYear() + 1900 + "-" + (1 + now.getMonth()) + "-" + now.getDate();         
              String EnteredTime1 = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();             
              String EntryDate=EnteredDate1+" "+EnteredTime1;

float pi=00.00F;
 int cs1=(ProficiencyScoreI+CommitmentScoreI+CommunicationScoreI+DependabilityScoreI+TurnOutScoreI+PunctualityScoreI)*100;
float CalculatedScores=cs1/50; 

//float CalculatedScores=0.00F;
String qryInsert="",EmpName="";
try
{
	String str="select dept,EmpName from db_GlobalERP.UserMaster where EmpCode like '%"+emp+"%'";
	System.out.println(str);
	PreparedStatement ps10 = con1.prepareStatement(str);
	ResultSet rs = ps10.executeQuery();
	while(rs.next())
	{
		department=rs.getString("dept");
		EmpName=rs.getString("EmpName");
		System.out.println("Dept 1: "+department);
			
	}
	
	
	String tableQry="create table test.EmpPersonalscore (SrNo int auto_increment primary key, EmpId int, EmpName varchar(50) not null, Department varchar(50) not null, HOD varchar(100) not null, month varchar(50), year varchar(50),  FromDate varchar(50), ToDate varchar(50), ProficiencyScore varchar(10) not null, ProficiencyCmt varchar(500) default '-',  CommunicationScore varchar(10) not null, CommunicationCmt varchar(500) default '-', CommitmentScore varchar(10) not null,  CommitmentCmt varchar(500) default '-', DependabilityScore varchar(10) not null, DependabilityCmt varchar(500) default '-',  TurnOutScore varchar(10) not null, TurnOutCmt varchar(500) default '-', PunctualityScore varchar(10) not null,  PunctualityCmt varchar(500) default '-', PI varchar(10) not null, CalculatedScores varchar(10) not null, EntryBy varchar(30)  not null default '-',EntryDate varchar(50) not null  ,UpdatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON update CURRENT_TIMESTAMP)";
	if(flag.equals("Save"))
	{
		String qrySelect="select * from test.EmpPersonalscore where EmpName='"+EmpName+"' and month='"+month+"' and year = '"+year+"' ";
		System.out.println(qrySelect);
		PreparedStatement ps3=con1.prepareStatement(qrySelect);
		ResultSet rs2=ps3.executeQuery();
		if(!rs2.next())
		{
			qryInsert="insert into test.EmpPersonalscore (EntryBy, HOD, EmpId, EmpName, ProficiencyScore, ProficiencyCmt, CommunicationScore, CommunicationCmt, CommitmentScore, CommitmentCmt, DependabilityScore, DependabilityCmt, TurnOutScore, TurnOutCmt, PunctualityScore, PunctualityCmt, PI, month, year, FromDate, ToDate, EntryDate, Department, CalculatedScores) "
					+"values('"+user+"','"+user+"', '"+emp+"', '"+EmpName+"', '"+ProficiencyScore+"', '"+ProficiencyCmt+"', '"+CommunicationScore+"', '"+CommunicationCmt+"', '"+CommitmentScore+"', '"+CommitmentCmt+"', '"+DependabilityScore+"', '"+DependabilityCmt+"', '"+TurnOutScore+"', '"+TurnOutCmt+"', '"+PunctualityScore+"', '"+PunctualityCmt+"', '00.00', '"+month+"', '"+year+"', '"+FromDate+"', '"+ToDate+"', '"+EntryDate+"', '"+department+"', '"+CalculatedScores+"')";
			
			PreparedStatement ps2=con1.prepareStatement(qryInsert);
			
			System.out.println(qryInsert);
			int x=ps2.executeUpdate();
			if(x!=0)
			{
				out.println("<script>  RedirectInsert();</script>");
			}
			else
			{
				out.println("<script>  RedirectError();</script>");
			} 
			System.out.println(x);
		}
		else
		{
			out.println("<script>  Redirect();</script>");
			%>
			test();
			<%
		}
		
		
	}else
	{
		String empId=request.getParameter("empId");
		//out.println("Emp Id : "+empId);
		qryInsert="update test.EmpPersonalscore set ProficiencyScore='"+ProficiencyScore+"', ProficiencyCmt='"+ProficiencyCmt+"', CommunicationScore='"+CommunicationScore+"', CommunicationCmt='"+CommunicationCmt+"', CommitmentScore='"+CommitmentScore+"', CommitmentCmt='"+CommitmentCmt+"', DependabilityScore='"+DependabilityScore+"', DependabilityCmt='"+DependabilityCmt+"', TurnOutScore='"+TurnOutScore+"', TurnOutCmt='"+TurnOutCmt+"', PunctualityScore='"+PunctualityScore+"', PunctualityCmt='"+PunctualityCmt+"', CalculatedScores='"+CalculatedScores+"' where SrNo="+empId;
		
		PreparedStatement ps4=con1.prepareStatement(qryInsert);
		
		System.out.println(qryInsert);
		int x=ps4.executeUpdate();
		if(x!=0)
		{
			out.println("<script>  RedirectUpdate();</script>");
		}
		else
		{
			out.println("<script>  RedirectError();</script>");
		} 
		System.out.println(x);
	}
		
}
catch(Exception e)
{
	System.out.println("Exception in insertRecord()");
	System.out.println(e.toString());
	
	out.println("<script>  RedirectError();</script>");
} 
%>
</body>
</html>
