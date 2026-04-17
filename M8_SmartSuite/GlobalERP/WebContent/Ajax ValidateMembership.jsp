
    <%@include file="PostgressConn.jsp" %>
    <%@page import="java.sql.*"  %>

<%!
Connection conn1;
Statement stmt1,stmt2;
%>
<%

int userid = Integer.parseInt(request.getParameter("userid"));
int projectid = Integer.parseInt(request.getParameter("projectid"));
boolean status = false;
String reason="-";
String projname="";

try{
	conn1=DriverManager.getConnection(postgresString,postgresUser,postgresPass); //postgresql
	 
	stmt1 = conn1.createStatement(); //all postgres queries
	stmt2 = conn1.createStatement(); //all postgres queries
	
	String sql1="select * from projects where id='"+projectid+"'";
	System.out.println(sql1);
	ResultSet rs1 = stmt2.executeQuery(sql1);
	if(rs1.next()){
		
		projname = rs1.getString("name");
		
		String sql = "select * from members where project_id='"+projectid+"' and user_id='"+userid+"'";
		System.out.println(sql);
		ResultSet rs = stmt1.executeQuery(sql);
		if(rs.next()){
			 status = true;
		}else{
			status = false;
			reason = "User Not A Member of Project ="+projname+" bearing id="+projectid+"";
			
		}
	
	}else{
		status = false;
		reason = "Invalid ProjectId";
	}
	
	
	
	
}catch(Exception ex){
	ex.printStackTrace();
}

out.println(status+"#"+reason);

%>
