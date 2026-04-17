 <%@page import="java.io.Flushable"%>
 <%@ include file="conn.jsp" %>
<script type="text/javascript">

</Script>

<%!
Connection con1;
%>

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


<% 
session.setAttribute("flag","company");
try 
{
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1 = null;
String sql1 = "";
String newstring = "";
boolean flag = false;
int element = 99; 
String company = request.getParameter("company").replaceAll(" ","");
System.out.println("&&&&&&&*  "+company);
int cnt = 0;

String A = request.getParameter("limitcount");
int limitcnt = 0;
limitcnt = Integer.parseInt(A);
System.out.println("?????"+limitcnt);

int k;
int counter=0;

  System.out.println("IN IF CONDOTIOn");
  
  sql1="( SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('"+company+"%') and IsDataValid='1' and SalesCustomerCode=0  order by CompanyName)"+
	   " union "+

	   "( SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' and SalesCustomerCode=0  order by CompanyName)"+
	   " union "+
	   
	   
	  "(SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode, EMail, IntrestedProduct,MobileNo,ContactPerson,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace(ContactPerson, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' and SalesCustomerCode=0 order by CompanyName )"+
	  " union "+
	
	  "(SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,CustomerCode,SalesCustomerCode,ContactPerson, EMail, IntrestedProduct,CompanyName,WebSite,Replace( Replace( Replace( MobileNo,'.', '') ,' ','') ,'-','') AS com,MobileNo as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where MobileNo like ('%"+company+"%') or TelephoneNo2 like ('%"+company+"%')"+
	  "and IsDataValid='1' and SalesCustomerCode=0 order by CompanyName ) limit 0,"+limitcnt+" ";  

  
    if(limitcnt==0)
    {
	 System.out.println("IN OTHER CONDOTIOn  ");
	sql1="(SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.','') ,' ','') ,'-','') AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('"+company+"%') and IsDataValid='1' and SalesCustomerCode=0 order by CompanyName )"+
	  " union "+

	  "( SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' and SalesCustomerCode=0  order by CompanyName)"+
	   " union "+
	  
	  "(SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,MobileNo,WebSite, Replace(Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','')  AS com,CompanyName as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace( ContactPerson, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1' and SalesCustomerCode=0 order by CompanyName )"+
	  " union "+

	  "(SELECT Address,City,Zip ,State ,Country,Phone ,CustEnteredByRep,Fax,WeeklyOffon,NoOfUnits,SalesCustomerCode,CustomerCode,ContactPerson, EMail, IntrestedProduct,CompanyName,WebSite, Replace( Replace( Replace( MobileNo, '.','') ,' ','') ,'-','') AS com,MobileNo as a  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where MobileNo like ('%"+company+"%') or TelephoneNo2 like ('%"+company+"%')"+
	  "and IsDataValid='1' and SalesCustomerCode=0 order by CompanyName )  limit 0,300";  
	  
	 
    }

    
    
  System.out.println("????"+sql1);
  rs1=stmt1.executeQuery(sql1);
  
  
  
  System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>Query Output Start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  
  
  String rep="",code="",contact="",email="",city="",name="",mobile="",product="",off="",website="",fax="",noofunits="", custType = "";
  
  
  String buffer="<div style='height:100%;width:100%;overflow:auto; align:right;'><table align = 'center' style=' margin: 10px;'>";
  int i=1;
  while(rs1.next())
  {
  newstring =rs1.getString("com");
  String b = rs1.getString("a");
  
  
  try{
	   code = (rs1.getString("CustomerCode") == null || rs1.getString("CustomerCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustomerCode")  ;
	   
	   name = (rs1.getString("a") == null || rs1.getString("a").equalsIgnoreCase("") ) ? "-" : rs1.getString("a")  ;
	
	   }catch(Exception e)
	   {
		   System.out.println(e);
	   }
  
  
  
  flag=true;

  out.print("<input type='hidden' name='PName"+i+"' id='PName"+i+"' value='"+name+"'>");
  out.print("<input type='hidden' name='PCode"+i+"' id='PCode"+i+"' value='"+code+"'>");
  
    
  if(newstring.toLowerCase().contains(company.toLowerCase()))
  {
  buffer+="<tr><td align='left'> <a href='#' onClick='getCustomerDetails1("+i+");'  style='color: black;'>"+rs1.getString("a").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+".</a></td></tr>";
  }
  	
  i++;
  System.out.println("----------------------------------------------------");
  
  } 
   //new element....
   
   
   
  buffer+="<input type='hidden' name='element' id='element' value="+limitcnt+">";
   
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
  //buffer+="</select>";
  // for(int s=0;s>counter;i++)
   		  
  out.println(buffer);
  System.out.println(">>>>>>>>>>>>>>>>>"+buffer);
   
  buffer=null;
  //System.out.println(buffer);
}
catch(Exception e)
{ 
  out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';><tr><td>Please Wait ...</td></tr></table></div>");
}
%>