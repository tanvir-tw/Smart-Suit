<%@ page language="java" contentType="application/pdf; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*"%>
<%
    // 1. Clear the buffer to prevent any leading whitespace from corrupting the PDF
    out.clear();
    out = pageContext.pushBody();

    String filename = request.getParameter("filename");
    if (filename == null) return;
    
    filename = filename.replace("^", " ");
    
    // 2. Resolve File Path
    String basePath = System.getenv("INVOICE_PATH");
    if (basePath == null || basePath.isBlank()) {
        basePath = "/var/www/html/GLOBALERP/VehicleMonthlyInvoices/";
        System.out.print(basePath+filename);
    }
    
    File file = new File(basePath, filename);

    if (file.exists() && file.canRead()) {
        // 3. Set Headers
        response.setContentType("application/pdf");
        response.setContentLength((int) file.length());
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        // 4. Stream the file
        byte[] buffer = new byte[4096];
        int bytesRead;
        
        try (BufferedInputStream is = new BufferedInputStream(new FileInputStream(file));
             OutputStream os = response.getOutputStream()) {
            
            while ((bytesRead = is.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.flush();
        } catch (Exception e) {
            System.err.println("Error streaming PDF: " + e.getMessage());
        }
    } else {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found on server.");
    }
%>