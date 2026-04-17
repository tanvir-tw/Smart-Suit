
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st4=null;
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String deductiondesc="0",deductionPer="0";
%>
<%
boolean isInvoiceSelected=false;
try{
	
if(request.getParameter("companyNameSelected")!=null && !(request.getParameter("companyNameSelected").equals("")) )
{
	
	String deductionvalue="0";
	
	//if(request.getParameter("deduction")!=null)
		deductionvalue=request.getParameter("deductionValue");
		System.out.println("deduction val::::"+deductionvalue);
	
	String companyCode="NA";
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	
	
	String paymentVoucher="-";
	java.text.DecimalFormat df = new java.text.DecimalFormat("000");

		if(request.getParameter("paymentMode").equalsIgnoreCase("Credit Note"))
		{
			paymentVoucher="CRN";
		}else if(request.getParameter("paymentMode").equalsIgnoreCase("Debit Note"))
		{
			paymentVoucher="DBN";
		}else
		{
		paymentVoucher="SMR";
		}
	String date =  new SimpleDateFormat("ddMMyy").format(new Date());

	String sql1="SELECT PaymentVoucherNo from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails  where PaymentVoucherNo like ('"+paymentVoucher+""+date+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
	  ResultSet rs=st1.executeQuery(sql1);
	  if(rs.next())
		  paymentVoucher=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
	  else
		  paymentVoucher+=date+"001";
	  
	  
	String sqlCompanyDetails="SELECT CustomerCode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName = ('"+request.getParameter("companyNameSelected").toString()+"') ";
	ResultSet rsCompanyDetails =st1.executeQuery(sqlCompanyDetails);
	 rsCompanyDetails.next();
		companyCode=rsCompanyDetails.getString(1);
	
        System.out.print("cmp name -->>"+request.getParameter("companyNameSelected").toString());
        
        
        String paymentMode="",paymentAmount="",ddNumber="-",ddDate="",bankName="",branchName="",city="",comments="";
        
    		paymentMode=request.getParameter("paymentMode");
    		paymentAmount=request.getParameter("paymentAmount");
	
    		ddNumber= (request.getParameter("ddNumber") == null || request.getParameter("ddNumber").equalsIgnoreCase("") ) ? "-" : request.getParameter("ddNumber")  ; 
    		ddDate= (request.getParameter("ddDate") == null|| request.getParameter("bankName").equalsIgnoreCase("")) ? todaysDate : request.getParameter("ddDate")  ;
    		bankName= (request.getParameter("bankName") == null || request.getParameter("bankName").equalsIgnoreCase("")) ? "-" : request.getParameter("bankName")  ;
    		branchName= (request.getParameter("branchName") == null || request.getParameter("branchName").equalsIgnoreCase("")) ? "-" : request.getParameter("branchName")  ;
    		city= (request.getParameter("city") == null || request.getParameter("city").equalsIgnoreCase("")) ? "-" : request.getParameter("city")  ;
    	 	if(request.getParameter("backDatedEntry")!=null)
    	 	todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
    		
    		System.out.println("--- BACK DATE  "+todaysDate);
    		System.out.println("--- BACK DATE  "+todaysDate);
    		comments=(request.getParameter("comments") == null || request.getParameter("comments").equalsIgnoreCase("")) ? "-" : request.getParameter("comments")  ;
    		String invoiceNumber="",amountAgainstInvoice="",invoiceValue="";;
    		String sql="";
    		int i=1;
if(request.getParameter("invoice").toString().equalsIgnoreCase("invoice") )
    		{
				System.out.println("**FOR Specific invoices...");
				System.out.println();
    		     
    		while(i!=Integer.parseInt(request.getParameter("checktotal")))
	    		{
	    			if(request.getParameter("check"+i+"")!=null)
	    			{
	    				isInvoiceSelected=true;
	    				invoiceNumber=request.getParameter("check"+i+"");
	    				amountAgainstInvoice=request.getParameter("amt"+i+"");
	    				invoiceValue=request.getParameter("invoiceValue"+i+"");
	    				
	    				 System.out.println(i+ " invoice no    -  "+invoiceNumber);
	    				 System.out.println(i+ " invoice val   -  "+invoiceValue);
	    				 System.out.println(i+ " amt ag inv    -  "+amountAgainstInvoice);
	    				
	    			      System.out.println("payment voucher ***  "+paymentVoucher);
	    			         
	    			          sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"custpymtagainstinv (CustomerCode,PaymentVoucherNo,InvNo,InvValue,AmountPaidAgainstThisInvoice,CustSpecifiedInvoice,InvRefNo) VALUES"+
	    			         "('"+companyCode+"','"+paymentVoucher+"','"+invoiceNumber+"','"+invoiceValue+"','"+amountAgainstInvoice+"','Yes','"+invoiceNumber+"')";
	    			          System.out.println(sql);
	    			          
	    			         st1.executeUpdate(sql);
	    			}
	    			i++;
	    		}
    		}
    		
    		if(request.getParameter("deduction")!=null)
    		{
    			
    			String sqlDeductionDesc="SELECT DeductionDesc,DeductionPer FROM "+session.getAttribute("CompanyMasterID").toString()+"paymentdeductiontypes "+
    			" WHERE DeductionCode ='"+request.getParameter("deductionOptions")+"' ";
    			ResultSet rsDesc=st1.executeQuery(sqlDeductionDesc);
    			  deductiondesc="-";deductionPer="-";
    			if(rsDesc.next())
    			{
    				deductiondesc=rsDesc.getString("DeductionDesc");
    				deductionPer=rsDesc.getString("DeductionPer");
    			}
    				
    			String sqlDeduction="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdeductiondetails(PaymentVoucherNo,CustomerCode,"+
    			" DeductionCode,DeductionDesc,DeductionBaseAmt,DeductionPer,DeductionAmt,Remarks,EntryDateTime,EnteredBy,Datavalid) "+
    			" VALUES ('"+paymentVoucher+"','"+companyCode+"','"+request.getParameter("deductionOptions")+"','"+deductiondesc+"',"+
    			" '"+deductionvalue+"','"+deductionPer+"','"+deductionvalue+"','"+comments+"','"+todaysDateTime+"','"+session.getAttribute("EmpName")+"','1')";
    			System.out.println(sqlDeduction);
    			st2.executeUpdate(sqlDeduction);
    			System.out.println();
    		}
    		
    			String sqlAllPayment="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails (PaymentVoucherNo,MoneyReceiptNo,CustomerCode,InvNoIsSpecified,InvoiceNo,InvoiceValue,"+
				"PaymentDetails,PaymentDate,PaymentMode,AmountPaid,ChOrDDorCreditNoteNo,ChOrDDorCreditNoteDate,"+
				"BankName,BranchName,City,TWEmpName,ChOrDDEncashedStatus,ChOrDDEncashedOnDate,Remarks,InvoicerefNo,UpdatedinTally) values "+
				" ('"+paymentVoucher+"','0','"+companyCode+"','0','0','0',"+
				" '"+paymentMode+"','"+todaysDate+"','"+paymentMode+"','"+paymentAmount+"','"+ddNumber+"','"+ddDate+"',"+
				" '"+bankName+"','"+branchName+"','"+city+"','"+session.getAttribute("EmpName")+"','-','-','"+comments+"','-','-')" ;
				
    			st4.executeUpdate(sqlAllPayment);
    			
    			System.out.println(sqlAllPayment);
				System.out.println();
				
    		
    		 String sqlLedger="Select balance from  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount  where CustomerCode='"+companyCode+"' ORDER BY TransactionId  desc limit 1";
    		 double  balance=0;
    		 ResultSet rsLedger=st1.executeQuery(sqlLedger);
    		 if (rsLedger.next())
    		 {
    			 System.out.println("bal "+rsLedger.getDouble("Balance"));
    			balance=rsLedger.getDouble("Balance");
    			
    			//balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")-Double.parseDouble(paymentAmount)-Double.parseDouble(deductionvalue)));// deduct TDS from this 
    			
    			if(balance==0||balance<0)
    			{
    				balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")+Double.parseDouble(paymentAmount)-Double.parseDouble(deductionvalue)));
    			}else
    			{
    			 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")-Double.parseDouble(paymentAmount)-Double.parseDouble(deductionvalue)));// deduct TDS from this
    			}
    		 }
    		 System.out.println("deduction val::::"+deductionvalue);
    		 System.out.println("Balance ::"+balance);
    		 
    		 
			   if(request.getParameter("paymentMode").equalsIgnoreCase("Debit Note"))
			   {
				   sqlLedger="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount (CustomerCode, 	TransactionType,TransactionDetail ,TransactionDate,"+
							 "DebitAmount ,CreditAmount,Balance ,EmpName ,PaymentVoucherNo ,DebitParty ,CreditParty) VALUES "+
							 " ('"+companyCode+"','"+paymentMode+"','"+ddNumber+"','"+todaysDate+"','"+paymentAmount+"','0.00','"+balance+"','"+session.getAttribute("EmpName")+"','"+paymentVoucher+"','Cash Amt','"+companyCode+"')";
			   }else
			   {  
    		 sqlLedger="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount (CustomerCode, 	TransactionType,TransactionDetail ,TransactionDate,"+
					 "DebitAmount ,CreditAmount,Balance ,EmpName ,PaymentVoucherNo ,DebitParty ,CreditParty) VALUES "+
					 " ('"+companyCode+"','"+paymentMode+"','"+ddNumber+"','"+todaysDate+"','0.00','"+paymentAmount+"','"+balance+"','"+session.getAttribute("EmpName")+"','"+paymentVoucher+"','Cash Amt','"+companyCode+"')";
			   }  
    		 System.out.println();
   
   		st3.executeUpdate(sqlLedger);
   
   		System.out.println(sqlLedger);
   		System.out.println(); 		
    		
    System.out.println(paymentAmount+paymentMode+" dd date ->> "+ddDate+ddNumber+bankName+branchName+city+paymentVoucher+comments);

	System.out.println(); 
	response.sendRedirect("alertGoTo.jsp?msg=Payment with Voucher No:"+paymentVoucher+" added in system for Customer "+request.getParameter("companyNameSelected")+"&goto=ledgerdetails.jsp");
}
else
{
	System.out.println("Payment Not Added. Please Try Again");
	response.sendRedirect("alert.jsp?msg=!!!! ERROR Inserting Record.Please try again.");
}


}catch(Exception e){
System.out.println( "Exception ::"+e );
response.sendRedirect("alert.jsp?msg=!!!! ERROR Inserting Record.Please try again.");
}
%>
