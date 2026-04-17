<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.*"%>

<html>
<head>
<title>Transworld Inward Upload</title>
</head>
<body>

<%
Connection conn = null;
PreparedStatement ps = null;
String resendMsg = "";

// ✅ Store all uploaded file names
ArrayList<String> fileNames = new ArrayList<String>();
ArrayList<String> failedFiles = new ArrayList<String>();

try {

    System.out.println("===== FILE UPLOAD START =====");

    ConnectionClass connection = new ConnectionClass();
    conn = connection.getConnect("db_leaveapplication");

    // ✅ FIXED PATH (IMPORTANT)
  //  String inward_doc = "/var/www/html/TWDOC";
    String inward_doc = System.getenv("INWARD_DOC");
    System.out.println("Upload Path: " + inward_doc);

    File uploadDir = new File(inward_doc);
    if (!uploadDir.exists()) {
        boolean created = uploadDir.mkdirs();
        System.out.println("Directory created: " + created);
    }

    System.out.println("Directory Exists: " + uploadDir.exists());
    System.out.println("Directory Writable: " + uploadDir.canWrite());

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (!isMultipart) {
        resendMsg = "No file uploaded!";
        System.out.println("Request is NOT multipart");
    } else {

        System.out.println("Request is multipart");

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        List<FileItem> items = upload.parseRequest(request);

        System.out.println("Total Items: " + items.size());

        for (FileItem item : items) {

            if (!item.isFormField()) {

                String originalName = item.getName();
                System.out.println("Original File Name: " + originalName);

                if (originalName == null || originalName.trim().isEmpty()) {
                    System.out.println("Skipped empty file");
                    continue;
                }

                String itemName = new File(originalName).getName();
                itemName = itemName.replaceAll(" ", "_");

                File savedFile = new File(uploadDir, itemName);

                try {
                    System.out.println("Saving file to: " + savedFile.getAbsolutePath());

                    item.write(savedFile);

                    if (!savedFile.exists() || savedFile.length() <= 0) {
                        throw new Exception("File not saved properly");
                    }

                    System.out.println("File saved SUCCESS: " + itemName);

                    // ✅ Add to list only if successful
                    fileNames.add(itemName);

                } catch (Exception ex) {
                    System.out.println("File write ERROR: " + ex.getMessage());
                    failedFiles.add(itemName);
                }
            }
        }

        // ================= DB INSERT =================
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        for (String file : fileNames) {
        	String NewFileName = "TWC" + sdf.format(new java.util.Date());
        	
            try {
                String sqlInsert = "INSERT INTO db_leaveapplication.t_uploadedFiles " +
                        "(FileName, UploadedBy, FileStatus, inwardedBy, inwardDateTime,NewFileName) " +
                        "VALUES (?, ?, ?, ?, NOW(),?)";

                ps = conn.prepareStatement(sqlInsert);
                ps.setString(1, file);
                ps.setString(2, session.getAttribute("leaveempname").toString());
                ps.setString(3, "uploaded");
                ps.setString(4, "-");
                ps.setString(5, NewFileName);

                System.out.println("Inserting sql : " + ps.toString());
                System.out.println("Inserting into DB: " + file);
                System.out.println("Inserting file: " + file + " NewName: " + NewFileName);
                ps.executeUpdate();
                ps.close();

            } catch (Exception e) {
                System.out.println("DB Insert Error: " + e);
                failedFiles.add(file);
            }
        }

        // ================= RESULT =================

        if (failedFiles.size() > 0) {
            resendMsg = "Some files failed: " + failedFiles;
        } else {
            resendMsg = "Files Uploaded Successfully!";
        }
    }

    System.out.println("===== FILE UPLOAD END =====");

} catch (Exception e) {
    e.printStackTrace();
    resendMsg = "File Upload Failed: " + e.getMessage();
} finally {
    try {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

// ✅ Redirect
response.sendRedirect("IwrdScan.jsp?resendMsg=" + resendMsg);
%>
</body>
</html>