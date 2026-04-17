<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
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
	
	String acode=request.getParameter("addresscode");
	String company1=request.getParameter("company");
	supcode=request.getParameter("suppliercode");
	String contactperson=request.getParameter("contactperson");
	String address=request.getParameter("address");
	String city=request.getParameter("city");
	String state=request.getParameter("state");
	String country=request.getParameter("country");
	String phone=request.getParameter("phone");
	String fax=request.getParameter("fax"); 
	String zip=request.getParameter("zip");
	String terms=request.getParameter("termsconditions");
	String pfi=request.getParameter("pfi");	
	String frieght=request.getParameter("frieght");
 	total=request.getParameter("total");
 	String grandtotal=request.getParameter("grandTotal");
 	salesquodate1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 	String remarks=request.getParameter("remarks");
	amountInWords=request.getParameter("rupees");
	String purchasedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("purquodate")));
	int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
//	group=request.getParameter("group");
//	System.out.println("GROUP IS  "+group);
	
	String twempname=request.getParameter("twempname");
	String penqnumber=request.getParameter("purchaseenqno");
	System.out.println("The purchase enq no is :"+penqnumber);
	
	String twrefnoenq=request.getParameter("twrefno");
	System.out.println("The twrefnoenq+++++++++++++++ :"+twrefnoenq);
	
	int pquono;
	String sqlquono="SELECT MAX(PurQuoNo) from "+session.getAttribute("CompanyMasterID").toString()+"purchasequo ";
	ResultSet rs=st1.executeQuery(sqlquono);
	rs.next();
	pquono=rs.getInt(1);
	pquono++;
	System.out.println(pquono);
	
	String twrefno="TW/EXPSE:0/PUR:";
	twrefno+=penqnumber;
	System.out.println("NO IS    *****  "+twrefno);	
	
//  ++++++++++++++++++++++++++++++++++++++++++++++   TW REF NO NOT ADDED YET   ********************************************************************
	
	String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchasequo (PurQuoNo ,TWRefNo ,SupplierCode ,PurQuoSupRefNo ,PurQuoDate ,Prompt ,TaxRate, "+
					 "PF ,FOB_CIF_CFR ,DeliveryPeriod ,NegotiatedDiscount ,TermsOfPayment ,OtherTerms ,InsurancePercent ,OtherTaxPercent ,"+
					 "OtherTaxType ,Freight ,FreightType ,Excise ,POGenerated ,QuoReceived ,GrandTotal ,CurrType ,CurrValue)"+
			
					 "VALUES ('"+pquono+"','"+twrefno+"','"+supcode+"','-','"+purchasedate+"','0','0.00',"+
					 "'"+pfi+"','-','-','0.00','"+paymentterms+"','"+terms+"','0.00','0.00',"+
					 "'-','"+frieght+"','-','0','0','0','"+grandtotal+"','Rupees','1' )";			
	System.out.println(sqlInsert);	
	st2.executeUpdate(sqlInsert);
	System.out.println(" %%%%%%%%%%%%%%%%%%%%%%%   %%%%%%%%%%%%%%%%%%% 555");
	
	for(i=0;i<number;i++)
	{
		String description1=request.getParameter("description"+i);
		discount1=request.getParameter("discount"+i);
		tax1=request.getParameter("tax"+i);
		quantity1=request.getParameter("quantity"+i);
		sellingprice1=request.getParameter("sellingPrice"+i);
		String make=request.getParameter("make"+i);
		String itemcode=request.getParameter("icode"+i);
		int no=Integer.parseInt(request.getParameter("gcode"+i));
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   kkkkkk"+no);
		String mcode=request.getParameter("mcode"+i);
		group=request.getParameter("groupname");
		System.out.println(no+" ************");
		
		//no=Integer.parseInt(request.getParameter(gcode));
		//System.out.println(no+"&&&&& &&&&&&&&&&& & &&&&&&&&&&&&&&&&&&& & ");
		String tableToBeAccessed="";
		if(no< 5)
		{
			System.out.println("IN IF   ");
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
			System.out.println(" "+tableToBeAccessed);
		}else{
			System.out.println("IN else   ");
			tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+no;
		}
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&77 ************");
				
		String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"pquo_items (PQNo ,TheGroup ,Make ,ItemCode ,Quantity ,UnitPrice ,DiscountPercent ,"+
				   "TheTableToBeAccessed ,STPercent ,LandedPrice ,ExtraTaxesApplicable)"+
				   
				   "VALUES ('"+pquono+"','"+no+"','"+mcode+"','"+itemcode+"','"+quantity1+"','"+sellingprice1+"','"+discount1+"',"+
				   " '"+tableToBeAccessed+"','"+tax1+"','"+sellingprice1+"','0' )";
		System.out.println(sql);
		st3.executeUpdate(sql);
		
		 String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq SET QuoReceived='1' WHERE PurchaseEnqNo='"+penqnumber+"' and TWRefNo = '"+twrefnoenq+"'";
		 System.out.println(sqlUpdate);
		 st4.executeUpdate(sqlUpdate);
		
	}
	
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Quotation is Successfully Added in System.&goto=AllPurchaseModule.jsp");
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