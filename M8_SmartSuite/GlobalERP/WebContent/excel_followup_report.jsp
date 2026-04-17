<%@ page contentType="application/vnd.ms-excel; charset=gb2312"
	import="java.sql.*" import="java.text.*"%>
<%@page import="java.util.Date"%>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename;
	filename = showdatex + "_Follow_Up_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="
			+ filename);
%>
<%@ include file="conn1.jsp"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>

	<%
		Connection conn = null;
			Statement st = null, st1 = null;
			Statement st2 = null;
			String FollowUpType = "";
			Format format = new SimpleDateFormat("dd-MMM-yyyy");
			Format parse = new SimpleDateFormat("yyyy-MM-dd");
			String fromDate = request.getParameter("fromDate"), toDate = request
					.getParameter("toDate");
			String selectedName = request.getParameter("rep");
			System.out.println(fromDate + toDate + selectedName);
			String sqlDetails = "";

			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
	
	%>
	<table>
		<tr>
			<td colspan="10">FOLLOW UP REPORT From <%=new SimpleDateFormat("dd-MMM-yyyy")
								.format(new SimpleDateFormat("yyyy-MM-dd")
										.parse(fromDate))%> To <%=new SimpleDateFormat("dd-MMM-yyyy")
								.format(new SimpleDateFormat("yyyy-MM-dd")
										.parse(toDate))%></td>
		</tr>
		<tr>
			<th>Sr.No</th>
			<%
				if ((session.getAttribute("userLevel").toString()
							.equalsIgnoreCase("level5"))) {
			%>
			<th>Sign</th>
			<%
				}
			%>
			<th>Company</th>
			<th>Contact Person</th>
			<th>Follow-Up Date</th>
			<th>Status</th>
			<th>Comments</th>
			<th>Follow-Up Type</th>
			<th>Next Follow Up Date</th>
			<th>Payment Follow-Up</th>
			<th>Reply</th>

		</tr>

		<%
			sqlDetails = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup  WHERE MarketingRepCode='"
						+ session.getAttribute("EmpCode")
						+ "' AND FollowUpDate BETWEEN '"
						+ fromDate
						+ "' AND '"
						+ toDate + "' ";

				if ("All".equalsIgnoreCase(selectedName)
						&& session.getAttribute("userLevel").toString()
								.equalsIgnoreCase("level5"))
					sqlDetails = "   SELECT a.*,b.MarketingRepName FROM("
							+ " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE FollowUpDate BETWEEN '"
							+ fromDate
							+ "' AND '"
							+ toDate
							+ "')AS a   "
							+ " LEFT OUTER JOIN (select MarketingRepName,MarketingRepCode  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  )as b "
							+ " on (a.MarketingRepCode=b.MarketingRepCode)";
				else if (session.getAttribute("userLevel").toString()
						.equalsIgnoreCase("level5"))
					sqlDetails = "   SELECT a.*,b.MarketingRepName FROM("
							+ " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup WHERE MarketingRepCode='"
							+ selectedName
							+ "' AND FollowUpDate BETWEEN '"
							+ fromDate
							+ "' AND '"
							+ toDate
							+ "')AS a   "
							+ " LEFT OUTER JOIN (select MarketingRepName,MarketingRepCode  from "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster  )as b "
							+ " on (a.MarketingRepCode=b.MarketingRepCode)";
				else
					sqlDetails = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup  WHERE MarketingRepCode='"
							+ session.getAttribute("EmpCode").toString()
							+ "'  AND FollowUpDate BETWEEN '"
							+ fromDate
							+ "' AND '" + toDate + "' ";
				int i = 1;
				ResultSet rsDetails = st1.executeQuery(sqlDetails);
				while (rsDetails.next()) {
					
					
					String follow_up_date=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsDetails.getString("FollowUpDate")));
					follow_up_date+=" "+(rsDetails.getString("FollowUpTime"));
					String next_follow_up_date=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
							(rsDetails.getString("NextFollowUpDate")));
					next_follow_up_date+=" "+(rsDetails.getString("NextFollowUpTime"));
					System.out.println("fffff"+follow_up_date+" nnnnnnnnn"+next_follow_up_date);
		%>
		<tr>
			<td align="left">
			<div align="left"><%=i++%></div>
			</td>
			<%
				if ((session.getAttribute("userLevel").toString()
								.equalsIgnoreCase("level5"))) {
			%>
			<td align="left">
			<div align="left"><%=rsDetails.getString("MarketingRepName")%></div>
			</td>
			<%
				}
			%>
			<td align="left">
			<div align="left"><%=rsDetails.getString("ProspCustName")%></div>
			</td>
			<td>
			<div align="left"><%=rsDetails.getString("ContactPerson")%></div>
			</td>
			<td>
			<div align="left"><%=follow_up_date%></div>
			</td>
			<td>
			<div align="left"><%=rsDetails.getString("Status")%></div>
			</td>
			<td>
			<div align="left"><%=rsDetails.getString("Comments")%></div>
			</td>
			<td>
			<div align="left"><%=rsDetails.getString("FollowUpType")%></div>
			</td>
			<td>
			<div align="left"><%=next_follow_up_date%></div>
			</td>
			<td>
			<div align="left"><%=rsDetails.getString("PaymentFollowup")%></div>
			</td>
			<td>
			<div align="left"><%=rsDetails.getString("Reply")%></div>
			</td>

		</tr>
		<%
			}
				if (i == 1) {
		%>
		<tr>
			<td colspan="11" align="center"><b></b></td>
		</tr>
		<tr>
			<td colspan="11" align="center"><b>--- NO DATA ---</b></td>
		</tr>
		<%
			}
} catch (Exception e) {
	out.print("!!!Connection Lost!!!");
	}
	finally{
		conn.close();
	}
		%>
	</table>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
</jsp:useBean>
