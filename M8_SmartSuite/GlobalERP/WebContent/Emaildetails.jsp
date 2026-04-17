<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
 <%@page import="com.ConnectionClass"%> 

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>GlobalERP</title>

  <!-- Font Awesome CDN -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>

  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
    }

    .layout {
      display: flex;
      margin-top: 70px; /* header height */
    }

    /* Sidebar */
    #EmailSidebar {
      width: 185px;
      background: #F5F5F5;
      backdrop-filter: blur(30px);
      border-radius: 0 1rem 1rem 0;
      padding: 1rem;
      display: flex;
      flex-direction: column;
      gap: 1rem;
      box-shadow: 2px 0 8px rgba(0,0,0,0.05);
      transition: width 0.3s ease;
    }

    #EmailSidebar .nav-link {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      font-size: 0.875rem;
      color: #3a7bd5;
      transition: all 0.2s ease-in-out;
    }

    #EmailSidebar .nav-link:hover {
      color: #2a5cae;
      text-decoration: none;
    }

    #EmailSidebar .nav-link i {
      font-size: 1.2rem;
      min-width: 24px;
      text-align: center;
    }

    /* Content */
    #mainContent {
      flex: 1;
      padding: 1rem;
    }

    /* Mobile - collapse sidebar into icons */
    @media (max-width: 767px) {
      #EmailSidebar {
        width: 60px;
        padding: 0.5rem;
        align-items: center;
      }

      #EmailSidebar .nav-link {
        justify-content: center;
        font-size: 0;
        gap: 0;
      }

      #EmailSidebar .nav-link i {
        font-size: 1.5rem;
        color: #3a7bd5;
      }

      #EmailSidebar .nav-link::after {
        content: attr(title);
        font-size: 0.75rem;
        position: absolute;
        left: 60px;
        background: #3a7bd5;
        color: #fff;
        padding: 0.25rem 0.5rem;
        border-radius: 4px;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.2s;
        white-space: nowrap;
      }

      #EmailSidebar .nav-link:hover::after {
        opacity: 1;
      }
    }
  </style>
</head>
<body>
<%
String empname=session.getAttribute("EmpName").toString();
String department = session.getAttribute("department").toString();
String Role=session.getAttribute("role").toString();
String hodname="";

Connection connmail = null;
Statement stmail = null;

try {
	ConnectionClass connection1= new ConnectionClass();

  connmail = connection1.getConnect("db_GlobalERP"); 
  stmail = connmail.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

String Hod="select Hodreport from db_GlobalERP.UserMaster where Dept = '"+department+"' and empname like '"+empname+"'";
ResultSet rs = stmail.executeQuery(Hod);
while(rs.next()){
  hodname = rs.getString("Hodreport");
}
%>

    <a href="ContractMasterSendmail.jsp" class="nav-link" id="EmailNav" title="Send Mail"><i class="far fa-file-alt"></i><span>Send Mail</span></a>
    <a href="Inbox.jsp" class="nav-link" id="EmailNav" title="Inbox"><i class="fas fa-inbox"></i><span>Inbox</span></a>
    <a href="Sent.jsp" class="nav-link" id="EmailNav" title="Sent"><i class="far fa-paper-plane"></i><span>Sent</span></a>

   <% if (Role.equalsIgnoreCase("HOD")||Role.equalsIgnoreCase("AllAdmin")||Role.equalsIgnoreCase("Hr")){ %>
      <a href="template.jsp" class="nav-link" id="EmailNav" title="Create Template"><i class="fas fa-plus-circle"></i><span>+ Create Template</span></a>
    <% } %>

    <% if (Role.equalsIgnoreCase("AllAdmin")||Role.equalsIgnoreCase("Hr")){ %>
      <a href="SendmailReport.jsp" class="nav-link" id="EmailNav" title="Send Mail Report"><i class="far fa-folder"></i><span>Send Mail Report</span></a>
    <% } %>

</body>
</html>
