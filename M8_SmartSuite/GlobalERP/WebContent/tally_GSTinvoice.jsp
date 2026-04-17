<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>
<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - Invoices-Data Access</title>
        <script>
        
        function chk()
        {

        	
        	
        	var chkf="";
        	var chkt="";
        	var objFromDate = document.getElementById("fromdate").value;
        	var fdate=objFromDate.split("-");
        	if(fdate[1]=="Jan")
        	{
        		chkf="01";
        	}
        	if(fdate[1]=="Feb")
        	{
        		chkf="02";
        	}
        	if(fdate[1]=="Mar")
        	{
        		chkf="03";
        	}
        	if(fdate[1]=="Apr")
        	{
        		chkf="04";
        	}
        	if(fdate[1]=="May")
        	{
        		chkf="05";
        	}
        	if(fdate[1]=="Jun")
        	{
        		chkf="06";
        	}
        	if(fdate[1]=="Jul")
        	{
        		chkf="07";
        	}
        	if(fdate[1]=="Aug")
        	{
        		chkf="08";
        	}
        	if(fdate[1]=="Sep")
        	{
        		chkf="09";
        	}
        	if(fdate[1]=="Oct")
        	{
        		chkf="10";
        	}
        	if(fdate[1]=="Nov")
        	{
        		chkf="11";
        	}
        	if(fdate[1]=="Dec")
        	{
        		chkf="12";
        	}
        	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
            var objToDate = document.getElementById("todate").value;
            var tdate=objToDate.split("-");
            if(tdate[1]=="Jan")
        	{
            	chkt="01";
        	}
        	if(tdate[1]=="Feb")
        	{
        		chkt="02";
        	}
        	if(tdate[1]=="Mar")
        	{
        		chkt="03";
        	}
        	if(tdate[1]=="Apr")
        	{
        		chkt="04";
        	}
        	if(tdate[1]=="May")
        	{
        		chkt="05";
        	}
        	if(tdate[1]=="Jun")
        	{
        		chkt="06";
        	}
        	if(tdate[1]=="Jul")
        	{
        		chkt="07";
        	}
        	if(tdate[1]=="Aug")
        	{
        		chkt="08";
        	}
        	if(tdate[1]=="Sep")
        	{
        		chkt="09";
        	}
        	if(tdate[1]=="Oct")
        	{
        		chkt="10";
        	}
        	if(tdate[1]=="Nov")
        	{
        		chkt="11";
        	}
        	if(tdate[1]=="Dec")
        	{
        		chkt="12";
        	}
            var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
           // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
             
            var date1 = new Date(objFromDate1);
            var date2 = new Date(objToDate1);
            
            //alert("from > "+date1+" Todate > "+date2);
            
            var date3 = new Date();
            var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
            var currentDate = new Date(date4);
             
                if(date1 > date2)
                {
                    alert("From Date Should be Less Than To Date");
                    return false; 
                }
//                 else if(date1 > currentDate)
//                 {
//                     alert("From Date should be less than current date");
//                     return false; 
//                 }
//                 else if(date2 > currentDate) 
//                 {
//                     alert("To Date should be less than current date");
//                     return false; 
//                 }

                return true;
        	
        }
        
        </script>
        
</head>


<body>
<form name="xyz" method="get" action="" onsubmit="return chk();">
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
			<font size="2"> From Date: </font>
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
			&nbsp;<b></b> </td><td align="left" valign="top" style="width: 180px;"> <font size="2"> To Date:</font>
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
            
		  //String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode   where a.InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"' and a.twempname='Autogenerated'  and a.invoicecancelled = 0  order by a.InvoiceDate";
		  
		  String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode   where a.InvoiceDate BETWEEN '"+fromDate+"' and '"+toDate+"' and a.invoicecancelled = 0  order by a.InvoiceDate";
		  
		  
		  
		//  String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode   where InvoiceNo=16495";
	           
		    String sql1="";
		    String Description="";
            System.out.println(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            <div style="height:600px;width:100%;overflow:scroll;">       
            <table width="100%" border="2" style="font-size: 10" class="sortable" >
            <tr>
            <td colspan="7" align="center"><b><font size="3">Converted Data to Tally [INVOICES-Data Access Charges]</font></b></td>
            </tr>
            <th>Voucher Date</th>
            <th>Voucher No</th>
            <th>Account Name</th>
            <th>Amount</th>
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



	 
	//New Code 
	
	double CGSTValue=0.00;
	double SGSTValue=0.00;
	double IGSTValue=0.00;
	double CGSTTaxRate=0.00;
	double SGSTTaxRate=0.00;
	double IGSTTaxRate=0.00;
	double ToTGST=0.00;
	String GrandTotal="";
	
	
	
	 String sqlgst="select Invoicerefno,invoiceno,CompanyName,GrandTotal,(GrandTotal -(CGSTValue+SGSTValue+IGSTValue)) as TaxableAmt,(CGSTValue+SGSTValue+IGSTValue) as GST ,CGSTValue,SGSTValue,IGSTValue,SACCode from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet where  invoiceno='"+mInvoiceno+"'";
     ResultSet rssubtot11=st1.executeQuery(sqlgst);
     System.out.println("sqlgst =>"+sqlgst);
     String SACCode="";

	if(rssubtot11.next()) 
	{
	  mTotal=rssubtot11.getString("TaxableAmt");
	  SACCode=rssubtot11.getString("SACCode");
	  CGSTValue=rssubtot11.getDouble("CGSTValue");
	  SGSTValue=rssubtot11.getDouble("SGSTValue");
	  IGSTValue=rssubtot11.getDouble("IGSTValue");
	  ToTGST=rssubtot11.getDouble("GST");
	  GrandTotal=rssubtot11.getString("GrandTotal");
	}
	
	System.out.println("TaxableAmt :- "+mTotal);
	System.out.println("SACCode :- "+SACCode);
	System.out.println("CGSTValue :- "+CGSTValue);
	System.out.println("SGSTValue :- "+SGSTValue);
	System.out.println("IGSTValue :- "+IGSTValue);
	System.out.println("Total GST :- "+ToTGST);
	
	
	
	 
	
	String TaxRatequery="select * from "+session.getAttribute("CompanyMasterID").toString()+"GSTINRateMaster where Code='"+SACCode+"' and Category!='-'";
	ResultSet rssubtot111=st1.executeQuery(TaxRatequery);
	
	System.out.println("TaxRatequery :- "+TaxRatequery);
	
	double  TaxRate=0.00;
	if(rssubtot111.next())
	{
		TaxRate=rssubtot111.getDouble("TaxRate");
	}
	System.out.println("TaxRate----------->     "+TaxRate);
	
	if(IGSTValue > 0)
	{
		IGSTTaxRate=TaxRate;
	}
	else
	{
		CGSTTaxRate=TaxRate/2;
		SGSTTaxRate=TaxRate/2;
	}
	
	System.out.println("CGSTTaxRate ----------->     "+CGSTTaxRate);
	System.out.println("SGSTTaxRate ----------->     "+SGSTTaxRate);
	System.out.println("IGSTTaxRate ----------->     "+IGSTTaxRate);
	
	
	
	mGrandtotal=GrandTotal;
	
	System.out.println("mGrandtotal ----------->     "+mGrandtotal);
	
	//New Code 
	
	 
	 
	          String mNarrations="Being monthly service charges against inv no "+mInvoicerefno+" dtd. "+mInvoicedate.substring(6,8)+"."+mInvoicedate.substring(4,6)+"."+mInvoicedate.substring(0,4);
              String mServicetaxAc="Service Tax (Output) ";
              String mTdspartyname="Data Access Charges";
              
              String mCGSTTaxAc="CGST";
              //String mCGSTpartyname="Data Access CGSTCharges";
              String mSGSTTaxAc="SGST";
              //String mSGSTpartyname="Data Access SGSTCharges";
              String mIGSTTaxAc="IGST";
              //String mIGSTpartyname="Data Access IGSTCharges";
              
              DecimalFormat df2 = new DecimalFormat( "0.00" );
              String mDiscountac="Discount";
              
             double mCGSTtaxrate=CGSTTaxRate;
             double mSGSTtaxrate=SGSTTaxRate;
             double mIGSTtaxrate=IGSTTaxRate;
              
              //need to add this field..
              /* String mServiceChargeAc="Service Charges";
              String mServiceChargeAmt="0.00";
              String mServiceChargerate="15";

              String mTdstaxrate="15"; //12 as per new ..
              String mTdssurcharge="0";
              String mStsecondarycessrate="0";
              String mSurchargeamount="0";
              String mAddlsurchargeamount="0";
              String mStsecondarycessamount="0";
              String mServicetaxamount="0";                        
              String mAssessableamount="0";
              String mDiscountac="Discount";
              String mDiscountamount="0";
              
              double tptotal = Double.parseDouble(mTotal);
              
              //System.out.println("tp total-"+tptotal);
              double tpsurchargeamount = tptotal * .15;
              //System.out.println(tpsurchargeamount);

	          double tpservicechargeamount =tptotal * .15;
              System.out.println("=>>>>>>>>>>>>>>>>>>>>>>>tpservicechargeamount=>"+tpservicechargeamount+"=====>>>>>tptotal===>"+tptotal);
			 			  	
              double tpaddlsurchargeamount=tpsurchargeamount*.00;
              //System.out.println(tpaddlsurchargeamount);
              double tpstsecondarycessamount=tpsurchargeamount*.00;
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
              //mAssessableamount=mTotal; */
             String  mAssessableamount=mTotal;
              
              
			  double nGrandTotal=0.00;	
			  double nTotal=0.00;
			  double nDiscountamount=0.00;
			
			  nTotal=Double.parseDouble(mTotal);
			  mTotal=df2.format(nTotal);
			  nTotal=Double.parseDouble(mTotal);
			
			
			nGrandTotal=Double.parseDouble(mGrandtotal);
			
		 System.out.println("r55555555555555555    "+mInvtype);
		 
//	if mDiscountamount

	
	
	nDiscountamount=nGrandTotal-(nTotal+ToTGST);
	
	String nTest=df2.format(nDiscountamount);
	
	String mDiscountamount=nTest;
	 
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
            <td align="right"><div align="right"> <%=mInvoicedate.substring(6,8)+"-"+mInvoicedate.substring(4,6)+"-"+mInvoicedate.substring(0,4)%></div></td>
            <td align="right"><div align="right"><%=mInvoiceno%></div></td>
			<td align="left"><div align="left"><%=mCompanyname%></div></td>
			<td align="right"><div align="right"><%=mGrandtotal%></div></td>
			<td><%=mTdspartyname%></td>
			<td align="left"><div align="left"><%=mNarrations%></div></td> 
			
			<%
			String ipAddress =request.getRemoteAddr(); 
			//String ipAddress="115.112.36.134";
		System.out.println("IP ADREDDSSS     "+ipAddress);
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
			
			// GST ValueS 
			if(IGSTValue > 0)
			{
				
				xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				xmldoc.append("<LEDGERNAME>"+mIGSTTaxAc+"</LEDGERNAME>\r\n");
				xmldoc.append("<TDSPARTYNAME>"+mTdspartyname+"</TDSPARTYNAME>\r\n");
				xmldoc.append("<GSTCLASS/>\r\n");
				xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
				xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
				xmldoc.append("<AMOUNT>"+IGSTValue+"</AMOUNT>\r\n");
				xmldoc.append("<TAXBILLALLOCATIONS.LIST>\r\n");
				xmldoc.append("<NAME>"+mInvoicerefno+"</NAME>\r\n");
				xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
				xmldoc.append("<ISINPUTAVAIL>No</ISINPUTAVAIL>\r\n");
				xmldoc.append("<ISPUREAGENTBILL>No</ISPUREAGENTBILL>\r\n");
				xmldoc.append("<ISPANVALID>No</ISPANVALID>\r\n");
				xmldoc.append("<TDSTAXRATE>"+mIGSTtaxrate+"</TDSTAXRATE>\r\n");
				xmldoc.append("<ASSESSABLEAMOUNT>"+mAssessableamount+"</ASSESSABLEAMOUNT>\r\n");
				xmldoc.append("</TAXBILLALLOCATIONS.LIST>\r\n");
				xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			
			}
			else
			{
			
				xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				xmldoc.append("<LEDGERNAME>"+mCGSTTaxAc+"</LEDGERNAME>\r\n");
				xmldoc.append("<TDSPARTYNAME>"+mTdspartyname+"</TDSPARTYNAME>\r\n");
				xmldoc.append("<GSTCLASS/>\r\n");
				xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
				xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
				xmldoc.append("<AMOUNT>"+CGSTValue+"</AMOUNT>\r\n");
				xmldoc.append("<TAXBILLALLOCATIONS.LIST>\r\n");
				xmldoc.append("<NAME>"+mInvoicerefno+"</NAME>\r\n");
				xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
				xmldoc.append("<ISINPUTAVAIL>No</ISINPUTAVAIL>\r\n");
				xmldoc.append("<ISPUREAGENTBILL>No</ISPUREAGENTBILL>\r\n");
				xmldoc.append("<ISPANVALID>No</ISPANVALID>\r\n");
				xmldoc.append("<TDSTAXRATE>"+mCGSTtaxrate+"</TDSTAXRATE>\r\n");
				xmldoc.append("<ASSESSABLEAMOUNT>"+mAssessableamount+"</ASSESSABLEAMOUNT>\r\n");
				xmldoc.append("</TAXBILLALLOCATIONS.LIST>\r\n");
				xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
				
				
				xmldoc.append("<ALLLEDGERENTRIES.LIST>\r\n");
				xmldoc.append("<LEDGERNAME>"+mSGSTTaxAc+"</LEDGERNAME>\r\n");
				xmldoc.append("<TDSPARTYNAME>"+mTdspartyname+"</TDSPARTYNAME>\r\n");
				xmldoc.append("<GSTCLASS/>\r\n");
				xmldoc.append("<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n");
				xmldoc.append("<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n");
				xmldoc.append("<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n");
				xmldoc.append("<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n");
				xmldoc.append("<AMOUNT>"+SGSTValue+"</AMOUNT>\r\n");
				xmldoc.append("<TAXBILLALLOCATIONS.LIST>\r\n");
				xmldoc.append("<NAME>"+mInvoicerefno+"</NAME>\r\n");
				xmldoc.append("<BILLTYPE>New Ref</BILLTYPE>\r\n");
				xmldoc.append("<ISINPUTAVAIL>No</ISINPUTAVAIL>\r\n");
				xmldoc.append("<ISPUREAGENTBILL>No</ISPUREAGENTBILL>\r\n");
				xmldoc.append("<ISPANVALID>No</ISPANVALID>\r\n");
				xmldoc.append("<TDSTAXRATE>"+mSGSTtaxrate+"</TDSTAXRATE>\r\n");
				xmldoc.append("<ASSESSABLEAMOUNT>"+mAssessableamount+"</ASSESSABLEAMOUNT>\r\n");
				xmldoc.append("</TAXBILLALLOCATIONS.LIST>\r\n");
				xmldoc.append("</ALLLEDGERENTRIES.LIST>\r\n");
			
			
			}
			//end taxable.....
						
			
			/////////////////////// Here need to changes in discount
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
            <td align="left"><div align="left">
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
            //	System.out.println("&&&&&&&&&&&&&&&&&&   *********************   #########");
            	System.out.println("%%%%%%%%   %%%%%%%%%%%%%%%%%%   "+senddata);
            }
            %>
            </div></td>
            <%
            if (senddata.contains("Updated") && (entrysearch=="NOT FOUND") )
            {
            	//System.out.println("IN QUERY   ");
                
            	//out.println("inserting data");
            	sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv (voucher_type,voucher_date,voucher_no,accountname,secondaccount,amount,narrations,username,create_date,tallyvid)"+
                     "VALUES ( 'Invoice-Direct','"+mInvoicedate+"','"+mInvoiceno+"','"+mCompanyname+"','"+mTdspartyname+"','"+mGrandtotal+"','"+mNarrations+"','"+mUsername+"','"+todaysDateTime+"','"+senddata+"' )";
                //out.println("SQL:===>"+sql1);
              
                //****************************************************************************Query to insert Data Value
                
              
                
                
            st2.executeUpdate(sql1);
            	
                
                
                
                
                //****************************************************************************Query to insert Data Value
                
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
	<!-- <div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div> -->
	</body>
</html>
</jsp:useBean>

<%@include file="footer_new.jsp"%>