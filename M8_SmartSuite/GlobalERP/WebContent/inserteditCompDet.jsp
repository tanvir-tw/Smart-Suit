<%@page import="java.util.Date"%>
<%@include file="conn.jsp" %>
 <% System.out.println("\n********===== insertCompDet.jsp ====*********");
 
 
 Class.forName(DB_Driver);
	Connection conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
 Statement st=conn.createStatement();
 Statement st1=conn.createStatement();
 Statement st2=conn.createStatement();
 Statement st3=conn.createStatement();
 
 String  action="",companyName="",empName="",compGdAdd="",compAdd="",compCst="",compBst="",phno="",faxno="",
		 email="",website="",panno="",date="",sendMsg="",sessionUserName="";
 int compCode=0;
 
 String Sysdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
 
 action=request.getParameter("action");
 System.out.println("\nAction ===============>: "+action);

 int twEmp=Integer.parseInt(session.getAttribute("EmpCode").toString());
 System.out.println("\nSession User ID ===========> "+twEmp);
 if(action.contains("Company"))
 {
	 
	 System.out.println("Inside Company===>");
 companyName=request.getParameter("compName");
 empName=session.getAttribute("EmpName").toString();
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
	 String sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet where OurCompanyName='"+companyName+"'";
	 ResultSet rs1=st1.executeQuery(sql1);
	 if(rs1.next()){
		 sendMsg="Company already exist";
		 response.sendRedirect("createComp.jsp?sendMsg="+sendMsg);
	 	
	 }else{
	 
	 String sqlcompcode="select max(OurCompanyCode) as OurCompanyCode from "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet";
    ResultSet rs=st1.executeQuery(sqlcompcode);
	while(rs.next())
	{
		compCode=rs.getInt("OurCompanyCode")+1;
	
     System.out.println("--------compCode--------->>"+compCode);
	}
	
	 //String sqlInsert="INSERT INTO t_ourcompanydet (CompanyCode ,OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+compCode+"', '"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet (OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 System.out.println("\nSqlinsert" +sqlInsert);
	 st.executeUpdate(sqlInsert);
	 System.out.println("\n******** Data Inserted ********");
	 
	// String sqlInserthistory="INSERT INTO t_companyhistory (CompanyCode ,OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+compCode+"', '"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 //System.out.println("\nsqlInserthistory" +sqlInserthistory);
	 //st1.executeUpdate(sqlInserthistory);
	
	 sendMsg="Company Added successfully";
	 response.sendRedirect("alertGoTo.jsp?msg="+sendMsg+"&goto=companyReport.jsp");

 }}
catch(Exception e)
{System.out.println("****** Exception ******* "+e);
} 
} 

 
//************************ code for insert designation ******************
if(action.contains("Update"))
 {
	String compCodeNew="";
	 System.out.println("Inside Company===>");
 companyName=request.getParameter("compName");
 
 compCodeNew=request.getParameter("compCode");
 empName=session.getAttribute("EmpName").toString();
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
	// String sql1="select * from t_ourcompanydet where OurCompanyName='"+companyName+"'";
	// ResultSet rs1=st1.executeQuery(sql1);
	 

	 /*	 if(rs1.next()){
		 sendMsg="Company already exist";
		 response.sendRedirect("createComp.jsp?sendMsg="+sendMsg);
	 	
	 }else{
	 
	 String sqlcompcode="select max(OurCompanyCode) as OurCompanyCode from t_ourcompanydet";
    ResultSet rs=st1.executeQuery(sqlcompcode);
	while(rs.next())
	{
		compCode=rs.getInt("OurCompanyCode")+1;
	
     System.out.println("--------compCode--------->>"+compCode);
	}
	*/
	 //String sqlInsert="INSERT INTO t_ourcompanydet (CompanyCode ,OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+compCode+"', '"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 String sqlupdate="update "+session.getAttribute("CompanyMasterID").toString()+"ourcompanydet SET OurCompanyDet='"+companyName+"',OurCompanyName='"+companyName+"',TWEmpName='"+empName+"',OurCompanyGodownAddress='"+compGdAdd+"',OurCompanyAddress='"+compAdd+"',OurCompanyBSTNo='"+compBst+"',OurCompanyCSTNo='"+compCst+"',PhoneNo='"+phno+"',FaxNo='"+faxno+"',Email='"+email+"',Puremail='"+email+"',Website='"+website+"',PanNo='"+panno+"' where OurCompanyCode='"+compCodeNew+"' ";
	 System.out.println("\nSqlinsert" +sqlupdate);
	 st.executeUpdate(sqlupdate);
	 System.out.println("\n******** Data Updated ********");
	 
	// String sqlInserthistory="INSERT INTO t_companyhistory (CompanyCode ,OurCompanyDet,OurCompanyName,TWEmpName,OurCompanyCode,OurCompanyGodownAddress,OurCompanyAddress,OurCompanyBSTNo,OurCompanyCSTNo,PhoneNo,FaxNo,Email,Puremail,Website,PanNo) VALUES ('"+compCode+"', '"+companyName+"', '"+companyName+"', '"+empName+"', '"+compCode+"', '"+compGdAdd+"', '"+compAdd+"', '"+compBst+"', '"+compCst+"', '"+phno+"', '"+faxno+"', '"+email+"', '"+email+"', '"+website+"', '"+panno+"')";
	 //System.out.println("\nsqlInserthistory" +sqlInserthistory);
	 //st1.executeUpdate(sqlInserthistory);
	
	 sendMsg="Company Updated successfully";
	 response.sendRedirect("alertGoTo.jsp?msg="+sendMsg+"&goto=companyReport.jsp");

 //}
	 }
catch(Exception e)
{System.out.println("****** Exception ******* "+e);
} 
} 
//***********************END OF CODE *************************************

//***********************Code for Edit Designation************************


//***********************End of Code**********************************
 %>