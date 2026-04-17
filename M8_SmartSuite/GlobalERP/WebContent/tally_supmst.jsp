<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - [SUPPLIER MASTER]</title>
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
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String text = "";
        
try 
{
            conn = tally.ReturnConnection();
		    st1 = conn.createStatement();
		    st2 = conn.createStatement();
            //out.println(fromDate);
            //out.println(toDate);
		    String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet";// where tallyname IS NOT NULL";
            String sql1="";
            System.out.println(sql);
            ResultSet rs=st1.executeQuery(sql);
            %>
                     
            <table align="left" style="font-size: 10" class="sortable">
            <tr >
            <td colspan="7" ><h1>Converted Data to Tally [SUPPLIER MASTER]</h1></td>
            </tr>
            
            <th>Account Name</th>
            <th>Status</th>
            <%
            String senddata=null;
            while(rs.next()) 
            {
            %>
            <tr>
            <%
                String mCompanyname=rs.getString("suppliername").replace("&","&amp;");
                String mBillingadd=rs.getString("address");
                String mBillingcity=rs.getString("City");
                String mBillingstate=rs.getString("state").replace("-"," ");
                
                String mBillingzip=rs.getString("zip");
                //String mCstormst=rs.getString("cstormst");
                
                if (mBillingadd!=null)
                {
                  mBillingadd=mBillingadd.replace("&","&amp;");
                }
                String entrysearch = tally.search_in_tables("SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv where accountname='"+mCompanyname+"' and voucher_type='Supplier-Master'");
                String mUsername=session.getAttribute("EmpName").toString();
                senddata=null;
                
            %>
            <td><div> <%=mCompanyname%></div></td>
            
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
			xmldoc.append("<REPORTNAME>All Masters</REPORTNAME>\r\n");
			xmldoc.append("</REQUESTDESC>\r\n");
			xmldoc.append("<REQUESTDATA>\r\n");
			xmldoc.append("<TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n");
			xmldoc.append("<LEDGER NAME='"+mCompanyname+"' RESERVEDNAME=''>\r\n");
			xmldoc.append("<ADDRESS.LIST TYPE='String'>\r\n");
			xmldoc.append("<ADDRESS>"+mBillingadd+"</ADDRESS>\r\n");
			xmldoc.append("<ADDRESS>"+mBillingcity+"</ADDRESS>\r\n");
			xmldoc.append("<ADDRESS></ADDRESS>\r\n");
			xmldoc.append("<ADDRESS></ADDRESS>\r\n");
			xmldoc.append("</ADDRESS.LIST>\r\n");
			xmldoc.append("<MAILINGNAME.LIST TYPE='String'>\r\n");
			xmldoc.append("<MAILINGNAME>"+mCompanyname+"</MAILINGNAME>\r\n");
			xmldoc.append("</MAILINGNAME.LIST>\r\n");
			xmldoc.append("<CURRENCYNAME>Rs.</CURRENCYNAME>\r\n");
			xmldoc.append("<STATENAME>"+mBillingstate+"</STATENAME>\r\n");
			xmldoc.append("<PINCODE>"+mBillingzip+"</PINCODE>\r\n");
			xmldoc.append("<INCOMETAXNUMBER></INCOMETAXNUMBER>\r\n");
			xmldoc.append("<SALESTAXNUMBER></SALESTAXNUMBER>\r\n");
			xmldoc.append("<PARENT>Sundry Creditors</PARENT>\r\n");
			xmldoc.append("<TAXCLASSIFICATIONNAME/>\r\n");
			xmldoc.append("<GSTTYPE/>\r\n");
			xmldoc.append("<APPROPRIATEFOR/>\r\n");
			xmldoc.append("<SERVICECATEGORY/>\r\n");
			xmldoc.append("<EXCISEDUTYTYPE/>\r\n");
			xmldoc.append("<EXCISENATUREOFPURCHASE/>\r\n");
			xmldoc.append("<LEDGERFBTCATEGORY/>\r\n");
			xmldoc.append("<ISBILLWISEON>Yes</ISBILLWISEON>\r\n");
			xmldoc.append("<ISCOSTCENTRESON>No</ISCOSTCENTRESON>\r\n");
			xmldoc.append("<ISINTERESTON>No</ISINTERESTON>\r\n");
			xmldoc.append("<ALLOWINMOBILE>No</ALLOWINMOBILE>\r\n");
			xmldoc.append("<ISCONDENSED>No</ISCONDENSED>\r\n");
			xmldoc.append("<AFFECTSSTOCK>No</AFFECTSSTOCK>\r\n");
			xmldoc.append("<FORPAYROLL>No</FORPAYROLL>\r\n");
			xmldoc.append("<INTERESTONBILLWISE>No</INTERESTONBILLWISE>\r\n");
			xmldoc.append("<OVERRIDEINTEREST>No</OVERRIDEINTEREST>\r\n");
			xmldoc.append("<OVERRIDEADVINTEREST>No</OVERRIDEADVINTEREST>\r\n");
			xmldoc.append("<USEFORVAT>No</USEFORVAT>\r\n");
			xmldoc.append("<IGNORETDSEXEMPT>No</IGNORETDSEXEMPT>\r\n");
			xmldoc.append("<ISTCSAPPLICABLE>No</ISTCSAPPLICABLE>\r\n");
			xmldoc.append("<ISTDSAPPLICABLE>No</ISTDSAPPLICABLE>\r\n");
			xmldoc.append("<ISFBTAPPLICABLE>No</ISFBTAPPLICABLE>\r\n");
			xmldoc.append("<ISGSTAPPLICABLE>No</ISGSTAPPLICABLE>\r\n");
			xmldoc.append("<ISEXCISEAPPLICABLE>No</ISEXCISEAPPLICABLE>\r\n");
			xmldoc.append("<ISTDSEXPENSE>No</ISTDSEXPENSE>\r\n");
			xmldoc.append("<ISEDLIAPPLICABLE>No</ISEDLIAPPLICABLE>\r\n");
			xmldoc.append("<ISEDLIAPPLICABLE>No</ISEDLIAPPLICABLE>\r\n");
			xmldoc.append("<ISRELATEDPARTY>No</ISRELATEDPARTY>\r\n");
			xmldoc.append("<SHOWINPAYSLIP>No</SHOWINPAYSLIP>\r\n");
			xmldoc.append("<USEFORGRATUITY>No</USEFORGRATUITY>\r\n");
			xmldoc.append("<FORSERVICETAX>No</FORSERVICETAX>\r\n");
			xmldoc.append("<ISINPUTCREDIT>No</ISINPUTCREDIT>\r\n");
			xmldoc.append("<ISEXEMPTED>No</ISEXEMPTED>\r\n");
			xmldoc.append("<ISABATEMENTAPPLICABLE>No</ISABATEMENTAPPLICABLE>\r\n");
			xmldoc.append("<TDSDEDUCTEEISSPECIALRATE>No</TDSDEDUCTEEISSPECIALRATE>\r\n");
			xmldoc.append("<AUDITED>No</AUDITED>\r\n");
			xmldoc.append("<SORTPOSITION> 1000</SORTPOSITION>\r\n");
			xmldoc.append("<OPENINGBALANCE></OPENINGBALANCE>\r\n");
			xmldoc.append("<LANGUAGENAME.LIST>\r\n");
			xmldoc.append("<NAME.LIST TYPE='String'>\r\n");
			xmldoc.append("<NAME>"+mCompanyname+"</NAME>\r\n");
			xmldoc.append("</NAME.LIST>\r\n");
			xmldoc.append("<LANGUAGEID> 1033</LANGUAGEID>\r\n");
			xmldoc.append("</LANGUAGENAME.LIST>\r\n");
			xmldoc.append("<LEDGERAUDITCLASS.LIST>\r\n");
			xmldoc.append("<LEDAUDITPERIOD.LIST></LEDAUDITPERIOD.LIST>\r\n");
			xmldoc.append("</LEDGERAUDITCLASS.LIST>\r\n");
			xmldoc.append("<AUDITENTRIES.LIST></AUDITENTRIES.LIST>\r\n");
			xmldoc.append("<TDSEXEMPTIONRULES.LIST></TDSEXEMPTIONRULES.LIST>\r\n");
			xmldoc.append("<DEDUCTINSAMEVCHRULES.LIST></DEDUCTINSAMEVCHRULES.LIST>\r\n");
			xmldoc.append("<LOWERDEDUCTION.LIST>\r\n");
			xmldoc.append("<LOWERDEDUCTIONDETAILS.LIST></LOWERDEDUCTIONDETAILS.LIST>\r\n");
			xmldoc.append("</LOWERDEDUCTION.LIST>\r\n");
			xmldoc.append("</LEDGER>\r\n");
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
            	sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv (voucher_type,accountname,username,create_date,tallyvid)"+
                     "VALUES ( 'Supplier-Master','"+mCompanyname+"','"+mUsername+"','"+todaysDateTime+"','"+senddata+"' )";
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

