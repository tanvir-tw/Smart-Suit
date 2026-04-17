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
	System.out.println(">>>>>>>>>>>>>>>>>>>>In Revise Purchase Enquiry>>>>>>>>>>>>>>>>>>>>>>>");	
	
	String Suppliercode="",SalesEnqNo="",PurEnqDate="",DueDate="",TWRefNo="",Remarks="",SentBy="",PurEnqTime="",SalesenqRecvdDate="",SalesenqRecvdTime="",PurEnqClosed="",ReasonForClosing="",ModeOfDelivery="",DateOfDelivery=""; 	
	int count=Integer.parseInt(request.getParameter("count").toString());
	System.out.println(">>> count:   "+count);	
	int QuoReceived=0;
	String PurEnqNumber=request.getParameter("PurEnqNumber");
    PurEnqDate=request.getParameter("enqdate");
    System.out.println(">>>>>>>>>>>PurEnqDate:"+PurEnqDate);
    DueDate=request.getParameter("duedate");
    System.out.println(">>>>>>>>>>>DueDate:"+DueDate);
	String SqlEnq="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq where PurchaseEnqNo='"+PurEnqNumber+"' ";
	ResultSet rsEnq=st.executeQuery(SqlEnq);
	System.out.println(">>>    "+SqlEnq);	
	while(rsEnq.next())
	{
		Suppliercode=rsEnq.getString("Suppliercode");
		SalesEnqNo=rsEnq.getString("SalesEnqNo");
		TWRefNo=rsEnq.getString("TWRefNo");
		Remarks=rsEnq.getString("Remarks");
		SentBy=rsEnq.getString("SentBy");
		PurEnqTime=rsEnq.getString("PurEnqTime");
		SalesenqRecvdDate=rsEnq.getString("SalesenqRecvdDate");
		SalesenqRecvdTime=rsEnq.getString("SalesenqRecvdTime");
		QuoReceived=rsEnq.getInt("QuoReceived");
		PurEnqClosed=rsEnq.getString("PurEnqClosed");
		ReasonForClosing=rsEnq.getString("ReasonForClosing");
		ModeOfDelivery=rsEnq.getString("ModeOfDelivery");
		try
		{
		 DateOfDelivery=rsEnq.getString("DateOfDelivery");
		}
		catch(Exception e)
		{
			DateOfDelivery="0000-00-00";	
		    //e.printStackTrace();
		}
	}
	

	int peno=0;
		String sqlOrderno="SELECT MAX(PurchaseEnqNo) from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq ";
		ResultSet rs=st3.executeQuery(sqlOrderno);
		rs.next();  
		    peno=rs.getInt(1);
		peno++;
		System.out.println(sqlOrderno);	
		System.out.println(">>>>>>>>>>>>>>QuoReceived:"+QuoReceived);	
	String sqlData="INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq(PurchaseEnqNo,Suppliercode,SalesEnqNo,TWRefNo,PurEnqDate,Remarks,DueDate,SentBy,PurEnqTime,"+
			"SalesenqRecvdDate,SalesenqRecvdTime, ReasonForClosing,ModeOfDelivery,DateOfDelivery,QuoReceived,PurEnqClosed)"+
			" Values('"+peno+"','"+Suppliercode+"','"+SalesEnqNo+"','"+TWRefNo+"','"+PurEnqDate+"','"+Remarks+"','"+DueDate+"','"+SentBy+"','"+PurEnqTime+"',"+
			"'"+SalesenqRecvdDate+"', '"+SalesenqRecvdTime+"','"+ReasonForClosing+"','"+ModeOfDelivery+"','"+DateOfDelivery+"','"+QuoReceived+"','"+PurEnqClosed+"')";
	System.out.println(sqlData);	
	st2.executeUpdate(sqlData);
	String groupname=request.getParameter("groupname");
	System.out.println(">>>>>>>>>>>>>>>>>>>>    "+groupname);

	for(i=0;i<count;i++)
	{
	String gcode=request.getParameter("groupcode"+i);	
	String mcode=request.getParameter("makecode"+i);
	String icode=request.getParameter("itemcode"+i);
	String quan=request.getParameter("quantity"+i);
	System.out.println("GCODE GCODE   "+quan);
	int no=Integer.parseInt(gcode);
	System.out.println("&*&&&**&*&*&*&*&*     "+no);
	String recommended=request.getParameter("recommended"+i);
	System.out.println(">>>>>>>>recommended:"+recommended);
	String tableToBeAccessed="";
	if(no< 5)
	{	System.out.println(" IN IF   ");

		tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupname.substring(0,5).toLowerCase()+"im_make"+mcode+"";
	}
	else {	System.out.println("IN esle");

		tableToBeAccessed=""+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+gcode;
	}
	System.out.println("TABLE TO BE ACCCCC       "+tableToBeAccessed);
	
	String sqlInsert="Insert into "+session.getAttribute("CompanyMasterID").toString()+"enquireditems(PurchaseEnqNo,TheGroup,Make,ItemCode,Quantity,RecommendedSupp,TheTableToBeAccessed)"+
					 "values('"+peno+"','"+gcode+"','"+mcode+"','"+icode+"','"+quan+"','"+recommended+"','"+tableToBeAccessed+"')";
	
	System.out.println(sqlInsert);
	st3.executeUpdate(sqlInsert);
	
	String SqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq set PurEnqClosed=1 where PurchaseEnqNo='"+PurEnqNumber+"'"; 
 	System.out.println(">>>>>>>>>>>>"+SqlUpdate);
	st1.executeUpdate(SqlUpdate);
	
	
	}
	
	
	response.sendRedirect("alertGoTo.jsp?msg=Purchase Enquiry Revised successfully!!! &goto=home.jsp");
		
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