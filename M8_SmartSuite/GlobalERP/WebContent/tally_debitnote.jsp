<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - Debit Note Vouchers</title>
</head>
<body>
<style type="text/css">


</style>


<form name="xyz" method="get" action="">
<%
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();
tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD,SID,PID,CMID);
Connection conn = null;
Statement st = null, st1 = null, st3 = null, st4 = null;
Statement st2 = null;
String selectedName;
Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
String fromDate="",toDate="",fromDateCal="",toDateCal="",mDate;
String companyName="",phone="",contact="",email="",product="",city="";
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
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
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
 </td><td align="center" valign="top" style="width: 20px;">
			&nbsp; </td><td align="left" valign="top" style="width: 180px;"> End Date:
			  
			 <input type="text" id="todate"
						name="todate" value="<%=toDateCal %>" size="15" readonly
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
		    st1 = conn.createStatement();
		    st2 = conn.createStatement();
            //out.println(fromDate);
            //out.println(toDate);
		    String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode where a.paymentdate BETWEEN '"+fromDate+"' and '"+toDate+"'  and paymentmode = 'Debit Note' order by paymentdate";
            String sql1="";
            System.out.println(sql);
            ResultSet rs=st1.executeQuery(sql);
            %>
                     
            <table align="left" style="font-size: 10" class="sortable">
            <tr >
            <td colspan="7" ><h1>Converted Data to Tally [DEBIT NOTE]</h1></td>
            </tr>
            <th>Voucher Date</th>
            <th>Voucher No</th>
            <th>Account Name</th>
            <th align="right">Amount</th>
            <th>Second Account</th>
            <th>Narrations</th>
            <th>Status</th>
            <%
            String senddata=null;
            while(rs.next()) 
            {
            %>
            <tr>
            <%
                String mVoudate=rs.getString("paymentdate");
                mVoudate="2010-04-01";
                System.out.println("first"+mVoudate);
                mVoudate=mVoudate.substring(0,4)+mVoudate.substring(5,7)+mVoudate.substring(8,10);
                System.out.println(mVoudate);
                String mVoucherno=rs.getString("paymentvoucherno");
                String mCompanyname=rs.getString("b.companyname").replace("&","and");
                String mSecondname="Data Access Charges"; // ACCOUNT NAME OF CREDIT ACCOUNT
                String mAmount=rs.getString("amountpaid");
                String mNarration=rs.getString("remarks");
                String mReference = "aa";
               	String entrysearch = tally.search_in_tables("SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where voucher_no='"+mVoucherno+"' and voucher_type='Debit Note'");
                String mUsername=session.getAttribute("EmpName").toString();
                senddata=null;
            %>
            <td><div> <%=mVoudate.substring(6,8)+"-"+mVoudate.substring(4,6)+"-"+mVoudate.substring(0,4)%></div></td>
            <td><%=mVoucherno%></td>
			<td><%=mCompanyname%></td>
			<td align="right"><%=mAmount%></td>
			<td><%=mSecondname%></td>
			<td><%=mNarration%></td>
					
			<%
			String ipAddress =request.getRemoteAddr(); 
			String Connected = tally.connectTallyserver(SID,PID);
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
            xmldoc.append("<REPORTNAME>Vouchers</REPORTNAME>\r\n");
            xmldoc.append("<STATICVARIABLES>\r\n");
            xmldoc.append("</STATICVARIABLES>\r\n");
            xmldoc.append("</REQUESTDESC>\r\n");
            xmldoc.append("<REQUESTDATA>\r\n");
            xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
            xmldoc.append("<VOUCHER  VCHTYPE='Debit Note' ACTION='Create'>\r\n");
            xmldoc.append("<DATE>"+mVoudate+"</DATE>\r\n");
            xmldoc.append("<NARRATION>"+mNarration+"</NARRATION>\r\n");
            xmldoc.append("<VOUCHERTYPENAME>Debit Note</VOUCHERTYPENAME>\r\n");
            xmldoc.append("<VOUCHERNUMBER>"+mVoucherno+"</VOUCHERNUMBER>\r\n");
            xmldoc.append("<REFERENCE>"+mReference+"</REFERENCE>\r\n");
            xmldoc.append("<PARTYLEDGERNAME>"+mCompanyname+"</PARTYLEDGERNAME>\r\n");
            xmldoc.append("<STATADJUSTMENTTYPE>Others</STATADJUSTMENTTYPE>\r\n");
            xmldoc.append("<CSTFORMISSUETYPE/>\r\n");
            xmldoc.append("<CSTFORMRECVTYPE/>\r\n");
            xmldoc.append("<FBTPAYMENTTYPE>Default</FBTPAYMENTTYPE>\r\n");
            xmldoc.append("<VCHGSTCLASS/>\r\n");
            xmldoc.append("<ENTEREDBY>murali</ENTEREDBY>\r\n");
            xmldoc.append("<DIFFACTUALQTY>No</DIFFACTUALQTY>\r\n");
            xmldoc.append("<AUDITED>No</AUDITED>\r\n");
            xmldoc.append("<FORJOBCOSTING>No</FORJOBCOSTING>\r\n");
            xmldoc.append("<ISOPTIONAL>No</ISOPTIONAL>\r\n");
            xmldoc.append("<EFFECTIVEDATE>"+mVoudate+"</EFFECTIVEDATE>\r\n");
            xmldoc.append("<USEFORINTEREST>No</USEFORINTEREST>\r\n");
            xmldoc.append("<USEFORGAINLOSS>No</USEFORGAINLOSS>\r\n");
            xmldoc.append("<USEFORGODOWNTRANSFER>No</USEFORGODOWNTRANSFER>\r\n");
            xmldoc.append("<USEFORCOMPOUND>No</USEFORCOMPOUND>\r\n");
            xmldoc.append("<ALTERID> 158332</ALTERID>\r\n");
            xmldoc.append("<EXCISEOPENING>No</EXCISEOPENING>\r\n");
            xmldoc.append("<USEFORFINALPRODUCTION>No</USEFORFINALPRODUCTION>\r\n");
            xmldoc.append("<ISCANCELLED>No</ISCANCELLED>\r\n");
            xmldoc.append("<HASCASHFLOW>No</HASCASHFLOW>\r\n");
            xmldoc.append("<ISPOSTDATED>No</ISPOSTDATED>\r\n");
            xmldoc.append("<USETRACKINGNUMBER>No</USETRACKINGNUMBER>\r\n");
            xmldoc.append("<ISINVOICE>No</ISINVOICE>\r\n");
            xmldoc.append("<MFGJOURNAL>No</MFGJOURNAL>\r\n");
            xmldoc.append("<HASDISCOUNTS>No</HASDISCOUNTS>\r\n");
            xmldoc.append("<ASPAYSLIP>No</ASPAYSLIP>\r\n");
            xmldoc.append("<ISCOSTCENTRE>No</ISCOSTCENTRE>\r\n");
            xmldoc.append("<ISDELETED>No</ISDELETED>\r\n");
            xmldoc.append("<ASORIGINAL>No</ASORIGINAL>\r\n");
            xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<LEDGERNAME>"+mCompanyname+"</LEDGERNAME>\r\n");
            xmldoc.append("<GSTCLASS/>\r\n");
            xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
            xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
            xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
            xmldoc.append("<ISPARTYLEDGER>Yes</ISPARTYLEDGER>\r\n");
            xmldoc.append("<AMOUNT>-"+mAmount+"</AMOUNT>\r\n");
            xmldoc.append("<BILLALLOCATIONS.LIST>\r\n");
            xmldoc.append("<NAME>"+mReference+"</NAME>\r\n");
            xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
            xmldoc.append("<AMOUNT>-"+mAmount+"</AMOUNT>\r\n");
            xmldoc.append("</BILLALLOCATIONS.LIST>\r\n");
            xmldoc.append("<UDF:VATDEALERNATURE.LIST DESC='`VATDealerNature`' ISLIST='YES' TYPE='String'>\r\n");
            xmldoc.append("<UDF:VATDEALERNATURE DESC='`VATDealerNature`'>Inter State Dealer</UDF:VATDEALERNATURE>\r\n");
            xmldoc.append("</UDF:VATDEALERNATURE.LIST>\r\n");
            xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<LEDGERNAME>"+mSecondname+"</LEDGERNAME>\r\n");
            xmldoc.append("<GSTCLASS/>\r\n");
            xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
            xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
            xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
            xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
            xmldoc.append("<AMOUNT>"+mAmount+"</AMOUNT>\r\n");
            xmldoc.append("<CATEGORYALLOCATIONS.LIST>\r\n");
            xmldoc.append("<CATEGORY>Primary Cost Category</CATEGORY>\r\n");
            xmldoc.append("<COSTCENTREALLOCATIONS.LIST>\r\n");
            xmldoc.append("<NAME></NAME>\r\n");
            xmldoc.append("<AMOUNT>"+mAmount+"</AMOUNT>\r\n");
            xmldoc.append("</COSTCENTREALLOCATIONS.LIST>\r\n");
            xmldoc.append("</CATEGORYALLOCATIONS.LIST>\r\n");
            xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<UDF:VATDEALERNATURE.LIST DESC='`VATDealerNature`' ISLIST='YES' TYPE='String'>\r\n");
            xmldoc.append("<UDF:VATDEALERNATURE DESC='`VATDealerNature`'>Inter State Dealer</UDF:VATDEALERNATURE>\r\n");
            xmldoc.append("</UDF:VATDEALERNATURE.LIST>\r\n");
            xmldoc.append("</VOUCHER>\r\n");
            xmldoc.append("</TALLYMESSAGE>\r\n");
            xmldoc.append("</REQUESTDATA>\r\n");
            xmldoc.append("</IMPORTDATA>\r\n");
            xmldoc.append("</BODY>\r\n");
            xmldoc.append("</ENVELOPE>\r\n");
            %>
            <td>
            <%
            if (entrysearch=="NOT FOUND")
            {
                 senddata = tally.sendTallyserver(xmldoc.toString(),SID,PID);
                 out.println(senddata);
            }
            else
            {
                senddata=entrysearch;            	
            	out.println(entrysearch);
            }
            %>
            </td>
            <%
                   
            if (senddata.contains("Updated") && (entrysearch=="NOT FOUND") )
            {
            	sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv (voucher_type,voucher_date,voucher_no,accountname,secondaccount,amount,narrations,username,create_date,tallyvid)"+
                     "VALUES ( 'Debit Note','"+mVoudate+"','"+mVoucherno+"','"+mCompanyname+"','"+mSecondname+"','"+mAmount+"','"+mNarration+"','"+mUsername+"','"+todaysDateTime+"','"+senddata+"' )";
                st2.executeUpdate(sql1);
        	}
            
            }
        }
        catch(Exception e)
        {
          out.println(e);
        }
        %>
        </tr>
        </table>
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