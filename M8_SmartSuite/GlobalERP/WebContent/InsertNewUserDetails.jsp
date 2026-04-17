<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.*"%>
<%@page import="com.ConnectionClass"%> 
<%
Connection con=null;
Statement stmt1=null,stmt2=null,stmt21=null,st1=null;
ConnectionClass connection= new ConnectionClass();
try
{
	con = connection.getConnect("db_GlobalERP");
	stmt1 = con.createStatement();
	stmt2= con.createStatement();
	stmt21= con.createStatement();
	st1= con.createStatement();

String subject="",mailid="",adminmail="";

subject=request.getParameter("subject");

mailid=request.getParameter("mailid");

String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());


StringBuffer htmlstring=new StringBuffer("");
HashMap hm=new HashMap(); 
List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
InputStream filecontent=null;
for (FileItem item : items) {
    if (item.isFormField()) {
        // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
        String fieldname = item.getFieldName();
        String fieldvalue = item.getString();
        System.out.println("If   "+fieldname+"--"+fieldvalue);
        hm.put(fieldname, fieldvalue);
    } else {
        // Process form file field (input type="file").
        String fieldname = item.getFieldName();
        String filename = FilenameUtils.getName(item.getName());
        filecontent = item.getInputStream();
        System.out.println("else   "+fieldname+"--"+filename+"---"+filecontent);
        hm.put(fieldname, filename);
    }
}
String Fullname=(String)hm.get("FullName");// request.getParameter("FullName");
String Username=(String)hm.get("UserName");//request.getParameter("UserName");
String Password=(String)hm.get("Password");//request.getParameter("Password");
String Userlevel=(String)hm.get("UserLevel");//request.getParameter("UserLevel");
String Dept=(String)hm.get("Department");//request.getParameter("Department");
String UAL=(String)hm.get("UAL");
System.out.println("UAL=================>"+UAL);
/* String ULAccess=(String)hm.get("UserLevelAccess"); *///request.getParameter("UserLevelAccess");

String ULAccess="1,2,3";

String Empcode=(String)hm.get("EmpCode");//request.getParameter("EmpCode");
String TALevel=(String)hm.get("TALevel");//request.getParameter("TALevel");
String Mobno=(String)hm.get("Mobno");//request.getParameter("Mobno");
String Email=(String)hm.get("emailid");//request.getParameter("emailid");
String Status=(String)hm.get("ActiveStatus");//request.getParameter("ActiveStatus");
String hod=(String)hm.get("hod");//request.getParameter("hod");
String sign=(String)hm.get("sign");//request.getParameter("sign");
System.out.println("sign      "+sign);
String WorkZone=(String)hm.get("Zone");//request.getParameter("Zone");
String State=(String)hm.get("state");//request.getParameter("state");
String City=(String)hm.get("city");//request.getParameter("city");
System.out.println("Zone -----"+WorkZone+">>>>>>>>State:----"+State+"\n>>>>>>>>City:----"+City);
String dotprojectid=(String)hm.get("dotid");//request.getParameter("city");
System.out.println("dotprojectid      "+dotprojectid);
System.out.println("FileContent-----"+filecontent+">>>>>>>>Fullname:"+Fullname+"\n>>>>>>>>Username:"+Username+"\n>>>>>>>>Password:"+Password+"\n>>>>>>>>Userlevel:"+Userlevel+"\n>>>>>>>>Dept:"+Dept+"\n>>>>>>>>ULAccess:"+ULAccess+"\n>>>>>>>>Empcode:"+Empcode+"\n>>>>>>>>TALevel:"+TALevel+"\n>>>>>>>>Mobno:"+Mobno+"\n>>>>>>>>Email:"+Email+"\n"+Status);
String com=session.getAttribute("CompanyMasterID").toString();
String KRAdotprojectid=(String)hm.get("kradotid");
System.out.println(KRAdotprojectid);
String rolenew=(String)hm.get("rolenew");

System.out.println("role new is-------------->here it is :"+rolenew);
String role1="";
 String Role="Select * from db_GlobalERP.UserTypeMaster where UserTypeCode='"+UAL+"' ";
 System.out.println("Role is------------>:"+Role);
 ResultSet rs21=stmt21.executeQuery(Role);
 if(rs21.next())
 {
	 role1=rs21.getString("UserType");
 }
 
 System.out.println("Role is:Please Check"+role1);
 
 if((role1.contains("Admin"))&&(!role1.equals("Admin")))
 {
	 System.out.println("Inside Role is HOD");
	role1="HOD";
 }
 
 else if(role1.equals("HR"))
 {
	 System.out.println("Inside Role HR");
	 role1="HR";
 }
 else
 {
	 System.out.println("Inside Role is - and ADMIN");
	 role1="-";
 }

String select="select * from UserMaster where UserName='"+Username+"'";
ResultSet rs=st1.executeQuery(select);

if(rs.next())
{
	response.sendRedirect("alertGoTo.jsp?msg=User Name already exists &goto=AddNewUser.jsp");
}
else
{
	String Ad="insert into UserMaster(EmpName,UserName,Password,UserLevel,Dept,CompanyCode,EmpCode,TALevel,mobileno,email,ActiveStatus,HodReport,UserTypeCode,companymasterid,WorkZone,State,City,dotprojectid,KRAdotprojectid,Role,Signature)values('"+Fullname+"','"+Username+"','"+Password+"','"+Userlevel+"','"+Dept+"','"+ULAccess+"','"+Empcode+"','"+TALevel+"','"+Mobno+"','"+Email+"','"+Status+"','"+hod+"',"+UAL+",?,'"+WorkZone+"','"+State+"','"+City+"','"+dotprojectid+"','"+KRAdotprojectid+"','"+rolenew+"',?)";
	System.out.println(">>>>>>>>Add:"+Ad);
	PreparedStatement ps=con.prepareStatement(Ad);
	ps.setString(1, com);
	ps.setBinaryStream(2,filecontent);
	int cnt1=ps.executeUpdate();
	String Add="insert into "+session.getAttribute("CompanyMasterID").toString()+"security(EmpName,UserName,Password,UserLevel,Dept,CompanyCode,EmpCode,TALevel,mobileno,email,ActiveStatus,HodReport,Signature)values('"+Fullname+"','"+Username+"','"+Password+"','"+Userlevel+"','"+Dept+"','"+ULAccess+"','"+Empcode+"','"+TALevel+"','"+Mobno+"','"+Email+"','"+Status+"','"+hod+"',?)";
	System.out.println(">>>>>>>>Add:"+Add); 
	PreparedStatement ps1=con.prepareStatement(Add);
	ps1.setString(1, com);
	ps1.setBinaryStream(1,filecontent);
	System.out.println(">>>>>>>>Add:"+Add);
	int cnt=ps1.executeUpdate();
	System.out.println("1");

htmlstring.append("<br><h4 align=center> ERP New User Account Details....  </h4>" +
		"<table align=center border=1 cellpadding=0 cellspacing=0>" +
			"<tr>" +
			"<th><b>User Name</b></th>" +
			"<th><b>Password</b></th>" +
			"<th><b>Email-id</b></th>" +
			"<th><b>Department</b></th>" +
			"<th><b>User Level</b></th></tr>");

System.out.println("2");
htmlstring.append("<tr>"+
	              "<td>"+Username+"</td>"+
	              "<td>"+Password+"</td>"+
	              "<td>"+Email+"</td>"+
	              "<td>"+Dept+"</td>"+
	              "<td>"+Userlevel+"</td></tr></table>");			

System.out.println("3");
String EMPName="test";
System.out.println("4");
String Emailid="select email from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+EMPName+"'";
System.out.println("5");
ResultSet rsEmailid=stmt2.executeQuery(Emailid);
System.out.println("6");
if(rsEmailid.next())
{
	adminmail=rsEmailid.getString("email");
	System.out.println("-------admin name:"+adminmail); 

}
String SqlSendingMail="Insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SendDateTime,SenderName)values('ERP New User Accounts Details','-','Hi, "+Username+","+htmlstring+"<br>Thanks & Regards,<br>Transworld Team','ERP New User Added Details.','"+Email+"','"+adminmail+"','"+todaysDateTime+"','Pending','"+todaysDateTime+"','"+EMPName+"')";
System.out.println(">>>>>>>>SqlSendingMail:"+SqlSendingMail);
stmt1.executeUpdate(SqlSendingMail);
//out.println("#Yes");

String Sendhistory="Insert into "+session.getAttribute("CompanyMasterID").toString()+"Adminhistory(AdminUserName,UserName,UpdatedDateTime,Action,ActiveStatus)values('"+EMPName+"','"+Fullname+"','"+todaysDateTime+"','Add','"+Status+"')";
System.out.println("------------"+Sendhistory);
stmt1.executeUpdate(Sendhistory);
//out.println("#Yes");

 response.sendRedirect("alertGoTo.jsp?msg=User Added Successfully &goto=AdminModule.jsp");
 }
 }
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
}
%>