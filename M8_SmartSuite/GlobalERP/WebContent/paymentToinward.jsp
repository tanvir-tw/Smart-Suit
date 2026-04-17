
<%@page import="java.util.Date"%>
<%@page import="java.io.Flushable"%>
 <%@ include file="conn.jsp" %>

<%!
Connection con1,conn;
%>
<%
	DecimalFormat twoDForm = new DecimalFormat("#.##");
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	String subject="",accountno="",duedate="",category="",inwrdno="",from="",address="",billno="",billamount="",billdate="",buffer="";
	
	
	
	
	

	
	
%>

<%


try{	
	System.out.println("INPOAGE   ");
	Class.forName("com.mysql.cj.jdbc.Driver");

	con1=DriverManager.getConnection("jdbc:mysql://"+host1+"/db_GlobalERP",user1,pass1);

	//conn=DriverManager.getConnection("jdbc:mysql://twdb.fleetview.in/db_leaveapplication","erp","1@erp");
	
	conn=DriverManager.getConnection("jdbc:mysql://"+host1+"/db_leaveapplication",user1,pass1);

	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();	
	Statement st2=con1.createStatement();
	
	Statement stleave=conn.createStatement();
	Statement stleave1=conn.createStatement();
	Statement stleave2=conn.createStatement();
	Statement stleave3=conn.createStatement();
	
	/*String sqldata="Select * from "+session.getAttribute("CompanyMasterID").toString()+"repeatedPayment where ActiveStatus='Yes'";
	ResultSet rs=st.executeQuery(sqldata);
	System.out.println(" *****************  "+sqldata);
	while(rs.next())
	{
		subject=rs.getString("Subject");
		accountno=rs.getString("AccountNo");
		duedate=rs.getString("BillDueDate");
		category=rs.getString("Category");
		address=rs.getString("Address");
		billno=rs.getString("BillNo");
		billamount=rs.getString("BillAmount");
		billdate=rs.getString("BillDate");
		from=rs.getString("FromDetails");
		
		
		System.out.println(subject+" "+accountno+" "+duedate+" "+category);*/
		accountno=request.getParameter("account");

		if(accountno!="")
		{
		subject=request.getParameter("subject");
		duedate=request.getParameter("billddate");
		category=request.getParameter("category");
		from=request.getParameter("from");
		address=request.getParameter("address");
		billno=request.getParameter("billno");
		billamount=request.getParameter("billamt");
		billdate=request.getParameter("billdate");
		
		System.out.println("-- sub --"+subject);
		System.out.println("-- accountno --"+accountno);
		System.out.println("-- duedate --"+duedate);
		System.out.println("-- category --"+category);
		System.out.println("-- from --"+from);
		System.out.println("-- address --"+address);
		System.out.println("-- billno --"+billno);
		System.out.println("-- billamount --"+billamount);
		System.out.println("-- billdate --"+billdate);
		
		
		
		

		

		
		String tokensub[]=subject.split(",");
		String tokenacc[]=accountno.split(",");

		String tokendue[]=duedate.split(",");

		String tokencat[]=category.split(",");
		String tokenfrm[]=from.split(",");
		String tokenadd[]=address.split(",");
		String tokenbillno[]=billno.split(",");
		String tokenamt[]=billamount.split(",");
		String tokenbilldate[]=billdate.split(",");
		
		
		
		System.out.println("Total length is " +tokencat.length);//3	
		System.out.println("Total length1 is " +tokensub.length);//3	

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		for(int a=0;a<(tokencat.length);a++)
		{	
			System.out.println("a is " +a);

			
			System.out.println("first is " +tokensub[a]);
			
			
			
			
			
			
			
		String check="select * from db_leaveapplication.t_inwarddetails where Subject='"+tokensub[a].trim()+"' and Category='"+tokencat[a]+"' and BillDueDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tokendue[a]))+"' ";
		ResultSet rscheck=stleave1.executeQuery(check);
		System.out.println("select query is   " +check);
		if(rscheck.next())
		{
			System.out.println("Addedd already  ");
			inwrdno=rscheck.getString("InwardRefNo");
			String update="Update db_leaveapplication.t_inwarddetails SET Subject='"+tokensub[a].trim()+"',Category='"+tokencat[a].trim()+"' ,BillDueDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tokendue[a]))+"',FromParty='"+tokenfrm[a].trim()+"',Address='"+tokenadd[a].trim()+"',BillNo='"+tokenbillno[a].trim()+"',BillAmt='"+tokenamt[a].trim()+"',BillDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tokenbilldate[a]))+"' where InwardRefNo='"+inwrdno+"'";
			System.out.println("update query is " +update);
			stleave2.executeUpdate(update);
			
		}
		else
		{
		try{
	
			
			int i=0,j=0,iwno=0;
			String refno="",dt="";
			String date=new SimpleDateFormat("ddMMyyyy").format(new java.util.Date());
			java.text.DecimalFormat df = new java.text.DecimalFormat("00");
			    refno="IW";
				//String sqlIwno="select rid, InwardNo, InwardDate from "+session.getAttribute("CompanyMasterID").toString()+"inwarddetails order by rid Desc limit 1";
		        String sqlIwno="SELECT rid,InwardRefNo  from db_leaveapplication.t_inwarddetails  where InwardRefNo like ('"+refno+""+date+"%') ORDER BY InwardRefNo DESC LIMIT 1";
				
				ResultSet rst=stleave.executeQuery(sqlIwno);
				System.out.println(sqlIwno);
				if(rst.next())
				{
					String a1=rst.getString(2);
					System.out.println(">>>>>>>>  "+a1);
					iwno=rst.getInt("rid");
					refno=rst.getString(2).substring(0,rst.getString(2).length()-2)+df.format(Integer.parseInt(rst.getString(2).substring(rst.getString(2).length()-2, rst.getString(2).length()))+1);
				}
				else
				{
					refno+=date+"001";	
				}
		

		System.out.println("BEfore  ");
		try{
			
			System.out.println(iwno);
			System.out.println(refno);
			System.out.println(todaysDate);
			System.out.println(todaysTime);
			
			
						 String sqlInsert="Insert into db_leaveapplication.t_inwarddetails (InwardNo,InwardRefNo,ManualRef,InwardDate,"+
						 "InwardTime,FromParty,PartyRefNo,Address,ToEmploy,ToEmailID,Subject,Dept,Category,"+
						 "BillNo,BillAmt,BillDate,BillDueDate,agreementParty,agreementDate,agreementFrom,"+
						 "agreementTo,FileName,FileLocation,Enteredby,EnteredById,EmailSend,"+
						 "senderRemark,receiverRemark,CheckStatus,InwrdPriority,InwardStatus,UpdatedDateTime,BillStatus,Keywords,Type)"+
						 " VALUES ('"+iwno+"','"+refno+"','-','"+todaysDate+"',"+
						 " '"+todaysTime+"','"+tokenfrm[a].trim()+"','-','"+tokenadd[a].trim()+"','-','-','"+tokensub[a].trim()+"','-','"+tokencat[a].trim()+"',"+
						 " '"+tokenbillno[a].trim()+"','"+tokenamt[a].trim()+"','"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tokenbilldate[a]))+"','"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(tokendue[a]))+"' ,'-','0000-00-00' ,'0000-00-00',"+
						 " '0000-000-00','-','-','"+session.getAttribute("EmpName")+"','0','No',"+
						 " '-','-','UnChecked','-','Pending','0000-00-00 00:00:00','UnPaid','-' ,'-' )";
		System.out.println("Final insert query is " +sqlInsert);
		stleave1.executeUpdate(sqlInsert);
		}catch(Exception e)
		{
		e.printStackTrace();	
		}
		System.out.println("After");
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		}
		
		buffer="Yes";
		
		out.print(buffer);
		
		
		
		}
		
		
		}
		else{
			buffer="No";
			out.print(buffer);


		}
	//}
	
	//out.print("Yes");
	
}
catch(Exception e)
{
	e.printStackTrace();
	//out.print("No");
}

%>
