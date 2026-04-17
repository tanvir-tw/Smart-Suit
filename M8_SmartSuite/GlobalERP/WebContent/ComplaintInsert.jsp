<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ConnectionClass"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	 
  	<%
  	String fname=(String)session.getAttribute("EmpName");
  	String email=(String)session.getAttribute("EmpEmail");
  	%> 
	<%!
	Connection conn=null;
	static int html=1;
	static int saveflag=1;
	 int count=1;
	%>
<html><head></head>
<script type="text/javascript">
function closewindow()
{
	window.close();
}
</script>
<body style="background-color: #F5F5F5">
<%
int Msg=1;
String ReportName="-",Description="-",Entby="-",Name="-",EmailID="-",Email1="-",FileName="-",Category="-";
String Priority="-",ClosingComments="-",ClosedBy="-",Status="-",PageName="-",Email2="-";
String ComplaintDateTime,ComplaintDate,UpadteDateTime;
String ContactNumber="-";
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

System.out.println("\n\n on complaint insert page");
PageName=request.getParameter("PageName");
System.out.println("@@@@@@@@@@ "+PageName);
ReportName=request.getParameter("ReportName");
Description=request.getParameter("desc");
Entby="-";
System.out.println("@@@@@@@@@@ 71");
Name=fname;
EmailID="avlsupport@mobile-eye.in";
Email1=request.getParameter("EmailID");

ContactNumber=request.getParameter("Number");

System.out.println("@@@@@@@@@@ 78");

FileName=request.getParameter("Filename");
System.out.println("@@@@@@@@@@ 81");

//String usertypevalue=session.getAttribute("empdept").toString();
System.out.println("@@@@@@@@@@ 84");
Category=request.getParameter("Category");
Priority=request.getParameter("Priority");
ComplaintDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
ComplaintDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
UpadteDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
ClosingComments="-";
ClosedBy="-";
Status="Pending";
String query="";
System.out.println("@@@@@@@@@@ 93");
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
				System.out.print("\n name==>"+name);
				String value = item.getString();
				System.out.print("\n value==>"+value);
				if(name.equals("ReportName")) 
				{
					ReportName = value;
					System.out.print("\nReport name==>"+ReportName);
					count1 = 1;
				}
				if(name.equals("description")) 
				{
					Description = value;
					System.out.print("\n Description name==>"+Description);
					count1 = 1;
				}
				if(name.equals("Entby")) 
				{
					Entby = value;
					System.out.print("\n Entby name==>"+Entby);
					count1 = 1;
				}
				if(name.equals("UserName")) 
				{
					Name = value;
					//System.out.print("\n Name==>"+Name);
					count1 = 1;
				}
				if(name.equals("EmailID")) 
				{
					Email1 = value;
					//System.out.print("\nEmailID 1==>"+Email1);
					count1 = 1;
				}
				
				if(name.equals("Number")) 
				{
					ContactNumber = value;
					//System.out.print("\n ContactNumber==>"+ContactNumber);
					count1 = 1;
				}
				if(name.equals("Category")) 
				{
					Category = value;
					//System.out.print("\n Category==>"+Category);
					count1 = 1;
				}
				if(name.equals("Priority")) 
				{
					Priority = value;
					//System.out.print("\n ContactNumber==>"+Priority);
					count1 = 1;
				}
				if(name.equals("PageName"))
				{
					PageName=value;
					count1=1;
				}
				
				System.out.println("\n $$$$$$$$$$$$$ "+PageName);

			} else {
						try {

								String itemName = item.getName();
								
								System.out.print("\n\nitemName==>"+itemName);
								/* if(itemName.equalsIgnoreCase(""))
								{
									
								} */
								if(itemName != null && itemName.trim().length() > 0)
								{
								    String envfilename = System.getenv("SMARTSUITE_COMPLAINTS");
								    savedFile = new File(envfilename + File.separator + itemName);

								    item.write(savedFile);

								    filepath[filecount] = "" + savedFile;
								    filename[filecount] = itemName;

								    filecount++;

								    if(saveflag==1)
								    {
								        savefilestring=""+savedFile;
								        saveflag++;
								    }
								    else
								    {
								        savefilestring=savefilestring+","+savedFile;
								    }

								    String screenshot=savedFile.getAbsolutePath();
								    System.out.println("screenshot--->>>"+screenshot);
								}
								/* else
								{
								String envfilename = System.getenv("SMARTSUITE_COMPLAINTS");
								savedFile = new File(envfilename+itemName);

								System.out.print("savedFile   ==>   "+savedFile);
								item.write(savedFile);
								filepath[filecount]=""+savedFile;
								
								filename[filecount]=itemName;
								filecount++;
								if(saveflag==1)
								{
								 savefilestring=""+savedFile;
								 saveflag++;
								}
								else
								savefilestring=savefilestring+","+savedFile;
								String screenshot=savedFile.getAbsolutePath();
								System.out.println("\n\nscreenshot--->>>"+screenshot);
								} */
								
							}catch(Exception e) {
	      						e.printStackTrace();
	      					}
  			}
  		}
  }
	
	Description = Description.replaceAll("\\r?\\n", " ");
	
	if(savefilestring == null || savefilestring.equals(""))
	{
	    savefilestring = "-";
	}
	Description= Description.replaceAll("'", "");
	Description= Description.replaceAll("\"", "");
	Description= Description.replaceAll("&", "");

	System.out.println("***************   216");
	if(null!=Description || null!=Category || null!=Priority)
	{
   try{
	   ConnectionClass connection = new ConnectionClass();
	   conn = connection.getConnect("db_gps");
	  	    
			Statement stmt=conn.createStatement();
			Statement st=conn.createStatement();
			Statement stgp=conn.createStatement();
			if(null == ContactNumber || ContactNumber.length()==0)
			{
				System.out.println(ContactNumber);
				ContactNumber="-";
			}
			
			if(null == Email1 || Email1.length()==0)
			{
				System.out.println(Email1);
				Email1="-";
			}
			
			if(Email1.length()>1)
			{
		         Email2=email+","+Email1;
		         Email2=Email2.replace(",",", ");
			}
			else
			{
		  	     Email2=email;
			}
			
		    String sqlinsert="insert into t_ComplaintDetail(ReportName,Description,EntBy,Name,EmailID,Email1,ContactNumber,FileName,Category,Priority,ComplaintDateTime,ClosingComment,ClosedBy,Status,Website,PageName) "+
			" values('"+ReportName+"','"+Description+"','"+Name+"','"+Name+"','"+EmailID+"','"+Email2+"','"+ContactNumber+"','"+savefilestring+"','"+Category+"','"+Priority+"','"+ComplaintDateTime+"','"+ClosingComments+"','"+ClosedBy+"','"+Status+"','Global ERP','"+PageName+"')";	
			
			System.out.println("\n\nquery sqlinsert-->>"+sqlinsert);
			
			
		  
			int i=stmt.executeUpdate(sqlinsert);
			System.out.println("Successfully inserted");
			//System.out.println("\ni=>"+i);
			
			String sqlinsert1="insert into t_historyComplaintDetail(ReportName,Description,EntBy,Name,EmailID,Email1,ContactNumber,FileName,Category,Priority,ComplaintDateTime,ClosingComment,ClosedBy,Status,Website,PageName) "+
			" values('"+ReportName+"','"+Description+"','"+Name+"','"+Name+"','"+EmailID+"','"+Email2+"','"+ContactNumber+"','"+savefilestring+"','"+Category+"','"+Priority+"','"+ComplaintDateTime+"','"+ClosingComments+"','"+ClosedBy+"','"+Status+"','Global ERP','"+PageName+"')";	
			
			System.out.println("\n\nquery sqlinsert-->>"+sqlinsert1);
		  
			int k=stmt.executeUpdate(sqlinsert1);
			System.out.println("Successfully inserted");
			//System.out.println("\nk=>"+k);
			
			String datetimemail=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ComplaintDateTime));
			
			if(i>0)
			{
				//System.out.println("\n\n i-->>"+i);
				innerflag=true;
			}
			String compid="select ComplaintID from t_ComplaintDetail where ReportName='"+ReportName+"' AND Description='"+Description+"' AND EntBy='"+Name+"' AND Email1='"+Email2+"' AND ComplaintDateTime='"+ComplaintDateTime+"' AND ContactNumber='"+ContactNumber+"'";
			System.out.println(compid);
			ResultSet rss=stmt.executeQuery(compid);
			if(rss.next())
			{
				complaintID=rss.getInt("ComplaintID");
				//System.out.println("\n\n complaintID-->>"+complaintID);
			}
			System.out.println("\n\n Complaint ID-->>"+complaintID);
						
			//Added query to add complaint to Open Issue Tracker
			String sqlinsertOIT="insert into db_GlobalERP.100000OpenIssueTracker(ComplaintID,ReportedDate,CustomerType,IssueRaisedBy,CustomerName,OpenIssue,Description,SystemName) values('"+complaintID+"','"+ComplaintDate+"','Internal','"+Name+"','Transworld','"+PageName+"','"+Description+"','GlobalERP')";	
					
			System.out.println("\n\n sqlinsertOIT------------------------>>"+sqlinsertOIT);
									  
			stmt.executeUpdate(sqlinsertOIT);
			System.out.println("Successfully inserted complaint in Open Issue Tracker");		
			
			String PageName1=this.getClass().getName();
				PageName1=PageName1.substring(PageName1.lastIndexOf(".")+1,PageName1.length());
				PageName1=PageName1.replace("_",".");
				PageName1=PageName1.replace(".005f","_");
				PageName1 = PageName1.replace(".0020"," ");
				System.out.println("PageName1   "+PageName1);
				String reportno="",reportname="";
				DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
				java.util.Date date = new java.util.Date();
				
				String SystemName ="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
				String sqlreport = "select * from db_GlobalERP.t_reportnumber where PageName = '"+PageName1+"'";
				Statement strno=conn.createStatement();
				ResultSet rsreport = strno.executeQuery(sqlreport);
				if(rsreport.next())
				{
					reportno = rsreport.getString("ReportNo");
					reportname=rsreport.getString("ReportName");
					
				}
				String heading=reportname+" "+reportno;
				System.out.println(reportno);
				
				String getEmailDetails="select * from db_gps.t_EmailReportSettings where `System`='ERP' ";
				Statement stmt11=conn.createStatement();
				ResultSet rs=stmt11.executeQuery(getEmailDetails);

				while(rs.next())
				{
					SystemName=rs.getString("System");
					Website=rs.getString("Website");
					Logo1=rs.getString("Logo1");
					Logo2=rs.getString("Logo2");
					Signature=rs.getString("Signature");
					fromLabel=rs.getString("fromLabel");
					replyToMailid=rs.getString("replyToMailid");
					Disclaimer=rs.getString("Disclaimer");

				}
			
			
	
			String comdate=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ComplaintDateTime));
			String Data="";
			Data = Data + "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
			"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
			"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
			"<img src="+Logo2+" style=^height: 70px; width: 175px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td>"+
			"<td  align = ^right^ >"+"<img src="+Logo1+"  style=^height: 80px; width: 300px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
			"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
			" <u><a href="+Website+">"+Website+"</a></u>&nbsp;"+ df.format(date) +"<br>"+heading+"</font><table><tr><td align = center style = ^margin-left:20px;^>";
			
			Data= Data + "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=90% border=0><tr><td align=left><font size=3 face=arial></br>"+Name+",<br><br>Thank you for contacting us. This is an automated response confirming the receipt of your complaint. One of our team members will get back to you as soon as possible. "
			 +"<br>For your records, the details of the complaint are listed below. When replying, please make sure that the complaint ID is copied in the subject line to ensure that your replies are tracked appropriately.</font></br></td></tr></table></td></tr>"+
			"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=90% border=1 style=^border-collapse: collapse^>"+
		"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Complaint Id  </b></font></td>"+
		"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b>  Description </b></font></td>"+
		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Report Name </b></font></td>"+
		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Category  </b></font></td>"+
		"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Status  </b></font></td>"+
		"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Priority  </b></font></td>"+
		"<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Call Me Back  </b></font></td>";
		
		Data= Data + "<tr><td align=right><font size=^2^ face=^arial^>"+complaintID+"</font></td>"+
		"<td align=left><font size=^2^ face=^arial^>"+Description+"</font></td>"+
		"<td align=left><font size=^2^ face=^arial^>"+ReportName+"</font></td>"+
		"<td align=left><font size=^2^ face=^arial^>"+Category+"</font></td>"+
		"<td align=left><font size=^2^ face=^arial^> Pending </font></td>"+
		"<td align=left><font size=^2^ face=^arial^>"+Priority+"</font></td>"+
		"<td align=right><font size=^2^ face=^arial^>"+ContactNumber+"</font></td>";
		Data= Data + "</tr></table><br/></br>";
		Data= Data+"</br></br></br></br></br>";
		Data = Data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>Transworld Global ERP Team</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762174221</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Copyright @2008 by Transworld  Technologies Ltd. All Rights Reserved.</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
		String subject="Global ERP Complaint ID: "+complaintID+" , Received from  "+Name+" on "+df.format(date)+".";

		System.out.println(Data);				
			if(i>0){
				
				try{
					 if(innerflag==true)
					 {
				               try
				               {
				                   String tocc="r_maner@transworld-compressor.com,p_khedkar@transworld-compressor.com,c_kapade@transworld-compressor.com,k_rajput@transworld-compressor.com";
				                    String q2 = "insert into db_GlobalERP.t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('Transworld','Mail for Register Complaint','"
										+ Data + "','" + subject + "','" + email + "','" + tocc + "','" + CurrentDate + "','Pending','Transworld')";
			                  	System.out.println("q2All_PendingMail>>>> :" + q2);
								stgp.executeUpdate(q2);
								
									System.out.println("inserted in all pending mail >>> 1234"); 
				                    flag=true;
				                    System.out.println("Your message has been sent");
				               }
				               catch(Exception e)
				               {
				                   System.out.print("Exception----->"+e);
				               } 
						}
						}catch(Exception e){
							e.printStackTrace();
						}        		              
				 }					       
%>
								<div
		                          style="background: #E6E6E6; font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em; color:red;width: 45%; margin-left: 25%">
	                              <blink> Thank You for your support request.</blink> </div><br>
	                             <form name="incident" style="background: #F5F5F5;" method="get">
	                             <br></br>
								   <table align="center" border="0" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 25%;">
								   <tr>
								   <td><div align ="center"><font size="3"><b> Your Complaint ID :<%=complaintID %> </b></font></div></td></tr>
								   <tr></table><br></br>
								    <table align="center" border="1" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 25%;">
							        <tr>
								   <td width="15%"><font size="2" face="Arial"><b> User Name </b></font></td><td width="25%"><font size="2" face="Arial"><%=Name %></font></td></tr><tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Email Id </b></font></td><td width="25%"><font size="2"><%=Email1 %></font></td></tr>
								    
								    <tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Category </b></font></td><td width="25%"><font size="2" face="Arial"><%=Category %></font></td></tr><tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Website</b></font></td><td width="25%"><font size="2" face="Arial"> ERP</font></td></tr><tr>
								   <td width="15%"><font size="2" face="Arial"><b> Priority </b></font></td><td width="25%"><font size="2" face="Arial"><%=Priority %></font></td></tr>  
								   <tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Report Name </b></font></td><td width="25%"><font size="2" face="Arial"><%=ReportName %></font></td></tr><tr>
								    <td width="15%"><font size="2" face="Arial"><b>Call me back</b></font></td><td width="25%"><font size="2" face="Arial"><%=ContactNumber %></font></td></tr><tr>
								    <td width="15%" valign="top"><font size="2" face="Arial"> <b>Description </b></font></td><td width="25%"><font size="2" face="Arial"><%=Description %></font></td></tr>
								  						
								</table><br>
								<table align="center" border="0" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 25%;">
								<tr>							
								   <td align="center">
								     <div align ="justify"><font size="2" color="green" face="Arial"><br></br><p>We will revert to you within 2 working days.<br>In case you need urgent assistance, <b>please note down your Complaint ID </b>and contact us on 020-41214444 or mail us on avlsupport@mobile-eye.in </p></font></div>
								   </td></tr></table><br>
								   
								   <table align="center" border="0" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 25%;">
								<tr>		
								   <td valign="bottom" align="center" colspan="2">
			                           <div><input type="submit" id="OK"
				                       name="OK" value="OK"  onclick="window.close();"/></div>
			                      </td>
			                      </tr>
			                      </table>
								   <br>
								</form>
		<%
   }
   catch(Exception e)
   {
            e.printStackTrace();
            response.sendRedirect("RegisterComplaint.jsp?desc="+Description+"&email="+Email1+"&Msg="+Msg+"&PageName1="+PageName+"&Number="+ContactNumber+"&Category="+Category+"&Priority="+Priority);
   }
	}
		%>						
	</body>
</html>