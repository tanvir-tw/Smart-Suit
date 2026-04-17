<%@ include file="conn.jsp" %>
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%!
Connection con1;
%>

<%
            String mmoneyreceiptno=request.getParameter("myvoucherno");
            System.out.println("myvoucherno:"+mmoneyreceiptno);
            Class.forName(DB_Driver);
            DecimalFormat twoDForm = new DecimalFormat("#.##");
			con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
			Statement stmt1=con1.createStatement();
			String mCustomercode="";
			ResultSet rs1=null;
		    String sql1="";
		    String mcustomername=request.getParameter("customerName").replace("ampers","&");
		    System.out.println("customer name:-"+request.getParameter("customerName"));
		    String Code=request.getParameter("customerCode");
		    System.out.println("Company Code Before  :-"+ Code);
		    String BranchName="";
		    
		    sql1="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where companyname ='"+mcustomername+"' and customercode='"+Code+"' limit 1";
		    rs1=stmt1.executeQuery(sql1);
		    
		    System.out.println("Sql   :-"+ sql1);
		    while(rs1.next())
			{
	    	   mCustomercode=rs1.getString("customercode"); 
	    	   BranchName=rs1.getString("BranchName");
			}
		    System.out.println("Company Name :-"+ mcustomername);
		    System.out.println("Company Code :-"+ mCustomercode);
		    
			boolean isInvoiceSelected=false;
			String invoiceNumber="",amountAgainstInvoice="",invoiceValue="",invoiceDate="";
 			int i=1;
 			System.out.println("invoice selected ....");
 			System.out.println(request.getParameter("invoice"));
 			String checktotal="";
	        //if(request.getParameter("invoice").toString().equalsIgnoreCase("invoice") )
	        if(request.getParameter("invoice")!=null )
    		{
				System.out.println("**FOR Specific invoices...");
				checktotal=request.getParameter("checktotal");
				System.out.println("checktotal :- "+checktotal);
				
				
				
				while(i!=Integer.parseInt(request.getParameter("checktotal")))
	    		{
	    			if(request.getParameter("check"+i+"")!=null)
	    			{
	    				isInvoiceSelected=true;
	    				invoiceNumber=request.getParameter("check"+i+"");
	    				amountAgainstInvoice=request.getParameter("amt"+i+"");
	    				invoiceValue=request.getParameter("invoiceValue"+i+"");
	    				invoiceDate=request.getParameter("TransactionDate"+i+"");
	    				System.out.println("invoiceDate"+invoiceDate);
	    				//invoiceDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-dd").parse(invoiceDate));
        				System.out.println(i+ " invoice no    -  "+invoiceNumber);
        				System.out.println(i+ " invoice date -  "+invoiceDate);
	    				System.out.println(i+ " invoice val   -  "+invoiceValue);
	    				System.out.println(i+ " amt ag inv    -  "+amountAgainstInvoice);
	    				System.out.println("payment voucher ***  "+"unAutho");
	    			 	try
	    			 	{
	    					sql1="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"collectioninv (CustomerCode,PaymentVoucherNo,InvNo,InvValue,AmountPaidAgainstThisInvoice,CustSpecifiedInvoice,InvRefNo,TransactionDate,moneyreceiptno,BranchName) VALUES"+
	    			       			  "('"+mCustomercode+"','unAutho','"+invoiceNumber+"','"+invoiceValue+"','"+amountAgainstInvoice+"','Yes','"+invoiceNumber+"','"+invoiceDate+"',"+mmoneyreceiptno+","+BranchName+")";
	    			    	System.out.println(sql1);
	    			    	stmt1.executeUpdate(sql1);
	    			    	
	    			 	}
	    			 	catch(Exception e)
	    			 	{
	    					System.out.println( "Exception ::"+e );
	    			 	}
	    			}
	    			i++;
	    		}
    		}
		    response.sendRedirect("collection.jsp");
		    
%>
