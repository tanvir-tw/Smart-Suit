<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>


<%
	
try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
	
		String companyCode=request.getParameter("companycode");
		String company=request.getParameter("companyname");
		String reasonforcancel=request.getParameter("reason");
		String contactperson=request.getParameter("contactPerson");
		String website=request.getParameter("website");
		String email=request.getParameter("email");
		String BankerDetail=request.getParameter("BankerDetail");
		String BillingCity=request.getParameter("BillingCity");
		String BillingZip=request.getParameter("BillingZip");
		String BillingState=request.getParameter("BillingState");
		String BillingCountry=request.getParameter("BillingCountry");
		String BillingPhone=request.getParameter("BillingPhone");
		String BillingFax=request.getParameter("BillingFax");
		String BillingAddress=request.getParameter("BillingAddress");
		String ShippingAddress=request.getParameter("ShippingAddress");
		String ShippingCity=request.getParameter("ShippingCity");
		String ShippingZip=request.getParameter("ShippingZip");
		String ShippingState=request.getParameter("ShippingState");
		String ShippingCountry=request.getParameter("ShippingCountry");
		String ShippingPhone=request.getParameter("ShippingPhone");
		String ShippingFax=request.getParameter("ShippingFax");
		String CSTOrMST=request.getParameter("CSTOrMST");
		String terms=request.getParameter("terms");
		String mobileNo=request.getParameter("mobileNo");
		String stdcode=request.getParameter("std");
		String phone=request.getParameter("phone");
		String category=request.getParameter("category");
		String interestedProduct=request.getParameter("product");
		String weelyoff=request.getParameter("weelyoff");
		String resiNumber=request.getParameter("resiNumber");
		String twemp=request.getParameter("twemp");
		String enteredon=request.getParameter("enteredon");
		if(enteredon==null)
		{
			enteredon="2000-01-01 00:00:00";
		}
		System.out.println(">>>>>>>>>>>     "+enteredon);
		String coreforms=request.getParameter("coreforms");
		String login=request.getParameter("login");
		String password=request.getParameter("password");
		String isdatavalid=request.getParameter("isdatavalid");
		String custdisc=request.getParameter("custdisc");
		String creditlimit=request.getParameter("creditlimit");
		String paymentterms=request.getParameter("paymentterms");
		String paymentmode=request.getParameter("paymentmode");
		String telephone2=request.getParameter("telephone2");
		String vendorcode=request.getParameter("vendorcode");
		String tallyname=request.getParameter("tallyname");
		String transactionexisted=request.getParameter("transactionexisted");
		
		String sql="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CustomerCode = '"+companyCode+"' limit 1";
		System.out.println(sql);
		ResultSet rs=st.executeQuery(sql);
		
		if(rs.next())
		
		{
			String date=rs.getString("EnteredOn");
			if(date==null)
			{
			date="2000-01-01 00:00:00";	
			}
			
		     /*  String customerHistory="insert into t_customerHistory( CustomerCode,CompanyName,ContactPerson,EMail,WebSite,BillingAddress,"+
				
			   "BillingCity,BillingZip,BillingState,BillingCountry,BillingPhone ,BillingFax ,ShippingAddress ,ShippingCity,"+
			   
			   "ShippingZip ,ShippingState ,ShippingCountry ,ShippingPhone ,ShippingFax ,BankerDetail ,CSTOrMST ,Category,"+
			   
			   "Terms,CorEForms ,LoginName ,CustPassword ,IntrestedProduct,	TWEmpName ,EnteredOn,IsDataValid ,CustDiscountPercent,"+
			   
			   "CustCreditLimit ,CustPaymentTerms ,CustPaymentMode ,STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode ,TallyName,TransactionExisted,reasonForUpdate,UpdateDateTime,UpdatedBy) VALUES"+
			   
			   "('"+rs.getString("CustomerCode")+"','"+rs.getString("CompanyName")+"','"+rs.getString("ContactPerson")+"','"+rs.getString("EMail")+"','"+rs.getString("WebSite")+"','"+rs.getString("BillingAddress")+"',"+
					   
			   "'"+rs.getString("BillingCity")+"','"+rs.getString("BillingZip")+"','"+rs.getString("BillingState")+"','"+rs.getString("BillingCountry")+"','"+rs.getString("BillingPhone")+"','"+rs.getString("BillingFax")+"','"+rs.getString("ShippingAddress")+"' ,'"+rs.getString("ShippingCity")+"',"+ 
			   
			   "'"+rs.getString("ShippingZip")+"','"+rs.getString("ShippingState")+"','"+rs.getString("ShippingCountry")+"','"+rs.getString("ShippingPhone")+"','"+rs.getString("ShippingFax")+"','"+rs.getString("BankerDetail")+"','"+rs.getString("CSTOrMST")+"' ,'"+rs.getString("Category")+"' , "+ 
			   
			   "'"+rs.getString("Terms")+"','"+rs.getString("CorEForms")+"','"+rs.getString("LoginName")+"','"+rs.getString("CustPassword")+"','"+rs.getString("IntrestedProduct")+"','"+rs.getString("TWEmpName")+"','"+date+"' ,'"+rs.getString("IsDataValid")+"','"+rs.getString("CustDiscountPercent")+"',  "+ 
			   
			   "'"+rs.getString("CustCreditLimit")+"','"+rs.getString("CustPaymentTerms")+"','"+rs.getString("CustPaymentMode")+"','"+rs.getString("STDCode")+"','"+rs.getString("MobileNo")+"','"+rs.getString("ResiNo")+"','"+rs.getString("TelephoneNo2")+"' ,'"+rs.getString("VendorCode")+"','"+rs.getString("TallyName")+"','"+rs.getString("TransactionExisted")+"',"+
			   
			   "'"+reasonforcancel+"','"+dateTime+"','"+twemp+"' )";
		
		System.out.println(customerHistory);
		st.executeUpdate(customerHistory);*/
		
			  String customerHistory="insert into "+session.getAttribute("CompanyMasterID").toString()+"customerHistory( CustomerCode,CompanyName,ContactPerson,EMail,WebSite,BillingAddress,"+
				
			   "BillingCity,BillingZip,BillingState,BillingCountry,BillingPhone ,BillingFax ,ShippingAddress ,ShippingCity,"+
			   
			   "ShippingZip ,ShippingState ,ShippingCountry ,ShippingPhone ,ShippingFax ,BankerDetail ,CSTOrMST ,Category,"+
			   
			   "Terms,CorEForms ,LoginName ,CustPassword ,IntrestedProduct,	TWEmpName ,EnteredOn,IsDataValid ,CustDiscountPercent,"+
			   
			   "CustCreditLimit ,CustPaymentTerms ,CustPaymentMode ,STDCode ,MobileNo ,ResiNo ,TelephoneNo2 ,VendorCode ,TallyName,TransactionExisted,reasonForUpdate,UpdateDateTime,UpdatedBy) VALUES"+
			   
			   "(?,?,?,?,?, ?,"+
				  "?,?,?,?,?, ?,?,?,"+
				  "?,?,?,?,?, ?,?,?,"+
				  "?,?,?,?,?, ?,?,?,?,"+
				  "?,?,?,?,?, ?,?,?,?,?,?,?,? )";
		
		System.out.println(customerHistory);
		java.sql.PreparedStatement stmt = con.prepareStatement( customerHistory );
		stmt.setString(1,rs.getString("CustomerCode"));
		stmt.setString(2,rs.getString("CompanyName"));
		stmt.setString(3,rs.getString("ContactPerson"));
		stmt.setString(4,rs.getString("EMail"));
		stmt.setString(5,rs.getString("WebSite"));
		stmt.setString(6,rs.getString("BillingAddress"));
		stmt.setString(7,rs.getString("BillingCity"));
		stmt.setString(8,rs.getString("BillingZip"));
		stmt.setString(9,rs.getString("BillingState"));
		stmt.setString(10,rs.getString("BillingCountry"));
		stmt.setString(11,rs.getString("BillingPhone"));
		stmt.setString(12,rs.getString("BillingFax"));
		stmt.setString(13,rs.getString("ShippingAddress"));
		stmt.setString(14,rs.getString("ShippingCity"));
		stmt.setString(15,rs.getString("ShippingZip")); 
		stmt.setString(16,rs.getString("ShippingState"));
		stmt.setString(17,rs.getString("ShippingCountry"));
		stmt.setString(18,rs.getString("ShippingPhone"));
		stmt.setString(19,rs.getString("ShippingFax"));
		stmt.setString(20,rs.getString("BankerDetail"));
		stmt.setString(21,rs.getString("CSTOrMST"));
		stmt.setString(22,rs.getString("Category"));
		stmt.setString(23,rs.getString("Terms"));
		stmt.setString(24,rs.getString("CorEForms"));
		stmt.setString(25,rs.getString("LoginName"));
		stmt.setString(26,rs.getString("CustPassword"));
		stmt.setString(27,rs.getString("IntrestedProduct"));
		stmt.setString(28,rs.getString("TWEmpName"));
		stmt.setString(29,date);
		stmt.setString(30,rs.getString("IsDataValid"));
		stmt.setString(31,rs.getString("CustDiscountPercent"));
		stmt.setString(32,rs.getString("CustCreditLimit"));
		stmt.setString(33,rs.getString("CustPaymentTerms"));
		stmt.setString(34,rs.getString("CustPaymentMode"));
		stmt.setString(35,rs.getString("STDCode"));
		stmt.setString(36,rs.getString("MobileNo"));
		stmt.setString(37,rs.getString("ResiNo"));
		stmt.setString(38,rs.getString("TelephoneNo2"));
		stmt.setString(39,rs.getString("VendorCode"));
		stmt.setString(40,rs.getString("TallyName"));
		stmt.setString(41,rs.getString("TransactionExisted"));
		stmt.setString(42,reasonforcancel);
		stmt.setString(43,dateTime);
		stmt.setString(44,twemp);
		 	
		
		}
					
		String updateSql="Update "+session.getAttribute("CompanyMasterID").toString()+"customerdet SET CompanyName='"+company+"',ContactPerson='"+contactperson+"',EMail='"+email+"',WebSite='"+website+"',BillingAddress='"+BillingAddress+"',"+
		   
		   "BillingCity='"+BillingCity+"',BillingZip='"+BillingZip+"',BillingState='"+BillingState+"',BillingCountry='"+BillingCountry+"',BillingPhone='"+BillingPhone+"' ,BillingFax='"+BillingFax+"' ,ShippingAddress='"+ShippingAddress+"' ,ShippingCity='"+ShippingCity+"',"+
		   
		   "ShippingZip='"+ShippingZip+"' ,ShippingState='"+ShippingState+"' ,ShippingCountry='"+ShippingCountry+"' ,ShippingPhone='"+ShippingPhone+"' ,ShippingFax='"+ShippingFax+"' ,BankerDetail='"+BankerDetail+"' ,CSTOrMST='"+CSTOrMST+"' ,Category='"+category+"',"+
		   
		   "Terms='"+terms+"',CorEForms='"+coreforms+"' ,LoginName='"+login+"' ,CustPassword='"+password+"' ,IntrestedProduct='"+interestedProduct+"',TWEmpName='"+twemp+"' ,EnteredOn='"+enteredon+"',IsDataValid='"+isdatavalid+"' ,CustDiscountPercent='"+custdisc+"',"+
		   
		   "CustCreditLimit='"+creditlimit+"' ,CustPaymentTerms='"+paymentterms+"' ,CustPaymentMode='"+paymentmode+"' ,STDCode='"+stdcode+"' ,MobileNo='"+mobileNo+"' ,ResiNo='"+resiNumber+"' ,TelephoneNo2='"+telephone2+"' ,VendorCode='"+vendorcode+"' ,TallyName='"+tallyname+"',TransactionExisted='"+transactionexisted+"' where customercode="+companyCode+" limit 1";
		   
		System.out.println(updateSql);
		st1.executeUpdate(updateSql);
		response.sendRedirect("alertGoTo.jsp?msg=Record saved.&goto=home.jsp");
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