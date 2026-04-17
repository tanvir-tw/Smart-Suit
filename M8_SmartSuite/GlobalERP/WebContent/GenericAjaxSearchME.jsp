
<%@ include file="conn.jsp"%>

<%!Connection con;%>
<%
	try {
		Class.forName(DB_Driver);
		con = DriverManager.getConnection(DB_NAME, DB_USERNAME,
				DB_PASSWORD);
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String sql = "";
		String emp = request.getParameter("emp");
		String id = request.getParameter("id");
		String empName="",email="";
		//sql = "SELECT DISTINCT(MarketingRepName),MarketingRepEMail FROM "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  WHERE username<>'' and password<>'' and MarketingRepName LIKE('%"+ emp + "%') and (Compressor=1 or DigitalEquipment=1 or DGSet=1 or Endoscope=1 or OtherGroups=1) ORDER BY MarketingRepName LIMIT 20 ";
		sql = "SELECT DISTINCT(EmpName),email FROM "+session.getAttribute("CompanyMasterID").toString()+"security WHERE ActiveStatus='Yes' and EmpName LIKE('%"+ emp + "%')  ORDER BY EmpName  ";
		
		rs = stmt.executeQuery(sql);
		//System.out.println("sql query--------" + sql);
		String buffer = "<div style='height:120px;width:400px;overflow:auto; '><table style='background-color:white; width:400px; display: block';>";
		int i = 1;
		while (rs.next()) {
			empName=rs.getString("EmpName");
			email=rs.getString("email");
			buffer += "<tr><td><a href='#' onClick='showVisitingCardDetails(\""
					+ rs.getString("EmpName")
					+ "\",\""
					+ rs.getString("email")
					+ "\",\""+id
					+ "\");'  style='color: blue;'>"
					+ rs.getString("EmpName").replaceAll(
							"(?i)" + emp,
							"<font color=blue><u>" + emp.toUpperCase()
									+ "</u></font>")
					+ ".</a></td></tr>";
			i++;
		}
		buffer += "</table></div>";
		out.println(buffer);
	} catch (Exception e) {
		System.out
				.println("!!!ERROR!!!  GenericAjaxSearchME  ::  " + e);
	} finally {
		con.close();
	}
%>
