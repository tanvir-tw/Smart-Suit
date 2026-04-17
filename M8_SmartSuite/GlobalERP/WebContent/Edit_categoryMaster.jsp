<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="header.jsp"%>
    <jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
    

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Category</title>
</head>
<body>
<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType = "";
			String todaysDate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
			String id=request.getParameter("ID");
			System.out.println("ID--->"+id);
	%>
	<%
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				
				String qry="select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingcategory where ID='"+id+"'";
				ResultSet rs=st.executeQuery(qry);
				System.out.println("Queryyyyy-->"+qry);
			
	while(rs.next())
{
  %>

		<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
		
	<a>Edit Category</a> </div>
	<div align="center" style="margin-left: 20%;">
	
	<form name="editcategory" method="post" action="updatecategorydata.jsp?ID=<%=id%>" >
	<div style="width: 50%;" align="center"><div style="float: left;"><a href="categoryMasterReport.jsp">BACK</a></div><div><b><font color="red">All Fields are Compulsory.</font></b></div></div>
	<div style="margin-right:25%; border:3px solid #2aa1cc ;width:50%;height:50%;" align="center">
	<table border="0" cellpadding="3" width="80%" align="center" style="background: white;">
	<tr>
	
	</tr>
	<tr>
	<td align="right">		
					<b>Category Name  : </b></td>
					<td><input type="text" name="category_name" id="category_name" value="<%=rs.getString("Category") %>"  />
</td>
	</tr>
	<tr>
					<td align="right"><b>Limit : </b></td>
					<td  align="left"><input type="text" name="limit" id="limit" value="<%=rs.getString("Limit1") %>" />
					</td>
	</tr>
	<tr>
		<td align="right"><b>Status : </b></td>
		
		<td  align="left"><select name="status" id="status">
		<%
		String stat=rs.getString("Status");
		String statusval="";
		if(stat.equalsIgnoreCase("Deactivate"))
		{
			statusval="Deactive";
		}
		else
		{
			statusval="Active";
		}
		%>
		<option value="<%=rs.getString("Status")%>"><%=statusval %></option>
		<option value="-">Active</option>
		<option value="Deactivate">Deactive</option>
		</select>
		</td>
	</tr>
	

	
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="bottom" align="center" colspan="4">
			<div><input type="submit" id="search-submit"
				name="submitFollowUp" value="Submit" class="formElement" /></div>
			</td>
	</tr>
		
	</table>
	
	<table>
	<tr>
	<th>
	</th>
	</tr>
	</table>
	</div>
	</form>
	</div>
	
			<br><br><br><br><br>
			<%} %>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>

	<%
			} catch (Exception e) {
			}
		conn.close();
	%>
</body>
</html>
</jsp:useBean>