<%@page import="com.ConnectionClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*"
	import="moreservlets.listeners.*" errorPage=""%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />
</head>
<body>
	<%
	String description = request.getParameter("desc").toString().replaceAll("'", "");
	String incidentDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("incidentDate")));
	String dateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
	String time = request.getParameter("hrs").toString() + ":" + request.getParameter("mins").toString() + "";
	String type = request.getParameter("type");
	String category = request.getParameter("cat");
	String location = request.getParameter("location");
	String relTo = request.getParameter("relTo");
	String assetId = request.getParameter("assetId");
	String EmpNames = request.getParameter("EmpNames");
	String SelectedEmpMail = request.getParameter("SelectedEmpMail");
	%>
	<%!
	Connection con = null;
	ConnectionClass connection = new ConnectionClass();%>
	<%
	
	Statement st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null;

	try {
		con = connection.getConnect("db_leaveapplication");
		st2 = con.createStatement();
		st1 = con.createStatement();
		st3 = con.createStatement();
		st4 = con.createStatement();
		st5 = con.createStatement();
		st6 = con.createStatement();
		st7 = con.createStatement();

	} catch (Exception e) {
		e.printStackTrace();
	}
	String reportname = "";
	String empdept = "", IsWorkFromHome = "" ,PageName="",reportno="";
	PageName = PageName.substring(PageName.lastIndexOf(".") + 1, PageName.length());
	System.out.println(PageName);
	PageName = PageName.replace("_", ".");
	PageName = PageName.replace(".005f", "_");
	PageName = PageName.replace(".0020", " ");
	System.out.println("PageName   " + PageName);
	String sqlreport = "select * from t_reportnumber where PageName = '" + PageName + "'";
	 ResultSet rsreport = st1.executeQuery(sqlreport);
	if (rsreport.next()) {
		reportno = rsreport.getString("ReportNo");
		reportname = rsreport.getString("ReportName");
	}
	%>
	<%
	String CurrentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date());

	int cmpId = 0;
	System.out.println(
			"------------------------------" + EmpNames + "------------------" + SelectedEmpMail + "-------------------");

	//int cmpId=0;
	String complaintid = "";
	String s1 = "select max(complaintid) as complaintid from t_incidentdata ";
	ResultSet rs1 = st2.executeQuery(s1);
	if (rs1.next()) {
		complaintid = rs1.getString("complaintid");
	}
	try {
	/* 	String sql = "INSERT INTO  t_incidentdata (Description,TheDate,TheTime,Type,Category,spEscalation,location,relatedTo,assetId,EnteredBy,EnteredDateTime,Status) "
		+ " VALUES ('" + description + "','" + incidentDate + "','" + time + "','" + type + "','" + category + "','"
		+ EmpNames + "','" + location + "','" + relTo + "','" + assetId + "','"
		+ session.getAttribute("leaveusername") + "','" + dateTime + "','Pending')  "; */
		
		String sql="INSERT INTO  t_incidentdata (Description,TheDate,TheTime,Type,Category,spEscalation,location,relatedTo,assetId,EnteredBy,EnteredDateTime,Status) "+
				   " VALUES ('"+description+"','"+incidentDate+"','"+time+"','"+type+"','"+category+"','"+EmpNames+"','"+location+"','"+relTo+"','"+assetId+"','"+session.getAttribute("empname")+"','"+dateTime+"','Pending')  ";
		System.out.println("============>>"+sql);
		st3.executeUpdate(sql);
	//	System.out.println("============>>" + sql);
	//	st.executeUpdate(sql);
		//=====Insert into History================
		String sqlCmpid = "select max(complaintid) as complaintid from t_incidentdata";
		ResultSet rsCmp = st1.executeQuery(sqlCmpid);
		if (rsCmp.next()) {
			cmpId = rsCmp.getInt("complaintid");
			System.out.println("*********" + cmpId);
		}
/* 		String sqlHistory = "INSERT INTO  t_incidenthistory (Description,TheDateTime,Type,Category,complaintid,spEscalation,location,relatedTo,assetId,EnteredBy,EnteredDateTime,Status) "
		+ "VALUES('" + description + "','" + incidentDate + " " + time + "','" + type + "','" + category + "',"
		+ cmpId + ",'" + EmpNames + "','" + location + "','" + relTo + "','" + assetId + "','"
		+ session.getAttribute("leaveusername") + "','" + dateTime + "','Pending')"; */
		String sqlHistory="INSERT INTO  t_incidenthistory (Description,TheDateTime,Type,Category,complaintid,spEscalation,location,relatedTo,assetId,EnteredBy,EnteredDateTime,Status) "+
				   "VALUES('"+description+"','"+incidentDate+" "+time+"','"+type+"','"+category+"',"+cmpId+",'"+EmpNames+"','"+location+"','"+relTo+"','"+assetId+"','"+session.getAttribute("empname")+"','"+dateTime+"','Pending')";

		System.out.println("============>>" + sqlHistory);
		st4.executeUpdate(sqlHistory);
		System.out.println(description + " " + incidentDate + " " + time + "  " + type + "     " + category);
		DateFormat df123 = new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234 = new SimpleDateFormat("yyyy-MM-dd");
		incidentDate = df123.format(df1234.parse(incidentDate));
		Date d = new Date();
		Format d2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
		String incdReg = d2.format(d);
		String sysAdmin = "";
		String hodMail = "";
		String systAdmin = "", systHod = "";
	/* 	String sqlMail = "select a.EscSysAdmin,a.Category,b.Empemail as systMail,a.EscHOD, c.Empemail as hodMail from "
		+ "t_incidentescalation as a " + "inner join( " + "SELECT * FROM t_employee) b "
		+ "on(b.EmpID=a.EscSysAdmin) " + "left outer join( " + "select * from t_employee)c "
		+ "on(c.EmpID=a.EscHOD) " + "where a.Category='" + category + "'"; */
		String sqlMail="select a.EscSysAdmin,a.Category,b.Empemail as systMail,a.EscHOD, c.Empemail as hodMail from "+ 
				"t_incidentescalation as a "+
				"inner join( "+
				"SELECT * FROM t_employee) b "+ 
				"on(b.EmpID=a.EscSysAdmin) "+
				"left outer join( "+
				"select * from t_employee)c "+
				"on(c.EmpID=a.EscHOD) "+
				"where a.Category='"+category+"'";
		ResultSet rsMail = st5.executeQuery(sqlMail);
		if (rsMail.next()) {
			sysAdmin = rsMail.getString("systMail");
			hodMail = rsMail.getString("hodMail");
		}
		String sql1 = "";
		String Logo1 = "";
		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
		java.util.Date date = new java.util.Date();
		String Website = "http://myfleetview.com/Transworld";
		String getEmailDetails = "select * from db_gps.t_EmailReportSettings where `System`='ERP' ";
		ResultSet rs = st6.executeQuery(getEmailDetails);
		String q2 = "";
		String tocc = "r_maner@transworld-compressor.com";

		while (rs.next()) {
			Logo1 = rs.getString("Logo1");
		}
		String Data = "";
		try {
			Data = Data
			+ "<html><head><body><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"
			+ "<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^80%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"
			+ "<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"
			+ "<img src=" + Logo1
			+ " style=^height: 70px; width: 400px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td></tr></table><font style=^color: #D8D8D8^>"
			+ "________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"
			+ " <u><a href=" + Website + ">" + Website + "</a></u>&nbsp;" + df.format(date) + "<br>"
			+ " Report No:-" + reportno + "</font><table><tr><td align = center style = ^margin-left:20px;^>";
			Data = Data
			+ "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=170% border=0><tr><td align=left><font size=3 face=arial></br>New incident has been registered. </font></br></td></tr></table></td></tr>"
			+ "<tr><td><table align=left  cellpadding=10 cellspacing=5 width=100% border=1 style=^border-collapse: collapse^>"
			+ "<tr bgcolor=^#ADDFFF^><td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Complaint ID  </b></font></td>"
			+ "<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b>  Incident Time </b></font></td>"
			+ "<td align=center style=^width: 8%;^><font size=^2^ face=^arial^><b> Incident Registered </b></font></td>"
			+ "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Incident Description  </b></font></td>"
			+ "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Incident Category  </b></font></td>"
			+ "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Location </b></font></td>"
			+ "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Type </b></font></td>"
			+ "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Related To </b></font></td>"
			+ "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Registered By </b></font></td>";

			Data = Data + "<tr><td align=right><font size=^2^ face=^arial^>" + cmpId + "</font></td>"
			+ "<td align=right><font size=^2^ face=^arial^>" + incidentDate
			+ "</font><br><font size=^2^ face=^arial^>" + time + "</font></td>"
			+ "<td align=right><font size=^2^ face=^arial^>" + incdReg + "</font></td>"
			+ "<td align=left><font size=^2^ face=^arial^>" + description + "</font></td>"
			+ "<td align=left><font size=^2^ face=^arial^>" + category + "</font></td>"
			+ "<td align=left><font size=^2^ face=^arial^>" + location + "</font></td>"
			+ "<td align=left><font size=^2^ face=^arial^>" + type + "</font></td>"
			+ "<td align=left><font size=^2^ face=^arial^>" + relTo + "</font></td>"
			+ "<td align=left><font size=^2^ face=^arial^>" + session.getAttribute("leaveusername")
			+ "</font></td>";
			Data = Data + "</tr></table><br/></br>";
			Data = Data + "</br></br></br></br></br>";
			Data = Data
			+ "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr><td><font size=^3^ face=^Arial^>Email: avlsupport@mobile-eye.in</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Copyright @2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
			String subject = "Incident " + cmpId + " on " + df.format(date) + ".";
			q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('Incident Details','Mail for Incident Report','"
					+ Data
					+ "','"
					+ subject
					+ "','"
					+ session.getAttribute("email").toString()
					+ "','"
					+ tocc+","+SelectedEmpMail
					+ "','"
					+ CurrentDate + "','Pending','Transworld')";

			System.out.println("Tocc is" + tocc + "," + SelectedEmpMail);
			System.out.println("q2All_PendingMail>>>> :" + q2);
			st7.executeUpdate(q2);
			System.out.println("inserted in all pending mail >>> 1234");
			try {

		System.out.println("Your message has been sent");
			} catch (Exception e) {
		System.out.print("Exception----->" + e);

			}

		} catch (Exception e) {
			System.out.println("Sorry, your mail cannot be sent due to Congestion----->" + e);
		}

	} catch (Exception e1) {
		System.out.println("Exception generateIncident.jsp------>>" + e1);
	}
	response.sendRedirect("alertGoTo.jsp?msg=Incident saved and mail sent successfully  &goto=incidentDataReport.jsp");
	%>
</body>
</html>