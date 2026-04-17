<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="js/multifile.js"></script>
<title>Transworld Inward Upload</title>
</head>
<body>
<%
   //..............
     String inrefno="",inno="",from="",from1="",prno="",to="", dept="", cat="", rd="", MyFile="", sub="",data="",completePath="", priority="", f123="",remark="";
   	 String itemName="",docPath="",blno="",blamt="",bldate="",blduedate="";
   	String agreementParty="",agreementDate="",agreementFrom="",agreementTo="";
     int count1=0,count2=0,count3=0,count4=0,count5=0;
%>
	<%
 /*
 String fName=request.getParameter("fnames");
 System.out.println("------------------"+fName);
 */
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
   } catch (FileUploadException e) {
   e.printStackTrace();
   }
   Iterator itr = items.iterator();
   
//   String a[]=request.getParameter("");
   String a="";
   while (itr.hasNext()) 
           {
   FileItem item = (FileItem) itr.next();
   if (item.isFormField())
           {
              String name = item.getFieldName();
                  String value = item.getString();
                  if(name.equals("inrefno"))
                   {
                         inrefno=value;
                   }
                   if(name.equals("inno"))
                   {  
                	    inno=value;                         
                   }
                   if(name.equals("from"))
                   {  
                	   from=value;                         
                   }
                   if(name.equals("prno"))
                   {
                	   prno=value;
                   }
                   if(name.equals("to"))
                   {
                	  if(to=="")
                	  {
                	   to=value;
                	  }
                	  else
                	  {
                		  to=to+","+value;
                	  }
                	   
               // 	  System.out.println("++++++++++++++++++++++++++++++"+to);
                   } 
                   if(name.equals("dept"))					
                   {
                	   dept=value;
                   }
                   if(name.equals("cat"))
                   {
                	   cat=value;
                   }
                   if(name.equals("rd"))
                   {
                	   rd=value;
                   }
                   if(name.equals("files_list"))
                   {
                	   MyFile=value;
                   }
                   if(name.equals("sub"))
                   {
                	   sub=value;
                   }
                   
                   if(name.equals("data"))
                   {
                	   data=value;
                   }
                   if(name.equals("priority"))
                   {
                	   priority=value;
                   }
                   //=======================================
                   if(name.equals("remark"))
                   {
                	   remark=value;
                   }
                   if(name.equals("blno"))
                   {
                	   blno=value;
                   }
                   if(name.equals("blamt"))
                   {
                	   blamt=value;
                   }
                   if(name.equals("bldate"))
                   {
                	   bldate=value;
                   }
                   if(name.equals("blduedate"))
                   {
                	   blduedate=value;
                   }
                   if(name.equals("from1"))
                   {
                	   from1=value;
                   }
                   //=======================================
                	if(name.equals("agreementParty"))
                   {
                		agreementParty=value;
                   }
                   if(name.equals("agreementDate"))
                   {
                	   agreementDate=value;
                   }
                   if(name.equals("agreementFrom"))
                   {
                	   agreementFrom=value;
                   }
                   if(name.equals("agreementTo"))
                   {
                	   agreementTo=value;
                   }
                   //=======================================
                   
                   if(name.equals("fileName"))
                   {
                	   f123=value.trim();
                   }
                   System.out.println("attched Files============>>"+f123);
                   out.println("attched Files============>>"+f123);
          } 
    	  else
		  {    
						try 
						{
							itemName = item.getName();
			                   if(itemName != null && !itemName.isEmpty()) {
			                       // New File Path as requested
			                       docPath = "/var/www/html/TWDOC/";
			                       completePath = docPath + itemName;
			                       
			                       // Create the file object and SAVE it to the disk
			                       File savedFile = new File(completePath);
			                       item.write(savedFile); 
			            
			                       System.out.println("File saved to: " + completePath);
			                   }
					       %><center>
		</table>
		<%
					   } 
			    	   catch (Exception e) 
			    	   {
					   		e.printStackTrace();
					   }
			    	   
				   }
		   }
 		   //=====================================================
   		   System.out.println(from+"*********"+from1);
   		   if(cat.equals("customer"))
   		   {
   			   from=from1;
   		   }
   		   
   		  //=====================================================
   		   System.out.println("==="+inno+"=="+inrefno+"==="+from+"==="+prno+"==="+to+"==="+dept+"===="+cat+"===="+rd+"===="+itemName+"===="+data+"==="+sub+"====="+remark+"======"+completePath+"===="+priority+"==="+docPath+"==="+f123+"======================="+blno+"=="+blamt+"=="+bldate+"=="+blduedate+"=="+agreementParty+"=="+agreementDate+"=="+agreementFrom+"=="+agreementTo);
		   response.sendRedirect("inwardEmail.jsp?inno="+inno+"&inrefno="+inrefno+"&from="+from+"&prno="+prno+"&to="+to+"&dept="+dept+"&cat="+cat+"&rd="+rd+"&itemName="+itemName+"&data="+data+"&sub="+sub+"&completePath="+completePath+"&priority="+priority+"&docPath="+docPath+"&AllFileNames="+f123+"&remark="+remark+"&blno="+blno+"&blamt="+blamt+"&bldate="+bldate+"&blduedate="+blduedate+"&agreementParty="+agreementParty+"&agreementDate="+agreementDate+"&agreementFrom="+agreementFrom+"&agreementTo="+agreementTo);
		   
		   }//close of else(multipart)
		   %>
	
</body>
</html>