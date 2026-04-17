<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
	
try{	
	
	System.out.println("Page name is insert expquo");
	
	
	
	System.out.println("chk     ."+request.getParameter("checkedNumber").toString()+".");
	Class.forName(DB_Driver);
	con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	
	String sellingprice1="" ,priceAccepted="",custrefno="",twsalesorderno="";				
	String QuoExpirydate="",salesquotime="",group="",quantity1=""; 
	String discount1="",tax1="",amount="",total="",salesquono="",currval="",currtype="",currsym="";
	String amountInWords="",customercode="";
	String enqtime="",salesquodate1="";
	int i=0,j=0;
	
	String acode=request.getParameter("addresscode");
	String company1=request.getParameter("company");
	customercode=request.getParameter("customercode");
	String contactperson=request.getParameter("contactperson");
	String address=request.getParameter("address");
	String city=request.getParameter("city");
	String state=request.getParameter("state");
	String country=request.getParameter("country");
	String phone=request.getParameter("phone");
	String fax=request.getParameter("fax"); 
	String zip=request.getParameter("zip");
	String terms=request.getParameter("termsconditions");
	enqtime=request.getParameter("enqtime");
	
	String salesenqno1=request.getParameter("salesenqno");
	System.out.println(salesenqno1);
 	total=request.getParameter("totalNew");
 	
 	salesquodate1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 	String remarks=request.getParameter("remarks");
	amountInWords=request.getParameter("rupees");
	 
	currtype=request.getParameter("type");
	currval=request.getParameter("curval");

	currsym=request.getParameter("cursmb");
	
	
	System.out.println("value is " +currval);
	System.out.println("Type  is " +currtype);

	String expirydate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
	int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
	group=request.getParameter("group");
	String gcd="select TheGroupCode from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupname='"+group+"'";
	ResultSet rsGcd=st.executeQuery(gcd);
	rsGcd.next();
	String gcod=rsGcd.getString("TheGroupCode");
	
	String twempname=request.getParameter("twempname");
	
	
	int squono;
	String sqlquono="SELECT MAX(SalesQuoNo) from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det ";
	ResultSet rs=st1.executeQuery(sqlquono);
	rs.next();
	squono=rs.getInt(1);
	squono++;
	System.out.println(squono);
	
	String twsalesrefno="";
	

	String salesquorefno="Exp SQ";
	String s="";
	java.text.DecimalFormat df = new java.text.DecimalFormat("000");
	String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
	
	String sqlInc="SELECT SalesquoRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesquoRefNo like ('"+salesquorefno+""+idDate+"%') ORDER BY  SalesquoRefNo DESC limit 1";
	ResultSet rs0=st2.executeQuery(sqlInc);
	
	if(rs0.next())
		salesquorefno=rs0.getString(1).substring(0,rs0.getString(1).length()-3)+df.format(Integer.parseInt(rs0.getString(1).substring(rs0.getString(1).length()-3, rs0.getString(1).length()))+1);
	else
		salesquorefno+=idDate+"001";
  	
	String sqlRef="SELECT SalesEnqRefNo   FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqNo="+salesenqno1+" LIMIT  1";
	ResultSet rsRef=st2.executeQuery(sqlRef);
	
	rsRef.next();
			twsalesrefno=rsRef.getString(1)+"/"+salesquorefno;
	
	String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det (SalesQuoNo , CustomerCode , SalesEnqNo , SalesQuoDate,"+
			
			"SalesQuoTime , TWSalesRefNo , TermsAndConditions , Total,"+
			
			"DiscountPercent , TotalinWords , SalesQuoCancelled , RevofSalesQuoNo,"+
			
			"NoofRevisions , ReasonForCancellingQuo , TheGroup , PendingItemsRemarks,"+
			
			"InvoiceGenerated , CustRefNo , CustRemarks , ThisIsSalesOrder,"+
			
			"TWSalesOrderNo , SalesOrderDate , CurrType , CurrValue,"+
			
			"TWEmpName , SODate , GrandTotal , AddressCode , CompanyName , ContactPerson,"+
			
			"Address ,city, Zip, State, country, Phone, Fax, SQRefNo, SQValidityPeriod,"+
			
			"SQExtnofSalesQuoNo, SQNoOfExtensions, SalesquoRefNo, RevOfSalesquoRefNo,"+
			
			"TWSalesOrderRefNo, SQExtnofSalesQuoRefNo, QuotationType, QuotationPrinted)"+
			
			"VALUES ('"+squono+"','"+customercode+"','"+salesenqno1+"','"+salesquodate1+"',"+
					
			"'"+todaysTime+"','"+twsalesrefno+"','"+terms+"','"+total+"',"+
					
			"'0.00','"+amountInWords+"','0','0' ,"+
					
			"'0','-','"+gcod+"','0',"+
						
			"'0','-','"+remarks+"','0',"+
			 
			"'0','0000-00-00','"+currtype+"','"+currval+"',"+
			
		"'"+session.getAttribute("EmpName")+"','0000-00-00','"+total+"','"+acode+"',"+
					
			"'"+company1+"','"+contactperson+"','"+address+"','"+city+"',"+
					
			"'"+zip+"','"+state+"','"+country+"','"+phone+"',"+
					
			"'"+fax+"','-','"+expirydate1+"','0',"+
				
			"'0','"+salesquorefno+"','-','0',"+
		
			"'NULL','OldTaxQuotation','0')";			
		
	System.out.println(""+sqlInsert);
	st2.executeUpdate(sqlInsert);
	
	for(i=0;i<number;i++)
	{
		String priceacc=request.getParameter("priceaccepted"+i);
		
		String description1=request.getParameter("description"+i);
		discount1=request.getParameter("discount"+i);
		tax1=request.getParameter("tax"+i);
		quantity1=request.getParameter("quantity"+i);
		
		
		
		sellingprice1=request.getParameter("NewunitD"+i);
		
		
		
		
		String make=request.getParameter("make"+i);
		String itemcode=request.getParameter("icode"+i);
		String gcode=request.getParameter("gcode"+i);
		String mcode=request.getParameter("mcode"+i);
		
		System.out.println(request.getParameter("gcode"+i)+" ************");
		
		int no=Integer.parseInt(request.getParameter("gcode"+i));
		String tableToBeAccessed="";
		if(no< 5)
		{
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
		}else 
			tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
		
		String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items (SalesQuoNo ,TheGroup, Make, ItemCode,"+
				"Quantity, SellingPrice, DiscountPercent, TheTableToBeAccessed, TheOptionNo,"+
				"InsertOR, STPercent, SQBalanceItems, ItemSrno, ItemDescription, TaxType)"+
				"VALUES ('"+squono+"','"+gcode+"','"+mcode+"','"+itemcode+"','"+quantity1+"','"+sellingprice1+"','"+discount1+"','"+tableToBeAccessed+"','0','-','"+tax1+"','1','0','"+description1+"','NIL')";
		st3.executeUpdate(sql);
		
		String sqlUpdate="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items SET PriceQuoted='1' WHERE SalesEnqNo='"+salesenqno1+"'";
		st4.executeUpdate(sqlUpdate);
		
	}
//	response.sendRedirect("alertGoTo.jsp?msg=Record Saved Succesfully.&goto=home.jsp");
	
	response.sendRedirect("alertGoTo.jsp?msg=Sales Quotation added successfully with Ref NO :"+salesquorefno+" For Company "+company1+".This will redirect you to print Quotation .&goto=printsalesexpquotation.jsp?salesQuotation="+squono+"/"+currsym+"");
	}
	catch(Exception e)
	{
	System.out.println( "Exception in INSERT QUOTATION ::"+e );
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	}
	finally
	{
	con.close();
	}
%>