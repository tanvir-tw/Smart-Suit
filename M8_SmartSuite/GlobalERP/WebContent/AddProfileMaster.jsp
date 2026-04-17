<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Contract Profile Master</title>
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">  

<body onkeypress="hideList(event);" onclick="hideOnClick();">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
 function Redirect()
 {
	 var a=document.getElementById("avail").value;
	 /* alert(" a :- "+a); */
	 alert("Already Exist With Availability  "+a+" ");
	 var b=document.getElementById("contid").value;
	 var c=document.getElementById("contname").value;
	 
	 window.location="ContractProfileForm.jsp?Id="+b+"&Name="+c+"";
 }
 
</script>
</head>
 <body>
<%! 
Connection con ;
%>
<%
String sqlInsert="";
try{

	
String EmpNm=session.getAttribute("EmpName").toString().trim();

String  ContractorId="";             
String  Department="";               
String  ContractorOfficialNumber=""; 
String  ContractorOfficialEmail="";  
String  ContractStartDate="";        
String  ContractEndDate="";          
String  ContractorWeekOff="";        
String  EntryBy="";                  
String  EntryDate="";
String  Designation="";
String ContractorName="";
String PermanentAddress="";


		
        String addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		
		Integer defualtval=1;
		String CustCategory="";
		String Company="";
		int maxid=0,maxid1=0;String available="";
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st1=con.createStatement();
		Statement st2=con.createStatement();
		Statement st3=con.createStatement();
		Statement st4=con.createStatement();
		Statement st5=con.createStatement();
		Statement st6=con.createStatement();
		Statement st8=con.createStatement();
		Statement st12=con.createStatement();	
		Statement st14=con.createStatement();
		Statement st18=con.createStatement();
		Statement st20=con.createStatement();
		System.out.println("After con.createStatement()");
		ContractorName=request.getParameter("Name");
		  ContractorId=request.getParameter("cont_id");             
		  Department=request.getParameter("dept");  
		  Designation=request.getParameter("designation");
		  ContractorOfficialNumber=request.getParameter("official_no"); 
		  ContractorOfficialEmail=request.getParameter("official_email");  
		  ContractStartDate=request.getParameter("cont_startdate");        
		  ContractEndDate=request.getParameter("cont_end");          
		  ContractorWeekOff=request.getParameter("weekoff");        
		  EntryBy=EmpNm;                  
		  EntryDate=addedOn;
		
		  System.out.println("ContractorName :- "+ContractorName);
		  
		  System.out.println("ContractorId :- "+ContractorId);
		  System.out.println("Department :- "+Department);
		  System.out.println("Designation :- "+Designation);
		  System.out.println("ContractorOfficialNumber :- "+ContractorOfficialNumber);
		  System.out.println("ContractorOfficialEmail :- "+ContractorOfficialEmail);
		  System.out.println("ContractStartDate :- "+ContractStartDate);
		  System.out.println("ContractEndDate :- "+ContractEndDate);
		  System.out.println("ContractorWeekOff :- "+ContractorWeekOff);
		  System.out.println("EntryBy :- "+EntryBy);
		  System.out.println("EntryDate :- "+EntryDate);
		  
		  String dt1 = new SimpleDateFormat("yyyy-MM-dd")
	        .format(new SimpleDateFormat("dd-MMM-yyyy")
	                .parse(ContractStartDate));
		  
		  String dt2 = new SimpleDateFormat("yyyy-MM-dd")
	        .format(new SimpleDateFormat("dd-MMM-yyyy")
	                .parse(ContractEndDate));
		  
		  Statement stsms=con.createStatement();
		  int sqlst=0;
			
			
			Statement stsms1=con.createStatement();
			
						
		sqlInsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMaster(ContractorId,Department,Designation,ContractorOfficialNumber,ContractorOfficialEmail,ContractStartDate,ContractEndDate,ContractorWeekOff,EntryBy,EntryDate) values ('"+ContractorId+"','"+Department+"','"+Designation+"','"+ContractorOfficialNumber+"','"+ContractorOfficialEmail+"','"+dt1+"','"+dt2+"','"+ContractorWeekOff+"','"+EntryBy+"','"+EntryDate+"')";
		
	sqlst= stsms.executeUpdate(sqlInsert);
		
		
		System.out.println("Insert Master Data  :- "+sqlInsert);
		
		
		String sqlInsertHistory="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractorProfileMasterHistory(ContractorId,Department,Designation,ContractorOfficialNumber,ContractorOfficialEmail,ContractStartDate,ContractEndDate,ContractorWeekOff,EntryBy,EntryDate) values ('"+ContractorId+"','"+Department+"','"+Designation+"','"+ContractorOfficialNumber+"','"+ContractorOfficialEmail+"','"+dt1+"','"+dt2+"','"+ContractorWeekOff+"','"+EntryBy+"','"+EntryDate+"')";
		
		System.out.println("Insert History Data  :- "+sqlInsertHistory);

	
		sqlst= stsms1.executeUpdate(sqlInsertHistory);
		
		if(Designation.equals("Technician")){
			String sql12="select max(TID) as maxid from db_CustomerComplaints.t_techlist";
		ResultSet	rs4=st6.executeQuery(sql12);
			if(rs4.next())
			{
				maxid=rs4.getInt("maxid");
			}
				maxid=maxid+1;
				
		String	sql3="select max(ID) as maxid1 from db_CustomerComplaints.t_admin";
		ResultSet	rs10=st8.executeQuery(sql3);
			if(rs10.next())
			{
				maxid1=rs10.getInt("maxid1");
			}
				maxid1=maxid1+1;
				
			//String sqltech="select TechName,Available from db_CustomerComplaints.t_techlist where TechName='"+ContractorName+"' or techuname='"+ContractorName+"'";	
			//ResultSet rsuser=st12.executeQuery(sqltech);
		//	if(rsuser.next())
		//	{    available=rsuser.getString("Available");
			       

			 %>
			 <input type="hidden" name="avail" id="avail" value=<%=available %> / >
			  <input type="hidden" name="contid" id= "contid" value=<%=ContractorId %> / >
			   <input type="hidden" name="contname" id="contname" value=<%=ContractorName %> / >
			 <%    
			 //	out.println("<script> Redirect() </script>");
			    
			    
				//response.sendRedirect("addtechnician.jsp?inserted=Already Exist");
		//	}
		//	else
		//	{
				
				sqlInsert="select PermanentAddress from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+ContractorId+"'";
	 	        System.out.println("Permanent Address is::::::::: "+sqlInsert);
	     ResultSet rsuser2=st20.executeQuery(sqlInsert);
				 if(rsuser2.next())
				{    
					PermanentAddress
			=rsuser2.getString("PermanentAddress");
				} 
     
			String sql18="insert into db_CustomerComplaints.t_techlist (TID,TechName,techuname,pass,Available,Location,MobNo,EmailId,ContractorId) values ('"+maxid+"','"+ContractorName+"', '"+ContractorName+"', 'transworld', 'Yes', '"+PermanentAddress+"','"+ContractorOfficialNumber+"','"+ContractorOfficialEmail+"','"+ContractorId+"')";
			System.out.println("==========Query for techlist============="+sql18);
		   st14.executeUpdate(sql18);
			String sql20="insert into db_CustomerComplaints.t_admin (id,Name,UName,pass,URole,UserType) values ('"+maxid1+"','"+ContractorName+"', '"+ContractorName+"', 'transworld', 'tech', 'tech') ";
			System.out.println("=============Query for admin=================="+sql20);
	st18.executeUpdate(sql20);
			}
			
	//	}
			
	
	String msg = "";		
	if(sqlst>=1)
	{	
    	out.println("<script type=\"text/javascript\">");
 	   out.println("alert('Added Successfully','','success');");
 	   
 	  // swal("Good job!", "You clicked the button!", "success");
 	   out.println("location='ContractMasterReport.jsp';");
 	   out.println("</script>");
	}else
	{
		out.println("<script type=\"text/javascript\">");
		   out.println("swal('Error Occurred  ','','success');");
		   
		  // swal("Good job!", "You clicked the button!", "success");
		   out.println("location='ContractMasterReport.jsp';");
		   out.println("</script>");
		System.out.println("Error Occurred");
	}

    
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("End second last");
			
		}




%>

</body>
</html>
</jsp:useBean>