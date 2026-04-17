<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.jibble.simpleftp.*" %>
<%@ page language="java" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %> 
<%@ page import="java.io.*"%>
<%@ page import="java.util.List" %>
<%
Connection con;
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
%>
<%
String f123="";
String itemName="",docPath="";
int fileCount=0;
String filename="",SupplierCode="",SupUserName="",SupPassword="",SupCategory="";
String supplierName="", city="",contactPerson="",address="",zip="",state="",country="",email="",phone="",fax="",website="",SupRating="";
String SupProduct="",GSTIN="",AreaCode="",mobile="",weekOff="",Designation="",chk="";
String IsDataValid="",reasonforcancel="";
String SupPOAuthorisationReqd="";
String OurSupplier="";String ResidencePhoneNo=""; 
String EnteredOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
SupPOAuthorisationReqd="False";
System.out.println("==================="+SupPOAuthorisationReqd);

String twemp="";

String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if (!isMultipart) 
{
} 
else
{
	
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
  String a="";
  while (itr.hasNext()) 
          {
  FileItem item = (FileItem) itr.next();
  if (item.isFormField())
          {
             String name = item.getFieldName();
                 String value = item.getString();
                
                  if(name.equals("myfile"))
                  {
                	  filename=value;
                  }
                //	System.out.println("file name is      ************************"+filename);
                  if(name.equals("SupplierCode"))
                  {
                	  SupplierCode=value;
                  } 
                  if(name.equals("supplierName"))
                  {
                	  supplierName=value;
                  } 
                  if(name.equals("city"))
                  {
                	  city=value;
                  } 
                  if(name.equals("contactPerson"))
                  {
                	  contactPerson=value;
                  } 
                  if(name.equals("address"))
                  {
                	  address=value;
                  } 
                  if(name.equals("zip"))
                  {
                	  zip=value;
                  } 
                  if(name.equals("state"))
                  {
                	  state=value;
                  }
                  if(name.equals("country"))
                  {
                	  country=value;
                  }
                  if(name.equals("mobile"))
                  {
                	  mobile=value;
                  }
                  if(name.equals("email"))
                  {
                	  email=value;
                  }
                  if(name.equals("ph"))
                  {
                	  phone=value;
                  }
                  if(name.equals("fax"))
                  {
                	  fax=value;
                  }
                  if(name.equals("website"))
                  {
                	  website=value;
                  }
                  if(name.equals("supRating"))
                  {
                	  SupRating=value;
                  }
                  if(name.equals("SupUserName"))
                  {
                	  SupUserName=value;
                  }
                  if(name.equals("SupPassword"))
                  {
                	  SupPassword=value;
                  }
                  if(name.equals("supCategory"))
                  {
                	  SupCategory=value;
                  }
                  if(name.equals("supProduct"))
                  {
                	  SupProduct=value;
                  }
                  
                  if(name.equals("GSTIN"))
                  {
                	  GSTIN=value;
                  }
                  
                  if(name.equals("areaCode"))
                  {
                	  AreaCode=value;
                  }
                  if(name.equals("mobile"))
                  {
                	  mobile=value;
                  }
                  if(name.equals("weeklyoff"))
                  {
                	  weekOff=value;
                  }
                  if(name.equals("designation"))
                  {
                	  Designation=value;
                  }
                  if(name.equals("supAuthorisation"))
                  {
                	  chk=value;
                  }
                  if(chk !=null)
                  {
                  	
                  if(chk.equals("True"))
                  	
                  	{
                  		SupPOAuthorisationReqd="True";	
                  		System.out.println("==================="+SupPOAuthorisationReqd);
                  	}
                  	
                  }	
                  System.out.println("============++++++"+chk);
                  if(name.equals("reason"))
                  {
                	  reasonforcancel=value;
                  }
                  if(name.equals("twemp"))
                  {
                	  twemp=value;
                  }
                  if(name.equals("alternateNumber"))
                  {
                	  ResidencePhoneNo=value;
                  }
         } 
   	  else
		  {    
						try 
						{
				           itemName = item.getName();
						   File savedFile = new File(config.getServletContext().getRealPath("/")+itemName);
						   out.println("path==========>>"+(config.getServletContext().getRealPath("/")).toString());
						   
						  // completePath=(config.getServletContext().getRealPath("/")+itemName).toString();
						   
						   docPath=(config.getServletContext().getRealPath("/")).toString();
						   System.out.println("PATH BSI   "+docPath);
						   item.write(savedFile);
					       %><center></table><%
					   } 
			    	   catch (Exception e) 
			    	   {
					   		e.printStackTrace();
					   }
			    	   
				   }
		   }
  

//=====Copy 2 FTP===============================================================================================
 try
 	{
	   SimpleFTP ftp = new SimpleFTP();
	   ftp.connect("202.38.172.58", 21, "sumedh", "789&*(medh");
	    ftp.bin();
	    System.out.println();
	   //ftp.stor(new FileInputStream(new File(cpyPath)), "/Uploaded/"+itemName+"");
//	   			f123=f123.substring(1, f123.length());
	   			out.println("values for FTP*********************"+f123);
	   			
			    String delims12 = "[,]";
			    String[] tokens12 = f123.split(delims12);
				for (String t : tokens12)
				{
					out.println("==========================>>"+docPath+"/"+t);
					ftp.stor(new FileInputStream(new File(docPath+"/"+itemName)), "/ERPDocuments/"+itemName+"");
					System.out.println("path----------->>"+docPath+"/"+t);
					fileCount++;
				}
 	}
 	catch(Exception e)
 	{
 		System.out.println("Exception Copy File to FTP----------->>"+e);
 	} 

}
 
Statement st1=con.createStatement(); 
Statement st=con.createStatement();
Statement st2=con.createStatement();
String sqlInsert="";
String sqlDocument="",enteredon="";	 
String mainsupllier="";
String suppliercode="";
String sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName='"+supplierName+"' ";
System.out.println("++++++++++++++++++++++++==="+sql);
ResultSet rs=st.executeQuery(sql);
if(rs.next())
{
	mainsupllier=rs.getString("SupplierName");
	suppliercode=rs.getString("SupplierCode");
	try{
	enteredon=rs.getString("EnteredOn");
	
	System.out.println("<<<<<<<<<<<<<<     "+enteredon);
	}
	catch(Exception e){enteredon="2001-01-01";}
		try{
		/*sqlInsert="	INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"supplierHistory(SupplierCode,SupplierName, 	City, 	ContactPerson,Address, 	Zip, 	State,"+
		  " Country, EMail,	Phone,Fax ,WebSite ,Sup_Rating ,"+
		  " SupUserName ,SupPassword ,SupCategory,SupProduct,EnteredOn,IsDataValid,OurSupplier, "+
		  " AreaCode ,Mobile ,ResidencePhoneNo,WeeklyOff,Designation,SupPOAuthorisationReqd,TallyName,TransactionExisted,reasonForUpdate,UpdatedBy)"+
		  " VALUES"+
		  " (?,?,?,?,?, ?,?,?,?,?,"+
		  " ?,?,?,?,?, ?,?,?,?,?,"+
		  " ?,?,?,?,?, ?,?,?,?,?) ";


java.sql.PreparedStatement stmt = con.prepareStatement(sqlInsert);
System.out.println(sqlInsert);

stmt.setString(1,rs.getString("SupplierCode"));
stmt.setString(2,rs.getString("SupplierName"));
stmt.setString(3,rs.getString("City"));
stmt.setString(4,rs.getString("ContactPerson"));
stmt.setString(5,rs.getString("Address"));
stmt.setString(6,rs.getString("Zip"));
stmt.setString(7,rs.getString("State"));
stmt.setString(8,rs.getString("Country"));
stmt.setString(9,rs.getString("EMail"));
stmt.setString(10,rs.getString("Phone"));
stmt.setString(11,rs.getString("Fax"));
stmt.setString(12,rs.getString("WebSite"));
stmt.setString(13,rs.getString("Sup_Rating"));
stmt.setString(14,rs.getString("SupUserName"));
stmt.setString(15,rs.getString("SupPassword")); 
stmt.setString(16,rs.getString("SupCategory"));
stmt.setString(17,rs.getString("SupProduct"));
stmt.setString(18,enteredon);
stmt.setString(19,rs.getString("IsDataValid"));
stmt.setString(20,rs.getString("OurSupplier"));
stmt.setString(21,rs.getString("AreaCode"));
stmt.setString(22,rs.getString("Mobile"));
stmt.setString(23,rs.getString("ResidencePhoneNo"));
stmt.setString(24,rs.getString("WeeklyOff"));
stmt.setString(25,rs.getString("Designation"));
stmt.setString(26,rs.getString("SupPOAuthorisationReqd"));
stmt.setString(27,rs.getString("TallyName"));
stmt.setString(28,rs.getString("TransactionExisted"));
stmt.setString(29,reasonforcancel);
stmt.setString(30,twemp);*/


 	 	sqlInsert="	INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"supplierHistory(SupplierCode,SupplierName, 	City, 	ContactPerson,Address, 	Zip, 	State,"+
		  " Country, EMail,	Phone,Fax ,WebSite ,Sup_Rating ,"+
		  " SupUserName ,SupPassword ,SupCategory,SupProduct,EnteredOn,IsDataValid,OurSupplier, "+
		  " AreaCode ,Mobile ,ResidencePhoneNo,WeeklyOff,Designation,SupPOAuthorisationReqd,TallyName,TransactionExisted,reasonForUpdate,UpdatedBy,UpdateOn)"+
		  " VALUES"+
		  " ('"+rs.getString("SupplierCode")+"','"+mainsupllier+"','"+rs.getString("City")+"','"+rs.getString("ContactPerson")+"','"+rs.getString("Address")+"','"+rs.getString("Zip")+"','"+rs.getString("State")+"', "+
		  " '"+rs.getString("Country")+"','"+rs.getString("EMail")+"','"+rs.getString("Phone")+"','"+rs.getString("Fax")+"','"+rs.getString("WebSite")+"','"+rs.getString("Sup_Rating")+"',"+
		  " '"+rs.getString("SupUserName")+"','"+rs.getString("SupPassword")+"','"+rs.getString("SupCategory")+"','"+rs.getString("SupProduct")+"','"+enteredon+"','"+rs.getString("IsDataValid")+"','"+rs.getString("OurSupplier")+"',"+
		  " '"+rs.getString("AreaCode")+"','"+rs.getString("Mobile")+"','"+rs.getString("ResidencePhoneNo")+"','"+rs.getString("WeeklyOff")+"','"+rs.getString("Designation")+"','"+rs.getString("SupPOAuthorisationReqd")+"','"+rs.getString("TallyName")+"','"+rs.getString("TransactionExisted")+"','"+reasonforcancel+"','"+twemp+"','"+todaysDate+"' ) ";
		System.out.println(""+sqlInsert);
		st.executeUpdate(sqlInsert);
}catch(Exception e){e.printStackTrace();}
}	
		//while(rs.next()){
  
/*else	sqlInsert = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"supplierdet(	SupplierCode,SupplierName, 	City, 	ContactPerson,Address, 	Zip, 	State,"+
			" 	Country, EMail,	Phone,Fax ,WebSite ,Sup_Rating ,"+
		    " 	SupUserName ,SupPassword ,SupCategory,SupProduct,EnteredOn,IsDataValid,OurSupplier, "+
		    " 	AreaCode ,Mobile ,ResidencePhoneNo,WeeklyOff,Designation,SupPOAuthorisationReqd) VALUES "+
		    " 	('"+scode+"','"+supplierName+"','"+city+"','"+contactPerson+"','"+address+"','"+zip+"',"+
		    "  '"+state+"','"+country+"','"+email+"','"+phone+"','"+fax+"','"+website+"','"+SupRating+"',"+
		    "  '-','-','"+SupCategory+"','"+SupProduct+"','"+EnteredOn+"','1','1','"+AreaCode+"',"+
		    "  '"+mobile+"','-','"+weekOff+"','"+Designation+"','"+SupPOAuthorisationReqd+"')";     
            System.out.println(sqlInsert);*/
			 	sqlInsert = "UPDATE "+session.getAttribute("CompanyMasterID").toString()+"supplierdet SET 	SupplierName='"+supplierName+"', City='"+city+"',ContactPerson='"+contactPerson+"',	Address='"+address+"', 	"+
			 	" 	Zip='"+zip+"', 	State='"+state+"',Country='"+country+"',	EMail='"+email+"',phone='"+phone+"',	Fax='"+fax+"' ,"+
        		" 	WebSite='"+website+"',Sup_Rating='"+SupRating+"',GSTINNo='"+GSTIN+"',SupUserName='-',SupPassword='-' ,"+
        		" EnteredOn='"+EnteredOn+"' ,"+
        		"	AreaCode='"+AreaCode+"', "+
        		"		Mobile='"+mobile+"' 	,	ResidencePhoneNo='"+ResidencePhoneNo+"' ,"+
        		" WeeklyOff='"+weekOff+"',Designation='"+Designation+"',SupPOAuthorisationReqd='"+SupPOAuthorisationReqd+"'   "+
        		"  WHERE SupplierCode='"+suppliercode+"'  limit 1";     
						  
System.out.println("******************************");
System.out.println("****************"+sqlInsert);

if(itemName!="")
{
	System.out.println("*************  IN IF LOOP ");	

sqlDocument="Insert into "+session.getAttribute("CompanyMasterID").toString()+"supplierdocuments(SupplierCode ,Documents ,UploadedBy ,UploadedOn) values ('"+SupplierCode+"','"+itemName+"','"+session.getAttribute("EmpName")+"','"+todaysDate+"')";			
System.out.println("*************  "+sqlDocument);	
st1.executeUpdate(sqlDocument);
}
try{          
				
st.executeUpdate(sqlInsert);

String existedDriver = "";
String msg = "";		
boolean flag=false;
	
flag=true;

msg = "Data insertion Failed . please try again";
				 /*sqlInsert = "update "+session.getAttribute("CompanyMasterID").toString()+"followup SET ()*/
if(flag){
msg =supplierName+" saved successfully in system";
}
response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto=home.jsp");
}catch(Exception e){
out.println( "Exception ::"+e );
}						       
%>