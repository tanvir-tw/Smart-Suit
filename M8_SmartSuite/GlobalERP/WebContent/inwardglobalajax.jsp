<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ConnectionClass"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.sql.*"%>


<%
	boolean ex = false;
Statement stmt1 = null,stmt2 = null,stmt3 = null,stmt4 = null;
Connection con1= null;
ConnectionClass connnection = new ConnectionClass();
ResultSet rs_pi1 = null;
ResultSet rs_pi2 = null;
ResultSet rs1 = null, rs_po = null, rs2 = null;
String sql1 = "", sql2 = "";

System.out.println("reach Ajax page");
	try {

		con1 = connnection.getConnect("db_leaveapplication");
		stmt1 = con1.createStatement();
		stmt2 = con1.createStatement();
		stmt3 = con1.createStatement();
		stmt4 = con1.createStatement();
	
		
		boolean flag = false;
		String A = request.getParameter("limitcount");
		int limit = 30;
		int ccount = 0;
		boolean showmore = false;
		int countlimit = 0;
		int count = 0, flg = 1;
		int limitcnt = Integer.parseInt(A);
		String item = request.getParameter("item");
		String searchBy = request.getParameter("searchBy");

		String rd = request.getParameter("rd");
		System.out.println("RD::" + rd);

		System.out.println("--limitcnt--" + A + "-----" + limit + "sssss::" + searchBy);

		String fromdate = "", todate = "", all = "";
		try {
			fromdate = request.getParameter("fromdate");
			todate = request.getParameter("todate");
			all = request.getParameter("all");
			
			System.out.println(fromdate + "----" + todate + "----" + all);
			fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
			todate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));

			if (all.equalsIgnoreCase("true")) {
				System.out.println("inside All");
				fromdate = "2013-01-01";
				todate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(item + "--" + searchBy);

		if (rd.equals("doc")) {
			System.out.println("--doc");

			if (searchBy.equalsIgnoreCase("All")) {
				System.out.println("limit " + limit);
				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where  (InwardDate>='" + fromdate + "' and InwardDate<='"
						+ todate + "') and BillAmt='0.00' and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%')  or (FileName like '%" + item
						+ "%' Or InwardDate like '%" + item + "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item
						+ "%' Or FromParty like '%" + item + "%' Or Dept like '%" + item
						+ "%' Or Keywords like '%" + item + "%' Or BillDate like '%" + item
						+ "%' Or  BillDueDate like '%" + item + "%' Or ToEmploy like '%" + item
						+ "%' Or ToEmailID like '%" + item + "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where  (InwardDate>='" + fromdate
						+ "' and InwardDate<='" + todate + "') and BillAmt='0.00' and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' Or InwardDate like '%" + item + "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item
						+ "%' Or FromParty like '%" + item + "%' Or Dept like '%" + item
						+ "%' Or Keywords like '%" + item + "%' Or BillDate like '%" + item
						+ "%' Or  BillDueDate like '%" + item + "%' Or ToEmploy like '%" + item
						+ "%' Or ToEmailID like '%" + item + "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Checked")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Checked' and (InwardDate>='" + fromdate
						+ "' and InwardDate<='" + todate + "') and BillAmt='0.00' and (Enteredby like '" + item
						+ "' or FileName like '%" + item
						+ "%' Or InwardDate like '%" + item + "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item
						+ "%' Or FromParty like '%" + item + "%' Or Dept like '%" + item
						+ "%' Or Keywords like '%" + item + "%' Or BillDate like '%" + item
						+ "%' Or  BillDueDate like '%" + item + "%' Or ToEmploy like '%" + item
						+ "%' Or ToEmailID like '%" + item + "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Checked' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt='0.00' and (Enteredby like '" + item + "' or FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Unchecked")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Unchecked' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt='0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Unchecked' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt='0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Forwarded")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Forwarded' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt='0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Forwarded' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt='0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			}
		}

		else if (rd.equals("bill")) {

			System.out.println("--bill");

			if (searchBy.equalsIgnoreCase("All")) {
				System.out.println("limit " + limit);
				limit = limit + (10 * limitcnt);
				sql1 = "select * from t_inwarddetails where (InwardDate>='" + fromdate + "' and InwardDate<='"
						+ todate + "') and BillAmt<>'0.00' and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' Or InwardDate like '%" + item + "%' Or Subject like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where (InwardDate>='" + fromdate
						+ "' and InwardDate<='" + todate + "') and BillAmt<>'0.00' and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' Or InwardDate like '%" + item + "%' Or Subject like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' Or ManualRef like '%" + item + "%' Or FromParty like '%" + item
						+ "%' Or Dept like '%" + item + "%' Or Keywords like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Checked")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Checked' and  (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt<>'0.00' and (Enteredby like '" + item + "' or FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' Or Subject like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or InwardDate like '%" + item + "%' Or ManualRef like '%" + item
						+ "%' Or FromParty like '%" + item + "%' Or Dept like '%" + item
						+ "%' Or Keywords like '%" + item + "%' Or BillDate like '%" + item
						+ "%' Or  BillDueDate like '%" + item + "%' Or ToEmploy like '%" + item
						+ "%' Or ToEmailID like '%" + item + "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Checked' and  (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt<>'0.00' and (Enteredby like '" + item + "' or FileName like '%" + item + "%' Or InwardDate like '%" + item
						+ "%' Or Subject like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or InwardDate like '%" + item + "%' Or ManualRef like '%" + item
						+ "%' Or FromParty like '%" + item + "%' Or Dept like '%" + item
						+ "%' Or Keywords like '%" + item + "%' Or BillDate like '%" + item
						+ "%' Or  BillDueDate like '%" + item + "%' Or ToEmploy like '%" + item
						+ "%' Or ToEmailID like '%" + item + "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Unchecked")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Unchecked' and  (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt<>'0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or ( Subject like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Unchecked' and  (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt<>'0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or ( Subject like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Forwarded")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Forwarded' and  (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt<>'0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (Subject like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc  limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Forwarded' and  (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate
						+ "') and BillAmt<>'0.00' and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (Subject like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			}

			System.out.println("--elllllll");

		}

		else {
			System.out.println("--ellllllsssssssssssl");

			if (searchBy.equalsIgnoreCase("All")) {
				System.out.println("limit " + limit);
				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where  (InwardDate>='" + fromdate + "' and InwardDate<='"
						+ todate + "') and (Enteredby like '" + item + "' or ToEmploy like '%" + item
						+ "%') or (FileName like '%" + item + "%' or Category like '%" + item
						+ "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item + "%' or senderRemark like '%" + item
						+ "%' Or Subject like '%" + item + "%' Or BillDate like '%" + item
						+ "%' Or  BillDueDate like '%" + item + "%' Or ToEmploy like '%" + item
						+ "%' Or ToEmailID like '%" + item + "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where  (InwardDate>='" + fromdate
						+ "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Checked")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Checked' and (InwardDate>='" + fromdate
						+ "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Checked' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Unchecked")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Unchecked' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Unchecked' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			} else if (searchBy.equalsIgnoreCase("Forwarded")) {

				limit = limit + (10 * limitcnt);

				sql1 = "select * from t_inwarddetails where CheckStatus='Forwarded' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc limit " + limit + "";

				sql2 = " SELECT COUNT(*) from t_inwarddetails where CheckStatus='Forwarded' and (InwardDate>='"
						+ fromdate + "' and InwardDate<='" + todate + "') and (Enteredby like '" + item
						+ "' or ToEmploy like '%" + item + "%') or (FileName like '%" + item
						+ "%' or Category like '%" + item + "%' or InwardRefNo like '%" + item + "%' or BillNo like '%" + item
						+ "%' or senderRemark like '%" + item + "%' Or Subject like '%" + item
						+ "%' Or BillDate like '%" + item + "%' Or  BillDueDate like '%" + item
						+ "%' Or ToEmploy like '%" + item + "%' Or ToEmailID like '%" + item
						+ "%') order by InwardDate desc";

			}

		}


		int totalrecords = 0;
		System.out.println("---1>>" + sql1);
		System.out.println("---2>>" + sql2);
		try {
			rs1 = stmt1.executeQuery(sql1);
			rs2 = stmt2.executeQuery(sql2);
			if (rs2.next()) {
				totalrecords = rs2.getInt(1);
			}
			System.out.println("---RowCount::::::" + totalrecords);
			if (totalrecords > limit) {
				showmore = true;
				System.out.println("in if");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		String buffer = "<div style='height:auto;width:100%;overflow:auto;'>";
		
		buffer += "<table id='example' class='display' style='width:100%'>";
		int i = 1;
		String val = "", val1 = "";
		String pono = "", PODate = "";
		String SupplierCode = "", SupplierName = "";
		String amount = "";
		String SupplierSQL = "";
		String refno = "";
		String total = "";
		String sup_name = "";
		String pq_no = "";
		String pi_date = "";
		String Supp = "";
		String status = "";
		String purdate = "";
		String duedate = "";
			System.out.println("-----All");

			if (!rs1.isBeforeFirst()) {

				buffer = buffer + "<tr align='center'><td>---Data Not Found---</td></tr>";
			} else
				buffer = buffer+ "<tr><th style='font-size:12px ; background: #1582AB ; height:50px;  color:white;face:san-serif;'>Sr.no</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>Inward No</th><th style='font-size:12px ; background: #1582AB; width:5%;  color:white;face:san-serif;'>Inward Date</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>Category</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>ToEmploy</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>Subject</th><th style='font-size:12px ; width:5%; background: #1582AB;  color:white;face:san-serif;'>Files</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>CheckStatus</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>UpdatedDate</th><th style='font-size:12px ; background: #1582AB;  color:white;face:san-serif;'>Enteredby</th></tr>";
				while (rs1.next()) {
				try {

					purdate = new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("InwardDate"));
					buffer = buffer + "<tr><td style='font-size: 11px; face:san-serif; color:black' align='left'>"
							+ i
							+ "</td><td style='font-size: 11px; face:san-serif; color:black' align='left'><a href='#' style='color: black;'>"
							+ rs1.getString("InwardRefNo").replaceAll("(?i)" + item,
									"<font color=blue><u>" + item.toUpperCase() + "</u></font>")
							+ ".</a></td><td style='font-size: 11px; face:san-serif; color:black' align='left'><a href='#' style='color: black;'>"
							+ purdate.replaceAll("(?i)" + item,
									"<font color=blue><u>" + item.toUpperCase() + "</u></font>")
							+ ".</a></td><td style='font-size: 11px; face:san-serif; color:black' align='left'><a href='#' style='color: black;'>"
							+ rs1.getString("Category").replaceAll("(?i)" + item,
									"<font color=blue><u>" + item.toUpperCase() + "</u></font>")
							+ ".</a></td><td style='font-size: 11px; face:san-serif; color:black' align='left'><a href='#' style='color: black;'>"
							+ rs1.getString("ToEmploy").replaceAll("(?i)" + item,
									"<font color=blue><u>" + item.toUpperCase() + "</u></font>")
							+ ".</a></td></td><td style='font-size: 11px; face:san-serif; color:black' align='left'><a href='#' style='color: black;'>"
							+ rs1.getString("Subject").replaceAll("(?i)" + item,
									"<font color=blue><u>" + item.toUpperCase() + "</u></font>")
							+ ".</a></td><td style='font-size: 11px; face:san-serif;  width:5%; color:black'  align='left'><a href='#' style='color: black;'>"
							+ rs1.getString("FileName").replaceAll("(?i)" + item,
									"<font color=blue><u>" + item.toUpperCase() + "</u></font>")
							+ ".</a></td><td style='font-size: 11px; face:san-serif; color:black' align='left'>"
							+ rs1.getString("CheckStatus")
							+ "</td><td style='font-size: 11px; face:san-serif; color:black' align='left'>"
							+ new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("UpdatedDateTime"))
							+ "</td><td style='font-size: 11px; face:san-serif; color:black' align='left'>"
							+ rs1.getString("Enteredby") + "</td></tr>";
							
							i++;
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		
		++limitcnt;
		if (showmore)
			buffer += "</table><a href='#more' id='more' onclick='timer1(" + limitcnt + ")'>More</a></div>";
		else
			buffer += "</table></div>";
		out.println(buffer);

	} catch (Exception e) {

		System.out.println("ex::" + e);
	}
%>