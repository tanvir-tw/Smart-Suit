<%@page import="javax.mail.Session"%>
<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@include file="header.jsp"%>
<%@page import="java.net.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.*"%>
<%@page import="org.xml.sax.InputSource;"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

<style>
table.mysortable
{
text-align: left;
font-family: Verdana, Geneva, Arial, Helvetica, sans-serif ;
font-weight: normal;
font-size: 11px;
color: #fff;

background-color: #1581AB; <!-- -->
border: 0px;
border-collapse: collapse;
border-spacing: 0px;
}

table.mysortable td
{
background-color: #F8F8FF;
color: #000;
padding: 4px;

border: 1px #808080 solid;
}
table.mysortable th
{
background-color: #1581AB;
color: white;
padding: 4px;

border: 1px #808080 solid;

}

table.mysortable td.hed
{
background-color: #C6DEFF;
color: #696969;
padding: 4px;

border-bottom: 2px #808080 solid;
font-size: 12px;
font-weight: bold;
} 

table.mysortable td.hed1
{
background-color: #C6DEFF;
color: #696969;
padding: 4px;

border-bottom: 2px #808080 solid;
font-size: 12px;
font-weight: bold;
} 

</style>

<script language="Javascript" type="text/javascript">

function gotoExcel(elemId, frmFldId)  
{  
	alert("hello");
	//element.removeAttribute('href');
	document.getElementsByTagName("a").removeAttribute("href"); 
	alert("zale");
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;  
    document.tallydata.action ="excel.jsp";
    document.forms["tallydata"].submit();
}

function gotoPrint(divName)  
{  
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;
     document.body.innerHTML = printContents;
     window.print();
     document.body.innerHTML = originalContents;
}

function changeScreenSize(w,h)
{
    window.resizeTo( w,h )
}

function getAccounts()
{
        document.getElementById("accountsList").style.visibility="visible";
		var accounts=document.payment.accountName.value;
		var ajaxRequest;  // The variable that makes Ajax possible!

		try
		{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				//var mySplitResult = reslt.split("#");
				//alert(mySplitResult[15]);
				document.getElementById("accountsList").innerHTML=reslt;
			} 
		}
		var queryString = "?accounts=" +accounts;
		ajaxRequest.open("GET", "AjaxGetAccounts.jsp" + queryString, true);
		ajaxRequest.send(null); 
	}
    function getAccountsDetails(i) 
    {
        //alert(document.getElementById("name"+i).value);
	   	document.getElementById("accountsList").style.visibility="hidden";
	 	document.payment.accountName.value=document.getElementById("name"+i).value;
    }
    function makeinvisible() 
    {
        //alert(document.getElementById("name"+i).value);
	   	document.getElementById("main").style.visibility="hidden";
    }

    function divScrollR()
    {
        var Right = document.getElementById('mydiv');
        var Left = document.getElementById('mydiv1');
        Left.scrollTop = Right.scrollTop;
    }

    function divScrollL()
    {
        var Right = document.getElementById('mydiv1');
        var Left = document.getElementById('mydiv');
        Right.scrollTop = Left.scrollTop;
    }
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Reports</title>
</head>
<body onload="changeScreenSize(100,100)">

<form name="payment" method="get" action="" autocomplete="off">
<%
String CMID=session.getAttribute("CompanyMasterID").toString();
String SID=session.getAttribute("TallySID").toString();
String PID=session.getAttribute("TallyPID").toString();
if (request.getQueryString()==null)
{
String begindate="",enddate="",begindateCal="",enddateCal="";
Date today = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DAY_OF_MONTH, -30);
Date today30 = cal.getTime();
String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
begindateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
enddateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

if (!(null == request.getParameter("begindate"))) {
    begindate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("begindate")));
    begindateCal=request.getParameter("begindate");
}
if (!(null == request.getParameter("enddate"))){
    enddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("enddate")));
    enddateCal=request.getParameter("enddate");
}
%>
<div id = "main">
     <table>
     <tr>
     <td>
     <div id="searchdiv">Search:
     <input type="text" name="accountName" id="search-text" value="" style='width: 250px;'
	 onkeyup="getAccounts()" /> </div>
	 
	<td>
    Begin Date   :
    </td>
     <td>
    <input type="text" id="begindate"
	 name="begindate" value="<%=begindateCal %>" size="15" readonly
	 style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 <script type="text/javascript">
		  Calendar.setup(
	    {
	      inputField  : "begindate",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "begindate"       // ID of the button
	    }
	  );
	</script>
	</td>
	<td>
     End Date   :
    </td>
     <td>
    <input type="text" id="enddate"
	 name="enddate" value="<%=enddateCal %>" size="15" readonly
	 style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 <script type="text/javascript">
		  Calendar.setup(
	    {
	      inputField  : "enddate",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "enddate"       // ID of the button
	    }
	  );
	</script>
	</td>
	<td>
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" onclick="makeinvisible()";/></td>
     </tr>
     <tr>
     <td>
     <div id='accountsList' style="color:green;">
	<div style="height: 210px; width: 350px; overflow: auto; border:solid inset;"></div>
	</div>
	</td>
     </tr>
     
      </table>
      </div>
      <%
} %>
</form>
<%
if (request.getQueryString()!=null)
{
	String exportFileName="tally_compare.xls";
%>
<form name="tallydata"  method="post" action="">
	<table align="center">
	<tr>
	<td>Name of the Customer:-<strong>
	<%=request.getParameter("accountName") %></strong>
	</td>
	</tr>
	<tr>
	<td>
	Statement of Accounts From:<strong> <%=request.getParameter("begindate") %> to <%=request.getParameter("enddate") %></strong> 
	<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('maindiv');">
	<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img>
	</a>
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('maindiv', 'tableHTML');">
	<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	</a> 
	</td>
	</tr>
	
	
	
	</table>
	<table width="100%">
	<tr>
	<td align="left" width="45%">
	 <strong>&nbsp;&nbsp;[ TALLY EXTRACT ]</strong>                                                      
	</td>
	<td align="right" width="50%">
	<strong>[ OUR ERP EXTRACT ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	</td>
	</tr>
	</table>
	<div id="maindiv">
     <table>
     <tr>
     <td>
	<div id = "mydiv" style="float:left; overflow:auto; width:49%;height:380;" onscroll="divScrollR();">
			                  <table  class="mysortable">
			  			      <tr>
			  			      <th><div style="width:50; align:left" >Voucher Type</div></th>
			  			      <th><div style="width:50; align:left" >Date</div></th>
		   	  			      <th><div style="width:50; align:left" >Voucher No</div></th>
			  			      <th><div style="width:80; align:right" >Debit</div></th>
			  			      <th><div style="width:80; align:right" >Credit</div></th>
			  			      <th><div style="width:100; align:right" >Balance</div></th>
			  			      <th><div style="width:500; align:left" >Narrations</div></th>
			  			      </tr>
			  			      <tr>
			<%
	        String msgrec=null;
            String Reportname="";
            String localipAddress =request.getRemoteAddr(); 
            //String ipAddress = "219.64.93.243";
            //String ipAddress = "219.64.202.76";
            //String ipAddress = "192.168.1.109";
          //  String ipAddress = "115.112.36.134";
            String Connected = tally.connectTallyserver(SID, PID);
            if (Connected.contains("Not Connected"))
            {
                 out.println(Connected);
                 out.println(" Please Start Tally Server First ");
            }
            else
            {
            DecimalFormat df2 = new DecimalFormat( "0.00" );
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
            //String Connected = tally.connectTallyserver(localipAddress);

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
			xmldoc.append("<SVFROMDATE TYPE='Date'>"+request.getParameter("begindate")+"</SVFROMDATE>\r\n");
			xmldoc.append("<SVTODATE TYPE='Date'>"+request.getParameter("enddate")+"</SVTODATE>\r\n");
			xmldoc.append("<SVMAILAUTHUSERNAME TYPE='String'>"+request.getParameter("accountName")+"</SVMAILAUTHUSERNAME>\r\n");
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
			    //url = new URL("http://10.0.10.62:9000/");
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
			      //out.println(line+"\n");
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
			  //double 
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
%>
			  <td>
			      </td>
			      <td>
			      </td>
			      <td>
			      </td>
			     
			      <td align="right">
		    <%
                if (mopb > 0)
                {
		             out.println(df2.format(mopb));
                     mDr = mDr + mopb;
                     
                }
              %>
			      </td>
			      <td align="right">
		    <%
                if (mopb < 0)
                {
		             out.println(df2.format(mopb*-1));
                     mCr = mCr + mopb*-1;
                 }
			  %>
		    </td>
		       <td>
		      </td>
		       <td>
			       Opening Balance
			      </td>
		      </tr>
			  <%
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
			xmldoc1.append("<SVFROMDATE TYPE='Date'>"+request.getParameter("begindate")+"</SVFROMDATE>\r\n");
			xmldoc1.append("<SVTODATE TYPE='Date'>"+request.getParameter("enddate")+"</SVTODATE>\r\n");
			//xmldoc1.append("<SVMAILSERVERNAME TYPE='String'>"+request.getParameter("accountName")+"</SVMAILSERVERNAME>\r\n");
			xmldoc.append("<SVMAILAUTHUSERNAME TYPE='String'>"+request.getParameter("accountName")+"</SVMAILAUTHUSERNAME>\r\n");
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
			    //url = new URL("http://10.0.10.62:9000/");
				URLConnection conn = url.openConnection();
			    conn.setDoOutput(true);
			    conn.setReadTimeout(40*1000);
			    conn.connect();
			    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			    wr.write(xmldoc1.toString());
			    wr.flush();
			    System.out.println(xmldoc1.toString());
			    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			    String line = null;
			    while ((line = reader.readLine()) != null)
			    {
			      response2.append(line + "\n");
			      //out.println(line+"\n");
			      System.out.println(line+"\n");
			    }
			   
			}
			catch (Exception e)
			{
				System.out.println("*****/Exception-->Send Tally, Message from tally"+e.toString()+msgrec);
				e.printStackTrace();
			}
	
			  System.out.println("done");
			  System.out.println(response2.toString());
			  DocumentBuilderFactory dbf1 = DocumentBuilderFactory.newInstance();
			  DocumentBuilder db1 = dbf1.newDocumentBuilder();
			  InputSource sx1 = new InputSource(new StringReader(response2.toString()));
			  Document doc1 = db.parse(sx1);
			 
			  Element root1 = doc1.getDocumentElement();
			  NodeList nodeList = doc1.getElementsByTagName("VOUCHER");
			  
		      String printflag="Y";
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
			     		      //System.out.println("PARTYLEDGERNAME : "  + ((Node) fstNm.item(0)).getNodeValue());
			     		      
			     		      Element fstElmnt1 = (Element) node;
			    		      NodeList fstNmElmntLst1 = fstElmnt1.getElementsByTagName("VOUCHERTYPENAME");
			    		      Element fstNmElmnt2 = (Element) fstNmElmntLst1.item(0);
			    		      NodeList fstNm2 = fstNmElmnt2.getChildNodes();
			    		      mVouchertype=((Node) fstNm2.item(0)).getNodeValue();
			    		      //System.out.println("VOUCHERTYPENAME : "  + ((Node) fstNm2.item(0)).getNodeValue());
		
			    		      Element vounoElmnt = (Element) node;
			    		      NodeList vounoElmntLst = vounoElmnt.getElementsByTagName("VOUCHERNUMBER");
			    		      Element vounoElmnt1 = (Element) vounoElmntLst.item(0);
			    		      NodeList vounoNm = vounoElmnt1.getChildNodes();
			    		      mVoucherno=((Node) vounoNm.item(0)).getNodeValue();
			    		      //System.out.println("VOUCHERTYPENAME : "  + ((Node) fstNm2.item(0)).getNodeValue());
			    		      
			    		      Element fstElmnt2 = (Element) node;
			    		      NodeList fstNmElmntLst2 = fstElmnt2.getElementsByTagName("DATE");
			    		      Element fstNmElmnt3 = (Element) fstNmElmntLst2.item(0);
			    		      NodeList fstNm3 = fstNmElmnt3.getChildNodes();
			    		      mDate=((Node) fstNm3.item(0)).getNodeValue();
			    		      //mDate=mDate.substring(6,8)+"/"+mDate.substring(4,6)+"/"+mDate.substring(0,4);
			    		      //System.out.println("DATE : "  + ((Node) fstNm3.item(0)).getNodeValue());
		
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
			    		      if (mdrtemp>=-0.00 && mdrtemp<=0.00){mdrtemp=0;}
			    		      
			    		      Element fstElmnt5 = (Element) node;
			    		      NodeList fstNmElmntLst5 = fstElmnt5.getElementsByTagName("CRAMOUNT");
			    		      Element fstNmElmnt6 = (Element) fstNmElmntLst5.item(0);
			    		      NodeList fstNm6 = fstNmElmnt6.getChildNodes();
			    		      mcrAmount=((Node) fstNm6.item(0)).getNodeValue().replace(",","");
			    		      System.out.println("CRAMOUNT"+mcrAmount);
			    		      mcrtemp=Double.parseDouble(mcrAmount);
			    		      if (mcrtemp>=-0.00 && mcrtemp <=0.00){mcrtemp=0;}
			    		     %>
			  			    <tr>
			  			    <td>
			  			    <a href="<%=mVouchertype.trim()%>">
                                   <%=mVouchertype.trim()%>
						    </td>
						    <td>
                                   <%
                                                                   
                                   out.println(mDate.trim());
                                   %>
						    </td>
		   				    <td>
                                   <%=mVoucherno.trim()%>
						    </td>
						    
						    <td align="right">
						    <%
                                 out.println(df2.format(mdrtemp));
                                 mDr = mDr + mdrtemp;
                                 mopb = mopb + mdrtemp;
                                 
                              %>
						    </td>
				
						    <td align="right">
                             <%
                                 out.println(df2.format(mcrtemp));
                                 mCr = mCr + mcrtemp;
                                 mopb = mopb -mcrtemp;
                              %>
						    </td>
				
						    <td align="right">
                                   <%
                                   if (mopb < 0)
                                   {
                                	   out.println(df2.format(mopb*-1)+" Cr");
                                	   }
                                   
                                   if (mopb > 0)
                                   {
                                	   out.println(df2.format((mopb))+" Dr");
                                   }
                                   %>
						    </td>
						    <td>
                                   <%=mNarration%>
						    </td>
						    </tr>
						    <%
			    		      }
			              }
			  
		%>
		<tr>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<td align="right">
		<%
		 if (mopb < 0)
        {
     	   out.println(df2.format(mopb*-1));
           mDr = mDr + (mopb*-1);
        }
        %>
		</td>
		<td align="right">
		<%
        if (mopb > 0)
        {
     	  out.println(df2.format(mopb));
     	  mCr = mCr + (mopb);
     	}
        %>
		</td>
		<td>
		</td>
				<td>Closing Balance:
		</td>
		
		</tr>
		<tr>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		
		<td align="right">
		<%
		out.println(df2.format(mDr));
		%>
		</td>
		<td align="right">
		<%
		out.println(df2.format(mCr));
		%>
		</td>
		<td>
		</td>
		<td>
		</td>
		</tr>
		</table>
        </div>
            
            <!-- ************ ERP LEDGER **************** -->
            
            
            <!-- <div style="float:left; margin-left:3; width:1%;height:380;background-color: 	Black;"> 
            </div> -->
           <div id = "mydiv1" style="float:left;overflow:auto; width:49%;height:380; overflow-x: scroll; overflow-y: hidden;"  onscroll="divScrollL();">
           <table class="mysortable">
            <tr>
            
            <%
              tally.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD,SID,PID,CMID);
              Connection conn = null;
              Statement st = null;
              conn = tally.ReturnConnection();
  		      st = conn.createStatement();
  		      String mybegindate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("begindate")));
     	      String myenddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("enddate")));
              System.out.println(mybegindate+myenddate);
     	      String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b ON a.customercode = b.customercode where b.tallyname LIKE '%"+request.getParameter("accountName")+"%' and transactiondate between '"+mybegindate+"' and '"+myenddate+"' order by transactiondate";
  		      System.out.println(sql);
              ResultSet rs=st.executeQuery(sql);
              String myprintflag = "Y";
               %>
			  			      <th><div style="width:50; align:left" >Voucher Type</div></th>
			  			      <th><div style="width:50; align:left" >Date</div></th>
		   	  			      <th><div style="width:50; align:left" >Voucher No</div></th>
			  			      <th><div style="width:80; align:right" >Debit</div></th>
			  			      <th><div style="width:80; align:right" >Credit</div></th>
			  			      <th><div style="width:100; align:right" >Balance</div></th>
			  			      <th><div style="width:500; align:left" >Narrations</div></th>
			  			      </tr>
			  			      <tr>
			  			      <%
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
			  			    	  if (rs.getDouble("creditamount")!=0)
			  			    	  {
			  			    	       mdrAmount=rs.getString("creditamount");
			  			    	       mdrtemp=Double.parseDouble(mdrAmount);
			  			    	       mBal = mBal - mdrtemp;
			  			    	  }
			  			    	  if (rs.getDouble("debitamount")!=0)
			  			    	  {
			  			    	       mdrAmount=rs.getString("debitamount");
			  			    	       mdrtemp=Double.parseDouble(mdrAmount)*-1;
			  			    	       mBal = mBal + mdrtemp;
			  			    	  } 
			  			    	  
			  			    	  if (myprintflag == "Y")
			  			    	{
			  			    	  %>
			  			           <tr>
			  			           <td>
			  			           </td>
			  			           <td>
			  			           </td>
			  			           <td>
			  			           </td>
			  			           <td align="right">
			                       <%
		                                 if (mBal < 0)
                                         {
     	                                       out.println(df2.format(mBal*-1));
                                               mDr = mDr + (mBal*-1);
                                          }
                                     %> 			            
			  			           </td>
			  			           <td align="right">
			                       <%
		                                 if (mBal > 0)
                                         {
     	                                       out.println(df2.format(mBal));
                                               mCr = mCr + (mBal);
                                          }
                                     %> 			            
			  			           </td>
			  			           <td>
			  			           </td>
			  			           <td>
			  			           Opening Balance
			  			           </td>
			  			      
			  			           </tr>
			  			      <%
			  			        myprintflag ="N";
			  			        }
			  			    	%>
			  			         <tr>
			  			         <td>
                                 <%=mVouchertype.trim()%>
						         </td>
						         <td>
                                 <%
                                    //mDate=mDate.substring(8,10)+"/"+mDate.substring(5,7)+"/"+mDate.substring(0,4);  
                                    out.println(myDate.trim());
                                    %>
						         </td>
		   				         <td>
                                 <%=mVoucherno.trim()%>
						         </td>
						         <td align="right">
						         <%
                                 if (mdrtemp <0)
                                 {
                                       out.println(df2.format((mdrtemp*-1)));
                                       mDr = mDr + mdrtemp;
                                       mBal = mBal + mdrtemp;
                                 }
                                %>
						        </td>
				     		    <td align="right">
                                <%
                                 if (mdrtemp >=0)
                                 {
                                       out.println(df2.format(mdrtemp));
                                       mCr = mCr + mdrtemp;
                                       mBal = mBal+mdrtemp;
                                 }
                                 %>
						        </td>
				    		    <td align="right">
                                <%
                                 if (mBal > 0)
                                 {
                                       out.println(df2.format(mBal)+" Cr");
                                 }
                                 if (mBal < 0)
                                 {
                                       out.println(df2.format((mBal*-1))+" Dr");
                                 }
                                 %>
						         </td>
						         <td>
                                 <%=mNarration%>
						         </td>
						         
						         </tr>
						    <%
			  			      } 
	                         %>
		<tr>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<td align="right">
		<%
		//System.out.println(mBal);
		 if (mBal > 0)
         {
     	   out.println(df2.format(mBal));
           mDr = mDr + (mBal);
           
         }
        %>
		</td>
		<td align="right">
		<%
         if (mBal < 0)
        {
     	  out.println(df2.format(mBal*-1));
     	  mCr = mCr + (mBal*-1);
     	  }
        %>
		</td>
		<td>
		</td>
		<td>Closing Balance:
		</td>
		</tr>
		<tr>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<td align="right">
		<%
		out.println(df2.format(mDr*-1));
		%>
		</td>
		<td align="right">
		<%
		out.println(df2.format(mCr));
		%>
		</td>
		<td>
		</td>
		<td>
		</td>

		</tr>
		</table></div>
		</td>
		</tr>
		</table>
		</div>
		<%
        } 
}
        %>
       <br><br> <br><br> <br><br> <br><br>
<br><br> <br><br> <br><br> <br><br>
<br><br> <br><br> <br><br> <br><br>
<br><br> <br><br> <br><br> <br><br>
<div id="footer">
<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
</div>
</form>
</body>
</html>
</jsp:useBean>
