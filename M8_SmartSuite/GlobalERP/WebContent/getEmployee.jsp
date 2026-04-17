<%@ include file="headConn.jsp"%>
<%
String tr,sql,email;
Statement st,st1,st2;
%>

<%
try
	{ 
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	tr=request.getParameter("deptName");
	System.out.println("#################"+tr+"###############");
	if(tr.equals("All"))
	{
		sql="select distinct(Name) as EmpName from t_leaveadmin where Status='Yes' order by EmpName asc";
	}
	else
	{
		sql="select distinct(Name) as EmpName from t_leaveadmin where TypeValue like '"+tr+"' and Status='Yes' order by EmpName asc";		
	}
	System.out.println(sql);
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	 { %>
<option value="<%=rst.getString("EmpName") %>">
	<%=rst.getString("EmpName") %>
</option>
<%  }

}catch(Exception e)
{
	out.print("Exception--->"+e);
}
finally
{
	conn.close();
}

%>
