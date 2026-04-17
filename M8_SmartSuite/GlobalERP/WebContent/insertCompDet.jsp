<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.ConnectionClass"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
Connection con = null;
Statement st4=null, st1=null, st2=null, st3=null;

try {
 ConnectionClass connection = new ConnectionClass();
	 con = connection.getConnect("db_leaveapplication");
	System.out.println("con :::::::::::::::::: " + con);

    st4= con.createStatement();
    st1 = con.createStatement();
    st2 = con.createStatement();
    st3 = con.createStatement(); 


} catch (Exception e) {
    e.printStackTrace();
}
 
 System.out.println("\n********===== insertCompDet.jsp ====*********");
 
 
 String  action="",companyName="",empName="",compGdAdd="",compAdd="",compCst="",compBst="",phno="",faxno="",
		 email="",website="",panno="",date="",sendMsg="",sessionUserName="";
 int compCode=0;
 
 String Sysdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
 
 action=request.getParameter("action");
 System.out.println("\nAction ===============>: "+action);
 
 int twEmp = Integer.parseInt(session.getAttribute("leaveempID").toString());
 
 System.out.println("\nSession User ID ===========> "+twEmp);

 
 if(action.contains("Company"))
 {
 companyName=request.getParameter("compName");
/*  empName=session.getAttribute("empname").toString(); */
  empName=session.getAttribute("leaveempname").toString();
 compGdAdd=request.getParameter("compGdAdd");
 compAdd=request.getParameter("compAdd");
 compBst=request.getParameter("compBstno");
 compCst=request.getParameter("compCstno");
 phno=request.getParameter("phNo");
 faxno=request.getParameter("faxNo");
 email=request.getParameter("email");
 website=request.getParameter("website");
 panno=request.getParameter("pNo");
 

 try
 {  
	 String sql1="select * from t_ourcompanydet where OurCompanyName='"+companyName+"'";
	 ResultSet rs1=st1.executeQuery(sql1);
	 if(rs1.next()){
		 sendMsg="Company already exist";
		 response.sendRedirect("createComp.jsp?sendMsg="+sendMsg);
	 	
	 }else{
	 
	 String sqlcompcode="select max(CompanyCode) as CompanyCode from t_ourcompanydet";
    ResultSet rs=st1.executeQuery(sqlcompcode);
	while(rs.next())
	{
		compCode=rs.getInt("CompanyCode")+1;
	
     System.out.println("--------compCode--------->>"+compCode);
	}
	
	 String sqlInsert="INSERT INTO t_ourcompanydet (CompanyCode ,OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+compCode+"', '"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 System.out.println("\nSqlinsert" +sqlInsert);
	st4.executeUpdate(sqlInsert);
	 System.out.println("\n******** Data Inserted ********");
	 
	 String sqlInserthistory="INSERT INTO t_companyhistory (CompanyCode ,OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+compCode+"', '"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 System.out.println("\nsqlInserthistory" +sqlInserthistory);
	 st1.executeUpdate(sqlInserthistory);
	
	 sendMsg="Company Added successfully";
	 response.sendRedirect("alertGoTo.jsp?msg="+sendMsg+"&goto=Hr_companyReport.jsp");

 }}
catch(Exception e)
{System.out.println("****** Exception ******* "+e);
} 
} 

 
//************************ code for insert designation ******************
String desgName="",underDept="",compCodefordes="",status="";
int deptCode=0;

compCodefordes=request.getParameter("cmpName");
desgName=request.getParameter("desgName");
underDept=request.getParameter("underDept");
status=request.getParameter("status");
if(action.contains("Designation"))
{  
	
	System.out.println("\n****** inside designation ******* ");
	 
	 
     String sqlcompcode="select OurCompanyName from t_ourcompanydet where CompanyCode="+compCodefordes+"";
     ResultSet rs=st1.executeQuery(sqlcompcode);
     	while(rs.next())
  		{
  			companyName=rs.getString("OurCompanyName");
  		
  	 //System.out.println("--------company name--------->>"+companyName);
  		}
  	
    String sqlGet="select max(desgId) as desgId from t_designation where CompanyCode="+compCodefordes+"";
 	ResultSet rsGet=st2.executeQuery(sqlGet);
 	while(rsGet.next())
 	{
 		deptCode=rsGet.getInt("desgId")+1;
 	}
 	//System.out.println("--------dest code--------->>"+deptCode);
 	
 	
     String SqlinsertDes="INSERT INTO t_designation(designation ,desgId,TWEmpID,UpdateDatetime,CompanyCode,Status) VALUES ('"+desgName+"', '"+deptCode+"', '"+twEmp+"', '"+Sysdate+"', '"+compCodefordes+"', 'Active')";
     System.out.println("\nSqlinsertDes----->"+SqlinsertDes);
     st3.executeUpdate(SqlinsertDes);
     System.out.println("========== Designation inserted ========");
     sendMsg="Designation created successfully";
	 response.sendRedirect("designationCreation.jsp?sendMsg="+sendMsg);
     
}
//***********************END OF CODE *************************************

//***********************Code for Edit Designation************************
if(action.contains("editDesignation"))
{  String deptName=request.getParameter("deptName");
  

	System.out.println("\n****** inside Edit designation ******* ");
	String sqledit="update t_designation set designation='"+deptName+"', Status='"+status+"' where CompanyCode="+compCodefordes+" and designation="+underDept+"";
	System.out.println(sqledit);
	st1.executeUpdate(sqledit);
	System.out.println("========== Designation Updated========");
    sendMsg="Designation Edit successfully";
    response.sendRedirect("editDesignation.jsp?sendMsg="+sendMsg);
    
	 
}

//***********************End of Code**********************************
 %>