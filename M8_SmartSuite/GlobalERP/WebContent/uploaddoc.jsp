<%@ include file="ConnectionComplaint.jsp" %>
<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
      <%@ page import="java.util.Iterator" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>
   
   
<%@ include file="headConn.jsp" %>
<%@ include file="header.jsp" %>



  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	    <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="org.jibble.simpleftp.*" %>
    <%@ page import="java.net.URLConnection" %>
    <%@ page import="java.net.URL" %>
    <%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="org.apache.commons.net.ftp.FTPReply"%>
  	<%
  	String fname=(String)session.getAttribute("EmpName");
  	String email=(String)session.getAttribute("EmpEmail");
  	%> 
  
<%!

Connection conn,con;
static int html=1;
static int saveflag=1;
 int count=1;
%>

<html><head></head>

<script type="text/javascript">



function Redirect1()
{
	
	alert('Contract Details Inserted Successfully  ','','success');
		  var value1=document.getElementById("compn").value;
		//  alert(value1);
var value2=document.getElementById("companyCode1").value;
//alert(value2);

window.location.href="customercontract.jsp?companyName="+value1+"&companyCode="+value2;
	
	    
	
}




function Redirect11()
{
	
	alert('Contract Updated  ','','success');
		  var value1=document.getElementById("compn").value;
		//  alert(value1);
var value2=document.getElementById("companyCode1").value;
//alert(value2);

window.location.href="customercontract.jsp?companyName="+value1+"&companyCode="+value2;
	
	    
	
}

</script>
<body style="background-color: #F5F5F5">

<%



String f123="";
Statement stdynamicdrop = null,st2=null,st=null,st3=null,st4=null,st6=null,st90=null;
String tt="";
st2=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();
st6=conn.createStatement();

String CustomerCode1="";
String ContractRefNo="";
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

String EntryBy=session.getAttribute("EmpName").toString();


String finaldoc="";

int Msg=1;
String ReportName="-",category="-",Entby="-",Name="-",EmailID="-",todate="-",FileName="-",Category="-";
String Priority="-",ClosingComments="-",ClosedBy="-",Status="-",PageName="-",Email2="-",custname1="-",SLA="-",CustomerType="-",Rate="-",companyCode="-",ToCc="-",Frequency="-",BillType="-",ToId="-",BillStatus="-",OperationalStatus="-",Billday="-";
String ComplaintDateTime,UpadteDateTime;
String fromdate="-";
Boolean innerflag=false;
Boolean flag=false;
Writer output = null;
String issue = "", report = "";
String randomnumber="";
File savedFile;
int count1 = 0, count2 = 0, filecount = 0, count4 = 0, count5 = 0,complaintID=0;
String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm")
.format(new java.util.Date());

String savefilestring="";
String[] filepath =new String[10];
String[] filename =new String[10];

String savedFileName="";
String docuold="";
System.out.println("\n\n on complaint insert page");

category=request.getParameter("category");
System.out.println("category"+category);

SimpleDateFormat fr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
Date date = new Date();  
System.out.println(fr.format(date));

Entby="-";
Name=fname;
todate=request.getParameter("todate");
System.out.println("fromda"+todate);

fromdate=request.getParameter("fromdate");
System.out.println("fromdate"+fromdate);

String NewFileName="";
FileName=request.getParameter("filename");
System.out.println("@FileName1"+FileName);


 ComplaintDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
 UpadteDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
ClosingComments="-";
ClosedBy="-";
Status="Pending";
String query="";
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
System.out.println("\n\n ismultipart-->>"+isMultipart);
	if (!isMultipart) {
		System.out.println("\n\nin multipart..");
	} else {
		System.out.println("\n\n in else with  multipart..");
		FileItemFactory factory = new DiskFileItemFactory();
		//System.out.print("\n\nfactory==>"+factory);
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		//	System.out.print("\n\n items==>"+items);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
	
	while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if(item.isFormField()) 
			{
				String name = item.getFieldName();
				String value = item.getString();
				
				if(name.equals("fromdate")) 
				{
					fromdate = value;
					//System.out.print("\n fromdate name==>"+fromdate);
					count1 = 1;
				}
				
				if(name.equals("category")) 
				{
					category = value;
					///System.out.print("\n category name==>"+category);
					count1 = 1;
				}
				
				if(name.equals("customertype")) 
				{
					CustomerType = value;
					//System.out.print("\n customertype name==>"+CustomerType);
					count1 = 1;
				}
				
				
				if(name.equals("custname1")) 
				{
					custname1 = value;
				//	System.out.print("\n custname1 name==>"+custname1);
					count1 = 1;
				}
				
				if(name.equals("todate")) 
				{
					todate = value;
					//System.out.print("\n tod date==>"+todate);
					count1 = 1;
				}
				
				
				if(name.equals("companyCode1")) 
				{
					companyCode = value;
					//System.out.print("\n companyCode name==>"+companyCode);
					count1 = 1;
				}
				if(name.equals("filename")) 
				{
					FileName = value;
					///System.out.print("\n FileName name==>"+FileName);
					count1 = 1;
				}

				
				
				
				if(name.equals("frequency")) 
				{
					Frequency = value;
					//System.out.print("\n Frequency name==>"+Frequency);
					count1 = 1;
				}
				
				if(name.equals("billtype")) 
				{
					BillType = value;
					//System.out.print("\n BillType name==>"+BillType);
					count1 = 1;
				}
				
				if(name.equals("Billday")) 
				{
					Billday = value;
				///	System.out.print("\n Billday name==>"+Billday);
					count1 = 1;
				}
				
				
				if(name.equals("billstatus")) 
				{
					BillStatus = value;
					//System.out.print("\n BillStatus name==>"+BillStatus);
					count1 = 1;
				}
				
				if(name.equals("operationalstatus")) 
				{
					OperationalStatus = value;
					//System.out.print("\n OperationalStatus name==>"+OperationalStatus);
					count1 = 1;
				}
				
				if(name.equals("email")) 
				{
					ToId = value;
					//System.out.print("\n ToId name==>"+ToId);
					count1 = 1;
				}
				
				if(name.equals("rate")) 
				{
					Rate = value;
					//System.out.print("\n ToId name==>"+ToId);
					count1 = 1;
				}
				if(name.equals("SLA")) 
				{
					SLA = value;
					//System.out.print("\n ToId name==>"+ToId);
					count1 = 1;
				}
				
				if(name.equals("email0")) 
				{
					ToCc = value;
					//System.out.print("\n ToCc name==>"+ToCc);
					count1 = 1;
				}
				
			}  else
			  {    
				try 
				{
		           itemName = item.getName();
				    System.out.println("\n itemName :-"+itemName);

				   
		           
		       	String date1=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());

		           if(itemName=="null" || itemName.equals(""))
	        		{
	        			//System.out.println("itemName in if loop===========================================================>"+itemName);
	        			itemName="-";
	        		}else{
				   //File savedFile = new File(config.getServletContext().getRealPath("/")+itemName);
				   itemName=itemName.replaceAll(" ","_");
				   
				   
				    
				    NewFileName=itemName.substring(0,itemName.lastIndexOf(".")).toString();
				    
				   // System.out.println("NewFileName :-"+NewFileName);
				    
				    int lastindex=0;
				    String NewFileName1="";
					   lastindex=itemName.lastIndexOf(".");
					   
					     NewFileName1=itemName.substring(lastindex);
					    
					    System.out.println("NewFileName 11111111 :-"+NewFileName1);
					    
					    
				    
				   NewFileName=NewFileName+date1+NewFileName1;
				  
				   
				  //  savedFile = new File("/home/twtech/Desktop/hello/"+NewFileName);
				    
				    
				 // savedFile = new File("/usr/share/tomcat/webapps/GlobalERP/"+NewFileName);
				 savedFile = new File("/home/javaprg/CustomerContract/"+NewFileName);

				   
				     finaldoc=finaldoc+","+NewFileName;

	        		//item.write(savedFile);
	        		System.out.println("savedFile:-"+savedFile);
				   
	        		savedFileName=savedFile.toString();
	        		
				 // docPath=("/home/twtech/Desktop/hello/");
				  
				//  docPath=("/usr/share/tomcat/webapps/GlobalERP/");

				  
				 // System.out.println("docPath:-"+docPath);
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


	%>
	<input type="hidden" id="companyCode1" name="companyCode1" value="<%=companyCode%>">
	
	<input type="hidden" id="compn" name="compn" value="<%=custname1%>">
	<%	
//=====Copy 2 FTP===============================================================================================
 System.out.println("here:-");
	System.out.print("\n fromdate ==>"+fromdate);
	
	
	String fromdatep=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
	
	System.out.print("\n fromdate ==>"+fromdatep);

	
	System.out.print("\n category ==>"+category);
	System.out.print("\n customertype ==>"+CustomerType);
	System.out.print("\n tod date==>"+todate);
	
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));
	System.out.print("\n tod date==>"+todate);

	
	System.out.print("\n Frequency ==>"+Frequency);
	System.out.print("\n BillType ==>"+BillType);
	System.out.print("\n Billday ==>"+Billday);
	System.out.print("\n OperationalStatus ==>"+OperationalStatus);
	System.out.print("\n ToId ==>"+ToId);
	System.out.print("\n ToCc ==>"+ToCc);
    System.out.println("\n filename :-"+itemName);

    System.out.println("\n rate :-"+Rate);
    System.out.println("\n SLA :-"+SLA);

	System.out.print("\n companyCode ==>"+companyCode);

	
	
	
	
    
    String pardate = new SimpleDateFormat("yyyyMMdd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));

    
    ContractRefNo="CA"+pardate+"-"+companyCode+"-"+custname1;
	System.out.print("\n ContractRefNo ==>"+ContractRefNo);

    
	String sql="select CustomerCode,Document from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster where CustomerCode ='"+companyCode+"'";
	
	System.out.println("sql" +sql);
	ResultSet rsDropdown=st2.executeQuery(sql);
	  while(rsDropdown.next())
	  {
		  
		   CustomerCode1=rsDropdown.getString("CustomerCode");
		  System.out.print("\n CustomerCode1 ==>"+CustomerCode1);
		  

		   docuold=rsDropdown.getString("Document");
		  System.out.print("\n docuold ==>"+docuold);
		  
		tt=tt+docuold;


	  }
	
	  if(NewFileName=="null" || NewFileName.equals(""))
		{
			NewFileName="";
		}
tt=tt+finaldoc;

System.out.print("\n tt ==>"+tt);

	if(companyCode.equals(CustomerCode1) && itemName.equals("-"))
	{
		
		System.out.println("Innn 1 \n");

		
		String updateSql="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerBillMaster set category='"+category+"',OperationalStatus='"+OperationalStatus+"',BillDay='"+Billday+"',ToId='"+ToId+"',ToCc='"+ToCc+"',BillFrequency='"+Frequency+"',BillType='"+BillType+"',Rate='"+Rate+"',SLARate='"+SLA+"',CustomerType='"+CustomerType+"' where CustomerCode='"+companyCode+"' ";

		
	    System.out.println("update updateSql"+updateSql);
		 st4.executeUpdate(updateSql);

	    
		String updateSql11="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster set ContarctFromDate='"+fromdatep+"',ContarctToDate='"+todate+"'  where CustomerCode='"+companyCode+"' ";
	    System.out.println("update updateSql11"+updateSql11);

	    
	    
		out.println("<script>  Redirect11();</script>");		

		 st6.executeUpdate(updateSql11);

	}
	else if(companyCode.equals(CustomerCode1)  && !(itemName.equals("-")))
	{
		System.out.println("\n Innn 2");

		
		String updateSql11="Update  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster set Document='"+tt+"',ContarctFromDate='"+fromdatep+"',ContarctToDate='"+todate+"' where CustomerCode='"+companyCode+"' ";

		
		 st4.executeUpdate(updateSql11);
		    System.out.println("update updateSql11"+updateSql11);
		    
		    String updateSql="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerBillMaster set category='"+category+"',OperationalStatus='"+OperationalStatus+"',BillDay='"+Billday+"',ToId='"+ToId+"',ToCc='"+ToCc+"',BillFrequency='"+Frequency+"',BillType='"+BillType+"',Rate='"+Rate+"',CustomerType='"+CustomerType+"' where CustomerCode='"+companyCode+"' ";

			
		    System.out.println("update updateSql"+updateSql);
		    
	st6.executeUpdate(updateSql);

		    
		out.println("<script>  Redirect11();</script>");		

		
	}
	
			
	else if(itemName.equals("-"))
	{
		
		
		System.out.println("Innn 3");

		//System.out.println("itemName in if loop===========================================================>"+itemName);
		itemName="-";

		
		
		String updateSql="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster(CustomerName,ContractRefNo,CustomerCode,ContarctFromDate,ContarctToDate,Document,EntryBy,EntryDate) "+" values('"+custname1+"','"+ContractRefNo+"','"+companyCode+"','"+fromdatep+"','"+todate+"','"+NewFileName+"','"+EntryBy+"','"+fr.format(date)+"')";
		System.out.println("else updateSql:---"+updateSql);

		st3.executeUpdate(updateSql);

		
		String updateSql11="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerBillMaster(CustomerName,CustomerCode,category,OperationalStatus,BillDay,ToId,ToCc,BillFrequency,BillType,Rate,SLARate,CustomerType,EntryBy,EntryDate) "+" values('"+custname1+"','"+companyCode+"','"+category+"','"+OperationalStatus+"','"+Billday+"','"+ToId+"','"+ToCc+"','"+Frequency+"','"+BillType+"','"+Rate+"','"+SLA+"','"+CustomerType+"','"+EntryBy+"','"+fr.format(date)+"')";
		System.out.println("else updateSql11:---"+updateSql11);
	 st4.executeUpdate(updateSql11);
		
		out.println("<script>  Redirect1();</script>");		

		
		

	}
	
	
	else{
	
	
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
		//	out.println("values for FTP*********************"+f123);
	    String delims12 = "[,]";
	    String[] tokens12 = NewFileName.split(delims12);
		for (String t : tokens12)
		
		{
			flg=false;

	//	System.out.println("In for loop");
				
				
		
				
	 inputStream = new FileInputStream(new File( savedFileName));
	 //System.out.println("In store ftp");
	 ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
		ftp.storeFile("/test/"+ t + "", inputStream);
		System.out.println("Below ftp store");
		
		
		
					
			
		System.out.println("path----------->>"+docPath+""+ t);
			fileCount++;
			
		
		
		}
		
			resendMsg="Files Uploaded Successfully !";
			System.out.println("resendMsg" +resendMsg);
			System.out.println("Innn 4");

			
			String updateSql="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerContractMaster(CustomerName,ContractRefNo,CustomerCode,ContarctFromDate,ContarctToDate,Document,EntryBy,EntryDate) "+" values('"+custname1+"','"+ContractRefNo+"','"+companyCode+"','"+fromdatep+"','"+todate+"','"+tt+"','"+EntryBy+"','"+fr.format(date)+"')";
			   
			st4.executeUpdate(updateSql);
			
			System.out.println("\n updateSql:---"+updateSql);
			
			
			
			String updateSql11="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"CustomerBillMaster(CustomerName,CustomerCode,category,OperationalStatus,BillDay,ToId,ToCc,BillFrequency,BillType,Rate,SLARate,CustomerType,EntryBy,EntryDate) "+" values('"+custname1+"','"+companyCode+"','"+category+"','"+OperationalStatus+"','"+Billday+"','"+ToId+"','"+ToCc+"','"+Frequency+"','"+BillType+"','"+Rate+"','"+SLA+"','"+CustomerType+"','"+EntryBy+"','"+fr.format(date)+"')";
			System.out.println("else updateSql11:---"+updateSql11);
			 st3.executeUpdate(updateSql11);
			
			
	out.println("<script>  Redirect1();</script>");		
}
catch(Exception e)
{
	
	
System.out.println("Exception Copy File to FTP----------->>"+e);
e.printStackTrace();
resendMsg="Unable To Upload File Due Connection Breakup!!!";
System.out.println("resendMsg" +resendMsg);
response.sendRedirect("home.jsp?resendMsg="+resendMsg);
}

	}

   }
   conn.close();
   
   %>
  		}
	
  	}
%>
								</body>
								</html>
  							