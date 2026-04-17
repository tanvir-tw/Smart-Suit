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
String CompanyName="",EMail="",ContactPerson="",BillingCity="",IntrestedProduct="",MobileNo="";
boolean flag=false;
String originalcompany=request.getParameter("company");
String company=request.getParameter("company");
company=company.replace(".", "");
company=company.replace(",", "");
company=company.replace("$", "");
company=company.replace("#", "");
company=company.replace("?", "");
  sql1="SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace(Replace(Replace(Replace(Replace(Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-',''),',',''),'?',''),'_',''),'(',''),')','') like ('%"+company+"%') order by CompanyName limit 20 ";
  System.out.println("QUERY FOR GETINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNG "+sql1);
 System.out.println("IN LEDGER *(*(*    "+sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:120px;width:400px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
 int i=1;
if(request.getParameter("getCompanyName")==null)
 while(rs1.next())
   {
      flag=true;
      CompanyName = (rs1.getString("CompanyName") == null || rs1.getString("CompanyName").equalsIgnoreCase("") ) ? "-" : rs1.getString("CompanyName")  ;
      EMail = (rs1.getString("EMail") == null || rs1.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs1.getString("EMail")  ;
      ContactPerson = (rs1.getString("ContactPerson") == null || rs1.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs1.getString("ContactPerson")  ;
      BillingCity = (rs1.getString("BillingCity") == null || rs1.getString("BillingCity").equalsIgnoreCase("") ) ? "-" : rs1.getString("BillingCity")  ;
      IntrestedProduct = (rs1.getString("IntrestedProduct") == null || rs1.getString("IntrestedProduct").equalsIgnoreCase("") ) ? "-" : rs1.getString("IntrestedProduct")  ;
      MobileNo = (rs1.getString("MobileNo") == null || rs1.getString("MobileNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("MobileNo")  ;
      
     buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+CompanyName+"\",\""+EMail+"\",\""+ContactPerson+"\",\""+BillingCity+"\",\""+IntrestedProduct+"\",\""+MobileNo+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></tr></td>";
    
        i++;
   } 
else
	 while(rs1.next())
	   {
	      flag=true;
	      
	      CompanyName = (rs1.getString("CompanyName") == null || rs1.getString("CompanyName").equalsIgnoreCase("") ) ? "-" : rs1.getString("CompanyName")  ;
	      EMail = (rs1.getString("EMail") == null || rs1.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs1.getString("EMail")  ;
	      ContactPerson = (rs1.getString("ContactPerson") == null || rs1.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs1.getString("ContactPerson")  ;
	      BillingCity = (rs1.getString("BillingCity") == null || rs1.getString("BillingCity").equalsIgnoreCase("") ) ? "-" : rs1.getString("BillingCity")  ;
	      IntrestedProduct = (rs1.getString("IntrestedProduct") == null || rs1.getString("IntrestedProduct").equalsIgnoreCase("") ) ? "-" : rs1.getString("IntrestedProduct")  ;
	      MobileNo = (rs1.getString("MobileNo") == null || rs1.getString("MobileNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("MobileNo")  ;
	      
	     buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+CompanyName+"\",\""+EMail+"\",\""+ContactPerson+"\",\""+BillingCity+"\",\""+IntrestedProduct+"\",\""+MobileNo+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></tr></td>";
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
