%@ page language="java"  errorPage="" %>
<html>
<head>
<title>Image insert into database</title>
</head>

<body>
<%
String CompId=request.getParameter("companyid");
System.out.println("Company ID in Image Upload==" + CompId);
%>
<form name="frm" action="saveImage.jsp?CompanyId=<%=CompId%>" enctype="multipart/form-data" method="post">
 <input type="text" name="name" > 
 <input type="file" name="uProperty" /> <br>
 <input type="submit" name="goUpload" value="Upload" />
</form>
</body>
</html>