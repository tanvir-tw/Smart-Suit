<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tally Conversion - Customer Master</title>
</head>
<body>
    <%
    try
    {
    Writer output = null;
    String text = "";
    File file = new File("C:\\Documents and Settings\\Shekhar\\Desktop\\Master.xml");
    output = new BufferedWriter(new FileWriter(file));
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn1= DriverManager.getConnection("jdbc:mysql://192.168.1.55/erp_vpedutech","erp","1@erp");
    String sql="select * from erp_vpedutech."+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname IS NOT NULL";
    Statement st1=conn1.createStatement();
    ResultSet rs=st1.executeQuery(sql);
    
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
    text = "<REPORTNAME>All Masters</REPORTNAME>\r\n";
    output.write(text);
    text = "</REQUESTDESC>\r\n";
    output.write(text);
    text = "<REQUESTDATA>\r\n";
    output.write(text);
    while(rs.next())
    {
    
    //CompanyName,EMail,BillingAddress,BillingCity,BillingZip,BillingState,BillingCountry,BillingPhone,CSTOrMST,STDCode,MobileNo,ResiNo
    
    String s1=rs.getString("CompanyName");
    String s2=rs.getString("BillingAddress");
    if (s2!=null)
    {
    s2=s2.replace("&","and");
    }
    text = "<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n";
    output.write(text);
    text = "<LEDGER NAME='"+s1.replace("&","and")+"' RESERVEDNAME=''>\r\n";
    output.write(text);
    text = "<ADDRESS.LIST TYPE='String'>\r\n";
    output.write(text);
    text = "<ADDRESS>"+s2+"</ADDRESS>\r\n";
    output.write(text);
    text = "<ADDRESS>"+rs.getString("BillingCity")+"</ADDRESS>\r\n";
    output.write(text);
    text = "<ADDRESS></ADDRESS>\r\n";
    output.write(text);
    text = "<ADDRESS></ADDRESS>\r\n";
    output.write(text);
    text = "</ADDRESS.LIST>\r\n";
    output.write(text);
    text = "<MAILINGNAME.LIST TYPE='String'>\r\n";
    output.write(text);
    text = "<MAILINGNAME>"+s1.replace("&","and")+"</MAILINGNAME>\r\n";
    output.write(text);
    text = "</MAILINGNAME.LIST>\r\n";
    output.write(text);
    text = "<CURRENCYNAME>Rs.</CURRENCYNAME>\r\n";
    output.write(text);
    text = "<STATENAME>"+rs.getString("BillingState")+"</STATENAME>\r\n";
    output.write(text);
    text = "<PINCODE>"+rs.getString("BillingZip")+"</PINCODE>\r\n";
    output.write(text);
    text = "<INCOMETAXNUMBER></INCOMETAXNUMBER>\r\n";
    output.write(text);
    text = "<SALESTAXNUMBER>"+rs.getString("CSTorMST")+"</SALESTAXNUMBER>\r\n";
    output.write(text);
    text = "<PARENT>Sundry Debtors</PARENT>\r\n";
    output.write(text);
    text = "<TAXCLASSIFICATIONNAME/>\r\n";
    output.write(text);
    text = "<GSTTYPE/>\r\n";
    output.write(text);
    text = "<APPROPRIATEFOR/>\r\n";
    output.write(text);
    text = "<SERVICECATEGORY/>\r\n";
    output.write(text);
    text = "<EXCISEDUTYTYPE/>\r\n";
    output.write(text);
    text = "<EXCISENATUREOFPURCHASE/>\r\n";
    output.write(text);
    text = "<LEDGERFBTCATEGORY/>\r\n";
    output.write(text);
    text = "<ISBILLWISEON>Yes</ISBILLWISEON>\r\n";
    output.write(text);
    text = "<ISCOSTCENTRESON>No</ISCOSTCENTRESON>\r\n";
    output.write(text);
    text = "<ISINTERESTON>No</ISINTERESTON>\r\n";
    output.write(text);
    text = "<ALLOWINMOBILE>No</ALLOWINMOBILE>\r\n";
    output.write(text);
    text = "<ISCONDENSED>No</ISCONDENSED>\r\n";
    output.write(text);
    text = "<AFFECTSSTOCK>No</AFFECTSSTOCK>\r\n";
    output.write(text);
    text = "<FORPAYROLL>No</FORPAYROLL>\r\n";
    output.write(text);
    text = "<INTERESTONBILLWISE>No</INTERESTONBILLWISE>\r\n";
    output.write(text);
    text = "<OVERRIDEINTEREST>No</OVERRIDEINTEREST>\r\n";
    output.write(text);
    text = "<OVERRIDEADVINTEREST>No</OVERRIDEADVINTEREST>\r\n";
    output.write(text);
    text = "<USEFORVAT>No</USEFORVAT>\r\n";
    output.write(text);
    text = "<IGNORETDSEXEMPT>No</IGNORETDSEXEMPT>\r\n";
    output.write(text);
    text = "<ISTCSAPPLICABLE>No</ISTCSAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISTDSAPPLICABLE>No</ISTDSAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISFBTAPPLICABLE>No</ISFBTAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISGSTAPPLICABLE>No</ISGSTAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISEXCISEAPPLICABLE>No</ISEXCISEAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISTDSEXPENSE>No</ISTDSEXPENSE>\r\n";
    output.write(text);
    text = "<ISEDLIAPPLICABLE>No</ISEDLIAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISEDLIAPPLICABLE>No</ISEDLIAPPLICABLE>\r\n";
    output.write(text);
    text = "<ISRELATEDPARTY>No</ISRELATEDPARTY>\r\n";
    output.write(text);
    text = "<SHOWINPAYSLIP>No</SHOWINPAYSLIP>\r\n";
    output.write(text);
    text = "<USEFORGRATUITY>No</USEFORGRATUITY>\r\n";
    output.write(text);
    text = "<FORSERVICETAX>No</FORSERVICETAX>\r\n";
    output.write(text);
    text = "<ISINPUTCREDIT>No</ISINPUTCREDIT>\r\n";
    output.write(text);
    text = "<ISEXEMPTED>No</ISEXEMPTED>\r\n";
    output.write(text);
    text = "<ISABATEMENTAPPLICABLE>No</ISABATEMENTAPPLICABLE>\r\n";
    output.write(text);
    text = "<TDSDEDUCTEEISSPECIALRATE>No</TDSDEDUCTEEISSPECIALRATE>\r\n";
    output.write(text);
    text = "<AUDITED>No</AUDITED>\r\n";
    output.write(text);
    text = "<SORTPOSITION> 1000</SORTPOSITION>\r\n";
    output.write(text);
    text = "<OPENINGBALANCE></OPENINGBALANCE>\r\n";
    output.write(text);
    text = "<LANGUAGENAME.LIST>\r\n";
    output.write(text);
    text = "<NAME.LIST TYPE='String'>\r\n";
    output.write(text);
    text = "<NAME>"+s1.replace("&","and")+"</NAME>\r\n";
    output.write(text);
    text = "</NAME.LIST>\r\n";
    output.write(text);
    text = "<LANGUAGEID> 1033</LANGUAGEID>\r\n";
    output.write(text);
    text = "</LANGUAGENAME.LIST>\r\n";
    output.write(text);
    text = "<LEDGERAUDITCLASS.LIST>\r\n";
    output.write(text);
    text = "<LEDAUDITPERIOD.LIST>       </LEDAUDITPERIOD.LIST>\r\n";
    output.write(text);
    text = "</LEDGERAUDITCLASS.LIST>\r\n";
    output.write(text);
    text = "<AUDITENTRIES.LIST>      </AUDITENTRIES.LIST>\r\n";
    output.write(text);
    text = "<TDSEXEMPTIONRULES.LIST>      </TDSEXEMPTIONRULES.LIST>\r\n";
    output.write(text);
    text = "<DEDUCTINSAMEVCHRULES.LIST>      </DEDUCTINSAMEVCHRULES.LIST>\r\n";
    output.write(text);
    text = "<LOWERDEDUCTION.LIST>\r\n";
    output.write(text);
    text = "<LOWERDEDUCTIONDETAILS.LIST>       </LOWERDEDUCTIONDETAILS.LIST>\r\n";
    output.write(text);
    text = "</LOWERDEDUCTION.LIST>\r\n";
    output.write(text);
    text = "</LEDGER>\r\n";
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
    output.close();
    out.println("Your file has been written");
    }
    catch (Exception e) 
    {
    System.out.println("Exception===========>>"+e);
    }     
    %>
</body>
</html>
