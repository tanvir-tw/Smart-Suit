<%@page import="com.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%
Connection conn = null;
%>
<%
Statement stmt1=null, stmt2=null, stmt3=null;
ConnectionClass connection = new ConnectionClass();
try 
{
	conn = connection.getConnect("db_leaveapplication");
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxContractDelete.jsp>>>>>>>>>>>>>>>>");	
 stmt1 = conn.createStatement();
 stmt2 = conn.createStatement();
 stmt3 = conn.createStatement();

String id=request.getParameter("id");
System.out.println(">>>>>>>>id:"+id);

if(request.getParameter("action").equals("delete"))
{	
	String SqlUpdate="UPDATE t_employee SET Status ='Deactive' WHERE EmpID='"+id+"' limit 1 ";
	System.out.println(">>>>>>>>SqlDeleteMaster:"+SqlUpdate);
	stmt1.executeUpdate(SqlUpdate);
	
	String SqlUpdate1="UPDATE t_leaveadmin SET Status ='No' WHERE EmpID='"+id+"' limit 1 ";
	System.out.println(">>>>>>>>SqlDeleteMaster11:"+SqlUpdate1);
	stmt2.executeUpdate(SqlUpdate1);
	out.println("Yes");
}
} 
catch (Exception e) {
System.out.println("AjaxContractDelete.jsp error  table > "+e);
out.println("NO");
}

%>