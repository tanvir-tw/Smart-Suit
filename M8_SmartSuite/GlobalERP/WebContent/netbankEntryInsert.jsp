<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%System.out.println("\n insert net banking");
try{
   erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);

	 Connection conn = null;
   Statement st = null,st1=null,st2=null,st3=null,st4=null;
   PreparedStatement pst1 =null;
   try {
	   conn = erp.ReturnConnection();
	   st = conn.createStatement();
	   st1 = conn.createStatement();
	   st2 = conn.createStatement();
	   st3 = conn.createStatement();
	   st4 = conn.createStatement();
   		}
   catch(Exception e)
   {
	  System.out.println(" connection error "+e); 
	   
   }
   
   
   
  System.out.println("Entryyy Form Inserttt");
   String tranType="",tranType1="",benfName="",benfBankName="",accountNo="",ifcCode="",refNo="",category="",comment="";
   String EmpName="",branchname="",email="",Stringtocreatefile="",newstring="",Partname="",date="";
   int nextcount=0,count=0;
   double amount=0.0;
   System.out.println("qwqwqe  ");
   String partDate="";
   String filenameDate="";
  System.out.println("222");
   tranType=request.getParameter("tranType");
   tranType1=request.getParameter("tranType1");
   benfName=request.getParameter("benfName");
   benfBankName= request.getParameter("benfBankName");
   accountNo= request.getParameter("accountNo");
   ifcCode= request.getParameter("ifcCode");
   amount= Double.parseDouble(request.getParameter("amount"));
   refNo= request.getParameter("refNo");
   System.out.println("@@@@@@@@22  "+refNo);
   String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
   String temp[]= request.getParameter("category").split(",");
   category=temp[0]; 
   comment= request.getParameter("comment");
   EmpName=session.getAttribute("EmpName").toString();
   System.out.println("333"+tranType +"" +tranType1);
   date= request.getParameter("date");
   System.out.println("date is  "+date);
   String Date=new SimpleDateFormat("dd/MM/yyyy").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date));
   String Paymentmode= request.getParameter("paymentmode");
   System.out.println("Paymentmode  "+Paymentmode);
   
   System.out.println("NEW DATE IS  "+Date);
   if(tranType==null)
   {
	   tranType=tranType1;
   }

    System.out.println("EmpName "+EmpName +"tranType "+tranType+ "benfName " +benfName+ " benfBankName " +benfBankName+" accountNo "+accountNo+" ifcCode "+ ifcCode +" refNo "+refNo+ " category "+category+ "comment "+comment+"amount "+amount);
    String sql="Select BeneBankBranchName,Beneficiaryemailid from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+benfName+"' AND BeneficiaryAccountNumber='"+accountNo+"'" ;
    System.out.println("sql ="+sql); 
    ResultSet rs1=st.executeQuery(sql);
	while(rs1.next())
	{branchname=rs1.getString("BeneBankBranchName");
		email=rs1.getString("Beneficiaryemailid");
	}
	
	//////
	if(tranType.equals("250-HDFC TO HDFC") || tranType.equals("3338-HDFC TO HDFC"))
	{  
		//Stringtocreatefile="Account no.,C,Amount,Narration \n ";
		Stringtocreatefile="";
	 	newstring = ""+accountNo+",C,"+amount+","+comment+" "+benfName+"\n\n";
		
	}
	else
	{
		Stringtocreatefile="";
		if(Paymentmode.equals("NEFT"))
		{	
			System.out.println("NEFT");
		newstring="N,,"+accountNo+","+amount+","+benfName+",,,,,,,,"+refNo+","+refNo+","+comment+",,,,,,,,"+Date+",,"+ifcCode+","+benfBankName+","+branchname+","+email+"\n\n";
		}
		else if(Paymentmode.equals("RTGS"))
		{
			System.out.println("RTGS");

			newstring="R,,"+accountNo+","+amount+","+benfName+",,,,,,,,"+refNo+","+refNo+","+comment+",,,,,,,,"+Date+",,"+ifcCode+","+benfBankName+","+branchname+","+email+"\n\n";
		}
	}
	System.out.println("newstring"+newstring);
	Stringtocreatefile = Stringtocreatefile+newstring;
	System.out.println("Record matter"+Stringtocreatefile+" current date"+todaysDateTime);
	
	/////
	
	
	
   String sqlinsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords (Recordmatter,BeneficiaryName,BeneficiaryAccountNumber,IFCCode,BeneBankName,BeneBankBranchName,Beneficiaryemailid,Amount,TallyRefNo,Comments,Createdby,CreationDate,RecordType,PaymentMode,FileName1)"+
   			"values ('"+Stringtocreatefile+"','"+benfName+"','"+accountNo+"','"+ifcCode+"','"+benfBankName+"','"+branchname+"','"+email+"','"+amount+"','"+refNo+"','"+comment+"','"+EmpName+"','"+todaysDateTime+"','"+tranType+"','"+Paymentmode+"','NA')";
   System.out.println(sqlinsert);

	
	/*
	
	String sqlinsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords (Recordmatter,BeneficiaryName,BeneficiaryAccountNumber,IFCCode,BeneBankName,BeneBankBranchName,Beneficiaryemailid,Amount,TallyRefNo,Comments,Createdby,CreationDate,RecordType,FileName1) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
   System.out.println(" insert record"+sqlinsert); 
   
   pst1 = conn.prepareStatement(sqlinsert);
   
   pst1.setString(1, Stringtocreatefile);
   pst1.setString(2, benfName);
   pst1.setString(3, accountNo);
   pst1.setString(4, ifcCode);
   pst1.setString(5, benfBankName);
   pst1.setString(6, branchname);
   pst1.setString(7, email);
   pst1.setDouble(8, amount);
   pst1.setString(9, refNo);
   pst1.setString(10, comment);
   pst1.setString(11, EmpName);
   pst1.setString(12, todaysDateTime);
   pst1.setString(13, tranType);
   pst1.setString(14, "NA");
   pst1.executeUpdate();
   */
   st1.executeUpdate(sqlinsert);
   
   
   
   String sqlnextcount1="Select max(id) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords ";
   System.out.println(sqlnextcount1);
   ResultSet rs3=st3.executeQuery(sqlnextcount1);	  
   while(rs3.next())
   {   
   count =rs3.getInt(1);
   }
   //count=count+1;
System.out.println("netbanking max Id cnttt- 2nd----->"+count);

String sqlinsert1="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles (id)  values ('"+count+"')";
	System.out.println(" insert record filessss-->"+sqlinsert1);   
st4.executeUpdate(sqlinsert1);
   
      	  //response.sendRedirect("netBankingEntry.jsp?tranType="+tranType+"&flag=yes");
    	  response.sendRedirect("alertGoTo.jsp?msg=Net Banking Entry Inserted Succssfully In System .&goto=netBankingEntry.jsp");
   
}
catch(Exception e)
{
	System.out.println(" error is"+e);   
}
  
   
   
%>
</jsp:useBean>