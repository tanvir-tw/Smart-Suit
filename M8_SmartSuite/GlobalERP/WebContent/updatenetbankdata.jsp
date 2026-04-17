<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st4=null;
//String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String deductiondesc="0",deductionPer="0";
String category="";
%>
<%
boolean isInvoiceSelected=false;
try{

	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();

	String Empname=session.getAttribute("EmpName").toString();
	String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String name=request.getParameter("supplier");
	String accountno=request.getParameter("accountno");
	String ifccode=request.getParameter("ifccode");
	String bankname=request.getParameter("bankname");
	String branchname=request.getParameter("branchname");
	String email=request.getParameter("email");
	String status=request.getParameter("status");
	String id=request.getParameter("ID");
	String limit=request.getParameter("limit");
	//String category=request.getParameter("category");
	String temp[]= request.getParameter("category").split(",");
	   category=temp[0]; 
	
	System.out.println("ID--->"+id);
	System.out.println(name+" ** "+accountno+" ** "+ifccode+" ** "+bankname+" ** "+branchname+" ** "+email+" ** "+status+""+limit+""+category);
	
	
	String sql1="select MAX(id) from "+session.getAttribute("CompanyMasterID").toString()+"netbankinghistory";
	ResultSet rs1=st3.executeQuery(sql1);
	rs1.next();
	int id1=rs1.getInt(1);
	id1++;
	
	String sqlInsert="Update "+session.getAttribute("CompanyMasterID").toString()+"netbanking set BeneficiaryName='"+name+"',BeneficiaryAccountNumber='"+accountno+"' ,IFCCode='"+ifccode+"' ,BeneBankName='"+bankname+"' ,BeneBankBranchName='"+branchname+"' ,Beneficiaryemailid='"+email+"' ,Status='"+status+"',EnteredBy='"+Empname+"',EnteredOn='"+todaysDateTime+"',Level1Limit='"+limit+"',Category='"+category+"' where id='"+id+"' ";
	st2.executeUpdate(sqlInsert);
	System.out.println("update queryyy------>"+sqlInsert);
	
	String sqlInsert1="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankinghistory (id,BeneficiaryName ,BeneficiaryAccountNumber ,IFCCode ,BeneBankName ,BeneBankBranchName ,Beneficiaryemailid,EnteredBy,EnteredOn) "+
	  "VALUES ('"+id1+"','"+name+"','"+accountno+"', '"+ifccode+"','"+bankname+"','"+branchname+"','"+email+"','"+Empname+"','"+todaysDateTime+"')";
st1.executeUpdate(sqlInsert1);
System.out.println(sqlInsert1);
	
	

	
	
	response.sendRedirect("alertGoTo.jsp?msg=Record Updated Succssfully In System .&goto=accountReport.jsp");
	
}
catch (Exception e){e.printStackTrace();}
finally{con.close();}
%>


