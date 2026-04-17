<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,ST123=null,st7=null,st8=null;
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
		st5=con.createStatement();
		st7=con.createStatement();
		st8=con.createStatement();
		ST123=con.createStatement();
		
		int count=Integer.parseInt(request.getParameter("count").toString());
		//int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
		
		System.out.println("count is -->>>>>>>" + count);
		
		
		String invcrefno=request.getParameter("invoicerefno");
		String custcode=request.getParameter("customercode");
		String invcdate=request.getParameter("invoicedate");
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_MONTH, -30);
		/* String SODF=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(SOD));	
 */
 String DOS=new SimpleDateFormat("dd-MMM-yyyy").format(cal
			.getTime());
		String SOD1= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(DOS));

		 
		 /* if(SON1==null | SON1==" " | SON1==""| SON1=="null")
		{
			SON1="-";
		}
		else
		{SP080419009
			SON1=request.getParameter("SON");
		}
		 */
		 
		
		System.out.println("SOD is -------------->>" + SOD1);
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
		String shipby=request.getParameter("shipBy");
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
		String contactperson=request.getParameter("conatctperson");
		String address=request.getParameter("address");
		String city=request.getParameter("city");
		String zip=request.getParameter("zip");
		String state=request.getParameter("state");
		String country=request.getParameter("country");
		String phone=request.getParameter("phone");
		String fax=request.getParameter("fax");
		String group=request.getParameter("group");
	    System.out.println("TYPE TYPE  "+addcode);
		
	    String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
        ResultSet rsdata241= ST123.executeQuery(companydata);
        rsdata241.next();
        String companyname1=rsdata241.getString("Companyname");
        String address1=rsdata241.getString("address");
        String phone1=rsdata241.getString("phone");
        String mail1=rsdata241.getString("emailid");
        String website1=rsdata241.getString("website");
        String fax1=rsdata241.getString("fax");
        String godownaddress1=rsdata241.getString("godownaddress");	      
        String SON1=request.getParameter("SON");
		if(SON1==null | SON1==" " | SON1==""| SON1=="null")
		{
			SON1="-";
		}
		else
		{
			SON1=request.getParameter("SON");
		}	
		System.out.println("SON is -------------->>" + SON1);
		String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet set InvoiceCancelled=1 where invoiceRefNo='"+invcrefno+"' 	";
		System.out.println(sqlUpdate);	
		st.executeUpdate(sqlUpdate);
		
		int SINumber;
		String sqlOrderno="SELECT MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet";
		ResultSet rs=st.executeQuery(sqlOrderno);
		rs.next();  
			SINumber=rs.getInt(1);
		SINumber++;
		
		String SIRefNumber="";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		try{
			Date today = new Date();
			SIRefNumber="SP";
      		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
			String sql3="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  where invoiceRefNo like ('"+SIRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    rs=st1.executeQuery(sql3);
			  if(rs.next())
				  SIRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SIRefNumber+=date+"001";
			  
     	}catch(Exception e)
     	{
		      e.printStackTrace();		
		}
     	
		System.out.println("NEW INVOICE NUMBER==================>"+SIRefNumber);
		String TheGroup="",SalesOrderDate="",SalesorderRefNo="";
		
     	String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesOrderNo='"+ request.getParameter("SOno") + "' ";
     	System.out.println("ORDER NO QUERYT   "+sqlDet);
		ResultSet rsDet = st1.executeQuery(sqlDet);
		if(!rsDet.next())
		{
			System.out.println("In IF ");
			
			TheGroup="3";
			SalesOrderDate=""+todaysDate;
			SalesorderRefNo="-";
			SESQnumber="-";
		}
		else
		{
			TheGroup=rsDet.getString("TheGroup");
			SalesOrderDate=rsDet.getString("SalesOrderDate");
			SalesorderRefNo=rsDet.getString("SalesorderRefNo");
			
			/* String sqlQuotationDet="SELECT TWSalesRefNo from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+rsDet.getInt("SalesQuoNo")+"' ";
			System.out.println("QUERTY PRINTGGG   "+sqlQuotationDet);
			ResultSet rsQuotaionDet=st2.executeQuery(sqlQuotationDet);
			rsQuotaionDet.next();
			SESQnumber=rsQuotaionDet.getString(1);
			System.out.println("++++++++++++++++++++++++++++++++++++++++++======");
		 */}
		
     			
		String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet (InvoiceNo ,CustomerCode ,InvoiceDate, TheGroup ,Total ," +
		"	Discount ,CST ,PFI ,FreightAmt ,GrandTotal, " +
		"	Terms, TotalInWords, 	PONo 	,PODate ,	DespatchMode ," +
		"	FreightType ,	PaymentMode ,	Insurance, ShippedBy ,ShipmentDate ," +
		"	DespCheckListCheckedBy ,PackingSlipCheckedBy ,DocketFilledBy,InvoiceCancelled ,	RevofInvoiceNo ," +
		"	NoofRevisions ,	ReasonForCancelling ,SEandSQRefNo,InvoiceTime,InvoiceRaisedby," +
		"	CurrType,CurrValue,TWSalesOrderNo ,DebitNote,TWEmpName, "+
		"	AddressCode,CompanyName,ContactPerson,Address,city," +
		"	Zip,State,country,Phone ,Fax, "+
		"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,InvoiceType ,InvoicePrinted, CustPurON, CustPurDT, InvRaisedBillAdd, InvRaisedShipAdd, InvRaisedConDet,InvRaisedCompName ) "+
		
		"   Values ('"+SINumber+"','"+custcode+"','"+invcdate+"','"+groupCode+"','"+total+"', "+
		"  '0.00','0.00','"+pfi+"','"+frieght+"','"+grandtotal+"', "+ 
		"  '"+terms+"','"+amountinwords+"','"+pono+"','"+rsDet.getString("SalesOrderDate")+"','-',"+
		"  '"+friType+"','"+paymentmode+"','"+insurance+"','"+shipby+"','"+shipmentDate+"', "+
		"  '"+deskchekedby+"','"+packslipby+"','"+docketfill+"','0','0',"+
		"  '0','-','"+SESQnumber+"','"+time+"','"+invoiceraisedby+"',"+
		"  'Rupees','1','"+salesorno+"','-','"+session.getAttribute("EmpName")+"',"+
		"  '"+addcode+"','"+company+"','"+contactperson+"','"+address+"','"+city+"', "+
		"  '"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"',"+ 
		"  '"+SIRefNumber+"' ,'"+rsDet.getString("SalesorderRefNo")+"','"+invcrefno+"','OldTaxInvoice','NO','"+rsDet.getString("CustPurON")+"','"+rsDet.getString("CustPurDT")+"','"+rsdata241.getString("address")+"','"+rsdata241.getString("godownaddress")+"','Tel: "+rsdata241.getString("phone")+"  Fax: "+rsdata241.getString("fax")+"  "+rsdata241.getString("emailid")+"  "+rsdata241.getString("website")+"','"+rsdata241.getString("Companyname")+"') ";
				
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
		String sqlAddition="";
		String SACCode="",HSNCode="";
		String tax1="";
		String cgsttax="";
		String sgsttax="";
		String igsttax="";
		String cgsttaxamt="";
		String sgsttaxamt="";
		String igsttaxamt="";
		String sellingprice="";
		String discount1="1";
		
		for(i=0;i<count;i++)
		{
			
			
			System.out.println(" IN LOOPPPPP ");
			String icode=request.getParameter("itemcode"+i);
			String quant=request.getParameter("quantity"+i);
			tax1=request.getParameter("stpercent"+i);
			discount1=request.getParameter("discount"+i);
			sellingprice=request.getParameter("sellingprice"+i);
			String descrp=request.getParameter("description"+i);
			String amount=request.getParameter("amount"+i);
			String gcode=request.getParameter("groupcode"+i);
			String mcode=request.getParameter("makecode"+i);
			String SqlQuoDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet WHERE invoiceRefNo='"+invcrefno+"' ";
			System.out.println(">>>>>>>>>>>      "+SqlQuoDet);
			ResultSet rsInvDet=st7.executeQuery(SqlQuoDet);
				if(rsInvDet.next()){

			String sqlInvItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items WHERE InvoiceNo='"+rsInvDet.getString("InvoiceNo")+"'";
			System.out.println(sqlInvItems);
			ResultSet rsInvItems=st8.executeQuery(sqlInvItems);
			rsInvItems.next();
			  
			SACCode=rsInvItems.getString("SACCode");	

			HSNCode=rsInvItems.getString("HSNCode");
			cgsttax=rsInvItems.getString("CGSTRate");
			sgsttax=rsInvItems.getString("SGSTRate");
			igsttax=rsInvItems.getString("IGSTRate");
			
				}

			
			 
			System.out.println("gcode is :--->>" + gcode);
			System.out.println("mcode is :--->>" + mcode);
			
			System.out.println("SACCode is :--->>" + SACCode);
			System.out.println("HSNCode is :--->>" + HSNCode);
			
			System.out.println("cgsttax is :--->>" + cgsttax);
			
			System.out.println("sgsttax is :--->>" + sgsttax);
			
			System.out.println("igsttax is :--->>" + igsttax);
			System.out.println("icode is :--->>" + icode);
			 System.out.println("quant is :--->>" + quant);
			 System.out.println("tax1 is :--->>" + tax1);
			 System.out.println("discount1 is :--->>" + discount1);
			 System.out.println("sellingprice is :--->>" + sellingprice);
			 System.out.println("description is :--->>" + descrp);
			 System.out.println("amount is :--->>" + amount);
				
		 double cgsttaxrate=Double.parseDouble(cgsttax);
			double sgsttaxrate=Double.parseDouble(sgsttax);
			double igsttaxrate=Double.parseDouble(igsttax);
									
			double amt=(Double.parseDouble(sellingprice)*Double.parseDouble(quant)) - Double.parseDouble(discount1);
									
			double CGSTTaxAmt=amt*(cgsttaxrate/100);
			double SGSTTaxAmt=amt*(sgsttaxrate/100);
			double IGSTTaxAmt=amt*(igsttaxrate/100);


			
			System.out.println(" Indiv Item Amt :- "+amt);
			TaxCGSTamt=CGSTTaxAmt;
			TaxSGSTamt=SGSTTaxAmt;
			TaxIGSTamt=IGSTTaxAmt;
			
		    TaxAmt=CGSTTaxAmt+SGSTTaxAmt+IGSTTaxAmt;
		    
		    String TaxAmtStr="";
		    
		    TaxAmtStr=new DecimalFormat("0.00").format(TaxAmt);
		    
		    System.out.println(" Indiv Item Tax :- "+TaxAmtStr);
		    

			int no=Integer.parseInt(gcode);
			
			System.out.println("gcode is :--->>" + gcode);
			System.out.println("mcode is :--->>" + mcode);
			System.out.println("SACCode is :--->>" + SACCode);
			System.out.println("HSNCode is :--->>" + HSNCode);
			
			System.out.println("cgsttax is :--->>" + cgsttax);
			System.out.println("cgsttaxrate is :--->>" + cgsttaxrate);
			System.out.println("sgsttaxrate is :--->>" + sgsttaxrate);
			System.out.println("igsttaxrate is :--->>" + igsttaxrate);
			
			System.out.println("amt is :--->>" + amt);
			System.out.println("CGSTTaxAmt is :--->>" + CGSTTaxAmt);
			System.out.println("SGSTTaxAmt is :--->>" + SGSTTaxAmt);
			System.out.println("IGSTTaxAmt is :--->>" + IGSTTaxAmt);
			
			System.out.println("sgsttax is :--->>" + sgsttax);
			
			System.out.println("igsttax is :--->>" + igsttax);
			System.out.println("icode is :--->>" + icode);
			 System.out.println("quant is :--->>" + quant);
			 System.out.println("tax1 is :--->>" + tax1);
			 System.out.println("discount1 is :--->>" + discount1);
			 System.out.println("sellingprice is :--->>" + sellingprice);
			 System.out.println("description is :--->>" + descrp);
			 
			 System.out.println("amount is :--->>" + amount);
			String tableToBeAccessed="";
			if(no< 5)
			{
				tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
		
			}else 
				tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;	
			
		
			 
			 
			 
		    String sqlIn="Insert into "+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items(InvoiceNo,TheGroup ,Make ,ItemCode ,Quantity ,SellingPrice ,DiscountPercent ,"+
				   " TheTableToBeAccessed ,SoNo ,STPercent ,ItemSrno , ItemDescription ,TaxType,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) "+
					 
				   " Values('"+SINumber+"','"+gcode+"','"+mcode+"','"+icode+"','"+quant+"','"+sellingprice+"','"+discount1+"', "+
				   " '"+tableToBeAccessed+"', '"+salesorno+"','"+tax1+"','"+ i+1 +"','"+descrp+"','NIL','"+HSNCode+"','"+SACCode+"','"+cgsttax+"','"+CGSTTaxAmt+"','"+sgsttax+"','"+SGSTTaxAmt+"','"+igsttax+"','"+IGSTTaxAmt+"')";
		    System.out.println(sqlIn);
		    st3.executeUpdate(sqlIn);
		
		}
			
		TotTaxCGST=TotTaxCGST+TaxCGSTamt;
		TotTaxSGST=TotTaxSGST+TaxSGSTamt;
		TotTaxIGST=TotTaxIGST+TaxIGSTamt;
		TotTax=TotTax+TaxAmt; 
		
		
		
		System.out.println(" Total CGSTTax :- "+TotTaxCGST);
		System.out.println(" Total SGSTTax :- "+TotTaxSGST);
		System.out.println(" Total IGSTTax :- "+TotTaxIGST);
		System.out.println(" Total Tax :- "+TotTax);
		
		String sql="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det set InvoiceGenerated='1' where SalesOrderNo='"+salesorno+"' limit 1  ";
		System.out.println(sql);
		st.executeUpdate(sql);
		

		String updategsttax = "update " + session.getAttribute("CompanyMasterID").toString()
				+ "performainvoicedet set CGSTValue='" + TotTaxCGST + "' ,CGSTRate='" + cgsttax
				+ "',SGSTRate='" + sgsttax + "', IGSTRate='" + igsttax + "', SGSTValue='" + TotTaxSGST
				+ "' ,IGSTValue='" + TotTaxIGST + "',HSNCode='" + HSNCode + "',SACCode='" + SACCode
				+ "' where invoiceRefNo='" + SIRefNumber + "'";

		System.out.println("Invoice Update :- " + updategsttax);

		st4.executeUpdate(updategsttax);

		String sqlBalance1 = "SELECT * FROM  " + session.getAttribute("CompanyMasterID").toString()
				+ "customerledgeraccount where CustomerCode=" + request.getParameter("customercode")
				+ " order by TransactionId DESC limit 1";

		ResultSet rsbalance1 = st1.executeQuery(sqlBalance1);
		System.out.println("sql" + sqlBalance1);

		double balance1 = 0, invcamount1 = 0;
		String invcamount = request.getParameter("grandTotal").toString();
		invcamount1 = Double.parseDouble(invcamount);
		//double debitamount1=0;
		//double creditamount1=0;
		//double transactionid1=0;
		if (rsbalance1.next()) {
			//transactionid1=rsbalance.getDouble("transactionid");
			//debitamount1=rsbalance.getDouble("debitamount");
			//creditamount1=rsbalance.getDouble("creditamount");
			balance1 = rsbalance1.getDouble("Balance");
			balance1 = invcamount1 + balance1;

		} else {
			balance1 = balance1 + invcamount1;
		}

		int transactionId;

		String transactionNo = "select MAX(TransactionId) from "
				+ session.getAttribute("CompanyMasterID").toString() + "customerledgeraccount";
		ResultSet rsNo = st2.executeQuery(transactionNo);
		rsNo.next();
		transactionId = rsNo.getInt(1);
		transactionId++;

		System.out.println("TRAN   ID   IS " + transactionId);

		System.out.println(
				"+++++++++++++++++++++++++++++++++                 =======================================");

		String differ = "SELECT DATEDIFF(now(),'2018-11-01') as DATEDIFF";
		ResultSet rsdiffer = st5.executeQuery(differ);

		int diff = 0;
		if (rsdiffer.next()) {
			diff = rsdiffer.getInt("DATEDIFF");
		}
		if (diff >= 0) {

			sqlAddition = "INSERT INTO " + session.getAttribute("CompanyMasterID").toString()
					+ "customerledgeraccount(TransactionId,CustomerCode,TransactionType,TransactionDetail,TransactionDate,DebitAmount, "
					+ " CreditAmount,Balance,EmpName,PaymentVoucherNo,DebitParty,CreditParty) " +

					" VALUES (" + transactionId + ",'" + request.getParameter("customercode")
					+ "','ProFormaInvoice','" + SIRefNumber + "','" + todaysDate + "','"
					+ request.getParameter("grandTotal") + "', " + " '0','" + balance1 + "','"
					+ session.getAttribute("EmpName") + "','-','" + request.getParameter("company")
					+ "' ,'Sales Account' )";

			System.out.println("Ledger Insert :- " + sqlAddition);

			st3.executeUpdate(sqlAddition);

		} else {

		}

		
				
		response.sendRedirect("alertGoTo.jsp?msg=Sales ProForma Invoice Has Been Revised Successfully &goto=home.jsp");
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