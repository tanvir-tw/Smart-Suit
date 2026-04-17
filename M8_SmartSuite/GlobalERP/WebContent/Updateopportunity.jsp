

<%@ include file="conn.jsp"%>

<%!
Connection con1;%>
<%

try{

Class.forName(DB_Driver);
con1=DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);


Statement st1=con1.createStatement();
Statement st10=con1.createStatement(); 
Statement st11=con1.createStatement();
Statement st3=con1.createStatement();
Statement st4=con1.createStatement();
Statement st5=con1.createStatement(); 

String datenew1="",datenew2="",datenew3="",datenew4="",contactPerson="",assignTo="",leadRef="",website="",email="",address="",country1="",opportunityname="";

String state="",city="",zip="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;



String custtype=request.getParameter("custtype");




String category1=request.getParameter("category");

String custtype1=request.getParameter("custtype");


String companyname=request.getParameter("comp");
System.out.println("companynamecustomercodecompanynamecompanyname----------->"+companyname);
String customercode=request.getParameter("cc");
System.out.println("customercodecustomercodecustomercodecustomercode----------->*******"+customercode);

System.out.println("Custtype is:"+custtype1);



String CustomerName="",CustomerCode="",ItemCode="",ItemDescription="",Rate="";
datenew4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
contactPerson=request.getParameter("contactPerson");
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
	country1=(request.getParameter("country1")== null || request.getParameter("country1").equalsIgnoreCase(""))?request.getParameter("newcountry"):request.getParameter("country1");
}catch(Exception e)
{
	country1="";
}
System.out.println("New Country ISSSSSSS ===="+request.getParameter("newcountry"));
System.out.println("Country=====Any====111111111"+country1);


System.out.println("country1----------->"+country1);
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

String oppocode="", mobile="",faxno="",std="",phone="",category="",product="",weeklyOffOn="",potentialValue="",noofunits="",alternateNumber="",comments="";


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

oppocode=request.getParameter("count1");
out.println("OPPO CODE_____>"+oppocode);




String SessionEmpName=session.getAttribute("EmpName").toString();
String insert= "UPDATE db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunity SET companyname='"+companyname+"',OpportunityName='"+opportunityname+"',Address='"+address+"',ContactPerson='"+contactPerson+"',Assignto='"+assignTo+"',LeadRefNo='"+leadRef+"',WebSite='"+website+"',Email='"+email+"',Country='"+country1+"',State='"+state+"',City='"+city+"',Zip='"+zip+"',MobileNo='"+mobile+"',STDCode='"+std+"',ResiNo='"+phone+"',Category='"+category+"',product='"+product+"',WeeklyOffOn='"+weeklyOffOn+"',potentialValue='"+potentialValue+"',noofunits='"+noofunits+"',alternatenumber='"+alternateNumber+"',Comments='"+comments+"' where Opportunitycode='"+oppocode+"' ";
st1.executeUpdate(insert);
  System.out.println("insert Query-------------->"+insert);
  
  
  
  String insert5= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"newopportunityhistory (companyname,customercode,opportunitycount,OpportunityName,Address,ContactPerson,Assignto,LeadRefNo,WebSite,Email,Country,State,City,Zip,MobileNo,STDCode,ResiNo,Category,product,WeeklyOffOn,potentialValue,noofunits,alternatenumber,Comments,Phone,Fax) values('"+companyname+"','"+customercode+"','"+category1+"','"+opportunityname+"','"+address+"','"+contactPerson+"','"+assignTo+"','"+leadRef+"','"+website+"','"+email+"','"+country1+"','"+state+"','"+city+"','"+zip+"','"+mobile+"','"+std+"','"+phone+"','"+category+"','"+product+"','"+weeklyOffOn+"','"+potentialValue+"','"+noofunits+"','"+alternateNumber+"','"+comments+"','"+phone+"','"+faxno+"')";
  st11.executeUpdate(insert5);
   System.out.println("insert Query-------------->"+insert5);
  
 
  String insert1= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo (Country,State,City) values('"+country1+"','"+state+"','"+city+"')";
  st10.executeUpdate(insert1);
   System.out.println("insert Query-----For --------->"+insert1);
  
  
   String cname=companyname.replace("&", "...");
   
   System.out.println("Customer code:=========>"+customercode);
   System.out.println("CustomerName is:=======>"+cname);
   System.out.println("CustomerTypeis:=======>"+custtype1);
   
   
   
 
   if(custtype.equals("Customer"))
   {
	out.println("<script type='text/javascript'>alert('Record Inserted Succesfully');");
	  out.println("location='OpportunityRep.jsp?companyname="+cname+"&customercode="+customercode+"&customertype="+custtype+"'");
		 	out.println("</script>");  
   }
   else
   {
	   out.println("<script type='text/javascript'>alert('Record Inserted Succesfully');");
		  out.println("location='OpportunityRep.jsp?companyname="+cname+"&customercode="+customercode+"&customertype="+custtype+"'");
			 	out.println("</script>"); 
   }
   


	 	
	 	/* out.println("<script type='text/javascript'>alert('Record Updated Succesfully');");
	 	  out.println("location='home.jsp'");
	 		 	out.println("</script>");   */


	
}
catch(Exception e)
{
	System.out.println("Conn problem");
}



%>