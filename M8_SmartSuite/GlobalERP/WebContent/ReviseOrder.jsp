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
		
	int count=Integer.parseInt(request.getParameter("count").toString());
	System.out.println(">>>    "+count);	
	String groupname=request.getParameter("groupname");
	System.out.println("GROUP NAME  TTTT        "+groupname);
	String salesorder=request.getParameter("salesorderno");
	String salesquono=request.getParameter("salesquono");
	String customercode=request.getParameter("customercode");
	String orderdate=request.getParameter("orderdate");
	String ordertime=request.getParameter("ordertime");
	String terms=request.getParameter("termsconditions");
	String total=request.getParameter("total");
	String amountinwords=request.getParameter("rupees");
	String group=request.getParameter("groupcode");
	String addcode=request.getParameter("addresscode");
	String companyname=request.getParameter("company");
	String contact=request.getParameter("contactperson");
	String Address=request.getParameter("address");
	String City=request.getParameter("city");
	String Zip=request.getParameter("zip");
	String State=request.getParameter("state");
	String Country=request.getParameter("country");
	String Phone=request.getParameter("phone");
	String Fax=request.getParameter("fax");
	System.out.println("QUO NO    "+Address);
	
	String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det set SOCancelled=1 where SalesOrderNo='"+salesorder+"'";
	System.out.println(sqlUpdate);	
	st.executeUpdate(sqlUpdate);
	
	int sono=0;
		String sqlOrderno="SELECT MAX(SalesOrderNo) from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
			sono=rs.getInt(1);
	sono++;
	
	
	
	
	
	String salesorderrefno="SO";
	String s="";
	java.text.DecimalFormat df = new java.text.DecimalFormat("000");
	String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
	String sqlInc="SELECT SalesorderRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesorderRefNo like ('"+salesorderrefno+""+idDate+"%') "+
				" ORDER BY  SalesorderRefNo DESC limit 1";
	ResultSet rs0=st1.executeQuery(sqlInc);

	if(rs0.next())
		salesorderrefno=rs0.getString(1).substring(0,rs0.getString(1).length()-3)+df.format(Integer.parseInt(rs0.getString(1).substring(rs0.getString(1).length()-3, rs0.getString(1).length()))+1);
	else
		salesorderrefno+=idDate+"001";
	
	String sqlData="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det (SalesOrderNo ,SalesQuoNo ,CustSalesOrderNo ,CustomerCode ,SalesOrderDate ,SalesOrderTime, "+
					"SOTermsAndConditions ,Total ,DiscountPercent ,TotalinWords ,TheGroup ,InvoiceGenerated ,CurrType ,CurrValue ,TWEmpName, "+
					"SOCancelled ,SOCancelledOnDate ,RevofSOrderNo ,NoofRevisions ,ReasonForCancellingSO ,Grandtotal ,AddressCode ,CompanyName, "+	
					"ContactPerson ,Address ,city ,Zip ,State ,country ,Phone ,Fax ,SalesorderRefNo ,RevofSOrderRefNo ,OrderType ,OrderPrinted)"+
					"VALUES('"+sono+"','"+salesquono+"','-','"+customercode+"','"+orderdate+"','"+ordertime+"', "+
					" 	'"+terms+"'	,'"+total+"','0.00','"+amountinwords+"','"+group+"','0','Rupees','1','"+session.getAttribute("EmpName")+"', "+
					"  '0','0000-00-00','0','0','-','0.00','"+addcode+"','"+companyname+"', "+
					"  '"+contact+"','"+Address+"','"+City+"','"+Zip+"','"+State+"','"+Country+"','"+Phone+"','"+Fax+"','"+salesorderrefno+"','Null','NewTaxOrder','NO' )";
	
	System.out.println(sqlData);	
	st2.executeUpdate(sqlData);
	
	for(i=0;i<count;i++)
	{
	String gcode=request.getParameter("groupcode"+i);	
	String mcode=request.getParameter("makecode"+i);
	String icode=request.getParameter("itemcode"+i);
	String quan=request.getParameter("quantity"+i);
	System.out.println("GCODE GCODE   "+quan);
	String tax1=request.getParameter("tax"+i);
	System.out.println(tax1);
	String discount1=request.getParameter("discount"+i);
	System.out.println(discount1);
	String sellingprice=request.getParameter("sellingPrice"+i);
	String desc=request.getParameter("description"+i);
	String amount=request.getParameter("amount"+i);
	int no=Integer.parseInt(gcode);
	System.out.println("&*&&&**&*&*&*&*&*     "+no);
	String tableToBeAccessed="";
	if(no< 5)
	{
		tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupname.substring(0,5).toLowerCase()+"im_make"+mcode+"";
	}
	else 
		tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
	System.out.println("TABLE TO BE ACCCCC       "+tableToBeAccessed);
	
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items (SalesOrderNo,	TheGroup ,Make ,ItemCode ,Quantity ,SellingPrice ,DiscountPercent, "+
			"InvRaisedQty ,TheTableToBeAccessed ,TheOptionNo ,InsertOR ,STPercent ,ItemSrno ,ItemDescription ,TaxType) "+
			"values('"+sono+"','"+gcode+"','"+mcode+"','"+icode+"','"+quan+"','"+sellingprice+"','"+discount1+"', "+
			"	'0','"+tableToBeAccessed+"','0','-','"+tax1+"','0','"+desc+"','NIL' )";
	
	System.out.println(sqlInsert);
	st3.executeUpdate(sqlInsert);
	
	
	}
	
	
	String sql="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det  set ThisIsSalesOrder='1'  where SalesQuoNo='"+salesquono+"' limit 1  ";
	System.out.println(sql);
	st.executeUpdate(sql);
	
	response.sendRedirect("alertGoTo.jsp?msg=Sales Order Revised successfully &goto=home.jsp");
		
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