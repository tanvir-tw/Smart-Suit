<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
System.out.print("Insert");
	
	try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		int i=0;
		int a=0;
		double total=Double.parseDouble(request.getParameter("totalN").toString());
		double pfi=Double.parseDouble(request.getParameter("pfi").toString());
		double pfi1=Math.round(total*pfi/100);
		String sqlAddition="";
		String salesorderno="",custsalesorderno="";
		String salesorderdate="",salesordertime="";
		String currsym=request.getParameter("CurrS");
		String discount="1",tax="";
		String quantity1="",sellingprice="";
		String description="";
		String SESQnumber="";
 		String istype=request.getParameter("type");
 		System.out.println("%^^^^^^^^^^%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     "+istype);
		int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
		String groupName=request.getParameter("groupTop");		
		String shipmentDate=new SimpleDateFormat(
		"yyyy-MM-dd")
		.format(new SimpleDateFormat(
				"dd-MMM-yyyy")
				.parse(request.getParameter("dateOfShipment")));
		
		int SINumber;
		String sqlOrderno="SELECT MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet ";
		ResultSet rs=st.executeQuery(sqlOrderno);
		System.out.println(sqlOrderno);
		rs.next();  
			SINumber=rs.getInt(1);
		SINumber++;
		System.out.println("&&&&****&& N "+SINumber);
		
		int SIProNumber;
		String SIProNo="select MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet ";
		ResultSet rsPro=st1.executeQuery(SIProNo);
		System.out.println(SIProNo);
		rsPro.next();
			SIProNumber=rsPro.getInt(1);
		SIProNumber++;	
		System.out.println("NONONON   MNOPNPOMKJKK   N "+SIProNumber);
		
		
		
		String SIRefNumber="";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");

		try{
			
			Date today = new Date();
			 
			SIRefNumber="EXP SI";

			String date =  new SimpleDateFormat("ddMMyy").format(new Date());

			String sql3="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet  where invoiceRefNo like ('"+SIRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    rs=st2.executeQuery(sql3);
			    System.out.println(sql3);     
			  if(rs.next())
				  SIRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SIRefNumber+=date+"001";
			  
		}catch(Exception e){
		e.printStackTrace();		
		}
		
		
		String SPRefNumber="";
	//	java.text.DecimalFormat df = new java.text.DecimalFormat("000");

		try{
			
			Date today = new Date();
			 
			SPRefNumber="EXP SP";

			String date =  new SimpleDateFormat("ddMMyy").format(new Date());

			String sql4="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  where invoiceRefNo like ('"+SPRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    rs=st3.executeQuery(sql4);
			    System.out.println(sql4);
			  if(rs.next())
				  SPRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SPRefNumber+=date+"001";
			  
		}catch(Exception e){
		e.printStackTrace();		
		}
		
		
		String sqlCustomerDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"customerdet WHERE CustomerCode='"+request.getParameter("customercode")+"' ";
		ResultSet rsCustomerDetails=st.executeQuery(sqlCustomerDetails);
		rsCustomerDetails.next();
		
		String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesOrderNo='"+ request.getParameter("SONumber") + "' ";
		ResultSet rsDet = st1.executeQuery(sqlDet);
		rsDet.next();
		
		String sqlQuotationDet="SELECT TWSalesRefNo from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+rsDet.getInt("SalesQuoNo")+"' ";
		System.out.println("QUERTY PRINTGGG   "+sqlQuotationDet);
		ResultSet rsQuotaionDet=st2.executeQuery(sqlQuotationDet);
		rsQuotaionDet.next();
		SESQnumber=rsQuotaionDet.getString(1);
		System.out.println("++++++++++++++++++++++++++++++++++++++++++======");	
		
		
		
		if(istype.equalsIgnoreCase("main"))
		{
		
        	String sqlmain="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"invoicedet " +
        			"(" +
        			"	InvoiceNo ,CustomerCode ,	InvoiceDate, TheGroup ,Total ," +
        			"	Discount ,CST ,PFI ,FreightAmt ,GrandTotal, " +
        			"	Terms, TotalInWords, 	PONo 	,PODate ,	DespatchMode ," +
        			"	FreightType ,	PaymentMode ,	Insurance, ShippedBy ,ShipmentDate ," +
        			"	DespCheckListCheckedBy ,PackingSlipCheckedBy ,DocketFilledBy,InvoiceCancelled ,	RevofInvoiceNo ," +
        			"	NoofRevisions ,	ReasonForCancelling ,SEandSQRefNo,InvoiceTime,InvoiceRaisedby," +
        			"	CurrType,CurrValue,TWSalesOrderNo ,DebitNote,TWEmpName, "+
        			"	AddressCode,CompanyName,ContactPerson,Address,city," +
        			"	Zip,State,country,Phone ,Fax, "+
        			"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,SalesInTransit ,VATdeclaration "+
        			"	)"+
        			"   Values(?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?"+
        			")";

				 java.sql.PreparedStatement stmt = con.prepareStatement( sqlmain );
				 
				 System.out.println(rsDet.getString("SalesOrderDate")+"Prop stmt "+request.getParameter("totalN").toString());
				 
				 stmt.setString(1,Integer.toString(SINumber));
				 stmt.setString(2,rsCustomerDetails.getString("CustomerCode"));
				 stmt.setString(3,todaysDate);
				 stmt.setString(4,rsDet.getString("TheGroup"));
				 stmt.setString(5,request.getParameter("totalN").toString());
				 stmt.setString(6,"0");
				 stmt.setString(7,"0");
				 stmt.setString(8,request.getParameter("pfi").toString());
				 stmt.setString(9,request.getParameter("frieght").toString());
				 stmt.setString(10,request.getParameter("grandTotalN").toString());
				 stmt.setString(11,request.getParameter("terms").toString());
				 stmt.setString(12,request.getParameter("rupees").toString());
				 stmt.setString(13,request.getParameter("SONumber").toString());
				 stmt.setString(14,rsDet.getString("SalesOrderDate"));
				 stmt.setString(15,"-");
				 stmt.setString(16,request.getParameter("frieghtType").toString());
				 stmt.setString(17,request.getParameter("paymentMode").toString());
				 stmt.setString(18,request.getParameter("insurance").toString());
				 stmt.setString(19,request.getParameter("shippedBy").toString());
				 stmt.setString(20,shipmentDate);
				 stmt.setString(21,request.getParameter("checkedBy").toString());
				 stmt.setString(22,request.getParameter("packingSlipCheckedBy").toString());
				 stmt.setString(23,request.getParameter("docketFilledBy").toString());
				 stmt.setString(24,"0");
				 stmt.setString(25,"0");
				 stmt.setString(26,"0");
				 stmt.setString(27,"0");
				 stmt.setString(28,SESQnumber);
				 stmt.setString(29,todaysTime);
				 stmt.setString(30,request.getParameter("SIRaisedBy").toString());
				 stmt.setString(31,request.getParameter("currencyType").toString());
				 stmt.setString(32,"0");
				 stmt.setString(33,request.getParameter("SONumber").toString());
				 stmt.setString(34,"0");
				 stmt.setString(35,session.getAttribute("EmpName").toString());
				 stmt.setString(36,request.getParameter("addresscode").toString());
				 stmt.setString(37,rsCustomerDetails.getString("CompanyName"));
				 stmt.setString(38,rsCustomerDetails.getString("ContactPerson"));
				 stmt.setString(39,rsCustomerDetails.getString("BillingAddress"));
				 stmt.setString(40,rsCustomerDetails.getString("BillingCity"));
				 stmt.setString(41,rsCustomerDetails.getString("BillingZip"));
				 stmt.setString(42,rsCustomerDetails.getString("BillingState"));
				 stmt.setString(43,rsCustomerDetails.getString("BillingCountry"));
				 stmt.setString(44,rsCustomerDetails.getString("BillingPhone"));
				 stmt.setString(45,rsCustomerDetails.getString("BillingFax"));
				 stmt.setString(46,SIRefNumber);
				 stmt.setString(47,rsDet.getString("SalesorderRefNo"));
				 stmt.setString(48,"0");
				 stmt.setString(49,"0");
				 stmt.setString(50,"0");
				 
		stmt.executeUpdate();
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "); 
		for(i=0;i<number;i++)
		{ 
			if(null!=request.getParameter("check"+i))
			{
					discount=request.getParameter("discountPercent"+i);
					tax=request.getParameter("STPercent"+i);
					quantity1=request.getParameter("quantity"+i);
					sellingprice=request.getParameter("sellingPrice"+i);
					description=request.getParameter("description"+i);
					System.out.println("DESCRIPTION  TTT    "+description);
					String mcode=request.getParameter("mcode"+i);
					String icode=request.getParameter("icode"+i);
					int no=Integer.parseInt(request.getParameter("gcode"+i));
					String tableToBeAccessed="";
					if(no< 5)
					{
						tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+mcode+"";
						System.out.println(tableToBeAccessed);
					}else  
						tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+rsDet.getString("TheGroup");
					
					String sqlItems=" INSERT INTO  "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items "+
							"(InvoiceNo ,TheGroup ,Make,ItemCode,Quantity ,SellingPrice ,DiscountPercent ,SONo,"+
							"TheTableToBeAccessed,ItemSRNo ,STPercent,ItemDescription) "+
							"VALUES ('"+SINumber+"','"+rsDet.getString("TheGroup")+"',"+
								"'"+mcode+"','"+icode+"','"+quantity1+"',"+
								"'"+sellingprice+"','"+discount+"','"+request.getParameter("SONumber").toString()+"'"+
								",'"+tableToBeAccessed+"','"+ i+1 +"','"+tax+"','"+description+"') ";
					System.out.println(sqlItems);
					st3.executeUpdate(sqlItems);
				
			}
		}
		
		String sqlUp="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det  set InvoiceGenerated='1'  where SalesOrderNo='"+request.getParameter("SONumber").toString()+"' limit 1  ";
		System.out.println(sqlUp);
		st.executeUpdate(sqlUp);
			
		int transactionId;
		String transactionNo="select MAX(TransactionId) from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount";
		ResultSet rsNo=st2.executeQuery(transactionNo);
		rsNo.next();
			transactionId=rsNo.getInt(1);
		transactionId++;
		System.out.println("TRAN   ID   IS "+transactionId);
		System.out.println("+++++++++++++++++++++++++++++++++                 =======================================");
		
		sqlAddition="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount(TransactionId,CustomerCode,TransactionType,TransactionDetail,TransactionDate,DebitAmount, "+
					" CreditAmount,Balance,EmpName,PaymentVoucherNo,DebitParty,CreditParty) "+
					
					" VALUES ("+transactionId+",'"+request.getParameter("customercode")+"','Invoice','"+SIRefNumber+"','"+todaysDate+"','"+request.getParameter("grandTotalN")+"', "+
					" '0','0','"+session.getAttribute("EmpName")+"','-','"+request.getParameter("company")+"' ,'Sales Account' )";
	
	    System.out.println(sqlAddition);
		st3.executeUpdate(sqlAddition); 
		
		System.out.println("+*************************************************************** *8");
	//	response.sendRedirect("alertGoTo.jsp?msg=INVOICE SUCCESFULLY SAVED.&goto=home.jsp");
	response.sendRedirect("alertGoTo.jsp?msg=Sales Invoice added successfully With Order No "+SIRefNumber+" .This will redirect you to print Invoice .&goto=Printsaleexpinvoice.jsp?transactionId="+SIRefNumber+"/"+currsym+"");
	}
		
		else if(istype.equalsIgnoreCase("proforma"))
		{
			
			String sqlProforma="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet " +
			"(" +
			"	InvoiceNo ,CustomerCode ,	InvoiceDate, TheGroup ,Total ," +
			"	Discount ,CST ,PFI ,FreightAmt ,GrandTotal, " +
			"	Terms, TotalInWords, 	PONo 	,PODate ,	DespatchMode ," +
			"	FreightType ,	PaymentMode ,	Insurance, ShippedBy ,ShipmentDate ," +
			"	DespCheckListCheckedBy ,PackingSlipCheckedBy ,DocketFilledBy,InvoiceCancelled ,	RevofInvoiceNo ," +
			"	NoofRevisions ,	ReasonForCancelling ,SEandSQRefNo,InvoiceTime,InvoiceRaisedby," +
			"	CurrType,CurrValue,TWSalesOrderNo ,DebitNote,TWEmpName, "+
			"	AddressCode,CompanyName,ContactPerson,Address,city," +
			"	Zip,State,country,Phone ,Fax, "+
			"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,InvoiceType , InvoicePrinted"+
			"	)"+
			"   Values(?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?"+
			")";
			System.out.println("else if proforma querry " +sqlProforma);
			
			
			java.sql.PreparedStatement stmt = con.prepareStatement( sqlProforma );
			 System.out.println(rsDet.getString("SalesOrderDate")+"Prop stmt "+request.getParameter("totalN").toString());
			 stmt.setString(1,Integer.toString(SIProNumber));
			 stmt.setString(2,rsCustomerDetails.getString("CustomerCode"));
			 stmt.setString(3,todaysDate);
			 stmt.setString(4,rsDet.getString("TheGroup"));
			 stmt.setString(5,request.getParameter("totalN").toString());
			 stmt.setString(6,"0");
			 stmt.setString(7,"0");
			 stmt.setString(8,request.getParameter("pfi").toString());
			 stmt.setString(9,request.getParameter("frieght").toString());
			 stmt.setString(10,request.getParameter("grandTotalN").toString());
			 stmt.setString(11,request.getParameter("terms").toString());
			 stmt.setString(12,request.getParameter("rupees").toString());
			 stmt.setString(13,request.getParameter("SONumber").toString());
			 stmt.setString(14,rsDet.getString("SalesOrderDate"));
			 stmt.setString(15,"-");
			 stmt.setString(16,request.getParameter("frieghtType").toString());
			 stmt.setString(17,request.getParameter("paymentMode").toString());
			 stmt.setString(18,request.getParameter("insurance").toString());
			 stmt.setString(19,request.getParameter("shippedBy").toString());
			 stmt.setString(20,shipmentDate);
			 stmt.setString(21,request.getParameter("checkedBy").toString());
			 stmt.setString(22,request.getParameter("packingSlipCheckedBy").toString());
			 stmt.setString(23,request.getParameter("docketFilledBy").toString());
			 stmt.setString(24,"0");
			 stmt.setString(25,"0");
			 stmt.setString(26,"0");
			 stmt.setString(27,"0");
			 stmt.setString(28,SESQnumber);
			 stmt.setString(29,todaysTime);
			 stmt.setString(30,request.getParameter("SIRaisedBy").toString());
			 stmt.setString(31,request.getParameter("currencyType").toString());
			 stmt.setString(32,"0");
			 stmt.setString(33,request.getParameter("SONumber").toString());
			 stmt.setString(34,"0");
			 stmt.setString(35,session.getAttribute("EmpName").toString());
			 stmt.setString(36,request.getParameter("addresscode").toString());
			 stmt.setString(37,rsCustomerDetails.getString("CompanyName"));
			 stmt.setString(38,rsCustomerDetails.getString("ContactPerson"));
			 stmt.setString(39,rsCustomerDetails.getString("BillingAddress"));
			 stmt.setString(40,rsCustomerDetails.getString("BillingCity"));
			 stmt.setString(41,rsCustomerDetails.getString("BillingZip"));
			 stmt.setString(42,rsCustomerDetails.getString("BillingState"));
			 stmt.setString(43,rsCustomerDetails.getString("BillingCountry"));
			 stmt.setString(44,rsCustomerDetails.getString("BillingPhone"));
			 stmt.setString(45,rsCustomerDetails.getString("BillingFax"));
			 stmt.setString(46,SPRefNumber);
			 stmt.setString(47,rsDet.getString("SalesorderRefNo"));
			 stmt.setString(48,"-");
			 stmt.setString(49,"OldTaxPInvoice");
			 stmt.setString(50,"No");
			 
			stmt.executeUpdate();
			
			for(i=0;i<number;i++)
			{ 
				System.out.println("IN FOR LOOP");
				if(null!=request.getParameter("check"+i))
				{
						discount=request.getParameter("discountPercent"+i);
						tax=request.getParameter("STPercent"+i);
						quantity1=request.getParameter("quantity"+i);
						sellingprice=request.getParameter("sellingPrice"+i);
						description=request.getParameter("description"+i);
						String mcode=request.getParameter("mcode"+i);
						String icode=request.getParameter("icode"+i);
						int no=Integer.parseInt(request.getParameter("gcode"+i));
						String tableToBeAccessed="";
						if(no< 5)
						{
							tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+mcode+"";
							System.out.println(tableToBeAccessed);
						}else 
							tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+rsDet.getString("TheGroup");
						
						
					String sqlProformaItems=" INSERT INTO  "+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items "+
					"(InvoiceNo ,TheGroup ,Make,ItemCode,Quantity ,SellingPrice ,DiscountPercent ,"+
					"TheTableToBeAccessed,SoNo,STPercent,ItemSrno ,ItemDescription,TaxType) "+
					"VALUES ('"+SIProNumber+"','"+rsDet.getString("TheGroup")+"',"+
					"'"+mcode+"','"+icode+"','"+quantity1+"',"+
					"'"+sellingprice+"','"+discount+"','"+tableToBeAccessed+"','"+request.getParameter("SONumber").toString()+"', "+
					"'"+tax+"','"+ i+1 +"','"+description+"','NIL') ";
					System.out.println("Proform item query " +sqlProformaItems);
				    st2.executeUpdate(sqlProformaItems);
				}
			}
			
			
			String sqlUpdate="";
			sqlUpdate="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det  set InvoiceGenerated='1'  where SalesOrderNo='"+request.getParameter("SONumber").toString()+"' limit 1  ";
			st3.executeUpdate(sqlUpdate);
			
			response.sendRedirect("alertGoTo.jsp?msg=PROFORMA INVOICE SUCCESFULLY SAVED.&goto=home.jsp");
			
		}		
		
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