<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import=" java.text.*"%>
 <%@page import="com.ConnectionClass"%> 
<%@page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>GlobalERP</title>
<script>
function Redirect(dept,name,issuestatus,chkbx,fd,td)
{
	alert("Issue Closed Successfully");
   window.location="OpenIssueTrackerEdit.jsp?companyName1="+dept+"&EmpName="+name+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+chkbx+"&status=action "; 
	
}
</script>
</head>
<body>
<%
ConnectionClass connection= new ConnectionClass();

	String issue_id="",ReportedDate="",dept="",name="",fd="",td="",issuestatus="",checkall="";
	String Sesrole2=session.getAttribute("role").toString();

	issue_id=request.getParameter("issueid");
	System.out.println("Issue Id =="+issue_id);
	
	ReportedDate=request.getParameter("ReportedDate");
	System.out.println("ReportedDate =="+ReportedDate);
	
	dept=request.getParameter("dept");
	System.out.println("dept =="+dept);
	
	name=request.getParameter("name");
	System.out.println("name =="+name);
	
	fd=request.getParameter("fd");
	System.out.println(" fd =="+fd);
	
	td=request.getParameter("td");
	System.out.println("td =="+td);
	
	issuestatus=request.getParameter("issuestatus");
	System.out.println(" issuestatus =="+issuestatus);
	
	checkall=request.getParameter("checkall");
	System.out.println("checkall =="+checkall);
	
	 String cntDateTime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
		Connection conn = null;
		Statement st = null;

		try {			
			conn = connection.getConnect("db_GlobalERP");
			st = conn.createStatement();
						
			String sql = "update db_GlobalERP.100000OpenIssueTracker set Status='Close',ClosureDate='"+cntDateTime+"' where Issue_SR_Id='"+issue_id+"' and ReportedDate='"+ReportedDate+"'";			
			System.out.println("Sql Query for Update == "+sql);		 
			st.executeUpdate(sql);			
			out.println("<script>  Redirect('"+dept+"','"+name+"','"+issuestatus+"','"+checkall+"','"+fd+"','"+td+"');</script>");

		} catch (Exception e) {
			out.print("Exception-->" + e);
		}
		//response.sendRedirect("OpenIssueTrackerEdit.jsp?companyName1="+dept+"&EmpName="+name+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+checkall+"&status=action ");
	%>
</body>
</html>
