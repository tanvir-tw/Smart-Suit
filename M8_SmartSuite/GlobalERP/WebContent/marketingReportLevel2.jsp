<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
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
	<title>Transworld Compressor Technologies LTD, ERP</title>
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
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null,st2=null;
			boolean isRepDetails=true;
			String action=request.getParameter("action");
			String repName="",repCode="";
			double numberOdDays=0;
		
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
			} catch (Exception e) {
			}
	%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 0.4em; height: 4px; background-color: #339CCB">
	</div>


	<div align="center" style="font-size: 1.5em;">
	<%if(isRepDetails){ %> Sales and Marketing Report of <a><%=request.getParameter("repName")%>
	</a>  <%} else{%> Trasanction : <a><%=request.getParameter("repName")%></a>
	details for <%=request.getParameter("company")%> <%}%> </a></div>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 1.5em; height: 4px; background-color: #339CCB">
	</div>

	<%if(isRepDetails){
		repName=request.getParameter("repName");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
 
	String sqlTargets="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  WHERE MarketingRepName='"+repName+"'  ";
	ResultSet rsTargets=st.executeQuery(sqlTargets);
	System.out.println(sqlTargets);
	
		%>
	<table border="0">
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td valign="top">
			<%if(rsTargets.next()){ 
		 
				 DateFormat formatter ; 
				 Date from,to ; 
				  formatter = new SimpleDateFormat("yyyy-MM-dd");
				  from = (Date)formatter.parse(fromDate);  
				  to = (Date)formatter.parse(toDate);
				  
				   double diff= (to.getTime() - from.getTime()) / (1000 * 60 * 60 * 24);
				   numberOdDays=diff;
			        System.out.println(diff);				        System.out.println(diff);
				repCode=rsTargets.getString("MarketingRepCode");
				
			double visitsTarget=0,callsTarget=0,lettersTarget=0,salesQuotationTarget=0,newProspectsTarget=0;
			String visits="",phoneCalls="",letters="",meetings="",email="",numberOfprospects="",numberOfSQ="",numberOfSO="",sumOfSO="";
			visitsTarget=(rsTargets.getDouble("VisitsTarget")/7)*diff;
			callsTarget=(rsTargets.getDouble("CallsTarget")/7)*diff;
			lettersTarget=(rsTargets.getDouble("LettersTarget")/7)*diff;
			salesQuotationTarget=(rsTargets.getDouble("SQTarget")/7)*diff;
			newProspectsTarget=(rsTargets.getDouble("NewProspectTarget")/7)*diff;
			
			 String sqlCount="SELECT    count(*) , 'PhoneCall'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where			 FollowUpType   "+
             "       in('phoneCall','Ph Call') and MarketingRepcode			 "+
             "       ='"+rsTargets.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
             "       '"+fromDate+"' and '"+toDate+"'			 "+
             "        union			 "+
             "       SELECT    count(*) , 'Visit'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
             "       in('Visit') and MarketingRepcode 			 "+
             "       ='"+rsTargets.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
             "       '"+fromDate+"' and '"+toDate+"'			 "+
             "       union			 "+
             "       SELECT    count(*) , 'Letter'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
             "       in('Letter') and MarketingRepcode 			 "+
             "       ='"+rsTargets.getString("MarketingRepCode")+"' and FollowUpDate  between			 "+
             "       '"+fromDate+"' and '"+toDate+"'			 "+
             "       union			 "+
             "       SELECT    count(*) , 'NoOfProspects'  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where			 "+
             "       CustEnteredByRep ='"+repName+"'  and			 "+
             "       AddedOnDate between '"+fromDate+"' and '"+toDate+"' "+
             "		 UNION "+
             "		 SELECT count(*) ,'NoOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsTargets.getString("MarketingRepName")+"' "+
             "		 and SalesOrderDate between '"+fromDate+"' and '"+toDate+"' and SOCancelled=0"+
             "    		 UNION "+
             "		 SELECT count(*) ,'NoOfSQ' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where TWEmpName='"+rsTargets.getString("MarketingRepName")+"' "+
             "		 and SalesQuoDate between '"+fromDate+" 00:00:00  	' and '"+toDate+" 00:00:00  	' and SalesQuoCancelled=0"+
             "		 UNION "+
             "		 SELECT SUM(Total) ,'SumOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+rsTargets.getString("MarketingRepName")+"' "+
             "		 and SalesOrderDate between '"+fromDate+"' and '"+toDate+"' and SOCancelled=0";
             
			 System.out.println(">>>>>>>>>>>sqlCount:"+sqlCount);
			 ResultSet rsCount=st2.executeQuery(sqlCount);
	 			phoneCalls=(rsCount.next()?rsCount.getString(1):"0");
	 			visits=(rsCount.next()?rsCount.getString(1):"0");
	 			letters=(rsCount.next()?rsCount.getString(1):"0");
	 			numberOfprospects=(rsCount.next()?rsCount.getString(1):"0");
	 			//numberOfprospects="10000";
	 			numberOfSO=(rsCount.next()?rsCount.getString(1):"0");
	 			numberOfSQ=(rsCount.next()?rsCount.getString(1):"0");
	 			sumOfSO=(rsCount.next()?rsCount.getString(1):"0");
	 			sumOfSO=(sumOfSO==null?"0":sumOfSO);
	 			double index=0,totalIndex=0;
	 			System.out.println("numberOfprospects:"+numberOfprospects);
			
			%>
				<table border="0" class="sortable">
					<tr>
						<th>Particulars</th>
						<th>Total</th>
						<th>Target</th>
						<th>Index</th>
					</tr>
					<tr>
						<td><div align="right">Visits</div></td>
						<td><%=visits %></td>
						<td><div align="right"><%=new DecimalFormat("0").format(visitsTarget) %></div></td>
						<%
						index=(Double.parseDouble(visits)!=0 ? Double.parseDouble(visits)/visitsTarget : 0);
						index=(visitsTarget==0 ? 0 : index);
						 
						%>
						<td><%=new DecimalFormat("0.00").format(index) %></td>
					</tr>
					<tr>
						<td><div align="right">Calls</div></td>
						<td><%=phoneCalls %></td>
						<td><div align="right"><%=new DecimalFormat("0").format(callsTarget) %></div></td>
												<%
						index=(Double.parseDouble(phoneCalls)!=0 ? Double.parseDouble(phoneCalls)/callsTarget : 0);
						 index=(callsTarget==0 ? 0 : index);
						%>
						<td><%=new DecimalFormat("0.00").format(index) %></td>
					</tr>
					<tr>
						<td><div align="right">Letters</div></td>
						<td><%=letters %></td>
						<td><div align="right"><%=new DecimalFormat("0").format(lettersTarget)%></div></td>
												<%
						index=(Double.parseDouble(letters)!=0 ? Double.parseDouble(letters)/lettersTarget : 0);
					    index=(lettersTarget==0 ? 0 : index);
						%>
						<td><%=new DecimalFormat("0.00").format(index) %></td>
					</tr>
					<tr>
						<td><div align="right">Sales Quo</div></td>
						<td><%=numberOfSQ %></td>
						<td><div align="right"><%=new DecimalFormat("0").format(salesQuotationTarget) %></div></td>
												<%
						index=(Double.parseDouble(numberOfSQ)!=0 ? Double.parseDouble(numberOfSQ)/salesQuotationTarget : 0);
						index=(salesQuotationTarget==0 ? 0 : index);
						%>
						<td><%=new DecimalFormat("0.00").format(index) %></td>
					</tr>
					<tr>
						<td><div align="right">Prospects</div></td>
						<td><%=numberOfprospects %></td>
						<td><div align="right"><%=new DecimalFormat("0").format(newProspectsTarget) %></div></td>
												<%
						index=(Double.parseDouble(numberOfprospects)!=0 ? Double.parseDouble(numberOfprospects)/newProspectsTarget : 0);
						index=(newProspectsTarget==0 ? 0 : index);
						%>
						<td><%=new DecimalFormat("0.00").format(index) %></td>
					</tr>					
				</table>
				<br></br>
				
		 
				<b>Number of SO:</b>&nbsp;&nbsp;<%=numberOfSO %><br> 
				<b>SO value:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sumOfSO %><br>
				
				<%} %>
			</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>
			<div class="TabView" id="TabView">
			<div class="Tabs" style="width: 750px;"><a>Day-wise Report</a>
			<a> Follow-Up Report </a></div>
			<div class="Pages" style="width: 1000px; height: 480px;">
			<div class="Page">
			<div class="Pad">
			<div align="center"
				style="font-size: 1.2em; margin-top: 1.5em; margin-bottom: 1.5em;">
			 </div>
			<%
			 DateFormat formatter ; 
			 Date from,to ; 
			  formatter = new SimpleDateFormat("yyyy-MM-dd");
			  from = (Date)formatter.parse(fromDate);  
			  to = (Date)formatter.parse(toDate);
			  
			Calendar calFrom = Calendar.getInstance();
			calFrom.setTime(from);
			
			int j=0;

			%>
			<table border="1px" class="sortable">

				<tr>
					<th>Sr. No</th>
					<th>Date</th>
					<th>Visits</th>
					<th>Calls</th>
					<th>Letters</th>
					<th>E-mails</th>
					<th>Meetings</th>
					<th>Sales Quotations</th>
					<th>New Prospects</th>
					<th>No of SO</th>
					<th>Total SO Value</th>
				</tr>
				<%
				while(j<numberOdDays+1)
				{
			j++;
			
			Date current = calFrom.getTime();
			String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(current);
			calFrom.add(Calendar.DAY_OF_YEAR, 1);
			
			String sqlDayWise="SELECT    count(*) , 'PhoneCall'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where			 FollowUpType   "+
            "       in('phoneCall','Ph Call') and MarketingRepcode			 "+
            "       ='"+repCode+"' and FollowUpDate  =			 "+
            "       '"+currentDate+"'			 "+
            "        union			 "+
            "       SELECT    count(*) , 'Visit'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
            "       in('Visit') and MarketingRepcode 			 "+
            "       ='"+repCode+"' and FollowUpDate  =			 "+
            "       '"+currentDate+"'			 "+
            "       union			 "+
            "       SELECT    count(*) , 'Letter'  from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
            "       in('Letter') and MarketingRepcode 			 "+
            "       ='"+repCode+"' and FollowUpDate  =			 "+
            "       '"+currentDate+"'			 "+
            "       union			 "+
            "       SELECT count(*) , 'Meeting' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
            "       in('Meeting') and MarketingRepcode"+
            "       ='"+repCode+"' and FollowUpDate  =			 "+
            "       '"+currentDate+"'			 "+
            "       union			 "+
            "       SELECT count(*) , 'Email' from "+session.getAttribute("CompanyMasterID").toString()+"followup where FollowUpType			 "+
            "       in('E-mail','E mail','Mail','Email') and MarketingRepcode 			 "+
            "       ='"+repCode+"' and FollowUpDate =			 "+
            "       '"+currentDate+"'			 "+
            "       union			 "+
            "       SELECT    count(*) , 'NoOfProspects'  from "+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where			 "+
            "       CustEnteredByRep ='"+repName+"'  and			 "+
            "       AddedOnDate ='"+currentDate+"' "+
            "		 UNION "+
            "		 SELECT count(*) ,'NoOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+repName+"' "+
            "		 and SalesOrderDate = '"+currentDate+"' and SOCancelled=0"+
            "    		 UNION "+
            "		 SELECT count(*) ,'NoOfSQ' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesquo_det where TWEmpName='"+repName+"' "+
            "		 and SalesQuoDate  = '"+currentDate+" 00:00:00' and SalesQuoCancelled=0"+
            "		 UNION "+
            "		 SELECT SUM(Total) ,'SumOfSO' FROM "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det where TWEmpName='"+repName+"' "+
            "		 and SalesOrderDate = '"+currentDate+"' and SOCancelled=0";
			
			  currentDate=new SimpleDateFormat("dd-MMM-yyyy").format(current);
			  System.out.println(">>>>>>>>>>sqlDayWise:"+sqlDayWise);
			ResultSet rsDayWise=st1.executeQuery(sqlDayWise);
				String visits="",phoneCalls="",letters="",meetings="",email="",numberOfprospects="",numberOfSQ="",numberOfSO="",sumOfSO="";
	 			phoneCalls=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			visits=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			letters=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			meetings=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			email=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			numberOfprospects=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			numberOfSO=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			numberOfSQ=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			sumOfSO=(rsDayWise.next()?rsDayWise.getString(1):"0");
	 			sumOfSO=(sumOfSO==null?"0":sumOfSO);
	 			System.out.println(">>>>>>>>>>numberOfprospects:"+numberOfprospects);
			%>
			<tr>
				<td><div align ="right"><%= j  %></div></td>
				<td><div align ="right"><%= currentDate  %></div></td>
				<td align="right"><div align ="right"><%=visits %></div></td>
				<td><div align ="right"><%=phoneCalls %></div></td>
				<td><div align ="right"><%=letters%></div></td>
				<td><div align ="right"><%=email%></div></td>
				<td><div align ="right"><%=meetings %></div></td>
				<td><div align ="right"><%=numberOfSQ %></div></td>
				<td><div align ="right"><%=numberOfprospects%></div></td>
				<td><div align ="right"><%=numberOfSO %></div></td>
				<td><div align ="right"><%=sumOfSO %></div></td>
			</tr>
			<%
			}
		 %>
			</table>
			</div>
			</div>
			<div class="Page">
			<div class="Pad">
						<div align="center"
				style="font-size: 1.2em; margin-top: 1.5em; margin-bottom: 1.5em;">
			 </div>

			<table border="1px"  class="sortable">
			<tr>
			<th>Sr.No</th>
			<th>Company</th>
			<th>Contact Person</th>
			<th>Follow-Up Date</th>
			<th>Status</th>
			<th>Comments</th>
			<th>Follow-Up Type</th>
			<th>Next Follow Up Date</th>
			<th>Payment Follow-Up</th>
			<th>Reply</th>
			</tr>
			<%
			int i=1;
			 
			 String sqlFollowUp="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup  WHERE MarketingRepCode='"+repCode+"' AND FollowUpDate BETWEEN '"+fromDate+"' AND '"+toDate+"' order by FollowUpDate Asc";
			 ResultSet rsFollowUp=st2.executeQuery(sqlFollowUp);
			 while(rsFollowUp.next()){
				 %>
				 		<tr>
		<td align="right"><div align ="right"><%=i++ %></div></td>
		<td align="left"><div align ="left"><%=rsFollowUp.getString("ProspCustName") %></div></td>
		<td><div align ="left"><%=rsFollowUp.getString("ContactPerson") %></div></td>
		<td><div align ="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
					(rsFollowUp.getString("FollowUpDate")))%></div></td>
		<td><div align ="left"><%=rsFollowUp.getString("Status") %></div></td>
		<td><div align ="left"><%=rsFollowUp.getString("Comments") %></div></td>
		<td><div align ="left"><%=rsFollowUp.getString("FollowUpType") %></div></td>
		<td><div align ="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat(
														"yyyy-MM-dd")
														.parse(rsFollowUp
																.getString("NextFollowUpDate")))%></div></td>
		<td><div align ="left"><%=rsFollowUp.getString("PaymentFollowup") %></div></td>
		<td><div align ="left"><%=rsFollowUp.getString("Reply") %></div></td>
		</tr>
				 <%
			 }
			%>
			<script type="text/javascript">
			tabview_initialize('TabView');
</script></td>

		</tr>
	</table>

	<% 
	}
	conn.close();
	%>

 </div></div></div></div></td></tr></table>
	<br><br> <br><br>  
<!--	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009-2017
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>-->
	<!-- end #footer -->
	</body>
	
	</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>