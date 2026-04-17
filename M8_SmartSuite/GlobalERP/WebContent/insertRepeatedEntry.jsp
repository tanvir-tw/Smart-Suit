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
		
		String var=request.getParameter("var");
		System.out.println(var);	
		if(var==null || var.equals("null"))
		{
			String accountno=request.getParameter("accno");
			String from=request.getParameter("from");
			String subject=request.getParameter("subject");
			String address=request.getParameter("address");
			String category=request.getParameter("category");
			String billno=request.getParameter("billno");
			String billamount=request.getParameter("billamount");
			String billdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date")));
			String billduedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date1")));
			System.out.println(accountno+" "+from+" "+subject+" "+address+" "+category+" "+billamount+""+billno+""+billdate+""+billduedate);
		
		String sql="select Max(SrNo) from "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment";
		ResultSet rs=st.executeQuery(sql);
		rs.next();
		int srno=rs.getInt(1);
		srno++;
		
		String sqldata="Insert into "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment (SrNo,Category, FromDetails, Address, Subject,BillNo,BillAmount,AccountNo,BillDate,BillDueDate)"+
					   " Values ('"+srno+"','"+category.replaceAll("'"," ")+"','"+from.replaceAll("'"," ")+"','"+address.replaceAll("'"," ")+"','"+subject.replaceAll("'"," ")+"','"+billno+"','"+billamount+"','"+accountno.replaceAll("'"," ")+"','"+billdate+"','"+billduedate+"')";
		System.out.println(sqldata);
		st.executeUpdate(sqldata);
		
		response.sendRedirect("alertGoTo.jsp?msg=New Repeated Payment Entry Is Successfully Inserted In System. &goto=RepeatEntry.jsp");
		}
		else if(var.equalsIgnoreCase("new") )
		{
			
			String srno1=request.getParameter("srno");
			System.out.println(var);	
			
			String accountno=request.getParameter("accno");
			String from=request.getParameter("from");
			String subject=request.getParameter("subject");
			String address=request.getParameter("address");
			String category=request.getParameter("category");
			String billno=request.getParameter("billno");
			String billamount=request.getParameter("billamount");
			String billdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date")));
			String billduedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date1")));
			System.out.println(accountno+" "+from+" "+subject+" "+address+" "+category+" "+billamount+""+billno+""+billdate+""+billduedate);
			
			String sqlUpdate="Update "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment "+
							 " SET Category ='"+category.replaceAll("'"," ")+"', FromDetails='"+from.replaceAll("'"," ")+"', Address='"+address.replaceAll("'"," ")+"', Subject='"+subject.replaceAll("'"," ")+"',BillNo='"+billno+"' , BillAmount='"+billamount+"' , AccountNo='"+accountno.replaceAll("'"," ")+"',BillDate='"+billdate+"',BillDueDate='"+billduedate+"' "+
							 " where SrNO='"+srno1+"'";
			System.out.println(sqlUpdate);
			st.executeUpdate(sqlUpdate);
			response.sendRedirect("alertForFilestatus.jsp?msg=Repeated Payment Entry  Is Successfully Updated. &goto=RepeatEntry.jsp");
		}
		
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