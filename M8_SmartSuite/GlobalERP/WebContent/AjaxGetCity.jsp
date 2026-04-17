<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>


<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

<% 
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");

Connection conn=null;
Statement st=null;
%>
<% 
try
{
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection("jdbc:mysql://twdb.fleetview.in/db_leaveapplication","erp","1@erp");
conn=DriverManager.getConnection("jdbc:mysql://"+host+"/db_GlobalERP",user,pass);
//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_leaveapplication","erp","1@erp");

ResultSet rst=null;
String sql="";
st=conn.createStatement();
String state = request.getParameter("state");
String country = request.getParameter("country");

//String html = "<option value='Select' selected='selected'>Select</option>";
String html=null;


	sql = "SELECT Distinct(City) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where State='"+state+"'  Order by City asc ";
	//System.out.println("sql:-"+sql);
	rst =st.executeQuery(sql);
	
	while(rst.next())
	{
		html += "<option value='"+rst.getString("City")+"'>"+rst.getString("City")+"</option>";
		System.out.println("html:-"+html);
	
    }
out.println("<option value='Select'>  </option>"+html);

}

catch(Exception e)
{
	e.printStackTrace();
}

%>
</jsp:useBean>