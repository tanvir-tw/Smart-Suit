<%@page import="java.util.Date"%>
<%@page import="com.erp.beans.LedgerUpdatation"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,stmt1=null,stmt2=null,stmt3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
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
	st6=con.createStatement();
	stmt1=con.createStatement();
	stmt2=con.createStatement();
	stmt3=con.createStatement();
	
	String invoiceno=request.getParameter("invoiceNo");
	System.out.println(invoiceno);
	
	String InvoiceRefNo=request.getParameter("invoiceRefNo");
	System.out.println("InvoiceRefNo :- "+InvoiceRefNo);
	
	String cancelreason=request.getParameter("reasonforcancel");
	System.out.println(cancelreason);
	
	String Total="",mCustomercode="",invrefnum="",invoicedate="",invoicedate1="";
	
	
	Date dt=null,dt1=null;
	
	
	String LockDate="select * from "+session.getAttribute("CompanyMasterID").toString()+"FinancialDateLock order by srno desc limit 1";
	ResultSet rsLockDate=st6.executeQuery(LockDate);
	if(rsLockDate.next())
	{
		dt=rsLockDate.getDate("LockDate");
	}

	
	
	String GetData="select * from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where invoicerefno='"+InvoiceRefNo+"' and invoicedate >='2018-11-01' ";
	
	// String GetData="select * from "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet where InvoiceNo='"+invoiceno+"' ";
	
	ResultSet rsGetData=st4.executeQuery(GetData);
	
	System.out.println("Get Data :- "+GetData);
	
	if(rsGetData.next())
	{
		Total=rsGetData.getString("GrandTotal");
		mCustomercode=rsGetData.getString("CustomerCode");
		invrefnum=rsGetData.getString("invoiceRefNo");
		invoicedate=rsGetData.getString("InvoiceDate");
		
		
		dt1=rsGetData.getDate("InvoiceDate");
		
		String date =  new SimpleDateFormat("ddMMyy").format(new Date());
		
		if(dt1.before(dt))
		{
			invoicedate=date;
		}else{
		invoicedate = new SimpleDateFormat("ddMMyy")
		        .format(new SimpleDateFormat("yyyy-MM-dd")
		                .parse(invoicedate));
		}
		String paymentVoucher="SPC";
		
		
		
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		
		
		
		
		//String sql1="SELECT PaymentVoucherNo from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails  where PaymentVoucherNo like ('"+paymentVoucher+""+date+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
		
		String sql1="SELECT PaymentVoucherNo from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails  where PaymentVoucherNo like ('"+paymentVoucher+""+invoicedate+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
		ResultSet rs=stmt1.executeQuery(sql1);
		if(rs.next())
		{
			  paymentVoucher=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
		}
		else
		{
			  paymentVoucher+=invoicedate+"001";
		}

		
		
		
		
		
		        System.out.println("Payment Voucher No :- "+paymentVoucher);
		
		
				
				String deductiondesc="-";
				String deductionPer="-";
				
				if(dt1.before(dt))
				{
					invoicedate=todaysDate;
				}else
				{
				invoicedate=rsGetData.getString("InvoiceDate");
				}
				
				
				String sqlDeduction="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails (paymentvoucherno,paymentdate,chorddorcreditnoteno,"+
					        "chorddorcreditnotedate,amountpaid,invoiceno,invoiceRefNo,bankname,branchname,city,"+
				        	"remarks,customercode,paymentmode,tallyrefno,twempname)"+
		                "VALUES ('"+paymentVoucher+"','"+invoicedate+"','"+paymentVoucher+"','"+invoicedate+"','"+Total+"',"+invoiceno+",'"+invrefnum+"','-','-','-','ProForma Invoice Cancelled "+invrefnum+"',"+mCustomercode+",'-','-','"+session.getAttribute("EmpName")+"')";
				
				
				
				System.out.println("sqldeduction :- "+sqlDeduction);
				
				stmt2.executeUpdate(sqlDeduction);
				
		
		 String sqlLedger="Select balance from  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount  where CustomerCode='"+mCustomercode+"' ORDER BY TransactionId  desc limit 1";
		
		 double  balance=0;
		 
		 ResultSet rsLedger=stmt3.executeQuery(sqlLedger);
		 
		 if (rsLedger.next())
		 {
			 System.out.println("bal "+rsLedger.getDouble("Balance"));
			 
				 System.out.println("=======================1111111");
				 
				 /* if(rsLedger.getDouble("Balance")<=0)
				 {
					 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")+Double.parseDouble(Total)));// deduct TDS from this
				 }
				 else
				 {
					 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")-Double.parseDouble(Total)));// deduct TDS from this
				 } */
				 
				 balance=Double.valueOf(twoDForm.format(rsLedger.getDouble("Balance")-Double.parseDouble(Total)));
		}
		
		 
		 System.out.println("balanceeeeeeeeee :- "+balance);
		 
		
		 String sqlLedger1="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount (CustomerCode, 	TransactionType,TransactionDetail ,TransactionDate,"+
				 "DebitAmount ,CreditAmount,Balance ,EmpName ,PaymentVoucherNo ,DebitParty ,CreditParty) VALUES "+
				 " ('"+mCustomercode+"','ProForma Invoice Reversed','"+paymentVoucher+"','"+invoicedate+"','0.00','"+Total+"','"+balance+"','"+session.getAttribute("EmpName")+"','"+paymentVoucher+"','Auto','"+mCustomercode+"')";
		
		 System.out.println("Insert Query  :- "+sqlLedger1);
		 
		 st4.executeUpdate(sqlLedger1);
		 
		 String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet SET InvoiceCancelled=1 , ReasonForCancelling='"+cancelreason+"' where invoiceRefNo='"+invrefnum+"' ";
			
		 System.out.println("Update :- "+sqlUpdate);
		 
		 st.executeUpdate(sqlUpdate);
			
		 String Updateledger="update "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount set TransactionType='ProForma Invoice Cancelled',PaymentVoucherNo='"+paymentVoucher+"' where TransactionDetail='"+invrefnum+"' and CustomerCode='"+mCustomercode+"'";
			st5.executeUpdate(Updateledger);
			
			System.out.println("Update Ledger :- "+Updateledger);
			
			 LedgerUpdatation ld =new LedgerUpdatation();
			ld.calulation(mCustomercode,session.getAttribute("CompanyMasterID").toString()); 
		 
		 response.sendRedirect("alertGoTo.jsp?msg=Proforma Invoice Cancelled.&goto=showinvoicelist.jsp?id=Close");

	}
	else
	{
		Total="0.00";
		mCustomercode="-";
		invrefnum="-";
		String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"performainvoicedet SET InvoiceCancelled=1 , ReasonForCancelling='"+cancelreason+"' where InvoiceNo='"+invoiceno+"' ";
		
		System.out.println("Update :- "+sqlUpdate);
		st.executeUpdate(sqlUpdate);
		
		
		
		   LedgerUpdatation ld =new LedgerUpdatation();
			ld.calulation(mCustomercode,session.getAttribute("CompanyMasterID").toString());   
			
		response.sendRedirect("alertGoTo.jsp?msg=Proforma Invoice Cancelled.&goto=showinvoicelist.jsp?id=Close");
	}
	
	
		 
	 
	
	}
catch(Exception e)
	{
	System.out.println("Exception ::"+e);
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=home.jsp");
	}
finally
{
	con.close();
}
%>		