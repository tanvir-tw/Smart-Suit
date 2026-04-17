<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="../header.jsp"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Conversion - Receipt Vouchers</title>
</head>
<body>
<form name="xyz" method="get" action="">
<br>
<br>
<br>
<table align="center" border="2">
<tr>
<td width="500">
    Conversion File Name: <input type="text" id="filename" name="filename" value="c:\tally.erp9\payments.xml" size = "50"/>
    </td>
    
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
    	   </tr>
    	   </table>
    	   <table align="center" border="2">
    	   <tr>
    	    <td align="center" valign="top">
			 
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
			&nbsp;<b>To </b> </td><td align="left" valign="top" style="width: 80px;">
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
        Writer output = null;
        String text = "";
        String mFilename=request.getParameter("filename");
        System.out.println(mFilename);
        File file = new File(mFilename);
        output = new BufferedWriter(new FileWriter(file));
        try {
            //String fromDate="2011-09-10";
            //String toDate="2011-09-15";
            //Class.forName("com.mysql.cj.jdbc.Driver");
            //Connection conn1= DriverManager.getConnection("jdbc:mysql://192.168.1.55/TWSQL_TWALLDATA","erp","1@erp");
            //st1=conn1.createStatement();
            conn = tally.ReturnConnection();
		    st1 = conn.createStatement();
		    st2 = conn.createStatement();
            out.println(fromDate);
            out.println(toDate);
		    String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"allpaymentdetails as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on a.CustomerCode = b.customerCode where a.paymentdate BETWEEN '"+fromDate+"' and '"+toDate+"'  and paymentmode = 'Cheque' order by paymentdate";
            String sql1="";
            System.out.println(sql);
            ResultSet rs=st1.executeQuery(sql);
            text="<ENVELOPE>\r\n";
            output.write(text);
            text=" <HEADER>\r\n";
            output.write(text);
            text="  <TALLYREQUEST>Import Data</TALLYREQUEST>\r\n";
            output.write(text);
            text=" </HEADER>\r\n";
            output.write(text);
            text=" <BODY>\r\n";
            output.write(text);
            text="  <IMPORTDATA>\r\n";
            output.write(text);
            text="   <REQUESTDESC>\r\n";
            output.write(text);
            text="    <REPORTNAME>Vouchers</REPORTNAME>\r\n";
            output.write(text);
            text="    <STATICVARIABLES>\r\n";
            output.write(text);
            //text="     <SVCURRENTCOMPANY>TRANSWORLD COMPRESSOR TECHNOL</SVCURRENTCOMPANY>\r\n";
            //output.write(text);
            text="    </STATICVARIABLES>\r\n";
            output.write(text);
            text="   </REQUESTDESC>\r\n";
            output.write(text);
            text="   <REQUESTDATA>\r\n";
            output.write(text);
            %>
                     
            <table width="100%" border="2" style="font-size: 10" class="sortable">
            <tr >
            <td colspan="6" align="center"><h1>Converted Data to Tally [PAYMENTS]</h1></td>
            </tr>
            <th>Voucher Date</th>
            <th>Voucher No</th>
            <th>Account Name</th>
            <th align="right">Amount</th>
            <th>Bank Name</th>
            <th>Narrations</th>
            <%
            while(rs.next()) 
            {
            %>
            <tr>
            <%
            	String mVoudate=rs.getString("paymentdate");
                //mVoudate="2010-04-01";
                System.out.println("first"+mVoudate);
                mVoudate=mVoudate.substring(0,4)+mVoudate.substring(5,7)+mVoudate.substring(8,10);
                System.out.println(mVoudate);
                String mVoucherno=rs.getString("paymentvoucherno");
                String mCompanyname=rs.getString("b.companyname").replace("&","and");
                String mBankname="HDFC Bank A/c No.00392050000250";//"HDFC Bank"; // FOR OTHER BANKS WE HAVE MAKE CHANGES IN OUR ERP
                String mAmount=rs.getString("amountpaid");
                String mNarration=rs.getString("remarks")+" Ch No:"+rs.getString("chorddorcreditnoteno");
                //Ch. No. :NEFT  Dtd 17/08/11 being paid amt against bill no.  C01011/0893 dtd 31/08/10
                text= mVoudate+mVoucherno;
                String mUsername=session.getAttribute("EmpName").toString();
                //String mTodaydate= today;
                sql1="insert into "+session.getAttribute("CompanyMasterID").toString()+"tallydata_conv (voucher_type,voucher_date,voucher_no,accountname,secondaccount,amount,narrations,username,create_date)"+
                     "VALUES ( 'Payments','"+mVoudate+"','"+mVoucherno+"','"+mCompanyname+"','"+mBankname+"','"+mAmount+"','"+mNarration+"','"+mUsername+"','"+todaysDateTime+"')";
                System.out.println(sql1);
                     st2.executeUpdate(sql1);
            %>
            <td><div> <%=mVoudate.substring(6,8)+"-"+mVoudate.substring(4,6)+"-"+mVoudate.substring(0,4)%></div></td>
            <td><%=mVoucherno%></td>
			<td><%=mCompanyname%></td>
			<td align="right"><%=mAmount%></td>
			<td><%=mBankname%></td>
			<td><%=mNarration%></td>
			<%
			text="    <TALLYMESSAGE xmlns:UDF='TallyUDF'>\r\n";
            output.write(text);
            text = "<VOUCHER  VCHTYPE='Payment' ACTION='Create'>\r\n";
            output.write(text);
            text="      <BASICBANKERSDATE.LIST TYPE='Date'>\r\n";
            output.write(text);
            text="       <BASICBANKERSDATE>"+mVoudate+"</BASICBANKERSDATE>\r\n";
            output.write(text);
            text="      </BASICBANKERSDATE.LIST>\r\n";
            output.write(text);
            text="      <DATE>"+mVoudate+"</DATE>\r\n";
            output.write(text);
            //text="      <GUID>534280e0-8c06-11d9-a6f7-525405f8aba3-00014d0a</GUID>\r\n";
            //output.write(text);
            text="      <NARRATION>"+mNarration+"</NARRATION>\r\n";
            output.write(text);
            text="      <VOUCHERTYPENAME>Payment</VOUCHERTYPENAME>\r\n";
            output.write(text);
            text = "<VOUCHERNUMBER>"+mVoucherno+"</VOUCHERNUMBER>\r\n";
            output.write(text);
            text = "<PARTYLEDGERNAME>"+mCompanyname+"</PARTYLEDGERNAME>\r\n";
            output.write(text);
            text="      <BASICVOUCHERCHEQUENAME>Neft "+mCompanyname+"</BASICVOUCHERCHEQUENAME>\r\n";
            output.write(text);
            text="      <BASICVOUCHERCROSSCOMMENT>A/c Payee</BASICVOUCHERCROSSCOMMENT>\r\n";
            output.write(text);
            text="      <CSTFORMISSUETYPE/>\r\n";
            output.write(text);
            text="      <CSTFORMRECVTYPE/>\r\n";
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
            text = "<EFFECTIVEDATE>"+mVoudate+"</EFFECTIVEDATE>\r\n";
            output.write(text);
            text="      <USEFORINTEREST>No</USEFORINTEREST>\r\n";
            output.write(text);
            text="      <USEFORGAINLOSS>No</USEFORGAINLOSS>\r\n";
            output.write(text);
            text="      <USEFORGODOWNTRANSFER>No</USEFORGODOWNTRANSFER>\r\n";
            output.write(text);
            text="      <USEFORCOMPOUND>No</USEFORCOMPOUND>\r\n";
            output.write(text);
            text="      <ALTERID> 158797</ALTERID>\r\n";
            output.write(text);
            text="      <EXCISEOPENING>No</EXCISEOPENING>\r\n";
            output.write(text);
            text="      <USEFORFINALPRODUCTION>No</USEFORFINALPRODUCTION>\r\n";
            output.write(text);
            text="      <ISCANCELLED>No</ISCANCELLED>\r\n";
            output.write(text);
            text="      <HASCASHFLOW>Yes</HASCASHFLOW>\r\n";
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
            text = "<LEDGERNAME>"+mCompanyname+"</LEDGERNAME>\r\n";
            output.write(text);
            text="       <GSTCLASS/>\r\n";
            output.write(text);
            text="       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>\r\n";
            output.write(text);
            text="       <LEDGERFROMITEM>No</LEDGERFROMITEM>\r\n";
            output.write(text);
            text="       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>\r\n";
            output.write(text);
            text="       <ISPARTYLEDGER>Yes</ISPARTYLEDGER>\r\n";
            output.write(text);
            text="       <AMOUNT>-108324.00</AMOUNT>\r\n";
            output.write(text);
            text="       <BILLALLOCATIONS.LIST>\r\n";
            output.write(text);
            text = "<NAME>"+mVoucherno+"</NAME>\r\n";
            output.write(text);
            text="        <BILLTYPE>Agst Ref</BILLTYPE>\r\n";
            output.write(text);
            text="        <AMOUNT>-"+mAmount+"</AMOUNT>\r\n";
            output.write(text);
            text="       </BILLALLOCATIONS.LIST>\r\n";
            output.write(text);
            text="      </ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="      <ALLLEDGERENTRIES.LIST>\r\n";
            output.write(text);
            text="       <LEDGERNAME>"+mBankname+"</LEDGERNAME>\r\n";
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
            text="       <AMOUNT>"+mAmount+"</AMOUNT>\r\n";
            output.write(text);
            text="      </ALLLEDGERENTRIES.LIST>\r\n";
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
            //out.println("Your file has been written");
            output.close();
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
	<!-- end #footer -->
   </body>
</html>
</jsp:useBean>