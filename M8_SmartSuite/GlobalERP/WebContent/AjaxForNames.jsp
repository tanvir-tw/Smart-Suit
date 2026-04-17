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
String company=request.getParameter("company");
System.out.println(">>>>>>>>>>>>>>    "+company);
String Name="",city="",address="",zip="",email="",phone="",website="",product="",weeklyoff="",suppliercode="",companyname="",fax="",mobile="";
String country="",state="",designation="",areacode="",alternateno="",role="";
sql1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName like ('%"+company+"%') order by EmpName";
//out.print(sql1);
System.out.println("INSupplier  INSupplier ******       "+sql1);
rs1=stmt1.executeQuery(sql1);
String buffer="<div style='height:120px;width:275px;overflow:auto; '><table style='background-color:#C6DEFF; width:400px; display: block';>";
int i=1;

while(rs1.next())
{

   Name= (rs1.getString("EmpName") == null || rs1.getString("EmpName").equalsIgnoreCase("") ) ? "-" : rs1.getString("EmpName") ;
   role= (rs1.getString("RoleID") == null || rs1.getString("RoleID").equalsIgnoreCase("") ) ? "-" : rs1.getString("RoleID") ;
   //flag=true;
   
   out.print("<input type='hidden' name='sname"+i+"' id='sname"+i+"' value='"+Name+"'>");  
   out.print("<input type='hidden' name='srole"+i+"' id='srole"+i+"' value='"+role+"'>");  
   
   
   
   
   
   
   buffer+="<tr><td><a href='#' onClick='getsupplierDetails("+i+");'  style='color: black;'>"+rs1.getString("EmpName").replaceAll("(?i)","<font color=blue><u>"+"</u></font>")+"</a></tr></td>";
   i++;
   
}
buffer+="</table></div>";
out.println(buffer);



} catch(Exception e) {  }
finally
{
	con1.close();
}
%>