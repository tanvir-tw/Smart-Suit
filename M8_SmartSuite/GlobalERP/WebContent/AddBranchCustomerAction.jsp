<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>


<%
	
try{	
	
	String CustomerCode = request.getParameter("companyname");
	System.out.println("___________pankajjjjjjjjjjjjjjjjjjjjjjjj---"+CustomerCode);
	String cust= request.getParameter("companyname1");
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();
		st6=con.createStatement();
		st7=con.createStatement();
		st8=con.createStatement();
		
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
		String BranchName=request.getParameter("branchname");
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
		
		
		
		
		
		String datavalid="1";
		
		String dt1=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
		
		String addedon = new SimpleDateFormat("yyyy-MM-dd HH:mm")
		.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm")
				.parse(dt1));
	
		String validbranch="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+cust+"' and BranchName='"+BranchName+"'";
		ResultSet rsvalidbranch=st7.executeQuery(validbranch);
		if(!rsvalidbranch.next())
		{
		
		int custocode;
		int BranchCode;
		String custocode1="";
		String sqlCode="SELECT Max(CustomerCode) as BranchCode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet ";
		ResultSet rs=st.executeQuery(sqlCode);
		rs.next();  
		
		BranchCode=rs.getInt("BranchCode");
		BranchCode++;
		
		custocode1=""+BranchCode;
		
		System.out.println("AUTOGENERATED CUSTOMER CODE is :   "+custocode1);
		
		
		String BrCode="";
		int BranchCode1=0;
		String sqlBranchCode="SELECT Max(BranchCode) as BranchCode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet ";
		ResultSet rbranchs=st8.executeQuery(sqlBranchCode);
		
		System.out.println("Br Query :-"+sqlBranchCode);
		rbranchs.next();  
		
		BranchCode1=rbranchs.getInt("BranchCode");
		BranchCode1++;
		
		BrCode=""+BranchCode1;
		
		System.out.println("AUTOGENERATED Branc CODE is :   "+BrCode);
		
		
		
		String sqlTransfer="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerdet ( CustomerCode, CompanyName,BranchName,BranchCode, ContactPerson,EMail ," 	+
				"WebSite,BillingAddress,BillingCity ,BillingZip ,BillingState ,BillingCountry, "+	
				"BillingPhone ,BillingFax ,ShippingAddress ,ShippingCity ,ShippingZip ,ShippingState, "+
				"ShippingCountry ,ShippingPhone ,ShippingFax ,BankerDetail ,CSTOrMST ,Category, "+	
				"Terms ,CorEForms ,LoginName ,CustPassword ,IntrestedProduct ,TWEmpName ,EnteredOn, "+	
				"IsDataValid ,CustDiscountPercent ,CustCreditLimit ,CustPaymentTerms ,CustPaymentMode,"+ 	
				"STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode ,TallyName ,TransactionExisted,ReasonForUpdate,weeklyoff)"+
				
				"VALUES('"+custocode1+"','"+cust+"' ,'"+BranchName+"','"+BrCode+"','"+contactperson+"' ,'"+email+"', "+
				"'"+website+"' ,'"+BillingAddress+"' ,'"+BillingCity+"' ,'"+BillingZip+"' ,'"+BillingState+"' ,'"+BillingCountry+"', "+
				"'"+BillingPhone+"','"+BillingFax+"' ,'"+ShippingAddress+"' ,'"+ShippingCity+"','"+ShippingZip+"','"+ShippingState+"',"+ 
				"'"+ShippingCountry+"' ,'"+ShippingPhone+"','"+ShippingFax+"' ,'-' ,'-','"+category+"',"+ 	
				"'-','-' ,'-' ,'-' ,'"+interestedProduct+"' ,'"+twemp+"' ,'"+addedon+"',"+ 	
				"'"+datavalid+"' ,'-' ,'0','"+paymentterms+"' ,'"+paymentmode+"','"+stdcode+"','"+mobileNo+"','"+resiNumber+"','"+telephone2+"','"+vendorcode+"','-','-','"+reasonforup+"','"+weeklyoff+"' )";
	
		
		System.out.println(" Customer Det :- "+sqlTransfer);
		
		st.executeUpdate(sqlTransfer);
		
		System.out.println(" Customer Det After :- "+sqlTransfer);
		
		int addresscode1=0;
		String sql="SELECT MAX(AddressCode) FROM "+session.getAttribute("CompanyMasterID").toString()+"custaddrdet";
		System.out.println(sql);
		ResultSet rsAdd=st3.executeQuery(sql);
		rsAdd.next();
		addresscode1=rsAdd.getInt(1);
		System.out.println(addresscode1);
		addresscode1++;
		System.out.println("AUTOGENERATED ADDRESS CODE is :" +addresscode1);
		

		
		
		String sqlAdd="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"custaddrdet (CustomerCode ,AddressCode,IntrestedProduct , ContactPerson , BillingAddress, "+
				"BillingCity ,BillingZip ,BillingState ,BillingCountry ,BillingPhone ,BillingFax ,ShippingAddress ,ShippingCity,"+ 
				"ShippingZip ,ShippingState ,ShippingCountry ,ShippingPhone ,ShippingFax ,EMail ,STDCode ,MobileNo,"+ 	
				"ResiNo ,TelephoneNo2 ,VendorCode)"+
				
				"VALUES( '"+custocode1+"' ,'"+addresscode1+"' ,'"+interestedProduct+"' ,'"+contactperson+"','"+BillingAddress+"' ,"+
				"'"+BillingCity+"' ,'"+BillingZip+"' ,'"+BillingState+"' ,'"+BillingCountry+"','"+BillingPhone+"','"+BillingFax+"','"+ShippingAddress+"','"+ShippingCity+"',"+
				"'"+ShippingZip+"','"+ShippingState+"' ,'"+ShippingCountry+"' ,'"+ShippingPhone+"' ,'"+ShippingFax+"' ,'"+email+"' ,'"+stdcode+"','"+mobileNo+"',"+
				"'"+resiNumber+"','"+telephone2+"','"+vendorcode+"' ) ";
	
		
			
	System.out.println(" Cust Addr Det :- "+sqlAdd);
		
		   
		st1.executeUpdate(sqlAdd);
		
		System.out.println(" Cust Addr Det After :- "+sqlAdd);
		
		//out.println("updateSql:---"+updateSql);
		
		
		int prospcustocode1=0;
		String prospcustocode="SELECT Max(CustomerCode) as CustomerCode from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster ";
		ResultSet rs12=st4.executeQuery(prospcustocode);
		rs12.next();  
		
		prospcustocode1=rs12.getInt("CustomerCode");
		prospcustocode1++;
		
		//custocode1=CustomerCode+"B"+BranchCode;
		
		System.out.println("AUTOGENERATED PROSP CUSTOMER CODE is :   "+prospcustocode1);
		
		
		String contactentry="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"contactdet (customercode,companyname,BranchName,BranchCode,contactperson,designation,Address,country,state,city,zipcode,email,phone,mobileno,fax,Email1 ,Email2 ,mobileno1,mobileno2,EntryBy) values ('"+prospcustocode1+"','"+cust+"','"+BranchName+"','"+BranchCode+"','"+contactperson+"','-','"+BillingAddress+"','"+BillingCountry+"','"+BillingState+"','"+BillingCity+"','"+BillingZip+"','"+email+"','"+BillingPhone+"','"+mobileNo+"','"+BillingFax+"','-','-','"+telephone2+"','"+telephone2+"','"+twemp+"')";
		st5.executeUpdate(contactentry);
		
		System.out.println(" ContactDet  Entry  :- "+contactentry);
		
		
		
		
		String prospinsert="INSERT INTO db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster(CustomerCode,SalesCustomerCode,CompanyName, Address, City, Zip, State,ContactPerson, MobileNo, MobileNo1, MobileNo2, Fax, EMail, WebSite ,CustEnteredByRep ,	WeeklyOffon ,AddedOnDate,Category, TelephoneNo2, Phone, STDCode, ProspCustAddedOn, Country,BranchName,PayTerms,BranchCode) VALUES ('"+prospcustocode1+"','"+custocode1+"','"+cust+"','"+BillingAddress+"','"+BillingCity+"','"+BillingZip+"','"+BillingState+"','"+contactperson+"','"+mobileNo+"','"+telephone2+"','"+telephone2+"','"+BillingFax+"','"+email+"','"+website+"','"+twemp+"','"+weeklyoff+"','"+addedon+"','"+category+"','"+telephone2+"','"+mobileNo+"','"+stdcode+"','"+addedon+"','"+BillingCountry+"','"+BranchName+"','"+paymentterms+"','"+BranchCode+"')";
		
		System.out.println(" Prosp Cust Entry  :- "+prospinsert);
		
		st6.executeUpdate(prospinsert);
		
		
		System.out.println(" Prosp Cust Entry  :- "+prospinsert);
	
		
		
	
		
		
		
				
		//st2.executeUpdate(updateSql1);
		
		
		
		
		
		

	
		
	 response.sendRedirect("alertGoTo.jsp?msg= Branch Added Successfull and saved.&goto=home.jsp");
}
		else
		{
			response.sendRedirect("alertGoTo.jsp?msg= Same Branch Is Available !!!.&goto=home.jsp");
		}
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