<%@ page contentType="application/vnd.ms-excel; "
	import="java.sql.*" import="java.text.*"%>
	<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.util.Date"%>
<%@ include file="conn1.jsp"%>
<%@page import="java.net.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.*"%>
<%@page import="org.xml.sax.InputSource"%>
<%@ page import="java.io.PrintWriter" %>  

<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename;
	filename = "tallycompare.xls";
	response.addHeader("Content-Disposition", "attachment;filename="
			+ filename);

	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">
<html>
<body>
<form>
<%
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();
	DecimalFormat df2 = new DecimalFormat( "0.00" );
	String begindate="",enddate="";
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	//cal.add(Calendar.YEAR, -3);
	cal.add(Calendar.DATE, -65);
	Date today30 = cal.getTime();
	System.out.println(today30);
	
	//begindate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	begindate=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	System.out.println("begin date:"+begindate);
	enddate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(DB_Driver);
	Connection connmain;
	connmain = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
	Statement stmain=connmain.createStatement();
	Statement stdata =connmain.createStatement();
	String sqldata = "";
	sqldata="DELETE FROM "+session.getAttribute("CompanyMasterID").toString()+"tally_erp";
    System.out.println(sqldata);
    stdata.executeUpdate(sqldata);
	ResultSet rsmain=null;
	String sqlmain="";
	sqlmain="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where tallyname is not null and tallyname !=' ' and tallyname !='-' and tallyname not like '% NA%' and tallyname not like '%NA %' order by tallyname limit 300,25";
	rsmain=stmain.executeQuery(sqlmain);
	String mAccountname="";
	//String ipAddress =request.getRemoteAddr(); 
	///String ipAddress = "219.64.93.243";
	///String ipAddress = "219.64.202.76";
//	String ipAddress = "115.112.36.134";
	String Connected = tally.connectTallyserver(SID , PID);
	if (Connected.contains("Not Connected"))
	{
		 out.println(Connected);
	     out.println(" Please Start Tally Server First ");
	}
	else
	{

		while(rsmain.next())
		{
	    	mAccountname = rsmain.getString("tallyname");
	    	
	    	if (mAccountname.isEmpty() )
	    	{
	    		mAccountname="NOT";
	    	}
	    	String msgrec=null;
			String mPartyname=null;
  			String mVouchertype=null;
  			String mVoucherno=null;
  			String mDate=null;
  			String mNarration="-";
  			String mdrAmount=null;
  			String mcrAmount=null;
  			double mdrtemp=0;
  			double mcrtemp=0;
  			double mDr =0;
  			double mCr =0;
  			double mBal=0;
  			double mAmount=0;
			StringBuilder xmldoc = new StringBuilder();
			xmldoc.append("<ENVELOPE>\r\n");
			xmldoc.append("<HEADER>\r\n");
			xmldoc.append("<TALLYREQUEST>Export Data</TALLYREQUEST>\r\n");
			xmldoc.append("</HEADER>\r\n");
			xmldoc.append("<BODY>\r\n");
			xmldoc.append("<EXPORTDATA>\r\n");
			xmldoc.append("<REQUESTDESC>\r\n");
			xmldoc.append("<REPORTNAME>rptMyReport</REPORTNAME>\r\n");
			xmldoc.append("<STATICVARIABLES>\r\n");  
			xmldoc.append("<EXPLODEFLAG>Yes</EXPLODEFLAG>\r\n");
			xmldoc.append("<SVEXPORTFORMAT>$$SysName:XML</SVEXPORTFORMAT>\r\n");
			xmldoc.append("<SVCURRENTCOMPANY>TRANSWORLD COMPRESSOR TECHNOL</SVCURRENTCOMPANY>\r\n");
			xmldoc.append("<SVFROMDATE TYPE='Date'>"+begindate+"</SVFROMDATE>\r\n");
			xmldoc.append("<SVTODATE TYPE='Date'>"+enddate+"</SVTODATE>\r\n");
			xmldoc.append("<SVMAILAUTHUSERNAME TYPE='String'>"+mAccountname+"</SVMAILAUTHUSERNAME>\r\n");
			xmldoc.append("</STATICVARIABLES>\r\n");
			xmldoc.append("</REQUESTDESC>\r\n");
			xmldoc.append("</EXPORTDATA>\r\n");
			xmldoc.append("</BODY>\r\n");
			xmldoc.append("</ENVELOPE>\r\n");
			StringBuilder response1 = new StringBuilder();
			try
			{
				URL url=null;
    			url = new URL("http://"+SID+":"+PID+"/");
    			URLConnection conn = url.openConnection();
    			conn.setDoOutput(true);
    			conn.setReadTimeout(40*1000);
    			conn.connect();
    			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
    			wr.write(xmldoc.toString());
    		 	wr.flush();
    			System.out.println(xmldoc.toString());
    			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    			String line = null;
    			while ((line = reader.readLine()) != null)
    			{	
      				response1.append(line + "\n");
      				System.out.println(line+"\n");
    			}
   
			}
			catch (Exception e)
			{	
				System.out.println("*****/Exception-->Send Tally, Message from tally"+e.toString()+msgrec);
				e.printStackTrace();
			}
  			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
  			DocumentBuilder db = dbf.newDocumentBuilder();
  			InputSource sx = new InputSource(new StringReader(response1.toString()));
  			Document doc = db.parse(sx);
 
			Element root = doc.getDocumentElement();
  			NodeList accountnodeList = doc.getElementsByTagName("MYACCOUNT");
  			String dropeningbalance = null;
	    	String cropeningbalance = null;
  			double mopb = 0;
  			for (int i = 0; i < accountnodeList.getLength(); i++)
  			{
            	Node accountnode = accountnodeList.item(i);
            	if (accountnode.getNodeType() == Node.ELEMENT_NODE) 
            	{
	     	      	Element drclgblg = (Element) accountnode;//  node;
    	 		    NodeList drclgblgLst = drclgblg.getElementsByTagName("DROPENINGBALANCE");
     			    Element drclgblgElmnt = (Element) drclgblgLst.item(0);
    			    NodeList drclgblgNm = drclgblgElmnt.getChildNodes();
    		    	dropeningbalance=((Node) drclgblgNm.item(0)).getNodeValue().replace(",","");
    		    	System.out.println("DROPENINGBALANCE"+dropeningbalance);
    		    	Element crclgblg = (Element) accountnode;//  node;
     		    	NodeList crclgblgLst = crclgblg.getElementsByTagName("CROPENINGBALANCE");
     		    	Element crclgblgElmnt = (Element) crclgblgLst.item(0);
    		    	NodeList crclgblgNm = crclgblgElmnt.getChildNodes();
    		    	cropeningbalance=((Node) crclgblgNm.item(0)).getNodeValue().replace(",","");
    		    	System.out.println("CROPENINGBALANCE"+cropeningbalance);
    			}
  			}
  			mopb = 0;
  			if (dropeningbalance!=null)
  			{
	   			mopb=Double.parseDouble(dropeningbalance);
       			if (mopb == 0)
       			{
		       		if (cropeningbalance!=null)
	       			{
	    	        	mopb = Double.parseDouble(cropeningbalance);
		            	mopb = mopb *-1;
	       			}
       			}
	    	}
	    	if (mopb > 0)
    		{
        		mDr = mDr + mopb;
        	}
	     	if (mopb < 0)
    		{
        	 	mCr = mCr + mopb*-1;
     		}
 	    	StringBuilder xmldoc1 = new StringBuilder();
			xmldoc1.append("<ENVELOPE>\r\n");
			xmldoc1.append("<HEADER>\r\n");
			xmldoc1.append("<TALLYREQUEST>Export Data</TALLYREQUEST>\r\n");
			xmldoc1.append("</HEADER>\r\n");
			xmldoc1.append("<BODY>\r\n");
			xmldoc1.append("<EXPORTDATA>\r\n");
			xmldoc1.append("<REQUESTDESC>\r\n");
			xmldoc1.append("<REPORTNAME>rptMyVouchers</REPORTNAME>\r\n");
			xmldoc1.append("<STATICVARIABLES>\r\n");  
			xmldoc1.append("<EXPLODEFLAG>Yes</EXPLODEFLAG>\r\n");
			xmldoc1.append("<SVEXPORTFORMAT>$$SysName:XML</SVEXPORTFORMAT>\r\n");
			xmldoc1.append("<SVCURRENTCOMPANY>TRANSWORLD COMPRESSOR TECHNOL</SVCURRENTCOMPANY>\r\n");
			xmldoc1.append("<SVFROMDATE TYPE='Date'>"+begindate+"</SVFROMDATE>\r\n");
			xmldoc1.append("<SVTODATE TYPE='Date'>"+enddate+"</SVTODATE>\r\n");
			xmldoc.append("<SVMAILAUTHUSERNAME TYPE='String'>"+mAccountname+"</SVMAILAUTHUSERNAME>\r\n");
			xmldoc1.append("</STATICVARIABLES>\r\n");
			xmldoc1.append("</REQUESTDESC>\r\n");
			xmldoc1.append("</EXPORTDATA>\r\n");
			xmldoc1.append("</BODY>\r\n");
			xmldoc1.append("</ENVELOPE>\r\n");
			StringBuilder response2 = new StringBuilder();
			try
			{	
				URL url=null;
    			url = new URL("http://"+SID+":"+PID+"/");
    			URLConnection conn = url.openConnection();
    			conn.setDoOutput(true);
    			conn.setReadTimeout(40*1000);
    			conn.connect();
    			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
    			wr.write(xmldoc1.toString());
    			wr.flush();
    			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    			String line = null;
    			while ((line = reader.readLine()) != null)
    			{
	      			response2.append(line + "\n");
    			}
			}
			catch (Exception e)
			{
				System.out.println("*****/Exception-->Send Tally, Message from tally"+e.toString()+msgrec);
				e.printStackTrace();
			}
	    	DocumentBuilderFactory dbf1 = DocumentBuilderFactory.newInstance();
  			DocumentBuilder db1 = dbf1.newDocumentBuilder();
  			InputSource sx1 = new InputSource(new StringReader(response2.toString()));
  			Document doc1 = db.parse(sx1);
 			Element root1 = doc1.getDocumentElement();
  			NodeList nodeList = doc1.getElementsByTagName("VOUCHER");
  			for (int i = 0; i < nodeList.getLength(); i++)
  			{
            	   Node node = nodeList.item(i);
               	   if (node.getNodeType() == Node.ELEMENT_NODE) 
               	  {
     		      		Element fstElmnt = (Element) node;
     		      		NodeList fstNmElmntLst = fstElmnt.getElementsByTagName("LEDGERNAME");
     		      		Element fstNmElmnt = (Element) fstNmElmntLst.item(0);
    		      		NodeList fstNm = fstNmElmnt.getChildNodes();
    		      		mPartyname=((Node) fstNm.item(0)).getNodeValue();
     		      		
     		      		Element fstElmnt1 = (Element) node;
    		      		NodeList fstNmElmntLst1 = fstElmnt1.getElementsByTagName("VOUCHERTYPENAME");
    		      		Element fstNmElmnt2 = (Element) fstNmElmntLst1.item(0);
    		      		NodeList fstNm2 = fstNmElmnt2.getChildNodes();
    		      		mVouchertype=((Node) fstNm2.item(0)).getNodeValue();
    		      		
    		      		Element vounoElmnt = (Element) node;
    		      		NodeList vounoElmntLst = vounoElmnt.getElementsByTagName("VOUCHERNUMBER");
    		      		Element vounoElmnt1 = (Element) vounoElmntLst.item(0);
    		      		NodeList vounoNm = vounoElmnt1.getChildNodes();
    		      		mVoucherno=((Node) vounoNm.item(0)).getNodeValue();
    		      
    		      		Element fstElmnt2 = (Element) node;
    		      		NodeList fstNmElmntLst2 = fstElmnt2.getElementsByTagName("DATE");
		    		    Element fstNmElmnt3 = (Element) fstNmElmntLst2.item(0);
    		      		NodeList fstNm3 = fstNmElmnt3.getChildNodes();
    		      		mDate=((Node) fstNm3.item(0)).getNodeValue();
    		      
    		      		Element fstElmnt6 = (Element) node;
    		      		NodeList fstNmElmntLst7 = fstElmnt6.getElementsByTagName("NARRATION");
    		      		Element fstNmElmnt7 = (Element) fstNmElmntLst7.item(0);
    		    
    		      		if (fstNmElmnt7.hasChildNodes())
    		      		{
    		            	 NodeList fstNm8 = fstNmElmnt7.getChildNodes();
    		             	 mNarration=((Node) fstNm8.item(0)).getNodeValue();
    		             	 System.out.println("NARRATION : "  + ((Node) fstNm8.item(0)).getNodeValue());
    		      		}
    		      		Element fstElmnt4 = (Element) node;
    		      		NodeList fstNmElmntLst4 = fstElmnt4.getElementsByTagName("DRAMOUNT");
    		      		Element fstNmElmnt5 = (Element) fstNmElmntLst4.item(0);
    		      		NodeList fstNm5 = fstNmElmnt5.getChildNodes();
    		      		mdrAmount=((Node) fstNm5.item(0)).getNodeValue().replace(",","");
    		      		System.out.println("DRAMOUNT"+mdrAmount);
    		      		mdrtemp=Double.parseDouble(mdrAmount);
    		      		if (mdrtemp>=-0.00 && mdrtemp<=0.00)
    		      		{
    		      			mdrtemp=0;
    		      		}
    		      
    		      		Element fstElmnt5 = (Element) node;
    		      		NodeList fstNmElmntLst5 = fstElmnt5.getElementsByTagName("CRAMOUNT");
    		      		Element fstNmElmnt6 = (Element) fstNmElmntLst5.item(0);
    		      		NodeList fstNm6 = fstNmElmnt6.getChildNodes();
    		      		mcrAmount=((Node) fstNm6.item(0)).getNodeValue().replace(",","");
    		      		System.out.println("CRAMOUNT"+mcrAmount);
    		      		mcrtemp=Double.parseDouble(mcrAmount);
    		      		if (mcrtemp>=-0.00 && mcrtemp <=0.00)
    		      		{
    		    	  		mcrtemp=0;
    		      		}
    		      		mDr = mDr + mdrtemp;
                  		mopb = mopb + mdrtemp;
                  		mCr = mCr + mcrtemp;
                  		mopb = mopb -mcrtemp;
                  		mAmount =0;
                  		if (mdrtemp!=0 && mcrtemp ==0)
                  		{
                  			mAmount = mdrtemp;
                  		}
                  		if (mcrtemp!=0 && mdrtemp ==0)
                  		{
                  			mAmount = mcrtemp;
                  		}
                  		System.out.println(mAccountname);
                  		System.out.println("DATE:"+mDate);
                  		String myDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(mDate));
                  		System.out.println("DATE:"+myDate);
                  		mNarration=mNarration.replace("'"," ");
                  		sqldata="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"tally_erp (customername,vouchertype,date,voucherno,debit,credit,balance,narrations,entry_found,data_from,amount)"+
		    	        		    "VALUES ('"+mAccountname+"','"+mVouchertype+"','"+myDate+"','"+mVoucherno+"','"+mdrtemp+"','"+mcrtemp+"','"+mopb+"','"+mNarration+"','N','TALLY',"+mAmount+")";
                  		System.out.println(sqldata);
      					stdata.executeUpdate(sqldata);	
                  }
         	}
		 	tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD,SID,PID,CMID);
  			Connection conn = null;
  			Statement st = null;
  			conn = tally.ReturnConnection();
    		st = conn.createStatement();
    		String mybegindate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(begindate));
   			String myenddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enddate));
  			System.out.println(mybegindate+myenddate);
   			String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b ON a.customercode = b.customercode where b.tallyname LIKE '%"+mAccountname+"%' and transactiondate between '"+mybegindate+"' and '"+myenddate+"' order by transactiondate";
    		System.out.println("ERP"+sql);
  			ResultSet rs=st.executeQuery(sql);
  			String myprintflag = "Y";
            mdrtemp = 0;
  			mcrtemp = 0;
  			mVouchertype=null;
  			mDate=null;
  			mVoucherno=null;
  			mNarration = null;
  			mdrAmount = null;
  			mBal = 0;
  			mDr = 0;
  			mCr= 0;
  			double tempdr;
  			double tempcr;
  			while (rs.next())
  			{
  			    mVouchertype=rs.getString("transactiontype");
  			    mDate=rs.getString("transactiondate");
  			    System.out.println(mDate);
  			    String myDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(mDate));
  			    mVoucherno=rs.getString("paymentvoucherno");
  			    mNarration=rs.getString("transactiondetail");
  			    System.out.println(rs.getString("transactiontype")+rs.getDouble("debitamount")+rs.getDouble("creditamount"));
  			    mBal = rs.getDouble("balance");
  			    tempdr = 0;
  			    tempcr = 0;
  			    if (rs.getDouble("creditamount")!=0)
  			    {
  			        mdrAmount=rs.getString("creditamount");
  			    	mdrtemp=Double.parseDouble(mdrAmount);
  			    }
  			    if (rs.getDouble("debitamount")!=0)
  			    {
  			        mdrAmount=rs.getString("debitamount");
  			        mdrtemp=Double.parseDouble(mdrAmount)*-1;
  			    } 
                if (mdrtemp <0)
                {
                    tempdr = mdrtemp*-1;
                	mBal = mBal + mdrtemp;
               }
               if (mdrtemp >=0)
               {
                   tempcr = mdrtemp;
            	   mBal = mBal+mdrtemp;
               }
               mAmount =0;
         		if (tempdr!=0 && tempcr ==0)
         		{
         			mAmount = tempdr;
         		}
         		if (tempcr!=0 && tempdr ==0)
         		{
         			mAmount = tempcr;
         		}
               sqldata="INSERT into "+session.getAttribute("CompanyMasterID").toString()+"tally_erp (customername,vouchertype,date,voucherno,debit,credit,balance,narrations,entry_found,data_from,amount)"+
   	        			   "VALUES ('"+mAccountname+"','"+mVouchertype+"','"+mDate+"','"+mVoucherno+"','"+tempdr+"','"+tempcr+"','"+mBal+"','"+mNarration+"','N','ERP',"+mAmount+")";
               System.out.println(sqldata);
			   stdata.executeUpdate(sqldata);
            } 
		}
	}
	Connection conncompare = null;
    Statement stcompare = null;
    Statement stinner = null;
	conncompare = tally.ReturnConnection();
	stcompare = conncompare.createStatement();
	stinner = conncompare.createStatement();
	String sqlinner = "";
	ResultSet rsinner=null;
	String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"tally_erp where data_from='TALLY' ";
	System.out.println("ERP"+sql);
	ResultSet rscompare=stcompare.executeQuery(sql);
	String mdate = "";
	String mvouchertype =null;
	double mdebit = 0;
	double mcredit = 0;
    String mnarration="";
    String mvoucherno = "";
    String mcustomername="";
    double mAmount=0;
	while (rscompare.next())
	{
		mdate=rscompare.getString("date");
		mvouchertype=rscompare.getString("vouchertype");
		System.out.println("vouchertype:"+mvouchertype);
		if (mvouchertype.equalsIgnoreCase("Credit Note"))
		{
			mvouchertype="Credit Note";
		}
		if (mvouchertype.equalsIgnoreCase("Sales"));
		{
			mvouchertype = "Invoice";
		}
		if (mvouchertype.equalsIgnoreCase("Receipt"))
		{
		     mvouchertype="Cheque";
		}
		
		System.out.println("vouchertype[after]:"+mvouchertype);
	    //out.println("====>"+mcustomername+mvouchertype+mdate+mAmount+"<br><br>");
		mdebit=rscompare.getDouble("debit");
		mcredit=rscompare.getDouble("credit");
		mAmount=rscompare.getDouble("amount");
		mnarration=rscompare.getString("narrations");
		mcustomername=rscompare.getString("customername");
		sqlinner="select * from "+session.getAttribute("CompanyMasterID").toString()+"tally_erp where data_from='ERP' and customername='"+mcustomername+"' and vouchertype = '"+mvouchertype+"' and date = '"+mdate+"' and (amount="+mAmount+") limit 1 ";
		rsinner=stinner.executeQuery(sqlinner);
		int tallycompare_id = rscompare.getInt("compare_id");
        String found_flag = "N";
        int mcompare_id=0;
		if (rsinner.next())
        {
			mcompare_id = rsinner.getInt("compare_id");
        	sqldata="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"tally_erp set entry_found = 'Y', entry_compareid="+tallycompare_id+" where compare_id="+mcompare_id;
			stdata.executeUpdate(sqldata);
			found_flag = "Y";
        }
	    if (found_flag =="Y")
	    {
	    	sqldata="UPDATE "+session.getAttribute("CompanyMasterID").toString()+"tally_erp set entry_found = 'Y', entry_compareid="+mcompare_id+" where compare_id="+tallycompare_id;
			stdata.executeUpdate(sqldata);
			found_flag="N";
	    }
	}
	String htmlstring="";
    sql="select DISTINCT customername from "+session.getAttribute("CompanyMasterID").toString()+"tally_erp order by customername";
	System.out.println("ERP"+sql);
	rscompare=stcompare.executeQuery(sql);
	String mColorCode = "#F2C8C6";
	%>
    <table border="1">
    <tr align="center">
    <td colspan="9" style="background-color:<%=mColorCode%>">
     <h1>TALLY/ERP Comparison from <%=begindate%> to <%=enddate %></h1>
    </td>
    </tr>
    
    <%
    String matchflag="N";
    while (rscompare.next())
    {
    	mcustomername=rscompare.getString("customername");
    	
    	%>
    	<tr align="center">
    	<td colspan="9" style="background-color:#E5DEDE"><h3>Name of the Customer:-<%=mcustomername%></h3>
    	</td>
    	</tr>
    	<tr>
        <th style="background-color:#70B0EF">Data From
        </th>
        	<th style="background-color:#70B0EF">Entry Found
        	</th>  
        	<th style="background-color:#70B0EF">Voucher Type
        	</th>
        	<th style="background-color:#70B0EF">Date
        	</th>
        	<th style="background-color:#70B0EF">Voucher No.
        	</th>
        	<th style="background-color:#70B0EF">Debit
        	</th>
        	<th style="background-color:#70B0EF">Credit
        	</th>
        	<th style="background-color:#70B0EF">Balance
        	</th>
        	 <th style="background-color:#70B0EF;width:500;">Narrations
        	 </th>
        	 </tr>
    	<%
    	
    	sqlinner="select * from "+session.getAttribute("CompanyMasterID").toString()+"tally_erp where customername='"+mcustomername+"' order by customername,date,debit,credit"; 
		rsinner=stinner.executeQuery(sqlinner);
		mColorCode = "#F2C8C6";
        while (rsinner.next())
        {
        	
        	mColorCode = "#F2C8C6";
        	if (rsinner.getString("entry_found").contains("Y"))
        	{
        		mColorCode="#90DB91";
        	}
        	%>
        	<tr>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("data_from")%>
        	</td>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("entry_found")%>
        	</td>  
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("vouchertype")%>
        	</td>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("date") %>
        	</td>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("voucherno")%>
        	</td>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("debit")%>
        	</td>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getString("credit")%>
        	</td>
        	<td style="background-color:<%=mColorCode%>"><%=rsinner.getDouble("balance")%>
        	</td>
        	 <td style="background-color:<%=mColorCode%>"><%=rsinner.getString("narrations")%>
        	 </td>
        	 </tr>
        	 <%
        }
    }
    System.out.println(htmlstring);
    %>
    <tr>
    <td colspan="9">
    </td>
    </tr>
    <tr>
    <td colspan="9">
    </td>
    </tr>
</table>
</form>
</body>
</html>
</jsp:useBean>
