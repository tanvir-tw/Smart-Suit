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
System.out.println("AJAX TEST  PAGE   ");
String prospect=request.getParameter("company");
System.out.println(""+prospect);
//sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname like ('"+prospect+"%') or tallyname like ('%"+prospect+"%') order by tallyname";

sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"netbanking where BeneficiaryName like '%"+prospect+"%' And Status <> 'Deactivate' ";

rs1=stmt1.executeQuery(sql1);
System.out.println(sql1);
String buffer="<div style='height:150px;width:325px;overflow:auto;'><table style='background-color:#C6DEFF;display: block';>";
int i=1; 
String mAccountname="",name="",accountno="",ifc="",bankname="",branchname="",emailid="";
while(rs1.next())
{
  name= (rs1.getString("BeneficiaryName") == null || rs1.getString("BeneficiaryName").equalsIgnoreCase("") ) ? "-" : rs1.getString("BeneficiaryName");
  accountno= (rs1.getString("BeneficiaryAccountNumber") == null || rs1.getString("BeneficiaryAccountNumber").equalsIgnoreCase("") ) ? "-" : rs1.getString("BeneficiaryAccountNumber");
  ifc= (rs1.getString("IFCCode") == null || rs1.getString("IFCCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("IFCCode");
  bankname= (rs1.getString("BeneBankName") == null || rs1.getString("BeneBankName").equalsIgnoreCase("") ) ? "-" : rs1.getString("BeneBankName");
  branchname= (rs1.getString("BeneBankBranchName") == null || rs1.getString("BeneBankBranchName").equalsIgnoreCase("") ) ? "-" : rs1.getString("BeneBankBranchName");
  emailid= (rs1.getString("Beneficiaryemailid") == null || rs1.getString("Beneficiaryemailid").equalsIgnoreCase("") ) ? "-" : rs1.getString("Beneficiaryemailid");
  
//  buffer+="<tr><td>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</tr></td>";
  if(name.toLowerCase().contains(prospect.toLowerCase()))
  {
     buffer+="<tr><td><a href='#' onClick='getAccountsDetails("+i+");'  style='color: black;'>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</a></tr></td>";
    // System.out.println(buffer);
  }
   out.print("<input type='hidden' name='name"+i+"' id='name"+i+ "' value='"+name+"'>");
   out.print("<input type='hidden' name='accountno"+i+"' id='accountno"+i+ "' value='"+accountno+"'>");
   out.print("<input type='hidden' name='ifc"+i+"' id='ifc"+i+ "' value='"+ifc+"'>");
   out.print("<input type='hidden' name='bankname"+i+"' id='bankname"+i+ "' value='"+bankname+"'>");
   out.print("<input type='hidden' name='branchname"+i+"' id='branchname"+i+ "' value='"+branchname+"'>");
   out.print("<input type='hidden' name='emailid"+i+"' id='emailid"+i+ "' value='"+emailid+"'>");
  i++; 
} 
buffer+="</table></div>";
out.println(buffer+"</select>");
}
catch(Exception e)
{
	System.out.println(" " +e);
	out.print("<div style='height:210px;width:350px;overflow:auto; align:left;'><table style='display: block';></table></div>");
}
finally
{
	con1.close();
}
%>
