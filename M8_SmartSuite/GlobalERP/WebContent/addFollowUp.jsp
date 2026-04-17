<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.sql.*" import=" java.text.*" import="java.util.*"  import="java.util.Date" errorPage="" %>
<%-- <%@ page import="com.erp.beans.ICAL"%> --%>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
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
<%-- <%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%><script src="js/multifile.js"></script> --%>
<%@page import="java.io.FileInputStream"%>  
<%@page import="java.io.IOException"%>  
<%@page import="java.net.SocketException"%>  
<%@page import="org.apache.commons.net.ftp.FTPClient"%>
<%@page import="org.apache.commons.net.ftp.FTPReply"%>
<%!Connection con, conn, conftp, econ;
String MeetingFilePath="", MeetingFileName="";
	static int saveflag = 1;
	static int saveflag1 = 1;
	static int nameflag = 1;%>
<%
String comid=session.getAttribute("CompanyMasterID").toString();
	ArrayList l1 = new ArrayList();
	String testflag=(String)session.getAttribute("flag");
	System.out.println("flag add follow up-------------"
			+ testflag);
	String serverid = "", usernm = "", passwd = "";
	String f123 = "";
	String itemName = "", docPath = "", allfilename = "", DocumentName = "";
	int fileCount = 0;
	int doc_count = 0;
	int file_count = 0;
	String fadd="";
	String doctype1 = "", doctype2 = "", doctype3 = "", doctype4 = "", doctype5 = "", doctype6 = "", totaldocs = "",opponame="";
	String resendMsg = "", customername = "", customercode = "", customerCity = "", customerContactPerson = "", filename = "";
	String paymentFolloywup = "", reply = "", fromdate1 = "", todate1 = "", comments = "", code = "", followUpStatus = "", followUptype = "", city = "", conperson = "", company = "", doctype = "";
	String preparation = "", followuptime = "", nextfollowuptime = "", nextfollowuptype = "", hrs = "", mins = "", inout = "";
	String spokento = "", expectedamnt = "", subject = "", tocc = "",confidencelevel="", expectedon = "", ColloectionStaffName="" ,remarks = "", expdate = "", OEmail="" , selectedEmail1 = "", selectedEmail2 = "", selectedEmail = "", fname1 = "", fname2 = "", fname3 = "", fname4 = "", fname5 = "", assignedwith = "";
	String sqlassign = "",ColloectionStaffMail="",NextColloectionStaffMail="";
	String MeetingReq="";
	String FileUploadPath = "";
	String mailIDofLogger = (String) session.getAttribute("EmpEmail");
	String nxtcollectst=request.getParameter("NxtCollectionStaff");
	System.out.println("Next Col Staf Name===------------------------->"+ nxtcollectst );
	File savedFile;
	String itemNames = "";
	int count1 = 0, count2 = 0, filecount = 0, count4 = 0, count5 = 0, complaintID = 0;
	String[] strpath = new String[5];
	String[] strtype = new String[5];
	long m = 0;
	int sendmsg = 0;
	String savefilestring = "", savefilename = "", savefilename1[] = null;
	String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new java.util.Date());
	String[] filename11 = new String[10];

	String[] filepath = new String[3];
	String[] filename1 = new String[3];
	String ftpfolder="";
	
	
	/////  connection to ftp
	try {
		System.out.println("Inside FTP COnnection");
		conftp = DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
		Statement stmtftp1 = conftp.createStatement();
		System.out.println("1");
		String sqlftp = "select companymid,Companyname,FTPServer,FTPUser,FTPPassword,FTPFolder from CompanyMaster where companymid="+comid;
		System.out.println("2");
		ResultSet rsftp = stmtftp1.executeQuery(sqlftp); 
		if(rsftp.next()){
		System.out.println("3");
		serverid = rsftp.getString("FTPServer");
		System.out.println("3.1");
		usernm = rsftp.getString("FTPUser");
		System.out.println("3.2");
		passwd = rsftp.getString("FTPPassword");
		System.out.println("4");
		ftpfolder = rsftp.getString("FTPFolder");
		System.out.println("IP:" + serverid + "Uname" + usernm+ "Passwd" + passwd);
		}

	} catch (Exception e) {
		System.out.println("excee");
	}
	///
	//boolean flg = false; for FTP UP 
	//==================================File Attachment==============================================
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	String itemName2="";String docpath2="";String Pathway="";String docpathfinalized="";
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
				String value = item.getString();

				if (name.equals("fN")) {
					filename = value;
					System.out
							.println("my file Names  fn ))))))))))))))))))))))))*"
									+ filename);
				}
				if (name.equals("f1")) {
					filename = "," + value;
					System.out
							.println("my file Names  f1  ))))))))))))))))))))))))*"
									+ filename);
				}
				if (name.equals("f2")) {
					filename = "," + value;
					System.out
							.println("my file Names  f2 ))))))))))))))))))))))))*"
									+ filename);
				}
				if (name.equals("f3")) {
					filename = "," + value;
					System.out
							.println("my file Names   f3 ))))))))))))))))))))))))*"
									+ filename);
				}
				if (name.equals("f4")) {
					filename = "," + value;
					System.out
							.println("my file Names   f4 ))))))))))))))))))))))))*"
									+ filename);
				}
				if (name.equals("f5")) {
					filename = "," + value;
					System.out
							.println("my file Names  f5 ))))))))))))))))))))))))*"
									+ filename);
				}
				System.out.println("file name is *RK*  " + filename);

				if (name.equals("paymentFollowUp")) {
					paymentFolloywup = value;
				}
				//System.out.println("Followup type   ))))))))))))))))))))))))*"
				//	+ paymentFolloywup);
				if (name.equals("reply")) {
					reply = value;
				}
				System.out
						.println("reply  is      &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "
								+ reply);

				if (name.equals("fromdate")) {
					fromdate1 = value;
				}
				System.out
						.println("from Dtae  is      &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "
								+ fromdate1);
				if (name.equals("todate")) {
					todate1 = value;
				}
				System.out
						.println("Today Dtae  is      &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "
								+ todate1);
				if (name.equals("comments")) {
					comments = value;
				}
				if (name.equals("Code")) {
					code = value;
				}
				System.out
						.println("CUStomer code is&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "
								+ code);
				if (name.equals("followUpStatus")) {
					followUpStatus = value;
				}
				if (name.equals("followUpType")) {
					followUptype = value;
				}
				
				if (name.equals("MeetingReq")) {
					MeetingReq = value;
				}
				
				System.out.println("MeetingReqMeetingReqMeetingReqMeetingReqMeetingReqMeetingReq==>>>>"+MeetingReq);
				if (name.equals("city")) {
					city = value;
				}
				System.out.println("CITY IS  ============>>" + city);
				if (name.equals("contactperson")) {
					conperson = value;
				}
				System.out.println("CONTACT PERSON IS  ============>>"
						+ conperson);
				if (name.equals("Name")) {
					company = value;
				}
				if (name.equals("documentType")) {
					doctype = value;
				}
				if (name.equals("Name")) {
					customername = value;
				}
				if (name.equals("Code")) {
					customercode = value;
				}
				System.out
						.println("PROSPECT CUSTMET CODE IS==========>>"
								+ customercode);

				if (name.equals("city")) {
					customerCity = value;
				}
				if (name.equals("contactperson")) {
					customerContactPerson = value;
				}
				System.out.println("attched Files============>>"
						+ filename);
				if (name.equals("preparation")) {
					preparation = value;
				}
				if (name.equals("followuptime")) {
					followuptime = value;
				}
				if (name.equals("")) {
					followuptime = value;
				}
				if (name.equals("nextfollowUpType")) {
					nextfollowuptype = value;
				}

				if (name.equals("inorout")) {
					inout = value;
				}
				if (name.equals("spokento")) {
					spokento = value;
				}
				if (name.equals("expectedamnt")) {
					expectedamnt = value;
				}
				if (name.equals("assignedwith")) {
					assignedwith = value;
				}
				if (name.equals("expectedon")) {
					expectedon = value;
					//System.out.println("EXPCTD DTAE IS  " + expectedon);

					if (expectedon.equals("")) {
						System.out.println("in if loop      ");
						expdate = "0000-00-00";
					} else {
						expdate = new SimpleDateFormat("yyyy-MM-dd")
								.format(new SimpleDateFormat(
										"dd-MMM-yyyy")
										.parse(expectedon));
					}
				}

				//fname4

				if (name.equals("fname1")) {
					fname1 = value;
				}

				if (name.equals("fname2")) {
					fname2 = value;
				}

				if (name.equals("fname3")) {
					fname3 = value;
				}

				if (name.equals("fname4")) {
					fname4 = value;
				}

				if (name.equals("fname5")) {
					fname5 = value;
				}

				if (name.equals("remarks")) {
					remarks = value;
				}
				
				if (name.equals("CollectionStaff")) {
					ColloectionStaffName = value;
				}
				
				if (name.equals("confidencelevel")) {
					confidencelevel = value;
				}
				
				if(name.equals("NxtCollectionStaff"))
				{
					nxtcollectst=value;
				}
				if (name.equals("SelectedEmpMail")) {
					selectedEmail = value;
					//System.out.println("---------------------------------------------------((((((()))))))"+selectedEmail);
				}
				if (name.equals("SelectedEmpMail1")) {
					selectedEmail1 = value;
					//System.out.println("---------------------------------------------------((((((()))))))"+selectedEmail);
				}

				if (name.equals("SelectedEmpMail2")) {
					selectedEmail2 = value;
					//System.out.println("---------------------------------------------------((((((()))))))"+selectedEmail);
				}
				if(name.equals("OEmail"))
				{
					OEmail=value;
					
				}
				
				//++++++++++++++++++++++++++++=
				if (name.equals("documentTypeN")) {
					doctype1 = value;
				}

				if (name.equals("documentType")) {
					doctype2 = value;
				}
				if (name.equals("documentType1")) {
					doctype3 = value;
				}
				if (name.equals("documentType2")) {
					doctype4 = value;
				}
				if (name.equals("documentType3")) {
					doctype5 = value;
				}
				if (name.equals("documentType4")) {
					doctype6 = value;
				}
				
					if (name.equals("opponame")) {
						opponame = value;
					System.out.println("OPPORTUNITY NAME=====>"+opponame);
					}

				// out.println("attched Files============>>"+f123);
			} else {
				try {

					itemNames = item.getName();
					//System.out.print("\n\file Name==>  SACHIN SACHIN    s " +itemNames);
					if (itemNames.equalsIgnoreCase("")) {
					} else {
						try {
							System.out.println("HHHHHH  ");
							
							    itemNames = itemNames.replaceAll("@","");
			                	itemNames = itemNames.replaceAll("'","");
			                	itemNames = itemNames.replaceAll("^","");
			                	itemNames = itemNames.replaceAll("#","");
			                	itemNames = itemNames.replaceAll("%","");
			                	itemNames = itemNames.replaceAll("&","");
			                	itemNames = itemNames.replaceAll(" ","");
			                	itemNames = itemNames.replaceAll("/","");
							
							
							   itemName2=itemName2 +"," + itemNames;
							    
							  /*  File savedFileNew = new File("/home/javaprg/TaskAttachment/"+ itemNames);
								System.out.println("path==========>>"
										+ "/home/javaprg/TaskAttachment/"+ itemNames);

								
								docPath = ("/home/javaprg/TaskAttachment/").toString(); 
								Pathway=("/home/javaprg/TaskAttachment/").toString()+ itemNames;
								docpathfinalized=docpathfinalized+ "," + Pathway;  */
								
								 File savedFileNew = new File("/home/javaprg/followup/"+ itemNames);
								System.out.println("path==========>>"
										+ "/home/javaprg/followup/"+ itemNames);

								
								docPath = ("/home/javaprg/followup/").toString(); 
								Pathway=("/home/javaprg/followup/").toString()+ itemNames;
								docpathfinalized=docpathfinalized+ "," + Pathway; 
								
							 /* File savedFileNew = new File(config
									.getServletContext().getRealPath(
											"/")
									+ itemNames);
							System.out.println("path==========>>"
									+ (config.getServletContext()
											.getRealPath("/"))
											.toString());

							
							docPath = (config.getServletContext()
									.getRealPath("/")).toString(); */  
									
									/* File savedFileNew = new File("/home/twtech/Desktop/test/"
											+ itemNames);
									System.out.println("path==========>>"
											+ ("/home/twtech/Desktop/test/")
													.toString());

									
									docPath = ("/home/twtech/Desktop/test/").toString(); */		
							
									/*  File savedFileNew = new File("/home/twtech/Desktop/test/"+ itemNames);
									System.out.println("path==========>>"
											+ "/home/twtech/Desktop/test/"+ itemNames);

									
									docPath = ("/home/twtech/Desktop/test/").toString(); 
									Pathway=("/home/twtech/Desktop/test/").toString()+ itemNames;
									docpathfinalized=docpathfinalized+ "," + Pathway;	
									
									 
									
									 */
									
									System.out
									.println("doPath============================================>"
											+ docPath); 
							item.write(savedFileNew);

							System.out
									.println("*******file copied******");
							filepath[filecount] = "" + savedFileNew;

							filename11[filecount] = itemName;
							filecount++;
							if (saveflag == 1) {

								savefilename = itemName;
								saveflag++;

							} else {
								savefilename = savefilename + ","
										+ itemName;
								//saveflag++;

							}

							System.out
									.println("file Nammmmmmmmmmmmmmmmmmmmmmmmmmmmmmmme         RK*"
											+ savefilename
											+ "*****"
											+ itemNames);

							if (saveflag1 == 1) {
								savefilestring = "" + savedFileNew;
								saveflag1++;
							} else {
								savefilestring = savefilestring + ","
										+ savedFileNew;
								//saveflag++;
							}
							//out.print("successfully saved the file");
							//File file = new File(savedFile);
							String screenshot = savedFileNew
									.getAbsolutePath();
							System.out
									.println("\n\nscreenshot-*****************-->>>"
											+ screenshot);

							allfilename = allfilename + "," + itemNames;
							System.out
									.println("file NammmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmeRK*==========>"
											+ allfilename);

							DocumentName = allfilename;

						} catch (Exception e) {
							e.printStackTrace();
						}
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		if (doctype1.equals("Select")) {
		} else {
			totaldocs = totaldocs + "," + doctype1;
		}
		if (doctype2.equals("Select")) {
		} else {
			totaldocs = totaldocs + "," + doctype2;
		}
		if (doctype3.equals("Select")) {
		} else {
			totaldocs = totaldocs + "," + doctype3;
		}
		if (doctype4.equals("Select")) {
		} else {
			totaldocs = totaldocs + "," + doctype4;
		}
		if (doctype5.equals("Select")) {
		} else {
			totaldocs = totaldocs + "," + doctype5;
		}
		if (doctype6.equals("Select")) {
		} else {
			totaldocs = totaldocs + "," + doctype6;
		}

		System.out.println("The document 1 " + doctype1);
		System.out.println("The document 2 " + doctype2);
		System.out.println("The document 3 " + doctype3);
		System.out.println("The document 4 " + doctype4);
		System.out.println("The document 5 " + doctype5);
		System.out.println("The document 6 " + doctype6);

		//strtype = totaldocs.split(",");
		//strpath = totaldocs.split(",");
		StringTokenizer st = new StringTokenizer(totaldocs, ",");
		doc_count = st.countTokens();

		StringTokenizer st1 = new StringTokenizer(savefilestring, ",");
		file_count = st1.countTokens();

		System.out.println("No of doc type ==>" + doc_count);
		System.out.println("No of str path ==>" + file_count);

		System.out.println("The total documents " + totaldocs);
		System.out
				.println("file Name=======================*******=====================>"
						+ filename);
		System.out.println("The total***************** files "
				+ savefilestring);

		if (savefilename != "") {
			//filename
			savefilename = savefilename.trim();
			if (savefilename.charAt(0) == ',') {
				savefilename = savefilename.substring(1).trim();
			}
			System.out.println("File is name " + savefilename);

			//filepath
			if (savefilestring.charAt(0) == ',') {
				savefilestring = savefilestring.substring(1).trim();
			}
		}

		System.out.println("File is path " + savefilestring);

		if ((paymentFolloywup == null) || (paymentFolloywup == "")) {
			paymentFolloywup = "NO";
		} else {
			paymentFolloywup = "Yes";
		}

		if ((reply == null) || (reply == "")) {
			reply = "No";
		} else {
			reply = "Yes";
		}

		if (inout.equals("") || inout.equals("out")) {
			inout = "OUT";
		} else {
			inout = "IN";
		}

		System.out.println("IN OUT VALUE  " + inout);
		System.out
				.println("&*****************************************  "
						+ assignedwith);
		//FTP CODE HERE DOWN SHOAIB
		//------

		//=====Copy 2 FTP===============================================================================================
		try {
			System.out.println("Inside COpy FTPPP" + allfilename);
			if (allfilename.equalsIgnoreCase("")) {

			} else {
				// get an ftpClient object  
				FTPClient ftpClient = new FTPClient();
				FileInputStream inputStream = null;
				//ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
				ftpClient.connect(serverid);
				//// pass username and password, returned true if authentication is +usernm+":"+passwd+"@"+serverid+" 
				// successful  
				boolean login = ftpClient.login(usernm,passwd);
				System.out.println("LOGINSTATUS===>" + login);
				f123 = allfilename;
				System.out
						.println("FILENNNNNNNNNNNNNNNMMMMMMMMMMMMMMEEEEEE"
								+ f123);

				System.out.println("After catch  -----");
				//Statement stmt=conn.createStatement();
				System.out.println("After catch  -----111");
				boolean flg = false, filestatus = false;
				System.out.println("After catch  ----2222-");
				System.out
						.println("values for FTP*********************"
								+ f123);
				String delims12 = ",";
				String[] tokens12 = f123.split(delims12);
				System.out.println("valllll" + tokens12[0] + "ttt "
						+ tokens12[1] + " tttt length===>"
						+ tokens12.length);
				for (int i = 1; i < tokens12.length; i++) {

					if (login) {
						System.out.println("Connection established...");

						System.out.println("new FilePATH====>"+docPath + "" + tokens12[i] + ftpfolder+comid+"/"+ tokens12[i]);
inputStream = new FileInputStream(new File(docPath + "" + tokens12[i]));
ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
System.out.println("9999999999999999999999"+inputStream);
/* boolean uploaded = ftpClient.storeFile(ftpfolder+comid+"/"+ tokens12[i] + "", inputStream);
 */		/* boolean uploaded = ftpClient.storeFile("/home/twtech/Desktop/test/"+ inputStream);
		 */	
		 boolean uploaded;
		 if(!(itemNames.equalsIgnoreCase("")) || !(itemNames.equalsIgnoreCase(null))){
  uploaded = true;
  itemName2=itemName2.substring(1);
  System.out.println("ITEMNAME 2 ISS:-" + itemName2);
  docpathfinalized=docpathfinalized.substring(1);
	//docpath2=docpath2.substring(1);
	System.out.println("docpath final is---->>"+ docpathfinalized);

		 }
		 else
		 {
			 uploaded = false; 
			 itemName2="";
			   System.out.println("ITEMNAME 2 ISS:-" + itemName2);
			   docpathfinalized="";
				//docpath2=docpath2.substring(1);
				System.out.println("docpath final is---->>"+ docpathfinalized);

		 }
	
 System.out.println("UPLOADED STATUS====>"
								+ uploaded);
						if (uploaded) {
							System.out
									.println("File uploaded successfully !");
						} else {
							System.out
									.println("Error in uploading file !");
						}
					}

					//////////////////////////////////////////////////////////////////////////////////////////////////////				
					System.out.println("t val--ttttt---" + tokens12[i]);
					flg = false;
					//ftp.Method = Net.WebRequestMethods.Ftp.ListDirectory;
					//ftp.UsePassive = false;
					System.out
							.println("new FilePATH====>" + docPath + ""
									+ tokens12[i] + "/test/"
									+ tokens12[i]);
					/*	try
						{
						 filestatus=ftp.stor(new FileInputStream(new File(docPath+""+tokens12[i])), "/test/"+tokens12[i]+"");
						// filestatus=ftp.stor("/home/r_kunjir/Desktop/images", "/test/"+tokens12[i]+"");
						 
						}catch(Exception e)
						{
							System.out.println("fileee==>"+e);
						}
						
						System.out.println("file STATUS====>"+filestatus);
						System.out.println("path----------->>"+docPath+"/"+tokens12[i]);
						fileCount++;
					 */
					//====Check If File Exist=================================================
	/*				try {
						URLConnection m_client = null;
						try {

							URL url = new URL("ftp://"+usernm+":"+passwd+"@"+serverid+"/.."+ftpfolder+comid+"/"+tokens12[i]);
							System.out.println("U-----------------------------"+url);
							//URL url = new URL("ftp://vpedutech:vpedutech@ twdb.fleetview.in/../test/"+ tokens12[i]);
							m_client = url.openConnection();
							System.out.println("*******************1"
									+ m_client);
							InputStream is = m_client.getInputStream();
							System.out.println("*******************2");
							BufferedInputStream bis = new BufferedInputStream(
									is);
							/*
							  OutputStream os = new FileOutputStream("xyz.txt");
							  BufferedOutputStream bos = new BufferedOutputStream(os);
							 */
			/*				System.out.println("*******************3");
							byte[] buffer = new byte[1024];
							int readCount = 0;

							if ((readCount = bis.read(buffer)) > 0) {
								System.out
										.println("**********File Verified*************");
							}
							flg = true;
						} catch (FileNotFoundException e1) {
							System.out
									.println("**********File Not Here!!!!*************");
							l1.add(tokens12[i]);
						} catch (Exception e) {
							System.out
									.println("Exception--for ftp file checking---->>"
											+ e);
							l1.add(tokens12[i]);
						}
						ftpClient.completePendingCommand();
					    ftpClient.logout();
						
						//@@@@@@Copy To DB@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
						if (flg == true) {
							try {
								java.util.Date today = new java.util.Date();
								String todaydate = new SimpleDateFormat(
										"yyyy-MM-dd").format(today);
								String todaytime = new SimpleDateFormat(
										"HH:mm:ss").format(today);
								//String  sqlInsert="INSERT INTO leaveapplication_vpedutech."+session.getAttribute("CompanyMasterID").toString()+"uploadedFiles (FileName,UploadedBy,FileStatus,inwardedBy,inwardDateTime)VALUES('"+t+"','"+session.getAttribute("empname").toString()+"','uploaded','-','-')";
								//System.out.println(sqlInsert);
								//stmt.executeUpdate(sqlInsert);
								resendMsg = "Files uploaded successfully";

							} catch (Exception e) {
								System.out
										.println("Exception===========>>"
												+ e);
								l1.add(tokens12[i]);
							}
						}
						//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

					} catch (Exception e) {
						System.out.println("Outer Exception ------>>"
								+ e);
					}
					 
				*/	 
					//========================================================================
				}
				if (l1.size() != 0) {
					resendMsg = "Unable To Upload Files " + l1;
				} else {
					resendMsg = "Files Uploaded Successfully !";
				}
				//response.sendRedirect("followupEntryForm.jsp?resendMsg="+resendMsg);
			}//end of else
		} catch (Exception e) {
			System.out
					.println("Exception Copy File to FTP----------->>"
							+ e + "ftppp");
			resendMsg = "Unable To Upload File Due Connection Breakup!!!";
			response.sendRedirect("followupEntryForm.jsp?resendMsg="
					+ resendMsg);
		}
		//====================================================================================================

		//FTP CODE HERE UP RK

	}

	System.out.println("Below value ----+" + todate1 + "frm date"
			+ fromdate1);

	hrs = todate1.substring(todate1.indexOf(" ") + 1, todate1
			.indexOf(":"));
	System.out.println("Below value ----+" + hrs);
	mins = todate1.substring(todate1.indexOf(":") + 1);
	System.out.println("Below value ----+" + mins);

	System.out.println("The fromdate is ==>" + fromdate1
			+ "  The todate is ===>" + todate1 + " Hrs ==>" + hrs
			+ "  Mins ==>" + mins);

	String fromdate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm")
					.parse(fromdate1));
	String todate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm")
					.parse(todate1));

	System.out.println("******The fromdate is CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC==>" + fromdate
			+ "  The todate is ===>" + todate);
	String flag = session.getAttribute("flag").toString();

	System.out.println("flag--------------------+" + flag);
	//if(flg == true)
	//	{     for FTP UP

		
		System.out.println("Colloection Staff Name=========================>>>>>>>>>>>>>>>>>>>>>>>" +ColloectionStaffName);
		
	if (flag.equalsIgnoreCase("company")) {
		String msg = "";
		String Mailmsg="";
		
		try {
			String sqlInsert = "";
			String existedDriver = "";

			String sql = "";
			comments = comments.replaceAll("'", " ").replaceAll("-",
					" ");
			if (itemName != "") {
				System.out.println("IN CUSTOMER IF");

				if (!(Integer.parseInt(assignedwith) == 000)) {
					System.out.println("====Inside the if===");
					System.out
							.println("Assigned with  " + assignedwith);
					sqlassign = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
							+ " 	opportunityname,ProspCustCode ,FollowUpDate ,FollowUpTime , ColloectionStaffName, Status ,confidencelevel,FollowUpType, FollowUpInOut,"
							+ "	Comments ,NextFollowUpDate , NextFollowUpTime,NextFollowUpType,Preparation,"
							+ " 	MarketingRepcode , City , ContactPerson ,"
							+ "	ProspCustName , "
							+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentName,DocumentCount,DocumentStatus,NextColloectionStaffName) VALUES "
							+ "   ('"
							+ opponame
							+ "','"		
							+ code
							+ "','"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ ColloectionStaffName
							+"','"
							+ followUpStatus
							
							+"','"+confidencelevel
							
							+ "','Assigned','"
							+ inout
							+ "','"
							+ comments.replaceAll("'", " ")
							+ "','"
							+ todate
							+ "','"
							+ hrs
							+ ":"
							+ mins
							+ ":00','"
							+ nextfollowuptype
							+ "','"
							+ preparation.replaceAll("'", " ")
							+ "',"
							+ "	'"
							+ assignedwith
							+ "','"
							+ city
							+ "','"
							+ conperson
							+ "',"
							+ "	'"
							+ company
							+ "','"
							+ paymentFolloywup
							+ "','"
							+ spokento.replaceAll("'", " ")
							+ "','"
							+ expectedamnt
							+ "','"
							+ expdate
							+ "','"
							+ remarks.replaceAll("'", " ")
							+ "','"
							+ reply
							+ "','"
							+ DocumentName
							+ "','"
							+ doc_count + "','Upload','"
							+ nxtcollectst
							+"')";
					System.out
							.println("In customer if loop if item name is null under if "
									+ sqlassign);
					System.out.println("====Inside the if>>===");

				}

				sql = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
						+ " opportunityname,ProspCustCode ,FollowUpDate ,FollowUpTime ,	ColloectionStaffName, Status  ,confidencelevel,FollowUpType, FollowUpInOut,"
						+ "	Comments ,NextFollowUpDate , NextFollowUpTime,NextFollowUpType,Preparation,"
						+ " 	MarketingRepcode , City , ContactPerson ,"
						+ "	ProspCustName , "
						+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentName,DocumentCount,DocumentStatus,NextColloectionStaffName) VALUES "
						+ "   ('"
						+ opponame
						+ "','"
						+ code
						+ "','"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ ColloectionStaffName
						+ "','"
						+ followUpStatus
						
						+",'"+confidencelevel
						
						+ "', "
						+ "	'"
						+ followUptype
						+ "','"
						+ inout
						+ "','"
						+ comments.replaceAll("'", " ")
						+ "','"
						+ todate
						+ "','"
						+ hrs
						+ ":"
						+ mins
						+ ":00','"
						+ nextfollowuptype
						+ "','"
						+ preparation.replaceAll("'", " ")
						+ "',"
						+ "	'"
						+ session.getAttribute("EmpCode")
						+ "','"
						+ city
						+ "','"
						+ conperson
						+ "',"
						+ "	'"
						+ company
						+ "','"
						+ paymentFolloywup
						+ "','"
						+ spokento.replaceAll("'", " ")
						+ "','"
						+ expectedamnt
						+ "','"
						+ expdate
						+ "','"
						+ remarks.replaceAll("'", " ")
						+ "','"
						+ reply
						+ "','"
						+ DocumentName
						+ "','"
						+ doc_count
						+ "','Upload','"
						+nxtcollectst
						+"')";
				System.out
						.println("In customer if loop if item name is null "
								+ sql);
				System.out.println("====Inside the if>>>>>>>>>!!===");

			} else {
				System.out.println("IN CUSTOMER else ");
				//System.out.println("====Inside the else>>>===");

				if (!(Integer.parseInt(assignedwith) == 000)) {//System.out.println("====Inside the else>>if>===");
					sqlassign = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
							+ " 	opportunityname,ProspCustCode, 	FollowUpDate, FollowUpTime, ColloectionStaffName, Status,confidencelevel, 	FollowUpType, FollowUpInOut,"
							+ "	Comments 	,NextFollowUpDate 	,NextFollowUpTime,NextFollowUpType,Preparation,"
							+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
							+ "	ProspCustName , "
							+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentName,DocumentCount,DocumentStatus,NextColloectionStaffName) VALUES "
							+ "   ('"
									+ opponame
									+ "','"
							+ code
							+ "','"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ ColloectionStaffName
							+ "','"
							+ followUpStatus
							
							+"','"+confidencelevel
							
							+ "','Assigned','"
							+ inout
							+ "','"
							+ comments.replaceAll("'", " ")
							+ "','"
							+ todate
							+ "','"
							+ hrs
							+ ":"
							+ mins
							+ ":00','"
							+ nextfollowuptype
							+ "','"
							+ preparation.replaceAll("'", " ")
							+ "',"
							+ "	'"
							+ assignedwith
							+ "','"
							+ city
							+ "','"
							+ conperson
							+ "',"
							+ "	'"
							+ company
							+ "','"
							+ paymentFolloywup
							+ "','"
							+ spokento.replaceAll("'", " ")
							+ "','"
							+ expectedamnt
							+ "','"
							+ expdate
							+ "','"
							+ remarks.replaceAll("'", " ")
							+ "','"
							+ reply
							+ "','"
							+ DocumentName
							+ "','"
							+ doc_count + "','Upload','"
							+ nxtcollectst+ "')" ;
					System.out
							.println("In customer else loop if item name is null under "
									+ sqlassign);
					System.out
							.println("====Inside the e>>>>>>>lse>>>===");

				}

				sql = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
						+ " 	opportunityname,ProspCustCode, 	FollowUpDate, FollowUpTime,	ColloectionStaffName, Status, confidencelevel,	FollowUpType, FollowUpInOut,"
						+ "	Comments 	,NextFollowUpDate 	,NextFollowUpTime,NextFollowUpType,Preparation,"
						+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
						+ "	ProspCustName , "
						+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentName,DocumentCount,DocumentStatus,NextColloectionStaffName) VALUES "
						+ "   ('"
								+ opponame
								+ "','"
						+ code
						+ "','"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ ColloectionStaffName
						+ "','"
						+ followUpStatus
						
						+"','"+confidencelevel
						
						+ "', "
						+ "	'"
						+ followUptype
						+ "','"
						+ inout
						+ "','"
						+ comments.replaceAll("'", " ")
						+ "','"
						+ todate
						+ "','"
						+ hrs
						+ ":"
						+ mins
						+ ":00','"
						+ nextfollowuptype
						+ "','"
						+ preparation.replaceAll("'", " ")
						+ "',"
						+ "	'"
						+ session.getAttribute("EmpCode")
						+ "','"
						+ city
						+ "','"
						+ conperson
						+ "',"
						+ "	'"
						+ company
						+ "','"
						+ paymentFolloywup
						+ "','"
						+ spokento.replaceAll("'", " ")
						+ "','"
						+ expectedamnt
						+ "','"
						+ expdate
						+ "','"
						+ remarks.replaceAll("'", " ")
						+ "','"
						+ reply
						+ "','"
						+ DocumentName
						+ "','"
						+ doc_count
						+ "','Upload','"
						+ nxtcollectst+"')";

				System.out
						.println("In customer else loop if item name is null  "
								+ sql);
				System.out.println("====Ins>>>>>>>>>>>>>>>e>>>===>");

			}
			//System.out.println("**************************************&&&&&&&&&&&&&*********************"+selectedEmail);
			//System.out.println("add followup into the table-----------------shoaib ssssshoaib"+sql);

			try {

				System.out.println("Here We Are Sending mail");
				Class.forName(DB_Driver);
				con = DriverManager.getConnection(DB_NAME, DB_USERNAME,
						DB_PASSWORD);

				conn = DriverManager.getConnection(
						"jdbc:mysql://"+host1+"/db_GlobalERP",user1,
						pass1);
				//conn=DriverManager.getConnection("jdbc:myNxtCollectionStaffsql:// twdb.fleetview.in/db_gps","erp","1@erp");

				//44
				Statement stmt = con.createStatement();
				Statement stmt1 = con.createStatement();
				Statement stdocs = con.createStatement();
				Statement stgp = conn.createStatement();
				Statement stgp2 = conn.createStatement();
				Statement stgp3 = conn.createStatement();

			try{	//62
				
				//Statement stgp1 = conn.createStatement();

				stmt.executeUpdate(sql);

				if (!(Integer.parseInt(assignedwith) == 000)) {
					stmt1.executeUpdate(sqlassign);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 				}
				msg="Yes";
			}catch (Exception e) {
				e.printStackTrace();
				
				msg = "No";
				//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
			}
                                                                                                                                                                                                                                                                                                                                                                                                    
				//Insert the document into table
				String docutype1 = "-", docutype2 = "-", docutype3 = "-", docutype4 = "-", docutype5 = "-", docutype6 = "-";
				String fileName1 = "-", fileName2 = "-", fileName3 = "-", fileName4 = "-", fileName5 = "-", fileName6 = "-";
				String filePath1 = "-", filePath2 = "-", filePath3 = "-", filePath4 = "-", filePath5 = "-", filePath6 = "-";
				String docsql = "";

				System.out.println("Total docs =====>" + totaldocs);
				System.out.println("Total files =====>"
						+ savefilestring);
				System.out.println("File count ===>" + file_count);

				StringTokenizer st = new StringTokenizer(totaldocs, ",");
				StringTokenizer st1 = new StringTokenizer(
						savefilestring, ",");
				if (file_count == 1) {
					docutype1 = st.nextToken();
					filePath1 = st1.nextToken();
					fileName1 = filePath1.substring(filePath1
							.lastIndexOf('/') + 1);
				}
				if (file_count == 2) {
					docutype1 = st.nextToken();
					docutype2 = st.nextToken();
					filePath1 = st1.nextToken();
					filePath2 = st1.nextToken();
					fileName1 = filePath1.substring(filePath1
							.lastIndexOf('/') + 1);
					fileName2 = filePath2.substring(filePath2
							.lastIndexOf('/') + 1);
				}
				if (file_count == 3) {
					System.out.println("===Inside 3");
					docutype1 = st.nextToken();
					docutype2 = st.nextToken();
					docutype3 = st.nextToken();
					filePath1 = st1.nextToken();
					filePath2 = st1.nextToken();
					filePath3 = st1.nextToken();
					fileName1 = filePath1.substring(filePath1
							.lastIndexOf('/') + 1);
					fileName2 = filePath2.substring(filePath2
							.lastIndexOf('/') + 1);
					fileName3 = filePath3.substring(filePath3
							.lastIndexOf('/') + 1);
				}
				if (file_count == 4) {
					docutype1 = st.nextToken();
					docutype2 = st.nextToken();
					docutype3 = st.nextToken();
					docutype4 = st.nextToken();
					filePath1 = st1.nextToken();
					filePath2 = st1.nextToken();
					filePath3 = st1.nextToken();
					filePath4 = st1.nextToken();
					fileName1 = filePath1.substring(filePath1
							.lastIndexOf('/') + 1);
					fileName2 = filePath2.substring(filePath2
							.lastIndexOf('/') + 1);
					fileName3 = filePath3.substring(filePath3
							.lastIndexOf('/') + 1);
					fileName4 = filePath4.substring(filePath4
							.lastIndexOf('/') + 1);
				}
				if (file_count == 5) {
					docutype1 = st.nextToken();
					docutype2 = st.nextToken();
					docutype3 = st.nextToken();
					docutype4 = st.nextToken();
					docutype5 = st.nextToken();
					filePath1 = st1.nextToken();
					filePath2 = st1.nextToken();
					filePath3 = st1.nextToken();
					filePath4 = st1.nextToken();
					filePath5 = st1.nextToken();
					fileName1 = filePath1.substring(filePath1
							.lastIndexOf('/') + 1);
					fileName2 = filePath2.substring(filePath2
							.lastIndexOf('/') + 1);
					fileName3 = filePath3.substring(filePath3
							.lastIndexOf('/') + 1);
					fileName4 = filePath4.substring(filePath4
							.lastIndexOf('/') + 1);
					fileName5 = filePath5.substring(filePath5
							.lastIndexOf('/') + 1);
				}
				if (file_count == 6) {
					docutype1 = st.nextToken();
					docutype2 = st.nextToken();
					docutype3 = st.nextToken();
					docutype4 = st.nextToken();
					docutype5 = st.nextToken();
					docutype6 = st.nextToken();
					filePath1 = st1.nextToken();
					filePath2 = st1.nextToken();
					filePath3 = st1.nextToken();
					filePath4 = st1.nextToken();
					filePath5 = st1.nextToken();
					filePath6 = st1.nextToken();
					fileName1 = filePath1.substring(filePath1
							.lastIndexOf('/') + 1);
					fileName2 = filePath2.substring(filePath2
							.lastIndexOf('/') + 1);
					fileName3 = filePath3.substring(filePath3
							.lastIndexOf('/') + 1);
					fileName4 = filePath4.substring(filePath4
							.lastIndexOf('/') + 1);
					fileName5 = filePath5.substring(filePath5
							.lastIndexOf('/') + 1);
					fileName6 = filePath6.substring(filePath6
							.lastIndexOf('/') + 1);
				}
				//System.out.println(">>>>>File Name 1 ==>"+fileName1);
				//System.out.println(">>>>>File Name 2 ==>"+fileName2);
				//System.out.println(">>>>>File Name 3 ==>"+fileName3);
				//System.out.println(">>>>>File Name 4 ==>"+fileName4);
				//System.out.println(">>>>>File Name 5 ==>"+fileName5);
				//System.out.println(">>>>>File Name 6 ==>"+fileName6);

				if (file_count == 0) {
					docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count + "')";
				}
				if (file_count == 1) {
					docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count
							+ "','"
							+ docutype1
							+ "','"
							+ fileName1 + "','" + filePath1 + "')";

				} else if (file_count == 2) {
					docsql = "insert into followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count
							+ "','"
							+ docutype1
							+ "','"
							+ fileName1
							+ "','"
							+ filePath1
							+ "','"
							+ docutype2
							+ "','"
							+ fileName2
							+ "','"
							+ filePath2 + "')";

				} else if (file_count == 3) {
					docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count
							+ "','"
							+ docutype1
							+ "','"
							+ fileName1
							+ "','"
							+ filePath1
							+ "','"
							+ docutype2
							+ "','"
							+ fileName2
							+ "','"
							+ filePath2
							+ "','"
							+ docutype3
							+ "','"
							+ fileName3 + "','" + filePath3 + "')";

				} else if (file_count == 4) {
					docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3,doctype4,docname4,docpath4) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count
							+ "','"
							+ docutype1
							+ "','"
							+ fileName1
							+ "','"
							+ filePath1
							+ "','"
							+ docutype2
							+ "','"
							+ fileName2
							+ "','"
							+ filePath2
							+ "','"
							+ docutype3
							+ "','"
							+ fileName3
							+ "','"
							+ filePath3
							+ "','"
							+ docutype4
							+ "','"
							+ fileName4
							+ "','"
							+ filePath4 + "')";

				} else if (file_count == 5) {
					docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3,doctype4,docname4,docpath4,doctype5,docname5,docpath5) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count
							+ "','"
							+ docutype1
							+ "','"
							+ fileName1
							+ "','"
							+ filePath1
							+ "','"
							+ docutype2
							+ "','"
							+ fileName2
							+ "','"
							+ filePath2
							+ "','"
							+ docutype3
							+ "','"
							+ fileName3
							+ "','"
							+ filePath3
							+ "','"
							+ docutype4
							+ "','"
							+ fileName4
							+ "','"
							+ filePath4
							+ "','"
							+ docutype5
							+ "','"
							+ fileName5 + "','" + filePath5 + "')";

				} else//file count == 6
				{
					docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3,doctype4,docname4,docpath4,doctype5,docname5,docpath5,doctype6,docname6,docpath6) values('"
							+ fromdate
							+ "','"
							+ followuptime
							+ "','"
							+ file_count
							+ "','"
							+ docutype1
							+ "','"
							+ fileName1
							+ "','"
							+ filePath1
							+ "','"
							+ docutype2
							+ "','"
							+ fileName2
							+ "','"
							+ filePath2
							+ "','"
							+ docutype3
							+ "','"
							+ fileName3
							+ "','"
							+ filePath3
							+ "','"
							+ docutype4
							+ "','"
							+ fileName4
							+ "','"
							+ filePath4
							+ "','"
							+ docutype5
							+ "','"
							+ fileName5
							+ "','"
							+ filePath5
							+ "','"
							+ docutype6
							+ "','"
							+ fileName6
							+ "','"
							+ filePath6 + "')";

				}
				System.out.println("Query of docs insert"+docsql);
				stdocs.executeUpdate(docsql);

				boolean flag1 = false;
				//System.out.println("**************************************&&&&&&&&&&&&&*********************"+selectedEmail);
					
	econ= DriverManager.getConnection(DB_NAME, DB_USERNAME,DB_PASSWORD);
	Statement est = econ.createStatement();
	
	System.out.println("Assign To:"+assignedwith);
	String esql="select MarketingRepEMail from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepCode='"+assignedwith+"'";
	ResultSet rs1=est.executeQuery(esql);
	if(rs1.next())
	{
	fadd=rs1.getString("MarketingRepEMail");	
	
	}
	
	System.out.println("Assign To:"+fadd);
				try {
					//===============================================Send Email Start (SHOAIB)========================================
					DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
					java.util.Date date = new java.util.Date();		
					String data = "";
					/* String website="http://www.safeandsecure.in"; */
					//System.out.println("-----------------------------------"+company+"111111111111111111"+code);
					//System.out.println("-----------------------------------"+customername+"111111111111111111"+customercode);

					if (code != "" || company != null) {
						System.out
								.println("===11111111111111111111111111===");
						data = data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
								"<body><table    border=^0^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
								"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
								"</a></td>"+
								"<td  align = ^right^ ></td></tr></table> <font style=^color: #D8D8D8^>"+
								"<img src=DatabaseAccess?id="+session.getAttribute("CompanyMasterID").toString()+" align=^left^ height=^50^ width=^200^></img>"+
								"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
								""+ df.format(date) +"<br>"+"</font><table><tr><td align = center style = ^margin-left:20px;^>";
						//		data= data + "<table width=100% > ";
								data= data + "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=170% border=0><tr><td align=left><font size=3 face=arial><b> Follow-Up Entry </b></font></br></td></tr></table></td></tr>"+
								"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=170% border=1 style=^border-collapse: collapse^>"+
							"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 12%;^><font size=^2^ face=^arial^><b> Company  </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>  Date </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Comments </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Next Follow-Up  </b></font></td>"+
							
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Status  </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Next Follow-Up Type </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Payment Followup </b></font></td>"+
							
									
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Contact Person  </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Spoken To </b></font></td>";
							
							
					data= data + "<tr><td align=left><font size=^2^ face=^arial^>"+company+"</font></td>"+
								"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(fromdate))+"</font>&nbsp;&nbsp;<font size=^2^ face=^arial^>"+followuptime +"</font></td>"+
											"<td align=left><font size=^2^ face=^arial^>"+comments+"</font></td>"+
											"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(todate))
							+ "  "
							+ hrs
							+ ":"
							+ mins +"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+followUpStatus+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+nextfollowuptype+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+paymentFolloywup+"</font></td>"+
							
							"<td align=left><font size=^2^ face=^arial^>"+customerContactPerson+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+spokento+"</font></td>";
							
							
							
					data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

					data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
					data= data + "</tr></body></html>";
						System.out
								.println("in DDDDDDDDDDDDDDDDAta====="
										+ data);
					} else if (customercode != ""
							|| customername != null) {
						System.out
								.println("====22222222222222222222222===");
						data = data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
								"<body><table    border=^0^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
								"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
								"</a></td>"+
								"<td  align = ^right^ >"+"</td></tr></table> <font style=^color: #D8D8D8^>"+
								"______________________________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
								""+ df.format(date) +"<br>"+"</font><table><tr><td align = center style = ^margin-left:20px;^>";
						//		data= data + "<table width=100% > ";
								data= data + "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=170% border=0><tr><td align=left><font size=3 face=arial><b> Follow-Up Entry </b></font></br></td></tr></table></td></tr>"+
								"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=170% border=1 style=^border-collapse: collapse^>"+
							"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 12%;^><font size=^2^ face=^arial^><b> Company  </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Date </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Comments</b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Next Follow-Up</b></font></td>"+
							
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Status</b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Next Follow-Up Type</b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Payment Followup</b></font></td>"+

							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b>Contact Person</b></font></td>"+
							"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b>Spoken To</b></font></td>";
							
							
					data= data + "<tr><td align=left><font size=^2^ face=^arial^>"+company+"</font></td>"+
								"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(fromdate))+"</font>&nbsp;&nbsp;<font size=^2^ face=^arial^>"+followuptime +"</font></td>"+
											"<td align=left><font size=^2^ face=^arial^>"+comments+"</font></td>"+
											"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(todate))
							+ "   "
							+ hrs
							+ ":"
							+ mins +"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+followUpStatus+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+nextfollowuptype+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+paymentFolloywup+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+customerContactPerson+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+spokento+"</font></td>";
							
							
							
					data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

					data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
					data= data + "</tr></body></html>";
					
					System.out.println("Start==>"+data);

					
								System.out.println("in DDDDDDDDDDDDDDDDAta====="
												+ data);
							}

					String collectionmail="select * from "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster where name='"+ColloectionStaffName+"'";
					ResultSet rscoll=stgp3.executeQuery(collectionmail);
					if(rscoll.next())
					{
						ColloectionStaffMail=rscoll.getString("email");
					}
					
					String nextcollectionmail="select * from "+session.getAttribute("CompanyMasterID").toString()+"collectionStaffMaster where name='"+nxtcollectst+"'";
					ResultSet rscollnext=stgp2.executeQuery(nextcollectionmail);
					if(rscollnext.next())
					{
						NextColloectionStaffMail=rscollnext.getString("email");
					}
							
							subject = "Follow-Up Details for "+company+" on "+ df.format(date)+" .";

							String vall = "Yes", vall11 = "Yes", vall22 = "Yes";

							if (selectedEmail != null
									&& !(selectedEmail.equals(""))
									&& !(selectedEmail.equals("-"))) {
								tocc = selectedEmail;
								vall = "No";
							}
							
							if (selectedEmail1 != null
									&& !(selectedEmail1.equals(""))
									&& !(selectedEmail1.equals("-"))) {
								if (vall.equalsIgnoreCase("No")) {
									tocc = tocc + "," + selectedEmail1;

								} else {
									tocc = selectedEmail1;

								}
								vall11 = "No";

							}
							if (selectedEmail2 != null
									&& !(selectedEmail2.equals(""))
									&& !(selectedEmail2.equals("-"))) {
								if (vall.equalsIgnoreCase("No")
										|| vall11.equalsIgnoreCase("No")) {
									tocc = tocc + "," + selectedEmail2;

								} else {
									tocc = selectedEmail2;

								}
							}
							
							if(OEmail.equalsIgnoreCase("null") || OEmail.equalsIgnoreCase(""))
							{
								System.out.println("NULL ======================");
							}
							else
							{
								System.out.println("NOT NULL ======================");
								if(tocc.equalsIgnoreCase("null")||tocc.equalsIgnoreCase(""))
								{
									tocc=OEmail;
								}
								else
								{
									tocc=tocc+","+OEmail;
								}
							}
							
					tocc=tocc +","+fadd;
					mailIDofLogger=mailIDofLogger+","+ColloectionStaffMail+","+NextColloectionStaffMail;
					System.out.println("To cc value is===================================== " + tocc);
					String q2 = "";

					if (MeetingReq != null && MeetingReq != "") 
					{
							  try{
	 					//com.erp.beans.ICAL ic=new com.erp.beans.ICAL();
	 					//ic.createCalEntry("Follow-Up Meeting "+customername, todate, hrs, mins, session.getAttribute("EMP_FullNAME").toString(),mailIDofLogger);
	 					//MeetingFileName=ic.GetFileName();
	 					//MeetingFilePath= ic.GetFilePath();
						}catch(Exception e){}  
					 System.out.println("Meeting Request 1=====>>>>" +MeetingReq);
					 itemName2=itemName2.trim();
					 docpathfinalized=docpathfinalized.trim();
					 if((itemName2.equalsIgnoreCase("")) || (itemName2.equalsIgnoreCase(null))){
						 String doctypes=   MeetingFileName ;
							String filePathtotal=	(MeetingFilePath+MeetingFileName ) ;
							System.out.println("File Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ doctypes);
							System.out.println("File Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ filePathtotal);
										
							q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Follow Up Details','Mail for Follow Up','"
									+ data
									+ "','"
									+ subject
									+ "','"
									+ mailIDofLogger
									+ "','"
									+ tocc
									+ "','"
									+ CurrentDate + "','Pending','Transworld','"+doctypes+"','"+filePathtotal+"')";
										
							
					 }
					 else
					 {
					String doctypes=  itemName2 + ","+ MeetingFileName ;
					String filePathtotal=docpathfinalized+","+ 	(MeetingFilePath+MeetingFileName ) ;
					 				
					System.out.println("File Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ doctypes);
					System.out.println("File Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ filePathtotal);
					q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Follow Up Details','Mail for Follow Up','"
							+ data
							+ "','"
							+ subject
							+ "','"
							+ mailIDofLogger
							+ "','"
							+ tocc
							+ "','"
							+ CurrentDate + "','Pending','Transworld','"+doctypes+"','"+filePathtotal+"')";
								
					
					 
					 
					 
					 }
				

						
						
					}
					else{
						/* String doctypes=MeetingFileName + ","+ docutype1 +	 ","+	docutype2 +	  "," + docutype3 +  "," +	docutype4 + "," + docutype5 +	"," + docutype6 ;
						 */
						 String doctypes=  itemName2 ;
							String filePathtotal=docpathfinalized ;
							
								
						System.out.println("File Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ doctypes);
						System.out.println("File Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ filePathtotal);
						

						
						
						q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Follow Up Details','Mail for Follow Up','"
							+ data
							+ "','"
							+ subject
							+ "','"
							+ mailIDofLogger
							+ "','"
							+ tocc
							+ "','"
							+ CurrentDate + "','Pending','Transworld','"+doctypes+"','"+filePathtotal+"')";
					}
					System.out.println("q2All_PendingMailmmmmmmmmmmmmmmm>>>> :" + q2);
					stgp.executeUpdate(q2);
					System.out.println("inserted in all pending mail >>> 1234");

					Mailmsg = "MailYes";

					//response.sendRedirect("home.jsp?msg="+msg);

				}// end of inner try
				catch (Exception e) {
					e.printStackTrace();
					System.out
							.println("Sorry, your mail cannot be sent due to Congestion----->"
									+ e);
					Mailmsg = "MailNO";
					//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
				}

				//===============================================Send Email End========================================

			} catch (Exception e) {
				//e.printStackTrace();
				//msg = "N";
				//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
			}

			System.out
					.println("compnn-------111111222------------------------------******----->"
							+ msg);
			if(msg.equalsIgnoreCase("Yes"))
			{
				//msg="Error in adding followup Entry";
				//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
				response.sendRedirect("alertGoTo.jsp?msg=Followup Added Successfully&goto=home.jsp");
			}
			else if(msg.equalsIgnoreCase("No"))
			{
				//msg="Follow up entry Added successfully";
				//response.sendRedirect("followupEntryForm.jsp?msg=" + msg);
				response.sendRedirect("alertGoTo.jsp?msg=Error inadding Followup &goto=followupEntryForm.jsp");
			}
			else
			{
				response.sendRedirect("home.jsp");
			}
			
				
			

			

		} catch (Exception e) {
			//e.printStackTrace();
			//msg="Error in followupentry";
			//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
		}

	} else {
		
		
		String msg = "";
		String Mailmsg="";
		try{
	
		System.out
				.println("PROSPECT*******Test Site******************");
		String drvName = fromdate;

		System.out.println(drvName);
		String vehcode = todate;

		String sql = "";
		String sqlInsert = "";
		String existedDriver = "";
		comments = comments.replaceAll("'", " ").replaceAll("-", " ");

		if (itemName != "") {
			System.out.println("IN PROSPECT IF    ");
			if (!(Integer.parseInt(assignedwith) == 000)) {
				sqlassign = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
						+ " 	opportunityname,ProspCustCode, 	FollowUpDate, 	Status, confidencelevel,	FollowUpType, ColloectionStaffName,NextColloectionStaffName"
						+ "	Comments 	,NextFollowUpDate ,NextFollowUpTime,NextFollowUpType,Preparation,"
						+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
						+ "	ProspCustName , "
						+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentCount ,DocumentStatus) VALUES "
						+ "   ('"
								+ opponame
								+ "','"
						+ customercode
						+ "','"
						+ fromdate
						+ "','"
						+ followUpStatus
						+"','"+confidencelevel
						+ "','Assigned','"
						+ ColloectionStaffName
						+ nxtcollectst
						+ comments.replaceAll("'", " ")
						+ "','"
						+ todate
						+ "','"
						+ hrs
						+ ":"
						+ mins
						+ ":00','"
						+ nextfollowuptype
						+ "','"
						+ preparation.replaceAll("'", " ")
						+ "',"
						+ "	'"
						+ assignedwith
						+ "','"
						+ customerCity
						+ "','"
						+ customerContactPerson
						+ "',"
						+ "	'"
						+ customername
						+ "','"
						+ paymentFolloywup
						+ "','"
						+ spokento.replaceAll("'", " ")
						+ "','"
						+ expectedamnt
						+ "','"
						+ expdate
						+ "','"
						+ remarks.replaceAll("'", " ")
						+ "','"
						+ reply
						+ "','" + doc_count + "','Upload')"
						+ "','"
						+ nxtcollectst;
			}

			sql = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
					+ " 	opportunityname,ProspCustCode, 	FollowUpDate, 	Status,confidencelevel, 	FollowUpType, ColloectionStaffName,NextColloectionStaffName"
					+ "	Comments 	,NextFollowUpDate ,NextFollowUpTime,NextFollowUpType,Preparation,"
					+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
					+ "	ProspCustName , "
					+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentCount ,DocumentStatus) VALUES "
					+ "   ('"
							+ opponame
							+ "','"
					+ customercode
					+ "','"
					+ fromdate
					+ "','"
					+ followUpStatus
					+"','"+confidencelevel
					+ "', "
					+ "	'"
					+ followUptype
					+ "','"
					+ ColloectionStaffName
					+ nxtcollectst
					+ comments.replaceAll("'", " ")
					+ "','"
					+ todate
					+ "','"
					+ hrs
					+ ":"
					+ mins
					+ ":00','"
					+ nextfollowuptype
					+ "','"
					+ preparation.replaceAll("'", " ")
					+ "',"
					+ "	'"
					+ session.getAttribute("EmpCode")
					+ "','"
					+ customerCity
					+ "','"
					+ customerContactPerson
					+ "',"
					+ "	'"
					+ customername
					+ "','"
					+ paymentFolloywup
					+ "','"
					+ spokento.replaceAll("'", " ")
					+ "','"
					+ expectedamnt
					+ "','"
					+ expdate
					+ "','"
					+ remarks.replaceAll("'", " ")
					+ "','"
					+ reply
					+ "','" + doc_count + "','Upload')";

			System.out.println("IN PROSPECT IF -------------" + sql);

		} else {
			System.out.println("IN PROSPECT ElSE    ");

			if (!(Integer.parseInt(assignedwith) == 000)) {
				sqlassign = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
						+ " 	opportunityname,ProspCustCode, 	FollowUpDate, 	Status,confidencelevel, FollowUpType, ColloectionStaffName,NextColloectionStaffName"
						+ "	Comments 	,NextFollowUpDate ,NextFollowUpTime,NextFollowUpType,Preparation,"
						+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
						+ "	ProspCustName , "
						+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentCount ,DocumentStatus) VALUES "
						+ "   ('"
								+ opponame
								+ "','"
						+ customercode
						+ "','"
						+ fromdate
						+ "','"
						+ followUpStatus
						+"','"+confidencelevel
						+ "','Assigned','"
						+ ColloectionStaffName
						+ nxtcollectst
						+ comments.replaceAll("'", " ")
						+ "','"
						+ todate
						+ "','"
						+ hrs
						+ ":"
						+ mins
						+ ":00','"
						+ nextfollowuptype
						+ "','"
						+ preparation.replaceAll("'", " ")
						+ "',"
						+ "	'"
						+ assignedwith
						+ "','"
						+ customerCity
						+ "','"
						+ customerContactPerson
						+ "',"
						+ "	'"
						+ customername
						+ "','"
						+ paymentFolloywup
						+ "','"
						+ spokento.replaceAll("'", " ")
						+ "','"
						+ expectedamnt
						+ "','"
						+ expdate
						+ "','"
						+ remarks.replaceAll("'", " ")
						+ "','"
						+ reply
						+ "','" + doc_count + "','Upload')";
			}

			sql = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"followup ( "
					+ " 	opportunityname,ProspCustCode, 	FollowUpDate, 	Status,confidencelevel, FollowUpType, ColloectionStaffName,NextColloectionStaffName"
					+ "	Comments 	,NextFollowUpDate ,NextFollowUpTime,NextFollowUpType,Preparation,"
					+ " 	MarketingRepcode ,	City ,	ContactPerson  ,"
					+ "	ProspCustName , "
					+ "   PaymentFollowup ,SpokenTo ,AmountExpected ,AmountExpectedOn ,Remarks ,Reply ,DocumentCount ,DocumentStatus) VALUES "
					+ "   ('"
							+ opponame
							+ "','"
					+ customercode
					+ "','"
					+ fromdate
					+ "','"
					+ followUpStatus
					+"','"+confidencelevel
					+ "', "
					+ "	'"
					+ followUptype
					+ ColloectionStaffName
					+ nxtcollectst
					+ "','"
					+ comments.replaceAll("'", " ")
					+ "','"
					+ todate
					+ "','"
					+ hrs
					+ ":"
					+ mins
					+ ":00','"
					+ nextfollowuptype
					+ "','"
					+ preparation.replaceAll("'", " ")
					+ "',"
					+ "	'"
					+ session.getAttribute("EmpCode")
					+ "','"
					+ customerCity
					+ "','"
					+ customerContactPerson
					+ "',"
					+ "	'"
					+ customername
					+ "','"
					+ paymentFolloywup
					+ "','"
					+ spokento.replaceAll("'", " ")
					+ "','"
					+ expectedamnt
					+ "','"
					+ expdate
					+ "','"
					+ remarks.replaceAll("'", " ")
					+ "','"
					+ reply
					+ "','" + doc_count + "','Upload')";

		}

		System.out
				.println("IN PROSPECT ElSE add followup...... -------------"
						+ sql);

		try {
			Class.forName(DB_Driver);
			con = DriverManager.getConnection(DB_NAME, DB_USERNAME,
					DB_PASSWORD);

			conn = DriverManager
					.getConnection("jdbc:mysql://"+host1+"/db_GlobalERP",
							user1,pass1);
			//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_gps","erp","1@erp");

			Statement stgp = conn.createStatement();
			Statement stgp1 = conn.createStatement();
	
			//44
			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();
			Statement stdocs = con.createStatement();
			try
			{
			stmt.executeUpdate(sql);
			if (!(Integer.parseInt(assignedwith) == 000)) {
				stmt1.executeUpdate(sqlassign);
				msg = "Yes";
			}
			}catch (Exception e) {
				e.printStackTrace();
				
				msg = "No";
				//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
			}

			//Insert the document into table
			String docutype1 = "-", docutype2 = "-", docutype3 = "-", docutype4 = "-", docutype5 = "-", docutype6 = "-";
			String fileName1 = "-", fileName2 = "-", fileName3 = "-", fileName4 = "-", fileName5 = "-", fileName6 = "-";
			String filePath1 = "-", filePath2 = "-", filePath3 = "-", filePath4 = "-", filePath5 = "-", filePath6 = "-";
			String docsql = "";

			System.out.println("Total docs =====>" + totaldocs);
			System.out.println("Total files =====>" + savefilestring);
			System.out.println("File count ===>" + file_count);

			StringTokenizer st = new StringTokenizer(totaldocs, ",");
			StringTokenizer st1 = new StringTokenizer(savefilestring,
					",");
			if (file_count == 1) {
				docutype1 = st.nextToken();
				filePath1 = st1.nextToken();
				fileName1 = filePath1.substring(filePath1
						.lastIndexOf('/') + 1);
			}
			if (file_count == 2) {
				docutype1 = st.nextToken();
				docutype2 = st.nextToken();
				filePath1 = st1.nextToken();
				filePath2 = st1.nextToken();
				fileName1 = filePath1.substring(filePath1
						.lastIndexOf('/') + 1);
				fileName2 = filePath2.substring(filePath2
						.lastIndexOf('/') + 1);
			}
			if (file_count == 3) {
				System.out.println("===Inside 3");
				docutype1 = st.nextToken();
				docutype2 = st.nextToken();
				docutype3 = st.nextToken();
				filePath1 = st1.nextToken();
				filePath2 = st1.nextToken();
				filePath3 = st1.nextToken();
				fileName1 = filePath1.substring(filePath1
						.lastIndexOf('/') + 1);
				fileName2 = filePath2.substring(filePath2
						.lastIndexOf('/') + 1);
				fileName3 = filePath3.substring(filePath3
						.lastIndexOf('/') + 1);
			}
			if (file_count == 4) {
				docutype1 = st.nextToken();
				docutype2 = st.nextToken();
				docutype3 = st.nextToken();
				docutype4 = st.nextToken();
				filePath1 = st1.nextToken();
				filePath2 = st1.nextToken();
				filePath3 = st1.nextToken();
				filePath4 = st1.nextToken();
				fileName1 = filePath1.substring(filePath1
						.lastIndexOf('/') + 1);
				fileName2 = filePath2.substring(filePath2
						.lastIndexOf('/') + 1);
				fileName3 = filePath3.substring(filePath3
						.lastIndexOf('/') + 1);
				fileName4 = filePath4.substring(filePath4
						.lastIndexOf('/') + 1);
			}
			if (file_count == 5) {
				docutype1 = st.nextToken();
				docutype2 = st.nextToken();
				docutype3 = st.nextToken();
				docutype4 = st.nextToken();
				docutype5 = st.nextToken();
				filePath1 = st1.nextToken();
				filePath2 = st1.nextToken();
				filePath3 = st1.nextToken();
				filePath4 = st1.nextToken();
				filePath5 = st1.nextToken();
				fileName1 = filePath1.substring(filePath1
						.lastIndexOf('/') + 1);
				fileName2 = filePath2.substring(filePath2
						.lastIndexOf('/') + 1);
				fileName3 = filePath3.substring(filePath3
						.lastIndexOf('/') + 1);
				fileName4 = filePath4.substring(filePath4
						.lastIndexOf('/') + 1);
				fileName5 = filePath5.substring(filePath5
						.lastIndexOf('/') + 1);
			}
			if (file_count == 6) {
				docutype1 = st.nextToken();
				docutype2 = st.nextToken();
				docutype3 = st.nextToken();
				docutype4 = st.nextToken();
				docutype5 = st.nextToken();
				docutype6 = st.nextToken();
				filePath1 = st1.nextToken();
				filePath2 = st1.nextToken();
				filePath3 = st1.nextToken();
				filePath4 = st1.nextToken();
				filePath5 = st1.nextToken();
				filePath6 = st1.nextToken();
				fileName1 = filePath1.substring(filePath1
						.lastIndexOf('/') + 1);
				fileName2 = filePath2.substring(filePath2
						.lastIndexOf('/') + 1);
				fileName3 = filePath3.substring(filePath3
						.lastIndexOf('/') + 1);
				fileName4 = filePath4.substring(filePath4
						.lastIndexOf('/') + 1);
				fileName5 = filePath5.substring(filePath5
						.lastIndexOf('/') + 1);
				fileName6 = filePath6.substring(filePath6
						.lastIndexOf('/') + 1);
			}
			//System.out.println(">>>>>File Name 1 ==>"+fileName1);
			//System.out.println(">>>>>File Name 2 ==>"+fileName2);
			//System.out.println(">>>>>File Name 3 ==>"+fileName3);
			//System.out.println(">>>>>File Name 4 ==>"+fileName4);
			//System.out.println(">>>>>File Name 5 ==>"+fileName5);
			//System.out.println(">>>>>File Name 6 ==>"+fileName6);

			if (file_count == 0) {
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count + "')";
			}
			if (file_count == 1) {
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count
						+ "','"
						+ docutype1
						+ "','"
						+ fileName1 + "','" + filePath1 + "')";

			} else if (file_count == 2) {
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count
						+ "','"
						+ docutype1
						+ "','"
						+ fileName1
						+ "','"
						+ filePath1
						+ "','"
						+ docutype2
						+ "','"
						+ fileName2
						+ "','"
						+ filePath2 + "')";

			} else if (file_count == 3) {
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count
						+ "','"
						+ docutype1
						+ "','"
						+ fileName1
						+ "','"
						+ filePath1
						+ "','"
						+ docutype2
						+ "','"
						+ fileName2
						+ "','"
						+ filePath2
						+ "','"
						+ docutype3
						+ "','"
						+ fileName3 + "','" + filePath3 + "')";

			} else if (file_count == 4) {
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3,doctype4,docname4,docpath4) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count
						+ "','"
						+ docutype1
						+ "','"
						+ fileName1
						+ "','"
						+ filePath1
						+ "','"
						+ docutype2
						+ "','"
						+ fileName2
						+ "','"
						+ filePath2
						+ "','"
						+ docutype3
						+ "','"
						+ fileName3
						+ "','"
						+ filePath3
						+ "','"
						+ docutype4
						+ "','"
						+ fileName4
						+ "','"
						+ filePath4 + "')";

			} else if (file_count == 5) {
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3,doctype4,docname4,docpath4,doctype5,docname5,docpath5) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count
						+ "','"
						+ docutype1
						+ "','"
						+ fileName1
						+ "','"
						+ filePath1
						+ "','"
						+ docutype2
						+ "','"
						+ fileName2
						+ "','"
						+ filePath2
						+ "','"
						+ docutype3
						+ "','"
						+ fileName3
						+ "','"
						+ filePath3
						+ "','"
						+ docutype4
						+ "','"
						+ fileName4
						+ "','"
						+ filePath4
						+ "','"
						+ docutype5
						+ "','"
						+ fileName5 + "','" + filePath5 + "')";

			} else//file count == 6
			{
				docsql = "insert into "+session.getAttribute("CompanyMasterID").toString()+"followupdocs(followupdate,followuptime,doccount,doctype1,docname1,docpath1,doctype2,docname2,docpath2,doctype3,docname3,docpath3,doctype4,docname4,docpath4,doctype5,docname5,docpath5,doctype6,docname6,docpath6) values('"
						+ fromdate
						+ "','"
						+ followuptime
						+ "','"
						+ file_count
						+ "','"
						+ docutype1
						+ "','"
						+ fileName1
						+ "','"
						+ filePath1
						+ "','"
						+ docutype2
						+ "','"
						+ fileName2
						+ "','"
						+ filePath2
						+ "','"
						+ docutype3
						+ "','"
						+ fileName3
						+ "','"
						+ filePath3
						+ "','"
						+ docutype4
						+ "','"
						+ fileName4
						+ "','"
						+ filePath4
						+ "','"
						+ docutype5
						+ "','"
						+ fileName5
						+ "','"
						+ filePath5
						+ "','"
						+ docutype6
						+ "','"
						+ fileName6
						+ "','"
						+ filePath6 + "')";

			}
			stdocs.executeUpdate(docsql);
			//System.out.println("**************************************&&&&&&&&&&&&&*********************"+selectedEmail);

			//code for customer mail
			//===============================================Send Email Start========================================
			try {

				String Data = "";
				if (code != "" || company != null)//
				{
					Data = "Respected Sir/Madam,\n\nYour Follow-Up Details Are As Follows.\nCompany Name: "
							+ company
							+ ""
							+ "\nFollow-Up Date: "
							+ new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(fromdate))
							+ ""
							+ "\nFollow-Up Time: "
							+ followuptime
							+ ""
							+ "\nComments: "
							+ comments
							+ ""
							+ "\nStatus: "
							+ followUpStatus
							+ ""
							+ "\nNext Follow-Up Date: "
							+ new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd").parse(todate))
							+ "  "
							+ hrs
							+ ":"
							+ mins
							+ ""
							+ "\nNext Follow-Up Type: "
							+ nextfollowuptype
							+ ""
							+ "\nPreparation for next Followup: "
							+ preparation
							+ ""
							+ "\nPayment Followup: "
							+ paymentFolloywup
							+ ""
							+ "\nSpoken To: "
							+ spokento
							+ ""
							+ "\nContact Person: "
							+ conperson
							+ ""
							+ "\nCity: "
							+ city
							+ ""
							+ "\nRemark: " + remarks + "";
					System.out.println("in DDDDDDDDDDDDDDDDAta====="
							+ Data);
				} else if (customercode != "" || customername != null) {
					Data = "Respected Sir/Madam,\n\nYour Follow-Up Details Are As Follows.\nCompany Name: "
							+ company
							+ ""
							+ "\nFollow-Up Date: "
							+ new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(fromdate))
							+ ""
							+ "\nFollow-Up Time: "
							+ followuptime
							+ " "
							+ "\nComments: "
							+ comments
							+ ""
							+ "\nStatus: "
							+ followUpStatus
							+ ""
							+ "\nNext Follow-Up Date: "
							+ new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd").parse(todate))
							+ "  "
							+ hrs
							+ ":"
							+ mins
							+ ""
							+ "\nNext Follow-Up Type: "
							+ nextfollowuptype
							+ ""
							+ "\nPreparation for next Followup: "
							+ preparation
							+ ""
							+ "\nPayment Followup: "
							+ paymentFolloywup
							+ ""
							+ "\nSpoken To: "
							+ spokento
							+ ""
							+ "\nContact Person: "
							+ conperson
							+ ""
							+ "\nCity: "
							+ city
							+ ""
							+ "\nRemark: " + remarks + "";
					System.out.println("in DDDDDDDDDDDDDDDDAta====="
							+ Data);
				}

				Data = Data
						+ "\n\n\n Thanks and Regards,\n Transworld Team";
				subject = "Follow-Up Details . This is a autogenerated mail please do not reply to it.";

				//selectedEmail selectedEmail1 selectedEmail2
				String vall = "Yes", vall11 = "Yes", vall22 = "Yes";

				if (selectedEmail != null
						&& !(selectedEmail.equals(""))
						&& !(selectedEmail.equals("-"))) {
					tocc = selectedEmail;
					vall = "No";
				}

				if (selectedEmail1 != null
						&& !(selectedEmail1.equals(""))
						&& !(selectedEmail1.equals("-"))) {
					if (vall.equalsIgnoreCase("No")) {
						tocc = tocc + "," + selectedEmail1;

					} else {
						tocc = selectedEmail1;

					}
					vall11 = "No";

				}
				if (selectedEmail2 != null
						&& !(selectedEmail2.equals(""))
						&& !(selectedEmail2.equals("-"))) {
					if (vall.equalsIgnoreCase("No")
							|| vall11.equalsIgnoreCase("No")) {
						tocc = tocc + "," + selectedEmail2;

					} else {
						tocc = selectedEmail2;

					}
				}
				
				if(OEmail.equalsIgnoreCase("null") || OEmail.equalsIgnoreCase(""))
				{
					System.out.println("NULL ======================");
				}
				else
				{
					System.out.println("NOT NULL ======================");
					if(tocc.equalsIgnoreCase("null")||tocc.equalsIgnoreCase(""))
					{
						tocc=OEmail;
					}
					else
					{
						tocc=tocc+","+OEmail;
					}
				}
				tocc=tocc+","+fadd;
				mailIDofLogger=mailIDofLogger+","+ColloectionStaffMail+","+NextColloectionStaffMail;
				System.out.println("To cc value is " + tocc);
				String q2 = "";
				if (MeetingReq != null && MeetingReq != "") 
				{
					System.out.println("Meeting Request 2=====>>>>" +MeetingReq);
					
					
					
					 try{
 					//com.erp.beans.ICAL ic=new com.erp.beans.ICAL();
 					//ic.createCalEntry("Follow-Up Meeting "+customername, todate, hrs, mins, session.getAttribute("EMP_FullNAME").toString(),mailIDofLogger);
 					//MeetingFileName=ic.GetFileName();
 					//MeetingFilePath= ic.GetFilePath();
					}catch(Exception e){} 
					 itemName2=itemName2.trim();
					 docpathfinalized=docpathfinalized.trim();
					 if((itemName2.equalsIgnoreCase("")) || (itemName2.equalsIgnoreCase(null))){
						 String doctypes=   MeetingFileName ;
							String filePathtotal=	(MeetingFilePath+MeetingFileName ) ;
							System.out.println("File Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ doctypes);
							System.out.println("File Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ filePathtotal);
							q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Follow Up Details','Mail for Follow Up','"
									+ Data
									+ "','"
									+ subject
									+ "','"
									+ mailIDofLogger
									+ "','"
									+ tocc
									+ "','"
									+ CurrentDate + "','Pending','Transworld','"+doctypes+"','"+filePathtotal+"')";
						
							
											
				
					 }
					 else
					 {
					String doctypes=  itemName2 + ","+ MeetingFileName ;
					String filePathtotal=docpathfinalized+","+ 	(MeetingFilePath+MeetingFileName ) ;
					 				
					System.out.println("File Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ doctypes);
					System.out.println("File Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ filePathtotal);
					                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Follow Up Details','Mail for Follow Up','"
							+ Data
							+ "','"
							+ subject
							+ "','"
							+ mailIDofLogger
							+ "','"
							+ tocc
							+ "','"
							+ CurrentDate + "','Pending','Transworld','"+doctypes+"','"+filePathtotal+"')";
					 }
				}else{
					System.out.println("Meeting Request 44444444444444=====>>>>" +MeetingReq);
					String doctypes=  itemName2 ;
					String filePathtotal=docpathfinalized  ;
					
					
				
					System.out.println("File Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ doctypes);
					System.out.println("File Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+ filePathtotal);
					

					q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Follow Up Details','Mail for Follow Up','"
							+ Data
							+ "','"
							+ subject
							+ "','"
							+ mailIDofLogger
							+ "','"
							+ tocc
							+ "','"
							+ CurrentDate + "','Pending','Transworld','"+doctypes+"','"+filePathtotal+"')";
							}
					try {
					System.out.println("q2All_PendingMail>>>> :" + q2);
				    stgp.executeUpdate(q2);

					System.out.println("inserted in all pending mail");
					//msg = "Yes";

					response.sendRedirect("home.jsp?msg=" + msg);

				} catch (Exception e) {
					e.printStackTrace();
				}

			}// end of inner try
			catch (Exception e) {
				e.printStackTrace();
				System.out
						.println("Sorry, your mail cannot be sent due to Congestion----->"
								+ e);
			}
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

			//===============================================Send Email End========================================

			//msg = "Yes";
			
			//response.sendRedirect("home.jsp?msg=" + msg);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "Error in followupentry";
			response.sendRedirect("followupEntryForm.jsp?msg=" + msg);
		}
		
		System.out
		.println("compnn---------------------Prospects1111222----------------******----->"
				+ msg);
if(msg.equalsIgnoreCase("Yes"))
{
	//msg="Error in adding followup Entry";
	//response.sendRedirect("followupEntryForm.jsp?msg="+msg);
	response.sendRedirect("alertGoTo.jsp?msg=Followup Added Successfully&goto=home.jsp");
	//response.sendRedirect("alertGoTo.jsp?msg=Claim updated with ID "+claimId+" &goto=claimAfterSubmit.jsp");
			
}
else if(msg.equalsIgnoreCase("No"))
{
	//msg="Follow up entry Added successfully";session factory interface to get the object of session,session interface to insert,update,delete the object
	//response.sendRedirect("followupEntryForm.jsp?msg=" + msg);
	//transaction object specifies atomic unit of work.methods for transaction management.
	//transaction factory-factory of transaction. it is optional.
	response.sendRedirect("alertGoTo.jsp?msg=Error in   adding Followup &goto=followupEntryForm.jsp");
}
else
{
	response.sendRedirect("home.jsp");
}
		
		}catch (Exception e) {
			e.printStackTrace();
			msg = "Error in followupentry";
			response.sendRedirect("followupEntryForm.jsp?msg=" + msg);
		}
		//msg = "Yes";
		//System.out.println("compnn-------------------------------------******----->"+ msg);
						
		//response.sendRedirect("home.jsp?msg=" + msg);

	}
	
%>
</body>
</html>