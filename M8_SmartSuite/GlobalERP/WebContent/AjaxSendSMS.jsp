
<%@page import="java.io.Flushable"%>

<%@ include file="conn.jsp"%>
<%@page import="java.net.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%
	Connection con1 = null;
	String msgid = null, sms = "", numbers = session.getAttribute("EmpMobileNumber").toString();
	numbers="9595085385";
 String contact=request.getParameter("contactPerson"),company=request.getParameter("companyName"),city=request.getParameter("companyCity");
 String email=request.getParameter("companyEmail"),product=request.getParameter("companyProduct"),phone=request.getParameter("companyPhone");
String extraMobileNos="";
 if(request.getParameter("ExtraMobileNos")!=null)
	extraMobileNos= request.getParameter("ExtraMobileNos");
 sms=company+",\n"+contact+",\n"+phone+",\n"+product+",\n"+city;
 System.out.println("sms der  "+sms);
	try {
		if (company == null
				|| company.equalsIgnoreCase("")) {
			out.println("Please Select Customer");
		} else {
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
					+ numbers + "&message=" + sms + "&gateway=premium";
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
			String buffer = "VISITING CARD  SENT TO  "
					+ session.getAttribute("EmpName") + " ("+numbers+")";

			out.println(buffer);
			buffer = null;

			
		}
	} catch (Exception e) {
		System.out.println(e);
		out.println("SMS Sending Failed("+numbers+")");
	} finally {
		con1.close();
	}
%>
