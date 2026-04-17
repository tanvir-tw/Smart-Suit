<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - PayRoll-Data Access</title>
</head>
<body>
<form name="xyz" method="get" action="">
<%
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();
	tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD,SID,PID,CMID);
Connection conn = null;
Statement st = null, st1 = null, st3 = null, st4 = null;
Statement st2 = null;
Statement stmain = null;
String selectedName;
Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
String fromDate="",toDate="",fromDateCal="",toDateCal="",mDate;
String companyName="",phone="",contact="",email="",product="",city="";
String tallyCompanyName="",contractorID="",contractorName="",MainContractorFeeAcc="",MainTDSAccount="";
String IndividualContractorFeeAcc="",IndividualContractorSDAcc="",IndividualContractorRecAcc="";

Date today = new Date();
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DAY_OF_MONTH, -30);
Date today30 = cal.getTime();
fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
if (!(null == request.getParameter("fromdate")))
{
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
}    		
if (!(null == request.getParameter("todate"))){
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
	toDateCal=request.getParameter("todate");
}
%>
    <table align="center" >
    	   <tr>
    	    <td align="center" valign="top" style="width: 180px;">
			Begin Date:
			<input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal%>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "fromdate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
			  );
			</script>
 </td><td align="center" valign="top" style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left" valign="top" style="width: 180px;"> End Date:
			 <input type="text" id="todate"
						name="todate" value="<%=toDateCal%>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "todate",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "todate"       // ID of the button
			    }
			  );
			</script>
			 </td><td align="left" valign="top">&nbsp;&nbsp;
	 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO"></input></td>
				<%--
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new java.util.Date()%></font>
				<a style="visibility: hidden;" href="#" onclick="javascript:window.open('excelLedgerDetails.jsp?company=<%=companyName %>&companyPhone=<%=phone %>&companyEmail=<%=email %>&companyPerson=<%=email %>&companyCity=<%=city %>&companyProduct=<%=product %>&fromDate=<%=fromDate %>&toDate=<%=toDate %>');" title="Export To Excel">

				<img src="images/excel.jpg"	width="15px" height="15px"></img></a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
				</td>
				 --%>	
    </tr></table>
    </form>
    <%
    	if (request.getQueryString()!=null)
            {
            String text = "";
            try {
                conn = tally.ReturnConnection();
                st =conn.createStatement();
    		    st1 = conn.createStatement();
    		    st2 = conn.createStatement();
    		    st3 = conn.createStatement();
    		    st4 = conn.createStatement();
    		    stmain = conn.createStatement();
                //out.println(fromDate);
                //out.println(toDate);
    		    String sql="select a.ContractorID as ContractorID,a.ContractorName as ContractorName,a.MainContractorFeeAcc as  MainContractorFeeAcc,a.MainTDSAccount as MainTDSAccount,a.IndividualContractorFeeAcc as IndividualContractorFeeAcc,a.IndividualContractorSDAcc as IndividualContractorSDAcc,a.IndividualContractorRecAcc as IndividualContractorRecAcc,b.GP as GP,b.SD as SD,b.TDS as TDS,b.Recovery as Recovery,b.NetPay as NetPay,b.BankAccNo as BankAccNo,b.PayrollDate as PayrollDate,b.Month1 as Month1  from  "+session.getAttribute("CompanyMasterID").toString()+"contractor_tally_mapping a,"+session.getAttribute("CompanyMasterID").toString()+"payrollentry b where a.ContractorID=b.ContractorID and  PayrollDate BETWEEN '"+fromDate+"' and '"+toDate+"' and ProcessStatus='Pending' and Company='TW'";
                String sql1="";
                System.out.println(sql);
                ResultSet rs=st.executeQuery(sql);
    %>
            <div style="height:400px;width:1000px;overflow:scroll;">       
            <table width="100%" border="2" style="font-size: 10" class="sortable">
            <tr >
            <td colspan="7" align="center"><h1>Converted Data to Tally [Payroll]</h1></td>
            </tr>
            <th>Month</th>
            <th>Contractor ID</th>
            <th>Contractor Name</th>
            <th align="right">Gross Pay</th>
            <th align="right">TDS</th>
            <th align="right">Security</th>
            <th align="right">Recovery</th>
            <th align="right">Net Pay</th>
            <th>Bank Name</th>
            <th>Narrations</th>
            <th>Status</th>
            <%
            	String senddata=null;
                        while(rs.next()) 
                        {
                        	System.out.println("IN WHILE OF MAIN QUERYY>>>   ");
            %>
            <tr>
            <%
            	String mPayrollDate=rs.getString("PayrollDate");
                          //mInvoicedate="2011-04-01";
                          System.out.println("first"+mPayrollDate);
                          mPayrollDate=mPayrollDate.substring(0,4)+mPayrollDate.substring(5,7)+mPayrollDate.substring(8,10);
                          //rs.getString("b.tallyname").replace("&","&amp;")
                          System.out.println(mPayrollDate);
                          String mContractorID=rs.getString("ContractorID");
                          System.out.println("Contractor IDis         "+mContractorID);
                          String mContractorname=rs.getString("ContractorName");;
                          String mTransactionrefno=rs.getString("ContractorID")+rs.getString("Month1");
            	          String mMainContractorFeeAcc=rs.getString("MainContractorFeeAcc").replace("&","&amp;");
            	          String mMainTDSAccount=rs.getString("MainTDSAccount").replace("&","&amp;");
            	          String mIndividualContractorFeeAcc=rs.getString("IndividualContractorFeeAcc").replace("&","&amp;");
            	          String mIndividualContractorSDAcc=rs.getString("IndividualContractorSDAcc").replace("&","&amp;");
            	          String mIndividualContractorRecAcc=rs.getString("IndividualContractorRecAcc").replace("&","&amp;");
            	          Double mGP=rs.getDouble("GP");
            	          Double mTDS=rs.getDouble("TDS");
            	          Double mSD=rs.getDouble("SD");
            	          Double mRecovery=rs.getDouble("Recovery");
            	          Double mNetPay=rs.getDouble("NetPay");
            	          String mBankAccNo=rs.getString("BankAccNo");
            	          String mNarrations="Being Contractor Fee Entry of "+mContractorname+" for "+rs.getString("Month1");
                          
                          DecimalFormat df2 = new DecimalFormat( "0.00" );
                          String entrysearch="NOT FOUND";// = tally.search_in_tables("SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where voucher_no='"+mInvoiceno+"'  and voucher_type='Invoice-Direct' ");
                          String searchsql = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where voucher_no='"+ mTransactionrefno +"'  and voucher_type='Payroll-Direct' ";
                          ResultSet rs1=stmain.executeQuery(searchsql);
                        try
                        {
                          	while(rs1.next()) 
                              {
                          		entrysearch="Already "+rs1.getString("tallyvid");
                              }
                  	    }
                  	    catch (Exception e) 
                  	    {                          
                  	        e.printStackTrace();
                  	       entrysearch = "search in table problem "+e.toString();
                        }
                  	      //out.println("Entry found:"+entrysearch);
                          String mUsername=session.getAttribute("EmpName").toString();
                          senddata=null;
            %>
            <td><div> <%=mPayrollDate.substring(6,8)+"-"+mPayrollDate.substring(4,6)+"-"+mPayrollDate.substring(0,4)%></div></td>
            <td><%=mTransactionrefno%></td>
			<td><%=mContractorname%></td>
			<td align="right"><%=mGP%></td>
			<td align="right"><%=mTDS%></td>
			<td align="right"><%=mSD%></td>
			<td align="right"><%=mRecovery%></td>
			<td align="right"><%=mNetPay%></td>
			<td><%=mBankAccNo%></td>
			<td><%=mNarrations%></td> 
			
			<%
 							String Connected = tally.connectTallyserver(SID,PID);
 							System.out.println("CONNECTION  "+Connected);
 							
 							if (Connected=="Not Connected !!!")
 							{
 						%>
			<h3>Please Start your Tally ERP 9 Software First and Reload this page .... </h4>
			 	
			<%
			 					}
			 					
			 					StringBuilder xmldoc = new StringBuilder();
			 								
			 					xmldoc.append("<ENVELOPE>\r\n");
			 				    xmldoc.append("<HEADER>\r\n");
			 					xmldoc.append("<TALLYREQUEST>Import Data</TALLYREQUEST>\r\n");
			 					xmldoc.append("</HEADER>\r\n");
			 					xmldoc.append("<BODY>\r\n");
			 					xmldoc.append("<IMPORTDATA>\r\n");
			 					xmldoc.append("<REQUESTDESC>\r\n");
			 					xmldoc.append("<REPORTNAME>All Masters</REPORTNAME>\r\n");
			 					xmldoc.append("<STATICVARIABLES>\r\n");
			 					xmldoc.append("</STATICVARIABLES>\r\n");
			 					xmldoc.append("</REQUESTDESC>\r\n");
			 					xmldoc.append("<REQUESTDATA>\r\n");
			 					xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
			 					xmldoc.append("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>\r\n");
			 					xmldoc.append("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>\r\n");
			 					xmldoc.append("<DATE>"+mPayrollDate+"</DATE>\r\n");
			 					xmldoc.append("<PARTYLEDGERNAME>"+mIndividualContractorFeeAcc+"</PARTYLEDGERNAME>\r\n");
			 					xmldoc.append("<NARRATION>"+mNarrations+"</NARRATION>\r\n");
			 					xmldoc.append("<EFFECTIVEDATE>"+mPayrollDate+"</EFFECTIVEDATE>\r\n");
			 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
			 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
			 					xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
			 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
			 					xmldoc.append("<LEDGERNAME>"+mMainContractorFeeAcc+"</LEDGERNAME>\r\n");
			 					xmldoc.append("<AMOUNT>-"+ mGP+"</AMOUNT>\r\n");
			 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
			 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
			 					xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
			 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
			 					xmldoc.append("<LEDGERNAME>"+mIndividualContractorFeeAcc+"</LEDGERNAME>\r\n");
			 					xmldoc.append("<AMOUNT>"+ mGP+"</AMOUNT>\r\n");
			 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			 					xmldoc.append("</VOUCHER>\r\n");
			 					xmldoc.append("</TALLYMESSAGE>\r\n"); 
			 					if( mTDS >0)
			 					{
			 						mNarrations="Being TDS Deducted from "+mContractorname+" for "+rs.getString("Month1");
			 						xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
				 					xmldoc.append("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>\r\n");
				 					xmldoc.append("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>\r\n");
				 					xmldoc.append("<DATE>"+mPayrollDate+"</DATE>\r\n");
				 					xmldoc.append("<PARTYLEDGERNAME>"+mMainTDSAccount+"</PARTYLEDGERNAME>\r\n");
				 					xmldoc.append("<NARRATION>"+mNarrations+"</NARRATION>\r\n");
				 					xmldoc.append("<EFFECTIVEDATE>"+mPayrollDate+"</EFFECTIVEDATE>\r\n");
				 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				 					xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
				 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				 					xmldoc.append("<LEDGERNAME>"+mIndividualContractorFeeAcc+"</LEDGERNAME>\r\n");
				 					xmldoc.append("<AMOUNT>-"+ mTDS+"</AMOUNT>\r\n");
				 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				 					xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
				 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				 					xmldoc.append("<LEDGERNAME>"+mMainTDSAccount+"</LEDGERNAME>\r\n");
				 					xmldoc.append("<AMOUNT>"+ mTDS+"</AMOUNT>\r\n");
				 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("</VOUCHER>\r\n");
				 					xmldoc.append("</TALLYMESSAGE>\r\n");	
			 					}
			 					
			 					if( mSD >0)
			 					{
			 						mNarrations="Being SD Deducted from "+mContractorname+" for "+rs.getString("Month1");
			 						xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
				 					xmldoc.append("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>\r\n");
				 					xmldoc.append("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>\r\n");
				 					xmldoc.append("<DATE>"+mPayrollDate+"</DATE>\r\n");
				 					xmldoc.append("<PARTYLEDGERNAME>"+mIndividualContractorSDAcc+"</PARTYLEDGERNAME>\r\n");
				 					xmldoc.append("<NARRATION>"+mNarrations+"</NARRATION>\r\n");
				 					xmldoc.append("<EFFECTIVEDATE>"+mPayrollDate+"</EFFECTIVEDATE>\r\n");
				 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				 					xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
				 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				 					xmldoc.append("<LEDGERNAME>"+mIndividualContractorFeeAcc+"</LEDGERNAME>\r\n");
				 					xmldoc.append("<AMOUNT>-"+ mSD+"</AMOUNT>\r\n");
				 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				 					xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
				 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				 					xmldoc.append("<LEDGERNAME>"+mIndividualContractorSDAcc+"</LEDGERNAME>\r\n");
				 					xmldoc.append("<AMOUNT>"+ mSD+"</AMOUNT>\r\n");
				 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("</VOUCHER>\r\n");
				 					xmldoc.append("</TALLYMESSAGE>\r\n");	
			 					}
			 					
			 					if( mRecovery >0)
			 					{
			 						mNarrations="Being Recovery Deducted from "+mContractorname+" for "+rs.getString("Month1");
			 						xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
				 					xmldoc.append("<VOUCHER  VCHTYPE='Journal' ACTION='Create'>\r\n");
				 					xmldoc.append("<VOUCHERTYPENAME>Journal</VOUCHERTYPENAME>\r\n");
				 					xmldoc.append("<DATE>"+mPayrollDate+"</DATE>\r\n");
				 					xmldoc.append("<PARTYLEDGERNAME>"+mIndividualContractorRecAcc+"</PARTYLEDGERNAME>\r\n");
				 					xmldoc.append("<NARRATION>"+mNarrations+"</NARRATION>\r\n");
				 					xmldoc.append("<EFFECTIVEDATE>"+mPayrollDate+"</EFFECTIVEDATE>\r\n");
				 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				 					xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
				 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				 					xmldoc.append("<LEDGERNAME>"+mIndividualContractorFeeAcc+"</LEDGERNAME>\r\n");
				 					xmldoc.append("<AMOUNT>-"+ mRecovery+"</AMOUNT>\r\n");
				 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				 					xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
				 					xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				 					xmldoc.append("<LEDGERNAME>"+mIndividualContractorRecAcc+"</LEDGERNAME>\r\n");
				 					xmldoc.append("<AMOUNT>"+ mRecovery+"</AMOUNT>\r\n");
				 					xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				 					xmldoc.append("</VOUCHER>\r\n");
				 					xmldoc.append("</TALLYMESSAGE>\r\n");	
			 					}
			 	
			 					xmldoc.append("<REQUESTDATA/>\r\n");
			 					xmldoc.append("<IMPORTDATA/>\r\n");
			 					xmldoc.append("<BODY/>\r\n");
			 					xmldoc.append("<ENVELOPE/>\r\n");
						 				%>
            <td>
            <%
            	System.out.println("EN DOF XML");
                                    
                        if (entrysearch=="NOT FOUND")
                        {
                        	System.out.println("IN IF ");
                            senddata = tally.sendTallyserver(xmldoc.toString(),SID,PID);
                            System.out.println("****");
                            out.println(senddata);
                            System.out.println(">>>>>>>>>>>>    >>>>>>>>>>>>>>        "+senddata);
                        }
                        else
                        {
                        	System.out.println("IN ELSE   ");
                            senddata=entrysearch;            	
                        	out.println(entrysearch);
                        	System.out.println("&&&&&&&&&&&&&&&&&&   *********************   #########");
                        	System.out.println("%%%%%%%%   %%%%%%%%%%%%%%%%%%   "+senddata);
                        }
            %>
            </td>
            <%
            if (senddata.contains("Updated") && (entrysearch=="NOT FOUND") )
            {
            	System.out.println("IN QUERY   ");
                
            	//out.println("inserting data");
            	mNarrations="Being Contractor Fee Entry of "+mContractorname+" for "+rs.getString("Month1");
            	sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv (voucher_type,voucher_date,voucher_no,accountname,secondaccount,amount,narrations,username,create_date,tallyvid)"+
                     "VALUES ( 'Payroll-Direct','"+mPayrollDate+"','"+mTransactionrefno+"','"+mContractorname+"','"+mMainContractorFeeAcc+"','"+mGP+"','"+mNarrations+"','"+mUsername+"','"+todaysDateTime+"','"+senddata+"' )";
                //out.println("SQL:===>"+sql1);
            	st2.executeUpdate(sql1);
            	//out.println("DATA UPDATION DONE");
        	}
            System.out.println("AFTER LAST IF  ");
          }
            
        }
        catch(Exception e)
        {
          e.printStackTrace();
          System.out.println("CATCH ERROR    ()()()(  () "+e);
        }
        %>
        
        </tr>
        </table>
        </div>
        <%
        }
        %>
    <br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	</body>
</html>
</jsp:useBean>