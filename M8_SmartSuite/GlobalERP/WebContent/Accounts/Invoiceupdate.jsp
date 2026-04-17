<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
       <title>Tally Conversion - Invoice </title>
 </head>
<body>

<%! String[] invoices;
        String tptext="";%>
<% 
   invoices = request.getParameterValues("checkbox1");
   if (invoices != null) 
   {
      for (int i = 0; i < invoices.length; i++) 
      {
          if (i==(invoices.length-1))
         {
             tptext=tptext+invoices[i];
         }
         else
        {
             tptext=tptext+invoices[i]+",";
             out.println ("<b>"+invoices[i]+"<b>\r\n");
        }
     }
   out.println(tptext);
   }
   else out.println ("<b>none<b>");
   
%>
          <%
             Writer output = null;
             String text = "";
	         File file = new File("C:\\Documents and Settings\\Shekhar\\Desktop\\invoice.xml");
     	     output = new BufferedWriter(new FileWriter(file));
             try
             {
                   String fromDate="2011-09-10";
                   String toDate="2011-09-13";
                   Class.forName("com.mysql.cj.jdbc.Driver");
                   Connection conn1= DriverManager.getConnection("jdbc:mysql://192.168.1.55/erp_vpedutech","erp","1@erp");
                   Statement st1=conn1.createStatement();
                   String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode  INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as c on a.Invoiceno=c.Invoiceno where a.invoiceno IN ("+tptext+")";
                   System.out.println(sql);
    
                   ResultSet rs=st1.executeQuery(sql);
                   %>
                   <table border="2">
                   <%
                    text = "<ENVELOPE>\r\n";
                    output.write(text);
                    text = "<HEADER>\r\n";
                    output.write(text);
                    text = "<TALLYREQUEST>Import Data</TALLYREQUEST>\r\n";
                    output.write(text);
                    text = "</HEADER>\r\n";
                    output.write(text);
                    text = "<BODY>\r\n";
                    output.write(text);
                    text = "<IMPORTDATA>\r\n";
                    output.write(text);
                    text = "<REQUESTDESC>\r\n";
                    output.write(text);
                    text = "<REPORTNAME>Vouchers</REPORTNAME>\r\n";
                    output.write(text);
                    text = "<STATICVARIABLES>\r\n";
                    output.write(text);
                   // text = "<SVCURRENTCOMPANY>TRANSWORLD COMPRESSOR TECHNOL</SVCURRENTCOMPANY>\r\n";
                    //text = "<SVCURRENTCOMPANY></SVCURRENTCOMPANY>\r\n";
                    //output.write(text);
                    text = "</STATICVARIABLES>\r\n";
                    output.write(text);
                    text = "</REQUESTDESC>\r\n";
                    output.write(text);
                    text = "<REQUESTDATA>\r\n";
                    output.write(text);
                    while(rs.next())
                    { 
                        String mInvoicedate=rs.getString("invoicedate");
                      //  mInvoicedate="2009-04-01";
                        System.out.println("first"+mInvoicedate);
                        mInvoicedate=mInvoicedate.substring(0,4)+mInvoicedate.substring(5,7)+mInvoicedate.substring(8,10);
                        System.out.println(mInvoicedate);
                        String mInvoiceno=rs.getString("invoiceno");
                        String mInvoicerefno=rs.getString("invoicerefno");
                        String mCompanyname=rs.getString("b.companyname").replace("&","and");
                        String mGrandtotal=rs.getString("grandtotal");
                        String mTotal=rs.getString("c.sellingprice");
                        String mNarrations="Being monthly service charges against inv no "+mInvoicerefno+" dtd. "+mInvoicedate.substring(6,8)+"."+mInvoicedate.substring(4,6)+"."+mInvoicedate.substring(0,4);
                        String mServicetaxAc="Service Tax (Output) ";
                        String mTdspartyname="Data Access Charges";
                        String mTdstaxrate="10";
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
                        //System.out.println("tp total-"+tptotal);
                        double tpsurchargeamount = tptotal * .10;
                        //System.out.println(tpsurchargeamount);
                        double tpaddlsurchargeamount=tpsurchargeamount*.02;
                        //System.out.println(tpaddlsurchargeamount);
                        double tpstsecondarycessamount=tpsurchargeamount*.01;
                        //System.out.println(tpstsecondarycessamount);
                        double tpservicetaxamount=(tpsurchargeamount+tpaddlsurchargeamount+tpstsecondarycessamount);
                        //System.out.println(tpservicetaxamount);
                        mSurchargeamount=Double.toString(tpsurchargeamount);
                        mAddlsurchargeamount=Double.toString(tpaddlsurchargeamount);
                        mStsecondarycessamount=Double.toString(tpstsecondarycessamount);
                        mServicetaxamount=Double.toString(tpservicetaxamount);
                        mAssessableamount=mTotal;
                        text= mInvoicedate+mInvoiceno;
                        %>
                        <tr> <%out.println(text);%> </tr>
                        <% 
                       
                        text = "<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n";
                        output.write(text);
                        //text = "<VOUCHER>\r\n";
                        //output.write(text);
                        text = "<VOUCHER  VCHTYPE='Sales' ACTION='Create'>\r\n";
                        output.write(text);
                        text = "<DATE>"+mInvoicedate+"</DATE>\r\n";
                        output.write(text);
                        //text = "<GUID>534280e0-8c06-11d9-a6f7-525405f8aba3-00014f75</GUID>\r\n";
                        //output.write(text);
                        text = "<NARRATION>"+mNarrations+"</NARRATION>\r\n";
                        output.write(text);
                        text = "<VOUCHERTYPENAME>Sales</VOUCHERTYPENAME>\r\n";
                        output.write(text);
                        text = "<VOUCHERNUMBER>"+mInvoiceno+"</VOUCHERNUMBER>\r\n";
                        output.write(text);
                        text = "<REFERENCE>"+mInvoicerefno+"</REFERENCE>\r\n";
                        output.write(text);
                        text = "<PARTYLEDGERNAME>"+mCompanyname+"</PARTYLEDGERNAME>\r\n";
                        output.write(text);
                        text = "<CSTFORMISSUETYPE/>\r\n";
                        output.write(text);
                        text = "<CSTFORMRECVTYPE/>\r\n";
                        output.write(text);
                        text = "<FBTPAYMENTTYPE>Default</FBTPAYMENTTYPE>\r\n";
                        output.write(text);
                        text = "<VCHGSTCLASS/>\r\n";
                        output.write(text);
                        text = "<ENTEREDBY>murali</ENTEREDBY>\r\n";
                        output.write(text);
                        text = "<DIFFACTUALQTY>No</DIFFACTUALQTY>\r\n";
                        output.write(text);
                        text = "<AUDITED>No</AUDITED>\r\n";
                        output.write(text);
                        text = "<FORJOBCOSTING>No</FORJOBCOSTING>\r\n";
                        output.write(text);
                        text = "<ISOPTIONAL>No</ISOPTIONAL>\r\n";
                        output.write(text);
                        text = "<EFFECTIVEDATE>"+mInvoicedate+"</EFFECTIVEDATE>\r\n";
                        output.write(text);
                        text = "<USEFORINTEREST>No</USEFORINTEREST>\r\n";
                        output.write(text);
                        text = "<USEFORGAINLOSS>No</USEFORGAINLOSS>\r\n";
                        output.write(text);
                        text = "<USEFORGODOWNTRANSFER>No</USEFORGODOWNTRANSFER>\r\n";
                        output.write(text);
                        text = "<USEFORCOMPOUND>No</USEFORCOMPOUND>\r\n";
                        output.write(text);
                        text = "<ALTERID> 159860</ALTERID>\r\n";
                        output.write(text); 
                        text = "<EXCISEOPENING>No</EXCISEOPENING>\r\n";
                        output.write(text);
                        text = "<USEFORFINALPRODUCTION>No</USEFORFINALPRODUCTION>\r\n";
                        output.write(text);
                        text = "<ISCANCELLED>No</ISCANCELLED>\r\n";
                        output.write(text);
                        text = "<HASCASHFLOW>No</HASCASHFLOW>\r\n";
                        output.write(text);
                        text = "<ISPOSTDATED>No</ISPOSTDATED>\r\n";
                        output.write(text);
                        text = "<USETRACKINGNUMBER>No</USETRACKINGNUMBER>\r\n";
                        output.write(text);
                        text = "<ISINVOICE>No</ISINVOICE>\r\n";
                        output.write(text);
                        text = "<MFGJOURNAL>No</MFGJOURNAL>\r\n";
                        output.write(text);
                        text = "<HASDISCOUNTS>No</HASDISCOUNTS>\r\n";
                        output.write(text);
                        text = "<ASPAYSLIP>No</ASPAYSLIP>\r\n";
                        output.write(text);
                        text = "<ISCOSTCENTRE>No</ISCOSTCENTRE>\r\n";
                        output.write(text);
                        text = "<ISDELETED>No</ISDELETED>\r\n";
                        output.write(text);
                        text = "<ASORIGINAL>No</ASORIGINAL>\r\n";
                        output.write(text);
                        text = "<ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<LEDGERNAME>"+mCompanyname+"</LEDGERNAME>\r\n";
                        output.write(text);
                        text = "<GSTCLASS/>\r\n";
                        output.write(text);
                        text = "<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n";
                        output.write(text);
                        text = "<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
                        output.write(text);
                        text = "<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
                        output.write(text);
                        text = "<ISPARTYLEDGER>Yes</ISPARTYLEDGER>\r\n";
                        output.write(text);
                        text = "<AMOUNT>-"+mGrandtotal+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "<BILLALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "<NAME>"+mInvoicerefno+"</NAME>\r\n";
                        output.write(text);
                        text = "<BILLTYPE>New Ref</BILLTYPE>\r\n";
                        output.write(text);
                        text = "<AMOUNT>-"+mGrandtotal+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "</BILLALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "</ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<LEDGERNAME>"+mTdspartyname+"</LEDGERNAME>\r\n";
                        output.write(text);
                        text = "<GSTCLASS/>\r\n";
                        output.write(text);
                        text = "<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n";
                        output.write(text);
                        text = "<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
                        output.write(text);
                        text = "<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
                        output.write(text);
                        text = "<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n";
                        output.write(text);
                        text = "<AMOUNT>"+mTotal+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "<CATEGORYALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "<CATEGORY>Primary Cost Category</CATEGORY>\r\n";
                        output.write(text);
                        text = "<COSTCENTREALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "<NAME></NAME>\r\n"; //may be sub group in this case it will be AVL Project...
                        output.write(text);
                        text = "<AMOUNT>"+mTotal+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "</COSTCENTREALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "</CATEGORYALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "</ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<LEDGERNAME>"+mServicetaxAc+"</LEDGERNAME>\r\n";
                        output.write(text);
                        text = "<TDSPARTYNAME>"+mTdspartyname+"</TDSPARTYNAME>\r\n";
                        output.write(text);
                        text = "<GSTCLASS/>\r\n";
                        output.write(text);
                        text = "<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n";
                        output.write(text);
                        text = "<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
                        output.write(text);
                        text = "<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
                        output.write(text);
                        text = "<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n";
                        output.write(text);
                        text = "<AMOUNT>"+mServicetaxamount+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "<TAXBILLALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "<NAME>"+mInvoicerefno+"</NAME>\r\n";
                        output.write(text);
                        text = "<BILLTYPE>New Ref</BILLTYPE>\r\n";
                        output.write(text);
                        text = "<ISINPUTAVAIL>No</ISINPUTAVAIL>\r\n";
                        output.write(text);
                        text = "<ISPUREAGENTBILL>No</ISPUREAGENTBILL>\r\n";
                        output.write(text);
                        text = "<ISPANVALID>No</ISPANVALID>\r\n";
                        output.write(text);
                        text = "<TDSTAXRATE>"+mTdstaxrate+"</TDSTAXRATE>\r\n";
                        output.write(text);
                        text = "<TDSSURCHARGE>"+mTdssurcharge+"</TDSSURCHARGE>\r\n";
                        output.write(text);
                        text = "<STSECONDARYCESSRATE>"+mStsecondarycessrate+"</STSECONDARYCESSRATE>\r\n";
                        output.write(text);
                        text = "<AMOUNT>"+mServicetaxamount+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "<SURCHARGEAMOUNT>"+mSurchargeamount+"</SURCHARGEAMOUNT>\r\n";
                        output.write(text);
                        text = "<ADDLSURCHARGEAMOUNT>"+mAddlsurchargeamount+"</ADDLSURCHARGEAMOUNT>\r\n";
                        output.write(text);
                        text = "<STSECONDARYCESSAMOUNT>"+mStsecondarycessamount+"</STSECONDARYCESSAMOUNT>\r\n";
                        output.write(text);
                        text = "<ASSESSABLEAMOUNT>"+mAssessableamount+"</ASSESSABLEAMOUNT>\r\n";
                        output.write(text);
                        text = "</TAXBILLALLOCATIONS.LIST>\r\n";
                        output.write(text);
                        text = "</ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "<LEDGERNAME>"+mDiscountac+"</LEDGERNAME>\r\n";
                        output.write(text);
                        text = "<GSTCLASS/>\r\n";
                        output.write(text);
                        text = "<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n";
                        output.write(text);
                        text = "<LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
                        output.write(text);
                        text = "<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
                        output.write(text);
                        text = "<ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n";
                        output.write(text);
                        text = "<AMOUNT>"+mDiscountamount+"</AMOUNT>\r\n";
                        output.write(text);
                        text = "</ALLLEDGERENTRIES.LIST>\r\n";
                        output.write(text);
                        text = "</VOUCHER>\r\n";
                        output.write(text);
                        text = "</TALLYMESSAGE>\r\n";
                        output.write(text);
                    }
                    text = "</REQUESTDATA>\r\n";
                    output.write(text);
                    text = "</IMPORTDATA>\r\n";
                    output.write(text);
                    text = "</BODY>\r\n";
                    output.write(text);
                    text = "</ENVELOPE>\r\n";
                    output.write(text);
                    out.println("Your file has been written");
                    output.close();
                   }
                   catch(Exception e)
                   { 
                       out.println(e);
                   }
                       
                %>
        </table>
    </body>
</html>
