import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
 
public class DatabaseAccess extends HttpServlet{
    
  public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
            throws ServletException, IOException
  {
      // JDBC driver name and database URL
      
      try{
    	  
    	  //out.println("Retrieve Image Example!");
      String driverName = "com.mysql.cj.jdbc.Driver";
      String url = "jdbc:mysql:// twdb.fleetview.in/";
      String dbName = "db_GlobalERP";
      String userName = "fleetview";
      String password = "1@erp";
      String queryString= request.getParameter("id");
      System.out.println("ID ===="+ queryString);
     
      Connection con = null;
      Class.forName(driverName);
      con = DriverManager.getConnection(url+dbName,userName,password);
      Statement st = con.createStatement();
      
      PreparedStatement pre1 = con.prepareStatement("select logo from CompanyMaster where companymid='"+queryString+"'");
      ResultSet rs1=pre1.executeQuery();
      while(rs1.next())   
      {byte[] bytearray1 = new byte[4096];  
                   int size1=0;  
                  InputStream sImage1;  
                    sImage1 = rs1.getBinaryStream("logo");  
                    response.reset();  
                   response.setContentType("image/jpeg");  
                   response.addHeader("Content-Disposition","filename=logo.jpg");  
                   while((size1=sImage1.read(bytearray1))!= -1 )  
                     {  
                       response.getOutputStream().write(bytearray1,0,size1);  
                     }  
                   response.flushBuffer(); 
                   sImage1.close();  
                  
                }


         //out.println("Retrieved Successfully!");
       pre1.close();
       con.close();  
      }catch(SQLException se){
         //Handle errors for JDBC
         se.printStackTrace();
      }catch(Exception e){
         //Handle errors for Class.forName
         e.printStackTrace();
      }
   }
} 