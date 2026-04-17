<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.text.*, java.util.*"%>
 <%@page import="com.ConnectionClass"%> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>GlobalERP</title>
<script>
function Redirect(dept,name,issuestatus,chkbx,fd,td)
{
//	alert("Issue Closed Successfully");
   	window.location = "OpenIssueTrackerEdit.jsp?companyName1="+dept+"&EmpName="+name+"&from_date1="+fd+"&to_date1="+td+"&issuestatus="+issuestatus+"&extAll="+chkbx+"&status=action "; 
	
}
</script>
</head>
<body>
<%
Connection conn = null;
Statement st = null;

ConnectionClass connection= new ConnectionClass();

String checkall="";
int Issue_SR_Id=0;
String insertHistorySql="",ReportedDate1="",CustomerType="",IssueRaisedBy="",CustomerName="",Priority="",
SystemName="",ActionPoint="",OpenIssue="",Description="",TargetClosureDate="",Status="",Department="",Concern="";

    String[] issueIds = request.getParameterValues("Issue_SR_Id");
    String ReportedDate = request.getParameter("ReportedDate");
    String dept = request.getParameter("dept");
    String name = request.getParameter("ename");
    String fd = request.getParameter("fd");
    String td = request.getParameter("td");
    String issuestatus = request.getParameter("issuestatus");
    issuestatus=request.getParameter("issuestatus");
    checkall=request.getParameter("checkall");
    
String Sesrole2=session.getAttribute("role").toString();
String cntDateTime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

    try {
    	conn = connection.getConnect("db_GlobalERP");
    	st = conn.createStatement();
    	
        if (issueIds != null && issueIds.length > 0) {
            int updateCount = 0;
            List<String> alreadyClosedIds = new ArrayList<String>();

            for (String issue_id : issueIds) {
                String checkSql = "SELECT Status FROM db_GlobalERP.100000OpenIssueTracker WHERE Issue_SR_Id='" + issue_id + "'";
                ResultSet rs = st.executeQuery(checkSql);

                if (rs.next()) {
                    String currentStatus = rs.getString("Status");

                    if ("Close".equalsIgnoreCase(currentStatus)) {
                        alreadyClosedIds.add(issue_id);
                    }
                }
                rs.close();
            }

            if (alreadyClosedIds.size() == issueIds.length) {
                String closedIds = String.join(", ", alreadyClosedIds);
                out.println("<script>alert('Issue ID are already closed: " + closedIds + "');</script>");
                out.println("<script>Redirect('" + dept + "','" + name + "','" + issuestatus + "','" + checkall + "','" + fd + "','" + td + "');</script>");
            } else {
                for (String issue_id : issueIds) {
                    if (!alreadyClosedIds.contains(issue_id)) {
                        String updateSql = "UPDATE db_GlobalERP.100000OpenIssueTracker " +
                                           "SET Status='Close', ClosureDate='" + cntDateTime + "' " +
                                           "WHERE Issue_SR_Id='" + issue_id + "'";
                        updateCount += st.executeUpdate(updateSql);
                        System.out.println("Updated issue: " + issue_id);
                        try{
                        String fetch = "select * from db_GlobalERP.100000OpenIssueTracker WHERE Issue_SR_Id='" + issue_id + "'";
                       System.out.println("fetch:: "+fetch);
                        Statement stfetch = conn.createStatement();
                        ResultSet rst = stfetch.executeQuery(fetch);
                        if(rst.next()){
                        	                       
                         	Issue_SR_Id = rst.getInt("Issue_SR_Id");
                        	ReportedDate1=rst.getString("ReportedDate");
                        	CustomerType=rst.getString("CustomerType");
                        	IssueRaisedBy=rst.getString("IssueRaisedBy");
                        	CustomerName=rst.getString("CustomerName");
                         	Priority=rst.getString("Priority");
                        	SystemName=rst.getString("SystemName");
                        	ActionPoint=rst.getString("ActionPoint");
                        	OpenIssue=rst.getString("OpenIssue");
                        	Description=rst.getString("Description");
                        	TargetClosureDate=rst.getString("TargetClosureDate");
                        	Status=rst.getString("Status");
                        	Department=rst.getString("Department");
                        	Concern=rst.getString("Concern");
                        	insertHistorySql = "INSERT INTO db_GlobalERP.100000OpenIssueTrackerHistory(Issue_SR_Id,ReportedDate, CustomerType, IssueRaisedBy, CustomerName, Priority, SystemName, ActionPoint, OpenIssue, Description, TargetClosureDate, Status, Department, Concern)VALUES ('"+Issue_SR_Id+"','"+ReportedDate1+"','"+CustomerType+"','"+IssueRaisedBy+"','"+CustomerName+"','"+Priority+"','"+SystemName+"','"+ActionPoint+"','"+OpenIssue+"','"+Description+"','"+TargetClosureDate+"','"+Status+"','"+Department+"','"+Concern+"')";
                        System.out.println("insertHistorySql:: "+insertHistorySql);
                        Statement stp = conn.createStatement();
                        stp.executeUpdate(insertHistorySql);
                        
                        }
                        }catch(Exception e){
                        	e.printStackTrace();
                        }
                    }
                }

                if (updateCount > 0) {
                    out.println("<script>alert('" + updateCount + " Issue Id closed successfully.');</script>");
                }

                if (!alreadyClosedIds.isEmpty()) {
                    String closedIds = String.join(", ", alreadyClosedIds);
                    out.println("<script>alert('Issue ID already closed: " + closedIds + "');</script>");
                }
                out.println("<script>Redirect('" + dept + "','" + name + "','" + issuestatus + "','" + checkall + "','" + fd + "','" + td + "');</script>");
            }          
            
        } else {
            out.println("<script>alert('Please select at least one issue.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        out.println("Exception --> " + e);
    }    
%>
</body>
</html>