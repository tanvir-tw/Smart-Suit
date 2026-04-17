<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>

<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
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
				
	   String salesquo=request.getParameter("salesquono");
	   int count=Integer.parseInt(request.getParameter("count").toString());
	   String customercode=request.getParameter("customercode");
	   String salesenqno=request.getParameter("salenqno");
	   String terms=request.getParameter("termsconditions");
	   String total=request.getParameter("total");
	   if(total=="")
			total="0";
	   String totalwords=request.getParameter("rupees");
	   String quoDate=request.getParameter("quodate");
		String quoTime=request.getParameter("quotime");
		String group=request.getParameter("group");
		System.out.println("GROUP GROUP GROUP        "+group);
		String gcd="SELECT TheGroupCode from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupName='"+group+"' ";
		ResultSet rsgcd=st.executeQuery(gcd);
		rsgcd.next();
		String gcod=rsgcd.getString("TheGroupCode");
		
		
		String remark=request.getParameter("custremark");
		String addcode=request.getParameter("addresscode");
		String company=request.getParameter("company");
		String address=request.getParameter("address");
		String city=request.getParameter("city");
		String zip=request.getParameter("zip");
		String state=request.getParameter("state");
		String country=request.getParameter("country");
		String contact=request.getParameter("contactperson");
		String phone=request.getParameter("phone");
		String fax=request.getParameter("fax");
		
		String expirydate1=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		
		String salesquorefno="SQ";
		String s="";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
		
		String sqlInc="SELECT SalesquoRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesquoRefNo like ('"+salesquorefno+""+idDate+"%') ORDER BY  SalesquoRefNo DESC limit 1";
		ResultSet rs0=st2.executeQuery(sqlInc);
		if(rs0.next())
			salesquorefno=rs0.getString(1).substring(0,rs0.getString(1).length()-3)+df.format(Integer.parseInt(rs0.getString(1).substring(rs0.getString(1).length()-3, rs0.getString(1).length()))+1);
		else
			salesquorefno+=idDate+"001";
		
		String twsalesrefno="";
		String sqlRef="SELECT SalesEnqRefNo   FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqNo='"+salesenqno+"' ";
		ResultSet rsRef=st2.executeQuery(sqlRef);
		rsRef.next();
			twsalesrefno=rsRef.getString(1)+"/"+salesquorefno;
		
		int squono;
		String sqlquono="SELECT MAX(SalesQuoNo) from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det ";
		ResultSet rs=st1.executeQuery(sqlquono);
		rs.next();
		squono=rs.getInt(1);
		squono++;
						
		String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det set SalesQuoCancelled=1 where SalesQuoNo='"+salesquo+"'";
		System.out.println(sqlUpdate);	
		st.executeUpdate(sqlUpdate);
				
		String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det (SalesQuoNo, CustomerCode ,SalesEnqNo,	SalesQuoDate ,SalesQuoTime ,TWSalesRefNo ,TermsAndConditions, "+
		"Total ,DiscountPercent ,TotalinWords ,SalesQuoCancelled ,RevofSalesQuoNo ,NoofRevisions ,ReasonForCancellingQuo ,TheGroup, "+
		"PendingItemsRemarks ,InvoiceGenerated ,CustRefNo ,CustRemarks ,ThisIsSalesOrder ,TWSalesOrderNo ,SalesOrderDate ,CurrType, "+	
		"CurrValue ,TWEmpName ,SODate ,GrandTotal ,AddressCode ,CompanyName ,ContactPerson ,Address ,city ,Zip ,State ,country, "+
		"Phone ,Fax ,SQRefNo ,SQValidityPeriod ,SQExtnofSalesQuoNo ,SQNoOfExtensions ,SalesquoRefNo ,RevOfSalesquoRefNo ,TWSalesOrderRefNo, "+
		"SQExtnofSalesQuoRefNo ,QuotationType ,QuotationPrinted) "+
		
		"VALUES ('"+squono+"','"+customercode+"','"+salesenqno+"','"+quoDate+"','"+quoTime+"','"+twsalesrefno+"','"+terms+"',"+
		" '"+total+"','0.00','"+totalwords+"','0','0','0','-','"+gcod+"', "+
		"  '0','0','-','"+remark+"','0','0','0000-00-00','Rupees' , "+
		"  '1','"+session.getAttribute("EmpName")+"','0000-00-00','"+total+"','"+addcode+"','"+company+"','"+contact+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"', "+
		"  '"+phone+"','"+fax+"','-','"+expirydate1+"','0','0','"+salesquorefno+"','-','0', "+
		"   'NULL','OldTaxQuotation','0')";
		System.out.println(sqlInsert);
		st1.executeUpdate(sqlInsert);
		
		for(i=0;i<count;i++)
		{
		String grpcode=request.getParameter("groupcode"+i);
		String makcode=request.getParameter("makecode"+i);
		String itemcode=request.getParameter("itemcode"+i);
		String quant=request.getParameter("quantity"+i);
		System.out.println("11111  "+quant);	
		String tax1=request.getParameter("stpercent"+i);
		System.out.println(tax1);
		String discount1=request.getParameter("discount"+i);
		System.out.println(discount1);
		String sellingprice=request.getParameter("sellingPrice"+i);
		System.out.println("2222222222  "+sellingprice);
		String amount=request.getParameter("amount"+i);
		String description=request.getParameter("description"+i);
		System.out.println("3333333333333        "+description);
		System.out.println("$$$$$$$$$$$$$$$$$$$  "+group);
		String tableToBeAccessed="";int no=0;
		if(no< 5)
		{
			tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+makcode+"";
		}
		else 
			tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+grpcode;
		
		String sqlIn="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesquo_items (SalesQuoNo ,TheGroup ,Make ,ItemCode ,Quantity ,SellingPrice ,DiscountPercent ,TheTableToBeAccessed ,TheOptionNo,"+
				     " InsertOR ,STPercent ,SQBalanceItems ,ItemSrno ,ItemDescription ,TaxType)"+
					 " Values('"+squono+"','"+grpcode+"','"+makcode+"','"+itemcode+"','"+quant+"','"+sellingprice+"','"+discount1+"','"+tableToBeAccessed+"','0',"+
					 " '-','"+tax1+"','1','0','"+description+"','NIL')";
		System.out.println(sqlIn);
		st2.executeUpdate(sqlIn);
		
		String sqlChange="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items SET PriceQuoted='1' WHERE SalesEnqNo='"+salesenqno+"'";
		System.out.println(sqlChange);
		st3.executeUpdate(sqlChange);
		
		}
	     
		response.sendRedirect("alertGoTo.jsp?msg=Sales Quotation Revised successfully &goto=home.jsp");
		
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