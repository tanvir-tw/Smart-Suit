<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.ServletOutputStream"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
int BUFSIZE = 4096;
String filePath;
{ 
	String compId=session.getAttribute("CompanyMasterID").toString();
	String filename = request.getParameter("filename");
	//filePath="/home/twtech/Desktop/test/";
	//filePath="/home/javaprg/TransworldDocs/100000/ERPDocs";
	 // filePath="/home/javaprg/TransworldDocs/"+compId+"/ERPDocs";  //working
	  filePath="/home/javaprg/TransworldDocs/"+compId+"/ERPDocs/"; 
	//filePath="/home/javaprg/TransworldDocs/ERPDocs";
	//filePath="C:\\Users\\Bhagyashri\\Desktop\\All Folders\\";
	//filePath="/home/javaprg/TaskAttachment/";
	filename=filename.replace("^"," "); 
System.out.println("After "+filename);
File file = new File(filePath+"/"+filename);
int length   = 0;
ServletOutputStream outStream = response.getOutputStream();
response.setContentType("text/html");
response.setContentLength((int)file.length());
String fileName = (new File(filePath+"/"+filename)).getName();
response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName.replace("^"," ") + "\"");
 
byte[] byteBuffer = new byte[BUFSIZE];
DataInputStream in = new DataInputStream(new FileInputStream(file));
 
while ((in != null) && ((length = in.read(byteBuffer)) != -1))
{
outStream.write(byteBuffer,0,length);
}
 
in.close();
outStream.close();
}
%>
</body>
</html>