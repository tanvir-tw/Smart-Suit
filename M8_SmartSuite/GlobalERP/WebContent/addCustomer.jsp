<%@page import="java.util.Collection"%>
<%@ include file="conn.jsp"%>
<%@page import="java.io.Flushable"%>

<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@ page
	import="java.util.Properties,javax.mail.*,javax.mail.internet.*"
	import="javax.mail.Session"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page
	import="java.util.Date, 
javax.activation.DataSource,         
javax.activation.FileDataSource,     
javax.mail.Address,                  
javax.mail.BodyPart,                 
javax.mail.Message,                  
javax.mail.Multipart,                
javax.mail.Session,                  
javax.mail.Transport,                
javax.mail.internet.InternetAddress, 
javax.mail.internet.MimeBodyPart,    
javax.mail.internet.MimeMessage,     
javax.mail.internet.MimeMultipart,
 java.io.File,                  
 java.io.FileNotFoundException, 
 java.io.FileOutputStream,      
 java.io.IOException,           
 java.text.ParseException"%>
<%! 
Connection con ;
%>
<%try{
		int customerCode=0;
		
		String sqlInsert1="";
String repName="", vendor="", companyName="", companyafteredit="", contactPerson="",website="",email="",zip="",state="",         
country="", phone="",fax="",category="",product="",weeklyOffOn="", alternateNumber="",address="",date=new SimpleDateFormat("yyyy-MM-dd").format(new Date()),
mobile="",mobile1="", mobile2="",logo="",stdCode="",addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),
potentialValue="",confidencelevel="",onetimecharge="",contractvalue="",recurringcharge="",solution="",verticals="",segment="",subgroup="",comments="", assignedBy="",leadRef="",noofunits="",BranchName="",GroupofComp="",TypeofBusiness="",ColloectionStaffName="",
paymentterm="",riskInvolved="", opprotunity="",reasonforupdate="",reassign="";
String EmpNm=session.getAttribute("EmpName").toString().trim();
try{
opprotunity=(request.getParameter("Opportunity")== null || request.getParameter("Opportunity").equalsIgnoreCase(""))?"":request.getParameter("Opportunity");
repName=(request.getParameter("repName")== null || request.getParameter("repName").equalsIgnoreCase(""))?"":request.getParameter("repName");
vendor=(request.getParameter("vendorcode")== null || request.getParameter("vendorcode").equalsIgnoreCase(""))?"":request.getParameter("vendorcode");
companyName=(request.getParameter("companyName")== null || request.getParameter("companyName").equalsIgnoreCase(""))?"":request.getParameter("companyName");
companyafteredit=(request.getParameter("companyNameafteredit")== null || request.getParameter("companyNameafteredit").equalsIgnoreCase(""))?"":request.getParameter("companyNameafteredit");
contactPerson=(request.getParameter("contactPerson")== null || request.getParameter("contactPerson").equalsIgnoreCase(""))?"":request.getParameter("contactPerson");
website=(request.getParameter("website")== null || request.getParameter("website").equalsIgnoreCase(""))?"":request.getParameter("website");
email=(request.getParameter("email")== null || request.getParameter("email").equalsIgnoreCase(""))?"":request.getParameter("email");
zip=(request.getParameter("zip")== null || request.getParameter("zip").equalsIgnoreCase(""))?"":request.getParameter("zip");
// state=(request.getParameter("state")== null || request.getParameter("state").equalsIgnoreCase(""))?"":request.getParameter("state");

 


try
{
	country=(request.getParameter("country1")== null || request.getParameter("country1").equalsIgnoreCase(""))?request.getParameter("newcountry"):request.getParameter("country1");
}catch(Exception e)
{
	country="";
}
// System.out.println("New country ISSSSSSS ===="+request.getParameter("newcountry"));
System.out.println("====country ====country=====111111111"+country);



try
{
 state=(request.getParameter("state")== null || request.getParameter("state").equalsIgnoreCase(""))?request.getParameter("newstate"):request.getParameter("state");
}catch(Exception e)
{
	state="";
}
// System.out.println("New Satet ISSSSSSS ===="+request.getParameter("newstate"));
System.out.println("====Satet ====Any=====111111111"+state);



phone=(request.getParameter("phone")== null || request.getParameter("phone").equalsIgnoreCase(""))?"":request.getParameter("phone");
fax=(request.getParameter("faxno")== null || request.getParameter("faxno").equalsIgnoreCase(""))?"":request.getParameter("faxno");
category=(request.getParameter("category")== null || request.getParameter("category").equalsIgnoreCase(""))?"":request.getParameter("category");
product=(request.getParameter("product")== null || request.getParameter("product").equalsIgnoreCase(""))?"":request.getParameter("product");
weeklyOffOn=(request.getParameter("weeklyOffOn")== null || request.getParameter("weeklyOffOn").equalsIgnoreCase(""))?"":request.getParameter("weeklyOffOn");
alternateNumber=(request.getParameter("alternateNumber")== null || request.getParameter("alternateNumber").equalsIgnoreCase(""))?"":request.getParameter("alternateNumber");
address=(request.getParameter("address")== null || request.getParameter("address").equalsIgnoreCase(""))?"":request.getParameter("address");
date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
mobile=(request.getParameter("mobile")== null || request.getParameter("mobile").equalsIgnoreCase(""))?"":request.getParameter("mobile");
mobile1=(request.getParameter("mobileno1")== null || request.getParameter("mobileno1").equalsIgnoreCase(""))?"":request.getParameter("mobileno1");
mobile2=(request.getParameter("mobileno2")== null || request.getParameter("mobileno2").equalsIgnoreCase(""))?"":request.getParameter("mobileno2");
logo=(request.getParameter("element_4")== null || request.getParameter("element_4").equalsIgnoreCase(""))?"":request.getParameter("element_4");
stdCode=(request.getParameter("std")== null || request.getParameter("std").equalsIgnoreCase(""))?"":request.getParameter("std");
addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
potentialValue=(request.getParameter("potentialValue").toString().replaceAll(",","")== null || request.getParameter("potentialValue").toString().replaceAll(",","").equalsIgnoreCase(""))?"":request.getParameter("potentialValue").toString().replaceAll(",","");
comments=(request.getParameter("comments").replaceAll("'"," ")== null || request.getParameter("comments").replaceAll("'"," ").equalsIgnoreCase(""))?"":request.getParameter("comments").replaceAll("'"," ");
assignedBy=(request.getParameter("assignedBy")== null || request.getParameter("assignedBy").equalsIgnoreCase(""))?"":request.getParameter("assignedBy");
leadRef=(request.getParameter("leadRef")== null || request.getParameter("leadRef").equalsIgnoreCase(""))?"":request.getParameter("leadRef");


verticals=(request.getParameter("verticals")== null || request.getParameter("verticals").equalsIgnoreCase(""))?"":request.getParameter("verticals");
solution=(request.getParameter("solution")== null || request.getParameter("solution").equalsIgnoreCase(""))?"":request.getParameter("solution");

segment=(request.getParameter("segment")== null || request.getParameter("segment").equalsIgnoreCase(""))?"":request.getParameter("segment");
subgroup=(request.getParameter("subgroup")== null || request.getParameter("subgroup").equalsIgnoreCase(""))?"":request.getParameter("subgroup");
confidencelevel=(request.getParameter("confidencelevel")== null || request.getParameter("confidencelevel").equalsIgnoreCase(""))?"":request.getParameter("confidencelevel");
onetimecharge=(request.getParameter("onetimecharge")== null || request.getParameter("onetimecharge").equalsIgnoreCase(""))?"":request.getParameter("onetimecharge");
recurringcharge=(request.getParameter("recurringcharge")== null || request.getParameter("recurringcharge").equalsIgnoreCase(""))?"":request.getParameter("recurringcharge");
contractvalue=(request.getParameter("contractvalue")== null || request.getParameter("contractvalue").equalsIgnoreCase(""))?"":request.getParameter("contractvalue");

noofunits=(request.getParameter("noofunits")== null || request.getParameter("noofunits").equalsIgnoreCase(""))?"":request.getParameter("noofunits");

BranchName=(request.getParameter("BranchMaster")== null || request.getParameter("BranchMaster").equalsIgnoreCase(""))?"":request.getParameter("BranchMaster");
GroupofComp=(request.getParameter("grcomp")== null || request.getParameter("grcomp").equalsIgnoreCase(""))?"":request.getParameter("grcomp");
TypeofBusiness=(request.getParameter("typebusiness")== null || request.getParameter("typebusiness").equalsIgnoreCase(""))?"":request.getParameter("typebusiness");
ColloectionStaffName=(request.getParameter("CollectionStaff")== null || request.getParameter("CollectionStaff").equalsIgnoreCase(""))?"":request.getParameter("CollectionStaff");
paymentterm=(request.getParameter("payment")== null || request.getParameter("payment").equalsIgnoreCase(""))?"":request.getParameter("payment");
riskInvolved=(request.getParameter("RiskInvolved")== null || request.getParameter("RiskInvolved").equalsIgnoreCase(""))?"":request.getParameter("RiskInvolved");

reasonforupdate=request.getParameter("reason");
reassign=request.getParameter("assignTo");

}
catch(Exception e)
{
	opprotunity="";
	repName="";
	vendor="";
	companyName="";
	companyafteredit="";
	contactPerson="";
	website="";
	email="";
	zip="";
	state="";
	country="";
	phone="0";
	fax="0";
	category="1";
	product="";
	weeklyOffOn="";
	alternateNumber="0";
	address="";
	date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	mobile="0";
	mobile1="0";
	mobile2="0";
	logo="";
	stdCode="0";
	addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	potentialValue="";
	comments="";
	assignedBy="";
	leadRef="";
	noofunits="0";
	BranchName="";
	GroupofComp="";
	TypeofBusiness="";
	ColloectionStaffName="";
	paymentterm="";
	riskInvolved="";
	verticals="";
	segment="";
	subgroup="";
	confidencelevel="";
	onetimecharge="";
	recurringcharge="";
	solution="";
	contractvalue="";
	
}
		System.out.println("Opportunity Name"+opprotunity);
		System.out.println("Vender code----"+vendor);
		System.out.println("COMPANY IS *****************     "+companyName);
		System.out.println("COMPANY AFTER EDIT IS      *****************     "+companyName);
		System.out.println("CONTACT PERSON  IS      *****************     "+contactPerson);
		System.out.println("Website----"+website);
		System.out.println("EMAIL----"+email);
		System.out.println("ZIP CODE----"+zip);
		System.out.println("SATE-----"+state);
		System.out.println("COUNTRY----"+country);
		System.out.println("PHONE----"+phone);
		System.out.println("FAX----"+fax);
		System.out.println("CATEGORY----"+category);
		System.out.println("PRODUCT----"+product);
		System.out.println("WEEKLY OFF ON----"+weeklyOffOn);
		System.out.println("ALTERNATE NUMBER----"+alternateNumber);
		System.out.println("ADDRESS----"+address);
		System.out.println("Primary Mobile----"+mobile);
		System.out.println("Mobile NUMBER----"+mobile1);
		System.out.println("MOBILE----"+mobile2);
		System.out.println("STD CODE----"+stdCode);
		System.out.println("POTENTIAL VALUE----"+potentialValue);
		System.out.println("COMMENTS----"+comments);
		System.out.println("ASSIGN NUMBER----"+assignedBy);
		System.out.println("LEAD REFERENCE----"+leadRef);
		System.out.println("NUMBER OF UNITS----"+noofunits);
		System.out.println("ALTERNATE NUMBER----"+BranchName);
		System.out.println("GROUP NAME----"+GroupofComp);
		System.out.println("TYPE OF BUSINESS----"+TypeofBusiness);
		System.out.println("COLLECTION STAFF----"+ColloectionStaffName);
		System.out.println("ALTERNATE NUMBER----"+paymentterm);
		System.out.println("RISK INVOLVED----"+riskInvolved);
		
		String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		String sqlInsert="";
		Integer defualtval=1;
		String CustCategory="";
		String Company="";
		
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement st1=con.createStatement();
		Statement stmt=con.createStatement();
		Statement stmt1=con.createStatement();
		Statement stmt2=con.createStatement();
		Statement stmt3=con.createStatement();
		Statement stcity=con.createStatement();
		Statement st3=con.createStatement();
		Statement st4=con.createStatement();
		Statement st5=con.createStatement();
		Statement st9=con.createStatement();
		Statement st12=con.createStatement();
		Statement st14=con.createStatement();
		Statement st13=con.createStatement();
		Statement st7=con.createStatement();
		Statement st73=con.createStatement();
		Statement st55=con.createStatement();
		Statement st18=con.createStatement();
		Statement st19=con.createStatement();
		Statement st20=con.createStatement();
		
		System.out.println("After con.createStatement()");
		
		
		
		
		try{
			category=request.getParameter("category");
		}catch(Exception e)
		{
			category="1";
		}
		
		
		
		String city="",newcity="-";
		try
		{
		 city=(request.getParameter("city")== null || request.getParameter("city").equalsIgnoreCase(""))?request.getParameter("newcity"):request.getParameter("city");
		}catch(Exception e)
		{
			city="";
		}
// 		System.out.println("New City ISSSSSSS ===="+request.getParameter("newcity"));
		System.out.println("==NEW=========City===========11111"+city);
		
		
	
		

      	
		
		
		
		if(request.getParameter("assignTo")!=null)
		{
			System.out.println("in request.getParameter(assignTo)!=");
			repName=request.getParameter("assignTo");
		}	
			
		System.out.println("after request.getParameter(assignTo)!=");
		
		if(alternateNumber.equals(""))
		{	
			System.out.println("in alternateNumber.equals()");
				alternateNumber="0";
		}	
		
		if(potentialValue.equals(""))
		{
			System.out.println("in potentialValue.equals");	
		   potentialValue="0";
		}
		System.out.println("after potentialValue.equals");
		System.out.println("22222222222222222222222  ");
		try{
			String repcode="";
			try{
				 String sqlrepcode="Select MarketingRepCode from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
				 System.out.println(sqlrepcode);
				 ResultSet rscode=st5.executeQuery(sqlrepcode);
			     if(rscode.next())
			     { 
				  repcode=rscode.getString("MarketingRepCode");
				  //getString("MarketingRepCode");				
			     }
				  System.out.println("233333333333   3333333333  "+repcode);
					}catch(Exception e)
					{
						e.printStackTrace();
					}
					
			
					System.out.println("11111111111111");
					
					
					
					
					
					
					 String Category=request.getParameter("Category");
				        System.out.println("Category---------------->"+Category);
				        String country1=request.getParameter("newcountry");
						System.out.println("NEW COUNTRY:-"+country1);
					
	
       
						
			
			
						try{
					        
		
		
	if(request.getParameter("update")==null) 
	{
		String sqlCode="SELECT MAX(CustomerCode) from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  ";
		ResultSet rscustCode=stmt.executeQuery(sqlCode);

		if(rscustCode.next()){
			System.out.println("11111111111");
			customerCode=rscustCode.getInt(1);
			
		}
		
	System.out.println("iiiiinnnnnn");
	
	customerCode=customerCode+1;
	
	System.out.println("Customer Code for NEW USER for insert into prospectivecustmaster "+customerCode);
			
	String comid=session.getAttribute("CompanyMasterID").toString();
			
	
	sqlInsert ="INSERT INTO "+comid+"prospectivecustmaster(CustomerCode,CompanyName, Address, City, Zip, State,ContactPerson, MobileNo, MobileNo1, MobileNo2, Fax, EMail, WebSite ,IntrestedProduct ,CustEnteredByRep ,	WeeklyOffon ,AddedOnDate,Category, TelephoneNo2, Phone, STDCode, ProspCustAddedOn, Country, comments, PotentialValue, NoOfUnits, Assighnedby,leadRef,Allocatedto,BranchName,GroupOfCompany,TypeOfBuisness, DealInProduct,PayTerms,RiskInvolved,ColloectionStaffName,OpportunityName) VALUES('"+customerCode+"','"+companyName+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+fax+"','"+email+"','"+website+"','"+product+"','"+repName+"','"+weeklyOffOn+"','"+date+"','"+category+"','"+alternateNumber+"','"+phone+"','"+stdCode+"','"+addedOn+"','"+country+"','"+comments.replaceAll("'"," ")+"','"+potentialValue+"','"+noofunits+"','"+assignedBy+"','"+leadRef+"','"+repcode+"','"+BranchName+"','"+GroupofComp+"','"+TypeofBusiness+"','"+product+"','"+paymentterm+"','"+riskInvolved+"','"+ColloectionStaffName+"','"+opprotunity+"')";
	
	System.out.println("Insert prospectivecustmaster-------->"+sqlInsert);
	
	
	 
	  String insert6= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo (Country,State,City) values('"+country1+"','"+state+"','"+city+"')";
	  st20.executeUpdate(insert6);
	   System.out.println("insert Query-----For --------->"+insert6);
	  
	
	sqlInsert1 ="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,companyname,contactperson,designation,Address,country,state,city,zipcode,email,phone,mobileno,fax,Email1 ,Email2 ,mobileno1,mobileno2,EntryBy) values ('"+customerCode+"','"+companyName+"','"+contactPerson+"','-','"+address+"','"+country+"','"+state+"','"+city+"','"+zip+"','"+email+"','"+phone+"','"+mobile+"','"+fax+"','-','-','"+mobile1+"','"+mobile2+"','"+EmpNm+"')";
	
	st13.executeUpdate(sqlInsert1);
	System.out.println("Insert contactdet-------->"+sqlInsert1);
	

	
	
	String sqlInsert2 ="INSERT INTO  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospecthistory (CustomerCode,CompanyName, Address, City, Zip, State,Country,comments,ContactPerson,Phone, Fax, EMail,WebSite ,IntrestedProduct ,CustEnteredByRep,WeeklyOffon,AddedOnDate,STDCode,MobileNo, PotentialValue, NoOfUnits,Assighnedby,leadRef,BranchName,GroupOfCompany,TypeOfBuisness, DealInProduct,PayTerms,RiskInvolved,ColloectionStaffName) VALUES('"+customerCode+"','"+companyName+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+comments.replaceAll("'"," ")+"','"+contactPerson+"','"+phone+"','"+fax+"','"+email+"','"+website+"','"+product+"','"+repName+"','"+weeklyOffOn+"','"+date+"','"+stdCode+"','"+mobile+"','"+potentialValue+"','"+noofunits+"','"+assignedBy+"','"+leadRef+"','"+BranchName+"','"+GroupofComp+"','"+TypeofBusiness+"','"+product+"','"+paymentterm+"','"+riskInvolved+"','"+ColloectionStaffName+"')";
 	st12.executeUpdate(sqlInsert2);
 	System.out.println("Insert historyyyy-------->"+sqlInsert2);
	
	
	}else 
	{
		
		String CustomerCode=request.getParameter("companyName");
		System.out.println("CustomerCode---------------->"+CustomerCode);
		
		String sqlCode1="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode="+CustomerCode+"  ";
		ResultSet rscustCode1=stmt.executeQuery(sqlCode1);

		if(rscustCode1.next()){
			System.out.println("12------------->");
			
			Company=rscustCode1.getString("companyName");
			
			System.out.println("Customer Name======"+Company);
		}
		
	System.out.println("CUSTOMER CODE IS==="+customerCode);
	System.out.println("PRIMARY MOBILE NUMBER==="+mobile);
	sqlInsert ="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster SET verticals='"+verticals+"',segment='"+segment+"',solution='"+solution+"',subgroup='"+subgroup+"',confidencelevel='"+confidencelevel+"',onetimecharge='"+onetimecharge+"',recurringcharge='"+recurringcharge+"',contractvalue='"+contractvalue+"',CompanyName='"+Company+"',Address='"+address.replaceAll("'"," ")+"',City='"+city+"',Zip='"+zip+"',State='"+state+"',ContactPerson='"+contactPerson.trim()+"',MobileNo='"+mobile+"', MobileNo1='"+mobile1+"', MobileNo2='"+mobile2+"',Fax='"+fax+"' ,EMail='"+email.replaceAll("'"," ")+"',WebSite='"+website+"',IntrestedProduct='"+product+"' ,CustEnteredByRep='"+repName+"' ,WeeklyOffon='"+weeklyOffOn+"',AddedOnDate='"+addedOn+"',Category='"+category+"',TelephoneNo2='"+alternateNumber+"' ,phone='"+phone+"',STDCode='"+stdCode+"',ProspCustAddedOn='"+addedOn+"',country='"+country+"' ,comments='"+comments.replaceAll("'"," ").trim()+"',PotentialValue='"+potentialValue+"', NoOfUnits='"+noofunits+"',Assighnedby='"+assignedBy+"',leadRef='"+leadRef+"',BranchName='"+BranchName+"',GroupOfCompany='"+GroupofComp+"',TypeOfBuisness='"+TypeofBusiness+"',DealInProduct='"+product+"', PayTerms='"+paymentterm+"',RiskInvolved='"+riskInvolved+"', ColloectionStaffName='"+ColloectionStaffName+"', OpportunityName='"+opprotunity+"',ReasonForUpdate='"+reasonforupdate+"',Reassignto='"+reassign+"'  WHERE CustomerCode="+CustomerCode+" limit 1";
	System.out.println("Update query ------->"+sqlInsert);
	
	
	 
	  String insert5= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo (Country,State,City) values ('"+country1+"','"+state+"','"+city+"')";
	  st19.executeUpdate(insert5);
	   System.out.println("insert Query-----For --------->"+insert5);
	  
	
	String sqlInsert4 ="INSERT INTO  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospecthistory (solution,verticals,segment,subgroup,confidencelevel,onetimecharge,recurringcharge,contractvalue,CustomerCode,CompanyName, Address, City, Zip, State,Country,comments,ContactPerson,Phone, Fax, EMail,WebSite ,IntrestedProduct ,CustEnteredByRep,WeeklyOffon,AddedOnDate,STDCode,MobileNo, PotentialValue, NoOfUnits,Assighnedby,leadRef,BranchName,GroupOfCompany,TypeOfBuisness, DealInProduct,PayTerms,RiskInvolved,ColloectionStaffName,reasonForUpdate,Reassignto) VALUES('"+solution+"','"+verticals+"','"+segment+"','"+subgroup+"','"+confidencelevel+"','"+onetimecharge+"','"+recurringcharge+"','"+contractvalue+"','"+CustomerCode+"','"+Company+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+comments.replaceAll("'"," ")+"','"+contactPerson+"','"+phone+"','"+fax+"','"+email+"','"+website+"','"+product+"','"+repName+"','"+weeklyOffOn+"','"+date+"','"+stdCode+"','"+mobile+"','"+potentialValue+"','"+noofunits+"','"+assignedBy+"','"+leadRef+"','"+BranchName+"','"+GroupofComp+"','"+TypeofBusiness+"','"+product+"','"+paymentterm+"','"+riskInvolved+"','"+ColloectionStaffName+"','"+reasonforupdate+"','"+reassign+"')";
  	st14.executeUpdate(sqlInsert4);
  	System.out.println("Insert historyyyy-------->"+sqlInsert4);
	
	
	}
	
	
	
	if(Category.equals("Liaison") || Category=="Liaison")
	{
		
		String sqlCode="SELECT MAX(CustomerCode) from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  ";
		ResultSet rscustCode=stmt.executeQuery(sqlCode);

		if(rscustCode.next()){
			System.out.println("11111111111");
			customerCode=rscustCode.getInt(1);
			
		}
		CustCategory="Liaison";
		customerCode=customerCode+1;
		System.out.println("Customer Code for NEW USER"+customerCode);
		String comid=session.getAttribute("CompanyMasterID").toString();
		
		sqlInsert ="INSERT INTO "+comid+"prospectivecustmaster(CustomerCode,CompanyName, Address, City, Zip, State,ContactPerson, MobileNo, MobileNo1, MobileNo2, Fax, EMail, WebSite ,IntrestedProduct ,CustEnteredByRep ,	WeeklyOffon ,AddedOnDate,Category, TelephoneNo2, phone, STDCode, ProspCustAddedOn, Country, comments, PotentialValue, NoOfUnits, Assighnedby,leadRef,Allocatedto,BranchName,GroupOfCompany,TypeOfBuisness, DealInProduct,PayTerms,RiskInvolved,ColloectionStaffName,OpportunityName,CustCategory) VALUES('"+customerCode+"','"+companyName+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+fax+"','"+email+"','"+website+"','"+product+"','"+repName+"','"+weeklyOffOn+"','"+date+"','"+category+"','"+alternateNumber+"','"+phone+"','"+stdCode+"','"+addedOn+"','"+country+"','"+comments.replaceAll("'"," ")+"','"+potentialValue+"','"+noofunits+"','"+assignedBy+"','"+leadRef+"','"+repcode+"','"+BranchName+"','"+GroupofComp+"','"+TypeofBusiness+"','"+product+"','"+paymentterm+"','"+riskInvolved+"','"+ColloectionStaffName+"','"+opprotunity+"','"+CustCategory+"')";
		
		System.out.println("Insert prospect Lision-------->"+sqlInsert);
		
		 
		  String insert1= "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo (Country,State,City) values('"+country1+"','"+state+"','"+city+"')";
		  st18.executeUpdate(insert1);
		   System.out.println("insert Query-----For --------->"+insert1);
		  
	
		
		String sqlInsert15 ="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,companyname,contactperson,designation,Address,country,state,city,zipcode,email,phone,mobileno,fax,Email1 ,Email2 ,mobileno1,mobileno2,EntryBy) values ('"+customerCode+"','"+companyName+"','"+contactPerson+"','-','"+address+"','"+country+"','"+state+"','"+city+"','"+zip+"','"+email+"','"+phone+"','"+mobile+"','"+fax+"','-','-','"+mobile1+"','"+mobile2+"','"+EmpNm+"')";
		
		st73.executeUpdate(sqlInsert15);
		System.out.println("Insert contactdet-------->"+sqlInsert15);
	}
	}
						
						
						
						
						
						
						
						
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	Statement stsms=con.createStatement();
			
	int sqlst= stsms.executeUpdate(sqlInsert);
	
	Statement stsms1=con.createStatement();
	
	String msg = "";		
    boolean flag=false;
    if(sqlst>=1)
	{	
	response.sendRedirect("alertGoTo.jsp?msg=Details saved successfully&goto=home.jsp");	
	}else
	{
	response.sendRedirect("alertGoTo.jsp?msg=Details NOT saved &goto=home.jsp");
	}

    
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("End second last");
			
		}


}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println("End last");
}


%>