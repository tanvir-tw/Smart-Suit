<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page language="java"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="js/multifile.js"></script>
<title>Transworld Inward Upload</title>
</head>
<body>
	<%! Statement stmt1 = null; %>

	<%
	try {
		Connection conn = null;
			conn = connection.getConnect("db_leaveapplication");    
			st=conn.createStatement();
			stmt1=conn.createStatement();
	} catch (Exception e) {
	    e.printStackTrace();
	} 
  
     String inrefno="",from="",prno="", to="",dept="", cat="", MyFile="", sub="",data="",completePath="", priority="", fileName="",srNoStr="";
   	 String itemName="",docPath="",blno="",blamt="",bldate="",blduedate="",remark="",from1="",manualref="";
   	 String agrParty="",agrFrom="",agrFrmDt="",agrToDt="";
   	 String agreementParty="",agreementDate="",agreementFrom="",agreementTo="";
     int count1=0,count2=0,count3=0,count4=0,count5=0, inno = 0;
 %>
	<%
 try
 {
	 String date=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());
	 java.text.DecimalFormat df = new java.text.DecimalFormat("00");
	 
	 	inrefno = "IW";
         String sqlIwno="SELECT rid,InwardRefNo  from t_inwarddetails  where InwardRefNo like ('"+inrefno+""+date+"%') ORDER BY InwardRefNo DESC LIMIT 1";
 		ResultSet rst=stmt1.executeQuery(sqlIwno);
 		if(rst.next())
 		{
 			String a1=rst.getString(2);
 			System.out.println(">>>>>>>>  "+a1);
 			inno = rst.getInt("rid") + 1;
 			inrefno=rst.getString(2).substring(0,rst.getString(2).length()-2)+df.format(Integer.parseInt(rst.getString(2).substring(rst.getString(2).length()-2, rst.getString(2).length()))+1);

 			
 		}
 		else
 		{
 			inrefno+=date+"001";	
 		}
 }
 catch(Exception e)
 {
 	out.println("Exception=================>>"+e);
 }
 System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>refno:"+inrefno); 
 
 
 
 /* 
String fName=request.getParameter("fnames");
 System.out.println("------------------"+fName);
 */
 //inrefno=request.getParameter("inrefno").trim();
 //inno=request.getParameter("inno").trim();
 
 from=request.getParameter("from").trim();

 prno=request.getParameter("prno").trim();
 String to1[]=request.getParameterValues("to");
 dept=request.getParameter("dept").trim();
 cat=request.getParameter("cat").trim();
// rd=request.getParameter("rd").trim();
 MyFile=request.getParameter("MyFile");
 sub=request.getParameter("sub");
 data=request.getParameter("data");
 priority=request.getParameter("priority");
 srNoStr=request.getParameter("srNoStr").trim();
 fileName=request.getParameter("fileName");
 remark=request.getParameter("remark");
 blno =request.getParameter("blno");
 blamt =request.getParameter("blamt");
 bldate =request.getParameter("bldate");
 blduedate =request.getParameter("blduedate");
 
 agreementParty=request.getParameter("agreementParty");
 agreementDate=request.getParameter("agreementDate");
 agreementFrom=request.getParameter("agreementFrom");
 agreementTo=request.getParameter("agreementTo");
 
 from1=request.getParameter("from1");
 manualref=request.getParameter("manualref");

 String address=request.getParameter("address");
 String keywords=request.getParameter("keywords").replace(",","-").replace("&","and").replace("'","-");                 
 System.out.println("KEYWIORDS    "+keywords);
 String searchby=request.getParameter("searchBy");
 System.out.println("check box value   "+searchby);
 
 
 if(from.equals("") || from.equals(null))
 {
	 from=from1;
 }
   
   for(int i=0; i<to1.length; i++)
   {
	   out.print(to1[i]); 
	   if(to=="")
	   {
		   to=to1[i];
	   }
	   else
	   {
		   to=to+","+to1[i];
	   }
   }
   System.out.print("\n\nTestNew!!!!!>>==="+inno+"=="+inrefno+"==="+from+"==="+prno+"==="+to+"==="+dept+"===="+cat+"===="+itemName+"===="+data+"==="+sub+"==="+completePath+"===="+priority+"==="+docPath+"==="+fileName+"==="+srNoStr+"======"+remark+"====="+blno+"=="+blamt+"=="+bldate+"=="+blduedate+"=="+address+"=="+agreementParty+"=="+agreementDate+"=="+agreementFrom+"=="+agreementTo+"&keywords="+keywords);
   System.out.print("\n\n\n\n--->>      uploadToInward.jsp?inno="+inno+"&inrefno="+inrefno+"&from="+from+"&prno="+prno+"&to="+to+"&dept="+dept+"&cat="+cat+"&itemName="+itemName+"&data="+data+"&sub="+sub+"&completePath="+completePath+"&priority="+priority+"&docPath="+docPath+"&fileName="+fileName+"&srNoStr="+srNoStr+"&remark="+remark+"&blno="+blno+"&blamt="+blamt+"&bldate="+bldate+"&blduedate="+blduedate+"&manualref="+manualref+"&address="+address+"&keywords="+keywords);
   String sendUrl="inno="+inno+"&inrefno="+inrefno+"&from="+from+"&prno="+prno+"&to="+to+"&dept="+dept+"&cat="+cat+"&itemName="+itemName+"&data="+data+"&sub="+sub+"&completePath="+completePath+"&priority="+priority+"&docPath="+docPath+"&fileName="+fileName+"&srNoStr="+srNoStr+"&remark="+remark+"&blno="+blno+"&blamt="+blamt+"&bldate="+bldate+"&blduedate="+blduedate+"&manualref="+manualref+"&address="+address+"&agreementParty="+agreementParty+"&agreementDate="+agreementDate+"&agreementFrom="+agreementFrom+"&agreementTo="+agreementTo+"&keywords="+keywords+"&searchby="+searchby;
//  response.sendRedirect("uploadToInward.jsp?inno="+inno+"&inrefno="+inrefno+"&from="+from+"&prno="+prno+"&to="+to+"&dept="+dept+"&cat="+cat+"&itemName="+itemName+"&data="+data+"&sub="+sub+"&completePath="+completePath+"&priority="+priority+"&docPath="+docPath+"&fileName="+fileName+"&srNoStr="+srNoStr+"&remark="+remark+"&blno="+blno+"&blamt="+blamt+"&bldate="+bldate+"&blduedate="+blduedate+"&manualref="+manualref+"&address="+address);
//	response.sendRedirect("uploadToInward.jsp?itemName="+itemName+"&remark="+remark+"&blno="+blno+"&blamt="+blamt+"&bldate="+bldate+"&blduedate="+blduedate+"&manualref="+manualref+"&address="+address);
 response.sendRedirect("uploadToInward.jsp?"+sendUrl);
		   %>

</body>
</html>