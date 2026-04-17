 <%@ include file="conn.jsp" %>

<%!
Connection con1;
%>
<% 
String buffer="";
try
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
boolean flag=false;
System.out.println("AJAX TEST  PAGE   ");
String srno=request.getParameter("srno");
System.out.println(""+srno);

sql1="update "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment set  ActiveStatus ='No' where SrNo='"+srno+"' ";
System.out.println(sql1);
stmt1.executeUpdate(sql1);


buffer="Yes";
out.println(buffer);
}
catch(Exception e)
{
	System.out.println(" " +e);
	buffer="No";
}
finally
{
	con1.close();
}
%>
