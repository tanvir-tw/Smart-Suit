<%@page import="java.util.Date"%><%@ page import="java.sql.* " %>
<%@page import="java.util.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.*" %>
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
<%!Connection conn=null; %>
<%!Connection conn1=null; %>
<%!Statement st=null; %>
<%!Statement st1=null; %>
<%!Statement st2=null; %>
<%!Statement st3=null; %>
<%!Statement st4=null; %>
<%!int MaxCustCode=0; %>
<%
try
{
Class.forName("com.mysql.cj.jdbc.Driver");
//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/TWSQL_TWALLDATA","erp","1@erp");
conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_GlobalERP","erp","1@erp");
conn1=DriverManager.getConnection("jdbc:mysql://10.0.10.62/db_gps","erp","1@erp");
 st = conn.createStatement();	
 st1 = conn.createStatement();
 st2 = conn.createStatement();
 st3 = conn1.createStatement();
 st4 = conn.createStatement();
 
 
}
catch(Exception e)
{
	System.out.println("Exception=========>>"+e);
}
 String companyName="";
 String address="";
 String emailID="";
 String state="";
 String addState="";
 String city="-";
 String addCity="";
 String pinCode="";;
 String contactPerson="";
 String phoneNumber="";
 String mobNumber="";
 String message="";
 
 int deptID=0;
 
 int saveflag=1;
 File savedFile;
 String[] filepath =new String[10];
 String[] filename =new String[10];
 String savefilestring="";
 int  count2 = 0, filecount = 0, count4 = 0, count5 = 0,count6 = 0,complaintID=0;
 Boolean innerflag=false;
 Boolean flag=false;
 Writer output = null;

  int count=1;

 
int count1=0;
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
                //      System.out.print("\n\n items==>"+items);
                } catch (FileUploadException e) {
                        e.printStackTrace();
                }
                Iterator itr = items.iterator();
        
        while (itr.hasNext()) {
                        FileItem item = (FileItem) itr.next();
                        if(item.isFormField()) 
                        {
                                String name1 = item.getFieldName();
                                System.out.print("\n name==>"+name1);
                                String value = item.getString();
                                System.out.print("\n value==>"+value);
                                if(name1.equals("com_name")) 
                                {
                                	    companyName = value;
                                        System.out.print("\n companyName==>"+companyName);
                                        
                                        count1++;
                                }
                                if(name1.equals("address")) 
                                {
                                		address = value;
                                        System.out.print("\n address==>"+address);
                                        
                                        count1++;
                                }
                                if(name1.equals("email")) 
                                {
                                		emailID = value;
                                        System.out.print("\n emailID==>"+emailID);
                                        count1++;
                                }
                                if(name1.equals("state")) 
                                {
                                		state = value;
                                        System.out.print("\n state==>"+state);
                                        count1++;
                                }
                                if(name1.equals("add_state")) 
                                {
                                		addState = value;
                                        System.out.print("\n addState==>"+addState);
                                        count1++;
                                }                             
                                if(name1.equals("city")) 
                                {
                                		city = value;
                                        System.out.print("\n city==>"+city);
                                        count1++;
                                } 
                                if(name1.equals("add_city")) 
                                {
                                		addCity = value;
                                        System.out.print("\n addCity==>"+addCity);
                                        count1++;
                                }                               
                                if(name1.equals("pin")) 
                                {
                                		pinCode = value;
                                        System.out.print("\n pinCode==>"+pinCode);
                                        count1++;
                                }
                                if(name1.equals("contact_person")) 
                                {
                                		contactPerson = value;
                                        System.out.print("\n contactPerson==>"+contactPerson);
                                        count1++;
                                }
                                
                                if(name1.equals("phone_num")) 
                                {
                                		phoneNumber = value;
                                        System.out.print("\n phoneNumber==>"+phoneNumber);
                                        count1++;
                                }
                                if(name1.equals("mob_num")) 
                                {
                                		mobNumber = value;
                                        System.out.print("\n mobNumber==>"+mobNumber);
                                        count1++;
                                }
                                if(name1.equals("msg")) 
                                {
                                		message = value;
                                        System.out.print("\n message==>"+message);
                                        count1++;
                                }
                               
                        } else {
                                       try {

                                             String itemName = item.getName();
                                             System.out.print("\n\nitemName==>"+itemName);
                                              if(itemName.equalsIgnoreCase(""))
                                              {
                                              }
                                            else
                                             {
                                             
                                             //savedFile = new File(config.getServletContext().getRealPath("/")+"Complaints/"+itemName);
                                            //   System.out.println("in doc uploading");
                                            	 String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir"); 
                                            //	 System.out.println("in doc uploading 1");
                                            	 File uploadDir = new File(FileUploadPath);
                                            //	 System.out.println("in doc uploading 2");
                                            	savedFile = new File(FileUploadPath+"/"+itemName);
                                            //	 System.out.println("in doc uploading 3");
                                         		// savedFile = new File("/home/a_bhardwaj/Desktop/Documents/"+itemName);                 
                                             
                                             					System.out.print("\n\nsavedFile==>"+savedFile);
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
                                                                 //out.print("successfully saved the file");
                                                                //File file = new File(savedFile);
                                                                String screenshot=savedFile.getAbsolutePath();
                                                       // System.out.println("\n\nscreenshot--->>>"+screenshot);
                                                                }
                                                        
                                                        
                                        } catch (Exception e) {
                                                e.printStackTrace();
                                        }
                        }
                }
        
        
        System.out.println("The Company is :"+companyName+"\nThe address is:"+address+"\nThe email is :"+emailID);
        System.out.println("The state is :"+state+"\nThe add_state is:"+addState+"\nThe city is :"+city+"\nThe add_city is :"+addCity);
        System.out.println("The pincode is :"+pinCode+"\nThe contact Person is:"+contactPerson+"\nThe phone Number is :"+phoneNumber+"\nThe mobNumber is :"+mobNumber);
        System.out.println("The message is :"+message);
        
        companyName = companyName.trim();
        address = address.trim();
        emailID = emailID.trim();
        state = state.trim();
        addState = addState.trim();
        city = city.trim();
        addCity = addCity.trim();
        pinCode = pinCode.trim();
        contactPerson = contactPerson.trim();
        phoneNumber = phoneNumber.trim();
        mobNumber = mobNumber.trim();
        message = message.trim();
        
        if(addState.equalsIgnoreCase("")) {
        	
        }else {
        	if(!state.equalsIgnoreCase("select")) {
        	}else{
        		state=addState;
        		//System.out.println("now state name is:"+state);
        	}
        }
        
        if(addCity.equalsIgnoreCase("")){
        	
        }else {
        	if(!city.equalsIgnoreCase("select")) {
        	}else{
        		city=addCity;
        		//System.out.println("city name is:"+city);
        	}
        } 
        System.out.println("now state name is:"+state);
        System.out.println("now city name is:"+city);
        
     //Insert into the databases
        try {  
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        Calendar cal = Calendar.getInstance();
	        String DateTime = dateFormat.format(cal.getTime());
	        System.out.println(DateTime);
	        	    
	        Date now = new Date();
	        Calendar cal1 = Calendar.getInstance();
	        cal1.setTime(now);  
	        cal1.add(Calendar.DAY_OF_YEAR, 1); // <--  
	        Date tomorrow = cal.getTime();  
	        System.out.println("Tomarrow date is "+tomorrow);  
	        
	        String data = "Thankyou for your enquiry.<br/> Our marketing team will contact you shortly on the following details given by you: <br /><br />Your Mobile Number : "+mobNumber+"<br/>Your Email Id : "+emailID+"<br><br>Looking for your Valuable business.<br><br>Thankyou.";
	        
	        String body="<html><head><title>Mail Body</title></head><body><table border=^18^ bordercolor=^#E6E6FA^ align=^center^ width=^30%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^><table  style=^margin-left: 1em;margin-right: 1em;width: 90%;height: 100%;^><tr><td width=^100%^><a href=^http://www.mobile-eye.in^ target=^_blank^><img src=^http://myfleetview.com/DiarySystem/images/mobile.jpg^ style=^height: 80px; width: 100px;^ title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a><br/><font style=^color: #D8D8D8^>___________________________________________________________________________</font><br/><br/><div>"
				+"Dear "+contactPerson+" <br>"
				+"<br><div style=^width:90%; margin-left: 5%;^><table align=^left^ border=^0^ cellpadding=^0^ cellspacing=^0^ width=^100%^ style=^background: white;^><tr><td valign=^top^><font size=^3^ face=^Arial^>"+data+"<br></font></td></tr></table></div><br><br></div>"
				+"<div style=^width:100%; float:left;^><br>Regards,<br><b><font color=^black^ size=^2^>Team</font></b> <font color=^red^>Transworld</font><br><br>"
				+"Phone: +91 20 41215555 <br>Email: marketing@myfleetview.com </div></div><font style=^color: #D8D8D8^>___________________________________________________________________________</font><br/><br/><br/></td></tr></table></td></tr></table></body></html>";
		                    
	               String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName)values('TWSupports','New Mail for Enquiry','"+body+"','Enquiry mail','"+emailID+"','n_doshi@myfleetview.com','"+DateTime+"','Pending','Transworld')";
	               st3.executeUpdate(q2);
	               System.out.println("the record has been successfully inserted into table");
	               
	               //select Max id
	               String qmax = "select MAX(CustomerCode) as cust from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster";
	               System.out.println("The query is :"+qmax);
	               ResultSet rs = st4.executeQuery(qmax);
	               if(rs.next()){
	               		MaxCustCode = rs.getInt("cust");
	               }
	               
	               System.out.println("The max id is :"+MaxCustCode);
	               MaxCustCode = MaxCustCode +1;
	         //insert data into erp database      
    		 String query = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CustomerCode,CompanyName,Address,City,Zip,State,Country,ContactPerson,Phone,EMail,IntrestedProduct,CustEnteredByRep,AddedOnDate,ProspCustAddedOn,Category,MobileNo,Comments,Allocatedto)values('"+MaxCustCode+"','"+companyName+"','"+address+"','"+city+"','"+pinCode+"','"+state+"','india','"+contactPerson+"','"+phoneNumber+"','"+emailID+"','AVL','Nilesh Doshi','"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"','"+DateTime+"','3','"+mobNumber+"','"+message+"','104')";
	         st.executeUpdate(query);
	         System.out.println("inserted into table"); 
	         
	         String query1 = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr(Customercode,Address,City,Zip,State,Country,ContactPerson,Phone,EMail,IntrestedProduct,MobileNo)values('"+MaxCustCode+"','"+address+"','"+city+"','"+pinCode+"','"+state+"','india','"+contactPerson+"','"+phoneNumber+"','"+emailID+"','AVL','"+mobNumber+"')";
	         st1.executeUpdate(query1);
	         System.out.println("inserted into table"); 
	         
	         String query2 = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"followup(ProspCustCode,FollowUpDate,FollowUpTime,Status,FollowUpType,FollowUpInOut,Comments,NextFollowUpDate,NextFollowUpType,Preparation,MarketingRepcode,ContactPerson,ProspCustName)values('"+MaxCustCode+"','"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"','"+new SimpleDateFormat("HH:mm:ss").format(new Date())+"','Warm','Email','IN','"+message+"','"+new SimpleDateFormat("yyyy-MM-dd").format(tomorrow)+"','phoneCall','-','104','"+contactPerson+"','"+companyName+"')";
	         st2.executeUpdate(query2);
	         System.out.println("inserted into table"); 
       
       
        response.sendRedirect("Enquiry.jsp?msg=1&mno='"+mobNumber+"'&email='"+emailID+"'");
        //System.out.println("queryis :"+query);
        }catch(Exception e) {
                System.out.println("Exception ------------->    "+e);                        	
        } 
        
         //}//else
}

 %>
