 <%@ include file="conn.jsp" %>
 <%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%!
Connection con1;
%>
<% 

String customercodes=request.getParameter("customercodes");

String company="";
String  companyPerson="";
String companyPhone="";
String  companyEmail="";
String  companyCity="";
String  companyProduct="";
System.out.println("cusotmercodes"+customercodes);
try
{
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st1=con1.createStatement();
		String sql1="";
		ResultSet rs1=null;
		Statement st2=con1.createStatement();
		ResultSet rs2=null;
		Statement st3=con1.createStatement();
		ResultSet rs3=null;
		
		String sql="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode="+  customercodes+" order by TransactionDate,transactionid ASC";
		System.out.println("sql"+sql);
		rs1=st1.executeQuery(sql);
		double balance = 0;
		double debitamount=0;
		double creditamount=0;
		double transactionid=0;
       	while(rs1.next())
		{
       		//System.out.println("1");
       		transactionid=rs1.getDouble("transactionid");
       		//System.out.println("2");
		    debitamount=rs1.getDouble("debitamount");
		 //   System.out.println("3");
		    creditamount=rs1.getDouble("creditamount");
		 //   System.out.println("4");
		    balance = balance + debitamount-creditamount;
		//    System.out.println("5");
		    sql1 = "UPDATE "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount set balance="+balance+" where transactionid="+transactionid;
		    st2.executeUpdate(sql1);
		    System.out.println("sql1"+sql1);
		    System.out.println("debitamount: "+debitamount+" Creditamount: "+creditamount+" Balance :"+balance);
		}
       	

//       	String sqlCustomerInfo="SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Assighnedby,leadRef,AddedOnDate,CompanyName from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode = '"+customercodes+"' and IsDataValid='1' ";
       	
       	String sqlCustomerInfo="SELECT CompanyName,EMail,BillingAddress,MobileNo,BillingCity,IntrestedProduct,ContactPerson from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode = '"+customercodes+"'";
       	
       	rs3= st3.executeQuery(sqlCustomerInfo);
       	System.out.println("query for geting all details===>"+sqlCustomerInfo);
       	
       	if(rs3.next())
       	{
       		 company= (rs3.getString("CompanyName") == null || rs3.getString("CompanyName").equalsIgnoreCase("") ) ? "-" : rs3.getString("CompanyName")  ;
       		 companyPerson=(rs3.getString("ContactPerson") == null || rs3.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs3.getString("ContactPerson")  ;
       		 companyPhone=(rs3.getString("MobileNo") == null || rs3.getString("MobileNo").equalsIgnoreCase("") ) ? "-" : rs3.getString("MobileNo")  ;
       		 companyEmail=(rs3.getString("EMail") == null || rs3.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs3.getString("EMail")  ;
       		 companyCity=(rs3.getString("BillingCity") == null || rs3.getString("BillingCity").equalsIgnoreCase("Select") ) ? "-" : rs3.getString("BillingCity")  ;
       		 companyProduct=(rs3.getString("IntrestedProduct") == null || rs3.getString("IntrestedProduct").equalsIgnoreCase("") ) ? "-" : rs3.getString("IntrestedProduct")  ;
       		
       	}
}
catch (Exception e)
{
	
}



String webadd="ledgerdetails.jsp?companyName="+company.replace('&','~')+"&companyPerson="+companyPerson+"&companyPhone="+companyPhone+"&companyEmail="+companyEmail+"&companyCity="+companyCity+"&companyProduct="+companyProduct+"&customercode="+customercodes;

System.out.println("REdirecting web Id====>"+webadd);
//?companyName=M S Freight Carriers (India) Pvt.Ltd.&companyPerson=Mr. Siddharth Khaitan&companyPhone=0&companyEmail=sidkhaitan@msfcipl.com, msfreight@msfcipl.com&companyCity=Kolkata&companyProduct=AVL
//response.sendRedirect("ledgerdetails.jsp");
response.sendRedirect(webadd);

%>
</jsp:useBean>
			

