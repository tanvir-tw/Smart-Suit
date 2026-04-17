<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	
	
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
	st5=con.createStatement();
	st6=con.createStatement();
	st7=con.createStatement();
	st8=con.createStatement();
	st9=con.createStatement();
	st10=con.createStatement();
	st11=con.createStatement();
	
	String sellingprice1="" ,priceAccepted="",custrefno="",twsalesorderno="";				
	String QuoExpirydate="",paymentterms="",group="",quantity1=""; 
	String discount1="",tax1="",amount="",total="",salesquono="";
	String cgstrate="",sgstrate="",igstrate="";
	String cgstamt="",sgstamt="",igstamt="";
	String totgstamt="",totcgstamt="",totsgstamt="",totigstamt="",SACCode="",HSNCode="";
	String amountInWords="",supcode="";
	String enqtime="",salesquodate1="";
	int i=0,j=0;
	int z=0;
	String pqno=request.getParameter("pquono");
	String acode=request.getParameter("addresscode");
	String company1=request.getParameter("company");
	supcode=request.getParameter("suppliercode");
	String terms=request.getParameter("termsconditions");
	 paymentterms=request.getParameter("paymentterms");
	 String tax=request.getParameter("tax");
	String pfi=request.getParameter("pfi");	
	String frieght=request.getParameter("frieght");
	System.out.println("P & F & I :-"+pfi);
	System.out.println("Frieght :-"+frieght);
 	total=request.getParameter("total");
 	String grandtotal=request.getParameter("grandTotal");
 	salesquodate1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 	String remarks=request.getParameter("remarks");
	amountInWords=request.getParameter("rupees");
	String expirydate=new SimpleDateFormat(
	"yyyy-MM-dd")
	.format(new SimpleDateFormat(
			"dd-MMM-yyyy")
			.parse(request.getParameter("fromdate")));
	int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
	//group=request.getParameter("group");
	String deliverydate=new SimpleDateFormat(
	"yyyy-MM-dd")
	.format(new SimpleDateFormat(
			"dd-MMM-yyyy")
			.parse(request.getParameter("deliverydate")));
	System.out.println("DELIVERY DATE  IIS  ***   "+deliverydate);
	
	
	String SupplierName="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+supcode+"'";
	ResultSet rssup=st5.executeQuery(SupplierName);
	rssup.next();
	String SupName=rssup.getString("SupplierName");
	
String CID=session.getAttribute("CompanyMasterID").toString();
	
	String companydata="select * from CompanyMaster where companymid="+CID;
				ResultSet rsdata123=st.executeQuery(companydata);
				rsdata123.next();
				String companyname=rsdata123.getString("Companyname");
				String address123=rsdata123.getString("address");
				String phone123=rsdata123.getString("phone");
				String mail=rsdata123.getString("emailid");
				String website=rsdata123.getString("website");
				String fax=rsdata123.getString("fax");
				String godownaddress=rsdata123.getString("godownaddress"); 
		Double grandtot=Double.parseDouble(grandtotal);
		
		String UserLevel=session.getAttribute("userLevel").toString();
		
		System.out.println("User Level :-"+UserLevel);
		String comid=session.getAttribute("CompanyMasterID").toString();
		int PurchaseOrderlimit=0;
		String LimitAmount="select PurchaseOrder from "+session.getAttribute("CompanyMasterID").toString()+"erplimitations where UserLevel='"+UserLevel+"'";
		ResultSet rslt=st6.executeQuery(LimitAmount);
		if(!rslt.next())
		{
			if(comid.equals("100000"))
		{
			PurchaseOrderlimit=5000;
		}
		else{
			PurchaseOrderlimit=200000;
		}
			
		}
		else
		{
		PurchaseOrderlimit=rslt.getInt(1);
		}
		System.out.println("Grand Total :-"+grandtot+"PurchaseOrderLimit :- "+PurchaseOrderlimit );
		
		totgstamt=request.getParameter("TOTGST");
	 	
	 	System.out.println("totgstamt :-"+totgstamt);
	 	totcgstamt=request.getParameter("CGST");
	 	System.out.println("totcgstamt :-"+totcgstamt);
	 	totsgstamt=request.getParameter("SGST");
	 	System.out.println("totsgstamt :-"+totsgstamt);
	 	totigstamt=request.getParameter("IGST");
	 	System.out.println("totigstamt :-"+totigstamt);
	 	
		
		
	if(grandtot > PurchaseOrderlimit)
	{
		int porderno;
		String sqlorderno="SELECT MAX(PONo) from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det";
		ResultSet rs=st1.executeQuery(sqlorderno);
		rs.next();
		porderno=rs.getInt(1);
		porderno++;
		System.out.println("Max + 1 --->"+porderno);
		
		int porderno1;
		String sqlorderno1="SELECT MAX(PONo) from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo__items";
		ResultSet rs1=st1.executeQuery(sqlorderno1);
		rs1.next();
		porderno1=rs1.getInt(1);
		porderno1++;
		System.out.println("Max + 1 --->"+porderno1);
		
		
		
		String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det (PONo ,PurQuoNo ,PODate ,POTime ,Terms ,POCancelled ,RevOfPOno ,NoOfRev, "+
				 "ReasonForCancelling ,Total ,DiscountPercent ,GrandTotal ,TotalinWords ,SentBy , SupplierCode ,POReference ,"+	
		         "despatchAddress ,PORaisedByCompany ,PendingPODetails ,PODueDate ,ReasonforPendingPO ,DeliveryDate ,CurrType ,CurrValue,RequestByUserForApproval,RemarksFromMD,PaymentTerms,taxamount,TotCGST,TotSGST,TotIGST,TotGST)"+
		
				 "VALUES ('"+porderno+"','"+pqno+"','"+todaysDate+"','"+todaysTime+"','"+terms+"','0','0','0' ,"+
				 "'-','"+total+"','0.00','"+grandtotal+"','"+amountInWords+"','"+session.getAttribute("EmpName")+"', '"+supcode+"','PO Generated from the Quotation No "+pqno+" ',"+
				 "'"+godownaddress+"','"+companyname+"',"+
				 " 'Amount Greater Than Limit','"+expirydate+"','-','"+deliverydate+"','Rupees','1','PO to be generated for "+SupName+". PO Value :- Rs. "+grandtotal+". and Limit : Rs."+PurchaseOrderlimit+"','-','"+paymentterms+"','"+tax+"','"+totcgstamt+"','"+totsgstamt+"','"+totigstamt+"','"+totgstamt+"')";
		
		System.out.println(" PO Limit Insert------>"+sqlInsert);
		
		st2.executeUpdate(sqlInsert);
		String SupName1="";
		String supplier="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where suppliercode='"+supcode+"'";
		ResultSet rssupplier=st11.executeQuery(supplier);
		if(rssupplier.next())
		{
			SupName1=rssupplier.getString("SupplierName");
		}
		else
		{
			SupName1="-";
		}
				
		String ServiceCat="";
		
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
			
			System.out.println(request.getParameter("gcode"+i)+" ************");
			group=request.getParameter("groupname");
			System.out.println(group+"GRUOP IS  ");
			
			SACCode=request.getParameter("SAC"+i);
			HSNCode=request.getParameter("HSN"+i);
			
			if(SACCode.equals("0") || SACCode=="0" )
			{
				ServiceCat="Goods";
			}
			else
			{
				ServiceCat="Services";
			}
			
			System.out.println("ServiceCat :-"+ServiceCat);
			
			cgstrate=request.getParameter("CGSTRate"+i);
			sgstrate=request.getParameter("SGSTRate"+i);
			igstrate=request.getParameter("IGSTRate"+i);
			cgstamt=request.getParameter("CGSTAmt"+i);
			sgstamt=request.getParameter("SGSTAmt"+i);
			igstamt=request.getParameter("IGSTAmt"+i);
			
			System.out.println(" Before Double "); 
			
			
			
			System.out.println("SACCode :-"+SACCode);
			System.out.println("HSNCode :-"+HSNCode);
			System.out.println("cgstrate :-"+cgstrate);
			System.out.println("sgstrate :-"+sgstrate);
			System.out.println("igstrate :-"+igstrate);
			System.out.println("cgstamt :-"+cgstamt);
			System.out.println("sgstamt :-"+sgstamt);
			System.out.println("igstamt :-"+igstamt);
			
			
			int no=Integer.parseInt(request.getParameter("gcode"+i));
			String tableToBeAccessed="";
			if(no< 5)
			{System.out.println("IN IF    ");
			
				tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
			}else {
				System.out.println("IN ELSR     ");
				
				tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
			}
			
			String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_items (PONo ,TheGroup ,Make ,ItemCode ,Quantity ,UnitPrice ,description,TheTableToBeAccessed,CGSTRate,SGSTRate,IGSTRate,CGSTAmt,SGSTAmt,IGSTAmt,ServiceCategary,SACCode,HSNCode)"+
					   
					   "VALUES ('"+porderno+"','"+gcode+"','"+mcode+"','"+itemcode+"','"+quantity1+"','"+sellingprice1+"','"+description1+"','"+tableToBeAccessed+"',"+cgstrate+","+sgstrate+","+igstrate+",'"+cgstamt+"','"+sgstamt+"','"+igstamt+"','"+ServiceCat+"','"+SACCode+"','"+HSNCode+"')";
			
			System.out.println("PO Limit Item Inser :- "+sql);
			
			st3.executeUpdate(sql);
		
		}
		
		//code for auto alert of pending PO
		
		
				DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
					java.util.Date date = new java.util.Date();		
					String data ="";
					String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new java.util.Date());
					String SystemName="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
					String companyMaster=session.getAttribute("CompanyMasterID").toString();
					String POStatus="Pending";
					String ReportName="Pending PO Order";
					String displayedReportNo="28";
					double ItemPrice=0.00;
					String Quantity="";
					String POReason="Amount Greater Than Limit";
					String toid="md@transworld-compressor.com",tocc="purchase@transworld-compressor.com";
					String subject = "Pending Purchase Order Of Quotation No :- "+pqno+" On "+ df.format(date)+" Of Rs."+grandtotal+"";
						System.out
								.println("===11111111111111111111111111===");
						
								data="<tr><td><table align=left  cellpadding=0 cellspacing=0 border=0><tr><td align=left><font size=3 face=arial><b> Pending Purchase Order Details : </b></font></br></td></tr></table></td></tr>"+
										"<tr><td><table align=left  cellpadding=0 cellspacing=0 border=1 style=^border-collapse: collapse^>"+
								"<tr bgcolor=^#ADDFFF^>"+
										"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> SrNo  </b></font></td>"+
										"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> PendingPoNo  </b></font></td>"+
							/* "<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> PurQuoNo </b></font></td>"+ */
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Date  </b></font></td>"+
							
									"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Supplier </b></font></td>"+
											"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> ItemCode </b></font></td>"+
											"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Desc  </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Status  </b></font></td>"+
							
							"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Quantity  </b></font></td>"+
									"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> UnitPrice  </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> PendingReason </b></font></td>"+
							"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Entry By</b></font></td>";
		
							String PendingPo="select * from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_items where PONo='"+porderno+"'";
							ResultSet rspendpo=st10.executeQuery(PendingPo);
							
									while(rspendpo.next())
									{
										
										ItemPrice=0.00;
										Quantity="";
										
										ItemPrice=rspendpo.getDouble("UnitPrice");
										Quantity=rspendpo.getString("Quantity");
										
										z++;		
									
							
					data= data +"<tr><td align=right><font size=^2^ face=^arial^>"+ z +"</font></td>"+
					"<td align=right><font size=^2^ face=^arial^>"+porderno+"</font></td>"+
/* "<td align=right><font size=^2^ face=^arial^>"+pqno+"</font></td>"+ */
								"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd")
											.parse(todaysDate))+"</font></td>"+
											"<td align=left><font size=^2^ face=^arial^>"+SupName1+"</font></td>"+
													"<td align=right><font size=^2^ face=^arial^>"+rspendpo.getString("ItemCode")+"</font></td>"+
													"<td align=left><font size=^2^ face=^arial^>"+rspendpo.getString("description")+"</font></td>"+
													
											"<td align=left><font size=^2^ face=^arial^>"+POStatus+"</font></td>"+
											
							"<td align=right><font size=^2^ face=^arial^>"+Quantity+"</font></td>"+
							"<td align=right><font size=^2^ face=^arial^>"+ItemPrice+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+POReason+"</font></td>"+
							"<td align=left><font size=^2^ face=^arial^>"+session.getAttribute("EmpName").toString()+"</font></td>";
							
							
							
														
									}
									z++;
									data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

									data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
									data= data + "</tr></body></html>";

						System.out
								.println("in DDDDDDDDDDDDDDDDAta====="
										+ data);
						
						try
						{
							
							String getEmailDetails="select * from db_gps.t_EmailReportSettings	where System='ERP"+companyMaster+"'";
							ResultSet rs100=st9.executeQuery(getEmailDetails);
							
							while(rs100.next())
							{
								 SystemName=rs100.getString("System");
								 Website=rs100.getString("Website");
								 Logo1=rs100.getString("Logo1");
								 Logo2=rs100.getString("Logo2");
								 Signature=rs100.getString("Signature");
								 fromLabel=rs100.getString("fromLabel");
								 replyToMailid=rs100.getString("replyToMailid");
								 Disclaimer=rs100.getString("Disclaimer");
								
							}
							
						}catch(Exception e)
						{
							System.out.println("Exception "+e.getMessage());
						}
								
						
						String html ="<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
		 						"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
		 						"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href= target=^_blank^>"+
		 						"<img src="+Logo1+" style=^height: 80px; width: 300px;^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
		 						"<img src="+Logo2+"  style=^height: 80px; width: 300px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
		 						"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^2^ face = ^Arial^>"+
		 						" <u><a href=http://"+Website+"></u>"+Website+"</a>"+ df.format(new Date())+"<br>"+"\n "+ReportName+": "+displayedReportNo+"</font><table>";
				        
				        html = html + data;
				        html = html + "</table><table align= left><br></br><tr><td><font size=^2^ face=^Arial^>Thanks and Regards</font></td></tr><tr><td><font size=^2^ face=^Arial^>"+Signature+"</font></td></tr><tr><td><font size=^2^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr>  <td><font size=^2^ face=^Arial^> "+Disclaimer+"</font></td> </tr></table></td></tr></table></div></td></tr></table></td></tr></body></html>";
						
					String 	q2 = "insert into t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('Pending PO Details','Pending Purchase Order','"
								+ html
								+ "','"
								+ subject
								+ "','"
								+ toid
								+ "','"
								+ tocc
								+ "','"
								+ CurrentDate + "','Pending','Transworld','','')";

					System.out.println("q2All_PendingMail>>>> :" + q2);
					st8.executeUpdate(q2);
					System.out.println("inserted in all pending mail >>> 1234");
		
		response.sendRedirect("alertGoTo.jsp?msg=Order Saved and Pending For Approval.&goto=home.jsp");
	}
	
	else
	{
		
		System.out.println(" <---Inside Else--->");
	int porderno;
	String sqlorderno="SELECT MAX(PONo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder ";
	ResultSet rs=st1.executeQuery(sqlorderno);
	rs.next();
	porderno=rs.getInt(1);
	porderno++;
	System.out.println(porderno);
	
	String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder (PONo ,PurQuoNo ,PODate ,POTime ,Terms ,POCancelled ,RevOfPOno ,NoOfRev, "+
					 "ReasonForCancelling ,Total ,DiscountPercent ,GrandTotal ,TotalinWords ,SentBy , SupplierCode ,POReference ,"+	
			         "despatchAddress ,PORaisedByCompany ,PendingPODetails ,PODueDate ,ReasonforPendingPO ,DeliveryDate ,CurrType ,CurrValue,PaymentTerms,taxamount,TotCGST,TotSGST,TotIGST,TotGST)"+
			
					 "VALUES ('"+porderno+"','"+pqno+"','"+todaysDate+"','"+todaysTime+"','"+terms+"','0','0','0' ,"+
					 "'-','"+total+"','0.00','"+grandtotal+"','"+amountInWords+"','"+session.getAttribute("EmpName")+"', '"+supcode+"','PO Generated from the Quotation No "+pqno+" ',"+
					 "'"+godownaddress+"','"+companyname+"',"+
					 " '-','"+expirydate+"','-','"+deliverydate+"','Rupees','1','"+paymentterms+"','"+tax+"',"+totcgstamt+","+totsgstamt+","+totigstamt+","+totgstamt+")";			
	
	System.out.println("PO Order Insert :- "+sqlInsert);	
	st2.executeUpdate(sqlInsert);
	
	String ServiceCat1="";
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
		
		System.out.println(request.getParameter("gcode"+i)+" ************");
		group=request.getParameter("groupname");
		System.out.println(group+"GRUOP IS  ");
		
		SACCode=request.getParameter("SAC"+i);
		HSNCode=request.getParameter("HSN"+i);
		if(SACCode.equals("0") || SACCode=="0" )
		{
			ServiceCat1="Goods";
		}
		else
		{
			ServiceCat1="Services";
		}
		
		System.out.println("ServiceCat :-"+ServiceCat1);
		
		cgstrate=request.getParameter("CGSTRate"+i);
		sgstrate=request.getParameter("SGSTRate"+i);
		igstrate=request.getParameter("IGSTRate"+i);
		cgstamt=request.getParameter("CGSTAmt"+i);
		sgstamt=request.getParameter("SGSTAmt"+i);
		igstamt=request.getParameter("IGSTAmt"+i);
		
		System.out.println("SACCode :-"+SACCode);
		System.out.println("HSNCode :-"+HSNCode);
		System.out.println("cgstrate :-"+cgstrate);
		System.out.println("sgstrate :-"+sgstrate);
		System.out.println("igstrate :-"+igstrate);
		System.out.println("cgstamt :-"+cgstamt);
		System.out.println("sgstamt :-"+sgstamt);
		System.out.println("igstamt:-"+igstamt);
		
		
		int no=Integer.parseInt(request.getParameter("gcode"+i));
		String tableToBeAccessed="";
		if(no< 5)
		{System.out.println("IN IF    ");
		
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
		}else {
			System.out.println("IN ELSR     ");
			
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
		}
		String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items (PONo ,TheGroup ,Make ,ItemCode ,Quantity ,UnitPrice,description,TheTableToBeAccessed,CGSTRate,SGSTRate,IGSTRate,CGSTAmt,SGSTAmt,IGSTAmt,ServiceCategary,SACCode,HSNCode)"+
				   
				   "VALUES ('"+porderno+"','"+gcode+"','"+mcode+"','"+itemcode+"','"+quantity1+"','"+sellingprice1+"','"+description1+"','"+tableToBeAccessed+"','"+cgstrate+"','"+sgstrate+"','"+igstrate+"','"+cgstamt+"','"+sgstamt+"','"+igstamt+"','"+ServiceCat1+"','"+SACCode+"','"+HSNCode+"')";
		System.out.println("PO Order Item Insert :- "+sql);
		st3.executeUpdate(sql);
		
		String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"purchasequo SET POGenerated='1',QuoReceived='1' WHERE PurQuoNo='"+pqno+"'";
		System.out.println(sqlUpdate);
		st4.executeUpdate(sqlUpdate);
		
	}
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Order Successfully Saved.&goto=home.jsp");
	}
	
	
	
	
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