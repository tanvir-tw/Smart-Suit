<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>

<%@page import="java.io.Flushable"%>

<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	<script language="JavaScript1.2">

	function validate()
	{
		var numericExpression = /^[0-9]+$/;
 

	  	if(!(document.sendSMS.ExtraMobileNos.value.match(numericExpression)) && document.sendSMS.ExtraMobileNos.value!="") 
	  	{
		  	alert("Mobile Number has to be Numeric");
	  		document.sendSMS.ExtraMobileNos.value=document.sendSMS.ExtraMobileNos.value.substring(0, document.sendSMS.ExtraMobileNos.value.length-1);
			return false;
		} 
		return true;
	}
	
	function newwindow(webadd)
	{ 
		window.open(webadd,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}
	</script>
	</head>
	<body>

	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null;
			 String contact=request.getParameter("contactPerson"),company=request.getParameter("companyName"),city=request.getParameter("companyCity");
			 String email=request.getParameter("companyEmail"),product=request.getParameter("companyProduct"),phone=request.getParameter("companyPhone");
			 System.out.println(company+",\n"+contact+",\n ph  "+phone+",\n"+product+",\n"+city);
	%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em; background-color: #339CCB">.
	</div>


	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em;">
	SMS Visiting Card of <a><%=request.getParameter("companyName")%></a></div>
 <% if(request.getParameter("flag")==null){%>
<form name="sendSMS" action="" method="get" onSubmit="return validate();">
	
	<table>

 
<tr>
<td></td>
<td>	 
</td>
</tr>

		<tr>
			<td valign="top"><b>To : </b></td>

			<td>
			<table>
 <tr><td>
<font size="2"> <input type="hidden" name ="companyName" value="<%=company %>" /></font>
  <input type="hidden" name ="companyPhone" value="<%=phone %>" />
   <input type="hidden" name ="companyEmail" value="<%=email %>" />
    <input type="hidden" name ="companyCity" value="<%=city %>" />
 <input type="hidden" name ="companyProduct" value="<%=product %>" />
  <input type="hidden" name ="contactPerson" value="<%=contact %>" />
    <input type="hidden" name ="flag" value="true" />
</td> </tr>
 
				<tr>
					<td >  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
					<%=session.getAttribute("EmpName") %></td>
					<td valign="top"><input type="text" name="userMob" rows="1" id="search-text"
						style='border-style: none; width: 200px; height: auto;'>(<%=session.getAttribute("EmpMobileNumber")%>)
					</td>
				</tr><!--  -->
				<tr><td></td>
				<td><a href="#"  onclick="newwindow('editMobileNumber.jsp');">
				Click Here to Edit your Mob No.</a></td>
				</tr>
			</table>
			</td>
			
			<!-- <td><textarea name="companyEmail" rows="1" id="search-text"
				style='border-style: none; width: 200px; height: auto;'>< %=request.getParameter("email") %></textarea>
			</td>  -->
		</tr>
 
		<tr>
			<td><br>
			</td>
		</tr>
		<tr>
			<td><b>Add extra mobile Nos</b><br><br>Note: Add (,) seperated numbers for more than one recipient
			</td>
			<td><textarea name="ExtraMobileNos" rows="2" id="search-text"
				style='width: 200px; height: auto;' ></textarea></td>
		</tr>
 
		<tr>

		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"><input type="submit" value="Send"  /> &nbsp;&nbsp;&nbsp;
			<input type="reset" value="Clear" />&nbsp;&nbsp;&nbsp;
			<input type="button" value="Cancel" onclick="window.close()"/>
			</td>
			
		</tr>
 
	</table>


	</form>
	
	<% 
 }
	if(request.getParameter("ExtraMobileNos")!=null){
		String extraMobileNos=null;
		extraMobileNos= request.getParameter("ExtraMobileNos");
		Connection con1 = null;
		String msgid = null, sms = "", numbers = session.getAttribute("EmpMobileNumber").toString();
		if(numbers.length()>12) {
			numbers="";
		}
		else numbers+=",";
		
		numbers+=extraMobileNos;
		

		
		
	 sms=company+",\n"+contact+",\n"+phone+",\n"+product+",\n"+city;
	 System.out.println("-----"+"sms det  "+sms);
		try {
 
				Class.forName(DB_Driver);
				con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,
						DB_PASSWORD);
				Statement stmt1 = con1.createStatement();
				ResultSet rs1 = null;
				String sql1 = "";
				boolean flag = false;

				sms = sms.replace("'", " ");
				sms = sms.replace(";", " ");
				sms = sms.replace("&", " ");
				sms = sms.replace("@", " ");
				sms = sms.replace("<>", " ");
				sms = sms.replace("[", " ");
				sms = sms.replace("]", " ");
				sms = URLEncoder.encode(sms);

				String smsurl = null;

				smsurl = "http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=TransWld&to="
						+ numbers + "&message=" + sms + "&gateway=regular";
				System.out.println("||||||||||||||||||||||||||||||||||||||||||||||||||||   "+smsurl);
				URL url = new URL(smsurl);
				URLConnection connection = url.openConnection();
				connection.connect();
				BufferedReader in = new BufferedReader(
						new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = in.readLine()) != null) {
					System.out.println(line);
					msgid = line;
				}
				String buffer = "         VISITING CARD  SENT TO  "
					  + " ("+numbers+")";

				out.println(buffer);
				buffer = null;
				try{
					stmt1.executeUpdate("INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"smshistory (SentBy,Msg,DateTime ) VALUES('"+session.getAttribute("EmpName")+"','"+sms.replace("+"," ")+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')");
				}catch(Exception ee){
					System.out.println("excep in save to t_smshistory"+ee);
				}

				con1.close();
			 
		} catch (Exception e) {
			System.out.println(e);
			out.println("SMS Sending Failed("+numbers+")");
		} finally {

		}
	%><div align="center">
	<input type="hidden" name="flagSMS" value="true" />
	<input type="button" value="Close" onclick="window.close()"/></div>
	<%
		
	} %>

	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em; background-color: #339CCB">.
	</div>
	<br></br>





	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<%@include file="footer_new.jsp"%> 
	</div>
	</body>
	</html>
</jsp:useBean>




















<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>

<%@page import="java.io.Flushable"%>

<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>


	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>


	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	<script language="JavaScript1.2">

	function validate()
	{
		var numericExpression = /^[0-9]+$/;
 

	  	if(!(document.sendSMS.ExtraMobileNos.value.match(numericExpression)) && document.sendSMS.ExtraMobileNos.value!="") 
	  	{
		  	alert("Mobile Number has to be Numeric");
	  		document.sendSMS.ExtraMobileNos.value=document.sendSMS.ExtraMobileNos.value.substring(0, document.sendSMS.ExtraMobileNos.value.length-1);
			return false;
		} 
		return true;
	}
	
	function newwindow(webadd)
	{ 
		window.open(webadd,'jav','width=470,height=500,top=250,left=600,resizable=no');
	}
	</script>
	</head>
	<body>

	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null;
			 String contact=request.getParameter("contactPerson"),company=request.getParameter("companyName"),city=request.getParameter("companyCity");
			 String email=request.getParameter("companyEmail"),product=request.getParameter("companyProduct"),phone=request.getParameter("companyPhone");
			 System.out.println(company+",\n"+contact+",\n ph  "+phone+",\n"+product+",\n"+city);
	%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em; background-color: #339CCB">.
	</div>


	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em;">
	SMS Visiting Card of <a><%=request.getParameter("companyName")%></a></div>
 <% if(request.getParameter("flag")==null){%>
<form name="sendSMS" action="" method="get" onSubmit="return validate();">
	
	<table>

 
<tr>
<td></td>
<td>	 
</td>
</tr>

		<tr>
			<td valign="top"><b>To : </b></td>

			<td>
			<table>
 <tr><td>
 <input type="hidden" name ="companyName" value="<%=company %>" />
  <input type="hidden" name ="companyPhone" value="<%=phone %>" />
   <input type="hidden" name ="companyEmail" value="<%=email %>" />
    <input type="hidden" name ="companyCity" value="<%=city %>" />
 <input type="hidden" name ="companyProduct" value="<%=product %>" />
  <input type="hidden" name ="contactPerson" value="<%=contact %>" />
    <input type="hidden" name ="flag" value="true" />
</td> </tr>
 
				<tr>
					<td > 
					<%=session.getAttribute("EmpName") %></td>
					<td valign="top"><textarea name="userMob" rows="1" id="search-text"
						style='border-style: none; width: 200px; height: auto;'>(<%=session.getAttribute("EmpMobileNumber")%>)</textarea>
					</td>
				</tr><!--  -->
				<tr><td></td>
				<td><a href="#"  onclick="newwindow('editMobileNumber.jsp');">
				Click Here to add/edit your Mob no</a></td>
				</tr>
			</table>
			</td>
			<!-- 
			<td><textarea name="companyEmail" rows="1" id="search-text"
				style='border-style: none; width: 200px; height: auto;'>< %=request.getParameter("email") %></textarea>
			</td> -->
		</tr>
 
		<tr>
			<td><br>
			</td>
		</tr>
		<tr>
			<td><b>Add extra mobile Nos</b><br><br>Note: Add (,) seperated numbers for more than one recipient
			</td>
			<td><textarea name="ExtraMobileNos" rows="2" id="search-text"
				style='width: 200px; height: auto;' ></textarea></td>
		</tr>
 
		<tr>

		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"><input type="submit" value="Send"  /> &nbsp;&nbsp;&nbsp;
			<input type="reset" value="Clear" />&nbsp;&nbsp;&nbsp;
			<input type="button" value="Cancel" onclick="window.close()"/>
			</td>
			
		</tr>
 
	</table>


	</form>
	
	<% 
 }
	if(request.getParameter("ExtraMobileNos")!=null){
		String extraMobileNos=null;
		extraMobileNos= request.getParameter("ExtraMobileNos");
		Connection con1 = null;
		String msgid = null, sms = "", numbers = session.getAttribute("EmpMobileNumber").toString();
		if(numbers.length()>12) {
			numbers="";
		}
		else numbers+=",";
		
		numbers+=extraMobileNos;
		

		
		
	 sms=company+",\n"+contact+",\n"+phone+",\n"+product+",\n"+city;
	 System.out.println("-----"+"sms det  "+sms);
		try {
 
				Class.forName(DB_Driver);
				con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,
						DB_PASSWORD);
				Statement stmt1 = con1.createStatement();
				ResultSet rs1 = null;
				String sql1 = "";
				boolean flag = false;

				sms = sms.replace("'", " ");
				sms = sms.replace(";", " ");
				sms = sms.replace("&", " ");
				sms = sms.replace("@", " ");
				sms = sms.replace("<>", " ");
				sms = sms.replace("[", " ");
				sms = sms.replace("]", " ");
				sms = URLEncoder.encode(sms);

				String smsurl = null;

				smsurl = "http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=TransWld&to="
						+ numbers + "&message=" + sms + "&gateway=regular";
				System.out.println("||||||||||||||||||||||||||||||||||||||||||||||||||||   "+smsurl);
				URL url = new URL(smsurl);
				URLConnection connection = url.openConnection();
				connection.connect();
				BufferedReader in = new BufferedReader(
						new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = in.readLine()) != null) {
					System.out.println(line);
					msgid = line;
				}
				String buffer = "         VISITING CARD  SENT TO  "
					  + " ("+numbers+")";

				out.println(buffer);
				buffer = null;
				try{
					stmt1.executeUpdate("INSERT INTO "+session.getAttribute("CompanyMasterID").toString()+"smshistory (SentBy,Msg,DateTime ) VALUES('"+session.getAttribute("EmpName")+"','"+sms.replace("+"," ")+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')");
				}catch(Exception ee){
					System.out.println("excep in save to t_smshistory"+ee);
				}

				con1.close();
			 
		} catch (Exception e) {
			System.out.println(e);
			out.println("SMS Sending Failed("+numbers+")");
		} finally {

		}
	%><div align="center">
	<input type="hidden" name="flagSMS" value="true" />
	<input type="button" value="Close" onclick="window.close()"/></div>
	<%
		
	} %>

	<div align="center"
		style="font-size: 1.5em; margin-top: 1.0em; margin-bottom: 1.0em; background-color: #339CCB">.
	</div>
	<br></br>





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
</jsp:useBean> --%>