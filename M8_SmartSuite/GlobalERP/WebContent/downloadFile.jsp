<%@ page import="java.io.*" %>

<%
String fileName = request.getParameter("file");

if (fileName == null || fileName.trim().isEmpty()) {
    return;
}

// 🔒 Security
fileName = new File(fileName).getName();

String filePath = "/var/www/html/TWDOC/" + fileName;
File file = new File(filePath);

if (!file.exists()) {
    return;
}

// 🔥 VERY IMPORTANT
out.clear();
out = pageContext.pushBody();

// Set headers
response.setContentType("application/octet-stream");
response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
response.setContentLengthLong(file.length());

// Stream file
BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

byte[] buffer = new byte[8192];
int bytesRead;

while ((bytesRead = bis.read(buffer)) != -1) {
    bos.write(buffer, 0, bytesRead);
}

bos.flush();
bis.close();
bos.close();
%>