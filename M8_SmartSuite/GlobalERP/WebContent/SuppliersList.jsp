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
String company=request.getParameter("company");
  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like ('%"+company+"%') order by SupplierName limit 20 ";
  //out.print(sql1);
 System.out.println("INSupplier  INSupplier ******       "+sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:100px;width:220px;overflow:auto;'><table style='background-color:white; display: block';>";
 int i=1;
/*if(request.getParameter("getCompanyName")==null)
 while(rs1.next())
   {
      flag=true;
      
     buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
        i++;
   } 
else */
	   while(rs1.next())
	   {
	      flag=true;
	      
	    // buffer+="<tr><td><a href='#' onClick='showSelectedSuppliers(\""+rs1.getString("SupplierCode")+"\",\""+rs1.getString("SupplierName")+"\");'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
	      
	      buffer+="<tr><td><a href='#' onClick='addRowForSupplier(\""+rs1.getString("SupplierCode")+"\",\""+rs1.getString("SupplierName")+"\");'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
	      // buffer+="<tr><td><a href='#' "+rs1.getString("SupplierCode")+"\",\""+rs1.getString("SupplierName")+"  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";   
	     
	     i++;
	   } 

   buffer+="</table></div>";
   out.println(buffer);

} 
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	con1.close();
}
%>
