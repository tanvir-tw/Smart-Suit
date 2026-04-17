<%@page import="com.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%
Connection conn = null;
Statement stmt1 =null;
ResultSet rs1=null;
ConnectionClass connection = new ConnectionClass();
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxEditUser.jsp>>>>>>>>>>>>>>>>");	
conn = connection.getConnect("db_leaveapplication");
stmt1 = conn.createStatement();

String sql1="";

String Buffer="";
String buffer="<div  id='userid' style='height:80px;width:250px;'><table align = 'left' >";
String Empname=request.getParameter("name").replaceAll(" ","");
System.out.println(">>>>>Name:"+Empname);
Empname=Empname.replace(".","");
Empname=Empname.replace(" ","");
Empname=Empname.replace("-","");
Empname=Empname.replace("_","");
String action =request.getParameter("action");
System.out.println(">>>>>>>action:"+action);
if(action.contains("search"))
{
	sql1="(SELECT Name,EmpID from t_leaveadmin where Replace( Replace( Replace( Name, '.', '') , ' ', '') , '-', '') like ('%"+Empname+"%') order by Name )";
	ResultSet rs=stmt1.executeQuery(sql1);
	
	if (!rs.next()) {
	    System.out.println("No records found");
	    buffer +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
	    rs.beforeFirst();
	} else {
    
   do{
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetails(\""+rs.getString("Name")+"\",\""+rs.getString("EmpID")+"\");'  style='color: black;'>"+rs.getString("Name").replaceAll("(?i)"+Empname,"<font color=blue><u>"+Empname.toUpperCase()+"</u></font>")+".</a></tr></td>";
    }while(rs.next());
    
	}
    buffer+="</table></div>";
    out.println(buffer);
    System.out.println("><><><><   ????????"+sql1);
}else if(action.contains("hod"))
{
    System.out.println("action hod condition");

	sql1="SELECT Name,EmpID from t_leaveadmin where Replace( Replace( Replace( Name, '.', '') , ' ', '') , '-', '') like ('%"+Empname+"%') and Status='Yes' order by Name";
    System.out.println("hod sql1........."+sql1);

	ResultSet rs=stmt1.executeQuery(sql1);
	if (!rs.next()) {
	    System.out.println("No records found");
	    buffer +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
	    rs.beforeFirst();
	} else {
    
    do{
    	 buffer+="<tr><td><a href='#' onClick='showVisitingCardDetailsHod(\""+rs.getString("Name")+"\",\""+rs.getString("EmpID")+"\");'  style='color: black;'>"+rs.getString("Name").replaceAll("(?i)"+Empname,"<font color=blue><u>"+Empname.toUpperCase()+"</u></font>")+".</a></tr></td>";
    }while(rs.next());
    
	}
    buffer+="</table></div>";
    out.println(buffer);
    System.out.println("><><><><   ????????"+sql1);
	
}else
{
	String select="select * from t_leaveadmin where Name='"+Empname+"'";
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
	out.println("Yes"+Buffer);
}
}
catch(Exception e)
{
	System.out.println("Exception e:"+e);
}
%>