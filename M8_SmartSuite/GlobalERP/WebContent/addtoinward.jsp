<%@page import="java.util.Date"%>

<%@ include file="ConnForIncident.jsp"%>

<%!
Connection con1,conn;
%>
<%
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	
	String amount="",category="",subject="",from="",billno="",address="",billdate="",billduedate="",accountno="";
	
	amount=request.getParameter("amount");
	category=request.getParameter("category");
	subject=request.getParameter("subject");
	from=request.getParameter("from");
	billno=request.getParameter("billno");
	address=request.getParameter("address");
	
	billdate=request.getParameter("billdate");
	
	billdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(billdate));
	billduedate=request.getParameter("billduedate");
	billduedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(billduedate));

	accountno=request.getParameter("accountno");
	
	
	

	//String name=request.getParameter("name");
%>

<%
try{	
	
	String host = System.getenv("DB_GLOBALERP_HOST");
	String user = System.getenv("DB_GLOBALERP_USER");
	String pass = System.getenv("DB_GLOBALERP_PASS");
	
	System.out.println("INPOAGE   ");
	Class.forName("com.mysql.cj.jdbc.Driver");

	con1=DriverManager.getConnection("jdbc:mysql://"+host+"/db_GlobalERP",user,pass);

	//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_leaveapplication","erp","1@erp");
	conn=DriverManager.getConnection("jdbc:mysql://"+host+"/db_leaveapplication",user,pass);

	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();	
	Statement st2=con1.createStatement();
	
	Statement stleave=conn.createStatement();
	Statement stleave1=conn.createStatement();
	Statement stleave2=conn.createStatement();
	Statement stleave3=conn.createStatement();
	
	
	
	
	
		
		String check="select * from db_leaveapplication.t_inwarddetails where Subject='"+subject.replaceAll("'"," ")+"' and Category='"+category.replaceAll("'"," ")+"' and BillDueDate='"+billduedate.replaceAll("'"," ")+"' ";
		ResultSet rscheck=stleave1.executeQuery(check);
		System.out.println("select query is " +check);

		System.out.println(check);
		if(rscheck.next())
		{
			System.out.println("Addedd already  ");
			
			String inwrdno=rscheck.getString("InwardRefNo");
			
			String update="Update db_leaveapplication.t_inwarddetails SET Subject='"+subject.replaceAll("'"," ")+"',Category='"+category.replaceAll("'"," ")+"' ,BillDueDate='"+billduedate+"',FromParty='"+from.replaceAll("'"," ")+"',Address='"+address.replaceAll("'"," ")+"',BillNo='"+billno+"',BillAmt='"+amount+"',BillDate='"+billdate+"' where InwardRefNo='"+inwrdno+"'";
			System.out.println("update is " +update);
			stleave2.executeUpdate(update);
		}
		else
		{
		try{
	
			
			int i=0,j=0,iwno=0;
			String refno="",dt="",a="";
			String date=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());
			java.text.DecimalFormat df = new java.text.DecimalFormat("00");
			
			    refno="IW";
				//String sqlIwno="select rid, InwardNo, InwardDate from "+session.getAttribute("CompanyMasterID").toString()+"inwarddetails order by rid Desc limit 1";
		        String sqlIwno="SELECT rid,InwardRefNo  from db_leaveapplication.t_inwarddetails  where InwardRefNo like ('"+refno+""+date+"%') ORDER BY InwardRefNo DESC LIMIT 1";
				
				ResultSet rst=stleave.executeQuery(sqlIwno);
				System.out.println("select rid and iward"  +sqlIwno);
				if(rst.next())
				{
					String a1=rst.getString(2);
					System.out.println(">>>>a1>>>>  "+a1);
					iwno=rst.getInt("rid");
					System.out.println(">>>iwno>>>>>  "+iwno);

					
					
					refno=rst.getString(2).substring(0,rst.getString(2).length()-2)+df.format(Integer.parseInt(rst.getString(2).substring(rst.getString(2).length()-2, rst.getString(2).length()))+1);
					System.out.println(">>>Ref no is >>>>>  " +refno);
				}
				else
				{
					refno+=date+"001";	
				}
		

		System.out.println("BEfore  ");
		
						 String sqlInsert="Insert into db_leaveapplication.t_inwarddetails (InwardNo,InwardRefNo,ManualRef,InwardDate,"+
						 "InwardTime,FromParty,PartyRefNo,Address,ToEmploy,ToEmailID,Subject,Dept,Category,"+
						 "BillNo,BillAmt,BillDate,BillDueDate,agreementParty,agreementDate,agreementFrom,"+
						 "agreementTo,FileName,FileLocation,Enteredby,EnteredById,EmailSend,"+
						 "senderRemark,receiverRemark,CheckStatus,InwrdPriority,InwardStatus,UpdatedDateTime,BillStatus,Keywords,Type)"+
						 " VALUES ('"+iwno+"','"+refno+"','-','"+todaysDate+"',"+
						 " '"+todaysTime+"','"+from.replaceAll("'"," ")+"','-','"+address.replaceAll("'"," ")+"','-','-','"+subject.replaceAll("'"," ")+"','-','"+category.replaceAll("'"," ")+"',"+
						 " '"+billno+"','"+amount+"','"+billdate+"','"+billduedate+"' ,'-','0000-00-00' ,'0000-00-00',"+
						 " '0000-000-00','-','-','"+session.getAttribute("EmpName")+"','0','No',"+
						 " '-','-','UnChecked','-','Pending','0000-00-00 00:00:00','UnPaid','-' ,'-' )";
		System.out.println("Final insert"   +sqlInsert);
		stleave1.executeUpdate(sqlInsert);
		System.out.println("After");
		
		
		response.sendRedirect("alertForFilestatus.jsp?msg=Repeated Payment Entry  Is Successfully Updated. &goto=RepeatEntry.jsp");

		}catch(Exception e)
		{
			e.printStackTrace();
		}
		}
		
	
	//out.print("Yes");
	
}
catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect("alertGoTo.jsp?msg=!!!! ERROR Inserting Record.Please try again.&goto=javascript:history.back()");

	//out.print("No");
}

%>