<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%@ include file="ConnForIncident.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
Statement stmt=null;
String user=session.getAttribute("user").toString();
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String deductiondesc="0",deductionPer="0";
System.out.println("user-->"+user+"date"+todaysDate);
%>
<%
//boolean isInvoiceSelected=false;
try{
	System.out.println("conn**");

	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	System.out.println("connt"+con);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	st5=con.createStatement();
	st6=con.createStatement();

	Statement stleave=conn.createStatement();
	Statement stleave1=conn.createStatement();
	System.out.println("conn**11");
	String codes="";
	String name=request.getParameter("supplier");
	String accountno=request.getParameter("accountno");
	String ifccode=request.getParameter("ifccode");
	String bankname=request.getParameter("bankname");
	String branchname=request.getParameter("branchname");
	String email=request.getParameter("email");
	//String category=request.getParameter("type");
	String status="-";
	String limit=request.getParameter("limit");
	System.out.println("conn**22");
	int id=0,id1=0;
	String a=request.getParameter("type");
	System.out.println("conn**223"+a);
	String temp[]= request.getParameter("type").split(",");
	String category=temp[0];
	System.out.println("conn**33");
	System.out.println("CATGORY IS   "+category);
	System.out.println("DETAILS   "+name+" "+accountno+" "+ifccode+""+bankname+""+branchname+""+email);

	
	 if(category.equals("Contracter Fee"))
	{
		String sqlData="select * from db_leaveapplication.t_leaveadmin where Name='"+name+"'";
		ResultSet rsData=stleave.executeQuery(sqlData);
		System.out.println(sqlData);
		rsData.next();
		codes=rsData.getString("EmpID");
		System.out.println("Contractor fee "+codes);
		
	}else if(category.equals("Claims"))
		{
			String sqlData="select * from db_leaveapplication.t_leaveadmin where Name='"+name+"'";
			ResultSet rsData=stleave.executeQuery(sqlData);
			System.out.println(sqlData);
			rsData.next();
			codes=rsData.getString("EmpID");
			System.out.println("Claims fee "+codes);
		} else if(category.equals("vendor"))
		{
		String sqlData="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName='"+name+"'";
		ResultSet rsData=st1.executeQuery(sqlData);
		System.out.println(sqlData);
		rsData.next();
		codes=rsData.getString("SupplierCode");
		}
	else if(category.equals("statutory"))
	{
		String sqlData="select * from "+session.getAttribute("CompanyMasterID").toString()+"statutorydet where StatutoryName='"+name+"'";
		ResultSet rsData=st1.executeQuery(sqlData);
		System.out.println(sqlData);
		rsData.next();
		codes=rsData.getString("ID");
		
	}
	else
	{
		System.out.println("ELSE fee ");
	}
	String sql1="select MAX(id) from "+session.getAttribute("CompanyMasterID").toString()+"netbanking";
	System.out.println("ELSE 11 ");
	//String sql2="select Limit1 from "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory where Category='"+category+"'";
	//System.out.println("ELSE 11 "+sql2);
	ResultSet rs1=st3.executeQuery(sql1);
	//ResultSet rs5=st5.executeQuery(sql2);
	rs1.next();
	id=rs1.getInt(1);
	id++;
	System.out.println("testtt ");
/*	while(rs5.next())
	{
		limit=rs5.getString("Limit1");
	}*/
	System.out.println("limit-enttttttttt--->"+limit);
	System.out.println("testtt 1");
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbanking (id,BeneficiaryName ,BeneficiaryAccountNumber ,IFCCode ,BeneBankName ,BeneBankBranchName ,Beneficiaryemailid,Enteredby,EnteredOn,Status,Category,AccountID,Level1Limit) "+
	  "VALUES ('"+id+"','"+name+"','"+accountno+"', '"+ifccode+"','"+bankname+"','"+branchname+"','"+email+"','"+user+"','"+todaysDate+"','"+status+"','"+category+"','"+codes+"','"+limit+"')";
	st1.executeUpdate(sqlInsert);
	System.out.println(""+session.getAttribute("CompanyMasterID").toString()+"netbanking query"+sqlInsert);

 


	String sqlId="select MAX(id) from "+session.getAttribute("CompanyMasterID").toString()+"netbankinghistory";
	ResultSet rs6=st6.executeQuery(sqlId);
	rs6.next();
	id1=rs6.getInt(1);
	id1++;
	System.out.println("maxxxidd"+id1);
	
	String sqlInsert1="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankinghistory (id,BeneficiaryName ,BeneficiaryAccountNumber ,IFCCode ,BeneBankName ,BeneBankBranchName ,Beneficiaryemailid) "+
				      "VALUES ('"+id1+"','"+name+"','"+accountno+"', '"+ifccode+"','"+bankname+"','"+branchname+"','"+email+"')";
 	st1.executeUpdate(sqlInsert1);
	System.out.println("history query"+sqlInsert1);

	response.sendRedirect("alertGoTo.jsp?msg=Data Inserted Succssfully In System .&goto=accountReport.jsp");
	
}
catch (Exception e){e.printStackTrace();}
finally{con.close();}
%>


