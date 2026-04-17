

<%@ include file="conn.jsp"%>

<%!
Connection con1;%>
<%

try{

Class.forName(DB_Driver);
con1=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);

Statement st3=con1.createStatement(); 
Statement st1=con1.createStatement();
Statement st2=con1.createStatement(); 
Statement st5=con1.createStatement(); 
Statement st4=con1.createStatement();
Statement st10=con1.createStatement();
Statement st11=con1.createStatement(); 

String count="",datenew1="",datenew2="",datenew3="",datenew4="",contactPerson="",assignTo="",leadRef="",website="",email="",address="",country1="",opportunityname="";

String state="",city="",zip="";
datenew1=new SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date());
datenew2=datenew1;


System.out.println("$$$$$$$$$$$$$$$$$$$$$$$"+datenew3);


String custtype=request.getParameter("type111");
String category1=request.getParameter("category");
System.out.println("Category"+category1);
String companyname=request.getParameter("comp");
System.out.println("companynamecustomercodecompanynamecompanyname----------->"+companyname);
String customercode=request.getParameter("customercode");
System.out.println("customercodecustomercodecustomercodecustomercode----------->"+customercode);

String CustomerName="",CustomerCode="",ItemCode="",ItemDescription="",Rate="";
datenew4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
contactPerson=request.getParameter("spokento");
System.out.println("contactPerson----------->"+contactPerson);

opportunityname=request.getParameter("opportunityname");
System.out.println("opportunityname----------->"+opportunityname);

assignTo=request.getParameter("assignTo");
System.out.println("assignTo----------->"+assignTo);
leadRef=request.getParameter("leadRef");
System.out.println("leadRef--------->"+leadRef);
website=request.getParameter("website");
System.out.println("website----------->"+website);
email=request.getParameter("email");
System.out.println("email----------->"+email);

country1=request.getParameter("country1");

try
{


if(country1.equals("Select"))
{
country1="";
}
else
{
	country1=(request.getParameter("country1")== null || request.getParameter("country1").equalsIgnoreCase(""))?request.getParameter("newcountry"):request.getParameter("country1");
}

}catch(Exception e)
{
	country1="";
}



state=request.getParameter("state");

try
{
	state=(request.getParameter("state")== null || request.getParameter("state").equalsIgnoreCase(""))?request.getParameter("newstate"):request.getParameter("state");
}catch(Exception e)
{
	state="";
}
System.out.println("New Country ISSSSSSS ===="+request.getParameter("newstate"));
System.out.println("State=====Any====111111111"+state);


System.out.println("state--------->"+state);
city=request.getParameter("city");
System.out.println("city----------->"+city);

try
{
	city=(request.getParameter("city")== null || request.getParameter("city").equalsIgnoreCase(""))?request.getParameter("newcity"):request.getParameter("city");
}catch(Exception e)
{
	city="";
}
System.out.println("New City ISSSSSSS ===="+request.getParameter("newcity"));
System.out.println("City=====Any====111111111"+city);



zip=request.getParameter("zip");
System.out.println("zip----------->"+zip);

String  Opportunitycount="",mobile="",faxno="",std="",phone="",category="",product="",weeklyOffOn="",potentialValue="",noofunits="",alternateNumber="",comments="";


Opportunitycount=request.getParameter("count");
System.out.println("Opportunity Count----------->"+Opportunitycount);
mobile=request.getParameter("mobile");
System.out.println("mobile----------->"+mobile);
faxno=request.getParameter("faxno");
System.out.println("faxno----------->"+faxno);
std=request.getParameter("std");
System.out.println("std--------->"+std);
phone=request.getParameter("phone");
System.out.println("phone----------->"+phone);
category=request.getParameter("category");
System.out.println("category----------->"+category);

count=request.getParameter("count");
System.out.println("count----------->"+count);

product=request.getParameter("product");
System.out.println("product----------->"+product);
weeklyOffOn=request.getParameter("weeklyOffOn");
System.out.println("weeklyOffOn----------->"+weeklyOffOn);
potentialValue=request.getParameter("potentialValue");
System.out.println("potentialValue--------->"+potentialValue);
noofunits=request.getParameter("noofunits");
System.out.println("noofunits----------->"+noofunits);
alternateNumber=request.getParameter("alternateNumber");
System.out.println("alternateNumber----------->"+alternateNumber);

comments=request.getParameter("comments");
System.out.println("comments----------->"+comments);

address=request.getParameter("address");


String origcustorsalescode=request.getParameter("originalcustcode");
System.out.println("origcustorsalescodeorigcustorsalescodeorigcustorsalescodeorigcustorsalescode====>"+origcustorsalescode);



String mnc="Select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity where  OpportunityName='"+opportunityname+"' and companyname='"+companyname+"' ";
ResultSet rs2=st2.executeQuery(mnc);


System.out.println("opportunity name-----+++++++++++++++++++++++--------->"+mnc);


if(rs2.next())
{
	//out.println("This Opportunity Available For This Company");
	out.println("<script type='text/javascript'>alert('This Opportunity Already Available For These Company');");
	  out.println("location='home.jsp'");
		 	out.println("</script>");  
}

else
{

	

	

String SessionEmpName=session.getAttribute("EmpName").toString();
String insert= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity (insertDate,origcustorsalescode,companyname,customercode,custtype,opportunitycount,OpportunityName,Address,ContactPerson,Assignto,LeadRefNo,WebSite,Email,Country,State,City,Zip,MobileNo,STDCode,ResiNo,Category,product,WeeklyOffOn,potentialValue,noofunits,alternatenumber,Comments,Phone,Fax) values('"+datenew3+"','"+origcustorsalescode+"','"+companyname+"','"+customercode+"','"+custtype+"','"+Opportunitycount+"','"+opportunityname+"','"+address+"','"+contactPerson+"','"+assignTo+"','"+leadRef+"','"+website+"','"+email+"','"+country1+"','"+state+"','"+city+"','"+zip+"','"+mobile+"','"+std+"','"+phone+"','"+category+"','"+product+"','"+weeklyOffOn+"','"+potentialValue+"','"+noofunits+"','"+alternateNumber+"','"+comments+"','"+phone+"','"+faxno+"')";
 st1.executeUpdate(insert);
  System.out.println("insert Query-------------->"+insert);
  
  
  
  
  String insert5= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunityhistory (companyname,customercode,custtype,opportunitycount,OpportunityName,Address,ContactPerson,Assignto,LeadRefNo,WebSite,Email,Country,State,City,Zip,MobileNo,STDCode,ResiNo,Category,product,WeeklyOffOn,potentialValue,noofunits,alternatenumber,Comments,Phone,Fax) values('"+companyname+"','"+customercode+"','"+custtype+"','"+Opportunitycount+"','"+opportunityname+"','"+address+"','"+contactPerson+"','"+assignTo+"','"+leadRef+"','"+website+"','"+email+"','"+country1+"','"+state+"','"+city+"','"+zip+"','"+mobile+"','"+std+"','"+phone+"','"+category+"','"+product+"','"+weeklyOffOn+"','"+potentialValue+"','"+noofunits+"','"+alternateNumber+"','"+comments+"','"+phone+"','"+faxno+"')";
  st11.executeUpdate(insert5);
   System.out.println("insert Query-------------->"+insert5);
  
 
   String Info="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo where Country='"+country1+"' and State='"+state+"' and City='"+city+"' ";
   ResultSet rs=st1.executeQuery(Info);
   
   
   System.out.println("insert Query-----For --------->"+Info);
   if(rs.next()){
	   
   }
   
   else
   {
  String insert1= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo (Country,State,City) values('"+country1+"','"+state+"','"+city+"')";
  st10.executeUpdate(insert1);
   System.out.println("insert Query-----For --------->"+insert1);
   }
   
  
   
   String cname=companyname.replace("&", "...");
   
   System.out.println("Customer code:=========>"+customercode);
   System.out.println("CustomerName is:=======>"+cname);
   System.out.println("Customercode is:=======>"+origcustorsalescode);
   System.out.println("CustomerTypeis:=======>"+custtype);
   
   
   if(custtype.equals("Customer"))
   {
	out.println("<script type='text/javascript'>alert('Record Inserted Succesfully');");
	  out.println("location='OpportunityRep.jsp?companyname="+cname+"&customercode="+origcustorsalescode+"&customertype="+custtype+"'");
		 	out.println("</script>");  
   }
   else
   {
	   out.println("<script type='text/javascript'>alert('Record Inserted Succesfully');");
		  out.println("location='OpportunityRep.jsp?companyname="+cname+"&customercode="+customercode+"&customertype="+custtype+"'");
			 	out.println("</script>"); 
   }
}
	 	
	 
}
		
catch(Exception e)
{
	
}



%>