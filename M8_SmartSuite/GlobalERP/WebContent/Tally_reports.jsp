<%@page import="java.io.*" import="java.sql.*" %>
<%@page import="java.text.*"%>
<%@ include file="header.jsp"%>

<%@page import="java.net.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.*"%>
<%@page import="org.xml.sax.InputSource;"%>

<jsp:useBean id="tally" class="com.tally.beans.TALLY" scope="page">

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
            String Reportname=null;
            if (request.getQueryString()!=null)
            {
               Reportname= request.getQueryString();// "Trial Balance";
               if (Reportname.contains("Trial_balance"))
               {
            	   Reportname="Trial Balance";
               }
               if (Reportname.contains("Balance_sheet"))
               {
            	   Reportname="Balance Sheet";
               }
               if (Reportname.contains("Day_book"))
               {
            	   Reportname="Day Book";
               }
               if (Reportname.contains("Ratio_analysis"))
               {
            	   Reportname="Ratio Analysis";
               }
               //out.println(Reportname);
            }
           
            String localipAddress =request.getRemoteAddr(); 
            //String ipAddress = "219.64.93.243";
            //String ipAddress = "219.64.202.76";
            //String ipAddress = "192.168.1.109";
           // String ipAddress = "115.112.36.134";
            String Connected = tally.connectTallyserver(SID, PID);
            //String Connected = tally.connectTallyserver(localipAddress);
	    	StringBuilder xmldoc = new StringBuilder();
	    	xmldoc.append("<ENVELOPE>\r\n");
	    	xmldoc.append("<HEADER>\r\n");
			//xmldoc.append("<VERSION>1</VERSION>\r\n");
			xmldoc.append("<TALLYREQUEST>Export Data</TALLYREQUEST>\r\n");
			xmldoc.append("</HEADER>\r\n");
			xmldoc.append("<BODY>\r\n");
	    	xmldoc.append("<EXPORTDATA>\r\n");
            xmldoc.append("<REQUESTDESC>\r\n");
            xmldoc.append("<REPORTNAME>"+Reportname+"</REPORTNAME>\r\n");
			xmldoc.append("<STATICVARIABLES>\r\n");
			xmldoc.append("<EXPLODEFLAG>Yes</EXPLODEFLAG>\r\n");
			xmldoc.append("<SVEXPORTFORMAT>$$SysName:HTML</SVEXPORTFORMAT>\r\n");
			xmldoc.append("<SVCURRENTCOMPANY>TRANSWORLD COMPRESSOR TECHNOL</SVCURRENTCOMPANY>\r\n");
			//xmldoc.append("<SVCURRENTCOMPANY>New Company</SVCURRENTCOMPANY>\r\n");
			
			xmldoc.append("</STATICVARIABLES>\r\n");
			xmldoc.append("</REQUESTDESC>\r\n");
			xmldoc.append("</EXPORTDATA>\r\n");
            xmldoc.append("</BODY>\r\n");
			xmldoc.append("</ENVELOPE>\r\n");
			
			StringBuilder response1 = new StringBuilder();
			String msgrec=null;
			try
			{
				URL url=null;
			    url = new URL("http://"+SID+":"+PID+"/");
			    //url = new URL("http://10.0.10.62:9000/");
				URLConnection conn = url.openConnection();
			    conn.setDoOutput(true);
			    conn.setReadTimeout(15*1000);
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
			    }
			    %>
			    <table style="margin-left:10;margin-top:20;width:100%">
			    <tr ></tr>
			    <tr>
			    <td style="width:10%"></td>
			    <td>
			           <%out.println(response1.toString());
			           System.out.println(response1.toString());%>
			    </td>
			    </tr>
			    </table>
			    <%
			    }
			catch (Exception e)
			{
				System.out.println("*****/Exception-->Send Tally, Message from tally"+e.toString()+msgrec);
				e.printStackTrace();
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
