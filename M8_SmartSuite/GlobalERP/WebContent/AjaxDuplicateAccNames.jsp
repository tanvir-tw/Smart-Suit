 <%@ include file="conn.jsp" %>

<%!
Connection con1;
%>

<% 
try
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();


ResultSet rs1=null;
String sql1="";
boolean flag=false;
String Accountno=request.getParameter("accountno");
String Accountname=request.getParameter("accountname");



	System.out.println("IN CONTRACTOR"+Accountname+"connection"+con1);
	sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryAccountNumber ='"+Accountno+"' order by BeneficiaryName";
	rs1=stmt1.executeQuery(sql1);
	System.out.println(" select queryy--->"+sql1);
	String buffer="no";
	//int i=1;
	while(rs1.next())
	{
		buffer="yes";
	}
	out.print(buffer);



}
catch(Exception e) 
{
}
finally
{
	con1.close();
}
%>