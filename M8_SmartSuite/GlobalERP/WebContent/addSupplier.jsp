<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>

<%
Connection con;
con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
%>
<%
String SupplierCode=request.getParameter("SupplierCode");       
String supplierName=request.getParameter("supplierName");      
String city=request.getParameter("city");  
String contactPerson=request.getParameter("contactPerson");  
String address=request.getParameter("address");
String zip=request.getParameter("zip");  
String state=request.getParameter("state");         
String country=request.getParameter("country");  
String email=request.getParameter("email"); 
String phone=request.getParameter("ph");         
String fax=request.getParameter("fax");         
String website=request.getParameter("website");    
String SupRating=request.getParameter("supRating");
String SupUserName=request.getParameter("SupUserName");
String SupPassword=request.getParameter("SupPassword");
String SupCategory=request.getParameter("supCategory");
String SupProduct=request.getParameter("supProduct");   
String EnteredOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
String GSTIN=request.getParameter("GSTIN");
String IsDataValid="";
String OurSupplier="";
String AreaCode=request.getParameter("areaCode"); 
String mobile=request.getParameter("mobile");
String ResidencePhoneNo=""; 
String weekOff=request.getParameter("weeklyoff"); 

System.out.println("***    "+weekOff);
String Designation=request.getParameter("designation");
String SupPOAuthorisationReqd="";
String chk=request.getParameter("supAuthorisation");
System.out.println("==================="+chk);



SupPOAuthorisationReqd="False";
System.out.println("==================="+SupPOAuthorisationReqd);

if(chk !=null)
{
	
if(chk.equals("True"))
	
	{
		SupPOAuthorisationReqd="True";	
		System.out.println("==================="+SupPOAuthorisationReqd);
	}
	
}	
System.out.println("added on "+EnteredOn);
		 
Statement st1=con.createStatement(); 
Statement st=con.createStatement();
int scode;
String sql="SELECT MAX(SupplierCode) from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet ";
ResultSet rs=st1.executeQuery(sql);
rs.next();
scode=rs.getInt(1);
scode++;
		//while(rs.next()){
System.out.println(scode);

String sqlInsert="";
	    
sqlInsert = "INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"supplierdet(	SupplierCode,SupplierName, 	City, 	ContactPerson,Address, 	Zip, 	State,"+
			" 	Country, EMail,	Phone,Fax ,WebSite ,Sup_Rating ,"+
		    " 	SupUserName ,SupPassword ,SupCategory,SupProduct,EnteredOn,IsDataValid,OurSupplier, "+
		    " 	AreaCode ,Mobile ,ResidencePhoneNo,WeeklyOff,Designation,SupPOAuthorisationReqd,GSTINNo) VALUES "+
		    " 	('"+scode+"','"+supplierName+"','"+city+"','"+contactPerson+"','"+address+"','"+zip+"',"+
		    "  '"+state+"','"+country+"','"+email+"','"+phone+"','"+fax+"','"+website+"','"+SupRating+"',"+
		    "  '-','-','"+SupCategory+"','"+SupProduct+"','"+EnteredOn+"','1','1','"+AreaCode+"',"+
		    "  '"+mobile+"','-','"+weekOff+"','"+Designation+"','"+SupPOAuthorisationReqd+"','"+GSTIN+"')";     
System.out.println(sqlInsert);
		              
			/*else
			 	sqlInsert = "UPDATE "+session.getAttribute("CompanyMasterID").toString()+"supplierdet SET 	SupplierCode='"+scode+"',SupplierName='"+SupplierName+"', City='"+city+"',ContactPerson='"+contactPerson+"',	Address='"+address+"', 	"+
			 	" 	Zip='"+zip+"', 	State='"+state+"',Country='"+country+"',	EMail='"+email+"',phone='"+phone+"',	Fax='"+fax+"' ,"+
        		" 	WebSite='"+website+"',Sup_Rating='"+Sup_Rating+"',SupUserName='"+SupUserName+"',SupPassword='"+SupPassword+"'"+
        		" EnteredOn='"+EnteredOn+"' ,"+
        		"	IsDataValid='"+IsDataValid+"' ,	OurSupplier='"+OurSupplier+"' 	,AreaCode='"+AreaCode+"', "+
        		"		Mobile='"+phone+"' 	,	ResidencePhoneNo='"+ResidencePhoneNo+"' ,"+
        		" WeeklyOff='"+weeklyOff+"',Designation='"+Designation+"',SupPOAuthorisationReqd='"+SupPOAuthorisationReqd+"'   "+
        		"  WHERE SupplierName='"+request.getParameter("SupplierName")+"' limit 1";     
			*/			  
System.out.println("******************************");
		
try{          
				
st.executeUpdate(sqlInsert);	 
String existedDriver = "";
String msg = "";		
boolean flag=false;
	
flag=true;

msg = "Data insertion Failed . please try again";
				 /*sqlInsert = "update "+session.getAttribute("CompanyMasterID").toString()+"followup SET ()*/
if(flag){
msg = "Supplier "+supplierName+" saved successfully in system";
}
response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto=home.jsp");
}catch(Exception e){
out.println( "Exception ::"+e );
}						       
%>