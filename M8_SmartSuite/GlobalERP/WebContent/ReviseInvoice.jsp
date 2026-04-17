<%@page import="java.util.Date"%>
<%@page import="com.erp.beans.*"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
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
		st4=con.createStatement();
		
		int count=Integer.parseInt(request.getParameter("count").toString());
		String invcrefno=request.getParameter("invoicerefno");
		String custcode=request.getParameter("customercode");
		String invcdate=request.getParameter("invoicedate");
		
		String invctime=request.getParameter("invoicetime");
		String groupCode=request.getParameter("groupCode");
		String total=request.getParameter("total");
		String pfi=request.getParameter("pfi");
		String frieght=request.getParameter("frieght");
		String grandtotal=request.getParameter("grandTotal");
		String terms=request.getParameter("termsconditions");
		String amountinwords=request.getParameter("rupees");
		String pono=request.getParameter("pono");
		String PODate=request.getParameter("podate");
		String friType=request.getParameter("frieghtType");
		String paymentmode=request.getParameter("paymentMode");
		String insurance=request.getParameter("insurance");
		String shipby=request.getParameter("shippedBy");
		String docketfill=request.getParameter("docketfilledby");
		String deskchekedby=request.getParameter("checkedBy");
		String packslipby=request.getParameter("packingSlipCheckedBy");
		System.out.println("VALUE   *****   "+docketfill);
		String SESQnumber=request.getParameter("SESQrefno");
		String time=request.getParameter("invoicetime");
		
		
		
		String shipmentDate="";
		String abc=request.getParameter("dateOfShipment");
		System.out.println("DATE IS  DATE     IS     "+abc);
		if(abc=="")
		{
		   shipmentDate="0000:00:00";	
		}
		else 
		{
		shipmentDate=new SimpleDateFormat(
		"yyyy-MM-dd")
		.format(new SimpleDateFormat(
				"dd-MMM-yyyy")
				.parse(abc));
		}
		System.out.println("DATE IS  DATE     IS     "+shipmentDate);
	    
		String invoiceraisedby=request.getParameter("SIRaisedBy");
	    String salesorno=request.getParameter("SOno");
	    String addcode=request.getParameter("addresscode");
		String company=request.getParameter("company");
		String contactperson=request.getParameter("contact");
		String address=request.getParameter("address");
		String city=request.getParameter("city");
		String zip=request.getParameter("zip");
		String state=request.getParameter("state");
		String country=request.getParameter("country");
		String phone=request.getParameter("phone");
		String fax=request.getParameter("fax");
		String group=request.getParameter("group");
	    System.out.println("TYPE TYPE  "+addcode);
	    System.out.println("REVISING INVOICEEEE"+invcrefno);
	    String discount="",tax="";
	    String cgsttax="";
		String sgsttax="";
		String igsttax="";
		String cgsttaxamt="";
		String sgsttaxamt="";
		String igsttaxamt="";
		String quantity1="",sellingprice="";
				
		String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"invoicedet set InvoiceCancelled=1 where invoiceRefNo='"+invcrefno+"'";
		System.out.println(sqlUpdate);	
		st.executeUpdate(sqlUpdate);
		
		

		String sqlDelete="delete from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount  where TransactionDetail='"+invcrefno+"'";
			
			System.out.println("Deletion qry for customerLedgerAcnt "+sqlDelete);
			st1.executeUpdate(sqlDelete);
		
		LedgerUpdatation ld =new LedgerUpdatation();
		ld.calulation(custcode,session.getAttribute("CompanyMasterID").toString());
		
		int SINumber;
		String sqlOrderno="SELECT MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet ";
		ResultSet rs=st.executeQuery(sqlOrderno);
		rs.next();  
			SINumber=rs.getInt(1);
		SINumber++;
		
		String SIRefNumber="";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		try{
			Date today = new Date();
			SIRefNumber="SI";
      		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
			String sql3="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet  where invoiceRefNo like ('"+SIRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    rs=st1.executeQuery(sql3);
			  if(rs.next())
				  SIRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SIRefNumber+=date+"001";
			  
     	}catch(Exception e){
		      e.printStackTrace();		
		      }
     	
     	System.out.println("NEW INVOICE NUMBER==================>"+SIRefNumber);
     	
     	String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
		ResultSet rsdata123=st.executeQuery(companydata);
		rsdata123.next();
		String companyname=rsdata123.getString("Companyname");
		String address123=rsdata123.getString("address");
		String phone123=rsdata123.getString("phone");
		String mail=rsdata123.getString("emailid");
		String website=rsdata123.getString("website");
		 fax=rsdata123.getString("fax");
		String godownaddress=rsdata123.getString("godownaddress");  
		
		String con1="Tel: "+phone123+"  Fax: "+fax+"  "+mail+"  "+website+"";
		
		String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"invoicedet (InvoiceNo ,CustomerCode ,	InvoiceDate, TheGroup ,Total ," +
		"	Discount ,CST ,PFI ,FreightAmt ,GrandTotal, " +
		"	Terms, TotalInWords, 	PONo 	,PODate ,	DespatchMode ," +
		"	FreightType ,	PaymentMode ,	Insurance, ShippedBy ,ShipmentDate ," +
		"	DespCheckListCheckedBy ,PackingSlipCheckedBy ,DocketFilledBy,InvoiceCancelled ,	RevofInvoiceNo ," +
		"	NoofRevisions ,	ReasonForCancelling ,SEandSQRefNo,InvoiceTime,InvoiceRaisedby," +
		"	CurrType,CurrValue,TWSalesOrderNo ,DebitNote,TWEmpName, "+
		"	AddressCode,CompanyName,ContactPerson,Address,city," +
		"	Zip,State,country,Phone ,Fax, "+
		"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,SalesInTransit ,VATdeclaration,UpdatedinTally ,InvoiceType ,InvoicePrinted,InvRaisedBillAdd, InvRaisedShipAdd, InvRaisedConDet,InvRaisedCompName ) "+
		

		"   Values ('"+SINumber+"','"+custcode+"','"+invcdate+"','"+groupCode+"','"+total+"', "+
		"  '0.00','0.00','"+pfi+"','"+frieght+"','"+grandtotal+"', "+ 
		"  '"+terms+"','"+amountinwords+"','"+pono+"','"+PODate+"','-',"+
		"  '"+friType+"','"+paymentmode+"','"+insurance+"','"+shipby+"','"+shipmentDate+"', "+
		"  '"+deskchekedby+"','"+packslipby+"','"+docketfill+"','0','0',"+
		"  '0','-','"+SESQnumber+"','"+time+"','"+invoiceraisedby+"',"+
		"  'Rupees','1','"+salesorno+"','-','"+session.getAttribute("EmpName")+"',"+
		"  '"+addcode+"','"+company+"','"+contactperson+"','"+address+"','"+city+"', "+
		"  '"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"',"+ 
		"  '"+SIRefNumber+"' ,'0','"+invcrefno+"','-','-','NO','OldTaxInvoice','NO','"+address123+"','"+godownaddress+"','"+con1+"','"+companyname+"') ";
		
		
		System.out.println(sqlInsert);
		st2.executeUpdate(sqlInsert);
		
		double TotTax=0.00;
		double TaxAmt=0.00;
		double TotTaxCGST=0.00;
		double TotTaxSGST=0.00;
		double TotTaxIGST=0.00;
		double TaxIGSTamt=0.00;
		double TaxCGSTamt=0.00;
		double TaxSGSTamt=0.00;
		
		String SACCode="",HSNCode="";
		
		for(i=0;i<count;i++)
		{
			
			System.out.println(" IN LOOPPPPP ");
			
			String gcode=request.getParameter("gcode"+i);
			String mcode=request.getParameter("mcode"+i);
			discount=request.getParameter("discountPercent"+i);
			tax=request.getParameter("STPercent"+i);
			quantity1=request.getParameter("quantity"+i);
			sellingprice=request.getParameter("sellingPrice"+i);
			System.out.println("sellingprice sellingprice "+sellingprice);
			if(sellingprice==null)
			{
				sellingprice="0.00";
			}
			//description=request.getParameter("description"+i);
			cgsttax=request.getParameter("CGST"+i);
			sgsttax=request.getParameter("SGST"+i);
			igsttax=request.getParameter("IGST"+i);
			SACCode=request.getParameter("SACCode");
			HSNCode=request.getParameter("HSNCode");
			
			double cgsttaxrate=Double.parseDouble(cgsttax);
			double sgsttaxrate=Double.parseDouble(sgsttax);
			double igsttaxrate=Double.parseDouble(igsttax);
			
			double amt=(Double.parseDouble(sellingprice)*Double.parseDouble(quantity1)) - Double.parseDouble(discount);
			
			double CGSTTaxAmt=amt*(cgsttaxrate/100);
			double SGSTTaxAmt=amt*(sgsttaxrate/100);
			double IGSTTaxAmt=amt*(igsttaxrate/100);
			
			System.out.println(" Indiv Item Amt :- "+amt);
			TaxCGSTamt=CGSTTaxAmt;
			TaxSGSTamt=SGSTTaxAmt;
			TaxIGSTamt=IGSTTaxAmt;
			
		    TaxAmt=CGSTTaxAmt+SGSTTaxAmt+IGSTTaxAmt;
		    
		    System.out.println(" Indiv Item Tax :- "+TaxAmt);
		    
			int no=Integer.parseInt(gcode);
			String tableToBeAccessed="";
			if(no< 5)
			{
				tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
		
			}else 
				tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;	
			
		
		String icode=request.getParameter("icode"+i);
		
		
		
		String descrp=request.getParameter("description"+i);
		String amount=request.getParameter("amount"+i);
		
		String sqlIn="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items(InvoiceNo,TheGroup ,Make ,ItemCode ,Quantity ,SellingPrice ,DiscountPercent ,SONo ,TheTableToBeAccessed ,TheOptionNo ,InsertOR ,ItemSRNo ,STPercent ,ItemDescription ,TaxType,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) Values ('"+SINumber+"','"+gcode+"','"+mcode+"','"+icode+"','"+quantity1+"','"+sellingprice+"','"+discount+"', "+
					 "  '"+salesorno+"','"+tableToBeAccessed+"','0','-','0','"+tax+"','"+descrp+"','NIL','"+HSNCode+"','"+SACCode+"','"+cgsttax+"','"+CGSTTaxAmt+"','"+sgsttax+"','"+SGSTTaxAmt+"','"+igsttax+"','"+IGSTTaxAmt+"')";
		System.out.println(sqlIn);
		st3.executeUpdate(sqlIn);
		
		}
			
		String sql="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det set InvoiceGenerated='1' where SalesOrderNo='"+salesorno+"' limit 1  ";
		System.out.println(sql);
		st.executeUpdate(sql);
		
		int transactionId;
		String transactionNo="select MAX(TransactionId) from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount";
		ResultSet rsNo=st2.executeQuery(transactionNo);
		rsNo.next();
			transactionId=rsNo.getInt(1);
		transactionId++;
		System.out.println("TRAN   ID   IS "+transactionId);
		System.out.println("+++++++++++++++++++++++++++++++++                 =======================================");
		
		String sqlAddition="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount(TransactionId,CustomerCode,TransactionType,TransactionDetail,TransactionDate,DebitAmount, "+
					" CreditAmount,Balance,EmpName,PaymentVoucherNo,DebitParty,CreditParty) "+
					
					" VALUES ("+transactionId+",'"+request.getParameter("customercode")+"','Invoice','"+SIRefNumber+"','"+todaysDate+"','"+request.getParameter("grandTotal")+"', "+
					" '0','0','"+session.getAttribute("EmpName")+"','-','"+request.getParameter("company")+"' ,'Sales Account' )";
	
	    System.out.println(sqlAddition);
		st3.executeUpdate(sqlAddition); 
				
		//response.sendRedirect("alertGoTo.jsp?msg=Sales Invoice Revised Successfully &goto=home.jsp");
		response.sendRedirect("alertgoToIDPage.jsp?msg=Sales Invoice Revised Successfully.&goto=showinvoicelist.jsp&id=revise");
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