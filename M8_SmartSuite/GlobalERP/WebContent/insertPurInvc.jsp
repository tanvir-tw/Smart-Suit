<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String tdydate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH, +4);
	Date fourdayslaterAsDate = cal.getTime();
	String fourdayslaterDate=new SimpleDateFormat("yyyy-MM-dd").format(fourdayslaterAsDate);
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$           %%%%%%%%%%%%   "+fourdayslaterDate);
%>

<%
	
try{	
	
	System.out.println("chk     ."+request.getParameter("checkedNumber").toString()+".");
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	
	String sellingprice1="" ,priceAccepted="",custrefno="",twsalesorderno="";				
	String QuoExpirydate="",paymentterms="",group="",quantity1=""; 
	String discount1="",tax1="",amount="",total="",salesquono="";
	String amountInWords="",supcode="";
	String enqtime="",salesquodate1="";
	int i=0,j=0;
	
	String pordno=request.getParameter("porderno");
	String acode=request.getParameter("addresscode");
	String company1=request.getParameter("company");
	supcode=request.getParameter("suppliercode");
	String terms=request.getParameter("termsconditions");
	String pfi=request.getParameter("pfi");	
	String frieght=request.getParameter("frieght");
	String cst=request.getParameter("cst");
 	total=request.getParameter("total");
 	String grandtotal=request.getParameter("grandTotal");
 	salesquodate1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 	String remarks=request.getParameter("remarks");
	amountInWords=request.getParameter("rupees");
	String paymentduedate=request.getParameter("fromdate");
	int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
	//group=request.getParameter("group");
	String supinvcref=request.getParameter("supinvoiceref");	
	
	int pinvoiceno;
	String sqlinvoiceno="SELECT MAX(PurInvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice";
	ResultSet rs=st1.executeQuery(sqlinvoiceno);
	rs.next();
	pinvoiceno=rs.getInt(1);
	pinvoiceno++;
	System.out.println(pinvoiceno);
	
	String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice (PurInvoiceNo ,PONo ,PurInvoiceDate ,PurInvoiceTime ,SupplierCode ,SupInvoiceRef ,Total ,"+
					 "DiscountPercent ,TaxPercent ,CSTorMST ,PFIPercent ,FreightAmount ,GrandTotal ,TotalinWords ,Terms ,Reason ,PaymentDueDate ,ExciseTax)"+
			
					 "VALUES ('"+pinvoiceno+"','"+pordno+"','"+todaysDate+"','"+todaysTime+"','"+supcode+"','"+supinvcref+"','"+total+"',"+
					 "'0.00','0.00','"+cst+"','"+pfi+"','"+frieght+"','"+grandtotal+"','"+amountInWords+"','"+terms+"','-','"+paymentduedate+"','0')";			
	
	System.out.println(sqlInsert);	
	st2.executeUpdate(sqlInsert);
	
	for(i=0;i<number;i++)
	{
	 		
		String description1=request.getParameter("description"+i);
		discount1=request.getParameter("discount"+i);
		tax1=request.getParameter("tax"+i);
		quantity1=request.getParameter("quantity"+i);
		sellingprice1=request.getParameter("sellingPrice"+i);
		String make=request.getParameter("make"+i);
		String itemcode=request.getParameter("icode"+i);
		String gcode=request.getParameter("gcode"+i);
		String mcode=request.getParameter("mcode"+i);
		group=request.getParameter("groupname");
		System.out.println(group+"GRUOP IS  ");
		
		System.out.println(request.getParameter("gcode"+i)+" ************");
		
		int no=Integer.parseInt(request.getParameter("gcode"+i));
		String tableToBeAccessed="";
		if(no< 5)
		{System.out.println("IN IF    ");
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
		}else {
			System.out.println("IN ELSE  ");
			tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
		}
		String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items (PurInvoiceNo ,TheGroup ,Make ,ItemCode ,Quantity ,UnitPrice ,TheTableToBeAccessed)"+
				   
				   "VALUES ('"+pinvoiceno+"','"+gcode+"','"+mcode+"','"+itemcode+"','"+quantity1+"','"+sellingprice1+"','"+tableToBeAccessed+"')";
		System.out.println(sql);
		st3.executeUpdate(sql);
		
		
	}
	
	
	String balance="";
	String sqlBal="Select Balance from "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails where SupplierCode='"+supcode+"' Order By Balance Desc limit 1";
	ResultSet rsBal=st3.executeQuery(sqlBal);
	if(rsBal.next())
	{	
	balance=rsBal.getString(1);
	}
	else 
	{
		 balance="0";
	}	
	String sqlSupPyament="Insert Into "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails (SupplierCode ,InvoiceNo ,InvoiceValue ,InvoiceDate ,PaymentDetails ,AmountPaid ,Balance ,CurrType ,PaymentDate ,PaymentDoneTillNow ,TWEmpName)"+
						 " VALUES ('"+supcode+"','"+pinvoiceno+"','"+grandtotal+"','"+tdydate+"','-','0.00','"+balance+"','Domestic Inv in Rupees','-','0.00','"+session.getAttribute("EmpName")+"')";
	System.out.println(">>>>>>>>>    "+sqlSupPyament);
	st.executeUpdate(sqlSupPyament);
	
	
	
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Invoice with PurInvNo :"+pinvoiceno+" is Added Successfully In System.&goto=home.jsp");
	}
	catch(Exception e)
	{
	System.out.println( "Exception in INSERT QUOTATION ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	}
	finally
	{
	con.close();
	}
%>