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
String suplier=request.getParameter("suplier").replaceAll(" ","");

suplier=suplier.replace(".","");
suplier=suplier.replace(" ","");
suplier=suplier.replace("-","");
suplier=suplier.replace("_","");
  //sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName like ('%"+suplier+"%') order by SupplierName limit 20 ";
  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where Replace(Replace(Replace(Replace(Replace(Replace( Replace( Replace( SupplierName,'.', '') ,' ','') ,'-',''),',',''),'?',''),'_',''),'(',''),')','') like ('%"+suplier+"%') order by SupplierName limit 20 ";
  //out.print(sql1);
 System.out.println("INSupplier  INSupplier ******       "+sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:120px;width:200px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
 int i=1;
/*if(request.getParameter("getCompanyName")==null)
 while(rs1.next())
   {
      flag=true;
      
     buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
        i++;
   } 
else */

if (!rs1.next()) {
    System.out.println("No records found");
    buffer +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
    rs1.beforeFirst();
} else {
	 //while(rs1.next())
	   do{
	      flag=true;
	      
	     buffer+="<tr><td><a href='#' onClick='showSelectedSuppliers(\""+rs1.getString("SupplierCode")+"\",\""+rs1.getString("SupplierName")+"\");'  style='color: black;'>"+rs1.getString("SupplierName").replaceAll("(?i)"+suplier,"<font color=blue><u>"+suplier.toUpperCase()+"</u></font>")+".</a></tr></td>";
	        i++;
	   }while(rs1.next());
}//end of else


   buffer+="</table></div>";
out.println(buffer);


} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
