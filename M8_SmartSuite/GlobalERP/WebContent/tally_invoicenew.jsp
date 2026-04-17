<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - Invoices-Data Access</title>
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
 </td><td align="center" valign="top" style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left" valign="top" style="width: 180px;"> End Date:
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
            st =conn.createStatement();
		    st1 = conn.createStatement();
		    st2 = conn.createStatement();
		    st3 = conn.createStatement();
		    st4 = conn.createStatement();
		    stmain = conn.createStatement();
            //out.println(fromDate);
            //out.println(toDate);
		    String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode   where a.InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"' and a.twempname='Autogenerated'  and a.invoicecancelled = 0  order by a.InvoiceDate";
            String sql1="";
            System.out.println(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            <div style="height:400px;width:1000px;overflow:scroll;">       
            <table width="100%" border="2" style="font-size: 10" class="sortable">
            <tr >
            <td colspan="7" align="center"><h1>Converted Data to Tally [INVOICES-Data Access Charges]</h1></td>
            </tr>
            <th>Voucher Date</th>
            <th>Voucher No</th>
            <th>Account Name</th>
            <th align="right">Amount</th>
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
              String mInvoicedate=rs.getString("invoicedate");
              //mInvoicedate="2011-04-01";
              System.out.println("first"+mInvoicedate);
              mInvoicedate=mInvoicedate.substring(0,4)+mInvoicedate.substring(5,7)+mInvoicedate.substring(8,10);
              
              System.out.println(mInvoicedate);
              String mInvoiceno=rs.getString("invoiceno");
              System.out.println("INVOICE NOS IS         "+mInvoiceno);
              String mCompanyname=null;
              String mInvoicerefno=rs.getString("invoicerefno");
	String mTotal="0.00";
	String mInvtype="invnoscst";
              if (rs.getString("b.tallyname")!=null)
              {
              mCompanyname=rs.getString("b.tallyname").replace("&","&amp;");
              }
              else
              {
            	  mCompanyname=rs.getString("b.tallyname");
              }
              String mGrandtotal=rs.getString("grandtotal");
              
              //total is base figure.sales items.....add mnthly servise charge,adjustable values ...and ignore serrvice chagre and taxes...
              //String mTotal=rs.getString("c.sellingprice");
   System.out.println("INVOICE cloed         ");

//
//Identifying  Sub Total
	 String sqlsubtot="select sum(Quantity*sellingprice) as sellingprice from "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items where InvoiceNo="+mInvoiceno+"  and  itemdescription in ('Monthly Service Charges','Adjustment in Bill Days','Voluntary SLA Adjustment','JRM - Monthly Road Risk Data Flat Charges')";
     ResultSet rssubtot=st1.executeQuery(sqlsubtot);
	if(rssubtot.next()) 
	{
	  mTotal=rssubtot.getString("sellingprice");
	}
	 System.out.println("reeeeeeeeeeeeeeeeee     ");
//Identifying Invoice Type
	 String sqlinvtype="select  *  from "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items where InvoiceNo="+mInvoiceno+"  and  itemdescription in ('Basic ST 12%')";
     ResultSet rsinvtype=st2.executeQuery(sqlinvtype);
	 if(rsinvtype.next()) 
	 {
	   mInvtype="invst" ;
     }
	 System.out.println("tttttttttttttttttttttttttttttttttttt  ");

	 String sqlinvtype1="select  *  from "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items where InvoiceNo="+mInvoiceno+"  and  itemdescription in ('Service Charge 12.36%')";
     ResultSet rsinvtype1=st3.executeQuery(sqlinvtype1);
	 if(rsinvtype1.next()) 
	 {
		mInvtype="invsc" ;
	 }
	 System.out.println("pppppppppppppppppppppppppppppp     ");
	          String mNarrations="Being monthly service charges against inv no "+mInvoicerefno+" dtd. "+mInvoicedate.substring(6,8)+"."+mInvoicedate.substring(4,6)+"."+mInvoicedate.substring(0,4);
              String mServicetaxAc="Service Tax (Output) ";
              String mTdspartyname="Data Access Charges";
              
              //need to add this field..
              String mServiceChargeAc="Service Charges";
              String mServiceChargeAmt="0.00";
              String mServiceChargerate="12.36";

              String mTdstaxrate="12"; //12 as per new ..
              String mTdssurcharge="2";
              String mStsecondarycessrate="1";
              String mSurchargeamount="0";
              String mAddlsurchargeamount="0";
              String mStsecondarycessamount="0";
              String mServicetaxamount="0";                        
              String mAssessableamount="0";
              String mDiscountac="Discount";
              String mDiscountamount="0";
              
              double tptotal = Double.parseDouble(mTotal);
              DecimalFormat df2 = new DecimalFormat( "0.00" );
              //System.out.println("tp total-"+tptotal);
              double tpsurchargeamount = tptotal * .12;
              //System.out.println(tpsurchargeamount);

	          double tpservicechargeamount =(tptotal * (12.36/100));
              //System.out.println(tpservicechargeamount);
			 			  	
              double tpaddlsurchargeamount=tpsurchargeamount*.02;
              //System.out.println(tpaddlsurchargeamount);
              double tpstsecondarycessamount=tpsurchargeamount*.01;
              //System.out.println(tpstsecondarycessamount);
              double tpservicetaxamount=(tpsurchargeamount+tpaddlsurchargeamount+tpstsecondarycessamount);
              //System.out.println(tpservicetaxamount);
			  mServiceChargeAmt=df2.format(tpservicechargeamount);

              //mSurchargeamount=Double.toString(tpsurchargeamount);
              mSurchargeamount=df2.format(tpsurchargeamount);
              //out.println("surcharge amount :-----"+mSurchargeamount);
              //mAddlsurchargeamount=Double.toString(tpaddlsurchargeamount);
              mAddlsurchargeamount=df2.format(tpaddlsurchargeamount);
              //mStsecondarycessamount=Double.toString(tpstsecondarycessamount);
              mStsecondarycessamount=df2.format(tpstsecondarycessamount);
              //mServicetaxamount=Double.toString(tpservicetaxamount);
              mServicetaxamount=df2.format(tpservicetaxamount);
              //mAssessableamount=mTotal;
              mAssessableamount=mTotal;
			  double nGrandTotal=0.00;	
			  double nTotal=0.00;
			  double nDiscountamount=0.00;
			
			  nTotal=Double.parseDouble(mTotal);
			  mTotal=df2.format(nTotal);
			  nTotal=Double.parseDouble(mTotal);
			
			
			nGrandTotal=Double.parseDouble(mGrandtotal);
			 System.out.println("r55555555555555555    ");
//	if mDiscountamount

	if (mInvtype=="invsc")
	{
		nDiscountamount=nGrandTotal-(nTotal+tpservicechargeamount);
	}

	if (mInvtype=="invst")
	{
		nDiscountamount=nGrandTotal-(nTotal+tpservicetaxamount);
	}
	
	if (mInvtype=="invnoscst")
	{
		nDiscountamount=nGrandTotal-nTotal;
	}
	
	String nTest=df2.format(nDiscountamount);
	
	mDiscountamount=nTest;
	 
	System.out.println("DISCOUNT AMONUT IN STRIN ISS    "+mDiscountamount);

              //out.println("grandtotal"+mGrandtotal+"mtotal:"+mTotal+"surcharge"+mSurchargeamount+"additional"+mAddlsurchargeamount+"stsecondary"+mStsecondarycessamount+"service"+mServicetaxamount+"assessable"+mAssessableamount);
      		  //out.println("searching entry:"+mInvoiceno);
              String entrysearch="NOT FOUND";// = tally.search_in_tables("SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where voucher_no='"+mInvoiceno+"'  and voucher_type='Invoice-Direct' ");
              String searchsql = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where voucher_no='"+mInvoiceno+"'  and voucher_type='Invoice-Direct' ";
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
            <td><div> <%=mInvoicedate.substring(6,8)+"-"+mInvoicedate.substring(4,6)+"-"+mInvoicedate.substring(0,4)%></div></td>
            <td><%=mInvoiceno%></td>
			<td><%=mCompanyname%></td>
			<td align="right"><%=mGrandtotal%></td>
			<td><%=mTdspartyname%></td>
			<td><%=mNarrations%></td> 
			
			<%
			//String ipAddress =request.getRemoteAddr(); 
			//String ipAddress="115.112.36.134";
			//String ipAddress="192.168.2.52";
			//System.out.println("IP ADREDDSSS     "+ipAddress);
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
			xmldoc.append("<REPORTNAME>Vouchers</REPORTNAME>\r\n");
			xmldoc.append("<STATICVARIABLES>\r\n");
			xmldoc.append("</STATICVARIABLES>\r\n");
			xmldoc.append("</REQUESTDESC>\r\n");
			xmldoc.append("<REQUESTDATA>\r\n");
			xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
			xmldoc.append("<VOUCHER  VCHTYPE='Sales' ACTION='Create'>\r\n");
			xmldoc.append("<DATE>"+mInvoicedate+"</DATE>\r\n");
			xmldoc.append("<NARRATION>"+mNarrations+"</NARRATION>\r\n");
			xmldoc.append("<VOUCHERTYPENAME>Sales</VOUCHERTYPENAME>\r\n");
			xmldoc.append("<VOUCHERNUMBER>"+mInvoiceno+"</VOUCHERNUMBER>\r\n");
			xmldoc.append("<REFERENCE>"+mInvoicerefno+"</REFERENCE>\r\n");
			xmldoc.append("<PARTYLEDGERNAME>"+mCompanyname+"</PARTYLEDGERNAME>\r\n");
			xmldoc.append("<CSTFORMISSUETYPE/>\r\n");
			xmldoc.append("<CSTFORMRECVTYPE/>\r\n");
			xmldoc.append("<FBTPAYMENTTYPE>Default</FBTPAYMENTTYPE>\r\n");
			xmldoc.append("<VCHGSTCLASS/>\r\n");
			xmldoc.append("<ENTEREDBY>murali</ENTEREDBY>\r\n");
			xmldoc.append("<DIFFACTUALQTY>No</DIFFACTUALQTY>\r\n");
			xmldoc.append("<AUDITED>No</AUDITED>\r\n");
			xmldoc.append("<FORJOBCOSTING>No</FORJOBCOSTING>\r\n");
			xmldoc.append("<ISOPTIONAL>No</ISOPTIONAL>\r\n");
			xmldoc.append("<EFFECTIVEDATE>"+mInvoicedate+"</EFFECTIVEDATE>\r\n");
			xmldoc.append("<USEFORINTEREST>No</USEFORINTEREST>\r\n");
			xmldoc.append("<USEFORGAINLOSS>No</USEFORGAINLOSS>\r\n");
			xmldoc.append("<USEFORGODOWNTRANSFER>No</USEFORGODOWNTRANSFER>\r\n");
			xmldoc.append("<USEFORCOMPOUND>No</USEFORCOMPOUND>\r\n");
			xmldoc.append("<ALTERID> 159860</ALTERID>\r\n");
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
			xmldoc.append("<AMOUNT>-"+mGrandtotal+"</AMOUNT>\r\n");
			xmldoc.append("<BILLALLOCATIONS.LIST>\r\n");
			xmldoc.append("<NAME>"+mInvoicerefno+"</NAME>\r\n");
			xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
			xmldoc.append("<AMOUNT>-"+mGrandtotal+"</AMOUNT>\r\n");
			xmldoc.append("</BILLALLOCATIONS.LIST>\r\n");
			xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
			xmldoc.append("<LEDGERNAME>"+mTdspartyname+"</LEDGERNAME>\r\n");
			xmldoc.append("<GSTCLASS/>\r\n");
			xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
			xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
			xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
			xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
			xmldoc.append("<AMOUNT>"+mTotal+"</AMOUNT>\r\n");
			xmldoc.append("<CATEGORYALLOCATIONS.LIST>\r\n");
			xmldoc.append("<CATEGORY>Primary Cost Category</CATEGORY>\r\n");
			xmldoc.append("<COSTCENTREALLOCATIONS.LIST>\r\n");
			xmldoc.append("<NAME></NAME>\r\n"); //may be sub group in this case it will be AVL Project...
			xmldoc.append("<AMOUNT>"+mTotal+"</AMOUNT>\r\n");
			xmldoc.append("</COSTCENTREALLOCATIONS.LIST>\r\n");
			xmldoc.append("</CATEGORYALLOCATIONS.LIST>\r\n");
			xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			
			if( mInvtype=="invst")
			{	
			xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
			xmldoc.append("<LEDGERNAME>"+mServicetaxAc+"</LEDGERNAME>\r\n");
			xmldoc.append("<TDSPARTYNAME>"+mTdspartyname+"</TDSPARTYNAME>\r\n");
			xmldoc.append("<GSTCLASS/>\r\n");
			xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
			xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
			xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
			xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
			xmldoc.append("<AMOUNT>"+mServicetaxamount+"</AMOUNT>\r\n");
			xmldoc.append("<TAXBILLALLOCATIONS.LIST>\r\n");
			xmldoc.append("<NAME>"+mInvoicerefno+"</NAME>\r\n");
			xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
			xmldoc.append("<ISINPUTAVAIL>No</ISINPUTAVAIL>\r\n");
			xmldoc.append("<ISPUREAGENTBILL>No</ISPUREAGENTBILL>\r\n");
			xmldoc.append("<ISPANVALID>No</ISPANVALID>\r\n");
			xmldoc.append("<TDSTAXRATE>"+mTdstaxrate+"</TDSTAXRATE>\r\n");
			xmldoc.append("<TDSSURCHARGE>"+mTdssurcharge+"</TDSSURCHARGE>\r\n");
			xmldoc.append("<STSECONDARYCESSRATE>"+mStsecondarycessrate+"</STSECONDARYCESSRATE>\r\n");
			xmldoc.append("<AMOUNT>"+mServicetaxamount+"</AMOUNT>\r\n");
			xmldoc.append("<SURCHARGEAMOUNT>"+mSurchargeamount+"</SURCHARGEAMOUNT>\r\n");
			xmldoc.append("<ADDLSURCHARGEAMOUNT>"+mAddlsurchargeamount+"</ADDLSURCHARGEAMOUNT>\r\n");
			xmldoc.append("<STSECONDARYCESSAMOUNT>"+mStsecondarycessamount+"</STSECONDARYCESSAMOUNT>\r\n");
			xmldoc.append("<ASSESSABLEAMOUNT>"+mAssessableamount+"</ASSESSABLEAMOUNT>\r\n");
			xmldoc.append("</TAXBILLALLOCATIONS.LIST>\r\n");
			xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			}
			//end taxable.....
						
			if(mInvtype=="invsc")
			{
			xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
			xmldoc.append("<LEDGERNAME>"+mServiceChargeAc+"</LEDGERNAME>\r\n");
			xmldoc.append("<TDSPARTYNAME>"+mTdspartyname+"</TDSPARTYNAME>\r\n");
			xmldoc.append("<GSTCLASS/>\r\n");
			xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
			xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
			xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
			xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
			xmldoc.append("<AMOUNT>"+mServiceChargeAmt+"</AMOUNT>\r\n");
			xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			}
			
			xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
			xmldoc.append("<LEDGERNAME>"+mDiscountac+"</LEDGERNAME>\r\n");
			xmldoc.append("<GSTCLASS/>\r\n");
			xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
			xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
			xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
			xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
			xmldoc.append("<AMOUNT>"+mDiscountamount+"</AMOUNT>\r\n");
			xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			xmldoc.append("</VOUCHER>\r\n");
			xmldoc.append("</TALLYMESSAGE>\r\n");
			xmldoc.append("</REQUESTDATA>\r\n");
			xmldoc.append("</IMPORTDATA>\r\n");
			xmldoc.append("</BODY>\r\n");
			xmldoc.append("</ENVELOPE>\r\n");
            			
            %>
            <td>
            <%
            System.out.println("EN DOF XML");
                        
            if (entrysearch=="NOT FOUND")
            {
            	System.out.println("IN IF ");
                senddata = tally.sendTallyserver(xmldoc.toString(),SID,PID);
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
            	sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv (voucher_type,voucher_date,voucher_no,accountname,secondaccount,amount,narrations,username,create_date,tallyvid)"+
                     "VALUES ( 'Invoice-Direct','"+mInvoicedate+"','"+mInvoiceno+"','"+mCompanyname+"','"+mTdspartyname+"','"+mGrandtotal+"','"+mNarrations+"','"+mUsername+"','"+todaysDateTime+"','"+senddata+"' )";
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