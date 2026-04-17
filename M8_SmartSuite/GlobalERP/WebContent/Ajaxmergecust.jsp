<%@page import="java.io.Flushable" import="java.util.Date"%>
<%@ include file="conn.jsp" %>
<script type="text/javascript">
function validate()
{
	var a=document.getElementById("cName").value;
	alert(a);
}

function timer()
{
window.setInterval("",3000);
}
</Script>
<%!
Connection con1;
%>

<% 
session.setAttribute("flag","company");
try 
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
String newstring="";
boolean flag=false;
int element=99; 
String company=request.getParameter("company").replaceAll(" ","");
System.out.println("*&&&&&&&&&&&******&&&&&&&&&&&&*  "+company);
int cnt=0;

String A=request.getParameter("limitcount");
int limitcnt=0;
limitcnt=Integer.parseInt(A);
System.out.println("><><><><   ????????"+limitcnt);

int k;
int counter=0;

  System.out.println("IN IF CONDOTIOn   ");
  
  sql1="( SELECT TWEmpName,CustomerCode,ContactPerson,BranchName, EMail,BillingCity,BillingFax, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('"+company+"%') and IsDataValid='1'  order by CompanyName)"+
	   " union "+

	   "( SELECT TWEmpName,CustomerCode,ContactPerson, BranchName, EMail,BillingCity,BillingFax, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1'  order by CompanyName)"+
	   " union "+
	   
	   
	  "(SELECT TWEmpName,CustomerCode, BranchName, EMail,BillingCity,BillingFax, IntrestedProduct,MobileNo,ContactPerson,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace( Replace( Replace(ContactPerson, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+
	  " union "+
	
	  "(SELECT TWEmpName,CustomerCode,ContactPerson,BranchName,  EMail,BillingCity,BillingFax, IntrestedProduct,CompanyName,WebSite,Replace( Replace( Replace( MobileNo,'.', '') ,' ','') ,'-','') AS com,MobileNo as a from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where MobileNo like ('%"+company+"%') or TelephoneNo2 like ('%"+company+"%')"+
	  " and IsDataValid='1' order by CompanyName ) limit 0,"+limitcnt+" ";  

  
    if(limitcnt==0)
    {
	 System.out.println("IN OTHER CONDOTIOn  ");
	sql1="(SELECT TWEmpName,CustomerCode,ContactPerson,BranchName,  EMail,BillingCity,BillingFax, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.','') ,' ','') ,'-','') AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('"+company+"%') and IsDataValid='1' order by CompanyName )"+
	  " union "+

	  "( SELECT TWEmpName,CustomerCode,ContactPerson,BranchName,  EMail,BillingCity,BillingFax, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1'  order by CompanyName)"+
	   " union "+
	  
	  "(SELECT TWEmpName,CustomerCode,ContactPerson,BranchName,  EMail,BillingCity,BillingFax, IntrestedProduct,MobileNo,WebSite, Replace(Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','')  AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where Replace( Replace( Replace( ContactPerson, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' order by CompanyName )"+
	  " union "+

	  "(SELECT TWEmpName,CustomerCode,ContactPerson,BranchName,  EMail,BillingCity,BillingFax, IntrestedProduct,CompanyName,WebSite, Replace( Replace( Replace( MobileNo, '.','') ,' ','') ,'-','') AS com,MobileNo as a  from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where MobileNo like ('%"+company+"%') or TelephoneNo2 like ('%"+company+"%')"+
	  "and IsDataValid='1' order by CompanyName )  limit 0,300";  
	  
	 
    }

  System.out.println("?????"+sql1);
  rs1=stmt1.executeQuery(sql1);
  
  
  System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>Query Output Start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  
  

  String buffer="<div style='height:100%;width:100%;overflow:auto; align:right;'><table align = 'center' style=' margin: 10px;'>";
  int i=1;
  while(rs1.next())
  {
  newstring =rs1.getString("com");
  String b=rs1.getString("a");
  flag=true;
  //    String s=company;
  out.print("<input type='hidden' name='cName"+i+"' id='cName"+i+"' value='"+rs1.getString("a")+"'>");
  out.print("<input type='hidden' name='cCode"+i+"' id='cCode"+i+"' value='"+rs1.getString("CustomerCode")+"'>");
  
  
  
    
  if(newstring.toLowerCase().contains(company.toLowerCase()))
	  buffer+="<tr><td align='left'><input  name='chkbx' id='ab"+i+"' type='checkbox' value='"+rs1.getString("a")+"*"+rs1.getString("CustomerCode")+"' /><a href='#'  style='color: black;'>"+rs1.getString("a").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"->"+rs1.getString("contactperson").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"->"+rs1.getString("BranchName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></tr></td>";

 
  	else if(rs1.getString("ContactPerson").toLowerCase().contains(company.toLowerCase()))
  	{
  		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
  		buffer+="<tr><td align='left'><input  name='chkbx' id='ab"+i+"' type='checkbox' value='"+rs1.getString("a")+"*"+rs1.getString("CustomerCode")+"' /><a href='#'  style='color: black;'>"+rs1.getString("ContactPerson").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"->"+rs1.getString("BranchName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"-> <u>"+newstring+"</u>.</a></tr></td>";

  	}
  	 else if(rs1.getString("MobileNo").contains(company))
   	 buffer+="<tr><td align='left'><input  name='chkbx' id='ab"+i+"' type='checkbox' value='"+rs1.getString("a")+"*"+rs1.getString("CustomerCode")+"' /><a href='#' style='color: black;'>"+rs1.getString("MobileNo").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"->"+rs1.getString("BranchName").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"-> <u>"+rs1.getString("CompanyName")+".</u></a></tr></td>";
   	 
  i++;
  System.out.println("----------------------------------------------------");
  
  } 
  
  
   //new element
   
   
  buffer+="<input type='hidden' name='element' id='element' value="+limitcnt+">";
  buffer+="<input type='hidden' name='item1' id='item1' value="+i+">"; 

   
   if(limitcnt!=0)
  { 
   	   buffer+="<tr><td align='left'><h5><a href='#' onclick='getCompanies();' >more..</a></h5></td></tr>";
  }
   else
  {  
   	   System.out.println("BUFFER HAS TO GO BLANK>>>>>>>>>>>>> .  ");
   	   buffer+="<tr><td></td></tr>";
  }
    	      
  buffer+="</table></div>";
  buffer+="</select>";
  // for(int s=0;s>counter;i++)
   		  
  out.println(buffer);
   
  buffer=null;
  //System.out.println(buffer);
}
catch(Exception e)
{ 
  out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';></table></div>");
}
finally
{
  con1.close();
}
%>