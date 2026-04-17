
<%@ include file="headConn.jsp"%>


<% 
try 
{
Statement stmt=conn.createStatement();
String sql=""; 
String emp=request.getParameter("emp");

		 sql="SELECT DISTINCT(Name),UName FROM t_leaveadmin  WHERE Name LIKE('%"+emp+"%') and Status='Yes' ORDER BY Name LIMIT 20 ";
		 ResultSet rs=stmt.executeQuery(sql);
		 String buffer="<div style='height:120px;width:400px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
		 int i=1;
		   while(rs.next())
		   {
		     buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs.getString("Name")+"\",\""+rs.getString("UName")+"\");'  style='color: black;'>"+rs.getString("Name").replaceAll("(?i)"+emp,"<font color=blue><u>"+emp.toUpperCase()+"</u></font>")+".</a></tr></td>";
		        i++;
		   } 
		   buffer+="</table></div>";
		out.println(buffer);
	


} 
catch(Exception e) 
{  
	System.out.println("!!!ERROR!!!  GenericAjaxSearch  ::  "+e);
}
finally
{
	conn.close();
}
%>
