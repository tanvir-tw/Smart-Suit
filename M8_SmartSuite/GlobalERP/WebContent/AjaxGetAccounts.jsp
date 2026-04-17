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

String prospect=request.getParameter("accounts");

//sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname like ('"+prospect+"%') or tallyname like ('%"+prospect+"%') order by tallyname";

sql1="( SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname like ('"+prospect+"%') order by  tallyname )"+
"union"+
"(SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname like ('%"+prospect+"%')  order by  tallyname) order by tallyname limit 20";

rs1=stmt1.executeQuery(sql1);
String buffer="<div style='height:150px;width:325px;overflow:auto;'><table style='display: block';>";
int i=1; 
String mAccountname="",name="";
while(rs1.next())
{
  name= (rs1.getString("tallyname") == null || rs1.getString("tallyname").equalsIgnoreCase("") ) ? "-" : rs1.getString("tallyname");
//  buffer+="<tr><td>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</tr></td>";
  if(name.toLowerCase().contains(prospect.toLowerCase()))
  {
     buffer+="<tr><td><a href='#' onClick='getAccountsDetails("+i+");'  style='color: black;'>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</a></tr></td>";
    // System.out.println(buffer);
  }
   out.print("<input type='hidden' name='name"+i+"' id='name"+i+ "' value='"+name+"'>");
  i++; 
} 
buffer+="</table></div>";
out.println(buffer+"</select>");
}
catch(Exception e)
{
	//System.out.println(e);
	out.print("<div style='height:210px;width:350px;overflow:auto; align:left;'><table style='display: block';></table></div>");
}
finally
{
	con1.close();
}
%>
