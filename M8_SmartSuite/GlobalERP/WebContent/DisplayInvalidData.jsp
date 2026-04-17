<%@ include file="header.jsp" %> 

    <%@page import="com.erp.beans.DisplayData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<br></br>
<table border=1  class="sortable">

<% 
//String fileFormat=session.getAttribute("FileFormat").toString();
//out.println(fileFormat);

try{
ArrayList<DisplayData> displist = (ArrayList<DisplayData>)request.getAttribute("InvalidList");

out.println(displist+"displist");
//out.println(displist.isEmpty());
if(displist.isEmpty()!=true)
{
	
	out.println("<font size='3'>"+"Columns Not Inserted into Database due to Error in Column values"+"</font>");
	%>
	<tr>
<th>ProspCustCode</th><th>SalesCustCode</th><th>Date</th><th>Status</th><th>FollowupType</th><th>FollowUpInOut</th><th>Comments</th>
<th>NextFollowUpDate</th><th>MarketingRepCode</th><th>ProspCustName</th><th>PaymentFollowup</th></tr>
	<%
	
Object display[]=displist.toArray();
int i=displist.size();
for(int j=0;j<i;j++)
{
DisplayData row=(DisplayData)display[j];

%>
<tr>

<Td><%=row.getProspCustCode()%></Td>
<Td><%=row.getSalesCustCode()%></Td>
<Td><%=row.getDate()%></Td>

<Td><%=row.getStatus()%></Td>
<Td><%=row.getFollowupType()%></Td>
<Td><%=row.getFollowUpInOut()%></Td>
<Td><%=row.getComments()%></Td>
<Td><%=row.getNextFollowUpDate()%></Td>

<Td><%=row.getMarketingRepCode()%></Td>
<Td><%=row.getProspCustName()%></Td>
<Td><%=row.getPaymentFollowup()%></Td>
</tr>

<%

}
}
else if(displist.isEmpty()!=false){
	
	out.println("Record Inserted Successfully......");
	//request.sendRedirect("alertGoTo.jsp?msg=FOLLOW UPS ARE SUCCESSFULLY INSERTED.&goto=home.jsp");	
}
}catch(Exception e)
{
	e.printStackTrace();
}
%>

</table>
</body>
</html>