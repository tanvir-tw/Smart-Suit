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

String item=request.getParameter("item");
String  searchBy=request.getParameter("searchBy");
if(searchBy.equalsIgnoreCase("Item"))
	  sql1="(SELECT distinct(Description)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Description,' ','') like ('"+item.replace(" ","")+"%') order by Description) "+
	  " UNION "+
	  " (SELECT distinct(Description)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Description,' ','') like ('%"+item.replace(" ","")+"%') order by Description) limit 50 ";

else if(searchBy.equalsIgnoreCase("Company"))
	
	sql1="(SELECT distinct(makename)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(makename,' ','') like ('"+item+"%') order by makename) "+
	  " UNION "+
	  " (SELECT distinct(makename)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(makename,' ','') like ('%"+item+"%') order by makename) limit 50 ";
	
else if(searchBy.equalsIgnoreCase("Model"))
	
	sql1="(SELECT distinct(Model)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Model,' ','') like ('"+item+"%') order by Model) "+
	  " UNION "+
	  " (SELECT distinct(Model)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Model,' ','') like ('%"+item+"%') order by Model) limit 50 ";
	
else if(searchBy.equalsIgnoreCase("Part"))
	sql1="(SELECT distinct(PartNo)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(PartNo,' ','') like ('"+item+"%') order by PartNo) "+
	  " UNION "+
	  " (SELECT distinct(PartNo)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(PartNo,' ','') like ('%"+item+"%') order by PartNo) limit 50 ";
	
else if(searchBy.equalsIgnoreCase("Supplier"))
	sql1="(SELECT distinct(SupplierName),SupplierCode  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where replace(SupplierName,' ','') like ('"+item+"%') order by SupplierName) "+
	  " UNION "+
	  " (SELECT distinct(SupplierName),SupplierCode  from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where replace(SupplierName,' ','') like ('%"+item+"%') order by SupplierName) limit 50 ";
	
	
  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:90px;width:400px;overflow:auto;'><table style='display: block; overflow:auto;'>";
  if(!(searchBy.equalsIgnoreCase("Supplier"))){
		 	int i=1;String val="";
		   while(rs1.next())
		   {
		      flag=true;
		    val=rs1.getString(1).replace("\"","`");
		    val=val.replace("&","~");  
		     buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\",\""+searchBy+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
		        i++;
		   } 
  }
  else
  {
		 	int i=1;String val="";
		   while(rs1.next())
		   {
		      flag=true;
		    val=rs1.getString(1).replace("\"","?");  
		     buffer+="<tr><td><a href='#' onClick='showSupplier(\""+rs1.getString(2)+"\",\""+val+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
		        i++;
		   } 
  }
   buffer+="</table></div>";
out.println(buffer);


} catch(Exception e) {  }
finally
{
	con1.close();
}
%>
