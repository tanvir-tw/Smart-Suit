<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	int i=0;
%>

<%
	try
	{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
	System.out.println(">>>>>>>>>>>In revise Purchase Quatation");	
	
	
	int count=Integer.parseInt(request.getParameter("count").toString());
	System.out.println(">>>    "+count);	
	
	String PurQuoNumber=request.getParameter("PurQuoNumber");
	String contactperson=request.getParameter("contactperson");
	String pqdate=request.getParameter("pqdate");
	
	String twref=request.getParameter("twref");
	String terms=request.getParameter("terms");
	String total=request.getParameter("total");
	System.out.println(">>>>>>>>>>>>>Total:"+total);
	String amountinwords=request.getParameter("rupees");
	String prompt=request.getParameter("prompt");
	String supliercode=request.getParameter("supliercode");
	String purquosupref=request.getParameter("purquosupref");
	String pf=request.getParameter("pf");
	String Address=request.getParameter("address");
	String City=request.getParameter("city");
	String Zip=request.getParameter("zip");
	String State=request.getParameter("state");
	String Country=request.getParameter("country");
	String phone=request.getParameter("phone");
	String fax=request.getParameter("fax");
	String grandtotal=request.getParameter("total");
	System.out.println(">>>>>>>>>>>>>grandTotal:"+grandtotal);
	String fobcfr=request.getParameter("fobcfr");
	String discount=request.getParameter("dis");
	System.out.println(">>>>>>>>>>>>>discount:"+discount);
	String delvp=request.getParameter("delvp");
	String other=request.getParameter("other");
	String insurance=request.getParameter("insurance");
	String othertaxp=request.getParameter("othertaxp");
	String othertaxt=request.getParameter("othertaxt");
	String freight=request.getParameter("freight");
	String freightT=request.getParameter("freightT");
	String excise=request.getParameter("excise");
	String pog=request.getParameter("pog");
	String quor=request.getParameter("quor");
	String curtype=request.getParameter("curtype");
	String curvalue=request.getParameter("curvalue");
	String termsofpay=request.getParameter("termsconditions");
	String TaxRate=request.getParameter("taxrate");
	String groupname=request.getParameter("groupname");
	System.out.println(">>>>>>>groupname:"+groupname);
	
	int pqno=0;
		String sqlOrderno="SELECT MAX(PurQuoNo) from "+session.getAttribute("CompanyMasterID").toString()+"purchasequo ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
		    pqno=rs.getInt(1);
		pqno++;
	
	String sqlData="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchasequo(PurQuoNo, TWRefNo, SupplierCode, PurQuoSupRefNo, PurQuoDate, Prompt, TaxRate, PF, FOB_CIF_CFR, DeliveryPeriod, NegotiatedDiscount, TermsOfPayment, OtherTerms, InsurancePercent, OtherTaxPercent, OtherTaxType, Freight, FreightType, Excise, POGenerated, QuoReceived, GrandTotal, CurrType, CurrValue)Values('"+pqno+"','"+twref+"','"+supliercode+"','"+purquosupref+"','"+pqdate+"','"+prompt+"','"+TaxRate+"','"+pf+"','"+fobcfr+"','"+delvp+"','"+discount+"','"+termsofpay+"','"+other+"','"+insurance+"','"+othertaxp+"','"+othertaxt+"','"+freight+"','"+freightT+"','"+excise+"','"+pog+"','"+quor+"','"+total+"','"+curtype+"','"+curvalue+"')";
	
	System.out.println(sqlData);	
	st2.executeUpdate(sqlData);
	
	for(i=0;i<count;i++)
	{
	String gcode=request.getParameter("groupcode"+i);	
	String mcode=request.getParameter("makecode"+i);
	String icode=request.getParameter("itemcode"+i);
	String quan=request.getParameter("quant"+i);
	System.out.println("GCODE GCODE   "+quan);
	String discount1=request.getParameter("discount"+i);
	System.out.println(discount1);
	String sellingprice=request.getParameter("selling"+i);
	String stpercent=request.getParameter("stpercent"+i);
	System.out.println(">>>>>>>>>>>>  PRICE  "+sellingprice);
	String landed=request.getParameter("landed"+i);
	System.out.println(">>>>>>>>>>>>  landed  "+landed);
	Double lan=Double.parseDouble(landed);
	System.out.println(">>>>>>>>>>>>  lan  "+lan);
	String extra=request.getParameter("extra"+i);
	//String desc=request.getParameter("description"+i);
	
	int no=Integer.parseInt(gcode);
	System.out.println("&*&&&**&*&*&*&*&*     "+no);
	String tableToBeAccessed="";
	if(no< 5)
	{
		tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupname.substring(0,5).toLowerCase()+"im_make"+mcode+"";
	}
	else 
		tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
	System.out.println("TABLE TO BE ACCCCC       "+tableToBeAccessed);
	
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"pquo_items(PQNo,TheGroup,Make,ItemCode,Quantity,UnitPrice,DiscountPercent,TheTableToBeAccessed,STPercent,LandedPrice,ExtraTaxesApplicable)values('"+pqno+"','"+gcode+"','"+mcode+"','"+icode+"','"+quan+"','"+sellingprice+"','"+discount1+"','"+tableToBeAccessed+"','"+stpercent+"','"+lan+"','"+extra+"')";
	
	System.out.println(sqlInsert);
	st3.executeUpdate(sqlInsert);
	
	
	}
	
	
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Quotation  Revised successfully &goto=home.jsp");
		
	}
	catch(Exception e)
	{
		System.out.println( "Exception ::"+e );
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again. \n\n \n\n   "+e.toString().replace("'"," --")+"&goto=javascript:history.back()");
	}
	finally
	{
		con.close();
	}
%>	