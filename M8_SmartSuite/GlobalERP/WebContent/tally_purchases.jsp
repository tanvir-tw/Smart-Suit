<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - Purchase Vouchers</title>
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
    <table align="center">
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
		    String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on a.suppliercode = b.suppliercode where a.purinvoicedate BETWEEN '"+fromDate+"' and '"+toDate+"'  order by a.purinvoicedate";
            String sql1="";
            System.out.println(sql);
            ResultSet rs=st1.executeQuery(sql);
            %>
                     
            <table width="100%" border="2" style="font-size: 10" class="sortable">
            <tr >
            <td colspan="7" align="center"><h1>Converted Data to Tally [PURCHASES]</h1></td>
            </tr>
            <th>Voucher Date</th>
            <th>Voucher No</th>
            <th>Account Name</th>
            <th align="right">Amount</th>
            <th>Secound Account</th>
            <th>Narrations</th>
            <th>Status</th>
            <%
            String senddata=null;
            while(rs.next()) 
            {
            %>
            <tr>
            <%
               	String mVoudate=rs.getString("purinvoicedate");
               	mVoudate="2011-04-01";
               	System.out.println("first "+mVoudate);
            	mVoudate=mVoudate.substring(0,4)+mVoudate.substring(5,7)+mVoudate.substring(8,10);
            	System.out.println(mVoudate);
            	String mVoucherno=rs.getString("purinvoiceno");
            	String mInvoicerefno=rs.getString("supinvoiceref");
            	String mCompanyname=rs.getString("b.suppliername").replace("&","&amp;");
            	out.println(mCompanyname);
            	String mGrandtotal=rs.getString("grandtotal");
            	String mTotal=rs.getString("total");
                String mDiscountper = rs.getString("discountpercent");
            	String mTaxpersent = rs.getString("taxpercent");
            	String mCstorMst = rs.getString("cstormst");
            	String mPfipersent = rs.getString("pfipercent");
            	String mFreightAmount=rs.getString("freightamount");
            	String mExcisetax = rs.getString("excisetax");
                double tptotal = Double.parseDouble(mTotal);
            	double tpexcisetax = tptotal*(Double.parseDouble(mExcisetax)/100);
            	double tptax = (tptotal+tpexcisetax) * (Double.parseDouble(mTaxpersent)/100);
            	double tppfi = 0;
            	if (Double.parseDouble(mPfipersent)!=0)
            	{
                     tppfi = (tptotal+tpexcisetax)  * (Double.parseDouble(mPfipersent)/100); 
            	}
            	else
            	{
             	     tppfi = Double.parseDouble(mFreightAmount);
            	}
            	double tpdiscount = (tptotal+tpexcisetax+tppfi)*(Double.parseDouble(mTaxpersent)/100);
            	String mReference = "";
            	String mNarrations="Being monthly service charges against inv no "+mInvoicerefno+" dtd. "+mVoudate.substring(6,8)+"."+mVoudate.substring(4,6)+"."+mVoudate.substring(0,4);
            	//Being  Pkg Comp. TLT7SC-12 28E  qty 1 invoice no, GN1112-0353 Dtd: 30.06.2011
            
            	String mDiscountac="Discount";
            	String mSalestaxac = "";
            	if (mCstorMst=="CST")
            	{
	                mSalestaxac = "Purchase Tax OMS @"+mTaxpersent;
            	}
            	else
            	{
	                mSalestaxac = "Purchase Tax MS @ "+mTaxpersent;
            	}
            	String mFreightac = "FREIGHT &amp; OCTROI PAID";
            	String mExciseac = "Central Excise duty @ "+mExcisetax;
            	String entrysearch = tally.search_in_tables("SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where voucher_no='"+mVoucherno+"' and voucher_type='Purchases'");
            	String mUsername=session.getAttribute("EmpName").toString();
            	senddata=null;
            %>
            <td><div> <%=mVoudate.substring(6,8)+"-"+mVoudate.substring(4,6)+"-"+mVoudate.substring(0,4)%></div></td>
            <td><%=mVoucherno%></td>
			<td><%=mCompanyname%></td>
			<td align="right"><%=mGrandtotal%></td>
			<td><%=mSalestaxac%></td>
			<td><%=mNarrations%></td> 
			
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
			xmldoc.append("<BODY>\r\n");
            xmldoc.append("<HEADER>\r\n");
            xmldoc.append("<TALLYREQUEST>Import Data</TALLYREQUEST>\r\n");
            xmldoc.append("</HEADER>\r\n");
            xmldoc.append("<IMPORTDATA>\r\n");
            xmldoc.append("<REQUESTDESC>\r\n");
            xmldoc.append("<REPORTNAME>Vouchers</REPORTNAME>\r\n");
            xmldoc.append("<STATICVARIABLES>\r\n");
            xmldoc.append("<SVCURRENTCOMPANY></SVCURRENTCOMPANY>\r\n");
            xmldoc.append("</STATICVARIABLES>\r\n");
            xmldoc.append("</REQUESTDESC>\r\n"); 
            xmldoc.append("<REQUESTDATA>\r\n");
            xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
            xmldoc.append("<VOUCHER  VCHTYPE='Purchase' ACTION='Create'>\r\n");
            xmldoc.append("<DATE>"+mVoudate+"</DATE>\r\n");
            xmldoc.append("<NARRATION>"+mNarrations+"</NARRATION>\r\n");
            xmldoc.append("<VOUCHERTYPENAME>Purchase</VOUCHERTYPENAME>\r\n");
            xmldoc.append("<VOUCHERNUMBER>"+mVoucherno+"</VOUCHERNUMBER>\r\n");
            xmldoc.append("<REFERENCE>"+mReference+"</REFERENCE>\r\n");
            xmldoc.append("<PARTYLEDGERNAME>"+mCompanyname+"</PARTYLEDGERNAME>\r\n");
            xmldoc.append("<CSTFORMISSUETYPE>C Form</CSTFORMISSUETYPE>\r\n");
            xmldoc.append("<CSTFORMRECVTYPE>Default</CSTFORMRECVTYPE>\r\n");
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
            xmldoc.append("<ALTERID> 158334</ALTERID>\r\n");
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
            xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
            xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
            xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
            xmldoc.append("<ISPARTYLEDGER>Yes</ISPARTYLEDGER>\r\n");
            xmldoc.append("<AMOUNT>"+mGrandtotal+"</AMOUNT>\r\n");
            xmldoc.append("<BILLALLOCATIONS.LIST>\r\n");
            xmldoc.append("<NAME>"+mReference+"</NAME>\r\n");
            xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
            xmldoc.append("<AMOUNT>"+mGrandtotal+"</AMOUNT>\r\n");
            xmldoc.append("</BILLALLOCATIONS.LIST>\r\n");
            xmldoc.append("<UDF:VATDEALERNATURE.LIST DESC='`VATDealerNature`' ISLIST='YES' TYPE='String'>\r\n");
            xmldoc.append("<UDF:VATDEALERNATURE DESC='`VATDealerNature`'>Inter State Dealer</UDF:VATDEALERNATURE>\r\n");
            xmldoc.append("</UDF:VATDEALERNATURE.LIST>\r\n");
            xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<TAXCLASSIFICATIONNAME>Inter-State Purchases</TAXCLASSIFICATIONNAME>\r\n");
            xmldoc.append("<LEDGERNAME>"+mSalestaxac+"</LEDGERNAME>\r\n");
            xmldoc.append("<GSTCLASS/>\r\n");
            xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
            xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
            xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
            xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
            xmldoc.append("<AMOUNT>-"+tptax+"</AMOUNT>\r\n");
            xmldoc.append("<CATEGORYALLOCATIONS.LIST>\r\n");
            xmldoc.append("<CATEGORY>Primary Cost Category</CATEGORY>\r\n");
            xmldoc.append("<COSTCENTREALLOCATIONS.LIST>\r\n");
            xmldoc.append("<NAME>Piston</NAME>\r\n");
            xmldoc.append("<AMOUNT>-"+tptax+"</AMOUNT>\r\n");
            xmldoc.append("</COSTCENTREALLOCATIONS.LIST>\r\n");
            xmldoc.append("</CATEGORYALLOCATIONS.LIST>\r\n");
            xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<LEDGERNAME>"+mSalestaxac+"</LEDGERNAME>\r\n");
            xmldoc.append("<GSTCLASS/>\r\n");
            xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
            xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
            xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
            xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
            xmldoc.append("<AMOUNT>-"+tptax+"</AMOUNT>\r\n");
            xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<LEDGERNAME>"+mFreightac+"</LEDGERNAME>\r\n");
            xmldoc.append("<GSTCLASS/>\r\n");
            xmldoc.append("<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n");
            xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
            xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
            xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
            xmldoc.append("<AMOUNT>-"+tppfi+"</AMOUNT>\r\n");
            xmldoc.append("<CATEGORYALLOCATIONS.LIST>\r\n");
            xmldoc.append("<CATEGORY>Primary Cost Category</CATEGORY>\r\n");
            xmldoc.append("<COSTCENTREALLOCATIONS.LIST>\r\n");
            xmldoc.append("<NAME>Central Cost</NAME>\r\n");
            xmldoc.append("<AMOUNT>-"+mTotal+"</AMOUNT>\r\n");
            xmldoc.append("</COSTCENTREALLOCATIONS.LIST>\r\n");
            xmldoc.append("</CATEGORYALLOCATIONS.LIST>\r\n");
            xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
            xmldoc.append("<UDF:REFERENCEDATE.LIST DESC='`ReferenceDate`' ISLIST='YES' TYPE='Date'>\r\n");
            xmldoc.append("<UDF:REFERENCEDATE DESC='`ReferenceDate`'>"+mVoudate+"</UDF:REFERENCEDATE>\r\n");
            xmldoc.append("</UDF:REFERENCEDATE.LIST>\r\n");
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
                     "VALUES ( 'Purchases','"+mVoudate+"','"+mVoucherno+"','"+mCompanyname+"','"+mSalestaxac+"','"+mGrandtotal+"','"+mNarrations+"','"+mUsername+"','"+todaysDateTime+"','"+senddata+"' )";
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