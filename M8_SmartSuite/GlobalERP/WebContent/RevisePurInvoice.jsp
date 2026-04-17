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
	System.out.println(">>>>>>>>>>>In revise Purchase Invoice<<<<<<<<<<<<<<<");	
	
	
	int count=Integer.parseInt(request.getParameter("count").toString());
	System.out.println(">>>    "+count);	
	
	String PurInvNumber=request.getParameter("PurInvNumber");
	String contactperson=request.getParameter("contactperson");
	String pidate=request.getParameter("pidate");
	
	String supinvref=request.getParameter("supinvref");
	String terms=request.getParameter("terms");
	String total=request.getParameter("total");
	System.out.println(">>>>>>>>>>>>>Total:"+total);
	String amountinwords=request.getParameter("rupees");
	String tax=request.getParameter("tax");
	String supliercode=request.getParameter("supliercode");
	String cstmst=request.getParameter("cstmst");
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
	String discount=request.getParameter("discount");
	System.out.println(">>>>>>>>>>>>>discount:"+discount);
	String reason=request.getParameter("reason");
	String payDuedate=request.getParameter("payDuedate");
	String excise=request.getParameter("excise");
	String pitime=request.getParameter("pitime");
	String freight=request.getParameter("freight");
	String po=request.getParameter("po");
	
	int pino=0;
		String sqlOrderno="SELECT MAX(PurInvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
		    pino=rs.getInt(1);
		pino++;
	
	String sqlData="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice(PurInvoiceNo,	PONo,   PurInvoiceDate, PurInvoiceTime, SupplierCode, SupInvoiceRef, Total, DiscountPercent, TaxPercent,CSTorMST,PFIPercent,FreightAmount,GrandTotal,TotalinWords,Terms,Reason,PaymentDueDate,ExciseTax)Values('"+pino+"',  '"+po+"','"+pidate+"',  '"+pitime+"',  '"+supliercode+"','"+supinvref+"','"+total+"','"+discount+"','"+tax+"','"+cstmst+"','"+pf+"','"+freight+"','"+grandtotal+"','"+amountinwords+"','"+terms+"','"+reason+"','"+payDuedate+"','"+excise+"')";
	String groupname=request.getParameter("groupname");
	System.out.println(sqlData);	
	st2.executeUpdate(sqlData);
	
	for(i=0;i<count;i++)
	{
	String gcode=request.getParameter("groupcode"+i);	
	String mcode=request.getParameter("makecode"+i);
	String icode=request.getParameter("itemcode"+i);
	String quan=request.getParameter("quant"+i);
	System.out.println("Quanity:"+quan);
	String sellingprice=request.getParameter("selling"+i);
	System.out.println(">>>>>>>>>>>>  PRICE  "+sellingprice);
	String landed=request.getParameter("landed"+i);
	System.out.println(">>>>>>>>>>>>  landed  "+landed);
	//;
	
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
	
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items(PurInvoiceNo,TheGroup,Make,ItemCode,Quantity,UnitPrice,TheTableToBeAccessed)values('"+ pino+"','"+gcode+"','"+mcode+"','"+icode+"','"+quan+"','"+sellingprice+"','"+tableToBeAccessed+"')";
	
	System.out.println(sqlInsert);
	st3.executeUpdate(sqlInsert);
	
	
	}
	
	
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Invoice  Revised successfully &goto=home.jsp");
		
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