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
	System.out.println(">>>>>>>>>>>In revise Purchase Order<<<<<<<<<<<<<<<<<<<<<<");	
	
	
	int count=Integer.parseInt(request.getParameter("count").toString());
	System.out.println(">>>    "+count);	
	
	String PurOrderRefNumber=request.getParameter("PurOrderRefNumber");
	String purquo=request.getParameter("purquo");
	String contactperson=request.getParameter("contactperson");
	String podate=request.getParameter("podate");
	
	String potime=request.getParameter("potime");
	String terms=request.getParameter("terms");
	String total=request.getParameter("total");
	System.out.println(">>>>>>>>>>>>>Total:"+total);
	String amountinwords=request.getParameter("rupees");
	String revofpono=request.getParameter("revofpono");
	String supliercode=request.getParameter("supliercode");
	String noofrev=request.getParameter("noofrev");
	String contact=request.getParameter("contactperson");
	String Address=request.getParameter("address");
	String City=request.getParameter("city");
	String Zip=request.getParameter("zip");
	String State=request.getParameter("state");
	String Country=request.getParameter("country");
	String phone=request.getParameter("phone");
	String fax=request.getParameter("fax");
	String grandtotal=request.getParameter("total");
	System.out.println(">>>>>>>>>>>>>grandTotal:"+grandtotal);
	String reason=request.getParameter("reason");
	String discount=request.getParameter("discount");
	String poref=request.getParameter("poref");
	String desaddr=request.getParameter("desaddr");
	String pendpo=request.getParameter("pendpo");
	String reasonp=request.getParameter("reasonp");
	String curtype=request.getParameter("curtype");
	String curvalue=request.getParameter("curvalue");
	String sentby=request.getParameter("sentby");
	String po=request.getParameter("po");
	String a=request.getParameter("duedate");
	System.out.println("comping date is   "+a);
	
	String groupname=request.getParameter("groupname");
	System.out.println("<><><<<<><   GRI+UOP NAMES IS   "+groupname);
	String duedate="";
	if(a=="NA")
	{
		duedate=a;	
	}
	else
	{
	 duedate =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("duedate")));
	}
	System.out.println(">>>>>>>>>>>>>duedate:"+duedate);
	String delvdate=request.getParameter("delvdate");
	if(delvdate=="NA")
	{
		delvdate="NA";	
	}
	else
	{
		delvdate =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("delvdate")));
	}
	System.out.println(">>>>>>>>>>>>>delvdate:"+delvdate);
	String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder set  POCancelled=1 where PONo='"+PurOrderRefNumber+"'";
	System.out.println(sqlUpdate);	
	st.executeUpdate(sqlUpdate);
	
	int sono=0;
		String sqlOrderno="SELECT MAX(PONo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
			sono=rs.getInt(1);
	sono++;
	
	String sqlData="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder(PONo,PurQuoNo,PODate ,POTime ,Terms,RevOfPOno ,NoOfRev,ReasonForCancelling,Total,DiscountPercent ,GrandTotal,TotalinWords,SentBy ,SupplierCode ,POReference,despatchAddress ,PORaisedByCompany ,PendingPODetails,PODueDate,ReasonforPendingPO ,DeliveryDate ,CurrType ,CurrValue)Values('"+sono+"','"+purquo+"','"+podate+"','"+potime+"','"+terms+"','"+revofpono+"','"+noofrev+"','"+reason+"','"+total+"','"+discount+"','"+grandtotal+"','"+amountinwords+"','"+sentby+"','"+supliercode+"','"+poref+"','"+desaddr+"','"+po+"','"+pendpo+"','"+duedate+"','"+reasonp+"','"+delvdate+"','"+curtype+"','"+curvalue+"')";

	System.out.println(sqlData);	
	st2.executeUpdate(sqlData);
	
	for(i=0;i<count;i++)
	{
	String gcode=request.getParameter("groupcode"+i);	
	String mcode=request.getParameter("makecode"+i);
	String icode=request.getParameter("itemcode"+i);
	String quan=request.getParameter("quantity"+i);
	System.out.println("GCODE GCODE   "+quan);
	String discount1=request.getParameter("discount"+i);
	System.out.println(discount1);
	String sellingprice=request.getParameter("sellingprice"+i);
	System.out.println(">>>>>>>>>>>>  PRICE  "+sellingprice);
	
	String desc=request.getParameter("description"+i);
	
	int no=Integer.parseInt(gcode);
	System.out.println("&*&&&**&*&*&*&*&*     "+no);
	System.out.println("GROUP NAME   "+groupname);
	String tableToBeAccessed="";
	String grpcd="select TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode='"+gcode+"'";
	ResultSet rscd=st1.executeQuery(grpcd);
	rscd.next();
	String grpnm=rscd.getString(1);
	if(no< 5)
	{
		tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+grpnm.substring(0,5).toLowerCase()+"im_make"+mcode+"";
	}
	else 
		tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
	System.out.println("TABLE TO BE ACCCCC       "+tableToBeAccessed);
	
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items(PONo,TheGroup,Make,ItemCode,Quantity,UnitPrice,TheTableToBeAccessed) values('"+sono+"','"+gcode+"','"+mcode+"','"+icode+"','"+quan+"','"+sellingprice+"','"+tableToBeAccessed+"')";
	
	System.out.println(sqlInsert);
	st3.executeUpdate(sqlInsert);
	
	
	}
	int no1=0;
	String Sqlselect="Select NoOfRev from "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder where PONo='"+sono+"'";
	ResultSet rss=st3.executeQuery(Sqlselect);
	if(rss.next())
	{
		no1=rss.getInt(1);
		
	}
	no1=no1+1;
	String sql="UPDATE  "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder set NoOfRev='"+no1+"'  where PONo='"+sono+"' limit 1  ";
	System.out.println(sql);
	st.executeUpdate(sql);
	
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Order Revised successfully &goto=home.jsp");
		
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