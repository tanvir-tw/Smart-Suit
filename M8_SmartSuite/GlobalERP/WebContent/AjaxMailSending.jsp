<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
Connection con1 = null;
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxMailSending.jsp>>>>>>>>>>>>>>>>");	
String subject="",mailid="",htmlstring1="";
subject=request.getParameter("subject");
//System.out.println(">>>>>>subject:"+subject);
mailid=request.getParameter("mailid");
//System.out.println(">>>>>>mailid:"+mailid);
htmlstring1=request.getParameter("htmlstring1");
//System.out.println(">>>>>>htmlstring:"+htmlstring1);
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
Statement stmt1 = con1.createStatement();
Statement stmt2 = con1.createStatement();
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String EMPName=session.getAttribute("EmpName").toString();
String SqlSendingMail="Insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,EntryDateTime,MailStatus,SendDateTime,SenderName)values('Marketing Mail','-','Sir/Mam,"+htmlstring1+"<br>Thanks & Regards,<br>Transworld Team','"+subject+"','"+mailid+"','"+todaysDateTime+"','Pending','"+todaysDateTime+"','"+EMPName+"')";
System.out.println(">>>>>>>>SqlSendingMail:"+SqlSendingMail);
stmt1.executeUpdate(SqlSendingMail);
out.println("#Yes");
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>>>Exception in Mail Sending:"+e);
	out.println("#No");
	System.out.println("\n>>>>>$$$$$$$$$$$$$>>>End of AjaxMailSending.jsp>>>>>>>>>>>>>>>>");
}
%>