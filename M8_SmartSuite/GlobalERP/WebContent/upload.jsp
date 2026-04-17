<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.sql.*" import=" java.text.*" import="java.util.*"  import="java.util.Date" errorPage="" %>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
	<%@ page import = "java.io.FileOutputStream"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.jibble.simpleftp.*"%>
<%@ page language="java"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.List"%>

<%@ page language="java" import="java.sql.*" import=" java.text.*"
	import=" java.util.*" errorPage=""%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="javax.mail.*" import="java.util.Properties"
	import="javax.mail.internet.InternetAddress"
	import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.servlet.http.HttpServletRequest"
	import="javax.mail.internet.MimeBodyPart"
	import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.net.URL"%>
   <%@ page import="java.net.*"%>
<%--    <%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%> --%>
<%-- <%@page import="com.sun.org.apache.xml.internal.resolver.Catalog"%> --%>
<script src="js/multifile.js"></script>

<%
String Claim_FilePath= System.getenv("Claim_FilePath");
System.out.println("Claim File Path : " + Claim_FilePath);

String itemNames="";
File savedFile;
String billno="",category="",billDate="",billby="",remarks="",billamount="",localpurpose="",up="up";
String claimtype="",clmrefno="",ourcompany="",fromdate1="",todate1="",advanceTaken="",origin="",destination="",purpose="";
String travelpurpose="",kmtraveled="",localtravelmode="",claimamt="",travelremarks="",billbytravel="";
//***************************** claim type =traval journey fare*************
String travelcategory="",travelmode="",fromdate="", hrs="",min="", todate="",hrs1="", min1="",fromplace="", toplace="", city="";
String traveldatetime="",travelhrs="", travelmin="", billNumber="", amount="",billbyT="", billComments="", companyNames="";
String companyNames1="",companyNames2="",companyNames3="", companyNames4="";
String compId=session.getAttribute("CompanyMasterID").toString();

%>
<%   //************** File Upload Code Start ************
System.out.println("$$$$$$$$$$$  uploadpage $$$$$$$$$$$$");
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	System.out.println(!isMultipart);
	if (!isMultipart) {
	} else {
		System.out.println("IN ELSE    +++++   ");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
		items = upload.parseRequest(request);
		} catch (FileUploadException e) {
				e.printStackTrace();
		}
				Iterator itr = items.iterator();
			//  String a[]=request.getParameter("");
				String a = "";
				
				while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if (item.isFormField()) {
				String name = item.getFieldName();
				System.out.println("   NMAE "+name);
				String value = item.getString();
				System.out.println("  value "+value);
				
				//***************************** claim type =traval journey fare*************
				 if (name.equals("travelcategory")) {
						travelcategory = value;
						System.out.println("@@@@@@@@@@@@ travelcategory "+travelcategory);
					}
					if (name.equals("travelmode")) {
						travelmode = value;
						System.out.println("@@@@@@@@@@@@ travelmode "+travelmode);
					}
					if (name.equals("fromdate")) {
						fromdate = value;
						System.out.println("@@@@@@@@@@@@ fromdate "+fromdate);
					}
					if (name.equals("hrs")) {
						hrs = value;
						System.out.println("@@@@@@@@@@@@ hrs "+hrs);
					}
					if (name.equals("min")) {
						min = value;
						System.out.println("@@@@@@@@@@@@ min "+min);
					}
					if (name.equals("todate")) {
						todate = value;
						System.out.println("@@@@@@@@@@@@ todate "+todate);
					}
					if (name.equals("hrs1")) {
						hrs1 = value;
						System.out.println("@@@@@@@@@@@@ hrs1 "+hrs1);
					}
					if (name.equals("min1")) {
						min1 = value;
						System.out.println("@@@@@@@@@@@@ min1 "+min1);
					}
					if (name.equals("fromplace")) {
						fromplace = value;
						System.out.println("@@@@@@@@@@@@ fromplace "+fromplace);
					}
					if (name.equals("toplace")) {
						toplace = value;
						System.out.println("@@@@@@@@@@@@ toplace "+toplace);
					}
					
					if (name.equals("city")) {
						city = value;
						System.out.println("@@@@@@@@@@@@ city "+city);
					}
					if (name.equals("traveldatetime")) {
						traveldatetime = value;
						System.out.println("@@@@@@@@@@@@ traveldatetime "+traveldatetime);
					}
					if (name.equals("travelhrs")) {
						travelhrs = value;
						System.out.println("@@@@@@@@@@@@ travelhrs "+travelhrs);
					}
					if (name.equals("travelmin")) {
						travelmin = value;
						System.out.println("@@@@@@@@@@@@ travelmin "+travelmin);
					}
					if (name.equals("billNumber")) {
						billNumber = value;
						System.out.println("@@@@@@@@@@@@ billNumber "+billNumber);
					}
					if (name.equals("amount")) {
						amount = value;
						System.out.println("@@@@@@@@@@@@ amount "+amount);
					}
					if (name.equals("billbyT")) {
						billbyT = value;
						System.out.println("@@@@@@@@@@@@ billbyT "+billbyT);
					}
					if (name.equals("billComments")) {
						billComments = value;
						System.out.println("@@@@@@@@@@@@ billComments "+billComments);
					}
					if (name.equals("companyNames")) {
						companyNames = value;
						System.out.println("@@@@@@@@@@@@ companyNames "+companyNames);
					}
					if (name.equals("companyNames1")) {
						companyNames1 = value;
						System.out.println("@@@@@@@@@@@@ companyNames1 "+companyNames1);
					}
					if (name.equals("companyNames2")) {
						companyNames2 = value;
						System.out.println("@@@@@@@@@@@@ companyNames2"+companyNames2);
					}
					if (name.equals("companyNames3")) {
						companyNames3 = value;
						System.out.println("@@@@@@@@@@@@ companyNames3 "+companyNames3);
					}
					if (name.equals("companyNames4")) {
						companyNames4 = value;
						System.out.println("@@@@@@@@@@@@ companyNames4 "+companyNames4);
					}

				if (name.equals("clmrefno")) {
					clmrefno = value;
					System.out.println("@@@@@@@@@@@@  clmrefno "+ clmrefno);
				}	
				
				if (name.equals("category")) {
					category = value;
					System.out.println ("  @@@@@@@@@@category "+ category);
				}	
				if (name.equals("billDate")) {
					billDate = value;
					System.out.println("@@@@@@@@@@@@ billDate "+ billDate);
				}	
				if (name.equals("localpurpose")) {
					localpurpose = value;
					System.out.println("@@@@@@@@@@@@ local purpose "+ localpurpose);
				}	
				
				if (name.equals("billby")) {
					billby = value;
					System.out.println(" @@@@@@@@@@@@ billby "+billby);
				}	
				if (name.equals("billno")) {
					billno = value;
					System.out.println(" @@@@@@@@@@@@ billno"+billno);
				}	
				if (name.equals("remarks")) {
					remarks = value;
					System.out.println("@@@@@@@@@@@@ remarks "+remarks);
				}
				if (name.equals("billamount")) {
					billamount = value;
					System.out.println("@@@@@@@@@@@@ billamount "+billamount);
				}
				///// *****************
				if (name.equals("ourcompany")) {
					 ourcompany = value;
					System.out.println("@@@@@@@@@@@@  ourcompany "+ ourcompany);
				}
				if (name.equals("fromdate1")) {
					fromdate1 = value;
					System.out.println("@@@@@@@@@@@@ fromdate1 "+fromdate1);
				}
				if (name.equals("todate1")) {
					todate1 = value;
					System.out.println("@@@@@@@@@@@@ todate1 "+todate1);
				}
				if (name.equals("purpose")) {
					purpose = value;
					System.out.println("@@@@@@@@@@@@ purpose "+purpose);
				}
				if (name.equals("origin")) {
					origin = value;
					System.out.println("@@@@@@@@@@@@ origin "+origin);
				}
				if (name.equals("destination")) {
					destination = value;
					System.out.println("@@@@@@@@@@@@ destination "+destination);
				}
				if (name.equals("advanceTaken")) {
					advanceTaken = value;
					System.out.println("@@@@@@@@@@@@ advanceTaken "+advanceTaken);
				}
				//  ****************** claimtype =local traval***************
				if (name.equals("travelpurpose")) {
					travelpurpose = value;
					System.out.println("@@@@@@@@@@@@ travelpurpose "+travelpurpose);
				}
				if (name.equals("kmtraveled")) {
					kmtraveled= value;
					System.out.println("@@@@@@@@@@@@ kmtraveled"+kmtraveled);
				}
				if (name.equals("localtravelmode")) {
					localtravelmode = value;
					System.out.println("@@@@@@@@@@@@ localtravelmode"+localtravelmode);
				}
				if (name.equals("claimamt")) {
					claimamt = value;
					System.out.println("@@@@@@@@@@@@ claimamt"+claimamt);
				}
				if (name.equals("travelremarks")) {
					travelremarks = value;
					System.out.println("@@@@@@@@@@@@ travelremarks "+travelremarks);
				}
				if (name.equals("billbytravel")) {
					billbytravel = value;
					System.out.println("@@@@@@@@@@@@ billbytravel "+billbytravel);
				}
				if (name.equals("claimtype")) {
					claimtype = value;
					System.out.println("@@@@@@@@@@@@ claimtype "+claimtype);
				}
				
				//***************************** claim type =traval journey fare*************
			   }else
				{
					try{
						String itemName2="";
						 itemNames = item.getName();
						System.out.print("\n\file Name==> " +itemNames);
						if(null!=itemNames && itemNames.trim() != ""){
							itemNames= itemNames.replaceAll("\\s","");
							
							   int lastIndex = itemNames.lastIndexOf(".");
							   DateFormat dateFormat = new SimpleDateFormat("ddMMMyyyyHH:mm:ss");
							   Date date1 = new Date();
							  String stre= dateFormat.format(date1);
							  System.out.println("stre is------->>>>>"+stre);
							   System.out.println("date is------->>>>>"+dateFormat.format(date1));
							   if(itemNames.indexOf(".")>=0)
							   {
								   System.out.println("itemName.indexOf"+itemNames.indexOf("."));
								   itemNames = itemNames.substring(0, lastIndex) + stre + itemNames.substring(lastIndex);
								   System.out.println("REAL itemName is------->>>>>"+itemNames);
								   itemName2=itemName2 +"," + itemNames;
								   System.out.println("values before---->>> "+ itemName2);
								      }
							   else
							   {
								   itemNames = itemNames.concat(stre);
								   System.out.println("FAKE itemName is------->>>>>"+itemNames);
								   itemName2=itemName2 + ","+itemNames +  ",";
								   System.out.println("values before---->>> "+ itemName2);
								   
							   }
							  
						
						   }

					   // String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir");

					     //savedFile = new File("/home/javaprg/TransworldDocs/100000/ERPDocs/"+ itemNames);
					      // savedFile = new File("http://twtech.in:8585/TransworldDocs/ERPDocs/"+compId+"/"+ itemNames); //working
					   //  savedFile = new File("C:\\Users\\Bhagyashri\\Desktop\\All Folders\\");
						// File savedFile = new File("/home/twtech/Desktop/test/"+ itemName);
						
						 //String FileUploadPath = "/TransworldDocs/ERPDocs/"+compId+"/";

						 //String FileUploadPath = "/home/javaprg/TransworldDocs/"+compId+"/ERPDocs/";
						 String FileUploadPath= Claim_FilePath;
						 
						 System.out.println("IIIIIII  "+FileUploadPath);
						 
							File uploadDir = new File(FileUploadPath);
							//System.out.println("IIIIIII  "+uploadDir.toString());
							savedFile = new File(FileUploadPath+"/"+itemNames);
							
					  // item.write(savedFile);
					    //String FileUploadPath ="/home/r_lakhote/transworld/TWERPV2/WebContent/ERPDocs/";
					   // String FileUploadPath ="/usr/share/tomcat6/webapps/images1/ERPClaimDocs";
					   /*  System.out.println("IIIIIII  "+savedFile);
						File uploadDir = new File(FileUploadPath);
						//System.out.println("IIIIIII  "+uploadDir.toString());
						savedFile = new File(FileUploadPath+"/"+itemNames);
						
						System.out.println("IIIIIII  "+savedFile);
						item.write(savedFile); */

						System.out.println("IIIIIII  "+savedFile);
						item.write(savedFile);

						System.out.println("Your file has been saved at the loaction:"+savedFile);
						System.out.println("HHHHHH  "+itemNames);
						  
							if(claimtype=="travelclaim" ||claimtype.equalsIgnoreCase("travelclaim"))
						{
						response.sendRedirect("ItemClaimInsert.jsp?claimtype=travelclaim&clmrefno="+clmrefno+"&ourcompany="+ourcompany+"&fromdate1="+fromdate1+"&todate1="+todate1+"&travelcategory="+travelcategory+"&purpose="+purpose+"&origin="+origin+"&destination="+destination+
															"&advanceTaken="+advanceTaken+"&travelmode="+travelmode+"&fromdate="+fromdate+"&hrs="+hrs+"&min="+min+
								                             "&todate="+todate+"&hrs1="+hrs1+"&min1="+min1+"&fromplace="+fromplace+"&toplace="+toplace+"&city="+city+
								                             "&traveldatetime="+traveldatetime+"&travelhrs="+travelhrs+"&travelmin="+travelmin+"&billNumber="+billNumber+"&amount="+amount+
								                             "&billbyT="+billbyT+"&billComments="+billComments+"&companyNames="+companyNames+"&companyNames1="+companyNames1+
								                             "&companyNames2="+companyNames2+"&companyNames3="+companyNames3+"&companyNames4="+companyNames4+
								                             "&filebill="+itemNames+"&up="+up+" ");
						}else
						{
					   	response.sendRedirect("ItemClaimInsert.jsp?claimtype=localclaim&clmrefno="+clmrefno+"&travelremarks="+travelremarks+"&billbytravel="+billbytravel+
					   										"&claimamt="+claimamt+"&travelpurpose="+travelpurpose+"&kmtraveled="+kmtraveled+"&localtravelmode="+localtravelmode+
					   										"&advanceTaken="+advanceTaken+"&destination="+destination+"&origin="+origin+"&purpose="+purpose+"&ourcompany="+ourcompany+
					   										"&fromdate1="+fromdate1+"&todate1="+todate1+"&category="+category+"&billDate="+billDate+" &localpurpose="+localpurpose+"&billno="+billno+
					   										"&billby="+billby+"&remarks="+remarks+"&filebill="+itemNames+" &billamount="+billamount+"&up="+up+" ");
						}
						}catch(Exception e)
					   {e.printStackTrace();
							response.sendRedirect("alertGoTo.jsp?msg=Uploaded File Path Not Found&goto=ItemClaimInsert.jsp?claimtype="+claimtype+"");
						
					}
			     
				}
				
		}
	}
%>
