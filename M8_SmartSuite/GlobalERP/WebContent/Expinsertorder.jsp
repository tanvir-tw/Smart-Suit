<%@page import="java.util.Date"%>
<%@ include file="conn.jsp"%>


<%
	Connection con=null ;
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	Statement st=null,st1=null,st2=null,st3=null;
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
%>

<%
	
	try{	
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		int i=0;
		int a=0;
		String salesorderno="",custsalesorderno="";
		String salesorderdate="",salesordertime="";
		String discount="",tax="";
		String group="",quantity1="",sellingprice="";
		String description="";
		
		String checkno=request.getParameter("checkedNumber");
		String customercode=request.getParameter("customercode");
		String salesquodate=request.getParameter("salesquodate");
		String contactperson=request.getParameter("contactperson");
		String state=request.getParameter("state");
		String address=request.getParameter("address");
		String fax=request.getParameter("fax");
		String phone=request.getParameter("phone");
		String city=request.getParameter("city");
		String country=request.getParameter("country");
		String zip=request.getParameter("zip");
		String salesquorefno=request.getParameter("salesquorefno");
		String company=request.getParameter("companyname");
		String salesquono=request.getParameter("salesquono");
		String terms=request.getParameter("terms");
		
		String Ctype=request.getParameter("currtype");
		String Cval=request.getParameter("currval");

		String Csym=request.getParameter("currsym");

		String total=request.getParameter("totalNew");
		
		System.out.print(total+"  !!!!!!!!!!");
		String amountinwords=request.getParameter("rupees");
		String addresscode=request.getParameter("addresscode");
		String twempname=request.getParameter("twempname");
		int number=Integer.parseInt(request.getParameter("checkedNumber").toString());
		//String gcode=request.getParameter("gcode");
		//System.out.println("GROUP CODE IS      "+gcode);
		group=request.getParameter("group"); 
		System.out.println("GRUOP ID +++++   "+group);
		
		String gname="select TheGroupCode from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupName='"+group+"'";
		ResultSet rsgrp=st.executeQuery(gname);
		rsgrp.next();
		String grpcd=rsgrp.getString("TheGroupcode");
		
		/*String sqlDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det WHERE SalesQuoNo='"+ salesquono + "' ";
		ResultSet rsDet = st1.executeQuery(sqlDet);
		rsDet.next();*/
					
		int sono=0;
		String sqlOrderno="SELECT MAX(SalesOrderNo) from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
			sono=rs.getInt(1);
		sono++;
		
		
		String salesorderrefno="EXP SO";
		String s="";
		java.text.DecimalFormat df = new java.text.DecimalFormat("000");
		String idDate =  new SimpleDateFormat("ddMMyy").format(new Date());
		
		String sqlInc="SELECT SalesorderRefNo  from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesorderRefNo like ('"+salesorderrefno+""+idDate+"%') "+
						" ORDER BY  SalesorderRefNo DESC limit 1";
		ResultSet rs0=st2.executeQuery(sqlInc);
		
		if(rs0.next())
			salesorderrefno=rs0.getString(1).substring(0,rs0.getString(1).length()-3)+df.format(Integer.parseInt(rs0.getString(1).substring(rs0.getString(1).length()-3, rs0.getString(1).length()))+1);
		else
			salesorderrefno+=idDate+"001";
		
		//SO220613002
		
		String sql="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det (SalesOrderNo ,SalesQuoNo,	CustSalesOrderNo,CustomerCode, "+ 
				
				"SalesOrderDate, SalesOrderTime, SOTermsAndConditions,Total, "+
				
				"DiscountPercent,TotalinWords, TheGroup,InvoiceGenerated, "+
				
				"CurrType,CurrValue,TWEmpName,SOCancelled,SOCancelledOnDate,"+ 	
				
				"RevofSOrderNo,	NoofRevisions,ReasonForCancellingSO,Grandtotal,AddressCode ,"+
				
				"CompanyName,ContactPerson,	Address,city,Zip,State,country,"+ 	
				
				"Phone,Fax,	SalesorderRefNo,RevofSOrderRefNo,OrderType,OrderPrinted)"+
				
				"VALUES('"+sono+"','"+salesquono+"','-','"+customercode+"',"+
						
				"'"+todaysDate+"','"+todaysTime+"','"+terms+"','"+total+"',"+
				
				"'0.00','"+amountinwords+"','"+grpcd+"','0' ,"+
				
				"'"+Ctype+"','"+Cval+"','"+session.getAttribute("EmpName")+"','0' ,"+
				
				"'0000-00-00','0','0','-' ,"+
				
				"'"+total+"','"+addresscode+"','"+company+"','"+contactperson+"' ,"+
				
				"'"+address+"','"+city+"','"+zip+"','"+state+"' ,"+
				
				"'"+country+"','"+phone+"','"+fax+"','"+salesorderrefno+"' ,"+
				
				"'0','OldTaxOrder','No')";
		
		
	st.executeUpdate(sql);	
		
		for(i=0;i<number;i++)
		{
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
					if(no< 5)
					{
						tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+group.substring(0,5).toLowerCase()+"im_make"+mcode+"";
						System.out.println(tableToBeAccessed);
					}else 
						tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+grpcd;
					
					String sqlInsert="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items (SalesOrderNo,	TheGroup,Make,ItemCode,"+ 	
								"Quantity,SellingPrice,	DiscountPercent ,InvRaisedQty,TheTableToBeAccessed, "+
								"TheOptionNo,InsertOR,STPercent,ItemSrno,ItemDescription,TaxType)"+
								"VALUES('"+sono+"','"+no+"','"+mcode+"','"+icode+"','"+quantity1+"','"+sellingprice+"','"+discount+"','0','"+tableToBeAccessed+"','0','NULL','"+tax+"','"+checkno+"','"+description+"','NIL')";
				
				st1.executeUpdate(sqlInsert);	
			}
		}
		
		sql="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det  set ThisIsSalesOrder='1'  where SalesQuoNo='"+salesquono+"' limit 1  ";
		st.executeUpdate(sql);
		
		//response.sendRedirect("alertGoTo.jsp?msg=Record Saved Successfully.&goto=home.jsp");
		response.sendRedirect("alertGoTo.jsp?msg=Sales Order added successfully with Order No: "+salesorderrefno+" For Company: "+company+" .This will redirect you to print Order .&goto=printexpSaleorder.jsp?salesOrder="+sono+"/"+Csym+"");
	}
	catch(Exception e)
	{
		System.out.println( "Exception ::"+e );
		e.printStackTrace();
		response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");
	}
	finally
	{
		con.close();
	}
%>	