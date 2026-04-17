<%@page import="java.util.Date"%>
<%-- <%@page import="com.erp.beans.LedgerUpdatation"%> --%>
<%@ include file="conn.jsp"%>

<script>


function Redirect11()
{
	
	//alert('Contract Updated  ','','success');
		  var value1=document.getElementById("SPRefNumber").value;
		 // alert(value1);
var value2=document.getElementById("SIProNumber").value;
//alert(value2);

var value3=document.getElementById("view").value;
//alert(value3);

 window.location.href="detailForProInvoice.jsp?InvoiceRefNo="+value1+"&Invoiceno="+value2+"&condition="+value3;
 
	    
	
}


function Redirect1()
{
	
	//alert('Contract Updated  ','','success');
		  var value1=document.getElementById("SIRefNumber").value;
		 // alert(value1);
var value2=document.getElementById("SINumber").value;
//alert(value2);

var value3=document.getElementById("view").value;
//alert(value3);

 window.location.href="viewInvoice.jsp?InvoiceRefNo="+value1+"&Invoiceno="+value2+"&condition="+value3;
 
	    
	
}

</script>
<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,ST123=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String companyid="";
	String view="View";
	
%>

<%
	
	try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();
		ST123=con.createStatement();
		
		 String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
         ResultSet rsdata241= ST123.executeQuery(companydata);
         rsdata241.next();
         String companyname=rsdata241.getString("Companyname");
         String address=rsdata241.getString("address");
         String phone=rsdata241.getString("phone");
         String mail=rsdata241.getString("emailid");
         String website=rsdata241.getString("website");
         String fax=rsdata241.getString("fax");
         String godownaddress=rsdata241.getString("godownaddress");	      
		 companyid=session.getAttribute("CompanyMasterID").toString();
		
		
		int i=0;
		int a=0;
		double total=Double.parseDouble(request.getParameter("total").toString());
		double pfi=Double.parseDouble(request.getParameter("pfi").toString());
		
		String fdate=request.getParameter("fromdate");
		fdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fdate));

 		System.out.println("fdate  "+fdate);

 		
		String tdate=request.getParameter("todate");
		tdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tdate));

 		System.out.println("tdate  "+tdate);

		String ddate=request.getParameter("due_date");
		ddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(ddate));

 		System.out.println("ddate  "+ddate);


		
		
		double pfi1=Math.round(total*pfi/100);
		String sqlAddition="";
		String salesorderno="",custsalesorderno="";
		String salesorderdate="",salesordertime="";
		String discount="1",tax="";
		String cgsttax="";
		String sgsttax="";
		String igsttax="";
		String cgsttaxamt="";
		String sgsttaxamt="";
		String igsttaxamt="";
		
		String quantity1="",sellingprice="";
		String description="";
		String SON=request.getParameter("SON");
		String SOD=request.getParameter("SOD");
		String del=request.getParameter("del");
		
 		System.out.println("SON  "+SON);


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
			 
			SIRefNumber="SI";

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
			 
			SPRefNumber="SP";

			String date =  new SimpleDateFormat("ddMMyy").format(new Date());

			String sql4="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  where invoiceRefNo like ('"+SPRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    rs=st3.executeQuery(sql4);
			    System.out.println(sql4);
			  if(rs.next())
				  SPRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SPRefNumber+=date+"001";
			    System.out.println("SPRefNumber "+SPRefNumber);

		}catch(Exception e){
		e.printStackTrace();		
		}
		%>
							<input type="hidden" name="SPRefNumber"  id="SPRefNumber" value="<%=SPRefNumber%>"></input>
							<input type="hidden" name="SIProNumber"  id="SIProNumber" value="<%=SIProNumber%>"></input>
														<input type="hidden" name="SINumber"  id="SINumber" value="<%=SINumber%>"></input>
																					<input type="hidden" name="SIRefNumber"  id="SIRefNumber" value="<%=SIRefNumber%>"></input>
							
									<input type="hidden" name="view"  id="view" value="<%=view%>"></input>
		
		<%
		
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
			System.out.println("+INNNNNNNNNNNNNNNNNNNN=");	

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
        			"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,SalesInTransit ,VATdeclaration ,"+ 
        			"   CustPurNO, CustPurDT, InvRaisedBillAdd, InvRaisedShipAdd, InvRaisedConDet,InvRaisedCompName,Fromdate,ToDate,DueDate,DeliveryDate"+
        			"	)"+
        			"   Values(?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,"+
        					  "?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?"+
        			")";

				 java.sql.PreparedStatement stmt = con.prepareStatement( sqlmain );
				 System.out.println(rsDet.getString("SalesOrderDate")+"Prop stmt "+request.getParameter("total").toString());
				 stmt.setString(1,Integer.toString(SINumber));
				 stmt.setString(2,rsCustomerDetails.getString("CustomerCode"));
				 stmt.setString(3,todaysDate);
				 stmt.setString(4,rsDet.getString("TheGroup"));
				 stmt.setString(5,request.getParameter("total").toString());
				 stmt.setString(6,"0");
				 stmt.setString(7,"0");
				 stmt.setString(8,request.getParameter("pfi").toString());
				 stmt.setString(9,request.getParameter("frieght").toString());
				 stmt.setString(10,request.getParameter("grandTotal").toString());
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
				 stmt.setString(30,companyname);
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
				 stmt.setString(51,SON);
				 stmt.setString(52,SOD);
				 stmt.setString(53,address);
				 stmt.setString(54,godownaddress);
				 stmt.setString(55,"Tel: "+phone+"  Fax: "+fax+"  "+mail+"  "+website);
				 stmt.setString(56,companyname);
				 stmt.setString(57,fdate);
				 stmt.setString(58,tdate);
				 stmt.setString(59,ddate);
				 stmt.setString(60,del);

				 System.out.println("Invoice det query:-  ");
		stmt.executeUpdate();
		System.out.println("%%%%%%%%%%%%%%%%&&&&&&&&&&& "+sqlmain);
		double TotTax=0.00;
		double TaxAmt=0.00;
		double TotTaxCGST=0.00;
		double TotTaxSGST=0.00;
		double TotTaxIGST=0.00;
		double TaxIGSTamt=0.00;
		double TaxCGSTamt=0.00;
		double TaxSGSTamt=0.00;
		
		String SACCode="",HSNCode="";
		for(i=0;i<number;i++)
		{ 
			if(null!=request.getParameter("check"+i))
			{
					discount=request.getParameter("discountPercent"+i);
					tax=request.getParameter("STPercent"+i);
					quantity1=request.getParameter("quantity"+i);
					sellingprice=request.getParameter("sellingPrice"+i);
					description=request.getParameter("description"+i);
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
							"TheTableToBeAccessed,ItemSRNo ,STPercent,ItemDescription,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) "+
							"VALUES ('"+SINumber+"','"+rsDet.getString("TheGroup")+"',"+
								"'"+mcode+"','"+icode+"','"+quantity1+"',"+
								"'"+sellingprice+"','"+discount+"','"+request.getParameter("SONumber").toString()+"'"+
								",'"+tableToBeAccessed+"','"+ i+1 +"','"+tax+"','"+description+"','"+HSNCode+"','"+SACCode+"','"+cgsttax+"','"+CGSTTaxAmt+"','"+sgsttax+"','"+SGSTTaxAmt+"','"+igsttax+"','"+IGSTTaxAmt+"'); ";
					System.out.println("Ivoice Items :- "+sqlItems);
					st3.executeUpdate(sqlItems);
				
			}
			TotTaxCGST=TotTaxCGST+TaxCGSTamt;
			TotTaxSGST=TotTaxSGST+TaxSGSTamt;
			TotTaxIGST=TotTaxIGST+TaxIGSTamt;
			TotTax=TotTax+TaxAmt;
		}
		System.out.println(" Total CGSTTax :- "+TotTaxCGST);
		System.out.println(" Total SGSTTax :- "+TotTaxSGST);
		System.out.println(" Total IGSTTax :- "+TotTaxIGST);
		System.out.println(" Total Tax :- "+TotTax);
		
		String sqlUp="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det  set InvoiceGenerated='1'  where SalesOrderNo='"+request.getParameter("SONumber").toString()+"' limit 1  ";
		System.out.println(sqlUp);
		st.executeUpdate(sqlUp);
			
		String updategsttax="update "+session.getAttribute("CompanyMasterID").toString()+"invoicedet set CGSTValue='"+TotTaxCGST+"' , SGSTValue='"+TotTaxSGST+"' ,IGSTValue='"+TotTaxIGST+"' where invoiceRefNo='"+SIRefNumber+"' ";
		
		System.out.println("Invoice Update :- "+updategsttax);
		
		st4.executeUpdate(updategsttax);
		
		String sqlBalance1="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode="+request.getParameter("customercode")+" order by TransactionId DESC limit 1";

		ResultSet rsbalance1=st1.executeQuery(sqlBalance1);
		System.out.println("sql"+sqlBalance1);
		
		double balance1 = 0,invcamount1=0;
		String invcamount=request.getParameter("grandTotal").toString();
		invcamount1=Double.parseDouble(invcamount);
		//double debitamount1=0;
		//double creditamount1=0;
		//double transactionid1=0;
		if(rsbalance1.next())
		{
			//transactionid1=rsbalance.getDouble("transactionid");
			//debitamount1=rsbalance.getDouble("debitamount");
			//creditamount1=rsbalance.getDouble("creditamount");
			balance1=rsbalance1.getDouble("Balance");
			balance1=invcamount1+balance1;
											
		}
		else
		{
			balance1=balance1+invcamount1;
		}	
		
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
					
					" VALUES ("+transactionId+",'"+request.getParameter("customercode")+"','Invoice','"+SIRefNumber+"','"+todaysDate+"','"+request.getParameter("grandTotal")+"', "+
					" '0','"+balance1+"','"+session.getAttribute("EmpName")+"','-','"+request.getParameter("company")+"' ,'Sales Account' )";
	
	    System.out.println(sqlAddition);
		st3.executeUpdate(sqlAddition); 
		
		    /* LedgerUpdatation ld =new LedgerUpdatation();
	ld.calulation(request.getParameter("customercode"),session.getAttribute("CompanyMasterID").toString()); */ 
		System.out.println("+*************************************************************** *8");
	//	response.sendRedirect("alertGoTo.jsp?msg=INVOICE SUCCESFULLY SAVED.&goto=home.jsp");
	
	//response.sendRedirect("alertGoTo.jsp?msg=Sales Invoice added successfully With Order No "+SIRefNumber+" .This will redirect you to print Invoice .&goto=printSalesInvoice.jsp?transactionId="+SIRefNumber+"");
	
	
				out.println("<script>  Redirect1();</script>");		

/* 	response.sendRedirect("http://aps.mobileeye.in:8181/GlobalERP/PaymentLink.jsp?transactionId="+SIRefNumber+"&CompanyMasterID="+companyid+"");
 */	
	}
		
		else if(istype.equalsIgnoreCase("proforma"))
		{
			
			System.out.println("+INNNNNNNNNNNNNNNNNNNNellllllllllll=");	

			sqlAddition="";
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
			"	invoiceRefNo, TWSalesorderRefNo ,RevOfinvoiceRefNo ,InvoiceType , InvoicePrinted, CustPurON, CustPurDT, InvRaisedBillAdd, InvRaisedShipAdd, InvRaisedConDet,InvRaisedCompName,FromDate,ToDate,DueDate,DeliveryDate"+
			"	)"+
			"   Values(?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,"+
					  "?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?"+
			")";
			System.out.println(sqlProforma);
			
			
			java.sql.PreparedStatement stmt = con.prepareStatement( sqlProforma );
			 System.out.println(rsDet.getString("SalesOrderDate")+"Prop stmt "+request.getParameter("total").toString());
			 stmt.setString(1,Integer.toString(SIProNumber));
			 stmt.setString(2,rsCustomerDetails.getString("CustomerCode"));
			 stmt.setString(3,todaysDate);
			 stmt.setString(4,rsDet.getString("TheGroup"));
			 stmt.setString(5,request.getParameter("total").toString());
			 stmt.setString(6,"0");
			 stmt.setString(7,"0");
			 stmt.setString(8,request.getParameter("pfi").toString());
			 stmt.setString(9,request.getParameter("frieght").toString());
			 stmt.setString(10,request.getParameter("grandTotal").toString());
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
			 stmt.setString(30,companyname);
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
			 stmt.setString(51,SON);
			 stmt.setString(52,SOD);
			 stmt.setString(53,address);
			 stmt.setString(54,godownaddress);
			 stmt.setString(55,"Tel: "+phone+"  Fax: "+fax+"  "+mail+"  "+website);
			 stmt.setString(56,companyname);
			 stmt.setString(57,fdate);
			 stmt.setString(58,tdate);
			 stmt.setString(59,ddate);
			 stmt.setString(60,del);

			stmt.executeUpdate();
			
			double TotTax=0.00;
			double TaxAmt=0.00;
			double TotTaxCGST=0.00;
			double TotTaxSGST=0.00;
			double TotTaxIGST=0.00;
			double TaxIGSTamt=0.00;
			double TaxCGSTamt=0.00;
			double TaxSGSTamt=0.00;
			
			String SACCode="",HSNCode="";
			
			
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
					    
					    String TaxAmtStr="";
					    
					    TaxAmtStr=new DecimalFormat("0.00").format(TaxAmt);
					    
					    System.out.println(" Indiv Item Tax :- "+TaxAmtStr);
					    
					    
					    
					    

					    
						if(no< 5)
						{
							tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+mcode+"";
							System.out.println(tableToBeAccessed);
						}else 
							tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+rsDet.getString("TheGroup");
						
						
						//need to add code for GST Values
						
						
			
			
					String sqlProformaItems=" INSERT INTO  "+session.getAttribute("CompanyMasterID").toString()+"performainvoice_items "+
					"(InvoiceNo ,TheGroup ,Make,ItemCode,Quantity ,SellingPrice ,DiscountPercent ,"+
					"TheTableToBeAccessed,SoNo,STPercent,ItemSrno ,ItemDescription,TaxType,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) "+
					"VALUES ('"+SIProNumber+"','"+rsDet.getString("TheGroup")+"',"+
					"'"+mcode+"','"+icode+"','"+quantity1+"',"+
					"'"+sellingprice+"','"+discount+"','"+tableToBeAccessed+"','"+request.getParameter("SONumber").toString()+"', "+
					"'"+tax+"','"+ i+1 +"','"+description+"','NIL','"+HSNCode+"','"+SACCode+"','"+cgsttax+"','"+CGSTTaxAmt+"','"+sgsttax+"','"+SGSTTaxAmt+"','"+igsttax+"','"+IGSTTaxAmt+"')";
								
					System.out.println("Item Query :- "+sqlProformaItems);
					
				    st2.executeUpdate(sqlProformaItems);
				}
				
				TotTaxCGST=TotTaxCGST+TaxCGSTamt;
				TotTaxSGST=TotTaxSGST+TaxSGSTamt;
				TotTaxIGST=TotTaxIGST+TaxIGSTamt;
				TotTax=TotTax+TaxAmt; 
				
				
			}
			
			System.out.println(" Total CGSTTax :- "+TotTaxCGST);
			System.out.println(" Total SGSTTax :- "+TotTaxSGST);
			System.out.println(" Total IGSTTax :- "+TotTaxIGST);
			System.out.println(" Total Tax :- "+TotTax);
			
			
			String sqlUpdate="";
			sqlUpdate="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det  set InvoiceGenerated='1'  where SalesOrderNo='"+request.getParameter("SONumber").toString()+"' limit 1  ";
			st3.executeUpdate(sqlUpdate);
			
			String updategsttax="update "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet set CGSTValue='"+TotTaxCGST+"' ,CGSTRate='"+cgsttax+"',SGSTRate='"+sgsttax+"', IGSTRate='"+igsttax+"', SGSTValue='"+TotTaxSGST+"' ,IGSTValue='"+TotTaxIGST+"',HSNCode='"+HSNCode+"',SACCode='"+SACCode+"' where invoiceRefNo='"+SPRefNumber+"'";
			
			System.out.println("Invoice Update :- "+updategsttax);
			
			st4.executeUpdate(updategsttax);
			
			
			String sqlBalance1="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode="+request.getParameter("customercode")+" order by TransactionId DESC limit 1";

			ResultSet rsbalance1=st1.executeQuery(sqlBalance1);
			System.out.println("sql"+sqlBalance1);
			
			double balance1 = 0,invcamount1=0;
			String invcamount=request.getParameter("grandTotal").toString();
			invcamount1=Double.parseDouble(invcamount);
			//double debitamount1=0;
			//double creditamount1=0;
			//double transactionid1=0;
			if(rsbalance1.next())
			{
				//transactionid1=rsbalance.getDouble("transactionid");
				//debitamount1=rsbalance.getDouble("debitamount");
				//creditamount1=rsbalance.getDouble("creditamount");
				balance1=rsbalance1.getDouble("Balance");
				balance1=invcamount1+balance1;
												
			}
			else
			{
				balance1=balance1+invcamount1;
			}	
			
			int transactionId;
			
			String transactionNo="select MAX(TransactionId) from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount";
			ResultSet rsNo=st2.executeQuery(transactionNo);
			rsNo.next();
				transactionId=rsNo.getInt(1);
			transactionId++;
			
			System.out.println("TRAN   ID   IS "+transactionId);
			
			System.out.println("+++++++++++++++++++++++++++++++++                 =======================================");
			
			String differ="SELECT DATEDIFF(now(),'2018-11-01') as DATEDIFF";
			ResultSet rsdiffer=st5.executeQuery(differ);
			
			int diff=0;
			if(rsdiffer.next())
			{
				diff=rsdiffer.getInt("DATEDIFF");
			}
			if(diff >=0)
			{
			
			sqlAddition="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount(TransactionId,CustomerCode,TransactionType,TransactionDetail,TransactionDate,DebitAmount, "+
						" CreditAmount,Balance,EmpName,PaymentVoucherNo,DebitParty,CreditParty) "+
						
						" VALUES ("+transactionId+",'"+request.getParameter("customercode")+"','ProFormaInvoice','"+SPRefNumber+"','"+todaysDate+"','"+request.getParameter("grandTotal")+"', "+
						" '0','"+balance1+"','"+session.getAttribute("EmpName")+"','-','"+request.getParameter("company")+"' ,'Sales Account' )";
			
            System.out.println("Ledger Insert :- "+sqlAddition);
		    
	   		st3.executeUpdate(sqlAddition);
			
			}
			else
			{
				
			}
		
		     
	   		
/* 			response.sendRedirect("alertGoTo.jsp?msg=PROFORMA INVOICE SUCCESFULLY SAVED.&goto=home.jsp");
 */			
 
			out.println("<script>  Redirect11();</script>");		

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