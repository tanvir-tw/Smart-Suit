<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@include file="header.jsp"%>
<%@page import="java.net.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.*"%>
<%@page import="org.xml.sax.InputSource"%>

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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Tally Reports</title>
</head>
<body>
	<%
	String CMID=session.getAttribute("CompanyMasterID").toString();
	String SID=session.getAttribute("TallySID").toString();
	String PID=session.getAttribute("TallyPID").toString();
	        DecimalFormat df2 = new DecimalFormat( "0.00" );
	        String todaydate="";
	        todaydate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	        String msgrec=null;
            String Reportname="rptbankbal";
            String localipAddress =request.getRemoteAddr(); 
            //String ipAddress = "192.168.1.109";
            //String ipAddress = "219.64.93.243";
             // String ipAddress = "115.112.36.134";
             ///String ipAddress = "219.64.202.76";
            String Connected = tally.connectTallyserver(SID,PID);
            StringBuilder xmldoc = new StringBuilder();
            xmldoc.append("<ENVELOPE>\r\n");
		    xmldoc.append("<HEADER>\r\n");
		    xmldoc.append("<TALLYREQUEST>Export Data</TALLYREQUEST>\r\n");
		    xmldoc.append("</HEADER>\r\n");
		    xmldoc.append("<BODY>\r\n");
	    	xmldoc.append("<EXPORTDATA>\r\n");
			xmldoc.append("<REQUESTDESC>\r\n");
			xmldoc.append("<REPORTNAME>rptbankbal</REPORTNAME>\r\n");
			xmldoc.append("<STATICVARIABLES>\r\n");  
			xmldoc.append("<EXPLODEFLAG>Yes</EXPLODEFLAG>\r\n");
			xmldoc.append("<SVEXPORTFORMAT>$$SysName:XML</SVEXPORTFORMAT>\r\n");
			xmldoc.append("<SVCURRENTCOMPANY>TRANSWORLD COMPRESSOR TECHNOL</SVCURRENTCOMPANY>\r\n");
			xmldoc.append("<SVFROMDATE TYPE='Date'>"+todaydate+"</SVFROMDATE>\r\n");
			xmldoc.append("<SVTODATE TYPE='Date'>"+todaydate+"</SVTODATE>\r\n");
			//xmldoc.append("<SVMAILAUTHUSERNAME TYPE='String'>"+request.getParameter("accountName")+"</SVMAILAUTHUSERNAME>\r\n");
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
			      //System.out.println(line+"\n");
			    }
			   
			}
			catch (Exception e)
			{
				System.out.println("*****/Exception-->Send Tally, Message from tally"+e.toString()+msgrec);
				e.printStackTrace();
			}
            //out.println("done:"+response1.toString());
              System.out.println("done:"+response1.toString());
              DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			  DocumentBuilder db = dbf.newDocumentBuilder();
			  InputSource sx = new InputSource(new StringReader(response1.toString()));
			  Document doc = db.parse(sx);
			  Element root = doc.getDocumentElement();
			  NodeList accountnodeList = doc.getElementsByTagName("MYACCOUNT");
			  String accountname= null;
			  String drclosingbalance = null;
			  String crclosingbalance = null;
			  double totaldr = 0;
			  double totalcr = 0;
			  double mdr = 0;
			  double mcr = 0;
			  %>
			  <div id = "mydiv" style="float:left; overflow:auto; width:60%;height:20; margin-left:10%; margin-top: 10;">
			  <table class="mysortable" style="align:center">
			  <tr>
			  <h3>List of Closing Bank Balances as on : <%=todaydate%></h3>
			  </tr>
			  </table>
			  </div>
			  <div id = "mydiv" style="float:left; overflow:auto; width:60%;height:380; margin-left: 10%; ">
			  <table  class="mysortable">
			  <tr>
			  <th><div style="align:left;width:300;">Bank Name</div></th>
			  <th><div style="align:right;width:100;">Debit Balance</div></th>
			  <th><div style="align:right;width:100;">Credit Balance</div></th>
			  </tr>
			  <%
			  for (int i = 0; i < accountnodeList.getLength(); i++)
			  {
			               Node accountnode = accountnodeList.item(i);
			               mdr = 0;
			               mcr = 0;
			               
			               if (accountnode.getNodeType() == Node.ELEMENT_NODE) 
			               {
			     		      
			            	  Element account = (Element) accountnode;//  node;
				     		  NodeList accountLst = account.getElementsByTagName("ACCOUNTNAME");
				     		  Element accountElmnt = (Element) accountLst.item(0);
				    		  NodeList accountNm = accountElmnt.getChildNodes();
				    		  accountname=((Node) accountNm.item(0)).getNodeValue();
				    		  System.out.println("Accountname"+accountname);
			            	  
				    		  Element crclgblg = (Element) accountnode;//  node;
			     		      NodeList crclgblgLst = crclgblg.getElementsByTagName("CRCLOSINGBALANCE");
			     		      Element crclgblgElmnt = (Element) crclgblgLst.item(0);
			     		      NodeList crclgblgNm = crclgblgElmnt.getChildNodes();
			    		      crclosingbalance=((Node) crclgblgNm.item(0)).getNodeValue().replace(",","");
			    		      System.out.println("CROPENINGBALANCE"+crclosingbalance);
			    	        
			    		      if (crclosingbalance!=null || crclosingbalance!="0.00" || crclosingbalance!="0")
			    			  {
			    				   mcr=Double.parseDouble(crclosingbalance);
			    			  }
			    		       
			    		      Element drclgblg = (Element) accountnode;//  node;
			            	  NodeList drclgblgLst = drclgblg.getElementsByTagName("DRCLOSINGBALANCE");
			     		      Element drclgblgElmnt = (Element) drclgblgLst.item(0);
			     		      NodeList drclgblgNm = drclgblgElmnt.getChildNodes();
			    		      drclosingbalance=((Node) drclgblgNm.item(0)).getNodeValue().replace(",","");
			    		      System.out.println("DRCLOSINGBALANCE"+drclosingbalance);
			    		    
			    		      if (drclosingbalance!=null || drclosingbalance!="0.00" || drclosingbalance!="0")
			    			  {
			    				   mdr=Double.parseDouble(drclosingbalance);
			    			  }
			    		     
			               }
			               if (mdr !=0 || mcr !=0)
			               {
			            	   totaldr = totaldr + mdr;
			            	   totalcr = totalcr + mcr;
			               %>
			               <tr>
			               <td align="left">
			               <%=accountname %>
			               </td>
			               <td align="right">
			               <%=(drclosingbalance) %>
			               </td>
			               <td align="right">
			               <%=(crclosingbalance) %>
			               </td>
			               
			               </tr>
			               <%
			               }
			  }
			%>
			<tr>
			<td align="right">Totals:</td>
			<td align="right">
			<%
			df2.format(totaldr); 
			%>
			</td>
			<td align="right">
			<%=df2.format(totalcr) %>
			</td></tr>
			<tr>
			<td colspan="3" align="center">
			<strong >Net Balance :<%=df2.format((totalcr-totaldr))%></strong>
			</td>
			</tr>
			</table>
			</div>
			<br><br> <br><br> <br><br> <br><br>
<br><br> <br><br> <br><br> <br><br>
<br><br> <br><br> <br><br> <br><br>
<br><br> <br><br> <br><br> <br><br>
<div id="footer">
<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
            
</body>
</html>
</jsp:useBean>
