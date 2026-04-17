
<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>
<%
Connection con=null ;
DecimalFormat twoDForm = new DecimalFormat("#.##");
Statement st1=null,st2=null,st3=null,st4=null;
String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String dateDDMMMYY=new SimpleDateFormat("dd-MMM-yy").format(new java.util.Date());
String deductiondesc="0",deductionPer="0";    int finalbal=0,calBal=0;
%>
<%
boolean isInvoiceSelected=false;
try
{
	
	if(request.getParameter("companyNameSelected")!=null && !(request.getParameter("companyNameSelected").equals("")) )
	{
		
		String deductionvalue="0";
		
		if(request.getParameter("deduction")!=null)
			deductionvalue=request.getParameter("deductionValue");
		
		String companyCode="NA";
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
			
		String paymentVoucher="-";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
	
		paymentVoucher="SMR";
	
		String date =  new SimpleDateFormat("yy"+ "/"+"MM"+ "/"+"dd").format(new Date());
		System.out.println("TODAYS DATE..  "+date);
		/*String sql1="SELECT PaymentVoucherNo from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails  where PaymentVoucherNo like ('"+paymentVoucher+""+date+"%') ORDER BY PaymentVoucherNo DESC LIMIT 1";
		  ResultSet rs=st1.executeQuery(sql1);
		  if(rs.next())
			  paymentVoucher=rs.getString(1).substring(0,rs.getString(1).length()-3)+df.format(Integer.parseInt(rs.getString(1).substring(rs.getString(1).length()-3, rs.getString(1).length()))+1);
		  else
			  paymentVoucher+=date+"001";*/
		  
		String refmonyno="";	  
		refmonyno="11-"+date;	  
		System.out.println("/////  "+refmonyno);	  
			  
			  
			  
		int MNYRECPTNumber;
		String RecptNo="select MAX(MoneyReceiptNo) from "+session.getAttribute("CompanyMasterID").toString()+"supallpaymentdetails ";
		ResultSet rsPro=st1.executeQuery(RecptNo);
		System.out.println(RecptNo);
		rsPro.next();
		MNYRECPTNumber=rsPro.getInt(1);
		MNYRECPTNumber++;	  
		  
		String sqlCompanyDetails="SELECT SupplierCode from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierName = ('"+request.getParameter("companyNameSelected").toString()+"') ";
		ResultSet rsCompanyDetails =st1.executeQuery(sqlCompanyDetails);
		rsCompanyDetails.next();
		companyCode=rsCompanyDetails.getString(1);
		
	    System.out.print("cmp name -->>"+request.getParameter("companyNameSelected").toString());
	        
	    String paymentMode="",paymentAmount="",ddNumber="-",ddDate="",bankName="",branchName="",city="",comments="",paymentdets="";
	        
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
	    		paymentdets=(request.getParameter("paymentdetails") == null || request.getParameter("paymentdetails").equalsIgnoreCase("")) ? "-" : request.getParameter("paymentdetails")  ;
	        	
	    		
	    		String invoiceNumber="",amountAgainstInvoice="",invoiceValue="";;
	    		String sql="";
	    		int i=1;
	    		int a=0;
	  
	 /* ********************  ***************************************************************************************************************  */
		          
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
		    			         
		    						
		    				String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails SET AmountPaid='"+paymentAmount+"'   where  InvoiceNo='"+invoiceNumber+"' and SupplierCode='"+companyCode+"'";
		    				System.out.println("????  "+sqlUpdate);
			    		 	st2.executeUpdate(sqlUpdate);
			    		 	  
			    		 	  
		    			    int initialbal=0,amountpaid=0,incvalue=0,diff=0,newbal=0;String invcno="";
	   			            String sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails where SupplierCode='"+companyCode+"' Order By InvoiceDate Asc";
		    			    ResultSet rs1=st2.executeQuery(sql1);
		    			    while(rs1.next())
		    			    {
		    			    	System.out.println("I IS     :::::   "+i);
		    			    	initialbal=rs1.getInt("Balance");
		    			    	System.out.println("BALANCE   "+initialbal);
		    			    	amountpaid=rs1.getInt("AmountPaid");
		    			    	System.out.println("AMOUNT PAID  "+amountpaid);
		    			    	incvalue=rs1.getInt("InvoiceValue");
		    			    	invcno=rs1.getString("InvoiceNo");
		    			    	
		    			    	diff=initialbal-Integer.parseInt(paymentAmount);
		    			    	System.out.println("*****    "+diff);
		    			        
		    			    	newbal=initialbal+diff;
		    				   	 String sql2="Update "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails SET AmountPaid='"+amountpaid+"',Balance='"+diff+"'  where  InvoiceNo='"+invcno+"'";
		    				  //  String sql2="Update "+session.getAttribute("CompanyMasterID").toString()+"suppaymentsettleddetails SET Balance='"+diff+"'  where  InvoiceNo Not in ('"+invoiceNumber+"')";
		    			       	System.out.println(">  >  >   "+sql2); 	
		    			     	st1.executeUpdate(sql2);
		    			    }
		    			        
		    			
		    				String sqlAllPayment="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"supallpaymentdetails(MoneyReceiptNo ,RefMoneyReceiptNo ,SupplierCode ,InvNoIsSpecified ,InvoiceNo ,InvoiceValue ,"+
		   				 	"InvoiceDate ,PaymentDetails ,PaymentDate ,PaymentMode ,AmountPaid ,ChOrDDorCreditNoteNo ,ChOrDDorCreditNoteDate ,BankName ,BranchName ,"+
			    			 "City ,TWEmpName ,ChOrDDEncashedStatus ,ChOrDDEncashedOnDate ,Remarks)"+
			        		 "VALUES ('"+MNYRECPTNumber+"','"+refmonyno+"/"+i+"','"+companyCode+"','1','"+invoiceNumber+"','"+invoiceValue+"',"+
			        		 "'"+todaysDate+"','"+paymentdets+"','"+dateDDMMMYY+"','"+paymentMode+"','"+paymentAmount+"','"+ddNumber+"','"+ddDate+"','"+bankName+"','"+branchName+"',  "+
			        		 "'"+city+"' ,'"+session.getAttribute("EmpName")+"','Payment Done','"+ddDate+"','"+comments+"')";	
				
						//	st4.executeUpdate(sqlAllPayment);
							System.out.println(sqlAllPayment); 
		    			}
		    			i++;
		    		}
	
	    		}
	    		    		    		
	  /* ********************  ***************************************************************************************************************  */  		
	    		    		
	    	/*String sqlAllPayment="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails (PaymentVoucherNo,MoneyReceiptNo,CustomerCode,InvNoIsSpecified,InvoiceNo,InvoiceValue,"+
					"PaymentDetails,PaymentDate,PaymentMode,AmountPaid,ChOrDDorCreditNoteNo,ChOrDDorCreditNoteDate,"+
					"BankName,BranchName,City,TWEmpName,ChOrDDEncashedStatus,ChOrDDEncashedOnDate,Remarks,InvoicerefNo,UpdatedinTally) values "+
					" ('"+paymentVoucher+"','0','"+companyCode+"','0','0','0',"+
					" '"+paymentMode+"','"+todaysDate+"','"+paymentMode+"','"+paymentAmount+"','"+ddNumber+"','"+ddDate+"',"+
					" '"+bankName+"','"+branchName+"','"+city+"','"+session.getAttribute("EmpName")+"','-','-','"+comments+"','-','-')" ;*/
			

			

		System.out.println(); 
		response.sendRedirect("alertGoTo.jsp?msg=Payment is Added in System for Supplier "+request.getParameter("companyNameSelected")+"&goto=paymentAccDet.jsp");
	}
	else
	{
		System.out.println("Payment Not Added. Please Try Again");
		response.sendRedirect("alert.jsp?msg=!!!! ERROR Inserting Record.Please try again.");
	}
	
}
catch(Exception e)

{
System.out.println( "Exception ::"+e );
response.sendRedirect("alert.jsp?msg=!!!! ERROR Inserting Record.Please try again.");
}
%>
