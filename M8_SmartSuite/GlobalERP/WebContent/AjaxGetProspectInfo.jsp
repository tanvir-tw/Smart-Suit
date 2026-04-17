 <%@page import="java.io.Flushable"%>
 <%@ include file="conn.jsp" %>
<script type="text/javascript">

</Script>
<%!
Connection con1;
%>

<% 
session.setAttribute("flag","customer");
try {
	

Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement stmt1=con1.createStatement();

ResultSet rs1=null;
String sql1="",newstring="";
boolean flag=false;

String A=request.getParameter("limitcount");
System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     "+A);
int limitcnt=0;
limitcnt=Integer.parseInt(A);
System.out.println("><><><><   ????????"+limitcnt);


String prospect=request.getParameter("prospect").replace(" ","").replace(".","");
System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&77"+prospect);
System.out.println(">>>>>>>>>>>>>>>  >>>>>>>>>>>>>>>>>>>   "+request.getParameter("displayList"));

/*if(request.getParameter("displayList")!=null)
	
  sql1="( SELECT Address ,CustomerCode,City,Zip ,State ,Country ,ContactPerson ,CustEnteredByRep,Phone ,Fax ,EMail ,IntrestedProduct,MobileNo,WeeklyOffon,WebSite,NoOfUnits,Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') like ('"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName )"+
	  "union"+
	  "(SELECT Address,CustomerCode ,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax ,IntrestedProduct, MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') like ('%"+prospect+"%') and SalesCustomerCode=0  order by  CompanyName) limit 20";

else  */
  sql1="( SELECT Address,CustomerCode ,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax, IntrestedProduct ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') like ('"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName )"+
  "union"+

  "(SELECT Address,CustomerCode ,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax,IntrestedProduct  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') like ('%"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName)"+
   " union "+

  "(SELECT Address ,CustomerCode,City,Zip ,State ,Country , ContactPerson,Phone ,CustEnteredByRep,Fax,IntrestedProduct  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where ContactPerson  like ('%"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName)   "+
  " union "+

  "(SELECT Address ,CustomerCode,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax,IntrestedProduct  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace( Replace( Replace (CompanyName ,' ',''),'.',''),'-','') AS com, CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where MobileNo  like ('%"+prospect+"%') or Phone like ('%"+prospect+"%')  "+
	" and SalesCustomerCode=0 order by  CompanyName) limit 0,"+limitcnt+""; 

  
  if(limitcnt==0)
{
	System.out.println("IN OTHER LOOP   (((*** N     ");
	sql1="( SELECT Address ,IntrestedProduct,CustomerCode,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace(Replace(Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') like ('"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName )"+
	  "union"+

	  "(SELECT Address ,IntrestedProduct,CustomerCode,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace(Replace(Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where  Replace( Replace( Replace (CompanyName,' ',''),'.',''),'-','') like ('%"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName)"+
	   " union "+

	  "(SELECT Address,IntrestedProduct ,CustomerCode,City,Zip ,State ,Country ,ContactPerson,Phone ,CustEnteredByRep,Fax  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace(Replace(Replace (CompanyName,' ',''),'.',''),'-','') AS com, CompanyName as b  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where ContactPerson like ('%"+prospect+"%') and SalesCustomerCode=0 order by  CompanyName)   "+
	  " union "+

	  "(SELECT Address ,IntrestedProduct,CustomerCode,City,Zip ,State ,Country ,ContactPerson ,Phone ,CustEnteredByRep,Fax  ,MobileNo,WeeklyOffon,WebSite,NoOfUnits,EMail,Replace(Replace(Replace (CompanyName,' ',''),'.',''),'-','') AS com,CompanyName as b from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where MobileNo like ('%"+prospect+"%') or Phone like ('%"+prospect+"%')  "+
		" and SalesCustomerCode=0 order by  CompanyName) limit 0,500 "; 
	
}
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> "+sql1);
  rs1=stmt1.executeQuery(sql1);
  System.out.println("__________________________________________---");
 String buffer="<div style='height:110px;width:300px;overflow:auto;'><table style='display: block';>";
 int i=1; 
 String rep="",code="",contact="",email="",city="",name="",mobile="",product="",off="",website="",fax="",noofunits="";
 /*if(request.getParameter("displayList")!=null)
 {
	   while(rs1.next())
	   {
		   System.out.println("IN WHILE   ");
		   name= (rs1.getString("com") == null || rs1.getString("com").equalsIgnoreCase("") ) ? "-" : rs1.getString("com")  ;
		 System.out.println(name);
		   buffer+="<tr><td>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</tr></td>";
			 i++;
	   } 
 } */

 //else
// {
   System.out.println("IN LSE      ");
   while(rs1.next())
   {
	   newstring = rs1.getString("com");
	   System.out.println("NEW STRING     "+newstring);
	   String b=rs1.getString("b");
	   System.out.println("BBBBBBBBBBBBB    "+b);
	   

	   System.out.println("IN HWILE     ");
	   try{
	   rep= (rs1.getString("CustEnteredByRep") == null || rs1.getString("CustEnteredByRep").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustEnteredByRep")  ;
	   code= (rs1.getString("CustomerCode") == null || rs1.getString("CustomerCode").equalsIgnoreCase("") ) ? "-" : rs1.getString("CustomerCode")  ;
	   contact= (rs1.getString("ContactPerson") == null || rs1.getString("ContactPerson").equalsIgnoreCase("") ) ? "-" : rs1.getString("ContactPerson")  ;
	   email= (rs1.getString("EMail") == null || rs1.getString("EMail").equalsIgnoreCase("") ) ? "-" : rs1.getString("EMail")  ;
	   city= (rs1.getString("City") == null || rs1.getString("City").equalsIgnoreCase("") ) ? "-" : rs1.getString("City")  ;
	   name= (rs1.getString("b") == null || rs1.getString("b").equalsIgnoreCase("") ) ? "-" : rs1.getString("b")  ;
	   mobile= (rs1.getString("MobileNo") == null || rs1.getString("MobileNo").equalsIgnoreCase("") ) ? "-" : rs1.getString("MobileNo")  ;
	   product= (rs1.getString("IntrestedProduct") == null || rs1.getString("IntrestedProduct").equalsIgnoreCase("") ) ? "-" : rs1.getString("IntrestedProduct")  ;
	   off= (rs1.getString("WeeklyOffon") == null || rs1.getString("WeeklyOffon").equalsIgnoreCase("") ) ? "-" : rs1.getString("WeeklyOffon")  ;
	   website= (rs1.getString("WebSite") == null || rs1.getString("WebSite").equalsIgnoreCase("") ) ? "-" : rs1.getString("WebSite")  ;
	   fax= (rs1.getString("Fax") == null || rs1.getString("Fax").equalsIgnoreCase("") ) ? "-" : rs1.getString("fax")  ;
	   noofunits= (rs1.getString("NoOfUnits") == null || rs1.getString("NoOfUnits").equalsIgnoreCase("") ) ? "-" : rs1.getString("NoOfUnits")  ;
	   System.out.println("NO OF UNITS ARE    ********  * "+noofunits);
	   }catch(Exception e)
	   {
		   System.out.println(e);
	   }
	   flag=true;
  //    String s=prospect;
  System.out.println("******************************  * ");
    
  out.print("<input type='hidden' name='pRepName"+i+"' id='pRepName"+i+"' value='"+rep+"'>");
  out.print("<input type='hidden' name='pCode"+i+"' id='pCode"+i+"' value='"+code+"'>");
  out.print("<input type='hidden' name='pContactPerson"+i+"' id='pContactPerson"+i+"' value='"+contact+"'>");
  out.print("<input type='hidden' name='pEmail"+i+"' id='pEmail"+i+"' value='"+email+"'>");
  out.print("<input type='hidden' name='pCity"+i+"' id='pCity"+i+"' value='"+city+"'>");
  out.print("<input type='hidden' name='pCompanyName"+i+"' id='pCompanyName"+i+"' value='"+b+"'>");
  out.print("<input type='hidden' name='pMobileNo"+i+"' id='pMobileNo"+i+"' value='"+mobile+"'>");
  out.print("<input type='hidden' name='pIntrestedProduct"+i+"' id='pIntrestedProduct"+i+"' value='"+product+"'>");
  out.print("<input type='hidden' name='pWeeklyOff"+i+"' id='pWeeklyOff"+i+"' value='"+off+"'>");
  out.print("<input type='hidden' name='pWebSite"+i+"' id='pWebSite"+i+"' value='"+website+"'>");
  out.print("<input type='hidden' name='pFax"+i+"' id='pFax"+i+"' value='"+fax+"'>");
  out.print("<input type='hidden' name='pNoOfUnits"+i+"' id='pNoOfUnits"+i+"' value='"+noofunits+"'>");
  

    if(newstring.toLowerCase().contains(prospect.toLowerCase())) 
	     buffer+="<tr><td><a href='#' onClick='getProspectDetails("+i+");'  style='color: blue;'>"+rs1.getString("b").replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</a></tr></td>";
	else if(contact.toLowerCase().contains(prospect.toLowerCase()))
		 buffer+="<tr><td><a href='#' onClick='getProspectDetails("+i+");'  style='color: blue;'>"+contact.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+"-> <u>"+rs1.getString("com")+"</u>.</a></tr></td>";
	else if(mobile.contains(prospect))
	{  
		if(name.equals("-"))
			name=contact;
		 buffer+="<tr><td><a href='#' onClick='getProspectDetails("+i+");'  style='color: blue;'>"+mobile.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+"-> <u>"+rs1.getString("CompanyName")+".</u></a></tr></td>";
	}
	 		  
        i++;
   }
   
// }
   
 buffer+="<input type='hidden' name='element' id='element' value="+limitcnt+">";
 
 if(limitcnt!=0)
 { 
	 System.out.println("IN IF OF LIMIT  ");
	   buffer+="<tr><td align='right'><h3><a href='#' onclick='getProspectes();' >more..</a></h3></td></tr>";
 }else{  
	   System.out.println("BUFFER HAS TO GO BLANK>>>>>>>>>>>>> .  ");
	   buffer+="<tr><td></td></tr>";
	      
 }
 
 buffer+="</table></div>";
out.println(buffer+"</select>");
//System.out.println(buffer);

} catch(Exception e) {  //out.println(e);
	out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';></table></div>");
//e.printStackTrace();
}
finally
{
	con1.close();
}

%>
