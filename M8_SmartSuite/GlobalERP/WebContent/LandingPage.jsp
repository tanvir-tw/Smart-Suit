<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="Landingheader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>

<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Jquery -->
<script src="jquery/jquery.min.js"></script>

<style>
/* Center the row and columns */
.row {
    display: flex;
    justify-content: center;  /* Center columns in the row */
}

/* Style for each column */
.col-4 {
    display: flex;
    justify-content: center;  /* Horizontally center the card */
    align-items: center;      /* Vertically center the card */
}

/* Card styling */
.card {
    width: 100%;  /* Take full width of the column */
    max-width: 300px;  /* Optional: set a max width for cards */
    margin: 10px;  /* Optional: space between the cards */
}

.container1 {
    width: 100%; /*460px*/
    padding: 40px;
    background: #ffffff;
    text-align: center;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
    position: relative;
}

.container1 .title {
    font-size: 2rem;
    color: #333;
}

.container1 .price {
    color: #FF6B6B;
    font-weight: 700;
    font-size: 2.2rem;
    margin: 15px 0;
}

.container1 span {
    font-size: 1rem;
}

.container1 .description {
    color: #3b3b3b;
    font-size: 1.1rem;
    margin: 20px 0 20px;
}

.container1 .offer {
    display: block;
    color: #555;
    font-size: 1rem;
    margin-top: 25px;
}


.ribbon-wrap {
    width: 150px;
    height: 150px;
    position: absolute;
    top: -10px;
    left: -10px;
    pointer-events: none;
}

.ribbon {
    width: 230px;
    font-size: 0.918rem;
    text-align: center;
    padding: 8px 0;
    background: #4a98f7;
    color: #fff;
    position: absolute;
    transform: rotate(-45deg);
    right: -17px;
    top: 29%;
}

html, body {
  background-image: url('imagesnew/bg.avif');
  background-size: cover;
  background-position: center;
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
}

.wrapper {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  padding: 10px;
  gap: 15px;
}

.card {
  background-color: #fff;
  border: 1px solid rgba(0, 0, 0, 0.125);
  border-radius: 0.5rem;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  overflow: hidden;
  text-align: center;
  transition: transform 0.2s;
  flex: 1 1 115px; /* Responsive base width */
  max-width: 180px;
}

.card:hover {
  transform: scale(1.03);
}

.card img {
  width: 100%;
  height: 120px;
  object-fit: contain;
  padding: 10px;
}

.card h5 {
  margin: 0;
  padding: 10px;
  font-size: 16px;
  color: #000;
}

a {
  text-decoration: none;
}

 .sub-menu {
        list-style-type: none;
        margin: 0; /* Remove default margin */
    }
    .toggle-icon {
        cursor: pointer;
        margin-left: 10px;
        background: none;
        border: none;
        font-size: 1em; /* Adjust size as needed */
        color: #007bff; /* Bootstrap primary color */
    }
    .list-group-item {
        background-color: #f8f9fa; /* Light background for list items */
        border: 1px solid #dee2e6; /* Border for list items */
        border-radius: 0.25rem; /* Rounded corners */
        margin-bottom: 0.5rem; /* Space between items */
        transition: background-color 0.3s; /* Smooth background transition */
    }
    .list-group-item:hover {
        background-color: #e2e6ea; /* Darker background on hover */
    }


.sub-menu li {
    position: relative; /* Required for positioning of submenu items */
}

.sub-menu li a {
    display: flex; /* Use flexbox to align items */
    align-items: center; /* Center items vertically */
}

 .sub-menu li a::before {
    content: ''; /* Add an empty content before the link */
    display: inline-block; /* Make it inline-block */
    width: 5px; /* Width of the bullet */
    height: 5px; /* Height of the bullet */
    background-color: cadetblue; /* Color of the bullet */
    border-radius: 50%; /* Make it circular */
    margin-right: 5px; /* Space between bullet and text */
} 
/* Mobile Optimizations */
@media (max-width: 768px) {
  .card {
    flex: 1 1 45%;
    max-width: 48%;
  }
    .d-flex {
    /* display: flex !important; */
}
    .container1{
  padding: 40px 20px 20px 40px;
  }
  
  .sub-menu{
  padding-left:0px;
  }
  
  .wrapper {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    padding: 10px;
    gap: 15px;
    margin-bottom: 10%;
}
  
}

@media (max-width: 480px) {
  .card {
    flex: 1 1 90%;
    max-width: 95%;
  }

  .card img {
    height: 100px;
  }

  .card h5 {
    font-size: 14px;
  }
  
  .container{
  margin-top: 90px;
  }
  
    .container1{
  padding: 40px 20px 20px 40px;
  }
  
  
  .d-flex {
    /* display: flex !important; */
}

 .sub-menu{
  padding-left:0px;
  }
  
  .wrapper {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    padding: 10px;
    gap: 15px;
    margin-bottom: 10%;
}
  
}
.card, img{
cursor: pointer;
}
</style>
<style>
 .menu-container {
      background: #fff;
      border: 1px solid #dee2e6;
      border-radius: .25rem;
      padding: 1rem;
    }
    .menu-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: .5rem 1rem;
      border: 1px solid #dee2e6;
      margin-bottom: .25rem;
      border-radius: .25rem;
      background: #f8f9fa;
    }
    .menu-item .title {
      display: flex;
      align-items: center;
      gap: .5rem;
      cursor: pointer;
    }
    .menu-item .title span {
      font-weight: 700;
    }
    .nested {
      margin-left: 2rem;
      display: none; /* hidden by default */
    }
    .nested.open {
      display: block; /* show when parent is clicked */
    }
    .drag-handle {
      cursor: grab;
      color: #6c757d;
    }
    .status-dot {
      width: 10px;
      height: 10px;
      border-radius: 50%;
      background: #6c757d;
      display: inline-block;
    }
    .status-dot.active {
      background: orange;
    }
</style>
 </head>
 <body>
 <%
// Variable Declaration
String role="",comType="";
 
 // Connection Initialization
Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    st10 = conn.createStatement();
   
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
 <%
try
{
	
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

%>
<div class="container-fluid" style="margin-top:90px;">
<div class="wrapper p-1">
<a href="home.jsp" class="card">
       <div class="content">
            <img src="imagesnew/home.gif" alt="home">
         <h5 class="text-center" style="color:black;">Home</h5>
       </div>
     </a>  
	<% 
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
         			{		
						%>	
      			
      			     <%if(HRModule.equalsIgnoreCase("Yes") || HRModule.equalsIgnoreCase("Yes") || comsessionid.equalsIgnoreCase("100052"))
{ %>
      
<div class="card" data-bs-toggle="modal" data-bs-target="#hrlistmodal">
       <div class="content" >
            <img src="imagesnew/HR.gif" alt="hr" data-bs-toggle="modal" data-bs-target="#hrlistmodal">
         <h5 class="text-center">HR</h5>
       </div>
     </div>
<%} }%>
<div class="card" data-bs-toggle="modal" data-bs-target="#leavelistmodal">
       <div class="content" >
            <img src="imagesnew/leave.gif" alt="hr" data-bs-toggle="modal" data-bs-target="#leavelistmodal">
         <h5 class="text-center">Leave</h5>
       </div>
</div>

<%-- DMS MODULE --%>
<% if(
     Sales.equalsIgnoreCase("Yes") ||
     Purchase.equalsIgnoreCase("Yes") ||
     Admin.equalsIgnoreCase("Yes") ||
     SuperAdmin.equalsIgnoreCase("Yes")
   ) { %>

<div class="card" data-bs-toggle="modal" data-bs-target="#dmslistmodal">
  <div class="content">
    <img src="imagesnew/Dms.gif" alt="dms" data-bs-toggle="modal" data-bs-target="#dmslistmodal">
    <h5 class="text-center">DMS</h5>
  </div>
</div>

<% } %>



<% if(
     Sales.equalsIgnoreCase("Yes") ||
     Purchase.equalsIgnoreCase("Yes") ||
     Admin.equalsIgnoreCase("Yes") ||
     SuperAdmin.equalsIgnoreCase("Yes")
   ) { %>

<div class="card" data-bs-toggle="modal" data-bs-target="#incidentlistmodal">
  <div class="content">
    <img src="imagesnew/Incident.gif" alt="incident" data-bs-toggle="modal" data-bs-target="#incidentlistmodal">
    <h5 class="text-center">Incident</h5>
  </div>
</div>

<% } %>

<%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")){%>
<div class="card" data-bs-toggle="modal" data-bs-target="#saleslistmodal">
     <div class="content">
            <img src="imagesnew/Sales.gif" alt="sales" data-bs-toggle="modal" data-bs-target="#saleslistmodal">
         <h5 class="text-center">Sales</h5>
       </div>
    </div>
<%}%>
<%if(Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")) 
{ %> 
<div class="card" data-bs-toggle="modal" data-bs-target="#purchaseprnlistmodal">
     <div class="content">
            <img src="imagesnew/purchaseprn.gif" alt="purchaseprn" data-bs-toggle="modal" data-bs-target="#purchaseprnlistmodal">
         <h5 class="text-center">Purchase PRN</h5>
       </div>
     </div>

     
     </div>
     
     <div class="wrapper p-1">
     
     <div class="card" data-bs-toggle="modal" data-bs-target="#purchaselistmodal">
     <div class="content">
            <img src="imagesnew/Purchase.gif" alt="purchase" data-bs-toggle="modal" data-bs-target="#purchaselistmodal">
         <h5 class="text-center">Purchase</h5>
       </div>
     </div>
<%}%>

<div class="card" data-bs-toggle="modal" data-bs-target="#claimslistmodal">
             <div class="content">
            <img src="imagesnew/Claim.gif" alt="claim" data-bs-toggle="modal" data-bs-target="#claimslistmodal">
         <h5 class="text-center">Claims</h5>
       </div>
    </div>

  <%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
<div class="card" data-bs-toggle="modal" data-bs-target="#mergelistmodal">
              <div class="content">
            <img src="imagesnew/merge.gif" alt="merge" data-bs-toggle="modal" data-bs-target="#mergelistmodal">
         <h5 class="text-center">Merge</h5>
       </div>
     </div>
     <%} %>
          
   <%
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("Transport")) && (session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")||session.getAttribute("userLevel").toString().equalsIgnoreCase("level4")))
					{
					%> 
<div class="card" data-bs-toggle="modal" data-bs-target="#transportlistmodal">
            <img src="imagesnew/transport.gif" alt="transport" data-bs-toggle="modal" data-bs-target="#transportlistmodal">
         <h5 class="text-center">Transport</h5>
       </div>
         		<%}%>
    
         		<%if(Account.equalsIgnoreCase("Yes") || AccountAdmin.equalsIgnoreCase("Yes")){%>
<div class="card" data-bs-toggle="modal" data-bs-target="#accountslistmodal">
             <div class="content">
            <img src="imagesnew/accounts.gif" alt="account" data-bs-toggle="modal" data-bs-target="#accountslistmodal">
         <h5 class="text-center">Accounts</h5>
       </div>
    </div>
<%} %>
      <%if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")){%>
<div class="card" data-bs-toggle="modal" data-bs-target="#collectionlistmodal">
              <div class="content">
            <img src="imagesnew/collection.gif" alt="collection" data-bs-toggle="modal" data-bs-target="#collectionlistmodal">
         <h5 class="text-center">Collection</h5>
       </div>
     </div>
     
<a href="collectionStaffReport.jsp" class="card">
        <div class="content">
            <img src="imagesnew/collectionstaff.gif" alt="collectionstaff" data-bs-toggle="modal" data-bs-target="#collectionstafflistmodal">
         <h5 class="text-center" style="color:black;">Collection Staff</h5>
       </div>
     </a>
         		<%}%>

<a href="Reconsilation.jsp" class="card">
               <div class="content">
            <img src="imagesnew/reconciliation.gif" alt="reconciliation" data-bs-toggle="modal" data-bs-target="#reconciliationlistmodal">
         <h5 class="text-center" style="color:black;">Reconciliation</h5>
       </div>
    </a>
     </div>
     <div class="wrapper p-3">

 <!--HR MODULE CONDITION   -->    
     <% 	
     if(role.equalsIgnoreCase("HR")) { %> 

<div class="card" data-bs-toggle="modal" data-bs-target="#TwtechHRlistmodal">
  <div class="content">
    <img src="imagesnew/TwtechHr.gif" alt="twtechHr" data-bs-toggle="modal" data-bs-target="#TwtechHRlistmodal">
    <h5 class="text-center" style="color:black;">Twtech HR</h5>
  </div>
</div>

<% } %> 
     
<a href="Emaildetails.jsp" class="card">
                <div class="content">
            <img src="imagesnew/emailtemplate.gif" alt="emailtemplate" data-bs-toggle="modal" data-bs-target="#emailtemplatelistmodal">
         <h5 class="text-center" style="color:black;">Email Template</h5>
       </div>
     </a>
     
     <%if(SalesAdmin.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
<a href="GlobalSearch_1.jsp" class="card">
        <div class="content">
            <img src="imagesnew/globalsearch.gif" alt="globalsearch" data-bs-toggle="modal" data-bs-target="#globalsearchlistmodal">
         <h5 class="text-center" style="color:black;">Global Search</h5>
       </div>
     </a>
         		<%}%>

<div class="card" data-bs-toggle="modal" data-bs-target="#reportslistmodal">
              <div class="content">
            <img src="imagesnew/Reports.gif" alt="reports" data-bs-toggle="modal" data-bs-target="#reportslistmodal">
         <h5 class="text-center">Reports</h5>
       </div>
     </div>
<div class="card" data-bs-toggle="modal" data-bs-target="#toolsmodal">
              <div class="content">
            <img src="imagesnew/tools.gif" alt="tools" data-bs-toggle="modal" data-bs-target="#toolsmodal">
         <h5 class="text-center">Tools</h5>
       </div>
     </div>
 <%if(Admin.equalsIgnoreCase("Yes") || SuperAdmin.equalsIgnoreCase("Yes")){%>
<div class="card" data-bs-toggle="modal" data-bs-target="#adminlistmodal">
              <div class="content">
            <img src="imagesnew/admin.gif" alt="admin" data-bs-toggle="modal" data-bs-target="#adminlistmodal">
         <h5 class="text-center">Admin</h5>
       </div>
     </div>
     <%} %>
</div>
</div>

<%
   	if(session.getAttribute("CompanyMasterID").toString().equalsIgnoreCase("100039")){%>
 <div class="wrapper p-3">

<!-- Add this once in your <head> -->
<div class="card" id="checkInCard" style="cursor:pointer;">
  <div class="content text-center p-3">
    <i class="fa-solid fa-right-to-bracket fa-3x" style="color: green;"></i>
    <h5 class="mt-2 text-success">Check In</h5>
  </div>
</div>
<div class="card" id="checkOutCard" style="cursor:pointer;">
  <div class="content text-center p-3">
    <i class="fa-solid fa-right-from-bracket fa-3x" style="color: red;"></i>
    <h5 class="mt-2 text-danger">Check Out</h5>
  </div>
</div>
    
</div>

<%} %>
<!-- HR modal -->
<div class="modal fade" id="hrlistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
   
<ol class="list-group">
<!-- <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="Dashboard_User.jsp">Dashboard</a></div>
    </div>
  </li>
 -->
 <div class="menu-item parent" data-target="performance-children">
      <div class="title"><span>Performance</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div>
    
          <div id="performance-children" class="nested">
          <div class="menu-item">
            <div class="title">
            <span><a href="AdvanceMoneyForm.jsp">Advance Entry</a></span>
            </div>
          </div>
          
            <div class="menu-item">
            <div class="title">
            <span><a href="TaskIndexCalculation.jsp">Index</a></span>
            </div>
          </div>
 
   <div class="menu-item">
            <div class="title">
            <span><a href="KRACalculation.jsp">KRA Index</a></span>
            </div>
          </div>
 
   <div class="menu-item">
            <div class="title">
            <span><a href="TaskApprovalReport.jsp">Task Status</a></span>
            </div>
          </div>
 
   <div class="menu-item">
            <div class="title">
            <span><a href="KRATaskStatusReport.jsp">KRA Status</a></span>
            </div>
          </div>
 	<% if(role.equals("AllAdmin") || role.equals("HOD") || role.equalsIgnoreCase("HR")) {%>
       <div class="menu-item">
            <div class="title">
            <span><a href="TaskAllocationReport.jsp">Task Allocation </a></span>
            </div>
          </div>
       <%} %>
 	<% if(role.equals("AllAdmin") || role.equals("HOD")) {%>
 	<div class="menu-item">
            <div class="title">
            <span><a href="TaskMailDownLodedDataReport.jsp">Task Approval</a></span>
            </div>
          </div>
       <%} %>

 		           				
<%if(role.equals("HOD") || role.equals("Admin") || role.equals("AllAdmin"))
	{%>
	<div class="menu-item">
            <div class="title">
            <span><a href="uploadTask.jsp">Task Upload</a></span>
            </div>
          </div>
<% } %>	      

        <div class="menu-item parent" data-target="scorecard-children">
          <div class="title"><span>Score Card</span></div><span style="color:#007bff;">&#x25BC;</span>
        </div>

      <div id="scorecard-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="ViewScores.jsp">View Emp Scores</a></span>
          </div>
        </div>
      <% if(!role.equals("-")){%>		           									
        <div class="menu-item">
          <div class="title">
            <span><a href="ScoreCardReport.jsp">Score Card</a></span>
          </div>
        </div>
          	<% }else if(role.equals("AllAdmin") || role.equals("HOD")) { %>
		  
          	   <div class="menu-item">
               <div class="title">
                 <span><a href="ScoreCardReport.jsp">Emp Score Report</a></span>
               </div>
             </div>
             <div class="menu-item">
             <div class="title">
               <span><a href="ViewScores.jsp">View Emp Scores</a></span>
             </div>
           </div>
		  <%}%>
		  
      </div>
      
        <div class="menu-item parent" data-target="projectsummary-children">
          <div class="title"><span>Project Summary</span></div><span style="color:#007bff;">&#x25BC;</span>
        </div>
        
             <div id="projectsummary-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="TaskSummaryReport.jsp">PI</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="KRASummaryReport.jsp">KRA</a></span>
          </div>
        </div>
		  
      </div>
        
    </div>
    
    
     <div class="menu-item parent" data-target="openproject-children">
      <div class="title"><span>Open Project</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div> 
    
          <div id="openproject-children" class="nested">
          
            <div class="menu-item">
            <div class="title">
            <span><a href="OPTaskIndexCalculation.jsp">Index</a></span>
            </div>
          </div>
 
   <div class="menu-item">
            <div class="title">
            <span><a href="OPKRACalculation.jsp">KRA Index</a></span>
            </div>
          </div>
 
   <div class="menu-item">
            <div class="title">
            <span><a href="OPTaskApprovalReport.jsp">Task Status</a></span>
            </div>
          </div>
 
   <div class="menu-item">
            <div class="title">
            <span><a href="OPKRATaskStatusReport.jsp">KRA Status</a></span>
            </div>
          </div>
 	<% if(role.equals("AllAdmin") || role.equals("HOD") || role.equalsIgnoreCase("HR")) {%>
       <div class="menu-item">
            <div class="title">
            <span><a href="OPTaskAllocationReport.jsp">Task Allocation </a></span>
            </div>
          </div>
       <%} %>
 	<% if(role.equals("AllAdmin") || role.equals("HOD")) {%>
 	<div class="menu-item">
            <div class="title">
            <span><a href="OPTaskMailDownLodedDataReport.jsp">Task Approval</a></span>
            </div>
          </div>
       <%} %>

 		           				
<%if(role.equals("HOD") || role.equals("Admin") || role.equals("AllAdmin"))
	{%>
	<div class="menu-item">
            <div class="title">
            <span><a href="UploadOpenProjectSheet.jsp">Task Upload</a></span>
            </div>
          </div>
<% } %>	      
       
    </div>
  <%
  	if(role.equalsIgnoreCase("HR")){ %>	
		<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="UploadAttendance.jsp">Upload Attendance</a></div>
    </div>
  </li>
	<%}
  %>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="AttendanceReport.jsp">Attendance Report</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="HolidayMaster1.jsp">Holiday Master</a></div>
    </div>
  </li>
	<% 
	if(role.equals("AllAdmin"))
	{	
		
	%>
	 <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="RevisePayApproval.jsp">Revise Pay Approval</a></div>
    </div>
  </li>
	 <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="RevisePayReport.jsp">Revise Pay Report</a></div>
    </div>
  </li>
	
	<%} %>
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="PaidaysReport.jsp">Payroll Days Status</a></div>
    </div>
  </li>







  	<% 	
	if(role.equals("Hr"))
	{
%>

 <div class="menu-item parent" data-target="Email-children">
      <div class="title"><span>Email Template</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div> 

 <div id="Email-children" class="nested">
          
            <div class="menu-item">
            <div class="title">
            <span><a href="template.jsp">Create Template</a></span>
            </div>
          </div>
           <div class="menu-item">
            <div class="title">
            <span><a href="ContractMasterSendmail.jsp">Send Email</a></span>
            </div>
          </div>
           <div class="menu-item">
            <div class="title">
            <span><a href="SendmailReport.jsp">Send Email Reports</a></span>
            </div>
          </div>
  </div>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="TaskFinalStatus.jsp">Task Final Status</a></div>
    </div>
  </li>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ContractMasterReport.jsp">Contract Master</a></div>
    </div>
  </li>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="RevisePayReport.jsp">Revise Pay Report</a></div>
    </div>
  </li>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="PayRollReport2.jsp">Pay Roll Generation</a></div>
    </div>
  </li>

<%} %>


    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="FinalPayReport.jsp">Final Pay Report</a></div>
    </div>
  </li>  
   <div class="menu-item parent" data-target="openissue-children">
      <div class="title"><span>Open Issue</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div>
    
       <div id="openissue-children" class="nested">
        <div class="menu-item parent" data-target="dashboard-children">
          <div class="title"><span>Dashboard</span></div><span style="color:#007bff;">&#x25BC;</span>
        </div>
           
      <div id="dashboard-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="OpenIssueDashBoard.jsp">Priority wise Dashboard</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="OpenIssueDashBoard1.jsp">Developer Wise Dashboard</a></span>
          </div>
        </div>
      </div>
      
      <div class="menu-item">
            <div class="title">
            <span><a href="OpenIssueTrackerEdit.jsp">Report</a></span>
            </div>
          </div>
       </div>   
         
</ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">HR</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- DMS modal -->
<div class="modal fade" id="dmslistmodal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">

        <div class="container1">
          <ol class="list-group">

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="IwrdScan.jsp">Upload Document</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="IwrdScanReport.jsp">Inward Uploaded Docs</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="inward.jsp">Inward Entry</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="inwardReport.jsp">Inward Report</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="billTracking.jsp">Tracking Report</a>
                </div>
              </div>
            </li>
            <%if(role.equalsIgnoreCase("HR")){ %>
            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="MasterTracking.jsp">Master Report</a>
                </div>
              </div>
            </li>

			<li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="billreport.jsp">Billing Report</a>
                </div>
              </div>
            </li>
            
            <%} %>
            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="inwardglobal.jsp">Inward Global Search</a>
                </div>
              </div>
            </li>

          </ol>

          <div class="ribbon-wrap">
            <div class="ribbon">DMS</div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="incidentlistmodal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">

        <div class="container1">
          <ol class="list-group">

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="incidentEntryForm.jsp">Enter Incident</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="incidentDataReport.jsp">Incident Report</a>
                </div>
              </div>
            </li>
          </ol>

          <div class="ribbon-wrap">
            <div class="ribbon">Incident</div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
<!-- Sales modal -->
<div class="modal fade" id="saleslistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
    <div class="container1">
     <div class="menu-container">
    
    <!-- File (Parent) -->  <!-- File Start -->
    <div class="menu-item parent" data-target="file-children">
      <div class="title"><span>File</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div>

    <!-- Children of File -->
    <div id="file-children" class="nested">
      <div class="menu-item parent" data-target="new-children">
        <div class="title"><span>New</span></div><span style="color:#007bff;">&#x25BC;</span>
      </div>

      <!-- Children of New -->
      <div id="new-children" class="nested">
        <div class="menu-item parent" data-target="enquiry-children">
          <div class="title"><span>Enquiry</span></div><span style="color:#007bff;">&#x25BC;</span>
        </div>

      <!-- Children of Enquiry -->
      <div id="enquiry-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="sales.jsp">Domestic</a></span>
          </div>
        </div>
      
        <!-- Children of Enquiry -->
        <div class="menu-item">
          <div class="title">
            <span><a href="Exportsales.jsp">Export</a></span>
          </div>
        </div>
      </div>

    <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="salesenq.jsp">Quotation</a></span>
          </div>
        </div>
      
       <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="salesorder.jsp">Order</a></span>
          </div>
        </div>
   
    <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="invoiceReport.jsp?id=proforma">Proforma Invoice</a></span>
          </div>
        </div>
      
           <!-- Children of New -->
        <div class="menu-item parent" data-target="invoice-children">
          <div class="title">
            <span>Invoice</span>
          </div>
      <span style="color:#007bff;">&#x25BC;</span>
        </div>

      
      <!-- Children of Enquiry -->
      <div id="invoice-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="ProformaInvcList.jsp">From Proforma</a></span>
          </div>
        </div>
      
        <!-- Children of Enquiry -->
        <div class="menu-item">
          <div class="title">
            <span><a href="invoiceReport.jsp?id=main">From Order</a></span>
          </div>
        </div>
      </div>
   
   </div>
   
        <div class="menu-item parent" data-target="close-children">
        <div class="title">
          <span>Close</span>
        </div>
       <span style="color:#007bff;">&#x25BC;</span>
     </div>
      
       <!-- Children of Close -->
      <div id="close-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="salesEnqReport.jsp?id=close">Enquiry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="showquotationlist.jsp?id=close">Quotation</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="showorderlist.jsp?id=close">Order</a></span>
          </div>
        </div>
   
        <div class="menu-item">
          <div class="title">
            <span><a href="showinvoicelist.jsp?id=proformaclose">Proforma Invoice</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="showinvoicelist.jsp?id=close">Invoice</a></span>
          </div>
        </div>
   </div>
   
        <div class="menu-item parent" data-target="revision-children">
        <div class="title">
          <span>Revision</span>
        </div>
      <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
  <!-- Children of Revision -->
      <div id="revision-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="salesEnqReport.jsp?id=revise">Enquiry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="showquotationlist.jsp?id=revise">Quotation</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="showorderlist.jsp?id=revise">Order</a></span>
          </div>
        </div>
   
        <div class="menu-item">
          <div class="title">
            <span><a href="showinvoicelist.jsp?id=proformarevise">Proforma Invoice</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="showinvoicelist.jsp?id=revise">Invoice</a></span>
          </div>
        </div>
   </div>

        <div class="menu-item parent" data-target="viewmain-children">
        <div class="title">
          <span>View</span>
        </div>
      <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
    <!-- Children of View -->
      <div id="viewmain-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="salesEnqReport.jsp?id=View">Enquiry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="showquotationlist.jsp?id=View">Quotation</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="showorderlist.jsp?id=View">Order</a></span>
          </div>
        </div>
   
        <div class="menu-item">
          <div class="title">
            <span><a href="showProformaInvoice.jsp?id=View">Proforma Invoice</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="showinvoicelist.jsp?id=View">Invoice</a></span>
          </div>
        </div>
   </div> 
      
</div>   <!-- File End -->

    <!-- Edit (Parent) -->  <!-- Edit Start -->
    <div class="menu-item parent" data-target="edit-children">
      <div class="title">
        <span>Edit</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
     <!-- Children of Edit -->
    <div id="edit-children" class="nested">
      <div class="menu-item">
        <div class="title">
          <span>Under Construction</span>
        </div>
      </div>

</div>   <!-- Edit End -->
    
        <!-- View (Parent) -->  <!-- View Start -->
       <div class="menu-item parent" data-target="view-children">
      <div class="title">
        <span>View</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
         <!-- Children of Edit -->
    <div id="view-children" class="nested">
      <div class="menu-item">
        <div class="title">
          <span><a href="ReceivableReport.jsp">Receivable Report</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title">
          <span><a href="transporterInstallationReport.jsp">Transporter Report</a></span>
        </div>
      </div>

</div>   <!-- View End -->

            <!-- Tools (Parent) -->  <!-- Tools Start -->    
       <div class="menu-item parent" data-target="tools-children">
      <div class="title">
        <span>Tools</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
            <!-- Children of Tools -->
    <div id="tools-children" class="nested">
    	<% 
					if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) )
         			{		
						%>	
      <div class="menu-item">
        <div class="title"><span><a href="BillingDetailsReport.jsp">Vehicle Bill Status</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="transporterData.jsp">Update Transporter</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="TotalNotAddedVehicles.jsp">Add New Vehicles</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="vehiclebillreport.jsp">Billing Report</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="autogeneratedbillreport.jsp">Vehicle Billing</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="AutoSendMail.jsp">Auto Billing Mail Report</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="physicaldamagereport.jsp">Damage Billing</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="MonthlyInvoiceDetails.jsp">Monthly Service Invoice Report</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="MonthlyBillingStatusReport.jsp">Monthly Billing Status</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="ASCSummaryReport.jsp">ASC Summary</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title"><span><a href="ASCPendingInvoiceReport.jsp">ASC Invoice</a></span>
        </div>
      </div>
	<%}
               		else
               		{
               		%>
               		
               		<%} %>
</div>   

<!-- Tools End -->
     
    
       <div class="menu-item parent" data-target="help-children">
      <div class="title">
        <span>Help</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
               <!-- Children of Tools -->
    <div id="help-children" class="nested">
      <div class="menu-item">
        <div class="title"><span>Under Construction</span>
        </div>
      </div>

</div> 

<!-- Help End -->
     
    
    <div class="ribbon-wrap">
      <div class="ribbon">Sales</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>
</div>

<!-- Purchase PRN modal -->
<div class="modal fade" id="purchaseprnlistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
   
<ol class="list-group">
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="PurchasePRNEnquiry.jsp">Purchase PRN Enquiry</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="PurchaseRequisitionEnquiryReport.jsp">Purchase PRN Report</a></div>
    </div>
  </li>
</ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">Purchase PRN</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>


<!-- Purchase modal -->
<div class="modal fade" id="purchaselistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
    <div class="container1">
     <div class="menu-container">
    
    <!-- File (Parent) -->  <!-- File Start -->
    <div class="menu-item parent" data-target="pfile-children">
      <div class="title"><span>File</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div>

    <!-- Children of File -->
    <div id="pfile-children" class="nested">
      <div class="menu-item parent" data-target="pnew-children">
        <div class="title"><span>New</span></div><span style="color:#007bff;">&#x25BC;</span>
      </div>

      <!-- Children of New -->
      <div id="pnew-children" class="nested">
        <div class="menu-item parent" data-target="penquiry-children">
          <div class="title"><span>Enquiry</span></div><span style="color:#007bff;">&#x25BC;</span>
        </div>

      <!-- Children of Enquiry -->
      <div id="penquiry-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseEnquiry.jsp">Enquiry</a></span>
          </div>
        </div>
      
        <!-- Children of Enquiry -->
        <div class="menu-item">
          <div class="title">
            <span><a href="ExportPurchaseEnquiry.jsp">Export Enquiry</a></span>
          </div>
        </div>
      </div>

    <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="purchaseQuotation.jsp">Quotation</a></span>
          </div>
        </div>
      
       <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="purchaseOrder.jsp">Order</a></span>
          </div>
        </div>
   
    <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="purchaseInvoice.jsp">Invoice</a></span>
          </div>
        </div>
      
           <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="addNewSupplier.jsp">Add Supplier</a></span>
          </div>
        </div>
   
   </div>
   
        <div class="menu-item parent" data-target="pclose-children">
        <div class="title">
          <span>Close</span>
        </div>
       <span style="color:#007bff;">&#x25BC;</span>
     </div>
      
       <!-- Children of Close -->
      <div id="pclose-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseEnqList.jsp?id=close">Enquiry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseQuatationList.jsp?id=close">Quotation</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseOrderList.jsp?id=close">Order</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseInvoiceList.jsp?id=close">Invoice</a></span>
          </div>
        </div>
   </div>
   
        <div class="menu-item parent" data-target="previse-children">
        <div class="title">
          <span>Revise</span>
        </div>
      <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
  <!-- Children of Revision -->
      <div id="previse-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseEnqList.jsp?id=revise">Enquiry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseQuatationList.jsp?id=revise">Quotation</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseOrderList.jsp?id=revise">Order</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseInvoiceList.jsp?id=revise">Invoice</a></span>
          </div>
        </div>
   </div>

        <div class="menu-item parent" data-target="pview-children">
        <div class="title">
          <span>View</span>
        </div>
      <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
    <!-- Children of View -->
      <div id="pview-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseEnqList.jsp">Enquiry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseQuatationList.jsp">Quotation</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseOrderList.jsp">Order</a></span>
          </div>
        </div>
        
        <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseInvoiceList.jsp">Invoice</a></span>
          </div>
        </div>
   </div> 
      
</div>   <!-- File End -->

    <!-- Edit (Parent) -->  <!-- Edit Start -->
    <div class="menu-item parent" data-target="pedit-children">
      <div class="title">
        <span>Edit</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
     <!-- Children of Edit -->
    <div id="pedit-children" class="nested">
      <div class="menu-item">
        <div class="title">
          <span><a href="editSupplier.jsp">Edit Supplier</a></span>
        </div>
      </div>

</div>   <!-- Edit End -->
    
        <!-- View (Parent) -->  <!-- View Start -->
       <div class="menu-item parent" data-target="preports-children">
      <div class="title">
        <span>Reports</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
         <!-- Children of Edit -->
    <div id="preports-children" class="nested">
    
    <div class="menu-item parent" data-target="pallenquiry-children">
        <div class="title"><span>All Enquiry</span>
        </div>
              <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
           <div id="pallenquiry-children" class="nested">
       <div class="menu-item">
          <div class="title">
            <span><a href="PurchaseEnqList.jsp">By Date Range</a></span>
          </div>
        </div>

      </div>
      
      <div class="menu-item">
        <div class="title">
          <span><a href="purchaseClosedEnquries.jsp">Closed Enquiry</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title">
          <span><a href="PurchaseQuatationList.jsp">Purchase Quotation</a></span>
        </div>
      </div>
         <div class="menu-item">
        <div class="title">
          <span><a href="PurchaseOrderReport.jsp">Purchase Order</a></span>
        </div>
      </div>
       <div class="menu-item">
        <div class="title">
          <span><a href="PurchaseInvoiceList.jsp">Purchase Invoice</a></span>
        </div>
      </div>
       <div class="menu-item">
        <div class="title">
          <span><a href="purchaseGRN report.jsp">Purchase GRN</a></span>
        </div>
      </div>
       <div class="menu-item">
        <div class="title">
          <span><a href="paymentAccDet.jsp">Payment Report</a></span>
        </div>
      </div>
       <div class="menu-item">
        <div class="title">
          <span><a href="PaymnetRepForAllSupp.jsp">Vendor's Payments</a></span>
        </div>
      </div>
       <div class="menu-item">
        <div class="title">
          <span><a href="ItemwisedetailsP.jsp">Purchase Orders</a></span>
        </div>
      </div>
</div>   <!-- View End -->

            <!-- Tools (Parent) -->  <!-- Tools Start -->    
       <div class="menu-item parent" data-target="ptools-children">
      <div class="title">
        <span>Tools</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
            <!-- Children of Tools -->
    <div id="ptools-children" class="nested">
      
      <div class="menu-item parent" data-target="additems-children">
        <div class="title"><span>Add Items</span>
        </div>
              <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
      <div id="additems-children" class="nested">
       <div class="menu-item">
          <div class="title">
            <span><a href="">Group</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="">Make</a></span>
          </div>
        </div>
      </div>
      
      <div class="menu-item">
        <div class="title"><span><a href="">Stock Update</a></span>
        </div>
      </div>

</div>   <!-- Tools End -->
     
      <div class="menu-item">
      <div class="title">
        <span><a href="">Search</a></span>
      </div>
    </div>
    
       <div class="menu-item parent" data-target="psearch-children">
      <div class="title">
        <span>Help</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
               <!-- Children of Tools -->
    <div id="psearch-children" class="nested">
      <div class="menu-item">
        <div class="title"><span>Under Construction</span>
        </div>
      </div>

</div>   <!-- Help End -->
     
    
    <div class="ribbon-wrap">
      <div class="ribbon">Purchase</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>
</div>

<!-- Claims modal -->
<div class="modal fade" id="claimslistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
   
<ol class="list-group">
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="claimReport.jsp?action=view">My Claim</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="AdvanceClaimReport.jsp">Advance Report</a></div>
    </div>
  </li>
  	<%if(Sesrole.equals("AllAdmin") || Sesrole.equals("HOD")) {%>
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="claimReport.jsp?action=check">Check Claim</a></div>
    </div>
  </li>
  	<%}%>
     <%if(Sesdepartment.equals("Accounts")){ %>
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="AccountClaimReport.jsp?action=approve">Approved Claim</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="claimReport.jsp?action=sanction">Sanction Claim</a></div>
    </div>
  </li>
  	<%}%>
</ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">Claims</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- Merge modal -->
<div class="modal fade" id="mergelistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
   
<ol class="list-group">
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="Mergeprocpect.jsp">Prospect</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="MergeCustomer.jsp">Customer</a></div>
    </div>
  </li>
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="itemmerging.jsp">Item</a></div>
    </div>
  </li>     
</ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">Merge</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- Transport modal -->
<div class="modal fade" id="transportlistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
   
<ol class="list-group">
<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>						
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="CustomerMaster.jsp">Customer Master</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="FollowupMaster.jsp">Follow-up Master</a></div>
    </div>
  </li>
<%}%>  
<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="BranchMaster.jsp">Branch Master</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="loadTypeMaster.jsp">Business/Load Type</a></div>
    </div>
  </li>
<%}%>  
<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="productMaster.jsp">Product Master</a></div>
    </div>
  </li>
<%}%> 
<%if(SalesAdmin.equalsIgnoreCase("Yes") || Sales.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){%>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="freightMaster.jsp">Freight Master</a></div>
    </div>
  </li>
<%}%>  
<%if(Admin.equalsIgnoreCase("Yes")){%>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="riskInvMaster.jsp">Risk Involved Master</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="companyReport.jsp">Company Master</a></div>
    </div>
  </li>
<%}%>  
<%if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")){%>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="OpportunityReport.jsp">Opportunity Report</a></div>
    </div>
  </li>
<%}%>   
</ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">Transport</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>


<!-- Accounts modal -->
<div class="modal fade" id="accountslistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
    <div class="container1">
     <div class="menu-container">
        <div class="menu-item parent" data-target="dataentry-children">
      <div class="title"><span>Data Entry</span></div><span style="color:#007bff;">&#x25BC;</span>
    </div>
    
      <div id="dataentry-children" class="nested">

        <div class="menu-item">
          <div class="title">
            <span><a href="vouchers.jsp">Vouchers</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="bankreco.jsp">Bank Reconciliation</a></span>
          </div>
        </div>
      
       <!-- Children of New -->
        <div class="menu-item">
          <div class="title">
            <span><a href="epayments.jsp">e-Payments</a></span>
          </div>
        </div>
   
        <div class="menu-item">
          <div class="title">
            <span><a href="paymentEntryForm.jsp">Payments Entry</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="Reconsilation.jsp">Reconsilation</a></span>
          </div>
        </div>

       	<%if(AccountAdmin.equalsIgnoreCase("Yes")){%>
    <div class="menu-item parent" data-target="netbanking-children">
        <div class="title"><span>Net Banking</span>
        </div>
              <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
           <div id="netbanking-children" class="nested">
           
           
    <div class="menu-item parent" data-target="master-children">
          <div class="title">
            <span>Master</span>
          </div>
            <span style="color:#007bff;">&#x25BC;</span>
          
        </div>
        
        <div id="master-children" class="nested">
        
          <div class="menu-item">
          <div class="title">
            <span><a href="accountReport.jsp">Account Master</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="categoryMasterReport.jsp">Category Master</a></span>
          </div>
        </div>
        </div>
        
         <div class="menu-item parent" data-target="transaction-children">
          <div class="title">
            <span>Transaction</span>
          </div>
            <span style="color:#007bff;">&#x25BC;</span>
          
        </div>
        
        <div id="transaction-children" class="nested">
        
          <div class="menu-item">
          <div class="title">
            <span><a href="netBankingEntry.jsp">Entry</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="netBankingApprove.jsp">Approve</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="netBankingCreateFile.jsp">Create File</a></span>
          </div>
        </div>
        </div>

             <div class="menu-item parent" data-target="accreports-children">
          <div class="title">
            <span>Reports</span>
          </div>
                        <span style="color:#007bff;">&#x25BC;</span>
          
        </div>
        
        <div id="accreports-children" class="nested">
        
          <div class="menu-item">
          <div class="title">
            <span><a href="accountEnteredbyReport.jsp">Account Entry</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="FileApprovedbyreport.jsp">File Approve</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="FileCreatedbyreport.jsp">File creation</a></span>
          </div>
        </div>
        </div>

      </div>
      <%} %>

           <div class="menu-item">
          <div class="title">
            <span><a href="Netbankfilestatus.jsp">NetBank File Status</a></span>
          </div>
        </div>
        <div class="menu-item">
          <div class="title">
            <span><a href="RepeatEntry.jsp">Repeat Payment</a></span>
          </div>
        </div>
        <div class="menu-item">
          <div class="title">
            <span><a href="TallyInterface.jsp">Sync.Tally Customer</a></span>
          </div>
        </div>
        <div class="menu-item">
          <div class="title">
            <span><a href="TallySupInterface.jsp">Sync.Tally Supplier</a></span>
          </div>
        </div>
   
   </div>
   
        <div class="menu-item parent" data-target="accreports-children1">
        <div class="title">
          <span>Reports</span>
        </div>
       <span style="color:#007bff;">&#x25BC;</span>
     </div>
      
      <div id="accreports-children1" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="tallycompare.jsp">Tally Comparison</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="cheques.jsp">Cheque Payments</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="allReports.jsp">Day Book</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="paymentReport.jsp">Approval Payments</a></span>
          </div>
        </div>
        
         <div class="menu-item">
          <div class="title">
            <span><a href="AllPaymentReport.jsp">All Payments</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="TallyInterface.jsp">Sync.Customer(T & E)</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="TallySupInterface.jsp">Sync.Supplier(T & E)</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="netbankreport.jsp">Net Banking</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="RepeatEntryDet.jsp">Repeat Payment</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="InvoiceDetailsReport.jsp">Invoice GST Detail</a></span>
          </div>
        </div>
   </div>
   
        <div class="menu-item parent" data-target="exporttotally-children">
        <div class="title">
          <span>Export to Tally</span>
        </div>
      <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
      <div id="exporttotally-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="tally_custmst.jsp">Customer Master</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="tally_invoice.jsp">Invoices</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="tally_GSTinvoice.jsp">GST Invoices</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="tally_receipts.jsp">Receipts</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="tally_creditnote.jsp">Credit Note</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="tally_debitnote.jsp">Debit Note</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="tally_supmst.jsp">Supplier Masters</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="tally_purchases.jsp">Purchases</a></span>
          </div>
        </div>
         <div class="menu-item">
          <div class="title">
            <span><a href="tally_payments.jsp">Payments</a></span>
          </div>
        </div>
   </div>

        <div class="menu-item parent" data-target="tallyreports-children">
        <div class="title">
          <span>Tally Reports</span>
        </div>
      <span style="color:#007bff;">&#x25BC;</span>
      </div>
      
    <!-- Children of View -->
      <div id="tallyreports-children" class="nested">
        <div class="menu-item">
          <div class="title">
            <span><a href="Tally_reports.jsp?Trial_balance">Trial Balance</a></span>
          </div>
        </div>

        <div class="menu-item">
          <div class="title">
            <span><a href="Tally_reports.jsp?Balance_sheet">Balance Sheet</a></span>
          </div>
        </div>
      
        <div class="menu-item">
          <div class="title">
            <span><a href="Tally_reports.jsp?Day_book">Day Book</a></span>
          </div>
        </div>
        
        <div class="menu-item">
          <div class="title">
            <span><a href="Tally_reports.jsp?Ratio_analysis">Ratio Analysis</a></span>
          </div>
        </div>
        <div class="menu-item">
          <div class="title">
            <span><a href="tally_banks.jsp">Bank Balances</a></span>
          </div>
        </div>
   </div> 
      

    <!-- Edit (Parent) -->  <!-- Edit Start -->
    <div class="menu-item parent" data-target="setupmaster-children">
      <div class="title">
        <span>Setup Masters</span>
      </div>
      <span style="color:#007bff;">&#x25BC;</span>
    </div>
    
     <!-- Children of Edit -->
    <div id="setupmaster-children" class="nested">
      <div class="menu-item">
        <div class="title">
          <span><a href="accountmst.jsp">Account Master</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title">
          <span><a href="groupmst.jsp">Group Master</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title">
          <span><a href="costcenter.jsp">Cost Center</a></span>
        </div>
      </div>
      <div class="menu-item">
        <div class="title">
          <span><a href="productmst.jsp">Product Master</a></span>
        </div>
      </div>

</div>   <!-- Edit End -->
    
    
    <div class="ribbon-wrap">
      <div class="ribbon">Accounts</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>
</div>


<!-- Collection -->
<div class="modal fade" id="collectionlistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
  
<ol class="list-group">
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="collection.jsp">Collection</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="PaymentReport.jsp">Payment Report</a></div>
    </div>
  </li>
   <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="deductionreport.jsp">Payment Deduction</a></div>
    </div>
  </li>
   <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="followupMarketingRep.jsp">Follow-Up Report</a></div>
    </div>
  </li>
  	<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) ){%>
   <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="TransactionReport.jsp">Transaction Report</a></div>
    </div>
  </li>
  <%} %>
</ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">Collection</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- twhr -->


<div class="modal fade" id="TwtechHRlistmodal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">

        <div class="container1">
          <ol class="list-group">

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="employeeReport.jsp">Add User</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="contractorReport.jsp">Contract Master</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="payableReport.jsp">Payroll</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="HRattendanceReport.jsp">Attendance Summary</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="Hr_companyReport.jsp">Company</a>
                </div>
              </div>
            </li>

            <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="departmentReport.jsp">Department</a>
                </div>
              </div>
            </li>
               <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="TWApply.jsp">Application Form</a>
                </div>
              </div>
            </li>
               <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="applicant_report.jsp">Applicant Report</a>
                </div>
              </div>
            </li>
               <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="Reasonreport.jsp">Attendance Reason Master</a>
                </div>
              </div>
            </li>
			     <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="leaveRequestReport_hr.jsp">Leave Report</a>
                </div>
              </div>
            </li>
             <li class="list-group-item d-flex justify-content-between align-items-start">
              <div class="ms-2 me-auto">
                <div class="fw-bold">
                  <a href="checkInOutReport.jsp">Attendance Report</a>
                </div>
              </div>
            </li>
          </ol>

          <div class="ribbon-wrap">
            <div class="ribbon">TWtech HR</div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>


<!-- Reports modal -->
<div class="modal fade" id="reportslistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body">

    <div class="container1">
   
<ol class="list-group">
	<%
   	if(session.getAttribute("CompanyMasterID").toString().equalsIgnoreCase("100039")){%>
     			
     			<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ItemMaster.jsp">Item Master</a></div>
    </div>
  </li>
     			<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="SupplierMaster.jsp">Supplier Master</a></div>
    </div>
  </li>
     			
     		<%}%>
   				
   				<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="CustomerMaster1.jsp">Customer Master</a></div>
    </div>
  </li>
   				<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="FunnelReportNew.jsp">Funnel Report</a></div>
    </div>
  </li>
<%
   if((session.getAttribute("userLevel").toString().equalsIgnoreCase("level5") && PurchaseAdmin.equalsIgnoreCase("Yes")) || session.getAttribute("userLevel").toString().equalsIgnoreCase("level6") ||(Admin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level5")) ){%>
     			<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="PendingPurchaseOrderList.jsp">Pending Order Report</a></div>
    </div>
  </li>
     		<%}%>
  	<%
		if(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes") || Purchase.equalsIgnoreCase("Yes") || PurchaseAdmin.equalsIgnoreCase("Yes")){ %>
  
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="marketingCustomerReportDateWise.jsp">Follow-Up</a></div>
    </div>
  </li>
	 <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="customer_wise_ledger.jsp">Aging</a></div>
    </div>
  </li>
	 <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="salesEnqReport.jsp?id=">Sales Enquiry</a></div>
    </div>
  </li>
	
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ledgerdetails.jsp">Ledger A/c Details</a></div>
    </div>
  </li>
  
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="marketingReport.jsp">Marketing</a></div>
    </div>
  </li>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ShowEnquiry.jsp">Sales Master</a></div>
    </div>
  </li>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="InvoiceDetailsReport.jsp">Invoice GST Detail</a></div>
    </div>
  </li>
  <%}%>
         		<% if(Collection.equalsIgnoreCase("Yes") || CollectionAdmin.equalsIgnoreCase("Yes")){%>
         		<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="customer_wise_ledger.jsp">Aging</a></div>
    </div>
  </li>
         		<%} %>
  <%if(session.getAttribute("isMarketingRepresentive")!=null){%> 
          
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="DashBoardForMarkt.jsp">Dash Board</a></div>
    </div>
  </li>

    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ProspectStatusReport.jsp">Prospects Detail</a></div>
    </div>
  </li>
<%}%>
          		<%if(Admin.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")){ %>
          			
          		<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="addNewMarketingRep.jsp?type=new">New Marketing Rep</a></div>
    </div>
  </li>

    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="Marketingeditreport.jsp">Master Marketing</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="followupMarketingRep.jsp">Customer Follow-Up</a></div>
    </div>
  </li>
<%} %>
 <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ComplaintReport.jsp">My Complaints</a></div>
    </div>
  </li>
<% if((session.getAttribute("CompanyType").toString().equalsIgnoreCase("FleetView")) && 
               				(Sales.equalsIgnoreCase("Yes") || SalesAdmin.equalsIgnoreCase("Yes")) )
					{%>
               		 <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="TransactionReport.jsp">Transaction Report</a></div>
    </div>
  </li> 
               		<%}
               		else
               		{
               		%>
               		
               		<%} %>

         <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ASCInvoiceDetails.jsp">ASC Invoice Details</a></div>
    </div>
  </li> 
        
            <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="contractdetails.jsp">Contract Report</a></div>
    </div>
  </li> 
      			      					    	
       <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="MonthBillReport.jsp">Invoice Monthly Report</a></div>
    </div>
  </li> 
      
          <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="customerwiseledger.jsp">Ledger Summary Report</a></div>
    </div>
  </li>       			     

      </ol>
      
    <div class="ribbon-wrap">
      <div class="ribbon">Reports</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- Tools modal -->
<div class="modal fade" id="toolsmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
    <div class="container1">
<ol class="list-group">
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="ChangePassword.jsp">Change Password</a></div>
    </div>
  </li>
</ol>
    <div class="ribbon-wrap">
      <div class="ribbon">Tools</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- Admin modal -->
<div class="modal fade" id="adminlistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
    <div class="container1">
<ol class="list-group">
  <%if(Admin.equalsIgnoreCase("Yes")){%>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="AdminModule.jsp">User Master</a></div>
    </div>
  </li>
<%}if((SuperAdmin.equalsIgnoreCase("Yes") && session.getAttribute("userLevel").toString().equalsIgnoreCase("level6"))){ %>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="AdminModuleMaster.jsp">Company Master</a></div>
    </div>
  </li>
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="createComp.jsp">Add New Company</a></div>
    </div>
  </li>
    <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="UserAccessControl.jsp">Role Management</a></div>
    </div>
  </li>
  <%} %>
</ol>
    <div class="ribbon-wrap">
      <div class="ribbon">Admin</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>

<!-- Leave modal -->
<div class="modal fade" id="leavelistmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
    <div class="container1">
<ol class="list-group">
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="leaveapplication.jsp">Leave Apply</a></div>
    </div>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold"><a href="leaveRequestReport.jsp"> Leave Report</a></div>
    </div>
  </li>
</ol>
    <div class="ribbon-wrap">
      <div class="ribbon">Leave</div>
    </div>
  </div>
</div> 
</div>
</div>
</div>


 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>

<script>
function toggleSubMenu(element) {
    const subMenuId = element.getAttribute('data-target'); // Get the target sub-menu ID
    const subMenu = document.getElementById(subMenuId); // Get the sub-menu by ID
    const isExpanded = element.getAttribute('aria-expanded') === 'true';
    
    // Toggle the display of the sub-menu
    subMenu.style.display = isExpanded ? 'none' : 'block';
    element.setAttribute('aria-expanded', !isExpanded);
    element.innerHTML = isExpanded ? '&#x25BC;' : '&#x25B2;'; // Change icon based on state
}
</script>

<script>
$(document).ready(function(){

	  // Function to enable/disable buttons
	  function updateButtons(status){
	      if(status === "In"){
	          // User already checked in → disable check in, enable check out
	          $("#checkInCard").css({"pointer-events":"none","opacity":"0.5"});
	          $("#checkOutCard").css({"pointer-events":"auto","opacity":"1"});
	      } else if(status === "Out"){
	          // User already checked out → disable check out, enable check in
	          $("#checkOutCard").css({"pointer-events":"none","opacity":"0.5"});
	          $("#checkInCard").css({"pointer-events":"auto","opacity":"1"});
	      }
	  }

	  // 🔹 Load current status on page load
	  $.ajax({
	      url: "checkInOut.jsp",
	      type: "POST",
	      data: { action: "status" },
	      success: function(response){
	          updateButtons(response.trim());
	      }
	  });

	  // 🔹 When user clicks CHECK IN
	  $("#checkInCard").click(function(){
	    $.ajax({
	      url: "checkInOut.jsp",
	      type: "POST",
	      data: { action: "checkin" },
	      success: function(response){
	        alert("Check-in successful!");
	        updateButtons("In");   // Immediately disable Check-In
	      }
	    });
	  });

	  // 🔹 When user clicks CHECK OUT
	  $("#checkOutCard").click(function(){
	    $.ajax({
	      url: "checkInOut.jsp",
	      type: "POST",
	      data: { action: "checkout" },
	      success: function(response){
	        alert("Check-out successful!");
	        updateButtons("Out");  // Disable Check-Out, Enable Check-In
	      }
	    });
	  });

	});
</script>

<script>
  // Toggle nested children on parent click
  document.querySelectorAll('.menu-item.parent').forEach(parent => {
    parent.addEventListener('click', () => {
      const targetId = parent.getAttribute('data-target');
      const targetDiv = document.getElementById(targetId);
      if (targetDiv) {
        targetDiv.classList.toggle('open');
      }
    });
  });
</script>

 <%@ include file="footer.jsp" %>
</body>
</html>