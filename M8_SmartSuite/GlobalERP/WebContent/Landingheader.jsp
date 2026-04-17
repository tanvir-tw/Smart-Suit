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
    <link rel="icon" type="imagenew/x-icon" href="images/erp.png">
    
    <!-- Internal CSS -->
    <link rel="stylesheet" href="cssnew/header.css" />
    
    <!-- Unicons CSS -->
    <link rel="stylesheet" href="cssnew/unicons.css" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
     
    <!-- Bootstrap CDN --> 
   <link href="cssnew/bootstrap/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
   <script src="jsnew/bootstrap/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  
      <style>
   nav {
    width: 100%;
    padding: 4px 14px;
    display: flex;
    justify-content: space-between;  
    align-items: center;           
    background-color: #1582AB;
    color: #fff;
    border-radius: 5px;           
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.nav-left,
.nav-right {
    display: flex;
    align-items: center;
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
    <!-- Logo -->
    <div class="nav-left d-flex align-items-center">
        <a href="#" class="logo ms-3">
            <img src="imagesnew/SSlogo.png" alt="logoImg" height="40" width="150" style="border-radius: 5px;">
        </a>  
        <!-- Report No. -->
        <span class="badge rounded-pill bg-light text-dark shadow-sm ms-3" style="font-family: Montserrat, sans-serif; font-size: 14px;">
            <strong>Report No.:</strong> <%=reportno%>
        </span>
    </div>

    <!-- Right section -->
    <div class="nav-right d-flex align-items-center">
        <!-- Log Complaint -->
        <a href="#" onclick="openpopup('<%=PageName%>')" class="ms-3" style="color: lime; text-decoration: none;">
            Log Complaint
        </a>

        <!-- Profile -->
        <div class="profile-details ms-3">
            <div class="profile-content">
                    <img src="imagesnew/User.png" alt="profileImg" class="profile-img">
            </div>
            <div class="name-job">
              <a href="logout.jsp" data-toggle="tooltip" title="Logout">
                <div class="profile_name" style="color:white;"><%=session.getAttribute("EmpName")%></div>
                </a>
            </div>
            <a href="logout.jsp" title="Logout" class="logout-icon ms-2">
                <i class="bx bx-power-off"></i>
            </a>
        </div>
    </div>
</nav>
<script src="jsnew/script.js" defer></script>
<script>
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