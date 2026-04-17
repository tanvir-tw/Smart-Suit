<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	<script src="sorttable.js" type="text/javascript"></script>
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>

	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	<script type="text/javascript" src="css/chrome.js">
	
</script>
	</head>
	<body>
	<script src="dropdown.js" type="text/javascript"></script>

	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
			Connection conn = null;
			Connection connPay = null;		
			Statement st = null, st1 = null, st3 = null, st4 = null, st5 = null;
			Statement st2 = null,st6 = null, st7=null, st8=null;
			Statement stmt=null,stmt1=null,stmt2=null;
			String sqlInsert = "";//String button="";  --previously
			String button=null; //if button is null it will be considered for case - approve
			String action = request.getParameter("action");
			String comments = request.getParameter("comment");
					
			System.out.println(">>>>>comment *********:"+comments);
			
			try
			{
				//button = request.getParameter("Reject");
			    //if(button.equalsIgnoreCase("null"))
			    //if(request.getParameter("Reject")==null)	
			    if(request.getParameter("Reject")!=null)
			    {
			    	button="-";
			    }
			    System.out.println(">>>>>button *********:"+button);
			 }
			 catch(Exception e)
			 {
				 System.out.println("error in button"+e);
			 }
			
			double amount=0.0,payAmount=0.0;
			String InwardDate="",InwardTime="",claimSubmittedDate="",InwardRefNo="IW",dueDate="";
			String claimIdentity="",ClaimantName="",AccMailId="";
			String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
			int disallowedAmount = 0, disallowedByhod = 0, disallowedByAc = 0, disallowedByCheck = 0;
			String commentsToBeInserted = "", statusToBeInserted = "",actionTakenBy="",actionAtTime="",empName="", HodReport="",empMail="",Hodmail="",SqlAllPendingMail="";
			String mailHading ="Claim Report";
			System.out.println(">>>>>>>action:"+action);
			System.out.println(">>>>>comments:"+comments);
			
			String claimrefno = request.getParameter("claimIdentity");
			System.out.println(">>>>>claimrefno:"+claimrefno);
			String EMPName=session.getAttribute("EmpName").toString();
			double SumOfClaimAmount=0.00,AdvanceTaken=0,DisallowedAmount=0,ClaimClearedForAmt=0,InwardNo=0;
			StringBuffer htmlstring=new StringBuffer("");
			StringBuffer htmlstring1=new StringBuffer("");
			NumberFormat nf=NumberFormat.getInstance();
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				st7 = conn.createStatement();
				st8 = conn.createStatement();
	
	
	%>
	<div><input type="hidden" name="action" id="action" value="<%=action%>" /></div>
	<%
		%>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom: 0.3em; height: 2px; background-color: #339CCB">
	</div>
	
	<% 
	String heading=null;
	if(request.getParameter("action").equals("approve"))
	{ heading="Approved";
	  System.out.println("@@@@@@@@@@@@@@@@"+heading+"@@@@@@@@@@@@@@@@@@");
	}
	else if(request.getParameter("action").equals("sanction"))
		heading="Sanction";
	else
		heading="Authorized";
	%><%claimIdentity=request.getParameter("claimIdentity"); %>
	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.3em; margin-bottom: 0.1em;">
	<a>Claim <%=heading%> Status-Claim ID: <%=claimIdentity%> </a></div>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.3em; margin-bottom: 0.1em; height: 2px; background-color: #339CCB">
	</div>

	<%
		       String sqlSum = "SELECT SUM(DisallowedAmount) as x, SUM(DisallowedAmountByHOD)as a ,SUM(DisallowedAmountByApproveman) as b,SUM(DisallowedAmountByACDept) as c from "+session.getAttribute("CompanyMasterID").toString()+"claim_det  where CLMRefNumber='"+ request.getParameter("claimIdentity") + "' and Cancel='1' ";

				ResultSet rsSum = st.executeQuery(sqlSum);
				if (rsSum.next()) 
				{
					disallowedAmount = rsSum.getInt(1);
					disallowedByhod = rsSum.getInt(2);
					disallowedByCheck = rsSum.getInt(3);
					disallowedByAc = rsSum.getInt(4);
				}
				System.out.println(">>>>>>>>>sqlSum:"+sqlSum);
				Date today = new Date();
				actionAtTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(today);
				
				if (action.equals("sanction")) 
				{   mailHading="Claim Payed of ";
					commentsToBeInserted = "CommentsByACDepa ";
					statusToBeInserted = "Sanctioned";
					actionTakenBy="SanctionedBy='"+session.getAttribute("EmpName").toString()+"' , SanctionedOn='"+actionAtTime+"' ";
				} else if (action.equals("check")) 
				{    mailHading="Claim Accept of";
					commentsToBeInserted ="CommentsByHOD";
					statusToBeInserted = "Authorized";
					actionTakenBy="CheckedBy='"+session.getAttribute("EmpName").toString()+"' , CheckedOn='"+actionAtTime+"' ";
					
				} else if (action.equals("approve")) 
				{   mailHading="Claim Sanction of ";
					commentsToBeInserted = "CommentsByACDepa";
					statusToBeInserted = "Approved";
					actionTakenBy="ApprovedBy='"+session.getAttribute("EmpName").toString()+"' , ApprovedOn='"+actionAtTime+"' ";
				}
				System.out.println(">>>>>>>>>>>>>>>>>>>>> sanction >>>>>>>>>>>>>>>>>>>>>>>>>>. .  ");
				
				sqlInsert ="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"claim_master SET "
						+ commentsToBeInserted + " ='" + comments + "', "
						+ actionTakenBy +" ,"
						+ "Status='" + statusToBeInserted
						+ "',DisallowedAmount=" + disallowedAmount
						+ ",DisallowedAmountByHOD=" + disallowedByhod
						+ " ," + " DisallowedAmountByApprovedman="
						+ disallowedByCheck + " ,DisallowedAmountByACDept="
						+ disallowedByAc + ", "
						+ " ClaimClearedForAmt=SumOfClaimAmount-"
						+ disallowedAmount + "  WHERE CLMRefNumber='"
						+ request.getParameter("claimIdentity") + "' and Cancel='1'";
				
				System.out.println(">>>>>sqlInsert:"+sqlInsert);
				
				try
				{
				  st3.executeUpdate(sqlInsert);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}

				if (action.equals("check") || action.equals("approve")) 
				{	String sqlreject="";
					if(button!=null)
					 {  if(action.equals("check"))
					    {
						 sqlreject="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set Status='Rejected',CommentsByHOD='"+comments+"' where CLMRefNumber='"+claimrefno+"'";
					    }
					    else
					    {sqlreject="Update "+session.getAttribute("CompanyMasterID").toString()+"claim_master Set Status='Rejected',CommentsByACDepa='"+comments+"' where CLMRefNumber='"+claimrefno+"'";
					    }	
					    //System.out.println("12345");
						st8.executeUpdate(sqlreject);
						System.out.println("sqlreject ===="+sqlreject);
						%>
						<script>
						var action=document.getElementById("action").value;
							window.close();
							//alert(action);
    						window.onunload = refreshParent;
    							function refreshParent() {
        						window.opener.location = "claimReport.jsp?checkAll=on&action="+action;
    							}
							</script>
						
						<%
				      }
					
						String SqlClaiMData="Select * from "+session.getAttribute("CompanyMasterID").toString()+"claim_master where CLMRefNumber='"+ request.getParameter("claimIdentity") + "'";
						 ResultSet rsClaimData=st.executeQuery(SqlClaiMData);
						
						 if(button!=null)
						 {  if(action.equals("check"))
							{
							 if(rsClaimData.next())
						      {   double payamount=rsClaimData.getDouble("SumOfClaimAmount")-(rsClaimData.getDouble("DisallowedAmount")+rsClaimData.getDouble("AdvanceTaken"));
						        	 htmlstring.append("<br><h4 align=center><font size=2> "+mailHading+" "+rsClaimData.getString("ClaimantName")+"</font></h4>" +
										"<table align=center width=60% border=1 cellpadding=0 cellspacing=0>" +
										"<tr><td><font size=2 >Claim ID : "+rsClaimData.getString("CLMRefNumber")+"</font> </td><td><font size=2 >Type Of Claim : </font><font size=2 > "+rsClaimData.getString("ClaimType")+"</font></td></tr>"+
										"<tr><td><font size=2 >Origin :</font> <font size=2>"+rsClaimData.getString("Origin")+" </font></td><td><font size=2 >Destination :</font><font size=2>"+rsClaimData.getString("Destination")+"</font> </td></tr> "+
										  " <tr><td><font size=2 >Departure On :"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsClaimData.getString("DepartureDateTime")))+"</font></td>"+
										  "<td><font size=2 >Arrival On : "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsClaimData.getString("ArrivalDateTime")))+"</font></td></tr>"+
										  " <tr><td><font size=2 >Advance Taken : "+nf.format(rsClaimData.getDouble("AdvanceTaken"))+".00</font></td><td><font size=2 color=red>Status:"+rsClaimData.getString("Status")+"</font></td></tr>"+
										  " <tr><td><font size=2>Claim Amount:"+nf.format(rsClaimData.getDouble("SumOfClaimAmount"))+".00</font></td><td colspan=2><font size=2>Ression for Rejection : "+rsClaimData.getString("CommentsByHOD")+"</font></td></tr>"+
										  "</table>");
							  	 }
							}// end of if action=check****************
							else
							{
								if(rsClaimData.next())
							      {   double payamount=rsClaimData.getDouble("SumOfClaimAmount")-(rsClaimData.getDouble("DisallowedAmount")+rsClaimData.getDouble("AdvanceTaken"));
							        	 htmlstring.append("<br><h4 align=center><font size=2> "+mailHading+" "+rsClaimData.getString("ClaimantName")+"</font></h4>" +
											"<table align=center width=60% border=1 cellpadding=0 cellspacing=0>" +
											"<tr><td><font size=2 >Claim ID : "+rsClaimData.getString("CLMRefNumber")+"</font> </td><td><font size=2 >Type Of Claim : </font><font size=2 > "+rsClaimData.getString("ClaimType")+"</font></td></tr>"+
											"<tr><td><font size=2 >Origin :</font> <font size=2>"+rsClaimData.getString("Origin")+" </font></td><td><font size=2 >Destination :</font><font size=2>"+rsClaimData.getString("Destination")+"</font> </td></tr> "+
											  " <tr><td><font size=2 >Departure On :"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsClaimData.getString("DepartureDateTime")))+"</font></td>"+
											  "<td><font size=2 >Arrival On : "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsClaimData.getString("ArrivalDateTime")))+"</font></td></tr>"+
											  " <tr><td><font size=2 >Advance Taken : "+nf.format(rsClaimData.getDouble("AdvanceTaken"))+".00</font></td><td><font size=2 color=red>Status:"+rsClaimData.getString("Status")+"</font></td></tr>"+
											  " <tr><td><font size=2>Claim Amount:"+nf.format(rsClaimData.getDouble("SumOfClaimAmount"))+".00</font></td><td colspan=2><font size=2>Ression for Rejection : "+rsClaimData.getString("CommentsByACDepa")+"</font></td></tr>"+
											  "</table>");
								  	 }
							}
						 }//*******end if button =!null************
						 else
						 {
					     if(rsClaimData.next())
					      {   double payamount=rsClaimData.getDouble("SumOfClaimAmount")-(rsClaimData.getDouble("DisallowedAmount")+rsClaimData.getDouble("AdvanceTaken"));
					        	 htmlstring.append("<br><h4 align=center><font size=2> "+mailHading+" "+rsClaimData.getString("ClaimantName")+"</font></h4>" +
									"<table align=center width=60% border=1 cellpadding=0 cellspacing=0>" +
									"<tr><td><font size=2 >Claim ID : "+rsClaimData.getString("CLMRefNumber")+"</font> </td><td><font size=2 >Type Of Claim : </font><font size=2 > "+rsClaimData.getString("ClaimType")+"</font></td></tr>"+
									"<tr><td><font size=2 >Origin :</font> <font size=2>"+rsClaimData.getString("Origin")+" </font></td><td><font size=2 >Destination :</font><font size=2>"+rsClaimData.getString("Destination")+"</font> </td></tr> "+
									  " <tr><td><font size=2 >Departure On :"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsClaimData.getString("DepartureDateTime")))+"</font></td>"+
									  "<td><font size=2 >Arrival On : "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsClaimData.getString("ArrivalDateTime")))+"</font></td></tr>"+
									  " <tr><td><font size=2 >Advance Taken : "+nf.format(rsClaimData.getDouble("AdvanceTaken"))+".00</font></td><td><font size=2 >Status:"+rsClaimData.getString("Status")+"</font></td></tr>"+
									  " <tr><td><font size=2>Claim Amount:"+nf.format(rsClaimData.getDouble("SumOfClaimAmount"))+".00</font></td><td><font size=2>Rejected Amount:"+rsClaimData.getString("DisallowedAmount")+"</font></td></tr>"+
									  "<tr><td colspan=2><font size=2 color=red>Payable Amount:"+nf.format(payamount)+".00</font></td></tr></table>");
						  	 }
						 }						 
						 	//CLAIM DETAIL 
						 		String sqlDetail = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_det WHERE CLMRefNumber='"+ request.getParameter("claimIdentity") + "' and Cancel='1'";
								System.out.println(">>>>>>>>>>sqlDisplay:"+sqlDetail);
								ResultSet rsDetail = st7.executeQuery(sqlDetail);
					       
								
						/*	// GET SUM OF CLAIM AMOUNT ,ADVANCE AMOUNT
							
							*/		
						 	 htmlstring1.append("<br><h4 align=center><font size=2>Claim Details</font></h4>" +
									"<table align=center border=1 cellpadding=0 cellspacing=0>"+
									"<tr bgcolor=#C6DEFF>"+
									"<th><font size=2>Bill ID</font></th>"+
									"<th><font size=2>Particulars</font></th>"+
									"<th><font size=2>Bill No</font></th>"+
									"<th><font size=2>Amount</font></th>"+
									"<th><font size=2>Rejected<br> Amount</font></th>"+
									"<th><font size=2>Amount Rejected <br>By HOD</font></th>"+
									"<th><font size=2>Comments <br>By Emp</font></th>"+
									"<th><font size=2>Comments <br>By HOD</font></th>");
									while(rsDetail.next())
									{
			  						htmlstring1.append("<tr>"+
									"<td><font size=2>"+rsDetail.getString("billId")+"</font></td>"+
			   						"<td><font size=2>"+rsDetail.getString("Particulars")+"</font></td>"+
			   						"<td><font size=2>"+rsDetail.getString("billNo")+"</font></td>"+
			   						"<td align=right><font size=2>"+nf.format(rsDetail.getDouble("Amount"))+".00</font></td>"+
			    					"<td align=right><font size=2>"+nf.format(rsDetail.getDouble("DisallowedAmount"))+".00</font></td>"+
			    					"<td align=right><font size=2>"+nf.format(rsDetail.getDouble("DisallowedAmountByHOD"))+".00</font></td>"+
			  					    "<td><font size=2>"+rsDetail.getString("CommentsByEmp")+"</font></td>"+
			  					    "<td><font size=2>"+rsDetail.getString("CommentsByHOD")+"</font></td>"+
			  					    "</tr>");
									}
									
							
						 //END CLAIM DETAIL
	
						 //GET DEPARTMENT OF EMPLOYEE
						   String Dept="";
						   String SqlData="select email,Dept,HodReport from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+rsClaimData.getString("ClaimantName")+"'";
						   ResultSet rsData=st1.executeQuery(SqlData);
						   System.out.println(">>>>>>>>SqlData:"+SqlData);
						   if(rsData.next())
						   {  empMail=rsData.getString("email");
							   Dept=rsData.getString("Dept");
							   HodReport=rsData.getString("HodReport");
							   
						   }
						   System.out.println(">>>>>>>>empMail:"+empMail+">>>>>>>>>>>>Dept:"+Dept);
						  
						   //**********GET HOD EMAIL
						    String SqlHod="select email from "+session.getAttribute("CompanyMasterID").toString()+"security where EmpName='"+HodReport+"' ";
						   //String SqlHod="select email from "+session.getAttribute("CompanyMasterID").toString()+"security where Dept='"+Dept+"' and Level='Level5'";
						   System.out.println(">>>>>>>>SqlHod:"+SqlHod);
						   ResultSet rsHod=st1.executeQuery(SqlHod);
						   if(rsHod.next())
						   {
							   Hodmail=rsHod.getString("email");
						   }
						   System.out.println(">>>>>>>>Hodmail:"+Hodmail);
						   
						 //***********GET ACCOUNT EMAIL
						    String SqlAcc="select toid from "+session.getAttribute("CompanyMasterID").toString()+"mailid where UserName='Accdeptclaim' ";
						    System.out.println(">>>>>>>>SqlHod:"+SqlHod);
						    ResultSet rsAcc=st2.executeQuery(SqlAcc);
							   if(rsAcc.next())
							   {
								   AccMailId=rsAcc.getString("toid");
							   }
							   System.out.println(">>>>>>>>Account email:"+AccMailId);
						   
						   SqlAllPendingMail="insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SendDateTime,SenderName)values('Claim Mail','-','<br><br>"+htmlstring+"</table><br>"+htmlstring1+"</table><br><br><br> Thanks & Regards,<br>Transworld Team','Claim Of "+rsClaimData.getString("ClaimantName")+"','"+AccMailId+"','"+Hodmail+","+empMail+"','"+todaysDateTime+"','Pending','"+todaysDateTime+"','"+EMPName+"')";
						   System.out.println(">>>>>>>>SqlAllPendingMail:"+SqlAllPendingMail);
						   st2.executeUpdate(SqlAllPendingMail);	 
					 }
					 
		if(button==null)
		{
	%>

	<br>
	 <br>
					
	<table align="center" width="90%" height="50%" border="0" cellpadding="2" cellspacing="2" style="background-color: #C6DEFF">
		<%

			//sqlInsert="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"claim_master SET CommentsByHOD='"+comments+"' , status='Sanctioned' WHERE status='Pending' AND claimID='"+request.getParameter("claimID")+"'";
					String sql = "SELECT  ClaimantName,Purpose,Origin,"
							+ "Destination ,DepartureDateTime,ArrivalDateTime,Status,CommentsByEmp,CommentsByHOD"
							+ ",CommentsApprovedBy,CommentsByACDepa,DisallowedAmountByHOD,DisallowedAmountByApprovedman,"
							+ "DisallowedAmountByACDept,DisallowedAmount,SumOfClaimAmount,"
							+ "AdvanceTaken,ClaimClearedForAmt,NetClaim FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE CLMRefNumber 	='"
							+ request.getParameter("claimIdentity") + " ' and Cancel='1' ";
					System.out.println(">>>>>>>>sql:"+sql);
					ResultSet rsClaim = st2.executeQuery(sql);
					//System.out.println(">>>>>>>>sql:"+sql);
					if (rsClaim.next()) 
					{
						
					SumOfClaimAmount=rsClaim.getDouble("SumOfClaimAmount");
					AdvanceTaken=rsClaim.getInt("AdvanceTaken");
					DisallowedAmount=rsClaim.getInt("DisallowedAmount");
					ClaimClearedForAmt=rsClaim.getInt("ClaimClearedForAmt");
						
						
		%>
		<%ClaimantName=rsClaim.getString("ClaimantName");
		claimSubmittedDate=new SimpleDateFormat("dd-MMM-yyyy")
										.format(new SimpleDateFormat(
												"yyyy-MM-dd").parse(rsClaim
												.getDate("ArrivalDateTime")
												.toString()));%>
		<tr>
			<td valign="top" align="left">Name: </td>
			<td align="left"><b><%=ClaimantName %></b></td>
			<td valign="top" align="left">Purpose: </td>
			<td align="left"><b><%=rsClaim.getString("Purpose")%></b></td>
			<td valign="top" align="left">Status:</td>
			<td align="left" valign="top" ><font color="red"><b><%=rsClaim.getString("status")%></b></font></td>
		</tr>

		<tr>
			<td valign="top" align="left">
			<div>Origin of Journey:</div>
			</td>
			<td align="left" valign="top"><b><%=rsClaim.getString("Origin")%></b></td>
			<td valign="top" align="left">
			<div>Destination:</div>
			</td>
			<td align="left" valign="top"><b><%=rsClaim.getString("Destination")%></b></td>
						<td valign="top" align="left">Comments By EMP: </td>
			<td align="left"><b><%=rsClaim.getString("CommentsByEmp")%></b></td>
		</tr>

		<tr>
			<td valign="top" align="left">Departure Date: </td>
			<td align="left" valign="top"><b><%=new SimpleDateFormat("dd-MMM-yyyy")
										.format(new SimpleDateFormat(
												"yyyy-MM-dd").parse(rsClaim
												.getDate("DepartureDateTime")
												.toString()))%></b></td>
			<td valign="top" align="left">Arrival Date</td>
			<td align="left" valign="top"><b><%=claimSubmittedDate%><b></td>
						<td valign="top" align="left">Comments <br>
			By HOD: </td>
			<td align="left"><b><%=rsClaim.getString("CommentsByHOD")%></b></td>
			
		</tr>
		<tr>
				<%
					
		 		%>
		 						<%
		 							if (action.equals("approve")) {
		 						%>
											<td valign="top" align="left">Comments <br>
			By A/c's Dept: </td>
			<td align="left"><b><%=rsClaim.getString("CommentsByACDepa")%></b></td>
		 		<%
		 			}
		 		%>
		
		     <td valign="top" align="left">Total Claim <br>Amount:
			</td>
			<td align="left"><b><%=nf.format(SumOfClaimAmount)%>.00</b></td>
		</tr>
		<%
			}
		%>
	</table>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.8em; margin-bottom: 0.8em; height: 4px; background-color: #339CCB">
	</div>

	<table border='1px' class='sortable'>
		<tr>
			<th>Bill ID</th>
			<th>Particulars</th>
			<th>BillNo</th>
			<th>Amount</th>
			<th>Denied Amount</th>
			<%
				 if (action.equals("check")) 
				{
			%>
			<th>Amount Denied By HOD</th>
			<%
				} 
				else if (action.equals("approve")) 
				{
			%>
			<th>Amount Denied By HOD</th>
			<th>Amount Denied By A/c's Dept</th>
			<%
				}
			%>
			<th>Comments By Emp</th>
			<%
				 if (action.equals("check"))
				{
			%>
			<th>Comments By HOD</th>
			<%
				} 
				else if (action.equals("approve")) 
				{
			%>
			<th>Comments By HOD</th>
			<th>Comments By A/c's Dept</th>
		</tr>
		<%
			    }
		%>

		<%
			String sqlDisplay = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_det WHERE CLMRefNumber='"
							+ request.getParameter("claimIdentity") + "' and Cancel='1'";
					System.out.println(">>>>>>>>>>sqlDisplay:"+sqlDisplay);
					ResultSet rsDiplay = st2.executeQuery(sqlDisplay);
					while (rsDiplay.next()) 
					{
		%>
		<tr>
			<td>
			<div align="right"><%=rsDiplay.getString("BillID")%></div>
			</td>
			<td>
			<div align="left"><%=rsDiplay.getString("Particulars")%></div>
			</td>
			<td>
			<div align="right"><%=rsDiplay.getString("BillNo")%></div>
			</td>
			<td>
			<div align="right"><%=rsDiplay.getString("Amount")%></div>
			</td>
			<td>
			<div align="right"><%=rsDiplay.getString("DisallowedAmount")%></div>
			</td>
			<%
				 if (action.equals("check")) 
				{
			%>
			<td>
			<div align="right"><%=rsDiplay.getString("DisallowedAmountByHOD")%></div>
			</td>
			<%
				} 
				else if (action.equals("approve")) 
				{
			%>
			<td>
			<div align="right"><%=rsDiplay.getString("DisallowedAmountByHOD")%></div>
			</td>
			<td>
			<div align="right"><%=rsDiplay.getString("DisallowedAmountByACDept")%></div>
			</td>
			<%
				}
			%>
			<td>
			<div align="left"><%=rsDiplay.getString("CommentsByEmp")%></div>
			</td>
			<%
				 if (action.equals("check")) 
				{
			%>
            <td>
			<div align="left"><%=rsDiplay.getString("CommentsByHOD")%></div>
			</td>
			<%
				} 
				else if (action.equals("approve")) 
				{
			%>
			<td>
			<div align="left"><%=rsDiplay.getString("CommentsByHOD")%></div>
			</td>
			<td>
			<div align="left"><%=rsDiplay.getString("CommentsByACDepa")%></div>
			</td>
			<%
				}
			%>
		</tr>

		<%
			}
					System.out.println("###########"+request.getParameter("Submit"));
					System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=");
					
		%>
	</table>
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.8em; margin-bottom: 0.4em; height: 4px; background-color: #339CCB">
	</div>
	<div align="right">
	<%
	try
	{
	%>
	<table>
		<tr>
			<td>
			<table style="background-color: #C6DEFF" border="1" cellpadding="1"
				cellspacing="0">
				<tr>
					<td align="right" >Total Claim Amount &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</br>
					</td>
					<td align="right" ><%=nf.format(SumOfClaimAmount)%>.00</td>
				</tr>
				
				<tr>
					<td>Advance taken</td>
					<td align="right" ><%=nf.format(AdvanceTaken)%>.00</td>
				</tr>
				<tr>
					<td>Denied Amount</td>
					<td align="right" ><%=nf.format(DisallowedAmount)%>.00</td>
				</tr>
				<tr>
					<td style="background-color: white"><font color="red"><b>Payable Amount</b></font></td>
					<td align="right" style="background-color: white" >
					<% payAmount=ClaimClearedForAmt - AdvanceTaken;%><%=nf.format(payAmount)%>.00
					</td>
				</tr>

			</table>
			
	<% 		
    
    %>
	<%
	//   GENRATE INWARD REF ID 
      
	%>
	<%
	try{
		if(request.getParameter("action").equals("approve"))
		    {
				
				//CONNECTION FOR db_leaveapplication DATABASE OF  inwarddetails table
			    
			    Class.forName("com.mysql.cj.jdbc.Driver");
		   	//connPay=DriverManager.getConnection("jdbc:mysql://10.0.10.62/db_leaveapplication","erp","1@erp");
			   //connPay=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_leaveapplication","erp","1@erp");
                connPay=DriverManager.getConnection("jdbc:mysql://"+host1+"/db_leaveapplication","erp","1@erp");
			    st6=connPay.createStatement();
			    stmt=connPay.createStatement();
			    stmt1=connPay.createStatement();
			    stmt2=connPay.createStatement();
			    System.out.println("@@@@@@@@@@@@@@@@@@@ connection "+connPay);
			    	
			System.out.println("@@@@@@@@Inside inserted "); 
		  
			//	GET INWARD DETAILS
			dueDate=request.getParameter("dueDate");
			System.out.println("@@@@@@@@ Due Date "+dueDate);
			dueDate= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(dueDate));
			System.out.println("@@@@@@@@ Due Date "+dueDate);
			System.out.println("@@@@@@@@"+ClaimantName+"  "+claimIdentity+  "    Amount "+payAmount );
			InwardDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			InwardTime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
			claimSubmittedDate=InwardDate; 
			//System.out.println("@@@@@@@@ "+InwardRefNo);
			System.out.println("@@@@@@@@ "+InwardTime+"       "+InwardDate);
			String sql1="SELECT InwardNo FROM db_leaveapplication.t_inwarddetails ORDER BY InwardNo DESC LIMIT 1 ";
			System.out.println("@@@@@@@@ sql query @@@@@@@@@"+sql1);
		
	   	ResultSet rs=stmt1.executeQuery(sql1);
	   	if(rs.next())
	   	{
	   	InwardNo=rs.getInt("InwardNo");
	   	}
		System.out.println("@@@@@@@@ Inward No@@@@@@@@@"+InwardNo);
	   	InwardNo=InwardNo+1;
		System.out.println("@@@@@@@@ Inward No@@@@@@@@@"+InwardNo);
		System.out.println("###########"+request.getParameter("Submit"));
		System.out.println("###########"+request.getParameter("action").equals("approve"));
		//Insert Inward details
		
			   
			   sqlInsert=" INSERT INTO db_leaveapplication.t_inwarddetails ("+
					   "InwardNo,InwardRefNo,`ManualRef`,`InwardDate`,"+
					   "`InwardTime`,`FromParty`,`PartyRefNo`,`Address`,"+
					   "`ToEmploy`,`ToEmailID`,`Subject`,`Dept`,"+
					   "`Category`,`BillNo`,`BillAmt`,`BillDate`,`BillDueDate`,"+
					   "`agreementParty`,`agreementDate`,`agreementFrom`,`agreementTo`,`FileName`,"+
					   "`FileLocation`,`Enteredby`,`EnteredById`,`EmailSend`,`ActionDate`,"+
					   "`senderRemark`,`receiverRemark`,`CheckStatus`,`InwrdPriority`,`InwardStatus`,"+
					   "`UpdatedDateTime`,`BillStatus`,`Keywords`"+
				       ")values('"+InwardNo+"','"+claimrefno+"','-','"+InwardDate+"','"+InwardTime+"','"+ClaimantName+"','"+claimrefno+"','Transworld',"+
					   "'-','-','claim-"+claimrefno+"','Accounts','Claim','"+claimrefno+"','"+payAmount+"','"+claimSubmittedDate+"','"+dueDate+"',"+
					   "'-','0000-00-00','0000-00-00','0000-00-00','-','-','Claim Entry','-','-','-','-','-','Checked','-','-','	0000-00-00 00:00:00','UnPaid','-')";
			   System.out.println(" inward query inserted "+sqlInsert);
			   stmt.executeUpdate(sqlInsert);

		    }
		}
		catch(Exception e)
		{ System.out.println("/////////error in inward query///////////////"+e);}
		%>
		
		
			
			
			
			<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
			%>
			</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
	</table>
	<div style="right:"><table><tr><td><input type="button" name="Exit" value="Exit" onclick="javascript:window.close();"/></td></tr></table></div>
	</div>
	<script>
	var action=document.getElementById("action").value;
    window.onunload = refreshParent;
    function refreshParent() {
        //window.opener.location.reload();
        window.opener.location = "claimReport.jsp?action="+action;
    }
</script>
	
	<%
		}//******************end of else of condition button=reject*******************
}//end of try
	catch (Exception e) 
	{
	   out.print("!!!Connection Lost!!!"+e);
	   e.printStackTrace();
	} 
	finally 
	{
	   conn.close();
	}
	%>

	<br><br><br><br>
	
		<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>

