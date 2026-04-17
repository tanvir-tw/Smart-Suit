<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%
	Connection con1 = null;
%>
<%
String buffer = "";
	try {
		Class.forName(DB_Driver);
		con1 = DriverManager.getConnection(DB_NAME, DB_USERNAME,
				DB_PASSWORD);
		Statement stmt1 = con1.createStatement();
		Statement st1 = con1.createStatement();
		
		ResultSet rs1 = null;
		
		String repname=request.getParameter("repname");
		

		String sql="Update "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
		  " SET Compressor=0,DigitalEquipment=0,DGSet=0,Endoscope=0,OtherGroups=0"+
		  " where MarketingRepName='"+repname+"' limit 1";
		System.out.println(sql);
		st1.executeUpdate(sql);
		
		
		String sql1="Update "+session.getAttribute("CompanyMasterID").toString()+"security "+
					" Set ActiveStatus='No' "+
					" where EmpName='"+repname+"' limit 1";
		System.out.println(sql1);
		stmt1.executeUpdate(sql1);
		
		buffer="Yes";
	
	} catch (Exception e) {
		System.out.println("insert sales enq in tmp table > "+e);
		buffer="No";
	} finally {
		con1.close();
	}
%>

		

		
		
		
		
		
	