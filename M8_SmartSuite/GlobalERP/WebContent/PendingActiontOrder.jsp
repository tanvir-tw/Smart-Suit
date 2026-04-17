<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%><%@page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	
	<script src="sorttable.js" type="text/javascript"></script>
	
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>
	
	
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>
	<script type="text/javascript">
	function Redirect1()
	{
		
		
		var Action=document.getElementById("Action").value;
		var Status=document.getElementById("Status").value;
		
		alert(Status +" Order Is " +Action+" Successfully ");
		
		window.location="PendingPurchaseOrderList.jsp";
		
	}
	
	function Redirect2()
	{
		
		var Action=document.getElementById("Action").value;
		var Status=document.getElementById("Status").value;
		
		alert(Status +" Order Is " +Action+" Successfully ");
		
		window.location="PendingPurchaseOrderList.jsp";
		
	}
	
	
	
	function Redirect3()
	{
		
		var Action=document.getElementById("Action").value;
		var Status=document.getElementById("Status").value;
		
		alert(Status +" Order Is " +Action+" Successfully ");
		
		window.location="PendingPurchaseOrderList.jsp";
		
	}
	
	
	
	</script>
	</head>
	<body>
    
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		    Connection conn = null;
			Statement st = null,st1=null,st2=null,st3=null,st5=null,st8=null,st9=null,st10=null,st11=null,st12=null;
			boolean isInvoiceSelected = false;
			int count=0;
			int d=0;
			Date today = new Date();
			String enqDate=new SimpleDateFormat("dd-MMM-yyyy").format(today);
			String date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enqDate));
			String todaysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
			String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
			
			
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, +4);
			Date fourdayslaterAsDate = cal.getTime();
			String fourdayslaterDate=new SimpleDateFormat("yyyy-MM-dd").format(fourdayslaterAsDate);
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$           %%%%%%%%%%%%   "+fourdayslaterDate);
			
			Date mothafter=new Date();
			cal.setTime(today);
			cal.add(Calendar.DAY_OF_MONTH,+30);
			Date MonthAsDate=cal.getTime();
			String monthafter=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(MonthAsDate);
			String monthafterInMMM=new SimpleDateFormat("dd-MMM-yyyy hh:mm;ss").format(MonthAsDate);
			System.out.println(monthafterInMMM+"())))))))))))))))))))))  ");
			double stpercent=0.0,amount=0.0,sellingPrice=0.0;
			Date today1 = new Date();
			String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today1);
			
			String type=request.getParameter("reasonforcancel");
			int porderno;
			type.replaceAll("'", " ");
			System.out.println("Action  :- "+type);
			
			String PurOrderRefNumber = request.getParameter("PurOrderNumber");
			System.out.println("PurOrderRefNumber :- "+PurOrderRefNumber);
			
			String Status=request.getParameter("type");
			System.out.println("Status :- "+Status);
			
			String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",PurQuoNumber="",status="",statusTD="",fromdate="";
			NumberFormat nf = new DecimalFormat("#0.00");
			String AuthorisationStatus="";
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st5 = conn.createStatement();
				st8 = conn.createStatement();
				st9 = conn.createStatement();
				st10 = conn.createStatement();
				st11= conn.createStatement();
				st12= conn.createStatement();
				
			} catch (Exception e) {
			}
			String  sqlPurchase="";
			String sqlPurDet ="";
			String cgstrate="",sgstrate="",igstrate="";
			String cgstamt="",sgstamt="",igstamt="";
			String totgstamt="",totcgstamt="",totsgstamt="",totigstamt="",SACCode="",HSNCode="";
			String SupName1="";
			int z1=0;
			int z=0;
		if(Status.equals("Pending"))
		{
		if(type.equals("Approved"))
		{
	   sqlPurchase = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det WHERE PONo = '"+ PurOrderRefNumber + "' ";
		
		
		System.out.println("****************             "+sqlPurchase);
	ResultSet rsTransaction = st.executeQuery(sqlPurchase);
	System.out.println("****************             "+sqlPurchase);
	if (rsTransaction.next()) 
	{
				
		String dueDate = "NA";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("PODueDate")));
				} catch (Exception e) {
				}
				String DelvDate = "NA";
				try {
					DelvDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsTransaction.getString("DeliveryDate")));
				} catch (Exception e) {
				}
				String PurOrderNumber=rsTransaction.getString("PONo");
				String Total=rsTransaction.getString("Total");
				String GrandTotal=rsTransaction.getString("GrandTotal");
				String TotalInWords=rsTransaction.getString("TotalinWords");
				String Terms=rsTransaction.getString("Terms");
				String pqno=rsTransaction.getString("PurQuoNo");
				String amountInWords=rsTransaction.getString("TotalinWords");
				String godownaddress=rsTransaction.getString("despatchAddress");
				String companyname=rsTransaction.getString("PORaisedByCompany");
				String supcode=rsTransaction.getString("SupplierCode");
				String expirydate=rsTransaction.getString("PODueDate");
				String deliverydate=rsTransaction.getString("DeliveryDate");
				String SentBy=rsTransaction.getString("SentBy");

				totgstamt=rsTransaction.getString("TotGST");
			 	
			 	System.out.println("totgstamt :-"+totgstamt);
			 	totcgstamt=rsTransaction.getString("TotCGST");
			 	System.out.println("totcgstamt :-"+totcgstamt);
			 	totsgstamt=rsTransaction.getString("TotSGST");
			 	System.out.println("totsgstamt :-"+totsgstamt);
			 	totigstamt=rsTransaction.getString("TotIGST");
			 	System.out.println("totigstamt :-"+totigstamt);
				
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
				
				int POCancelled=0;
				if(type.equals("Approved"))
				{
					AuthorisationStatus="Approved";
					POCancelled=2;
				}
				else
				{
					AuthorisationStatus="Rejected";
					POCancelled=3;
				}
				
				%>
				<input type="hidden" name="Action" id="Action" value=<%=AuthorisationStatus%>></input>
				<input type="hidden" name="Status" id="Status" value=<%=Status%>></input>
				
				<%
				
				
				String sqlorderno="SELECT MAX(PONo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder ";
				ResultSet rs=st1.executeQuery(sqlorderno);
				rs.next();
				porderno=rs.getInt(1);
				porderno++;
				System.out.println("Max Of Po No :- "+porderno);
				
				String InsertPO="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder (PONo ,PurQuoNo ,PODate ,POTime ,Terms ,POCancelled ,RevOfPOno ,NoOfRev, "+
						 "ReasonForCancelling ,Total ,DiscountPercent ,GrandTotal ,TotalinWords ,SentBy , SupplierCode ,POReference ,"+	
				         "despatchAddress ,PORaisedByCompany ,PendingPODetails ,PODueDate ,ReasonforPendingPO ,DeliveryDate ,CurrType ,CurrValue,AuthorisationStatus,ApprovedBy,TotCGST,TotSGST,TotIGST,TotGST )"+
				
						 "VALUES ('"+porderno+"','"+pqno+"','"+todaysDate+"','"+todaysTime+"','"+Terms+"','0','0','0' ,"+
						 "'-','"+Total+"','0.00','"+GrandTotal+"','"+amountInWords+"','"+SentBy+"', '"+supcode+"','PO Generated from the Quotation No "+pqno+" ',"+
						 "'"+godownaddress+"','"+companyname+"',"+
						 " '-','"+expirydate+"','-','"+deliverydate+"','Rupees','1','"+AuthorisationStatus+"','"+session.getAttribute("EmpName")+"' ,"+totcgstamt+","+totsgstamt+","+totigstamt+","+totgstamt+")";
				
				System.out.println("PO Insert :- "+InsertPO);
				st.executeUpdate(InsertPO);
				if(Status.equals("Pending"))
				{

				sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_items WHERE PONo ='"+ PurOrderNumber + "'  ";
				}
				
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("****************             "+sqlPurDet);
				
				String ServiceCat="";
				
				while (rsPurDet.next())		  
				{
					String des=rsPurDet.getString("description");
					if(des.equals("null") || des==" " || des=="")
					{
						des="-";
					}
					else{
						des=rsPurDet.getString("description");
					}
					
					SACCode=rsPurDet.getString("SACCode");
					HSNCode=rsPurDet.getString("HSNCode");
					
					ServiceCat=rsPurDet.getString("ServiceCategary");
					
					
					
					System.out.println("ServiceCat :-"+ServiceCat);
					
					cgstrate=rsPurDet.getString("CGSTRate");
					sgstrate=rsPurDet.getString("SGSTRate");
					igstrate=rsPurDet.getString("IGSTRate");
					cgstamt=rsPurDet.getString("CGSTAmt");
					sgstamt=rsPurDet.getString("SGSTAmt");
					igstamt=rsPurDet.getString("IGSTAmt");
					
					System.out.println("SACCode :-"+SACCode);
					System.out.println("HSNCode :-"+HSNCode);
					System.out.println("cgstrate :-"+cgstrate);
					System.out.println("sgstrate :-"+sgstrate);
					System.out.println("igstrate :-"+igstrate);
					System.out.println("cgstamt :-"+cgstamt);
					System.out.println("sgstamt :-"+sgstamt);
					System.out.println("igstamt :-"+igstamt);
					
					
					
					String ItemInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items (PONo ,TheGroup ,Make ,ItemCode ,Quantity ,UnitPrice ,description,TheTableToBeAccessed,CGSTRate,SGSTRate,IGSTRate,CGSTAmt,SGSTAmt,IGSTAmt,ServiceCategary,SACCode,HSNCode)"+
					   
					   "VALUES ('"+porderno+"','"+rsPurDet.getString("TheGroup")+"','"+rsPurDet.getString("Make")+"','"+rsPurDet.getString("ItemCode")+"','"+rsPurDet.getString("Quantity")+"','"+rsPurDet.getString("UnitPrice")+"','"+des+"','"+rsPurDet.getString("TheTableToBeAccessed")+"',"+cgstrate+","+sgstrate+","+igstrate+","+cgstamt+","+sgstamt+","+igstamt+",'"+ServiceCat+"','"+SACCode+"','"+HSNCode+"')";
					
					System.out.println("PO Order Item Insert :- "+ItemInsert);
					st3.executeUpdate(ItemInsert);
				}
				//update pending PO table AuthorisationStatus 
				String UpdateAuthorisationStatus="update "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det set AuthorisationStatus='"+AuthorisationStatus+"' ,ActualPONo='"+porderno+"' ,RemarksFromMD='"+type+"' where PONo='"+PurOrderRefNumber+"'";
				System.out.println("Pending PO Update:- "+UpdateAuthorisationStatus);
				st3.executeUpdate(UpdateAuthorisationStatus);
				
				/* else
				{
					
						System.out.println("Status is :-"+Status+" and Action is :- "+AuthorisationStatus);
						
						String po="select * from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det where PONo='"+PurOrderRefNumber+"'";
						ResultSet rsactpo=st5.executeQuery(po);
						
						rsactpo.next();
						
						//update original PO Table AuthorisationStatus
						
						String UpdateAuthorisationStatus="update "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder set AuthorisationStatus='"+AuthorisationStatus+"' where PONo='"+rsactpo.getString("ActualPONo")+"' and AuthorisationStatus='"+rsactpo.getString("AuthorisationStatus")+"'";
						System.out.println("Pending PO Update:- "+UpdateAuthorisationStatus);
						st5.executeUpdate(UpdateAuthorisationStatus);
				} */
				
				
				DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
				java.util.Date date1 = new java.util.Date();		
				String data ="";
				String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new java.util.Date());
				String SystemName="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
				String companyMaster=session.getAttribute("CompanyMasterID").toString();
				String POStatus="Pending";
				String ReportName="Pending PO Order";
				String displayedReportNo="28";
				
				String POReason="Amount Greater Than Limit";
				String toid="purchase@transworld-compressor.com",tocc="md@transworld-compressor.com";
				String subject = ""+type+" Purchase Order Of Pending PoNo :- "+PurOrderNumber+" On "+ df.format(date1)+" .";
					System.out
							.println("===11111111111111111111111111===");
					
							data="<tr><td><table align=left  cellpadding=0 cellspacing=0 border=0><tr><td align=left><font size=3 face=arial><b> Pending Purchase Order Details : </b></font></br></td></tr></table></td></tr>"+
									"<tr><td><table align=left  cellpadding=0 cellspacing=0 border=1 style=^border-collapse: collapse^>"+
							"<tr bgcolor=^#ADDFFF^>"+
									"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> SrNo  </b></font></td>"+
									"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> PendingPoNo  </b></font></td>"+
						"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> ActualPoNo </b></font></td>"+ 
						"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Date  </b></font></td>"+
								"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Supplier </b></font></td>"+
								"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Itemcode </b></font></td>"+
										"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Desc </b></font></td>"+
								"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Status </b></font></td>"+
										"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Comment </b></font></td>"+
										"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Approved /Rejected By  </b></font></td>";
										String PendingPo="select * from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_items where PONo='"+PurOrderRefNumber+"'";
										ResultSet rspendpo=st10.executeQuery(PendingPo);
										
												while(rspendpo.next())
												{
										z1++;
							data= data +"<tr><td align=right><font size=^2^ face=^arial^>"+ z1 +"</font></td>"+
									"<td align=right><font size=^2^ face=^arial^>"+PurOrderNumber+"</font></td>"+
				 "<td align=right><font size=^2^ face=^arial^>"+porderno+"</font></td>"+ 
												"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat(
															"yyyy-MM-dd")
															.parse(todaysDate))+"</font></td>"+
															"<td align=left><font size=^2^ face=^arial^>"+SupName1+"</font></td>"+
															 "<td align=right><font size=^2^ face=^arial^>"+rspendpo.getString("ItemCode")+"</font></td>"+ 
																	 "<td align=left><font size=^2^ face=^arial^>"+rspendpo.getString("description")+"</font></td>"+
															"<td align=left><font size=^2^ face=^arial^>"+AuthorisationStatus+"</font></td>"+
																	"<td align=left><font size=^2^ face=^arial^>"+type+"</font></td>"+
																	"<td align=left><font size=^2^ face=^arial^>"+session.getAttribute("EmpName").toString()+"</font></td>";
																	
															
											
											
												}
																		
													
													data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

													data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
													data= data + "</tr></body></html>";
													
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
										
								
				out.println("<script>  Redirect1();</script>");
	}
	
	
			}
		
		
		else if(type.equals("Cancel"))
		{
			
			System.out.println("Inside Cancel Action Page");
			System.out.println("Inside Cancel");
		
			AuthorisationStatus="Cancelled";
			String UpdateAuthorisationStatus1="update "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det set AuthorisationStatus='"+AuthorisationStatus+"'  where PONo='"+PurOrderRefNumber+"'";
			System.out.println("Pending PO Update:- "+UpdateAuthorisationStatus1);
			st3.executeUpdate(UpdateAuthorisationStatus1);

			
			%>
						<input type="hidden" name="Action" id="Action" value=<%=AuthorisationStatus%>></input>
						<input type="hidden" name="Status" id="Status" value=<%=Status%>></input>
						
						<%
						
			
			out.println("<script>  Redirect3();</script>");
		
		}
		
		
		else{
			String code="";
			String supcode1="select * from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det where PONo='"+PurOrderRefNumber+"' ";
			ResultSet rssup=st12.executeQuery(supcode1);
			if(rssup.next())
			{
				code=rssup.getString("SupplierCode");
			}
			else
			{
				code="";
			}
			
			String supplier="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where suppliercode='"+code+"'";
			ResultSet rssupplier=st11.executeQuery(supplier);
			if(rssupplier.next())
			{
				SupName1=rssupplier.getString("SupplierName");
			}
			else
			{
				SupName1="-";
			}
			
			AuthorisationStatus="Rejected";
			String UpdateAuthorisationStatus1="update "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det set AuthorisationStatus='"+AuthorisationStatus+"',RemarksFromMD='"+type+"' where PONo='"+PurOrderRefNumber+"'";
			System.out.println("Pending PO Update:- "+UpdateAuthorisationStatus1);
			st3.executeUpdate(UpdateAuthorisationStatus1);
			
			%>
			<input type="hidden" name="Action" id="Action" value=<%=AuthorisationStatus%>></input>
			<input type="hidden" name="Status" id="Status" value=<%=Status%>></input>
			
			<%
			
			DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
			java.util.Date date1 = new java.util.Date();		
			String data ="";
			String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new java.util.Date());
			String SystemName="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
			String companyMaster=session.getAttribute("CompanyMasterID").toString();
			String POStatus="Pending";
			String ReportName="Pending PO Order";
			String displayedReportNo="28";
			String reason="Rejected";
			String porderno1="-";
			
			String POReason="Amount Greater Than Limit";
			//String toid="w_tamboli@transworld-compressor.com",tocc="p_tepale@transworld-compressor.com";
			String toid="purchase@transworld-compressor.com",tocc="md@transworld-compressor.com";
			String subject = ""+reason+" Purchase Order Of Pending PoNo :- "+PurOrderRefNumber+" On "+ df.format(date1)+" .";
				System.out
						.println("===11111111111111111111111111===");
				
						data="<tr><td><table align=left  cellpadding=0 cellspacing=0 border=0><tr><td align=left><font size=3 face=arial><b> Pending Purchase Order Details : </b></font></br></td></tr></table></td></tr>"+
								"<tr><td><table align=left  cellpadding=0 cellspacing=0 border=1 style=^border-collapse: collapse^>"+
						"<tr bgcolor=^#ADDFFF^>"+
								"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> SrNo  </b></font></td>"+
								"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> PendingPoNo  </b></font></td>"+
					"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> ActualPoNo </b></font></td>"+
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Date  </b></font></td>"+
							"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Supplier </b></font></td>"+
									"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Itemcode </b></font></td>"+
											"<td align=center style=^width: 3%;^><font size=^2^ face=^arial^><b> Desc </b></font></td>"+
					
					
							"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Status </b></font></td>"+
									"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Comment </b></font></td>"+
									"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Approved /Rejected By  </b></font></td>";
									String PendingPo="select * from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_items where PONo='"+PurOrderRefNumber+"'";
									ResultSet rspendpo=st10.executeQuery(PendingPo);
									
											while(rspendpo.next())
											{
									z++;
						data= data +"<tr><td align=right><font size=^2^ face=^arial^>"+ z +"</font></td>"+
								"<td align=right><font size=^2^ face=^arial^>"+PurOrderRefNumber+"</font></td>"+
			 "<td align=right><font size=^2^ face=^arial^>"+porderno1+"</font></td>"+
					  
											"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat(
														"yyyy-MM-dd")
														.parse(todaysDate))+"</font></td>"+
														"<td align=left><font size=^2^ face=^arial^>"+SupName1+"</font></td>"+
														 "<td align=right><font size=^2^ face=^arial^>"+rspendpo.getString("ItemCode")+"</font></td>"+ 
																 "<td align=left><font size=^2^ face=^arial^>"+rspendpo.getString("description")+"</font></td>"+
														"<td align=left><font size=^2^ face=^arial^>"+AuthorisationStatus+"</font></td>"+
																"<td align=left><font size=^2^ face=^arial^>"+type+"</font></td>"+
																"<td align=left><font size=^2^ face=^arial^>"+session.getAttribute("EmpName").toString()+"</font></td>";
																
														
										
										
										
											}						
												
												data= data + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

												data= data + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^></font></td></tr> <tr>  <td><font size=^3^ face=^Arial^></font></td> </tr>";
												data= data + "</tr></body></html>";
												
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
			
			out.println("<script>  Redirect1();</script>");
		}
		
		
		
		}	
				 else 
				{     
					 String AuthorisationStatus1="";
					 int POCancelled=0;
					 if(type.equals("Approved"))
					 {
						 AuthorisationStatus1="Approved";
						 POCancelled=2;
					 }
					 else
					 {
						 AuthorisationStatus1="Rejected";
						 POCancelled=3;
					 }
						
					 
					 System.out.println("Status is :-"+Status+" and Action is :- "+AuthorisationStatus1);
					 %>
						<input type="hidden" name="Action" id="Action" value=<%=AuthorisationStatus1%>></input>
						<input type="hidden" name="Status" id="Status" value=<%=Status%>></input>
						
						<%
						
						
						String po="select * from "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det where PONo='"+PurOrderRefNumber+"'";
						System.out.println("Pending PO Update:- "+po);
						ResultSet rsactpo=st5.executeQuery(po);
						rsactpo.next();
						
						//update original PO Table AuthorisationStatus
						//type="Rejected";
						String UpdateAuthorisationStatus="update "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder set AuthorisationStatus='"+AuthorisationStatus1+"' where PONo='"+rsactpo.getString("ActualPONo")+"' and AuthorisationStatus='"+rsactpo.getString("AuthorisationStatus")+"'";
						
						st5.executeUpdate(UpdateAuthorisationStatus);
						System.out.println("Already  PO Update:- "+UpdateAuthorisationStatus);
						
						String UpdateAuthorisationStatus1="update "+session.getAttribute("CompanyMasterID").toString()+"authorisepo_det set AuthorisationStatus='"+AuthorisationStatus1+"' where PONo='"+PurOrderRefNumber+"'";
						System.out.println("Pending PO Update:- "+UpdateAuthorisationStatus1);
						st3.executeUpdate(UpdateAuthorisationStatus1);
						
						 
						out.println("<script>  Redirect2();</script>");			
					
				} 
				
	
						
		
	%>


           
           
            

	


</form>

			
<!-- 	<br> <br> <br> <br><br> <br> <br> <br><br> <br> <br> <br> -->
<!-- 	<br> <br> <br> <br><br> <br> <br> <br><br> <br> <br> <br> -->
<!-- 	<div id="footer"> -->
<!-- 	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009 -->
<!-- 	by Transworld  Technologies Ltd. All Rights Reserved.</a></p> -->
<!-- 	</div> -->
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
<%@ include file="footer_new.jsp"%>