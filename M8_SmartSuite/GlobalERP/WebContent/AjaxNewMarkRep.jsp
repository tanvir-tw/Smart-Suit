<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxClaimEnq.jsp>>>>>>>>>>>>>>>>");	
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stmt2 = con1.createStatement();
Statement stmt3 = con1.createStatement();

String Buffer="";
String Empname=request.getParameter("name");
System.out.println(">>>>>Name:"+Empname);

String select="select * from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+Empname+"'";
System.out.println(">>>>>select :"+select);

ResultSet rs= stmt1.executeQuery(select);

if(rs.next())
{
	System.out.println(">>>>>Name:"+Empname);
	
	String TALevel="";
	String select1="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+Empname+"' and Dept in ('Marketing','Sales')";
	 System.out.println(">>>>>select in security :"+select1);
	ResultSet rs2= stmt2.executeQuery(select1);
	if(rs2.next())
	{
		
		TALevel=rs2.getString("TALevel");
		
		
	
	
	Buffer="ZZ"+rs.getString("MarketingRepName");
	Buffer+="ZZ"+rs.getString("MarketingRepEMail");
	Buffer+="ZZ"+rs.getString("MarketingRepPhNo");
	Buffer+="ZZ"+rs.getString("Password");
    Buffer+="ZZ"+rs.getString("UserLevel");
    Buffer+="ZZ"+TALevel;
	Buffer+="ZZ"+rs.getString("VisitsTarget");
	Buffer+="ZZ"+rs.getString("CallsTarget");
	Buffer+="ZZ"+rs.getString("LettersTarget");
	Buffer+="ZZ"+rs.getString("SQTarget");
	Buffer+="ZZ"+rs.getString("NewProspectTarget");
	
	}
	System.out.println("-------Buffer:"+Buffer);
	
	String Buffer1="No"+Buffer;
	out.println("No"+Buffer);
}
else{
	
 select="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+Empname+"' and Dept in ('Marketing','Sales')";
 System.out.println(">>>>>select in security :"+select);
ResultSet rs1= stmt3.executeQuery(select);
if(rs1.next())
{
	Buffer="ZZ"+rs1.getString("UserName");
	Buffer+="ZZ"+rs1.getString("email");
	Buffer+="ZZ"+rs1.getString("mobileno");
	Buffer+="ZZ"+rs1.getString("Password");
    Buffer+="ZZ"+rs1.getString("UserLevel");
	Buffer+="ZZ"+rs1.getString("TALevel");
	
	System.out.println("-------Buffer:"+Buffer);
	String Buffer1="Yes"+Buffer;
	out.println("Yes"+Buffer);
}
else{
	String Buffer1="NoData"+Buffer;
	out.println("NoData"+Buffer);
}
}

}
catch(Exception e)
{
}
%>