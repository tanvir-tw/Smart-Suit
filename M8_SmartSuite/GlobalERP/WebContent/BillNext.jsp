<%@ page import="java.util.List" %>
<%@ page import="com.erp.beans.*" %>
<%@ include file="headConn.jsp" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %> 
   <%@ page import="java.io.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="org.jibble.simpleftp.*" %>
    <%@ page import="java.net.URLConnection" %>
    <%@ page import="java.net.URL" %>
    <%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="org.apache.commons.net.ftp.FTPReply"%>
    
   <%@ page language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="js/multifile.js"></script>
<title>Transworld Inward Upload</title>
</head>
<body>

        
   <%

   String f123="";
 	 String itemName="",docPath="";
 //	String fName="";
   int fileCount=0;
   String resendMsg="";
   ArrayList l1 =new ArrayList();
   String serverid="",usernm="",passwd="";	
   Statement st1=conn.createStatement();
   
   String sqlftp="select * from t_ftpconnection";
   System.out.println("sqlftp:-"+sqlftp);
   ResultSet rsftp=st1.executeQuery(sqlftp);
   rsftp.next();
   serverid=rsftp.getString("ServerID");
   usernm=rsftp.getString("Username");
   passwd=rsftp.getString("Password");
%>
<%

String fName=request.getParameter("MyFile");
System.out.println("--------MyFIle--------"+fName);

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if (!isMultipart) 
{
} 
else
{
 FileItemFactory factory = new DiskFileItemFactory();
 ServletFileUpload upload = new ServletFileUpload(factory);
 List items = null;
 try {
 items = upload.parseRequest(request);
 System.out.println("items="+items);
 } catch (FileUploadException e) {
 e.printStackTrace();
 }
 Iterator itr = items.iterator();
 
// String a[]=request.getParameter("");
 String a="";
 int i=0;
 String savedFileName="";
 String NewFileName="";
 while (itr.hasNext()) 
         {
	   //System.out.println
 FileItem item = (FileItem) itr.next();
 if (item.isFormField())
         {
            String name = item.getFieldName();
                String value = item.getString();
               
                 if(name.equals("fileName"))
                 {
              	   f123=NewFileName;
                 }
                 if(name.equals("MyFile"))
                 {
              	   fName=NewFileName;
                 }
                 System.out.println("fName Files fName============>>"+fName);
                 System.out.println("attched Files============>>"+f123);
                 out.println("attched Files============>>"+f123);
        } 
  	  else
		  {    
						try 
						{
				           itemName = item.getName();
				       	String date=new SimpleDateFormat("dd-MMM-yyyyHH:mm:ss").format(new java.util.Date());

				           if(itemName=="null" || itemName.equals(""))
			        		{
			        			System.out.println("itemName in if loop===========================================================>"+itemName);
			        			itemName="-";
			        		}else{
						   //File savedFile = new File(config.getServletContext().getRealPath("/")+itemName);
						   itemName=itemName.replaceAll(" ","_");
						    NewFileName=itemName.substring(0,itemName.lastIndexOf(".")).toString();
						   NewFileName=NewFileName+date+".xls";
						   System.out.println("NewFileName :-"+NewFileName);
						   
						   // File savedFile = new File("/home/twtech/Desktop/test/"+NewFileName);
						    
						    File savedFile = new File("/usr/share/tomcat/webapps/GlobalERP/"+NewFileName);

			        		//item.write(savedFile);
			        		System.out.println("savedFile:-"+savedFile);
						   
			        		savedFileName=savedFile.toString();
			        		
						  //docPath=("/home/twtech/Desktop/test/");
						  
						  docPath=("/usr/share/tomcat/webapps/GlobalERP/");

						  
						  System.out.println("docPath:-"+docPath);
						   item.write(savedFile);
			        		}
					      
					   } 
			    	   catch (Exception e) 
			    	   {
			    		   System.out.println("exception is :-"+e);
					   		e.printStackTrace();
					   }
			    	   
				   }
		   }
 
 			
//=====Copy 2 FTP===============================================================================================
		 System.out.println("here:-");
 try
	{
	
	 FTPClient ftp = new FTPClient();
	 FileInputStream inputStream = null;
	 try {
		  
	      int reply;
	      String server = "serverid";
	      ftp.connect(serverid);
	      
	  		ftp.login(usernm,passwd);
	      ftp.connect(server);
	      System.out.println("Connected to " + server + ".");
	      System.out.print(ftp.getReplyString());

	      // After connection attempt, you should check the reply code to verify
	      // success.
	      reply = ftp.getReplyCode();

	      if(!FTPReply.isPositiveCompletion(reply)) {
	        ftp.disconnect();
	        System.err.println("FTP server refused connection.");
	        System.exit(1);
	      }
	     
	      ftp.logout();
	    
	   		try
		   	{
	   			System.out.println("In try FTP connection");
	 		ftp.connect(serverid);
	   		ftp.login(usernm,passwd);
			
	
		    System.out.println("In FTP connection 1");
		   	}
		   	catch(Exception e)
		   	{
		   		
		   		ftp.connect(serverid);
		  		ftp.login(usernm,passwd);
		   		
			    System.out.println("In FTP connection 2");
		   	}
	   	}
	   	catch(Exception e)
	   	{
	   		ftp.connect(serverid);
	   		ftp.login(usernm,passwd);
	   		System.out.println("In 2nd FTP connection");
	   
		    System.out.println("In FTP connection 3");
		    
	   	}
				
	    		
	    		boolean flg=false;
	   			out.println("values for FTP*********************"+f123);
			    String delims12 = "[,]";
			    String[] tokens12 = NewFileName.split(delims12);
				for (String t : tokens12)
				
				{
					flg=false;
	
				System.out.println("In for loop");
						
						
			 inputStream = new FileInputStream(new File( savedFileName));
			 System.out.println("In store ftp");
			 ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
				ftp.storeFile("/test/"+ t + "", inputStream);
				System.out.println("Below ftp store");
				
				
				
							
					
				System.out.println("path----------->>"+docPath+""+ t);
					fileCount++;
					
				
					ExcelToSQL obj=new ExcelToSQL(savedFileName);
				
				}
				
					resendMsg="Files Uploaded Successfully !";
					System.out.println("resendMsg" +resendMsg);
				  
					
					
					
				response.sendRedirect("BillUpload.jsp?resendMsg="+resendMsg);
				
	}
	catch(Exception e)
	{
		
		System.out.println("Exception Copy File to FTP----------->>"+e);
		e.printStackTrace();
		resendMsg="Unable To Upload File Due Connection Breakup!!!";
		System.out.println("resendMsg" +resendMsg);
		response.sendRedirect("BillUpload.jsp?resendMsg="+resendMsg);
	}

	 

		   }
		   conn.close();
		   
		   %>
  
</body>
</html>