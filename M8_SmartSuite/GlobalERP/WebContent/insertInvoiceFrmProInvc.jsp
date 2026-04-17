<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<script>

function Redirect1()
{
	
	//alert('Done ','','success');
		  var value1=document.getElementById("SIRefNumber").value;
		//  alert(value1);
var value2=document.getElementById("SINumber").value;
//alert(value2);

var value3=document.getElementById("view").value;
//alert(value3);

 window.location.href="viewInvoice.jsp?InvoiceRefNo="+value1+"&Invoiceno="+value2+"&condition="+value3;
 
	    
	
}

function Redirect2()
{
	
	alert("Invoice Already Generated");
	

window.location.href="home.jsp";
	
	    
	
}


</script>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,ST123=null,stmt1=null,stmt2=null,stmt3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String companyid="";
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
		st4=con.createStatement();
		st5=con.createStatement();
		st6=con.createStatement();
		stmt1=con.createStatement();
		stmt2=con.createStatement();
		stmt3=con.createStatement();
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
		
		String fdate=request.getParameter("label1");
/* 		fdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fdate));
 */
 		System.out.println("fdate  "+fdate);

 		
		String tdate=request.getParameter("label2");
/* 		tdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tdate));
 */
 		System.out.println("tdate  "+tdate);

		String ddate=request.getParameter("due_date");
		ddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(ddate));
 
 		System.out.println("ddate  "+ddate);
		String po=request.getParameter("POO");
 		System.out.println("po  "+po);
 		
 		String deli=request.getParameter("deli");
 		System.out.println("deoi  "+deli);
String HtmlAnnexure="";
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
		String SESQnumber="";
		String view="View";

		
		
		
		int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
		String groupName=request.getParameter("groupTop");		
		String shipmentDate=new SimpleDateFormat(
		"yyyy-MM-dd")
		.format(new SimpleDateFormat(
				"dd-MMM-yyyy")
				.parse(request.getParameter("dateOfShipment")));
		
		String invoicerefno=request.getParameter("prorefno");
		
		System.out.println("Invoice Ref No :- "+invoicerefno);
		
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		
		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
		
		// Code Starts For Credit Note While Converting Proforma Inv To Main Inv 
		
		String Total="",mCustomercode="",invrefnum="",invoiceno="";
		
		
		// Code Ends For Credit Note While Converting Proforma Inv To Main Inv
		
		
		
		
		int SINumber;
		
		String sqlOrderno="SELECT MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet ";
		ResultSet rs1=st.executeQuery(sqlOrderno);
		
		System.out.println(sqlOrderno);
		
		rs1.next();  
			SINumber=rs1.getInt(1);
		SINumber++;
		System.out.println("&&&&****&& N "+SINumber);
		
		/* int SIProNumber;
		String SIProNo="select MAX(InvoiceNo) from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet ";
		ResultSet rsPro=st1.executeQuery(SIProNo);
		System.out.println(SIProNo);
		rsPro.next();
			SIProNumber=rsPro.getInt(1);
		SIProNumber++;	
		System.out.println("NONONON   MNOPNPOMKJKK   N "+SIProNumber); */
		
		
		String SIRefNumber="";
		
		//java.text.DecimalFormat df = new java.text.DecimalFormat("000");

		try{
			
			Date today = new Date();
			 
			 SIRefNumber="SI";

			String date1 =  new SimpleDateFormat("ddMMyy").format(new Date());

			String sql3="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet  where invoiceRefNo like ('"+SIRefNumber+""+date1+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    ResultSet rs=st2.executeQuery(sql3);
			    System.out.println(sql3);     
			  if(rs.next())
				  SIRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SIRefNumber+=date+"001"; 
			  
		}catch(Exception e){
		e.printStackTrace();		
		} %>
		
		<input type="hidden" name="SPRefNumber"  id="SPRefNumber" value="<%=SIRefNumber%>"></input>
<%-- 		<input type="hidden" name="SIProNumber"  id="SIProNumber" value="<%=SIProNumber%>"></input>
 --%>									<input type="hidden" name="SINumber"  id="SINumber" value="<%=SINumber%>"></input>
																<input type="hidden" name="SIRefNumber"  id="SIRefNumber" value="<%=SIRefNumber%>"></input>
		
				<input type="hidden" name="view"  id="view" value="<%=view%>"></input>
<%
		String SPRefNumber="";
	//	java.text.DecimalFormat df = new java.text.DecimalFormat("000");

		try{
			
			Date today = new Date();
			 
			/* SPRefNumber="SP";

			//String date =  new SimpleDateFormat("ddMMyy").format(new Date());

			String sql4="SELECT invoiceRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  where invoiceRefNo like ('"+SPRefNumber+""+date+"%') ORDER BY invoiceRefNo DESC LIMIT 1";
			    ResultSet rs=st3.executeQuery(sql4);
			    System.out.println(sql4);
			  if(rs.next())
				  SPRefNumber=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
			  else
				  SPRefNumber+=date+"001";
 */			  
		}catch(Exception e){
		e.printStackTrace();		
		}
		
		
		String sqlCustomerDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"customerdet WHERE CustomerCode='"+request.getParameter("customercode")+"' ";
		ResultSet rsCustomerDetails=st.executeQuery(sqlCustomerDetails);
		rsCustomerDetails.next();
		
		String TheGroup="",SalesOrderDate="",SalesorderRefNo="";
		
		String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesorderRefNo='"+ request.getParameter("SONumber") + "' ";
		System.out.println("*"+sqlDet);
		ResultSet rsDet = st5.executeQuery(sqlDet);
		
		
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
			
			String sqlQuotationDet="SELECT TWSalesRefNo from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+rsDet.getInt("SalesQuoNo")+"' ";
			System.out.println("QUERTY PRINTGGG   "+sqlQuotationDet);
			ResultSet rsQuotaionDet=st2.executeQuery(sqlQuotationDet);
			rsQuotaionDet.next();
			SESQnumber=rsQuotaionDet.getString(1);
			System.out.println("++++++++++++++++++++++++++++++++++++++++++======");
		}
		
			
	
		
		int InvoiceGenerated=0;
		 int InvoiceCancelled=0;
				
			
			String GetData="select * from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where invoiceRefNo='"+invoicerefno+"' and InvoiceDate >='2018-11-01' ";

			//String GetData="select * from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where invoiceRefNo='"+invoicerefno+"'  ";
			
			ResultSet rsGetData=st4.executeQuery(GetData);
			
			System.out.println("Get Data :- "+GetData);
			
			if(rsGetData.next())
			{
				Total=rsGetData.getString("GrandTotal");
				mCustomercode=rsGetData.getString("CustomerCode");
				invrefnum=rsGetData.getString("invoiceRefNo");
				invoiceno=rsGetData.getString("InvoiceNo");
				HtmlAnnexure=rsGetData.getString("HtmlAnnexure");
				System.out.println("HtmlAnnexure Data :- "+HtmlAnnexure);
				InvoiceGenerated = rsGetData.getInt("InvoiceGenerated");
				System.out.println("InvoiceGenerated "+InvoiceGenerated);
				
				InvoiceCancelled = rsGetData.getInt("InvoiceCancelled");
				
				System.out.println("InvoiceCancelled "+InvoiceCancelled);
				
				if((InvoiceGenerated==1)&&(InvoiceCancelled==0) || (InvoiceGenerated==0)&&(InvoiceCancelled==1))
				
				{
					out.println("<script>  Redirect2();</script>");
				}
				
				String paymentVoucher="CRN";
				
				String sql1="SELECT PaymentVoucherNo from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails  where PaymentVoucherNo like ('"+paymentVoucher+""+date+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
				ResultSet rs=stmt1.executeQuery(sql1);
				if(rs.next())
				{
					  paymentVoucher=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
				}
				else
				{
					  paymentVoucher+=date+"001";
				}

				System.out.println("Payment Voucher No :- "+paymentVoucher);
				
				
						
						String deductiondesc="-";
						String deductionPer="-";
						
						
						
						
						String sqlDeduction="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails (paymentvoucherno,paymentdate,chorddorcreditnoteno,"+
							        "chorddorcreditnotedate,amountpaid,invoiceno,invoiceRefNo,bankname,branchname,city,"+
						        	"remarks,customercode,paymentmode,tallyrefno,twempname)"+
				                "VALUES ('"+paymentVoucher+"','"+todaysDateTime+"','"+paymentVoucher+"','"+todaysDateTime+"','"+Total+"',"+invoiceno+",'"+invrefnum+"','-','-','-','ProForma Invoice Converted Into Main Invoice',"+mCustomercode+",'Credit Note','-','"+session.getAttribute("EmpName")+"')";
						
						
						
						System.out.println("sqldeduction :- "+sqlDeduction);
						
						stmt2.executeUpdate(sqlDeduction);
						
				
				 String sqlLedger="Select balance from  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount  where CustomerCode='"+mCustomercode+"' ORDER BY TransactionId  desc limit 1";
				
				 double  balance=0;
				 
				 ResultSet rsLedger=stmt3.executeQuery(sqlLedger);
				 
				 if (rsLedger.next())
				 {
					 System.out.println("bal "+rsLedger.getDouble("Balance"));
					 
						 System.out.println("=======================1111111");
						 
						/*  if(rsLedger.getDouble("Balance")<=0)
						 {
							 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")+Double.parseDouble(Total)));// deduct TDS from this
						 }
						 else
						 {
							 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")-Double.parseDouble(Total)));// deduct TDS from this
						 } */
						 
						 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")-Double.parseDouble(Total)));// deduct TDS from this

				}
				
				 
				 System.out.println("balanceeeeeeeeee :- "+balance);
				 
				
				 String sqlLedger1="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount (CustomerCode, 	TransactionType,TransactionDetail ,TransactionDate,"+
						 "DebitAmount ,CreditAmount,Balance ,EmpName ,PaymentVoucherNo ,DebitParty ,CreditParty) VALUES "+
						 " ('"+mCustomercode+"','Credit Note','"+paymentVoucher+"','"+todaysDate+"','0.00','"+Total+"','"+balance+"','"+session.getAttribute("EmpName")+"','"+paymentVoucher+"','Auto','"+mCustomercode+"')";
				
				 st6.executeUpdate(sqlLedger1);
				 
				 System.out.println("Insert Query  :- "+sqlLedger1);
				 
				 
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
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
    			"   CustPurNO, CustPurDT, InvRaisedBillAdd, InvRaisedShipAdd, InvRaisedConDet,InvRaisedCompName,Fromdate,ToDate,DueDate,DeliveryDate,HtmlAnnexure"+
    			"	)"+
    			"   Values(?,?,?,?,?, ?,?,?,?,?,"+
    					  "?,?,?,?,?, ?,?,?,?,?,"+
    					  "?,?,?,?,?, ?,?,?,?,?,"+
    					  "?,?,?,?,?, ?,?,?,?,?,"+
    					  "?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?"+
    			")";

			 java.sql.PreparedStatement stmt = con.prepareStatement( sqlmain );
			 System.out.println("Prop stmt "+request.getParameter("total").toString());
			 stmt.setString(1,Integer.toString(SINumber));
			 stmt.setString(2,rsCustomerDetails.getString("CustomerCode"));
			 stmt.setString(3,todaysDate);
			 stmt.setString(4,TheGroup);
			 stmt.setString(5,request.getParameter("total").toString());
			 stmt.setString(6,"0");
			 stmt.setString(7,"0");
			 stmt.setString(8,request.getParameter("pfi").toString());
			 stmt.setString(9,request.getParameter("frieght").toString());
			 stmt.setString(10,request.getParameter("grandTotal").toString());
			 stmt.setString(11,request.getParameter("terms").toString());
			 stmt.setString(12,request.getParameter("rupees").toString());
			 stmt.setString(13,request.getParameter("SONumber").toString());
			 stmt.setString(14,SalesOrderDate);
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
			 stmt.setString(47,SalesorderRefNo);
			 stmt.setString(48,"0");
			 stmt.setString(49,"0");
			 stmt.setString(50,"0");
			 stmt.setString(51,po);
			 stmt.setString(52,todaysDate);
			 stmt.setString(53,address);
			 stmt.setString(54,godownaddress);
			 stmt.setString(55,"Tel: "+phone+"  Fax: "+fax+"  "+mail+"  "+website);
			 stmt.setString(56,companyname);
			 stmt.setString(57,fdate);
			 stmt.setString(58,tdate);
			 stmt.setString(59,ddate);
			 stmt.setString(60,deli);
			 stmt.setString(61,HtmlAnnexure);

			 System.out.println("Invoice det query:-  "+sqlmain);
			 
	stmt.executeUpdate();
	System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ");
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
					tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+TheGroup+"";
				
				String sqlItems=" INSERT INTO  "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items "+
						"(InvoiceNo ,TheGroup ,Make,ItemCode,Quantity ,SellingPrice ,DiscountPercent ,SONo,"+
						"TheTableToBeAccessed,ItemSRNo ,STPercent,ItemDescription,HSNCode,SACCode,CGSTRate,CGSTValue,SGSTRate,SGSTValue,IGSTRate,IGSTValue) "+
						"VALUES ('"+SINumber+"','"+TheGroup+"',"+
							"'"+mcode+"','"+icode+"','"+quantity1+"',"+
							"'"+sellingprice+"','"+discount+"','0'"+
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
	
	//String sqlUp="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det  set InvoiceGenerated='1'  where SalesOrderNo='"+request.getParameter("SONumber").toString()+"' limit 1  ";
	String sqlUp="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet  set InvoiceGenerated='1'  where invoicerefno='"+invoicerefno+"' ";
	System.out.println("salesorder update :- "+sqlUp);
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


/* response.sendRedirect("http://aps.mobileeye.in:8181/GlobalERP/PaymentLink.jsp?transactionId="+SIRefNumber+"&CompanyMasterID="+companyid+"");
 */

	
	
		
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