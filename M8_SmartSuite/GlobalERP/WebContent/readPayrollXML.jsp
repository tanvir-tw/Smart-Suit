
<%@page import="java.sql.*"%>

<%! 
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");
Connection conn=null;
%>
<%
String DB_Driver="com.mysql.cj.jdbc.Driver";
/*String DB_NAME="jdbc:mysql://192.168.2.55:3306/twsql_twalldata";*/
//String DB_NAME="jdbc:mysql://202.65.131.44:3306/twsql_twalldata";
String DB_NAME="jdbc:mysql://"+host+"/twsql_twalldata";
String DB_USERNAME=user;
String DB_PASSWORD=pass;
Class.forName(DB_Driver);
conn=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
String max_sql="select MAX(SrNo) from t_payrollXML";
System.out.println(max_sql);
Statement st_max=conn.createStatement();
ResultSet rs_max=st_max.executeQuery(max_sql);
String max="";
if(rs_max.next()){
	max=rs_max.getString(1);
	System.out.println("Max No is "+max);
}
int max_int=Integer.parseInt(max);
System.out.println("Max No is "+max_int);
%>
