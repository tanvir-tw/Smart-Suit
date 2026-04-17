<%@page import="com.lowagie.text.Document"%>
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

</head>

<script >
function Redirect()
{
	alert("Contractor Id Already Exist !!! ");
    window.location="ContractEntryForm.jsp";
	
}


</script>
 <body>
<%! 
Connection con ;
%>
<%
String sqlInsert="";
String sqlInsertHistroy="";
try{

	

	String EmpNm=session.getAttribute("EmpName").toString().trim();

 String cmpname="",id="" ;
 String name="",prnsemail="",tempadd1="",tempadd2="",Tempcity="",tempzip="",tempcon="",tempstate="",permadd1="",permadd2="",permcity="",permzip="",permcon="";
 String permstate="",phn="",dob="",married="",unmarried="",immname="",immphn="",rel="";
 String pan="", aadhar="",driving="",passport="";
 String bnkname="",accno="",ifsc="",accname="",branch="";
 String medicmp="",policyno="",policyStart="",policyEnd="";
 String edu="",strm="";
 String  EntryBy="";                  
 String  EntryDate="";
 String Marrital="";
 String addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
 Integer defualtval=1;
	String CustCategory="";
	String Company="";
	
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement st1=con.createStatement();
	Statement st2=con.createStatement();
	Statement st3=con.createStatement();
	Statement st4=con.createStatement();
	Statement st5=con.createStatement();
			
	System.out.println("After con.createStatement()");


cmpname=request.getParameter("comp_name");
name=request.getParameter("cont_name");
id=request.getParameter("cont_id");



prnsemail=request.getParameter("personal_email");
System.out.println("prnsemail--------==========="+prnsemail);
tempadd1=request.getParameter("Temporary_addr1");
System.out.println("tempadd1--------==========="+tempadd1);
tempadd2=request.getParameter("Temporary_addr2");
System.out.println("tempadd2--------==========="+tempadd2);
Tempcity=request.getParameter("Temporary_city");
System.out.println("Tempcity--------==========="+Tempcity);
tempzip=request.getParameter("Temporary_zip");
System.out.println("tempzip--------==========="+tempzip);
tempcon=request.getParameter("Temporarycountry");
System.out.println("tempcon--------==========="+tempcon);
tempstate=request.getParameter("Temporarystate");
System.out.println("tempstate--------==========="+tempstate);

permadd1=request.getParameter("permanant_addr1");
permadd2=request.getParameter("permanant_addr2");
permcity=request.getParameter("permanant_city");
permzip=request.getParameter("permanant_zip");
permcon=request.getParameter("permanantcountry");
  permstate=request.getParameter("permanantstate");
phn=request.getParameter("phn_no");
dob=request.getParameter("dob");
Marrital=request.getParameter("Marrital");
//unmarried=request.getParameter("marital_married");
immname=request.getParameter("name");
immphn=request.getParameter("imm_phnno");
rel=request.getParameter("relation");
  pan=request.getParameter("pancard");
 aadhar=request.getParameter("aadhar_no");
driving=request.getParameter("driving_no");
passport=request.getParameter("passport_no");
  bnkname=request.getParameter("bank_name");
accno=request.getParameter("acc_no");
ifsc=request.getParameter("ifsc");
accname=request.getParameter("acc_holdername");
branch=request.getParameter("branch");
medicmp=request.getParameter("medi_comp");
policyno=request.getParameter("policy_no");
policyStart=request.getParameter("policy_start");
policyEnd=request.getParameter("policy_end");
  edu=request.getParameter("education");
strm=request.getParameter("stream");
 
EntryBy=EmpNm;                  
EntryDate=addedOn;

  

		System.out.println("Company Name "+cmpname);
		System.out.println("Name "+name);
		System.out.println("ID "+id);
		System.out.println("Personal Email "+prnsemail);
		System.out.println("Street Address "+tempadd1);
		System.out.println("Address line 2 "+tempadd2);
		System.out.println("City "+Tempcity);
		System.out.println("ZIP CODE "+tempzip);
		System.out.println("Country "+tempcon);
		System.out.println("State "+tempstate);
		System.out.println("Street Address "+permadd1);
		System.out.println("Address line 2 "+permadd2);
		System.out.println("City "+permcity);
		System.out.println("Postal code "+permzip);
		System.out.println("Country "+permcon);
		System.out.println("State "+permstate);
		System.out.println("Phone Number "+phn);
		System.out.println("Date of Birth "+dob);
		System.out.println("Marrital "+Marrital);
		//System.out.println("Unmarried "+unmarried);
		System.out.println("Immediate Name "+immname);
		System.out.println("Immediate Phone No "+immphn);
		System.out.println("Relation "+rel);
		System.out.println("Pan card "+pan);
		System.out.println("Aadhar card "+aadhar);
		System.out.println("Driving "+driving);
		System.out.println("Passport "+passport);
		System.out.println("Bank Name "+bnkname);
		System.out.println("Account Number "+accno);
		System.out.println("Account Holder Name "+accname);
		System.out.println("IFSC "+ifsc);
		System.out.println("Branch "+branch);
		System.out.println("Mediclaim Company Name "+medicmp);
		System.out.println("Policy Number "+policyno);
		System.out.println("Policy Start Date "+policyStart);
		System.out.println("Policy End Date "+policyEnd);
		System.out.println("Education "+edu);
		System.out.println("Stream "+strm);

		String TempAddr=""+tempadd1+","+tempadd2+","+Tempcity+","+tempzip+","+tempcon+","+tempstate;
		System.out.println("TempAddr "+TempAddr);
		 String PermAddr=permadd1+","+permadd2+","+permcity+","+permzip+","+permcon+","+permstate;
		 System.out.println("PermAddr "+PermAddr);
	     
		 if(pan== " " || pan==null )
		 {
			 pan=" - ";
			 
		 }
		 if(aadhar== " " || aadhar==null) 
		 {
			 aadhar=" - ";
			 
		 }
		 if(driving== " " || driving==null )
		 {
			 driving=" - " ;
			 
		 }
		 if(passport== " " || passport==null)
		 {
			 passport= " - ";
		 }
		 if(medicmp== " " || medicmp==null)
		 {
			 medicmp= " - ";
		 }
		 if(policyno== " " || policyno==null)
		 {
			 policyno= " - ";
		 }
		 if(strm== " " || strm==null)
		 {
			 strm= " - ";
		 }
		 
							
					
		 String dt1 ="",dt2="";
		 Statement stsms=con.createStatement();
	        Statement stsms1=con.createStatement();

	        if(policyStart.equals("-")|| policyStart==null || policyStart.equals(" ") || policyStart.equals("") )
	        {
	        	dt1="-";
	        }
	        else{
	         dt1 = new SimpleDateFormat("yyyy-MM-dd")
	        .format(new SimpleDateFormat("dd-MMM-yyyy")
	                .parse(policyStart));
	        }
	        if(policyEnd.equals("-") || policyEnd==null || policyEnd.equals(" ") || policyEnd.equals("") )
	        {
	        	dt2="-";
	        }
	        else{
	        dt2 = new SimpleDateFormat("yyyy-MM-dd")
	        .format(new SimpleDateFormat("dd-MMM-yyyy")
	                .parse(policyEnd));

	        }
	        
	        
	        String Check="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where ContractorId='"+id+"'";
	        ResultSet rsCheck=st4.executeQuery(Check);
	        if(rsCheck.next())
	        {
	        	out.println("<script>  Redirect();</script>");	
	        }
	        else{
	        sqlInsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew (CompanyName,ContractorId,ContractorName,PermanentAddress,TemporaryAddress,MobNo,Email,ImmediateContactName,ImmediateContactRelation,ImmediateContactNumber,DateOfBirt,MaritalStatus,PanCard,AadharCard,DrivingLicense,Passport,BankName,BankAccountNumber,BankAccountHolder,BankIFSCCode,BankBranchName,MediclaimPolicyNo,MediclaimCompanyName,MediclaimStartDate,MediclaimEndDate,Education,Stream,EntryBy,EntryDate) values ('"+cmpname+"','"+id+"','"+name+"','"+PermAddr+"','"+TempAddr+"','"+phn+"','"+prnsemail+"','"+immname+"','"+rel+"','"+immphn+"','"+dob+"','"+Marrital+"','"+pan+"','"+aadhar+"','"+driving+"','"+passport+"','"+bnkname+"','"+accno+"','"+accname+"','"+ifsc+"','"+branch+"','"+policyno+"','"+medicmp+"','"+dt1+"','"+dt2+"','"+edu+"','"+strm+"','"+EntryBy+"','"+EntryDate+"')";
	        System.out.println("Insert "+sqlInsert);

	        int sqlst=0;

	        sqlst= stsms.executeUpdate(sqlInsert);




	         String sqlInsertHistory ="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNewHistory (CompanyName,ContractorId,ContractorName,PermanentAddress,TemporaryAddress,MobNo,Email,ImmediateContactName,ImmediateContactRelation,ImmediateContactNumber,DateOfBirt,MaritalStatus,PanCard,AadharCard,DrivingLicense,Passport,BankName,BankAccountNumber,BankAccountHolder,BankIFSCCode,BankBranchName,MediclaimPolicyNo,MediclaimCompanyName,MediclaimStartDate,MediclaimEndDate,Education,Stream,EntryBy,EntryDate) values ('"+cmpname+"','"+id+"','"+name+"','"+PermAddr+"','"+TempAddr+"','"+phn+"','"+prnsemail+"','"+immname+"','"+rel+"','"+immphn+"','"+dob+"','"+Marrital+"','"+pan+"','"+aadhar+"','"+driving+"','"+passport+"','"+bnkname+"','"+accno+"','"+accname+"','"+ifsc+"','"+branch+"','"+policyno+"','"+medicmp+"','"+dt1+"','"+dt2+"','"+edu+"','"+strm+"','"+EntryBy+"','"+EntryDate+"')";
	         System.out.println("Insert Histroy :- "+sqlInsertHistory);
	         int sqlst1=0;

	            sqlst1= stsms1.executeUpdate(sqlInsertHistory);



	        String msg = "";

	        if(sqlst>=1)
	        {
	            out.println("<script type=\"text/javascript\">");
	            out.println("alert('Added Successfully','','success');");

	           // swal("Good job!", "You clicked the button!", "success");
	            out.println("location='ContractMasterReport.jsp';");
	            out.println("</script>");
	         System.out.println("Details Added");
	        }else
	        {
	            out.println("<script type=\"text/javascript\">");
	               out.println("swal('Error Occurred ','','success');");

	              // swal("Good job!", "You clicked the button!", "success");
	               out.println("location='ContractEntryForm.jsp';");
	               out.println("</script>");
	            System.out.println("Error Occurred");
	        }

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
