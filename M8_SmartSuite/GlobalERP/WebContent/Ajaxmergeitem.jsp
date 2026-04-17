<%@page import="java.io.Flushable" import="java.util.Date"%>
<%@ include file="conn.jsp" %>
<script type="text/javascript">

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
  
  sql1="(SELECT groupcode,GroupName,makecode,ItemCode,PartNo,Price,pricedate,Replace(Description,' ','') AS com,Description as a from "+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where Replace(Description,' ','') like ('"+company+"%') and Newgroupcode is null  order by ItemCode)"+
  " union "+

  "(SELECT groupcode,GroupName,makecode,ItemCode,PartNo,Price,pricedate,Replace(Model,' ','') AS com,Model as a from "+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where Replace(Model,' ','') like ('%"+company+"%') and Newgroupcode is null order by ItemCode)"+
  " union "+
  

 "(SELECT groupcode,GroupName,makecode,ItemCode,PartNo,Price,pricedate,Replace(makename,' ', '') AS com,makename as a from "+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where Replace(makename,' ', '') like ('%"+company+"%') and Newgroupcode is null "+
 " order by ItemCode) limit 0,"+limitcnt+" ";   

  
    if(limitcnt==0)
    {
	 System.out.println("IN OTHER CONDOTIOn  ");
	sql1="(SELECT groupcode,GroupName,makecode,ItemCode,PartNo,Price,pricedate,Replace(Description,' ','') AS com,Description as a from "+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where Replace(Description,' ','') like ('"+company+"%') and Newgroupcode is null  order by ItemCode)"+
	  " union "+

	  "(SELECT groupcode,GroupName,makecode,ItemCode,PartNo,Price,pricedate,Replace(Model,' ','') AS com,Model as a from "+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where Replace(Model,' ','') like ('%"+company+"%') and Newgroupcode is null order by ItemCode)"+
	  " union "+
	  

	 "(SELECT groupcode,GroupName,makecode,ItemCode,PartNo,Price,pricedate,Replace(makename,' ','') AS com,makename as a from "+session.getAttribute("CompanyMasterID").toString()+"searchitemstest where Replace(makename,' ', '') like ('%"+company+"%') and Newgroupcode is null "+
	 " order by ItemCode) limit 0,300";  
	  
	 
    }

  System.out.println("?????"+sql1);
  rs1=stmt1.executeQuery(sql1);
  
  
  System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>Query Output Start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  
  

  String buffer="<div style='height:100%;width:100%;overflow:auto; align:right;'><table align = 'left' border='0' style='margin:10px';><th></th><th align='left'>Search Item</th><th align='center'>GroupCode</th><th align='center'>GroupName</th><th align='center'>MakeCode</th>"+
  "<th align='center'>ItemCode</th><th align='center'>PartNo</th><th align='center'>Price</th></tr>+";
  int i=1;
  while(rs1.next())
  {
	  System.out.println("--------In while loop-----------");
  newstring =rs1.getString("com");
  String b=rs1.getString("a");
  System.out.println("--------In while newstring-----------"+newstring);
  System.out.println("--------In while b-----------"+b);


  flag=true;
  //    String s=company;
  
  
    
  System.out.println("-------------------------------------------aaaaaaa---------" +rs1.getString("a"));

  System.out.println("--------In while b-----------"+b);
  System.out.println("--------In while b-----------"+rs1.getString("groupcode"));
  System.out.println("--------In while b-----------"+rs1.getString("GroupName"));
  System.out.println("--------In while b-----------"+rs1.getString("makecode"));
  System.out.println("--------In while b-----------"+rs1.getString("ItemCode"));
  System.out.println("--------In while b-----------"+rs1.getString("PartNo"));
  System.out.println("--------In while b-----------"+rs1.getString("Price"));




  
  
  
  
    
  if(newstring.toLowerCase().contains(company.toLowerCase()))
  {
  buffer+="<tr><td align='left'><input  name='chkbx' id='ab"+i+"' type='checkbox' value='"+rs1.getString("a")+"~"+rs1.getString("groupcode")+"~"+rs1.getString("GroupName")+"~"+rs1.getString("makecode")+"~"+rs1.getString("ItemCode")+"~"+rs1.getString("PartNo")+"~"+rs1.getString("Price")+"' /></td><td>"+rs1.getString("a").replaceAll("(?i)"+company,"<font color=blue><u>"+company.toUpperCase()+"</u></font>")+"</td><td>"+rs1.getString("groupcode")+"<td>"+rs1.getString("GroupName")+"</td><td>"+rs1.getString("makecode")+"</td><td>"+rs1.getString("ItemCode")+"</td><td>"+rs1.getString("PartNo")+"</td><td>"+rs1.getString("Price")+"</td></tr>";
  }
 
  i++;
  System.out.println("----------------------------------------------------");
  System.out.println(buffer);

  } 
  
  
   //new element
   
   
  buffer+="<input type='hidden' name='element' id='element' value="+limitcnt+">";
  buffer+="<input type='hidden' name='item1' id='item1' value="+i+">"; 

   
   if(limitcnt!=0)
  { 
   	   buffer+="<tr><td align='left'><h5><a href='#' onclick='getCompanies1();' >more..</a></h5></td></tr>";
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
  System.out.println(buffer);
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