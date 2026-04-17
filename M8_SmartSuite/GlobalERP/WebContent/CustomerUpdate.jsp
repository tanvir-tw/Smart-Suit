<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st5=null,st6=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>


<%
	
try{	
	
	String CustomerCode = request.getParameter("companyname");
	System.out.println("___________pankajjjjjjjjjjjjjjjjjjjjjjjj---"+CustomerCode);
	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st5=con.createStatement();
		st6=con.createStatement();
		
		String CorEForms=request.getParameter("CorEForms1");
		String addresscode="",SalesCustomer="";
	
		System.out.println("CorEForms11111------------->"+CorEForms);
		String login1=request.getParameter("login1");
		System.out.println("login1-----------"+login1);
		String address="";
		String city="";
		String state="";
		String country="";
		String repName="";
		String isdatavalidate="";
		String potentialValue="";
		String noofunits="";
		String assignedBy="";
		String leadRef="";
		String zip="";
		String comments="",reassign="";
		
		String companyCode=request.getParameter("companyname");
		
		String company=request.getParameter("companyname1");
		
 		String reasonforcancel=request.getParameter("reason");
 		
		String contactperson=request.getParameter("ContacPerson");
		
		String website=request.getParameter("website");
		
		String email=request.getParameter("email");
		
		String BankerDetail=request.getParameter("BankerDetail");
		
		String BillingCity=request.getParameter("city");
		
		String BillingZip=request.getParameter("Billingzip");
		
		String BillingState=request.getParameter("state");
		
		String BillingCountry=request.getParameter("country1");
		
		String verticals=request.getParameter("verticals");
		String solution=request.getParameter("solution");
		String segment=request.getParameter("segment");
		String subgroup=request.getParameter("subgroup");
		String confidencelevel=request.getParameter("confidencelevel");
		String onetimecharge=request.getParameter("onetimecharge");
		String recurringcharge=request.getParameter("recurringcharge");
		String contractvalue=request.getParameter("contractvalue");
	
		String BillingPhone=request.getParameter("BillingPhone");
	
		String BillingFax=request.getParameter("BillingFax");
	
		String BillingAddress=request.getParameter("BillingAddress");
	
		String ShippingAddress=request.getParameter("ShippingAddress");
	
		String ShippingCity=request.getParameter("city1");
	
		String ShippingZip=request.getParameter("ShippingZip");
	
		String ShippingState=request.getParameter("state1");
	
		String ShippingCountry=request.getParameter("country2");
	
		String ShippingPhone=request.getParameter("ShippingPhone");
	
		String ShippingFax=request.getParameter("ShippingFax");
		
		String CSTOrMST=request.getParameter("CSTOrMST");
	
		String terms=request.getParameter("terms");
		
		String mobileNo=request.getParameter("MobileNo");
	
		String BillingGSTN=request.getParameter("BillingGSTN");
		
		String ShippingGSTN=request.getParameter("ShippingGSTN");
		
// 		out.println("ShippingGSTN"+ShippingGSTN);
// 		out.println("BillingGSTN"+BillingGSTN);
	
		String stdcode=request.getParameter("std");
		
		System.out.println("stdcode----------------"+stdcode);
		String phone=request.getParameter("phone");
		
		System.out.println("phone---"+phone);
		String category=request.getParameter("category");
		System.out.println("category---"+category);
		String interestedProduct=request.getParameter("product");
		System.out.println("interestedproduct---"+interestedProduct);
		String weeklyoff=request.getParameter("weeklyoff");
		System.out.println("weelyoffweelyoffweelyoff---"+weeklyoff);
		String resiNumber=request.getParameter("resiNumber");
		
		System.out.println("resiNumberresiNumber---"+resiNumber);
		String twemp=request.getParameter("assignTo");
		System.out.println("twemp---"+twemp);
 		
		String coreforms=request.getParameter("coreforms");
		String login=request.getParameter("login");
		String password=request.getParameter("password");
		String isdatavalid=request.getParameter("isdatavalid");
	
		String custdisc=request.getParameter("custdisc");
		String creditlimit=request.getParameter("creditlimit");
		String paymentterms=request.getParameter("paymentterms");
		String paymentmode=request.getParameter("paymentmode");
		String telephone2=request.getParameter("phone");
		String reasonforup=request.getParameter("reason");
		

		
		
		
		if(telephone2.contains("null"))
		{
			
			telephone2="0";
		}
		
		System.out.println("TELEPHONE1"+telephone2);
		String vendorcode=request.getParameter("vendorcode");
		System.out.println("vendorcode**************"+vendorcode);
		
		if(vendorcode.equals("null") || vendorcode=="" )
		{
			vendorcode="0";
			System.out.println("vendorcode**************in if"+vendorcode);
		}

			String tallyname=request.getParameter("tallyname");
		System.out.println("tallyname-----------------------   "+tallyname);
		String transactionexisted=request.getParameter("transactionexisted");
		System.out.println("transactionexisted-----------------------   "+transactionexisted);
		
		
		System.out.println("TELEPHONE2"+telephone2);
		

		
		
		
	
		
			
	
		
		String updateSql="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"customerdet SET solution='"+solution+"',verticals='"+verticals+"',segment='"+segment+"',subgroup='"+subgroup+"',confidencelevel='"+confidencelevel+"',onetimecharge='"+onetimecharge+"',recurringcharge='"+recurringcharge+"',contractvalue='"+contractvalue+"',CompanyName='"+company+"',ContactPerson='"+contactperson+"',EMail='"+email+"',WebSite='"+website+"',BillingAddress='"+BillingAddress+"',"+
		   
		   "BillingCity='"+BillingCity+"',BillingZip='"+BillingZip+"',BillingState='"+BillingState+"',BillingCountry='"+BillingCountry+"',BillingPhone='"+BillingPhone+"' ,BillingFax='"+BillingFax+"' ,ShippingAddress='"+ShippingAddress+"' ,ShippingCity='"+ShippingCity+"',"+
		   
		   "ShippingZip='"+ShippingZip+"' ,ShippingState='"+ShippingState+"' ,ShippingCountry='"+ShippingCountry+"' ,ShippingPhone='"+ShippingPhone+"' ,ShippingFax='"+ShippingFax+"' ,BankerDetail='"+BankerDetail+"' ,CSTOrMST='"+CSTOrMST+"' ,Category='"+category+"',"+
		   
		   "Terms='"+terms+"',CorEForms='"+coreforms+"' ,LoginName='"+login+"' ,CustPassword='"+password+"' ,IntrestedProduct='"+interestedProduct+"',TWEmpName='"+twemp+"' ,IsDataValid='"+isdatavalid+"' ,CustDiscountPercent='"+custdisc+"',"+
		   
		   "CustCreditLimit='"+creditlimit+"' ,CustPaymentTerms='"+paymentterms+"' ,CustPaymentMode='"+paymentmode+"' ,STDCode='"+stdcode+"' ,MobileNo='"+mobileNo+"' ,ResiNo='"+resiNumber+"' ,TelephoneNo2='"+telephone2+"' ,weeklyoff='"+weeklyoff+"',VendorCode='"+vendorcode+"',ReasonForUpdate='"+reasonforup+"',BillingGSTN='"+BillingGSTN+"',ShippingGSTN='"+ShippingGSTN+"' where customercode='"+companyCode+"' limit 1";
		   
		st1.executeUpdate(updateSql);
		
		out.println("updateSql:---"+updateSql);
		
		
		
		
		
		
		
		
		
		
	
		String sqlSetails=" SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"custaddrdet where CustomerCode = '"+companyCode+"'";
		
		ResultSet rs=st3.executeQuery(sqlSetails);
		System.out.println("sqlSetailssqlSetailssqlSetailssqlSetailssqlSetails:---"+sqlSetails);
		if(rs.next())
		{
			addresscode=rs.getString("AddressCode");
			System.out.println("Addresscode:---"+addresscode);
			
		}
		
	
		
		
		
		String updateSql1="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"custaddrdet SET ContactPerson='"+contactperson+"',AddressCode='"+addresscode+"',"+

				"BillingAddress='"+BillingAddress+"',BillingCity='"+BillingCity+"',BillingZip='"+BillingZip+"',BillingState='"+BillingState+"',"+
                "BillingCountry='"+BillingCountry+"',BillingPhone='"+BillingPhone+"',BillingFax='"+BillingFax+"',ShippingAddress='"+ShippingAddress+"',"+
				"ShippingCity='"+ShippingCity+"',ShippingZip='"+ShippingZip+"',ShippingState='"+ShippingState+"',ShippingCountry='"+ShippingCountry+"',"+
				"ShippingPhone='"+ShippingPhone+"',"+
								"ShippingFax='"+ShippingFax+"',STDCode='"+stdcode+"',MobileNo='"+mobileNo+"',ResiNo='"+resiNumber+"',"+
				"TelephoneNo2='"+telephone2+"',VendorCode='"+vendorcode+"' where CustomerCode='"+companyCode+"' limit 1";
		
		st2.executeUpdate(updateSql1);
		System.out.println("updateSql55555555555555555:---"+updateSql1);
		
		
		
		
		
String sqlSetails1=" SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where SalesCustomerCode = '"+companyCode+"'";
		
		ResultSet rs4=st5.executeQuery(sqlSetails1);
		System.out.println(":-tttttt--"+sqlSetails1);
		if(rs4.next())
		{
			//SalesCustomer=rs4.getString("SalesCustomerCode");
			System.out.println(":-SalesCustomer------>SalesCustomer--"+SalesCustomer);
			address=rs4.getString("Address");
			city=rs4.getString("City");
			zip=rs4.getString("Zip");
			state=rs4.getString("State");
			country=rs4.getString("Country");
			city=rs4.getString("City");
			repName=rs4.getString("CustEnteredByRep");
			
			isdatavalidate=rs4.getString("IsDataValid");
			potentialValue=rs4.getString("PotentialValue");
			noofunits=rs4.getString("NoOfUnits");
			assignedBy=rs4.getString("Assighnedby");
			leadRef=rs4.getString("leadRef");
			comments=rs4.getString("Comments");
			reassign=rs4.getString("Reassignto");
			
			
			System.out.println("salessssssscode:---"+SalesCustomer);
			
		}
		
		String updateSql2="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster SET solution='"+solution+"',verticals='"+verticals+"',segment='"+segment+"',subgroup='"+subgroup+"',confidencelevel='"+confidencelevel+"',onetimecharge='"+onetimecharge+"',recurringcharge='"+recurringcharge+"',contractvalue='"+contractvalue+"',CompanyName='"+company+"',Address='"+BillingAddress+"',City='"+BillingCity+"',Zip='"+BillingZip+"',State='"+BillingState+"',Country='"+BillingCountry+"',ContactPerson='"+contactperson+"',Phone='"+BillingPhone+"',Fax='"+BillingFax+"',EMail='"+email+"',WebSite='"+website+"',IntrestedProduct='"+interestedProduct+"',WeeklyOffon='"+weeklyoff+"',"+
				"IsDataValid='"+isdatavalidate+"',Category='"+category+"',STDCode='"+stdcode+"',MobileNo='"+mobileNo+"',ResiNo='"+resiNumber+"',TelephoneNo2='"+telephone2+"',"+
					"PotentialValue='"+potentialValue+"',NoOfUnits='"+noofunits+"',ReasonForUpdate='"+reasonforup+"',Reassignto='"+reassign+"'  where SalesCustomerCode='"+companyCode+"' limit 1 ";

					st6.executeUpdate(updateSql2);
							System.out.println("prospect updateeeeeeeeeeeeeeeeee:---"+updateSql2);
		


		
		
		
		
//		String updateSql2="Update db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster SET 
		
		
		
		
		

		
		//IsDataValid
		//String sqlcon ="INSERT into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospecthistory (CustomerCode,CompanyName,Address,City,Zip,State,Country,ContactPerson,Phone,Fax,EMail,WebSite,IntrestedProduct,CustEnteredByRep,WeeklyOffon,AddedOnDate,ProspCustAddedOn,SalesCustomerCode   ,Category,STDCode,MobileNo,ResiNo,TelephoneNo2,Comments,PotentialValue,NoOfUnits,VendorCode,Assighnedby,leadRef,reasonForUpdate,UpdateDateTime,UpdatedBy,BranchName,GroupOfCompany,TypeOfBuisness,DealInProduct,PayTerms,RiskInvolved,ColloectionStaffName)  VALUES('"+companyCode+"','"+company+"','"+BillingAddress+"','"+BillingCity+"','"+BillingZip+"','"+BillingZip+"','"+BillingState+"','"+BillingCountry+"','"+contactperson+"','"+BillingPhone+"','"+BillingFax+"','"+email+"','"+website+"','"+interestedProduct+"','"+SalesCustomer+"','"+weeklyoff+"','"+isdatavalid+"','"+category+"','"+stdcode+"' ,'"+mobileNo+"','"+resiNumber+"','"+telephone2+"','"+vendorcode+"')";
		
	//	System.out.println("Insert query is "+sqlcon);
		
		//	String sqlcon ="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospecthistory(CustomerCode,CompanyName,Address,City,Zip,State,Country,ContactPerson,Phone,Fax,EMail,WebSite,IntrestedProduct,SalesCustomerCode,WeeklyOffon,Category,STDCode,MobileNo,ResiNo,TelephoneNo2, VendorCode) VALUES('"+companyCode+"','"+company+"','"+BillingAddress+"','"+BillingCity+"','"+BillingZip+"','"+BillingState+"','"+BillingCountry+"','"+contactperson+"','"+BillingPhone+"','"+BillingFax+"','"+email+"','"+website+"','"+interestedProduct+"','"+SalesCustomer+"','"+weeklyoff+"','"+category+"','"+stdcode+"' ,'"+mobileNo+"','"+resiNumber+"','"+telephone2+"','"+vendorcode+"')";
		
	//	System.out.println("Insert query is "+sqlcon);
		
		//String sqlSetails=" SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"custaddrdet where CustomerCode = '"+companyCode+"'";
	
	
		
		response.sendRedirect("alertGoTo.jsp?msg=Customer Edited with comments : "+reasonforcancel+" and saved.&goto=home.jsp");
}
catch(Exception e)
{
	System.out.println( "Exception ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
}
finally
{
	con.close();
}
%>			