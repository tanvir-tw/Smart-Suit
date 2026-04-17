<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<html>
<head>
<title>Tally Conversion - Purchases</title>
</head>
<body>
        <%
        Writer output = null;
        String text = "";
        File file = new File("C:\\Documents and Settings\\Shekhar\\Desktop\\Purchases.xml");
        output = new BufferedWriter(new FileWriter(file));
        try {
            String fromDate="2011-09-10";
            String toDate="2011-09-13";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn1= DriverManager.getConnection("jdbc:mysql://192.168.1.55/erp_vpedutech","erp","1@erp");
            Statement st1=conn1.createStatement();
            String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on a.suppliercode = b.suppliercode where a.purinvoicedate BETWEEN '"+fromDate+"' and '"+toDate+"'  order by a.purinvoicedate "; //INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items as c on a.purinvoiceno=c.purinvoiceno 
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
            text = "<SVCURRENTCOMPANY></SVCURRENTCOMPANY>\r\n";
            output.write(text);
            text = "</STATICVARIABLES>\r\n";
            output.write(text);
            text = "</REQUESTDESC>\r\n"; 
            output.write(text);
            text = "<REQUESTDATA>\r\n";
            output.write(text);
            while(rs.next()) {
                String mVoudate=rs.getString("purinvoicedate");
                //  mInvoicedate="2009-04-01";
                System.out.println("first "+mVoudate);
                mVoudate=mVoudate.substring(0,4)+mVoudate.substring(5,7)+mVoudate.substring(8,10);
                System.out.println(mVoudate);
                String mVoucherno=rs.getString("purinvoiceno");
                String mInvoicerefno=rs.getString("supinvoiceref");
                String mCompanyname=rs.getString("b.suppliername").replace("&","&amp;");
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
                
                text= mVoudate+mVoucherno;
            %>
            <tr> <%out.println(text);%> </tr>
            <% 
            text="    <TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n";
            output.write(text);
            text="     <VOUCHER  VCHTYPE='Purchase' ACTION='Create'>\r\n";
            output.write(text);
            text="      <DATE>"+mVoudate+"</DATE>\r\n";
            output.write(text);
            text="      <NARRATION>"+mNarrations+"</NARRATION>\r\n";
            output.write(text);
            text="      <VOUCHERTYPENAME>Purchase</VOUCHERTYPENAME>\r\n";
            output.write(text);
            text="      <VOUCHERNUMBER>"+mVoucherno+"</VOUCHERNUMBER>\r\n";
            output.write(text);
            text="      <REFERENCE>"+mReference+"</REFERENCE>\r\n";
            output.write(text);
            text="      <PARTYLEDGERNAME>"+mCompanyname+"</PARTYLEDGERNAME>\r\n";
            output.write(text);
            text="      <CSTFORMISSUETYPE>C Form</CSTFORMISSUETYPE>\r\n";
            output.write(text);
            text="      <CSTFORMRECVTYPE>Default</CSTFORMRECVTYPE>\r\n";
            output.write(text);
            text="      <FBTPAYMENTTYPE>Default</FBTPAYMENTTYPE>\r\n";
            output.write(text);
            text="      <VCHGSTCLASS/>\r\n";
            output.write(text);
            text="      <ENTEREDBY>murali</ENTEREDBY>\r\n";
            output.write(text);
            text="      <DIFFACTUALQTY>No</DIFFACTUALQTY>\r\n";
            output.write(text);
            text="      <AUDITED>No</AUDITED>\r\n";
            output.write(text);
            text="      <FORJOBCOSTING>No</FORJOBCOSTING>\r\n";
            output.write(text);
            text="      <ISOPTIONAL>No</ISOPTIONAL>\r\n";
            output.write(text);
            text="      <EFFECTIVEDATE>"+mVoudate+"</EFFECTIVEDATE>\r\n";
            output.write(text);
            text="      <USEFORINTEREST>No</USEFORINTEREST>\r\n";
            output.write(text);
            text="      <USEFORGAINLOSS>No</USEFORGAINLOSS>\r\n";
            output.write(text);
            text="      <USEFORGODOWNTRANSFER>No</USEFORGODOWNTRANSFER>\r\n";
            output.write(text);
            text="      <USEFORCOMPOUND>No</USEFORCOMPOUND>\r\n";
            output.write(text);
            text="      <ALTERID> 158334</ALTERID>\r\n";
            output.write(text);
            text="      <EXCISEOPENING>No</EXCISEOPENING>\r\n";
            output.write(text);
            text="      <USEFORFINALPRODUCTION>No</USEFORFINALPRODUCTION>\r\n";
            output.write(text);
            text="      <ISCANCELLED>No</ISCANCELLED>\r\n";
            output.write(text);
            text="      <HASCASHFLOW>No</HASCASHFLOW>\r\n";
            output.write(text);
            text="      <ISPOSTDATED>No</ISPOSTDATED>\r\n";
            output.write(text);
            text="      <USETRACKINGNUMBER>No</USETRACKINGNUMBER>\r\n";
            output.write(text);
            text="      <ISINVOICE>No</ISINVOICE>\r\n";
            output.write(text);
            text="      <MFGJOURNAL>No</MFGJOURNAL>\r\n";
            output.write(text);
            text="      <HASDISCOUNTS>No</HASDISCOUNTS>\r\n";
            output.write(text);
            text="      <ASPAYSLIP>No</ASPAYSLIP>\r\n";
            output.write(text);
            text="      <ISCOSTCENTRE>No</ISCOSTCENTRE>\r\n";
            output.write(text);
            text="      <ISDELETED>No</ISDELETED>\r\n";
            output.write(text);
            text="      <ASORIGINAL>No</ASORIGINAL>\r\n";
            output.write(text);
            text="      <ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="       <LEDGERNAME>"+mCompanyname+"</LEDGERNAME>\r\n";
            output.write(text);
            text="       <GSTCLASS/>\r\n";
            output.write(text);
            text="       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>\r\n";
            output.write(text);
            text="       <LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
            output.write(text);
            text="       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
            output.write(text);
            text="       <ISPARTYLEDGER>Yes</ISPARTYLEDGER>\r\n";
            output.write(text);
            text="       <AMOUNT>"+mGrandtotal+"</AMOUNT>\r\n";
            output.write(text);
            text="       <BILLALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="        <NAME>"+mReference+"</NAME>\r\n";
            output.write(text);
            text="        <BILLTYPE>New Ref</BILLTYPE>\r\n";
            output.write(text);
            text="       <AMOUNT>"+mGrandtotal+"</AMOUNT>\r\n";
            output.write(text);
            text="       </BILLALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="       <UDF:VATDEALERNATURE.LIST DESC='`VATDealerNature`' ISLIST='YES' TYPE='String'>\r\n";
            output.write(text);
            text="        <UDF:VATDEALERNATURE DESC='`VATDealerNature`'>Inter State Dealer</UDF:VATDEALERNATURE>\r\n";
            output.write(text);
            text="       </UDF:VATDEALERNATURE.LIST>\r\n";
            output.write(text);
            text="      </ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="      <ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="       <TAXCLASSIFICATIONNAME>Inter-State Purchases</TAXCLASSIFICATIONNAME>\r\n";
            output.write(text);
            text="       <LEDGERNAME>"+mSalestaxac+"</LEDGERNAME>\r\n";
            output.write(text);
            text="       <GSTCLASS/>\r\n";
            output.write(text);
            text="       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n";
            output.write(text);
            text="       <LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
            output.write(text);
            text="       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
            output.write(text);
            text="       <ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n";
            output.write(text);
            text="       <AMOUNT>-"+tptax+"</AMOUNT>\r\n";
            output.write(text);
            text="       <CATEGORYALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="        <CATEGORY>Primary Cost Category</CATEGORY>\r\n";
            output.write(text);
            text="        <COSTCENTREALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="         <NAME>Piston</NAME>\r\n";
            output.write(text);
            text="         <AMOUNT>-"+tptax+"</AMOUNT>\r\n";
            output.write(text);
            text="        </COSTCENTREALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="       </CATEGORYALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="      </ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="      <ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="       <LEDGERNAME>"+mSalestaxac+"</LEDGERNAME>\r\n";
            output.write(text);
            text="       <GSTCLASS/>\r\n";
            output.write(text);
            text="       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n";
            output.write(text);
            text="       <LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
            output.write(text);
            text="       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
            output.write(text);
            text="       <ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n";
            output.write(text);
            text="       <AMOUNT>-"+tptax+"</AMOUNT>\r\n";
            output.write(text);
            text="      </ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="      <ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="       <LEDGERNAME>"+mFreightac+"</LEDGERNAME>\r\n";
            output.write(text);
            text="       <GSTCLASS/>\r\n";
            output.write(text);
            text="       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n";
            output.write(text);
            text="       <LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
            output.write(text);
            text="       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
            output.write(text);
            text="       <ISPARTYLEDGER>No</ISPARTYLEDGER>\r\n";
            output.write(text);
            text="       <AMOUNT>-"+tppfi+"</AMOUNT>\r\n";
            output.write(text);
            text="       <CATEGORYALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="        <CATEGORY>Primary Cost Category</CATEGORY>\r\n";
            output.write(text);
            text="        <COSTCENTREALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="         <NAME>Central Cost</NAME>\r\n";
            output.write(text);
            text="         <AMOUNT>-"+mTotal+"</AMOUNT>\r\n";
            output.write(text);
            text="        </COSTCENTREALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="       </CATEGORYALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="      </ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="      <UDF:REFERENCEDATE.LIST DESC='`ReferenceDate`' ISLIST='YES' TYPE='Date'>\r\n";
            output.write(text);
            text="       <UDF:REFERENCEDATE DESC='`ReferenceDate`'>"+mVoudate+"</UDF:REFERENCEDATE>\r\n";
            output.write(text);
            text="      </UDF:REFERENCEDATE.LIST>\r\n";
            output.write(text);
            text="      <UDF:VATDEALERNATURE.LIST DESC='`VATDealerNature`' ISLIST='YES' TYPE='String'>\r\n";
            output.write(text);
            text="       <UDF:VATDEALERNATURE DESC='`VATDealerNature`'>Inter State Dealer</UDF:VATDEALERNATURE>\r\n";
            output.write(text);
            text="      </UDF:VATDEALERNATURE.LIST>\r\n";
            output.write(text);
            text="     </VOUCHER>\r\n";
            output.write(text);
            text="    </TALLYMESSAGE>\r\n";
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
        } catch(Exception e) {
            out.println(e);
        }
            
            %>
        </table>
    </body>
</html>
