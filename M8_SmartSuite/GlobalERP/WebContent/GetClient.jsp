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
String company=request.getParameter("company");
String id= request.getParameter("id");
System.out.println(">>>>>>>>>>>>>id:"+id);
  sql1="SELECT CustomerCode,CompanyName  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName like ('%"+company+"%') order by CompanyName limit 20 ";
  //out.print(sql1);
 System.out.println("IN LEDGER *(*(*    "+sql1);
  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:120px;width:400px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
 int i=1;
if(request.getParameter("getCompanyName")==null)
 while(rs1.next())
   {
      flag=true;
     if(Integer.parseInt(id)==1)
     {
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
         i++;
     }
     if(Integer.parseInt(id)==2)
     {
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
         i++;
     }
     if(Integer.parseInt(id)==3)
     {
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
         i++;
     }
     if(Integer.parseInt(id)==4)
     {
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
         i++;
     }
     if(Integer.parseInt(id)==5)
     {
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
         i++;
     }
     
   } 
else
	 while(rs1.next())
	   {
	      flag=true;
	      if(Integer.parseInt(id)==1)
	      { 
	        buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+rs1.getString("CompanyName")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
	        i++;
	      }
	      if(Integer.parseInt(id)==2)
	      { 
	        buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+rs1.getString("CompanyName")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
	        i++;
	      }
	      if(Integer.parseInt(id)==3)
	      { 
	        buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+rs1.getString("CompanyName")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
	        i++;
	      }
	      if(Integer.parseInt(id)==4)
	      { 
	        buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+rs1.getString("CompanyName")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
	        i++;
	      }
	      if(Integer.parseInt(id)==5)
	      { 
	        buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs1.getString("CustomerCode")+"\",\""+rs1.getString("CompanyName")+"\",\""+Integer.parseInt(id)+"\");'  style='color: black;'>"+rs1.getString("CompanyName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";
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
