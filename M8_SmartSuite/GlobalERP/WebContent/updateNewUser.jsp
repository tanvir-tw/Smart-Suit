<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
try
{
Class.forName(DB_Driver);
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=null;
st1=con.createStatement();

Statement st2=con.createStatement();


Statement stmt1 = con.createStatement();
Statement stmt2= con.createStatement();

String subject="",mailid="",adminmail="";

subject=request.getParameter("subject");

mailid=request.getParameter("mailid");

String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());


StringBuffer htmlstring=new StringBuffer("");

HashMap hm=new HashMap(); 
List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
InputStream filecontent=null;
InputStream filecontent1=null;
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
        filecontent1=item.getInputStream();
        System.out.println("else   "+fieldname+"--"+filename+"---"+filecontent);
        hm.put(fieldname, filename);
    }
}



String rolenew=(String)hm.get("rolenew");

System.out.println("rolenew============================>"+rolenew);

String Selectuser=(String)hm.get("Selectuser");//request.getParameter("Selectuser");
String UserName=(String)hm.get("UserName");//request.getParameter("UserName");
String UserLevel=(String)hm.get("UserLevel");//request.getParameter("UserLevel");
String Department=(String)hm.get("Department");//request.getParameter("Department");
String UserLevelAccess=(String)hm.get("UserLevelAccess");//request.getParameter("UserLevelAccess");
String EmpCode=(String)hm.get("EmpCode");//request.getParameter("EmpCode");
String UAL=(String)hm.get("UAL");
System.out.println("UAL=================>"+UAL);
String TALevel=(String)hm.get("TALevel");//request.getParameter("TALevel");
String mobileno=(String)hm.get("mobileno");//request.getParameter("mobileno");
String email=(String)hm.get("email");//request.getParameter("email");
String ActiveStatus=(String)hm.get("ActiveStatus");//request.getParameter("ActiveStatus");
String hod=(String)hm.get("hod");//request.getParameter("hod");
String sign=(String)hm.get("sign");//request.getParameter("sign");
System.out.println("STATUS     "+ActiveStatus);

String dotprojectId=(String)hm.get("dotid");
String KRAdotprojectId=(String)hm.get("kradotid");


System.out.println(dotprojectId+""+KRAdotprojectId);





System.out.println(">>>>>>>>Fullname:"+Selectuser+"\n>>>>>>>>Username:"+UserName+" \n>>>>>>>>Userlevel:"+UserLevel+"\n>>>>>>>>Dept:"+Department+"\n>>>>>>>>ULAccess:"+UserLevelAccess+"\n>>>>>>>>Empcode:"+EmpCode+"\n>>>>>>>>TALevel:"+TALevel+"\n>>>>>>>>Mobno:"+mobileno+"\n>>>>>>>>Email:"+email+"\n.....status"+ActiveStatus);

String URole="";
String query21="select * from db_GlobalERP.UserTypeMaster where UserTypeCode='"+UAL+"'";

ResultSet rs21=st2.executeQuery(query21);

if(rs21.next())
{
	URole=rs21.getString("UserType");
}

System.out.println("User type for Role:"+URole);


String update1="update UserMaster set UserName='"+UserName+"',EmpName='"+Selectuser +"',UserLevel='"+UserLevel+"',Dept='"+Department+"',CompanyCode='"+UserLevelAccess+"',EmpCode='"+EmpCode+"',TALevel='"+TALevel+"',mobileno='"+mobileno+"',email='"+email+"', ActiveStatus='"+ActiveStatus+"', UserTypeCode="+UAL+",Role='"+rolenew+"',HodReport='"+hod+"',dotprojectid='"+dotprojectId+"',KRAdotprojectid='"+KRAdotprojectId+"' ,Signature=? where UserName='"+ UserName +"'";
System.out.println(">>>>>>>>Update:"+update1);


PreparedStatement ps_usermaster=con.prepareStatement(update1);
ps_usermaster.setBinaryStream(1, filecontent1);

	
String update="update "+session.getAttribute("CompanyMasterID").toString()+"security set UserName='"+UserName +"',EmpName='"+Selectuser +"',UserLevel='"+UserLevel+"',Dept='"+Department+"',CompanyCode='"+UserLevelAccess+"',TALevel='"+TALevel+"',mobileno='"+mobileno+"',email='"+email+"', ActiveStatus='"+ActiveStatus+"',HodReport='"+hod+"',Signature=? where UserName='"+ UserName +"'";
System.out.println(">>>>>>>>Update:"+update); 


PreparedStatement ps_security=con.prepareStatement(update);
ps_security.setBinaryStream(1, filecontent);



int cnt=ps_security.executeUpdate();
System.out.println(">>>>>>>>security 1");
int cnt1=ps_usermaster.executeUpdate();
System.out.println(">>>>>>>>security 2:"+cnt1+" usermaster"+cnt1); 


htmlstring.append("<br><h4 align=center> ERP Account Edit Details....  </h4>" +
		"<table align=center border=1 cellpadding=0 cellspacing=0>" +
			"<tr>" +
			"<th><b>User Name</b></th>" +
		    "<th><b>Email-id</b></th>" +
			"<th><b>Department</b></th>" +
			"<th><b>User Level</b></th></tr>");


htmlstring.append("<tr>"+
	              "<td>"+UserName+"</td>"+
	              "<td>"+email+"</td>"+
	              "<td>"+Department+"</td>"+
	              "<td>"+UserLevel+"</td></tr></table>");			


String EMPName="karan";
String Emailid="select email from "+session.getAttribute("CompanyMasterID").toString()+"security where UserName='"+UserName+"'";

ResultSet rsEmailid=stmt2.executeQuery(Emailid);

if(rsEmailid.next())
{
	adminmail=rsEmailid.getString("email");
	 System.out.println("-------admin name:"+adminmail); 

}
response.sendRedirect("alertGoTo.jsp?msg=User Updated Successfully&goto=AdminModule.jsp");
}
catch(Exception e)
{
	System.out.println(">>>>>>>>>>>>Exception:e"+e);
}
%>


