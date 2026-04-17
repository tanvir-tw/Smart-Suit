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
String suplier=request.getParameter("suplier");
  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like ('"+suplier+"%') "+
  		" union "+	
  	 	"SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like ('%"+suplier+"%') order by SupplierName limit 20 ";
  //out.print(sql1);
 System.out.println("INSupplier  INSupplier ******       "+sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer="<table>";
 int i=1;
 while(rs1.next())
 {
  flag=true;
  buffer+="<tr><td><a href='#' onClick='showSelectedSuppliers(\""+rs1.getString("SupplierCode")+"\",\""+rs1.getString("SupplierName")+"\");'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+suplier,"<font color=blue><u>"+suplier.toUpperCase()+"</u></font>")+".</a></tr></td>";
  i++;
 } 
   buffer+="</table>";
out.println(buffer);


} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
