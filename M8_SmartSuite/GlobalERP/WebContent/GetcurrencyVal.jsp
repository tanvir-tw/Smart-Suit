 <%@ include file="conn.jsp" %>
 <%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>

<%@page import="java.util.Date"%>

<%!
Connection con;
%>
<% 
try
{
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st=con.createStatement();
		
		Statement st2=con.createStatement();

	String type=request.getParameter("type");
	String typeval="",symbol="";
	String buffer="";
		int i=1;
		
		String sql="select CurrencyValue,CurrencySymbol FROM  "+session.getAttribute("CompanyMasterID").toString()+"currencydet where CurrencyType like '%"+type+"%'";
		System.out.println("***    "+sql);
			
			ResultSet rs = st.executeQuery(sql);
			if(rs.next())
			{
				
				typeval=rs.getString("CurrencyValue");	
				symbol=rs.getString("CurrencySymbol");
			}
		
		
		
		buffer=typeval+"~"+symbol;
		
		
	out.print(buffer);	
		
		
		
		
}	
catch(Exception e)
{
	out.print("#noting");
}
finally
{
	con.close();
}

%>

