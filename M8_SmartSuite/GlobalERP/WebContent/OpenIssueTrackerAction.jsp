<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import=" java.text.*"%>
<%@page import="com.ConnectionClass"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Open Issue Tracker</title>
<script>
function Redirect(dept,name,issuestatus,chkbx,fd,td)
{
	alert("Issue Added Successfully");
   window.location="OpenIssueTrackerEdit.jsp?companyName1="+dept+"&EmpName="+name+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+chkbx+"&status=action "; 
	
}

function Redirect1(dept,name,issuestatus,chkbx,fd,td)
{
	alert("Issue Added Successfully");
   window.location="OpenIssueTrackerEdit.jsp?companyName1="+dept+"&EmpName="+name+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+chkbx+"&status=action "; 
	
}
</script>
</head>
<body>
	<%
	System.out.println("In side the action page of open issue tracker");

	Connection conn=null;
	Statement stmt=null;
	ConnectionClass connection= new ConnectionClass();
	try {
		conn = connection.getConnect("db_GlobalERP");
		stmt = conn.createStatement();
		
	String Sesrole1=session.getAttribute("role").toString();
	
	String reportedDate= new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	System.out.println("Reported date== "+reportedDate);
	
	String Customer_and_Internal="",IssueRaisedBy="",CustomerName="",Priority="",SystemName="",ActionPoint="",OpenIssueName="",Description="",TargetDate="",Department="",ConcernName="";
	String dept="",ename="",issuestatus="",chbk="",fd="",td="";

	Customer_and_Internal=request.getParameter("customeInternal");
	IssueRaisedBy=request.getParameter("issueraisedby");
	CustomerName=request.getParameter("customername");
	Priority=request.getParameter("priority");
	SystemName=request.getParameter("system");
	ActionPoint=request.getParameter("actionpoint");
	OpenIssueName=request.getParameter("reportname");
	Description=request.getParameter("description");
	TargetDate=request.getParameter("targetclosedate");
	Department=request.getParameter("Department");
	ConcernName=request.getParameter("concernperson");
	
	
	dept = request.getParameter("dept");
	ename = request.getParameter("ename");
	issuestatus = request.getParameter("issuestatus");
	chbk = request.getParameter("chbk");
	fd = request.getParameter("fd");
	td = request.getParameter("td");
	
	if(dept.equalsIgnoreCase("null") || dept == null){
		
		dept="Select";
	}
	
if(ename.equalsIgnoreCase("null") || ename == null){
		
	ename="";
	}
	String TargetDateNew=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(TargetDate));	
		String insertOpenIssue = "insert into db_GlobalERP.100000OpenIssueTracker(ReportedDate,CustomerType,IssueRaisedBy,CustomerName,Priority,SystemName,ActionPoint,OpenIssue,Description,TargetClosureDate,Status,Department,Concern)values('"+reportedDate+"','"
				+ Customer_and_Internal + "','"+IssueRaisedBy+"','"+CustomerName+"','"+Priority+"','"+SystemName+"','"+ActionPoint+"','"+OpenIssueName+"','"+Description+"','"+TargetDateNew+"','Open','"+Department+"','"+ConcernName+"')";
		 
		stmt.executeUpdate(insertOpenIssue);
		System.out.println("insertOpenIssue:- "+insertOpenIssue); 
	
if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("HOD")) {
	out.println("<script>  Redirect('"+dept+"','"+ename+"','"+issuestatus+"','"+chbk+"','"+fd+"','"+td+"');</script>");
}else{
	out.println("<script>  Redirect1('"+dept+"','"+ename+"','"+issuestatus+"','"+chbk+"','"+fd+"','"+td+"');</script>");
}
	}catch(Exception e){
		e.printStackTrace();
	}	 
	%>
</body>
</html>