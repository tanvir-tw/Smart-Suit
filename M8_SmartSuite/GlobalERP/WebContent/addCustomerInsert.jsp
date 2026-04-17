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
String repName="", vendor="", companyName="", companyafteredit="", contactPerson="",website="",email="",zip="",state="",         
country="", phone="",fax="",category="",product="",weeklyOffOn="", alternateNumber="",address="",date=new SimpleDateFormat("yyyy-MM-dd").format(new Date()),
mobile="",mobile1="", mobile2="",logo="",stdCode="",addedOn=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),
potentialValue="",comments="",assignedBy="",leadRef="",noofunits="",BranchName="",GroupofComp="",TypeofBusiness="",ColloectionStaffName="",
paymentterm="",riskInvolved="", opprotunity="";
		
try{
opprotunity=(request.getParameter("Opportunity")== null || request.getParameter("Opportunity").equalsIgnoreCase(""))?"":request.getParameter("Opportunity");
repName=(request.getParameter("repName")== null || request.getParameter("repName").equalsIgnoreCase(""))?"":request.getParameter("repName");
vendor=(request.getParameter("vendorcode")== null || request.getParameter("vendorcode").equalsIgnoreCase(""))?"":request.getParameter("vendorcode");
companyName=(request.getParameter("companyName")== null || request.getParameter("companyName").equalsIgnoreCase(""))?"":request.getParameter("companyName");
companyafteredit=(request.getParameter("companyNameafteredit")== null || request.getParameter("companyNameafteredit").equalsIgnoreCase(""))?"":request.getParameter("companyNameafteredit");
contactPerson=(request.getParameter("contactPerson")== null || request.getParameter("contactPerson").equalsIgnoreCase(""))?"":request.getParameter("contactPerson");
website=(request.getParameter("website")== null || request.getParameter("website").equalsIgnoreCase(""))?"":request.getParameter("website");
email=(request.getParameter("email")== null || request.getParameter("email").equalsIgnoreCase("email"))?"":request.getParameter("email");
zip=(request.getParameter("zip")== null || request.getParameter("zip").equalsIgnoreCase(""))?"":request.getParameter("zip");
state=(request.getParameter("state")== null || request.getParameter("state").equalsIgnoreCase(""))?"":request.getParameter("state");
country=(request.getParameter("country1")== null || request.getParameter("country1").equalsIgnoreCase(""))?"":request.getParameter("country1");
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
noofunits=(request.getParameter("noofunits")== null || request.getParameter("noofunits").equalsIgnoreCase(""))?"":request.getParameter("noofunits");
BranchName=(request.getParameter("BranchMaster")== null || request.getParameter("BranchMaster").equalsIgnoreCase(""))?"":request.getParameter("BranchMaster");
GroupofComp=(request.getParameter("grcomp")== null || request.getParameter("grcomp").equalsIgnoreCase(""))?"":request.getParameter("grcomp");
TypeofBusiness=(request.getParameter("typebusiness")== null || request.getParameter("typebusiness").equalsIgnoreCase(""))?"":request.getParameter("typebusiness");
ColloectionStaffName=(request.getParameter("CollectionStaff")== null || request.getParameter("CollectionStaff").equalsIgnoreCase(""))?"":request.getParameter("CollectionStaff");
paymentterm=(request.getParameter("payment")== null || request.getParameter("payment").equalsIgnoreCase(""))?"":request.getParameter("payment");
riskInvolved=(request.getParameter("RiskInvolved")== null || request.getParameter("RiskInvolved").equalsIgnoreCase(""))?"":request.getParameter("RiskInvolved");
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
}
		System.out.println("Opportunity Name"+opprotunity);
		System.out.println("Vender code----"+vendor);
		System.out.println("COMPANY IS *****************     "+companyName);
		System.out.println("COMPANY AFTER EDIT IS      *****************     "+companyafteredit);
		System.out.println("CONTACT PERSON  IS      *****************     "+contactPerson);
		System.out.println("Website----"+website);
		System.out.println("EMAIL----"+email);
		System.out.println("ZIP CODE----"+zip);
		System.out.println("SATE-----"+state);
		System.out.println("COUNTRY----"+country);
		System.out.println("PHONE----"+phone);
		System.out.println("FAX---faxxxxxxxxxxxxxxxxxxxxxxxxx-"+fax);
		System.out.println("CATEGORY----"+category);
		System.out.println("PRODUCT----"+product);
		System.out.println("WEEKLY OFF ON----"+weeklyOffOn);
		System.out.println("ALTERNATE NUMBER----"+alternateNumber);
		String newaddress=request.getParameter("address");
		System.out.println("ADDRESS----"+address);
		System.out.println("newaddress----"+newaddress);
		System.out.println("Primary Mobile--mobllllllllllllllllll--"+mobile);
		System.out.println("Mobile NUMBER---mobillllllllllllllll2222222222-"+mobile1);
		System.out.println("MOBILE---mobil33333333333333333333333-"+mobile2);
		System.out.println("STD CODE---std codeeeeeeeeeeeeeeeeeeeeeeeee-"+stdCode);
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
		
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		Statement stmt=con.createStatement();
		Statement stmt1=con.createStatement();
		Statement stmt2=con.createStatement();
		Statement stmt3=con.createStatement();
		Statement stcity=con.createStatement();
		Statement st4=con.createStatement();
		Statement st5=con.createStatement();
		Statement stmt99=con.createStatement();
		System.out.println("After con.createStatement()");
		String city="",newcity="-";
		
		
		try
		{
		 city=(request.getParameter("city")== null || request.getParameter("city").equalsIgnoreCase(""))?request.getParameter("newcity"):request.getParameter("city");
		}catch(Exception e)
		{
			city="";
		}
		System.out.println("New City ISSSSSSS ===="+request.getParameter("newcity"));
		System.out.println("=========111111111");
		try{
			category=request.getParameter("category");
		}catch(Exception e)
		{
			category="1";
		}
		System.out.println("city is ===="+city);
		
      	try{
		if(request.getParameter("newcity")!="" && city.equalsIgnoreCase("Select") )
        {
        	System.out.println("in if newcity!=");
        	city=request.getParameter("newcity");
        	
        	System.out.println("city is*&*&*&*"+city);
        	city = city.substring(0,1).toUpperCase() + city.substring(1).toLowerCase();
        	System.out.println("NEW city--------->>>>"+city);
        	String sql = "select Distinct(City) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo";
        	ResultSet rs = st4.executeQuery(sql);
        	if(rs.next())
        	{
        		out.println("<html><script>alert('City Is Allready Exist') </script> </html>");	
        	}else
        	{
        		System.out.println("in else newcity!=");
	        	String city1 = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City,State,Country)values('"+city+"','"+state+"','"+country+"')";
	        	stcity.execute(city1);
	        	
	        	System.out.println("city inserted");
        	}
        }
       System.out.println("city is"+city);
		}catch(Exception e)
      	{
      		
      	}
    	try
		{
		 state=(request.getParameter("state")== null || request.getParameter("state").equalsIgnoreCase(""))?request.getParameter("newstate"):request.getParameter("state");
		}catch(Exception e)
		{
			city="";
		}
		System.out.println("New state ISSSSSSS ===="+request.getParameter("newstate"));
		System.out.println("=========111111111");
		try{
			category=request.getParameter("category");
		}catch(Exception e)
		{
			category="1";
		}
		System.out.println("state is ===="+state);
		
      	try{
		if(request.getParameter("newstate")!="" && state.equalsIgnoreCase("Select") )
        {
        	System.out.println("in if newcity!=");
        	state=request.getParameter("newstate");
        	
        	System.out.println("city is*&*&*&*"+state);
        	state = state.substring(0,1).toUpperCase() + state.substring(1).toLowerCase();
        	System.out.println("NEW state--------->>>>"+state);
        	String sql = "select Distinct(state) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo ";
        	ResultSet rs = st4.executeQuery(sql);
        	if(rs.next())
        	{
        		out.println("<html><script>alert('City Is Allready Exist') </script> </html>");	
        	}else
        	{
        		System.out.println("in else newcity!=");
	        	String state1 = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City,State,Country)values('"+city+"','"+state+"','"+country+"')";
	        	stcity.execute(state1);
	        	System.out.println("state inserted");
        	}
        }
       System.out.println("city is"+state);
		}catch(Exception e)
      	{
      		
      	}
      	
      	
      	
      	try
		{
		 country=(request.getParameter("country1")== null || request.getParameter("country1").equalsIgnoreCase(""))?request.getParameter("newcountry"):request.getParameter("country1");
		}catch(Exception e)
		{
			country="";
		}
		System.out.println("New City ISSSSSSS ===="+request.getParameter("newcountry"));
		System.out.println("=========111111111");
		try{
			category=request.getParameter("category");
		}catch(Exception e)
		{
			category="1";
		}
		System.out.println("country issssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss ===="+country);
		
      	try{
		if(request.getParameter("newcountry")!="" && state.equalsIgnoreCase("Select") )
        {
        	System.out.println("in if newcountry!=");
        	state=request.getParameter("newcountry");
        	
        	System.out.println("city is*&*&*&*"+country);
        	country = country.substring(0,1).toUpperCase() + state.substring(1).toLowerCase();
        	System.out.println("NEW country--------->>>>"+country);
        	String sql = "select Distinct(country) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo";
        	ResultSet rs = st4.executeQuery(sql);
        	if(rs.next())
        	{
        		out.println("<html><script>alert('Country Is Allready Exist') </script> </html>");	
        	}else
        	{
        		System.out.println("in else newcountry!=");
	        	String country2 = "insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"citystctryinfo(City,State,Country)values('"+city+"','"+state+"','"+country+"')";
	        	stcity.execute(country2);
	        	System.out.println("countryyyyyyyyyyyyyy inserted---------------------"+country2);
	        	
        	}
        }
       System.out.println("country is"+country);
		}catch(Exception e)
      	{
      		
      	}
      	
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
					String sqlCode="SELECT MAX(CustomerCode) from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  ";
					ResultSet rscustCode=stmt.executeQuery(sqlCode);

					if(rscustCode.next()){
						System.out.println("11111111111");
						customerCode=rscustCode.getInt(1);
						System.out.println("Customer code======"+customerCode);
					}
					
	try{	
		
		String strcompname="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CompanyName='"+companyName+"'";
		ResultSet rsstrcompname=stmt99.executeQuery(strcompname);
		if(rsstrcompname.next()){
			System.out.println("inner loop-===================");
			response.sendRedirect("alertGoTo.jsp?msg=Details NOT saved beacuse company name already exists..!&goto=addNewCustomer.jsp");
			//String companyName1=companyName;
			//String contactPerson1=contactPerson;
			//response.sendRedirect("addNewCustomer.jsp?companyName1='"+companyName1+"'&contactPerson1='"+contactPerson1+"'");
			//String companyName1="<div>this is error</div>";
			//response.sendRedirect("addNewCustomer.jsp?companyName1='"+companyName1+"' ");
			
		}else{
	if(request.getParameter("update")==null) 
	{
	System.out.println("iiiiinnnnnn");
	customerCode=customerCode+1;
	System.out.println("Customer Code for NEW USER"+customerCode);
	String comid=session.getAttribute("CompanyMasterID").toString();
	
	sqlInsert ="INSERT INTO  db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CustomerCode,CompanyName, Address, City, Zip, State,ContactPerson, MobileNo, MobileNo1, MobileNo2, Fax, EMail, WebSite ,IntrestedProduct ,CustEnteredByRep ,	WeeklyOffon ,AddedOnDate,Category, TelephoneNo2, phone, STDCode, ProspCustAddedOn, Country, comments, PotentialValue, NoOfUnits, Assighnedby,leadRef,Allocatedto,BranchName,GroupOfCompany,TypeOfBuisness, DealInProduct,PayTerms,RiskInvolved,ColloectionStaffName,OpportunityName) VALUES('"+customerCode+"','"+companyName+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+fax+"','"+email+"','"+website+"','"+product+"','"+repName+"','"+weeklyOffOn+"','"+date+"','"+category+"','"+alternateNumber+"','"+phone+"','"+stdCode+"','"+addedOn+"','"+country+"','"+comments.replaceAll("'"," ")+"','"+potentialValue+"','"+noofunits+"','"+assignedBy+"','"+leadRef+"','"+repcode+"','"+BranchName+"','"+GroupofComp+"','"+TypeofBusiness+"','"+product+"','"+paymentterm+"','"+riskInvolved+"','"+ColloectionStaffName+"','"+opprotunity+"')";
	}else 
	{
		
 	String customerCode1=request.getParameter("companyName");
	System.out.println("CUSTOMER CODE IS==="+customerCode);
	System.out.println("PRIMARY MOBILE NUMBER==="+mobile);
	
// 	String custcode=request.getParameter("customerCode");
// 	System.out.println("CUSTOMER CODE IS==="+custcode);
	String company=request.getParameter("companyName123");
	System.out.println("Company is in updatee....==="+company);
	String addr=request.getParameter("address");
	System.out.println("Company is in updatee....==="+addr);
	
	
	//String city1=request.getParameter("address");
 	String city1=(request.getParameter("city")== null || request.getParameter("city").equalsIgnoreCase(""))?request.getParameter("newcity"):request.getParameter("city");
	System.out.println("Company is in updatee....==="+city1);
	String zip1=request.getParameter("zip");
	System.out.println("Company is in updatee....==="+zip1);
	//String state1=request.getParameter("address");
 	String state1=(request.getParameter("state")== null || request.getParameter("state").equalsIgnoreCase(""))?request.getParameter("newstate"):request.getParameter("state");
	System.out.println("Company is in updatee....==="+state1);
	String contactperson1=request.getParameter("contactPerson");
	System.out.println("Contact person  is in updatee....==="+contactperson1 );
	String Mobile=request.getParameter("mobile");
	System.out.println("mobile is in updatee....==="+Mobile);
	String Fax=request.getParameter("faxno");
	System.out.println("Company is in updatee....==="+Fax );
	String Email=request.getParameter("email");
	System.out.println("Company is in updatee....==="+Email );
	
	String Website=request.getParameter("website");
	System.out.println("Company is in updatee....==="+Website );
	
	String product1=request.getParameter("product");
	System.out.println("productis in updatee....==="+product1 );
 	//String Website=request.getParameter("website");
	//System.out.println("Company is in updatee....==="+Website );
	String weeklyOffOn1=request.getParameter("weeklyOffOn");
	System.out.println("weeklyOffOn is in updatee....==="+weeklyOffOn1 );
	//String Website=request.getParameter("website");
	//System.out.println("Company is in updatee....==="+Website );
	String category1=request.getParameter("category");
	System.out.println("category is in updatee....==="+category1 );
	String alternateNumber1=request.getParameter("alternateNumber");
	System.out.println("alternateNumber1 is in updatee....==="+alternateNumber1 );
	
	String phone1=request.getParameter("phone");
	System.out.println("phone is in updatee....==="+phone1 );
	
	String std1=request.getParameter("std");
	System.out.println("std is in updatee....==="+std1 );
	
	//String alternateNumber1=request.getParameter("alternateNumber");
	//System.out.println("alternateNumber1 is in updatee....==="+alternateNumber1 );
//String country1=request.getParameter("address1");
 	String country1=(request.getParameter("country1")== null || request.getParameter("country1").equalsIgnoreCase(""))?request.getParameter("newcountry"):request.getParameter("country1");
	System.out.println("country1 is in updatee....==="+country1 );
	
	String comments1=request.getParameter("comments");
	System.out.println("comments is in updatee....==="+comments1 );
	
	String potentialValue1=request.getParameter("potentialValue");
	System.out.println("potential  is in updatee....==="+potentialValue1 );
	
	String noofunits1=request.getParameter("noofunits");
	System.out.println("noofunits is in updatee....==="+noofunits1 );
	
	String assigned1=request.getParameter("assigned");
	System.out.println("comments is in updatee....==="+assigned1 );
	
	
	
	
	
	String city2="",country2="",state2="";
	String sql="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where CustomerCode ='"+request.getParameter("companyName").replaceAll("~~","&")+"' limit 1 ";
	System.out.println("CHANGED QUERY   "+sql);	
	ResultSet rs1 = st4.executeQuery(sql);
		 while(rs1.next())
		 {
			 city2=rs1.getString("City");
			 country2=rs1.getString("Country");
			 state2=rs1.getString("State");
		 }
		 
		 System.out.println("city 88888....==="+city2+"---------------------"+state2+"88888888"+country2 );
			 
		
if(city1=="null" || city1==" " || city1=="" || city1=="Select" )
{
	city1=city2;
	
}
	
	if(country1=="null" || country1==" " || country1=="" || country1=="Select")
	{
		country1=country2;
		
	}
	if(state1=="null" || state1==" " || state1=="" || state1=="Select")
	{
		state1=state2;
	}
	
	 System.out.println("city 88888....==="+city1+"---------------------"+state1+"88888888"+country1 );
	
	
	
	
	
	
	sqlInsert ="UPDATE db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster SET companyName='"+company+"' ,Address='"+addr.replaceAll("'"," ")+"',City='"+city1+"',Zip='"+zip1+"',State='"+state1+"',ContactPerson='"+contactPerson.trim()+"',MobileNo='"+Mobile+"', MobileNo1='"+mobile1+"', MobileNo2='"+mobile2+"',Fax='"+Fax+"' ,EMail='"+Email.replaceAll("'"," ")+"',WebSite='"+Website+"',IntrestedProduct='"+product1+"' ,CustEnteredByRep='"+repName+"' ,WeeklyOffon='"+weeklyOffOn1+"',AddedOnDate='"+addedOn+"',Category='"+category1+"',TelephoneNo2='"+alternateNumber1+"' ,phone='"+phone1+"',STDCode='"+std1+"',ProspCustAddedOn='"+addedOn+"',country='"+country1+"' ,comments='"+comments1.replaceAll("'"," ").trim()+"',PotentialValue='"+potentialValue1+"', NoOfUnits='"+noofunits1+"',Assighnedby='"+assigned1+"',leadRef='"+leadRef+"',BranchName='"+BranchName+"',GroupOfCompany='"+GroupofComp+"',TypeOfBuisness='"+TypeofBusiness+"',DealInProduct='"+product+"', PayTerms='"+paymentterm+"',RiskInvolved='"+riskInvolved+"', ColloectionStaffName='"+ColloectionStaffName+"', OpportunityName='"+opprotunity+"'  WHERE CustomerCode="+customerCode1+" limit 1";     
	}
		}
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	System.out.println(sqlInsert);
	Statement stsms=con.createStatement();
			
	int sqlst= stsms.executeUpdate(sqlInsert);
	String msg = "";		
    boolean flag=false;
    if(sqlst>=1)
	{	
	response.sendRedirect("alertGoTo.jsp?msg=Details saved successfully&goto=home.jsp");	
	}else
	{
	response.sendRedirect("alertGoTo.jsp?msg=Details NOT saved &goto=home.jsp");
	}





String sqlHistory="";
if(request.getParameter("update")!=null)
{
	System.out.println("in request.getParameter(update)!=");
 	String reasonForUpdate=request.getParameter("reason");
	//String sqlSetails=" SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  WHERE CompanyName='"+request.getParameter("companyName")+"'";
	String sqlSetails=" SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster  WHERE customercode='"+request.getParameter("companyName")+"'";//request.getParameter("companyName") is returning customercode
	ResultSet rsDetails= stmt1.executeQuery(sqlSetails);
	String categor="", resNo="", vCode="",haddress="",hcity="",hzip="",hstate="",hlogo="", hcontactPerson="",hmobile="",hmobile1="",hmobile2="",hfax="",hwebsite="",hproduct="",hrepName="",hweeklyOffOn="",hdate="",hcategory="",
			halternateNumber="",hphone="",hemail="", hstdCode="",haddedOn="",hcountry="",hpotentialValue="",hnoofunits="",hassignedBy="",hleadRef="",hrepcode="",hbranch="",hgrpofComp="",htypeofbus="",hcolestfname="",
					hpayterm="",hriskinv="";

	System.out.println(")))======="+sqlSetails);
	if(rsDetails.next())
	{  
		System.out.println(")))=======1111111"+sqlSetails);	
		sqlHistory="insert into "+session.getAttribute("CompanyMasterID").toString()+"prospecthistory  (CustomerCode,CompanyName,Address,Zip,State,Country,ContactPerson,"+
		 " Phone,Fax,EMail,WebSite,IntrestedProduct,CustEnteredByRep,WeeklyOffon,AddedOnDate,ProspCustAddedOn,SalesCustomerCode,"+
		 " IsDataValid,Category,STDCode,MobileNo,ResiNo,TelephoneNo2,VendorCode,PotentialValue,NoOfUnits,Assighnedby,"+
		 "Comments,leadRef,reasonForUpdate,UpdateDateTime,UpdatedBy, BranchName,GroupOfCompany,TypeOfBuisness, PayTerms,RiskInvolved,ColloectionStaffName )"+
		 "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?)";
		
		System.out.println(")))=======33333");
		
			System.out.println(")))=======In try block");
			System.out.println("historyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"+sqlHistory);
		try
		{
			System.out.println("historyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
			
			haddress=(rsDetails.getString(3) == null || rsDetails.getString(3).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(3);
			hzip=(rsDetails.getString(5) == null || rsDetails.getString(5).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(5);
			hstate=(rsDetails.getString(6) == null || rsDetails.getString(6).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(6);
			hcountry=(rsDetails.getString(7) == null || rsDetails.getString(7).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(7);
			hphone=(rsDetails.getString(9) == null || rsDetails.getString(9).equalsIgnoreCase("") ) ? "0" : rsDetails.getString(9);		
			hfax=(rsDetails.getString(10) == null || rsDetails.getString(10).equalsIgnoreCase("") ) ? "0" : rsDetails.getString(10);
			hemail=(rsDetails.getString(11) == null || rsDetails.getString(11).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(11);
			hwebsite=(rsDetails.getString(12) == null || rsDetails.getString(12).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(12);
			hproduct=(rsDetails.getString(13) == null || rsDetails.getString(13).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(13);
			hrepName=(rsDetails.getString(14) == null || rsDetails.getString(14).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(14);
			hweeklyOffOn=(rsDetails.getString(15) == null || rsDetails.getString(15).equalsIgnoreCase("") ) ? "-" : rsDetails.getString(15);
			haddedOn=(rsDetails.getString(16) == null || rsDetails.getString(16).equalsIgnoreCase("") ) ? "00-00-0000": new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDetails.getString(16)));
			hstdCode = (rsDetails.getString(21) == null || rsDetails.getString(21).equalsIgnoreCase("") ) ? "0" : rsDetails.getString(21);
			categor=(rsDetails.getString(20) == null || rsDetails.getString(20).equalsIgnoreCase("")||rsDetails.getString(20).equalsIgnoreCase("-") ) ? "1" : rsDetails.getString(20);
			resNo = (rsDetails.getString(23) == null || rsDetails.getString(23).equalsIgnoreCase("") ) ? "0" : rsDetails.getString(23);
			vCode=(rsDetails.getString(25) == null || rsDetails.getString(25).equalsIgnoreCase("") ) ? "0" : rsDetails.getString(25);
			hbranch=(rsDetails.getString(34) == null || rsDetails.getString(34).equalsIgnoreCase("")||rsDetails.getString(34).equalsIgnoreCase("-") ) ? "-" : rsDetails.getString(34);
			hgrpofComp=(rsDetails.getString(35) == null || rsDetails.getString(35).equalsIgnoreCase("")||rsDetails.getString(35).equalsIgnoreCase("-") ) ? "-" : rsDetails.getString(35);
			htypeofbus=(rsDetails.getString(36) == null || rsDetails.getString(36).equalsIgnoreCase("")||rsDetails.getString(36).equalsIgnoreCase("-") ) ? "-" : rsDetails.getString(36);
			hcolestfname=(rsDetails.getString(40) == null || rsDetails.getString(40).equalsIgnoreCase("")||rsDetails.getString(40).equalsIgnoreCase("-") ) ? "-" : rsDetails.getString(40);
			hpayterm=(rsDetails.getString(38) == null || rsDetails.getString(38).equalsIgnoreCase("")||rsDetails.getString(38).equalsIgnoreCase("-") ) ? "-" : rsDetails.getString(38);
			hriskinv=(rsDetails.getString(39) == null || rsDetails.getString(39).equalsIgnoreCase("")||rsDetails.getString(39).equalsIgnoreCase("-") ) ? "-" : rsDetails.getString(39);
		
		}catch(Exception e)
		{
			
			haddress="";
			hzip="";
			hstate="";
			hcountry="";
			hphone="0";
			hfax="0";
			hemail="";
			hwebsite="";
			hproduct="";
			hrepName="";
			hweeklyOffOn="";
			haddedOn="0000-00-00";
			hstdCode="0";
			categor="1";
			resNo="0";
			vCode="0";
			hbranch="";
			hgrpofComp="";
			htypeofbus="";
			hcolestfname="";
			hpayterm="";
			hriskinv="";
		}
		System.out.println(")))=======Addr"+haddress);
		System.out.println(")))=======zip"+hzip);
		System.out.println(")))=======state"+hstate);
		System.out.println(")))=======country"+hcountry);
		System.out.println(")))=======phone"+hphone);
		System.out.println(")))=======fax"+hfax);
		System.out.println(")))=======email"+hemail);
		System.out.println(")))=======web"+hwebsite);
		System.out.println(")))=======product"+hproduct);
		System.out.println(")))=======repName"+hrepName);
		System.out.println(")))=======weely off"+hweeklyOffOn);
		System.out.println(")))=======added"+haddedOn);
		System.out.println(")))=======std"+hstdCode);
		System.out.println(")))=======categroy"+categor);
		
		int x=rsDetails.getInt(1);
		System.out.println(")))=======2222---"+x);
		
		java.sql.PreparedStatement stmtmain = con.prepareStatement( sqlHistory );
		 
			stmtmain.setInt(1,x);
		 stmtmain.setString(2,companyafteredit);
		 stmtmain.setString(3,haddress);
		 stmtmain.setString(4,city);
		 stmtmain.setString(5,hzip);
		 
		 stmtmain.setString(6,hstate);
		 stmtmain.setString(7,hcountry);
		 stmtmain.setString(8,rsDetails.getString(8));
		 stmtmain.setString(9,hphone);
		 stmtmain.setString(10,hfax);
		 
		 stmtmain.setString(11,hemail);
		 stmtmain.setString(12,hwebsite);
		 stmtmain.setString(13,hproduct);
		 stmtmain.setString(14,hrepName);
		 stmtmain.setString(15,hweeklyOffOn);
		 
		 stmtmain.setString(16,haddedOn);
		 stmtmain.setString(17,haddedOn);
		 stmtmain.setString(18,rsDetails.getString(18));
		 stmtmain.setString(19,rsDetails.getString(19));
		 stmtmain.setString(20,categor);
		 
		 stmtmain.setString(21,hstdCode);
		 stmtmain.setString(22,rsDetails.getString(22));
		 stmtmain.setString(23,resNo);
		 stmtmain.setString(24,rsDetails.getString(24));
		 stmtmain.setString(25,vCode);
		 
		 stmtmain.setString(26,rsDetails.getString(26));
		 stmtmain.setString(27,rsDetails.getString(27));
		 stmtmain.setString(28,rsDetails.getString(28));
		 stmtmain.setString(29,rsDetails.getString(29));
		 stmtmain.setString(30,rsDetails.getString(30));	 
		 
		 stmtmain.setString(31,reasonForUpdate);	 
		 stmtmain.setString(32,dateTime);	 
		 stmtmain.setString(33,repName);
		 stmtmain.setString(34,hbranch);
		 stmtmain.setString(35,hgrpofComp);
		
		 stmtmain.setString(36,htypeofbus);
		 stmtmain.setString(37,hpayterm);
		 stmtmain.setString(38,hriskinv);
		 stmtmain.setString(39,hcolestfname);
		 
		stmtmain.executeUpdate();
		System.out.println(sqlHistory);
}

System.out.println(sqlHistory);
stmt.executeUpdate(sqlInsert);

System.out.println("Last hi");

if(request.getParameter("update")==null) 
	{
		 int addresscode;
		 String sql="SELECT MAX(AddressCode) FROM "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr";
		 ResultSet rsAdd=stmt3.executeQuery(sql);
		 rsAdd.next();
		 addresscode=rsAdd.getInt(1);
		 System.out.println(addresscode);
		 addresscode++;
		 
		 
 		 String sqlAddress="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustaddr (Customercode ,AddressCode ,IntrestedProduct ,ContactPerson ,Address, "+
         "City,Zip ,State ,Country ,Phone ,Fax ,EMail ,STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode)"     +        
         "VALUES('"+customerCode+"','"+addresscode+"','"+product+"','"+logo+" "+contactPerson+"','"+address.replaceAll("'"," ")+"',"+
         "'"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+email.replaceAll("'"," ")+"','"+stdCode+"','"+mobile+"','0','"+alternateNumber+"','0')";
		 stmt.executeUpdate(sqlAddress);
		 
		 System.out.println("Insert query is "+sqlAddress);
		 
		String sqlcon ="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,contactperson,"+
			"mobileno,mobileno1,mobileno2,AlternetNO,email,phone,fax,zipcode"+
			",address,city,state,country) VALUES ('"+customerCode+"','"+logo+" "+contactPerson+"','"+mobile+"','"+mobile1+"','"+mobile2+"','"+alternateNumber+"','"+email.replaceAll("'"," ")+"','"+phone+"','"+fax+"','"+zip+"','"+address.replaceAll("'"," ")+"','"+city+"','"+state+"','"+country+"')";
		stmt.executeUpdate(sqlcon);
		 
		 System.out.println("Insert query is "+sqlcon);
}
flag=true;


try{
String numbers="NA",sendEmailTo="-";
if(request.getParameter("update")==null )   
{
try{
	
	String repDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster where MarketingRepName='"+repName+"'";
	System.out.println(repDetails);
	ResultSet rsRepDetails=stmt.executeQuery(repDetails);
	if(rsRepDetails.next())
	{
		String msgid = null, sms = "";
		  numbers = rsRepDetails.getString("MarketingRepPhNo");
			if(numbers.length()>9) 
				{
				String nos=mobile;
				if(!(phone.equalsIgnoreCase("") || phone.equalsIgnoreCase("0")))
					nos+=" , "+phone;
				System.out.println(nos + numbers);
				
				if(assignedBy.equalsIgnoreCase(repName))		
					 sms="New Prospect "+companyName+" is added by you. Please contact "+contactPerson+" on "+nos+" ";
				else
				 sms="New Prospect "+companyName+" is assiged to you by "+session.getAttribute("EmpName")+". Please contact "+contactPerson+" on "+nos+" ";
				
				try {
						String sql1 = "";
						sms = sms.replace("]", " ").replace("'", " ").replace(";", " ").replace("&", " ").replace("@", " ").replace("<>", " ").replace("[", " ");
						sms = URLEncoder.encode(sms);
			
						String smsurl = null;
			
						smsurl = "http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=TransWld&to="
								+ numbers + "&message=" + sms + "&gateway=regular";
						URL url = new URL(smsurl);
						URLConnection connection = url.openConnection();
						connection.connect();
						BufferedReader in = new BufferedReader(
								new InputStreamReader(connection.getInputStream()));
						String line;
						while ((line = in.readLine()) != null) {
							System.out.println(line);
							msgid = line;
						}
							try{
								stsms.executeUpdate("INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"smshistory (SentBy,Msg,DateTime ) VALUES('"+repName+"','"+sms.replace("+"," ")+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')");
							}catch(Exception ee){
								System.out.println("excep in save to t_smshistory"+ee);
							}
					} catch (Exception e) {
						System.out.println(e);
						out.println("SMS Sending Failed("+numbers+")");
					} finally { }
				}
			
			sendEmailTo=rsRepDetails.getString("MarketingRepEMail");
			addedOn=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(addedOn));
			if(!(sendEmailTo.equalsIgnoreCase("-")))
			{
				System.out.println("Sending email....");
				String Data="";
				if(assignedBy.equalsIgnoreCase(repName))
				{
					 Data = "added by "+assignedBy+" on "+addedOn+"<br> <br>";
				}
				else
				{
					Data = "assigned to you by "+assignedBy+" on "+addedOn+"<br> <br>";
				}
				String headerString="",htmlString="";
				int i=1;
				Date today = new Date();
				Calendar cal = Calendar.getInstance();
				cal.setTime(today);
				cal.add(Calendar.DAY_OF_MONTH, -1);
				Date today30 = cal.getTime();
				String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
				String todaysDateFormat=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
				headerString = " "; 
				htmlString = "<html><body><span style='margin-left:5%;'><strong>Please verify following details of New Prospective Customer :-<br><br></stong></span>";
				htmlString = htmlString +"<div><table cellpadding='0' cellspacing='2' style='margin-left:5%; font-family:verdana; font-size:14; border:thin solid; border-color:black; '>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Prospect</td><td style='background-color: #D4EEF5;width:250px;'><strong>"+companyName+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Address:</td><td style='background-color: #D4EEF5;'>"+address+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>City:</td><td style='background-color: #D4EEF5;'> "+city+" - "+zip+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >State :</td><td style='background-color: #D4EEF5;'> "+state+" ["+country+"]</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Phone No:</td><td style='background-color: #D4EEF5;'> <strong>"+stdCode+" - "+phone+"</strong> </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Alternate Number:</td><td style='background-color: #D4EEF5;'>"+alternateNumber+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Website:</td><td style='background-color: #D4EEF5;'> "+website+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Contact Person :</td><td style='background-color: #D4EEF5;'><strong>"+logo+" "+contactPerson+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Mobile no :</td><td style='background-color: #D4EEF5;'>"+mobile+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'  >Email:</td><td style='background-color: #D4EEF5;'><strong>"+email+"</strong></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2'></td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td  style='background-color: #38469E; color:white;'>Intrested In Product :</td><td style='background-color: #D4EEF5;'> "+product+"</td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Potential Value:</td><td style='background-color: #D4EEF5;'> "+potentialValue+" </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;'>Weekly Off On:</td><td style='background-color: #D4EEF5;'> "+weeklyOffOn+" </td></tr>";
				htmlString = htmlString +"<tr style='border:thin solid;'><td style='background-color: #38469E; color:white;' >Comments:</td><td style='background-color: #D4EEF5;'> "+comments+"</td> </tr>";
				htmlString = htmlString +"<tr style='border:thin solid;height:6px;'><td style='background-color: #FDBD84; color:white;' colspan='2' ></td></tr>";
				htmlString = htmlString +"</tr></table><br>";
				htmlString = htmlString +"<span style='margin-left:5%;'><strong>"+Data+"</stong></span> </div></body></html>";
								i=1;
				int sumFollowUp=0;
 

				Data = htmlString;
	     		Properties props = new Properties();
				String host="smtp.transworld-compressor.com";
				String protocol="smtp";
				String user="tripend@mobile-eye.in"; //jd@mobile-eye.in  tripend@mobile-eye.in
				String pass2="transworld";
				props.put("mail.smtp.starttls.enable","true");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.user", "user");
				props.put("mail.smtp.password", "pass");  
				props.put("mail.store.protocol", protocol);
				props.put("mail.smtps.host", host);
				 
				Session session1 = Session.getDefaultInstance(props, null);
				Message msga = new MimeMessage(session1);
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					msga.setSubject("New Lead: "+companyName+" , assigned by "+assignedBy+" ");
				}
				else
				{
					msga.setSubject("New Lead: "+companyName+" added by "+assignedBy+" ");
				}
				msga.setSentDate(new java.util.Date());
				Address recipientAddrs[] = new InternetAddress[1];
				Address recipientAddrsCC[] = new InternetAddress[1];
				recipientAddrs[0] = new InternetAddress(sendEmailTo);
				//recipientAddrs[0] = new InternetAddress("s_dhole@transworld-compressor.com");

				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					recipientAddrsCC[0] = new InternetAddress(session.getAttribute("EmpEmail").toString());
					//recipientAddrsCC[0] = new InternetAddress("s_dhole@transworld-compressor.com");

				}
				msga.addRecipients(Message.RecipientType.TO,recipientAddrs);
				
				if(!(assignedBy.equalsIgnoreCase(repName)))
				{
					msga.addRecipients(Message.RecipientType.CC,recipientAddrsCC);
				}
				
				Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld");
				
				msga.setFrom(fromAddress);
				System.out.println(Data);
				msga.setContent(Data,"text/html; charset=ISO-8859-1");
				Transport t = session1.getTransport("smtps");
				msga.saveChanges(); // don't forget this
				try
				{
					t.connect(host, user, pass2);
					System.out.println("SENT*******");
					t.sendMessage(msga, msga.getAllRecipients());
					System.out.println("Your message has been sent");
				}
				catch(Exception e)
				{
					System.out.print("Exception----->"+e);
				} 
				finally 
				{
					t.close();
				} 
				Transport.send(msga);
		}
		else
			sendEmailTo="  (!!! Email Id not available in System.)";
		}	
   }
   catch(Exception e)
   {
		System.out.println(e);	   
   }
}
}
catch(Exception e)
{
	e.printStackTrace();
}
msg = "!!!ERROR. Record not saved in system to some problem. Please try again";
/*sqlInsert = "update "+session.getAttribute("CompanyMasterID").toString()+"followup SET ()*/

if(flag)
{
	//alert("hi");
 System.out.println("flag is " +flag);


}
//response.sendRedirect("addNewCustomer.jsp?ck=yes");
response.sendRedirect("alertGoTo.jsp?msg=Details saved successfully&goto=home.jsp");
}

}
catch(Exception e)
{
	System.out.println(e);
	//String msg1 = "!!!ERROR. Record not saved in system due to some problem. Please try again";
	//response.sendRedirect("addNewCustomer.jsp?msg="+msg1);
	response.sendRedirect("alertGoTo.jsp?msg=Record not saved in system due to some problem. Please try again.&goto=addNewCustomer.jsp");
}
}catch(Exception e)
{
	e.printStackTrace();
}
%>

