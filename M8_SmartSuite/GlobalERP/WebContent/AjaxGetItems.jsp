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


System.out.println("_______________________________________________-");


	  sql1="(SELECT distinct(Description)  from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Description,' ','') like ('"+item.replace(" ","")+"%') order by Description) "+
	  " UNION "+
	  " (SELECT distinct(Description) from "+session.getAttribute("CompanyMasterID").toString()+"searchitems where replace(Description,' ','') like ('%"+item.replace(" ","")+"%') order by Description) limit 50 ";


	
	System.out.println(sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:90px;width:350px;overflow:auto;'><table style='display: block; overflow:auto;'>";

		 	int i=1;String val="";
		   while(rs1.next())
		   {
		      flag=true;
		    val=rs1.getString(1).replace("\"","`");
		    val=val.replace("&","~");  
		     buffer+="<tr><td><a href='#' onClick='showItemDetails(\""+val+"\")'  style='color: black;'>"+rs1.getString(1).replaceAll("(?i)"+item,"<font color=blue><u>"+item.toUpperCase()+"</u></font>")+".</a></tr></td>";
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
