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
   
   
   
  System.out.println("111");
   String tranType="",tranType1="",benfName="",benfBankName="",accountNo="",ifcCode="",refNo="",category="",comment="";
   String EmpName="",branchname="",email="",Stringtocreatefile="",newstring="",Partname="",date="";
   int amount=0,nextcount=0,count=0;
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
   amount= Integer.parseInt(request.getParameter("amount"));
   refNo= request.getParameter("refNo");
   System.out.println("@@@@@@@@22  "+refNo);
   
   String temp[]= request.getParameter("category").split(",");
   category=temp[0]; 
   comment= request.getParameter("comment");
   EmpName=session.getAttribute("EmpName").toString();
   System.out.println("333"+tranType +"" +tranType1);
   date= request.getParameter("date");
   System.out.println("date is  "+date);
   String Date=new SimpleDateFormat("dd/MM/yyyy").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date));
   
   
   System.out.println("NEW DATE IS  "+Date);
   if(tranType==null)
   {
	   tranType=tranType1;
   }
// set heading of file & detail formate acording to transtype *************
	
	if (tranType.equals("250-HDFC TO OTHER"))
	{
		Partname="TCT0"+partDate;
	}
	else if(tranType.equals("250-HDFC TO HDFC"))
	{
		Partname = "TCT50"+partDate;
	}
	else if(tranType.equals("3338-HDFC TO OTHER"))
	{
		 Partname = "TCT8"+partDate;
	}
	else if(tranType.equals("3338-HDFC TO HDFC"))
	{
		Partname = "TCT38"+partDate;
	}
	System.out.println("partname "+Partname);

   
	String sqlnextcount="Select count(*) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+"'";
	   System.out.println(sqlnextcount);
	   ResultSet rs2=st.executeQuery(sqlnextcount);	  
	   while(rs2.next())
	   {   
	   count =rs2.getInt(1)+1;
	   }
	   nextcount=nextcount+count;
	  System.out.println("next count "+nextcount);
	
	 
   Writer output = null;
   String userHome = System.getProperty("user.home");
   System.out.println("userHome-"+userHome);
   String FilePath =""+userHome+"/NetbankingFiles"+filenameDate+"";
   System.out.println("file path  "+FilePath);
   
   String FileName="/"+Partname+"."+nextcount+"";

  
   String Flgfnewfile="";
		 Flgfnewfile= request.getParameter("Flgfnewfile");
		 System.out.println("Flgfnewfile " +Flgfnewfile);
  System.out.println("sysdate "+Date +"partDate "+partDate);

	
    System.out.println("EmpName "+EmpName +"tranType "+tranType+ "benfName " +benfName+ " benfBankName " +benfBankName+" accountNo "+accountNo+" ifcCode "+ ifcCode +" refNo "+refNo+ " category "+category+ "comment "+comment+"amount "+amount);
    String sql="Select BeneBankBranchName,Beneficiaryemailid from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName='"+benfName+"' AND BeneficiaryAccountNumber='"+accountNo+"'" ;
    System.out.println("sql ="+sql); 
    ResultSet rs1=st.executeQuery(sql);
	while(rs1.next())
	{branchname=rs1.getString("BeneBankBranchName");
		email=rs1.getString("Beneficiaryemailid");
	}
   String sqlinsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords (BeneficiaryName,BeneficiaryAccountNumber,IFCCode,BeneBankName,BeneBankBranchName,Beneficiaryemailid,Amount,TallyRefNo,Comments,Createdby,FileName1)"+
   			"values ('"+benfName+"','"+accountNo+"','"+ifcCode+"','"+benfBankName+"','"+branchname+"','"+email+"','"+amount+"','"+refNo+"','"+comment+"','"+EmpName+"','NA')";
   System.out.println(" insert record"+sqlinsert);   
   st1.executeUpdate(sqlinsert);
   
  

	if(tranType.equals("250-HDFC TO HDFC") || tranType.equals("3338-HDFC TO HDFC"))
	{  
		Stringtocreatefile="Account no.,C,Amount,Narration \n ";
		if(amount<200000)
		{	//Replace(Format(Date, "dd-mm-yyyy"), "-", "/")
		newstring="N,,"+accountNo+","+amount+","+benfName+",,,,,,,,"+refNo+","+refNo+","+comment+",,,,,,,,"+Date+",,"+ifcCode+","+benfBankName+","+branchname+","+email+"\n\n";
		}
		else
		{
			newstring="R,,"+accountNo+","+amount+","+benfName+",,,,,,,,"+refNo+","+refNo+","+comment+",,,,,,,,"+Date+",,"+ifcCode+","+benfBankName+","+branchname+","+email+"\n\n";
		}
	}
	else
	{
		Stringtocreatefile="";
	 	newstring = ""+accountNo+",C,"+amount+","+comment+" "+benfName+"\n\n";
	}
	System.out.println("newstring"+newstring);
	Stringtocreatefile = Stringtocreatefile+newstring;
	
	
   //response.sendRedirect("netBanking.jsp?tranType="+tranType+"&flag=yes");
       	 
    	 boolean exists=false;
    	   if(!new File(FilePath).exists()) 
    	  {
    	   File  dir = new File(FilePath);  dir.mkdir();
    	  }	
    	   System.out.println("folder exisit"+new File(FilePath).exists());
    	  
    	  //create new file.
    	  if(Flgfnewfile.equals("NO"))
	      {
    	    FileWriter file = new FileWriter(FilePath+FileName+".txt",true);
       	    output = new BufferedWriter(file);
       	    output.write(Stringtocreatefile);
       	    output.close();
       	    System.out.println("Your file has been written");
       	    response.sendRedirect("netBanking.jsp?tranType="+tranType+"&flag=yes"); 
    	  }
    	  else
    	  {
    	  //  folder created
    	    File file = new File(FilePath+FileName+".txt");
       	   // FileWriter fw = new FileWriter(filename,true);
       	    output = new BufferedWriter(new FileWriter(file));
       	    output.write(Stringtocreatefile);
       	    output.close();
       	    System.out.println("New file created ");
    	  }
    	  
    	  response.sendRedirect("netBanking.jsp?tranType="+tranType+"&flag=yes");
    	/*
    */
}
catch(Exception e)
{
	System.out.println(" error is"+e);   
}
  
   
   
%>
</jsp:useBean>