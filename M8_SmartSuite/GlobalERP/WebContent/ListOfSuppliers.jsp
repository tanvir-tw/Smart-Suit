<%@ include file="conn.jsp" %>

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
String sql1="";
boolean flag=false;



String prospect=request.getParameter("prospect");

	
	sql1="( SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName like ('"+prospect+"%')  order by  CompanyName )"+
	  "union"+
	  "(SELECT *  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName like ('%"+prospect+"%')   order by  CompanyName) limit 20";


  rs1=stmt1.executeQuery(sql1);
 String buffer="<div style='height:110px;width:300px;overflow:auto;'><table style='display: block';>";
 int i=1; 
 String rep="",code="",contact="",email="",city="",name="",mobile="",product="",off="",website="",fax="",noofunits;

	   while(rs1.next())
	   {
		   name= (rs1.getString("CompanyName") == null || rs1.getString("CompanyName").equalsIgnoreCase("") ) ? "-" : rs1.getString("CompanyName")  ;
		   buffer+="<tr><td>"+name.replaceAll("(?i)"+prospect,"<font color=blue><u>"+prospect.toUpperCase()+"</u></font>")+".</tr></td>";
			 i++;
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

