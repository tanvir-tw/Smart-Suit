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

//System.out.println("in ajaxgetcustomer......");
String prospect=request.getParameter("company");

//sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname like ('"+prospect+"%') or tallyname like ('%"+prospect+"%') order by tallyname";

sql1="( SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where companyname like ('"+prospect+"%') and IsDataValid=1 order by  companyname )"+
"union"+
"(SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where companyname like ('%"+prospect+"%')  and IsDataValid=1 order by  companyname) order by companyname limit 20";

rs1=stmt1.executeQuery(sql1);
String buffer="<div style='height:190px;width:300px;overflow:auto;border: thin solid; border-color: #2077DA;'><table style='dsplay: block;background-color: #E1F3F3;'>";
//System.out.println("in sql1......"+sql1);

int i=1; 
String mAccountname="",name="";
while(rs1.next())
{
  name= (rs1.getString("companyname") == null || rs1.getString("companyname").equalsIgnoreCase("") ) ? "-" : rs1.getString("companyname");
//  buffer+="<tr><td>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</tr></td>";
name=name+"#"+rs1.getString("BranchName")+"#"+rs1.getString("CustomerCode");
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
