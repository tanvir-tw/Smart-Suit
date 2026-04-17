    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
    
<%@ page language="java" import="java.sql.*" import=" java.text.*" import="java.util.*"  import="java.util.Date" errorPage="" %>
<%@include file="conn.jsp" %>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
	<%@ page import = "java.io.FileOutputStream"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.jibble.simpleftp.*"%>
<%@ page language="java"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.List"%>

<%@ page language="java" import="java.sql.*" import=" java.text.*"
	import=" java.util.*" errorPage=""%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="javax.mail.*" import="java.util.Properties"
	import="javax.mail.internet.InternetAddress"
	import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.servlet.http.HttpServletRequest"
	import="javax.mail.internet.MimeBodyPart"
	import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.net.URL"%>
   <%@ page import="java.net.*"%>
   <%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
  <%@page import="java.io.FileInputStream"%>  
<%@page import="java.io.IOException"%>  
<%@page import="java.net.SocketException"%>  
<%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="org.apache.commons.net.ftp.FTPReply"%>
<%!Connection con, conn, conftp;

	
	%>

	<script>
	function myfun() {
		
		var a=document.getElementById("hello").value;
		var b=document.getElementById("hello1").value;
		
		//var r=document.getElementById("hello2").value;
		
		
		//str.replace(/$/g, '');
		
		//var c=a.replace(/$/g," ");
		//var d=b.replace(/$/g," ");
		
		//alert(c);
		//alert(d);
		
		
		
		var newTest = a.replace(/,/g, ' ');
		
		var newTest1 = b.replace(/,/g, ' ');
		
		
		
		  // window.open("http://twtech.in/TransworldDocs/ERPDocs/"+b+"/"+newTest+"","_self");
	     //  window.open("http://twtech.in/TransworldDocs/ERPDocs/"+b+"/"+newTest1+"");
	     
	     window.open("http://twtech.in/TransworldDocs/ERPDocs/"+b+"/"+newTest+"","_self");
	     window.open("http://twtech.in/TransworldDocs/ERPDocs/"+b+"/"+newTest1+"");
	    window.open("https://www.google.com"); 
	    
	}
	
	</script>
	<html>
	<body>
	<%
String userid=session.getAttribute("user").toString();






String fname=request.getParameter("documentName");
String comid=session.getAttribute("CompanyMasterID").toString();
String ftpfolder="";
System.out.println("File NAme---->"+fname);
System.out.println("Master Id---->"+comid);







/* 
comid="100000";

fname="POSCO PO for 50dev and agreement.pdf";

String sh="POSCO PO for 50dev and agreement.pdf,POSCO PO for 50dev and agreement.pdf";
*/
String abc,pqr;
 	

String []arr=fname.split(",");
System.out.println("arr length"+arr.length);

for(int i=0;i<arr.length;i++)
{
    System.out.println("arr val"+arr[i]);

}

		





 if(arr.length<=1)
{
	
	System.out.println("In IF ");
	 response.sendRedirect("http://twtech.in:8585/TransworldDocs/ERPDocs/"+comid+"/"+fname+"");
	//response.sendRedirect("http://twtech.in:8585/TransworldDocs/ERPDocs/"+fname+"");
	  //response.sendRedirect("http://twtech.in/TransworldDocs/ERPDocs/100000/"+fname+"");
}
else
{
	System.out.println("IN ELSE");
	
	 abc=arr[0];
	 pqr=arr[1];
	
	
	System.out.println(abc);
	System.out.println(pqr);
	
	abc=abc.replace(" ", ",");
	pqr=pqr.replace(" ",",");
	
	%>
	
	 <input type="hidden" id="hello" name="hello" value=<%=abc %> >
	  <input type="hidden" id="hello1" name="hello1" value=<%=pqr %>>
	<input type="hidden" id="hello2" name="hello1" value=<%=comid %>>
	
	<% 
	
	out.println("<script>myfun();</script>");	
	
	//response.sendRedirect("http://twtech.in/TransworldDocs/ERPDocs/"+comid+"/"+fname+"");
}
		 

%>


	

</body>
</html>