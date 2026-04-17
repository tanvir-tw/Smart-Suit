<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
 <%@page import="com.ConnectionClass"%> 
<%@ include file="conn.jsp"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
    <link rel="icon" type="image/x-icon" href="imagesnew/erp.png">
    
 <!-- Internal CSS and JS -->
<link rel="stylesheet" href="cssnew/header.css" />  
<link href="cssnew/report.css" rel="stylesheet">
<link href="cssnew/modal.css" rel="stylesheet"> 
<script src="jsnew/validation.js"></script>
  
<!-- Unicons CSS -->
<link rel="stylesheet" href="cssnew/unicons.css" />
<link rel="stylesheet" href="cssnew/boxicons.min.css">
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
      
<!-- Bootstrap CDN --> 
<link href="cssnew/bootstrap/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<script src="jsnew/bootstrap/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

<!-- Jquery -->
<script src="jquery/jquery.min.js"></script>
 
<!-- DataTable CSS -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/buttons.dataTables.min.css"> <!-- Export Button -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/colReorder.dataTables.min.css"> <!-- Click-and-drag column reordering -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/jquery.dataTables.min.css"> <!--Basic configuration  -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/select.dataTables.min.css"> <!--select checkbox  -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/fixedColumns.dataTables.min.css"><!--Fixed column  -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/keyTable.dataTables.min.css"> <!-- Key Table  -->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/responsive.dataTables.min.css"> <!--Responsive-->
<link rel="stylesheet" type="text/css" href="cssnew/datatable/dataTables.dateTime.min.css">
<link rel="stylesheet" type="text/css" href="cssnew/datatable/searchBuilder.dataTables.min.css">

<!-- DataTable JS -->
<script src="jquery/jquery.js"></script> <!-- jquery -->
<script src="jsnew/datatable/dataTables.bootstrap5.min.js"></script> <!-- Bootstrap 5  -->
<script src="jsnew/datatable/jquery.dataTables.min.js"></script> <!--Basic configuration  -->
<script src="jsnew/datatable/dataTables.buttons.min.js"></script>  <!-- Export Button -->
<script src="jsnew/datatable/jszip.min.js"></script>  <!-- Excel -->
<script src="jsnew/datatable/pdfmake.min.js"></script> <!-- PDF -->
<script src="jsnew/datatable/vfs_fonts.js"></script> <!--PDF-->
<script src="jsnew/datatable/buttons.html5.min.js"></script> <!-- Copy to clipboard and create Excel, PDF and CSV files from the table's data. -->
<script src="jsnew/datatable/buttons.print.min.js"></script> <!-- Print -->
<script src="jsnew/datatable/dataTables.colReorder.min.js"></script> <!-- Click-and-drag column reordering -->
<script src="jsnew/datatable/dataTables.select.min.js"></script> <!--select checkbox  -->
<script src="jsnew/datatable/dataTables.fixedColumns.min.js"></script> <!--Fixed column  -->
<script src="jsnew/datatable/dataTables.keyTable.min.js"></script> <!-- Key Table  -->
<script src="jsnew/datatable/dataTables.responsive.min.js"></script> <!--Responsive-->
<script src="jsnew/datatable/buttons.colVis.min.js"></script>
<script src="jsnew/datatable/dataTables.dateTime.min.js"></script>
<script src="jsnew/datatable/dataTables.searchBuilder.min.js"></script>

 <!--Feather Icon -->
<script src="jsnew/feather.min.js"></script> <!-- Icons -->
  
<!--Calendar-->
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>


      <style>
   .nav-links{
   margin-bottom:0px;
   }
 .nav-links li{
  list-style: none;
}
.nav-links li a{
  color: #f2f2f2;
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  padding: 9px 15px;
  border-radius: 5px;
  transition: all 0.3s ease;
}
.nav-links li a:hover{
  background: white;
  color:black;
}
nav .nav-links {
  display: flex;
  align-items: center;
}
nav {
  justify-content: space-between;
}
.nav-links .drop-menu{
  position: absolute;
  background: white;
  width: 180px;
  line-height: 45px;
  top: 85px;
  opacity: 0;
  visibility: hidden;
  box-shadow: 0 6px 10px rgba(0,0,0,0.15);
}
.nav-links li:hover .drop-menu,
.nav-links li:hover .mega-box{
  transition: all 0.3s ease;
  top: 45px;
  opacity: 1;
  visibility: visible;
}
.drop-menu li a{
  width: 100%;
  display: block;
  padding: 0 0 0 15px;
  font-weight: 400;
  border-radius: 0px;
}

  */
/* Base styles for the navbar */
nav {
    width: 100%;                    /* Set navbar width to 80% */
/*     height:9%;
 */    margin: 20px auto;             /* Center navbar horizontally with a top margin */
    padding: 8px 8px;
    display: flex;
    justify-content: space-between;  /* Spread logo and profile section apart */
    align-items: center;           /* Align items vertically */
    background-color: #1582AB;
    color: #fff;
    border-radius: 5px;           /* Rounded corners */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);  /* Add a shadow effect */
}

/* Logo styling */
.logo {
    font-size: 24px;
    font-weight: bold;
    color: #fff;
    text-decoration: none;
}

/* Profile section */
.profile-details {
    display: flex;
    align-items: center;
}

/* Profile image styling */
.profile-img {
    border-radius: 50%;
    width: 30px;
    height: 30px;
    object-fit: cover;
    margin-right: 10px;
}

/* Name and Job section (optional) */
.name-job {
    margin-right: 10px;
}

.profile_name {
    font-size: 14px;
    font-weight: 500;
}

/* Logout icon styling */
.logout-icon {
    font-size: 20px;
    color: #fff;
    text-decoration: none;
}

.logout-icon:hover {
    color: #ff4d4d;
}


.mega-box {
  position: absolute;
  left: 0%;
  top: 50px;
  opacity: 0;
  visibility: hidden;
  z-index: 1050;
 /*  width: 100%; */
  padding: 0 30px;
  transition: opacity 0.3s ease, top 0.3s ease;
}

.mega-box .content {
  background: white;
  padding: 25px 35px;
  display: flex;
  flex-wrap: wrap;
  gap: 30px;
  border-radius: 10px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.mega-box .content .row {
  flex: 1 1 5%;
  min-width: 14%;
  line-height: 10px;
}

.content .row header {
  color: #1582AB;
  font-size: 13px;
  font-weight: 600;
/*   margin-bottom: 12px;
 */  border-bottom: 1px solid #ddd;
  padding-bottom: 5px;
}

.content .row .mega-links {
  margin: 0;
  padding: 0;
  list-style: none;
}

.row .mega-links li {
  padding: 4px 0;
}

.row .mega-links li a {
  display: block;
  padding: 8px 16px;
  color: #333;
  font-size: 13px;
  border-radius: 5px;
  transition: all 0.3s ease;
  text-decoration: none;
}

.row .mega-links li a:hover {
  background-color: #1582AB;
  color: white;
  transform: translateX(4px);
}



/* Custom styling ONLY for Reports dropdown */
ul.custom-reports-dropdown {
  background-color: white;
  border-radius: 0;
  box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
  padding: 0;
  min-width: 220px;
}

ul.custom-reports-dropdown li a.dropdown-item {
  padding: 10px 20px;
  font-size: 12px;
  color: black;
  font-weight: 400;
  border-radius: 0;
}

ul.custom-reports-dropdown li a.dropdown-item:hover {
  background-color: #1582AB;
  color: white;
  border:1px solid;
  margin:5px 0px 5px 0px;
}

.dropdown-submenu {
  display: none;
  position: absolute;
  top: 0;
  left: 100%;
  min-width: 180px;
  background-color: white;
  border: 1px solid #ddd;
  z-index: 1000;
  border-radius: 5px;
  padding: 10px 0;
  box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}

.dropend:hover > .dropdown-submenu {
  display: block;
}

.dropstart:hover > .dropdown-submenu {
  display: block;
   right: 100%;  /* Show to the left of the parent */
  left: auto;   /* Reset left */
  top: 0;
}

.dropup:hover > .dropdown-submenu {
  display: block;
  bottom: 100%;   /* Position above the parent */
  top: auto;      /* Reset top */
  left: 0;        /* Align submenu to the left edge of the parent */
}

.dropdown-submenu {
  position: absolute;
  top: 0;
  left: 100%;
  min-width: 180px;
  background-color: white;
  border: 1px solid #ddd;
  z-index: 1000;
  border-radius: 5px;
  padding: 10px 0;
  box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}

.dropdown-submenu li a {
  display: block;
  padding: 6px 20px;
  color: black;
  text-decoration: none;
  font-size: 13px;
}

.dropdown-submenu li a:hover {
  background-color: #1582AB;
  color: white;
}



.mega-links.grid-list {
  display: grid;
  grid-template-columns: repeat(6, 1fr); /* 5 columns */
  gap: 6px;
  list-style: none;
  padding: 0;
  margin: 0;
}

.mega-links.grid-list li a {
  display: block;
  padding: 10px 12px;
  background-color: #f1f1f1;
  color: #333;
  text-decoration: none;
  border-radius: 4px;
  text-align: center;
  transition: background-color 0.3s ease;
}

.mega-links.grid-list li a:hover {
  background-color: #ddd;
  background-color:#1582AB;
}

   .menu-toggle {
            display: none;
            font-size: 24px;
            color: white;
            cursor: pointer;
            background: none;
            border: none;
            padding: 5px;
        }


.nav-links li a {
  color: #f2f2f2;
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  padding: 9px 15px;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.nav-links li a:hover,
.nav-links li a.active {
  background: #1582AB; /* Change to blue on hover and when active */
  color: white; /* Change text color to white for better contrast */
}

.nav-links .drop-menu {
  position: absolute;
  background: white;
  width: 180px;
  line-height: 45px;
  top: 85px;
  opacity: 0;
  visibility: hidden;
  box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
}

.nav-links li:hover .drop-menu,
.nav-links li:hover .mega-box {
  transition: all 0.3s ease;
  top: 45px;
  opacity: 1;
  visibility: visible;
}

.nav-links li:hover > a {
  background: #1582AB; /* Keep the background blue when the dropdown is open */
  color: white; /* Change text color to white for better contrast */
}

/* Hide Bootstrap's default caret on dropdown toggle */
.no-caret::after {
  display: none !important;
}

#main{
	    position: absolute;
  top: 50px; /* height of header */
  bottom: 50px; /* height of footer */
  left: 0;
  right: 0;
  overflow-y: auto;
  padding: 7px 20px;
	  
  }

/* Mobile friendly UI */ 
@media (max-width: 768px) {

    nav {
        flex-direction: row;
        align-items: center;
    }

    .profile-details {
        margin-top: 10px;
    }
      .menu-toggle {
    display: block;
  }

   .nav-links {
    display: none !important;
    flex-direction: row;
    width: 100%;
    background-color: #1582AB;
    padding: 0px 0;
    border-radius: 10px;
    overflow: auto;
  } 

nav .nav-links {
    column-gap: 0px;
    list-style: none;
}


  .nav-links.active {
    display: flex !important;
  }
  
  .nav-links li {
    padding: 3px 20px;
  }
  
  .row .mega-links li a {
    display: block;
    padding: 0px 16px;
    color: #333;
    font-size: 13px;
    border-radius: 5px;
    transition: all 0.3sease;
    text-decoration: none;
}

  #mainli{
    padding: 0px 0px;

}
      .mega-links.grid-list {
    display: block;
    list-style: none;
    padding:0;
    margin: 0;
   }
   

   
   .mega-box .content {
    background: white;
    padding: 10px 13px; 
    display: block;
    flex-wrap: wrap;
    gap: 30px;
    border-radius: 10px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}
   
   
    .mega-box  {
  position: absolute;
  left: 0;
  top: 75px;
  opacity: 0;
  visibility: hidden;
  z-index: 1050;
  width: 80%;
  padding: 0 34px;
  transition: opacity 0.3s ease, top 0.3s ease;
}
   .nav-links li:hover .drop-menu, .nav-links li:hover .mega-box {
    transition: all 0.3sease;
    top: 130px;
    left:5px;
    opacity: 1;
    visibility: visible;
}

.mega-box .content .row {
    /* width: calc(25% - -86px); */
    width:100%;
    line-height: 30px;
}

    
   .dropdown-submenu {
        position: static; 
        display: none; 
    }

    .dropdown-submenu.active {
        display: block; 
        padding-left: 20px; 
    }
    
   .mega-links {
    display: none;
  }

  .mega-links.show {
    display: block;
    
  }
  
  #othermenu li{
      padding: 0px 28px;
  }
  
      #main{
	    position: absolute;
  top: 20px; /* height of header */
  bottom: 50px; /* height of footer */
  left: 0;
  right: 0;
  overflow-y: auto;
  padding: 90px 20px;
	  
  }

}

   </style>
  </head>
<body>
<%!
//Connection Initialization
Connection mainconn = null;
Statement st = null,strno=null;

%>
<%
ConnectionClass connection= new ConnectionClass();

try {
	System.out.println("in header");

	mainconn = connection.getConnect("db_GlobalERP");
	System.out.println("sessionconn header"+mainconn);
	 st = mainconn.createStatement();
	 strno = mainconn.createStatement();
	
} catch (Exception e) {
	System.out.println("catch  header connection "+mainconn);

	mainconn = connection.getConnect("db_GlobalERP");

		    e.printStackTrace();
		} 

String SesmUsername=session.getAttribute("EmpName").toString();
String SesmLevel=session.getAttribute("userLevel").toString();
String Sesrole=session.getAttribute("role").toString();
String Sesdepartment=session.getAttribute("department").toString();
String comsessionid=session.getAttribute("CompanyMasterID").toString();

String PageName=this.getClass().getName();
String reportno = "",logoname="";
PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
System.out.println(PageName);
PageName=PageName.replace("_",".");
PageName=PageName.replace(".005f","_");
PageName = PageName.replace(".0020"," ");
System.out.println("PageName   "+PageName);
String sqlreport = "select ReportNo from t_reportnumber where PageName = '"+PageName+"'";
ResultSet rsreport = strno.executeQuery(sqlreport);
if(rsreport.next())
{
	reportno = rsreport.getString("ReportNo");
}

String logo="select distinct(companymid),Companyname,logoname from db_GlobalERP.CompanyMaster where companymid='"+session.getAttribute("CompanyMasterID").toString()+"'";
ResultSet rslogo = strno.executeQuery(logo);
if(rslogo.next())
{
	logoname=rslogo.getString("logoname");
}else{
	logoname="";
}

System.out.println("Report Number Above Session Id------->"+reportno);
String SuperAdmin="", Admin="", Sales="", Purchase="", Claim="",HRModule="", Account="", Collection="", SalesAdmin="", PurchaseAdmin="", ClaimAdmin="", AccountAdmin="",CollectionAdmin="";
String role="",comType="";

SuperAdmin=session.getAttribute("SuperAdmin").toString();
Admin=session.getAttribute("Admin").toString();
Sales=session.getAttribute("Sales").toString();
Purchase=session.getAttribute("Purchase").toString();
Claim=session.getAttribute("Claim").toString();
Account=session.getAttribute("Account").toString();
Collection=session.getAttribute("Collection").toString();
SalesAdmin=session.getAttribute("SalesAdmin").toString();
PurchaseAdmin=session.getAttribute("PurchaseAdmin").toString();
ClaimAdmin=session.getAttribute("ClaimAdmin").toString();	
AccountAdmin=session.getAttribute("AccountAdmin").toString();
CollectionAdmin=session.getAttribute("CollectionAdmin").toString();
HRModule=session.getAttribute("HRModule").toString();
role=session.getAttribute("role").toString();
comType=session.getAttribute("CompanyType").toString();

System.out.println("Report Number Below Session Id------->"+reportno);


System.out.println("Report Number-------1>"+SuperAdmin);
System.out.println("Report Number-------2>"+Admin);
System.out.println("Report Number-------3>"+Sales);

System.out.println("Report Number-------4>"+Purchase);
System.out.println("Report Number-------5>"+Claim);
System.out.println("Report Number-------6>"+Account);

System.out.println("Report Number-------7>"+Collection);
System.out.println("Report Number-------8>"+SalesAdmin);
System.out.println("Report Number-------9>"+PurchaseAdmin);

System.out.println("Report Number-------10>"+ClaimAdmin);
System.out.println("Report Number-------11>"+AccountAdmin);
System.out.println("Report Number-------12>"+CollectionAdmin);

%>
   <nav class="nav mt-0">
     <a href="#" class="logo ms-3">
		<img src="imagesnew/<%=logoname%>" alt="logoImg" height=40 width=150 style="border-radius: 5px;"></img>
    </a> 	
     <span class="badge rounded-pill bg-light text-dark shadow-sm" style="font-family: Montserrat, sans-serif; font-size: 14px;">
    <strong>Report No.:</strong> <%= reportno %>
  </span>
  <button class="menu-toggle" id="mobileMenuToggle">
        <i class='bx bx-menu'></i>
    </button>

    <ul class="nav-links flex-md-row" id="mainNavLinks">
       <li id="mainli"><a href="home.jsp">Home</a></li>
        <li id="mainli">
          <a href="#" class="desktop-item">Modules</a>          
          <div class="mega-box" id="megaMenu">
            <div class="content">
           <!--    <div class="row">
                <img src="img.jpg" alt="">
              </div> -->
        			<% 
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
         			{		
						%>	
      			
      			     <%if(HRModule.equalsIgnoreCase("Yes") || HRModule.equalsIgnoreCase("Yes") || comsessionid.equalsIgnoreCase("100052"))
{ %>
                
<div class="row">
                <header onclick="toggleMenu('hrMenu')"><b>HR</b></header>
                <ul class="mega-links" id="hrMenu">
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Performance
          </a>
           <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                <li><a class="dropdown-item" href="AdvanceMoneyForm.jsp">Advance Entry</a></li>		           									
                <li><a class="dropdown-item" href="TaskIndexCalculation.jsp">Index</a></li>
                <li><a class="dropdown-item" href="KRACalculation.jsp">KRA Index</a></li>
                <li><a class="dropdown-item" href="TaskApprovalReport.jsp">Task Status</a></li>
                <li><a class="dropdown-item" href="KRATaskStatusReport.jsp">KRA Status</a></li> 
                  <% if(role.equals("AllAdmin") || role.equals("HOD") || role.equalsIgnoreCase("HR")) 
		           	{
		           %>
		           	<li><a class="dropdown-item" href="TaskAllocationReport.jsp">Task Allocation </a></li>
		           	 <%} %>
		           									
		          <% if(role.equals("AllAdmin") || role.equals("HOD")) 
		           	{
		          %>
		           	<li><a class="dropdown-item" href="TaskMailDownLodedDataReport.jsp">Task Approval</a></li>
		           <%} %>
		           				
                  <%if(role.equals("HOD") || role.equals("Admin") || role.equals("AllAdmin"))
	                 {%>
                   <li><a class="dropdown-item" href="uploadTask.jsp">Task Upload</a></li>
                   <% } %>	 
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="scDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Score Card
          </a>
           <ul class="dropdown-submenu" aria-labelledby="scDropdown">
                        <li><a class="dropdown-item" href="ViewScores.jsp">View Emp Scores</a></li>
                 	<% if(!role.equals("-")){%>
		               <li><a class="dropdown-item" href="ScoreCardReport.jsp">Score Card</a></li>
		           	<%}else if(role.equals("AllAdmin") || role.equals("HOD")) {%>
		           		<li><a class="dropdown-item" href="ScoreCardReport.jsp">Emp Score Report</a></li>
		           	    <li><a class="dropdown-item" href="ViewScores.jsp">View Emp Scores</a></li>
		          	<%} %>
          </ul> </li>
          <li class="dropend"><a class="dropdown-toggle" href="#" id="psDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Project Summary
                    </a>
            <ul class="dropdown-submenu" aria-labelledby="psDropdown">
                     <li><a class="dropdown-item" href="TaskSummaryReport.jsp">PI</a></li>
		           	 <li><a class="dropdown-item" href="KRASummaryReport.jsp">KRA</a></li>
          </ul> </li>
           </ul> </li>
              <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Open Project
          </a>
           <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                <li><a href="OPTaskIndexCalculation.jsp">Index</a></li>
                <li><a href="OPKRACalculation.jsp">KRA Index</a></li>
                <li><a href="OPTaskApprovalReport.jsp">Task Status</a></li>
                <li><a href="OPKRATaskStatusReport.jsp">KRA Status</a></li> 
                     <%
		           	  if(role.equals("AllAdmin") || role.equals("HOD") || role.equalsIgnoreCase("HR")) 
		    			{%>
		        <li><a href="OPTaskAllocationReport.jsp">Task Allocation </a></li>
		           	<%} %>
		              <%if(role.equals("AllAdmin") || role.equals("HOD")) 
		           		{%>
		       <li><a href="OPTaskMailDownLodedDataReport.jsp">Task Approval</a></li>
		           	    <%} %>
		           	    
             <%if((session.getAttribute("EmpName").toString().equals("Washim") || 
               session.getAttribute("EmpName").toString().equalsIgnoreCase("Poonam Dixit") ))
                {%>
           <li><a href="UploadOpenProjectSheet.jsp">Task Upload</a></li>
             <% } %>	 
           <li><a href="UploadOpenProjectSheet.jsp">Task Upload</a></li>
           </ul> </li> 
            <%	if(role.equalsIgnoreCase("HR")){ %>
                  <li><a class="dropdown-item" href="UploadAttendance.jsp">Upload Attendance</a></li>
            <%}%>
                  <li><a class="dropdown-item" href="AttendanceReport.jsp">Attendance Report</a></li>
                  <li><a class="dropdown-item" href="HolidayMaster1.jsp">Holiday Master</a></li>
             <% if(role.equals("AllAdmin")){%>
                  <li><a class="dropdown-item" href="RevisePayApproval.jsp">Revise Pay Approval</a></li>
                  <li><a class="dropdown-item" href="RevisePayReport.jsp">Revise Pay Report</a></li>
              <%}%>    
                  <li><a class="dropdown-item" href="PaidaysReport.jsp">Payroll Days Status</a></li>
             <% if(role.equals("Hr")){%>
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Email Template
                  </a>
                    <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                      <li><a class="dropdown-item" href="template.jsp">Create Template</a></li>
                      <li><a class="dropdown-item" href="ContractMasterSendmail.jsp">Send Email</a></li>   
                      <li><a class="dropdown-item" href="SendmailReport.jsp">Send Email Reports</a></li>     
                    </ul> </li>
                <li><a class="dropdown-item" href="TaskFinalStatus.jsp">Task Final Status</a></li>		           									
                <li><a class="dropdown-item" href="ContractMasterReport.jsp">Contract Master</a></li>
                <li><a class="dropdown-item" href="RevisePayReport.jsp">Revise Pay Report</a></li>
                <li><a class="dropdown-item" href="PayRollReport2.jsp">Pay Roll Generation</a></li>
              <%} %>
                 <li><a class="dropdown-item" href="FinalPayReport.jsp">Final Pay Report</a></li>
                  <% 
		 if(role.equals("HOD") || role.equals("AllAdmin")) 
		     { 
		   %>
              <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Open Issue
          </a>
           <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                      <li class="dropend"><a class="dropdown-toggle" href="#" id="ddropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                       Dashboard
                        </a>
               <ul class="dropdown-submenu" aria-labelledby="ddropdown">
                      <li><a class="dropdown-item" href="OpenIssueDashBoard.jsp">Priority wise Dashboard</a></li>
                      <li><a class="dropdown-item" href="OpenIssueDashBoard1.jsp">Developer Wise Dashboard</a></li>
                      
               </ul> </li>
                      <li><a class="dropdown-item" href="OpenIssueTrackerEdit.jsp">Report</a></li>
                     
          </ul> </li>						
		 <% } else{ %>
			        <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Open Issue
          </a>
           <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                      <li><a class="dropdown-item" href="OpenIssueTracker.jsp">Report</a></li>
                     
          </ul> </li>	
          <%}%> 
         
          
          
               <ul class="mega-links" id="hrMenu">
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           Leave
          </a>
           <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                <li><a class="dropdown-item" href="leaveapplication.jsp">Leave Apply</a></li>		           									
                <li><a class="dropdown-item"  href="leaveRequestReport.jsp">Leave Report</a></li>
                </ul>
                </ul>
</div>
<%} }%>

<%-- DMS MODULE --%>

<div class="row">
  <header onclick="toggleMenu('dmsMenu')"><b>DMS</b></header>
  <ul class="mega-links" id="dmsMenu">
    <li><a class="dropdown-item" href="IwrdScan.jsp">Upload Document</a></li>
    <li><a class="dropdown-item" href="IwrdScanReport.jsp">Inward Uploaded Docs</a></li>
    <li><a class="dropdown-item" href="inward.jsp">Inward Entry</a></li>
    <li><a class="dropdown-item" href="inwardReport.jsp">Inward Report</a></li>
    <li><a class="dropdown-item" href="billTracking.jsp">Tracking Report</a></li>
    <li><a class="dropdown-item" href="inwardglobal.jsp">Global Search</a></li>
  </ul>
</div>

<!-- Incident Module -->
<div class="row">
  <header onclick="toggleMenu('incidentMenu')"><b>Incident</b></header>
  <ul class="mega-links" id="incidentMenu">
    <li><a class="dropdown-item" href="incidentEntryForm.jsp">Enter Incident</a></li>
    <li><a class="dropdown-item" href="incidentDataReport.jsp">Generate Incident</a></li>
     </ul>
</div>



    <%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes"))
{ %>
<div class="row">
                <header onclick="toggleMenu('salesMenu')"><b>Sales</b></header>
                <ul class="mega-links" id="salesMenu">
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="fDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      File
                    </a>
                     <ul class="dropdown-submenu" aria-labelledby="fDropdown">
                     <li class="dropend"><a class="dropdown-toggle" href="#" id="nDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      New
                    </a>
                      <ul class="dropdown-submenu" aria-labelledby="nDropdown">
                     <li class="dropend"><a class="dropdown-toggle" href="#" id="eDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Enquiry
                    </a>
                       <ul class="dropdown-submenu" aria-labelledby="eDropdown">
                      <li><a class="dropdown-item" href="sales.jsp">Domestic</a></li>
                      <li><a class="dropdown-item" href="Exportsales.jsp">Export</a></li>
                      </ul>
                      
                     </li>
                      <li><a class="dropdown-item" href="salesenq.jsp">Quotation</a></li>
                      <li><a class="dropdown-item" href="salesorder.jsp">Order</a></li>
                      <li><a class="dropdown-item" href="invoiceReport.jsp?id=proforma">Proforma Invoice</a></li>
                       <li class="dropend"><a class="dropdown-toggle" href="#" id="iDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Invoice
                    </a>
                       <ul class="dropdown-submenu" aria-labelledby="iDropdown">
                      <li><a class="dropdown-item" href="ProformaInvcList.jsp">From Proforma</a></li>
                      <li><a class="dropdown-item" href="invoiceReport.jsp?id=main">From Order</a></li>
                      </ul>
                      
                     </li>
                      </ul>
                     </li>
		           	 <li class="dropend"><a class="dropdown-toggle" href="#" id="cDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Close
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="cDropdown">
                     	  <li><a class="dropdown-item" href="salesEnqReport.jsp?id=close">Enquiry</a></li>
		           		  <li><a class="dropdown-item" href="showquotationlist.jsp?id=close">Quotation</a></li>
		           		  <li><a class="dropdown-item" href="showorderlist.jsp?id=close">Order</a></li>
		           		  <li><a class="dropdown-item" href="showinvoicelist.jsp?id=proformaclose">Proforma Invoice</a></li>
		           		  <li><a class="dropdown-item" href="showinvoicelist.jsp?id=close">Invoice </a></li>
		           	     </ul>
                     </li>           	 
		           	 <li class="dropend"><a class="dropdown-toggle" href="#" id="rDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Revision
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="rDropdown">
                     	    <li><a class="dropdown-item" href="salesEnqReport.jsp?id=revise">Enquiry</a></li>
		        			<li><a class="dropdown-item" href="showquotationlist.jsp?id=revise">Quotation</a></li>
		        			<li><a class="dropdown-item" href="showorderlist.jsp?id=revise">Order </a></li>
		         			<li><a class="dropdown-item" href="showinvoicelist.jsp?id=proformarevise">Proforma Invoice </a></li>
		         			<li><a class="dropdown-item" href="showinvoicelist.jsp?id=revise">Invoice</a></li>
		         		</ul>
                     </li>
		           	 <li class="dropend"><a class="dropdown-toggle" href="#" id="vDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      View
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="vDropdown">
                     	    <li><a class="dropdown-item" href="salesEnqReport.jsp?id=View">Enquiry</a></li>
		         			<li><a class="dropdown-item" href="showquotationlist.jsp?id=View">Quotation</a></li>
		         			<li><a class="dropdown-item" href="showorderlist.jsp?id=View">Order</a></li>
		         			<li><a class="dropdown-item" href="showProformaInvoice.jsp?id=View">Proforma Invoice</a></li>
		          			<li><a class="dropdown-item" href="showinvoicelist.jsp?id=View">Invoice</a></li>
		         	     </ul>
                     </li>
                    </ul>              
                  </li>
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="eDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Edit
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="eDropdown">
                     	    <li><a class="dropdown-item" href="#">Under Construction</a></li>
		         	     </ul>
                     </li>
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="viewDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      View
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="viewDropdown">
                              <li><a class="dropdown-item" href="ReceivableReport.jsp">Receivable Report</a></li>
           				      <li><a class="dropdown-item" href="transporterInstallationReport.jsp">Transporter Report</a></li>
           	            </ul>
                     </li>
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="tDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Tools
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="tDropdown">
                         	<% 
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
         			{		
						%>	
                             <li><a class="dropdown-item" href="BillingDetailsReport.jsp">Vehicle Bill Status</a></li> 
           					 <li><a class="dropdown-item" href="transporterData.jsp">Update Transporter</a></li>
          					 <li><a class="dropdown-item" href="TotalNotAddedVehicles.jsp">Add New Vehicles</a></li> 
         					 <li><a class="dropdown-item" href="vehiclebillreport.jsp">Billing Report</a></li> 
         					 <li><a class="dropdown-item" href="autogeneratedbillreport.jsp">Vehicle Billing</a></li>
         					 <li><a class="dropdown-item" href="AutoSendMail.jsp">Auto Billing Mail Report</a></li>
         					 <li><a class="dropdown-item" href="physicaldamagereport.jsp">Damage Billing</a></li>
         					 <li><a class="dropdown-item" href="MonthlyInvoiceDetails.jsp">Monthly Service Invoice Report</a></li>
							 <li><a class="dropdown-item" href="MonthlyBillingStatusReport.jsp">Monthly Billing Status</a></li>
               				 <li><a class="dropdown-item" href="ASCSummaryReport.jsp">ASC Summary</a></li>
         					 <li><a class="dropdown-item" href="ASCPendingInvoiceReport.jsp">ASC Invoice</a></li>
        				    <%} %>  
           	            </ul>
                     </li>
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="hDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Help
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="hDropdown">
                     	    <li><a class="dropdown-item" href="#">Under Construction</a></li>
		         	     </ul>
                     </li>
                  
                </ul>
</div>
<%} %>

<%if(Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")) 
{ %> 
<div class="row">
                <header onclick="toggleMenu('purchaseMenu')"><b>Purchase</b></header>
                <ul class="mega-links" id="purchaseMenu">
                   <li class="dropend"><a class="dropdown-toggle" href="#" id="pfDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      File
                    </a>
                     <ul class="dropdown-submenu" aria-labelledby="fDropdown">
                     <li class="dropend"><a class="dropdown-toggle" href="#" id="pnDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      New
                    </a>
                      <ul class="dropdown-submenu" aria-labelledby="nDropdown">
                     <li class="dropend"><a class="dropdown-toggle" href="#" id="peDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Enquiry
                    </a>
                       <ul class="dropdown-submenu" aria-labelledby="peDropdown">
                           <li><a class="dropdown-item" href="PurchaseEnquiry.jsp">Enquiry</a></li>
		           		   <li><a class="dropdown-item" href="ExportPurchaseEnquiry.jsp">Export Enquiry</a></li>
                      </ul>
                      
                     </li>
                      <li><a class="dropdown-item" href="purchaseQuotation.jsp">Quotation</a></li>
		           	  <li><a class="dropdown-item" href="purchaseOrder.jsp">Order </a></li>
		           	  <li><a class="dropdown-item" href="purchaseInvoice.jsp">Invoice</a></li>
		           	 <li><a class="dropdown-item" href="addNewSupplier.jsp">Add Supplier</a></li>
                      </ul>
                     </li>
		           	 <li class="dropend"><a class="dropdown-toggle" href="#" id="pcDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Close
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="pcDropdown">
                     	     <li><a class="dropdown-item" href="PurchaseEnqList.jsp?id=close">Enquiry</a></li>
		           		     <li><a class="dropdown-item" href="PurchaseQuatationList.jsp?id=close">Quotation</a></li>
		           			 <li><a class="dropdown-item" href="PurchaseOrderList.jsp?id=close">Order </a></li>
		           			 <li><a class="dropdown-item" href="PurchaseInvoiceList.jsp?id=close">Invoice </a></li>
		           	     </ul>
                     </li>           	 
		           	 <li class="dropend"><a class="dropdown-toggle" href="#" id="prDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Revise
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="prDropdown">
                     	      <li><a class="dropdown-item" href="PurchaseEnqList.jsp?id=revise">Enquiry</a></li>
		         			  <li><a class="dropdown-item" href="PurchaseQuatationList.jsp?id=revise">Quotation</a></li>
		         			  <li><a class="dropdown-item" href="PurchaseOrderList.jsp?id=revise">Order </a></li>
		          			  <li><a class="dropdown-item" href="PurchaseInvoiceList.jsp?id=revise">Invoice</a></li>
		         		</ul>
                     </li>
		           	 <li class="dropend"><a class="dropdown-toggle" href="#" id="pvDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      View
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="pvDropdown">
                     	     <li><a class="dropdown-item" href="PurchaseEnqList.jsp">Enquiry</a></li>
		         			 <li><a class="dropdown-item" href="PurchaseQuatationList.jsp">Quotation</a></li>
		        			 <li><a class="dropdown-item" href="PurchaseOrderList.jsp">Order </a></li>
		          			 <li><a class="dropdown-item" href="PurchaseInvoiceList.jsp">Invoice</a></li>
		         	     </ul>
                     </li>
                    </ul>              
                  </li>
                   <li class="dropend"><a class="dropdown-toggle" href="#" id="pedDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Edit
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="pedDropdown">
                     	    <li><a href="editSupplier.jsp">Edit Supplier</a></li>
		         	     </ul>
                     </li> 
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="repDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Reports
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="repDropdown">
	    							 <li class="dropend"><a class="dropdown-toggle" href="#" id="p1eDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     All Enquiry
                                     </a>
                                          <ul class="dropdown-submenu" aria-labelledby="paeDropdown">
		           							<li><a class="dropdown-item" href="PurchaseEnqList.jsp">By Date Range</a></li>
                                         </ul>
                                      </li>
	    							<li><a class="dropdown-item" href="purchaseClosedEnquries.jsp">Closed Enquiry </a></li>
	    							<li><a class="dropdown-item" href="PurchaseQuatationList.jsp">Purchase Quotation </a></li>
	    							<li><a class="dropdown-item" href="PurchaseOrderReport.jsp">Purchase Order </a></li>
	    							<li><a class="dropdown-item" href="PurchaseInvoiceList.jsp">Purchase Invoice </a></li> 
	    							<li><a class="dropdown-item" href="purchaseGRN report.jsp">Purchase GRN </a></li>
	    							<li><a class="dropdown-item" href="paymentAccDet.jsp">Payment Report </a></li>
	      							<li><a class="dropdown-item" href="PaymnetRepForAllSupp.jsp">Vendor's Payments</a></li>
	      							<li><a class="dropdown-item" href="ItemwisedetailsP.jsp">Purchase Orders</a></li>
           	               </ul>
                     </li>
                    <li class="dropend"><a class="dropdown-toggle" href="#" id="ptDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Tools
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="ptDropdown">
                                    <li class="dropend"><a class="dropdown-toggle" href="#" id="p1eDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     All Enquiry
                                     </a>
                                          <ul class="dropdown-submenu" aria-labelledby="paeDropdown">
	                                         <li><a class="dropdown-item" href="GroupMaster.jsp?id=group">Group</a></li>
		           							<li><a class="dropdown-item" href="GroupMaster.jsp?id=make">Make</a></li>                                         </ul>
                                      </li>
            		 				<li><a class="dropdown-item" href="stockdet.jsp">Stock Update</a></li>
           	            </ul>
                     </li>
                   <li><a href="purchase.jsp">Search</a></li>
                  <li class="dropend"><a class="dropdown-toggle" href="#" id="phDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Help
                    </a>
                         <ul class="dropdown-submenu" aria-labelledby="phDropdown">
                     	    <li><a class="dropdown-item" href="#">Under Construction</a></li>
		         	     </ul>
                     </li>
                </ul>
</div>
<% }%>  

<div class="row">
                <header onclick="toggleMenu('claimsMenu')"><b>Claims</b></header>
                <ul class="mega-links" id="claimsMenu">
                  <li><a class="dropdown-item" href="claimReport.jsp?action=view">My Claim</a></li>
         		  <li><a class="dropdown-item" href="AdvanceClaimReport.jsp">Advance Report</a></li>
                  <%if(Sesrole.equals("AllAdmin") || Sesrole.equals("HOD")) 	
						{%>
     			  <li><a class="dropdown-item" href="claimReport.jsp?action=check">Check Claim</a></li>
     				<%}%>
     				<%
     				if(Sesdepartment.equals("Accounts")){ %>
     			 <li><a class="dropdown-item" href="AccountClaimReport.jsp?action=approve">Approved Claim</a></li>
     			 <li><a class="dropdown-item" href="claimReport.jsp?action=sanction">Sanction Claim</a></li>
    				 <%}%>
                </ul>
<%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
                <header onclick="toggleMenu('mergeMenu')"><b>Merge</b></header>
                <ul class="mega-links" id="mergeMenu">
                   <li><a class="dropdown-item" href="Mergeprocpect.jsp">Prospect</a></li>
         		   <li><a class="dropdown-item" href="MergeCustomer.jsp">Customer</a></li>
	        	   <li><a class="dropdown-item" href="itemmerging.jsp">Item</a></li>
                </ul>
</div>
<%} %>
   
  <%if(Account.equalsIgnoreCase("Yes") || AccountAdmin.equalsIgnoreCase("Yes")){%>
<div class="row">
                <header onclick="toggleMenu('accountsMenu')"><b>Accounts</b></header>
                <ul class="mega-links" id="accountsMenu">
                   <li class="dropend"><a class="dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                   Data Entry</a>
                    <ul class="dropdown-submenu" aria-labelledby="dropdownMenuLink">
                            <li><a class="dropdown-item" href="vouchers.jsp">Vouchers</a></li>
   							<li><a class="dropdown-item" href="bankreco.jsp">Bank Reconciliation</a></li>
   							<li><a class="dropdown-item" href="epayments.jsp">e-Payments</a></li>
   							<li><a class="dropdown-item" href="paymentEntryForm.jsp">Payments Entry</a></li>
   							<li><a class="dropdown-item" href="Reconsilation.jsp">Reconsilation</a></li>   
   							<%if(AccountAdmin.equalsIgnoreCase("Yes")){%>
   						 	<li class="dropend"><a class="dropdown-toggle" href="#" id="nbDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Net Banking </a>
   								<ul class="dropdown-submenu" aria-labelledby="nbDropdown">
                                 <li class="dropup dropdown no-caret"><a class="dropdown-toggle" href="#" id="masterDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Master &#9650;</a>
                                     <ul class="dropdown-menu dropdown-submenu" aria-labelledby="masterDropdown">
                                        <li><a class="dropdown-item" href="accountReport.jsp">Account Master</a></li>
   										<li><a class="dropdown-item" href="categoryMasterReport.jsp">Category Master</a></li>
      								 </ul>
                                 </li>
                                 <li class="dropup dropdown no-caret"><a class="dropdown-toggle" href="#" id="tranDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Transaction &#9650;</a>
                                     <ul class="dropdown-menu dropdown-submenu" aria-labelledby="tranDropdown">
                                        <li><a class="dropdown-item" href="netBankingEntry.jsp">Entry</a></li>
      									<li><a class="dropdown-item" href="netBankingApprove.jsp">Approve</a></li>
     									<li><a class="dropdown-item" href="netBankingCreateFile.jsp">Create File</a></li>
     								</ul>
                                 </li>
                                 <li class="dropup dropdown no-caret"><a class="dropdown-toggle" href="#" id="reportsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Reports &#9650;</a>
                                     <ul class="dropdown-menu dropdown-submenu" aria-labelledby="reportsDropdown">
                                         <li><a class="dropdown-item" href="accountEnteredbyReport.jsp">Account Entry</a></li>
      							   		 <li><a class="dropdown-item" href="FileApprovedbyreport.jsp">File Approve</a></li>
      									 <li><a class="dropdown-item" href="FileCreatedbyreport.jsp">File creation</a></li>
      								  </ul>
                                     </li>
           	                    </ul>
   								</li>
									<%}%>	
   							<li><a class="dropdown-item" href="Netbankfilestatus.jsp">NetBank File Status</a></li>
    						<li><a class="dropdown-item" href="RepeatEntry.jsp">Repeat Payment</a></li>
    						<li><a class="dropdown-item" href="TallyInterface.jsp">Sync.Tally Customer</a></li>
    						<li><a class="dropdown-item" href="TallySupInterface.jsp">Sync.Tally Supplier</a></li>
           	       </ul>
                   </li>
				   <li class="dropend"><a class="dropdown-toggle" href="#" id="reportDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Reports </a>
                                     <ul class="dropdown-submenu" aria-labelledby="reportDropdown">
                                         <li><a class="dropdown-item" href="tallycompare.jsp">Tally Comparison</a></li>
   									     <li><a class="dropdown-item" href="cheques.jsp">Cheque Payments</a></li>
   									     <li><a class="dropdown-item" href="allReports.jsp">Day Book</a></li>
   									     <li><a class="dropdown-item" href="paymentReport.jsp">Approval Payments</a></li>
   									     <li><a class="dropdown-item" href="AllPaymentReport.jsp">All Payments</a></li>
   									     <li><a class="dropdown-item" href="TallyInterface.jsp">Sync.Customer(T & E)</a></li>
   									     <li><a class="dropdown-item" href="TallySupInterface.jsp">Sync.Supplier(T & E)</a></li>
    								     <li><a class="dropdown-item" href="netbankreport.jsp">Net Banking</a></li>
         							     <li><a class="dropdown-item" href="RepeatEntryDet.jsp">Repeat Payment</a></li>
         							     <li><a class="dropdown-item" href="InvoiceDetailsReport.jsp">Invoice GST Detail</a></li>
                                     </ul>
                                     </li>
				   <li class="dropend"><a class="dropdown-toggle" href="#" id="extDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Export to Tally </a>
                                     <ul class="dropdown-submenu" aria-labelledby="extDropdown">
                                        <li><a href="tally_custmst.jsp">Customer Master</a></li>
   									    <li><a class="dropdown-item" href="tally_invoice.jsp">Invoices</a></li>
   									    <li><a class="dropdown-item" href="tally_GSTinvoice.jsp">GST Invoices</a></li>
   									    <li><a class="dropdown-item" href="tally_receipts.jsp">Receipts</a></li>
   									    <li><a class="dropdown-item" href="tally_creditnote.jsp">Credit Note</a></li>
   									    <li><a class="dropdown-item" href="tally_debitnote.jsp">Debit Note</a></li> 
   									    <li><a class="dropdown-item" href="tally_supmst.jsp">Supplier Masters</a></li>
   									    <li><a class="dropdown-item" href="tally_purchases.jsp">Purchases</a></li>
   									    <li><a class="dropdown-item" href="tally_payments.jsp">Payments</a></li>
   								   </ul>
                                     </li>
				   <li class="dropend"><a class="dropdown-toggle" href="#" id="trDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Tally Reports</a>
                                     <ul class="dropdown-submenu" aria-labelledby="trDropdown">
                                       <li><a class="dropdown-item" href="Tally_reports.jsp?Trial_balance">Trial Balance</a></li>
  									   <li><a class="dropdown-item" href="Tally_reports.jsp?Balance_sheet">Balance Sheet</a></li>
   									   <li><a class="dropdown-item" href="Tally_reports.jsp?Day_book">Day Book</a></li>
   									   <li><a class="dropdown-item" href="Tally_reports.jsp?Ratio_analysis">Ratio Analysis</a></li>
   									   <li><a class="dropdown-item" href="tally_banks.jsp">Bank Balances</a></li>
   								</ul>
                                     </li>
				   <li class="dropend"><a class="dropdown-toggle" href="#" id="smDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                     Setup Masters</a>
                                     <ul class="dropdown-submenu" aria-labelledby="smDropdown">
                                        <li><a class="dropdown-item" href="accountmst.jsp">Account Master</a></li>
  										<li><a class="dropdown-item" href="groupmst.jsp">Group Master</a></li>
   										<li><a class="dropdown-item" href="costcenter.jsp">Cost Center</a></li>
   										<li><a class="dropdown-item" href="productmst.jsp">Product Master</a></li>
   									</ul>
                                     </li>
                </ul>
</div>
 <%} %>  
     <%if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")){%>
<div class="row">
                <header onclick="toggleMenu('collectionMenu')"><b>Collection</b></header>
                <ul class="mega-links" id="collectionMenu">
                    <li><a class="dropdown-item" href="collection.jsp">Collection</a></li>
  					<li><a class="dropdown-item" href="paymentReport.jsp">Payment Report</a></li>
  					<li><a class="dropdown-item" href="deductionreport.jsp">Payment Deduction</a></li>
  					<li><a class="dropdown-item" href="followupMarketingRep.jsp">Follow-Up Report</a></li>
				<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
					{%>
               		<li><a class="dropdown-item" href="TransactionReport.jsp">Transaction Report</a></li> 
               		<%}%>
                </ul>
</div>
 <%} %> 
 
  <% 	if(role.equalsIgnoreCase("HR")) { %> 
<div class="row">
  <header onclick="toggleMenu('dmsMenu')"><b>TwTech HR</b></header>
  <ul class="mega-links" id="dmsMenu">
    <li><a class="dropdown-item" href="employeeReport.jsp">Add User</a></li>
    <li><a class="dropdown-item" href="contractorReport.jsp">Contract Master</a></li>
    <li><a class="dropdown-item" href="payableReport.jsp">Payroll</a></li>
    <li><a class="dropdown-item" href="HRattendanceReport.jsp">Attendance Summary</a></li>
    <li><a class="dropdown-item" href="Hr_companyReport.jsp">Company</a></li>
    <li><a class="dropdown-item" href="departmentReport.jsp">Department</a></li>
      <li><a class="dropdown-item" href="TWApply.jsp">Application Form</a></li>
    <li><a class="dropdown-item" href="applicant_report.jsp">Applicant Report</a></li>
    <li><a class="dropdown-item" href="Reasonreport.jsp">Attendance Reason Master</a></li>
    <li><a class="dropdown-item" href="leaveRequestReport_hr.jsp">Leave Report</a></li>
    <li><a class="dropdown-item" href="checkInOutReport.jsp">Attendance Report</a></li>
  </ul>
</div>
 <%} %>  
 
 <%if(Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")) 
{ %> 
<div class="row">
                <header onclick="toggleMenu('pprnMenu')"><b>Purchase PRN</b></header>
                <ul class="mega-links" id="pprnMenu">
                  <li><a class="dropdown-item" href="PurchasePRNEnquiry.jsp">Purchase PRN Enquiry</a></li>
         		 <li><a class="dropdown-item" href="PurchaseRequisitionEnquiryReport.jsp">Purchase PRN Report</a></li>
                </ul>
 
<%} %>
                <header><b></b></header>

                <ul class="mt-1 d-inline-block" id="othermenu"  style="width: max-content; min-width: unset;">
                     <%if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")){%>
                         <li style="background-color:#1582AB;color:white;"><a class="dropdown-item" href="collectionStaffReport.jsp" style="text-decoration:none;color:white;">Collection Staff</a></li>
                      <%} %> 
                        <%if(!comsessionid.equalsIgnoreCase("100061")){
%>
		 			<li style="background-color:#1582AB;color:white;margin-top:2px;"><a class="dropdown-item" href="Reconsilation.jsp" style="text-decoration:none;color:white;">Reconciliation</a></li>
		 			<li style="background-color:#1582AB;color:white;margin-top:2px;"><a class="dropdown-item" href="Emaildetails.jsp" style="text-decoration:none;color:white;">Email Template</a></li>
                   <%} %>
                   <%if(SalesAdmin.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
		 				<li style="background-color:#1582AB;color:white;margin-top:2px;"><a class="dropdown-item" href="GlobalSearch_1.jsp" style="text-decoration:none;color:white;">Global Search</a></li>
		 			<%} %>
		       </ul>
</div>

            </div>
          </div>
        </li>        
<li id="mainli">
  <a href="#" class="desktop-item">Reports</a>

  <div class="mega-box">
<div class="content">
  <ul class="mega-links grid-list">
    <% if(session.getAttribute("CompanyMasterID").toString().equalsIgnoreCase("100039")) { %>
      <li><a href="ItemMaster.jsp">Item Master</a></li>
      <li><a href="SupplierMaster.jsp">Supplier Master</a></li>
    <% } %>
    <li><a href="CustomerMaster1.jsp">Customer Master</a></li>
    <li><a href="FunnelReportNew.jsp">Funnel Report</a></li>
    <% if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5") && PurchaseAdmin.equalsIgnoreCase("Yes")) || session.getAttribute("userLevel").toString().equalsIgnoreCase("level6") || (Admin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")) ) { %>
      <li><a href="PendingPurchaseOrderList.jsp">Pending Order Report</a></li>
    <% } %>

    <% if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")) { %>
      <li><a href="marketingCustomerReportDateWise.jsp">Follow-Up</a></li>
      <li><a href="customer_wise_ledger.jsp">Aging</a></li>
      <li><a href="salesEnqReport.jsp?id=">Sales Enquiry</a></li>
      <li><a href="ledgerdetails.jsp">Ledger A/c Details</a></li>
      <li><a href="marketingReport.jsp">Marketing</a></li>
      <li><a href="ShowEnquiry.jsp">Sales Master</a></li>
      <li><a href="InvoiceDetailsReport.jsp">Invoice GST Detail</a></li>
    <% } %>

    <% if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")) { %>
      <li><a href="customer_wise_ledger.jsp">Aging</a></li>
    <% } %>

    <% if(session.getAttribute("isMarketingRepresentive") != null) { %>
      <li><a href="DashBoardForMarkt.jsp">Dash Board</a></li>
      <li><a href="ProspectStatusReport.jsp">Prospects Detail</a></li>
    <% } %>

    <% if(Admin.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")) { %>
      <li><a href="addNewMarketingRep.jsp?type=new">New Marketing Rep</a></li>
      <li><a href="Marketingeditreport.jsp">Master Marketing</a></li>
      <li><a href="followupMarketingRep.jsp">Customer Follow-Up</a></li>
    <% } %>

    <li><a href="ComplaintReport.jsp">My Complaints</a></li>
    <% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) && (Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes"))) { %>
      <li><a href="TransactionReport.jsp">Transaction Report</a></li>
    <% } %>
    <li><a href="ASCInvoiceDetails.jsp">ASC Invoice Details</a></li>
    <li><a href="contractdetails.jsp">Contract Report</a></li>
    <li><a href="MonthBillReport.jsp">Invoice Monthly Report</a></li>
    <li><a href="customerwiseledger.jsp">Ledger Summary Report</a></li>
  </ul>
</div>

  </div>
</li>
   		 <li id="mainli"><a href='#' class="dropdown-toggle" id="toolsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Tools</a>
   				<ul class="dropdown-menu custom-reports-dropdown" aria-labelledby="toolsDropdown">
     			    <li><a class="dropdown-item" href="ChangePassword.jsp">Change Password</a></li> 
   				</ul>
   		</li>  
   		   			<%if(Admin.equalsIgnoreCase("Yes") || SuperAdmin.equalsIgnoreCase("Yes")){%>
   		
   		 <li id="mainli"><a href='#' class="dropdown-toggle" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Admin</a>
   				<ul class="dropdown-menu custom-reports-dropdown" aria-labelledby="adminDropdown">
   				   <%if(Admin.equalsIgnoreCase("Yes")){%>
     			    <li><a class="dropdown-item" href="AdminModule.jsp">User Master</a></li> 
     			    <%}%>
     			    
     			    <%if((SuperAdmin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level6"))){ %>
     			    <li><a class="dropdown-item" href="companyReport.jsp">Company Master</a></li>
		  	    	<li><a class="dropdown-item" href="createComp.jsp">Add New Company</a></li>
		  	    	<li><a class="dropdown-item" href="UserAccessControl.jsp">Role Management</a></li>
     			    <%}%>
   				</ul>
   		</li>   
   		<%}%>  
        </ul>
        	<a href="#" onclick="openpopup('<%=PageName%>')" style="color: lime;text-decoration:none;">Log Complaint</a>
    <div class="profile-details">
        <div class="profile-content">
                <img src="imagesnew/User.png" alt="profileImg" class="profile-img">
        </div>
        <div class="name-job">
           <a href="logout.jsp" data-toggle="tooltip" title="Logout" style="text-decoration:none;">
            <div class="profile_name" style="color:White;"><%=session.getAttribute("EmpName")%></div>
            </a>
        </div>
        <a href="logout.jsp" title="Logout" class="logout-icon">
            <i class="bx bx-power-off"></i>
        </a>
    </div>
</nav>
   <script src="jsnew/script.js" defer></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const mainNavLinks = document.getElementById('mainNavLinks');

    mobileMenuToggle.addEventListener('click', function() {
        // Toggle the 'active' class to show/hide the menu
        mainNavLinks.classList.toggle('active');
        
        // Change the icon between menu and close (X) when clicked
        const icon = this.querySelector('i');
        if (mainNavLinks.classList.contains('active')) {
            icon.classList.remove('bx-menu');
            icon.classList.add('bx-x');
        } else {
            icon.classList.remove('bx-x');
            icon.classList.add('bx-menu');
        }
    });

    // Close menu when clicking outside of it (optional)
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.nav')) {
            mainNavLinks.classList.remove('active');
            const icon = mobileMenuToggle.querySelector('i');
            icon.classList.remove('bx-x');
            icon.classList.add('bx-menu');
        }
    });
});
</script>
<script>
function toggleMenu(menuId) {
    // Only run on mobile (you can adjust the breakpoint value, e.g., 768px)
    if (window.innerWidth <= 768) {
        const menu = document.getElementById(menuId);
        if (menu) {
            menu.classList.toggle('show');
        }
    }
}
function openpopup(PageName)
{
	try
	{
		testwindow=window.open("RegisterComplaint.jsp?PageName="+PageName,"Register Complaint","width=700,height=400,scrollbars=yes");
	 	testwindow.moveTo(200,200);
	}
	catch(e)
	{
		alert(e);
	}
}
</script>


  </body>
</html>