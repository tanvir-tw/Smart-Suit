<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
String host = System.getenv("DB_GLOBALERP_HOST");
String user = System.getenv("DB_GLOBALERP_USER");
String pass = System.getenv("DB_GLOBALERP_PASS");
   Connection conn=null;
   Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
   conn = DriverManager.getConnection("jdbc:mysql://"+host+"/jsp","root", "root.123");

   PreparedStatement psImageInsertDatabase=null;
   String CompId=request.getParameter("CompanyId");
   System.out.println("Comapny ID in save Image====="+ CompId);
   
   byte[] b=null;
   try{
      String sqlImageInsertDatabase="insert into upload_image (bImage) values(?)";
      psImageInsertDatabase=conn.prepareStatement(sqlImageInsertDatabase);
      
      DiskFileItemFactory factory = new DiskFileItemFactory();

      ServletFileUpload sfu = new ServletFileUpload(factory);
      List items = sfu.parseRequest(request);

      Iterator iter = items.iterator();
      System.out.println("iter---->"+iter);
      
      while (iter.hasNext()) {
         FileItem item = (FileItem) iter.next();
         if (!item.isFormField()) {
              b = item.get();
          }
      }
      
      psImageInsertDatabase.setBytes(1,b);
      psImageInsertDatabase.executeUpdate();
   }
   catch(Exception e)
   {
     e.printStackTrace();
     response.sendRedirect("imageUpload.jsp");
   }

%> 