<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxEditUser.jsp>>>>>>>>>>>>>>>>");	
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();

ResultSet rs1=null;

String sql1="";

String Buffer="";
String buffer="<div  id='userid' style='height:80px;width:400px;'><table align = 'left' >";
String Empname=request.getParameter("name");
System.out.println(">>>>>Name:"+Empname);
String action =request.getParameter("action");
System.out.println(">>>>>>>action:"+action);
//String Buffer1="Yes"+Buffer;
if(action.contains("search"))
{
	sql1="(SELECT EmpName from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName like ('%"+Empname+"%') order by EmpName )";
	ResultSet rs=stmt1.executeQuery(sql1);
	
	if (!rs.next()) {
	    System.out.println("No records found");
	    buffer +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
	    rs.beforeFirst();
	} else {
    
   do{
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs.getString("EmpName")+"\");'  style='color: black;'>"+rs.getString("EmpName").replaceAll("(?i)"+Empname,"<font color=blue><u>"+Empname.toUpperCase()+"</u></font>")+".</a></tr></td>";
    }while(rs.next());
    
	}
    buffer+="</table></div>";
    out.println(buffer);
    System.out.println("><><><><   ????????"+sql1);
}else if(action.contains("hod"))
{
	sql1="(SELECT EmpName from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName like ('%"+Empname+"%') order by EmpName )";
	ResultSet rs=stmt1.executeQuery(sql1);
	if (!rs.next()) {
	    System.out.println("No records found");
	    buffer +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
	    rs.beforeFirst();
	} else {
    
    do{
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetailsHod(\""+rs.getString("EmpName")+"\");'  style='color: black;'>"+rs.getString("EmpName").replaceAll("(?i)"+Empname,"<font color=blue><u>"+Empname.toUpperCase()+"</u></font>")+".</a></tr></td>";
    }while(rs.next());
    
	}
    buffer+="</table></div>";
    out.println(buffer);
    System.out.println("><><><><   ????????"+sql1);
	
}else
{
	String select="select * from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+Empname+"'";
	System.out.println(">>>>>>>>select:"+select);
	ResultSet rs= stmt1.executeQuery(select);
	while(rs.next())
	{
		Buffer="ZZ"+rs.getString("UserName");
		Buffer+="ZZ"+rs.getString("UserLevel");
		Buffer+="ZZ"+rs.getString("Dept");
		Buffer+="ZZ"+rs.getString("CompanyCode");
		Buffer+="ZZ"+rs.getString("EmpCode");
		Buffer+="ZZ"+rs.getString("TALevel");
		Buffer+="ZZ"+rs.getString("mobileno");
		Buffer+="ZZ"+rs.getString("email");
		Buffer+="ZZ"+rs.getString("ActiveStatus");
		Buffer+="ZZ"+rs.getString("HodReport");
		System.out.println("-------Buffer:"+Buffer);
	}
	//String Buffer1="Yes"+Buffer;
	out.println("Yes"+Buffer);
}
//newstring="select replace('sql1',' ','')";	
//out.println("Yes"+Buffer);





}
catch(Exception e)
{
	System.out.println("Exception e:"+e);
}
%>