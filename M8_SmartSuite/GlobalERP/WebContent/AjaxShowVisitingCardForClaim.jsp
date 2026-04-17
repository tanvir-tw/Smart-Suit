 <%@ include file="conn.jsp" %>
<%!
Connection con1;
%>
<% 
try {

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
boolean flag=false;
String company=request.getParameter("companyName");
System.out.println(">>>>>>>>>company:"+company);
  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode= ('"+company+"') order by CompanyName limit 1 ";
  System.out.println(">>>>>>>>>sql1:"+sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer=" ";
 int i=1;
   if(rs1.next())
     buffer+= "#"+rs1.getString("CompanyName");
   i++;
out.println(buffer);

} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
