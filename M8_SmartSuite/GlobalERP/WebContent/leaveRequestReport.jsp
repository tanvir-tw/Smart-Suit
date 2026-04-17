 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
 <%@ page import=" java.util.Date"%>

<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">
<%
Connection conn = null;
Statement st1 =null,stmt=null;
String datex1="",datex2="",bt="",data1="",data2="",dt2="",dt1="",dttime="",dt1time="",status="";
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString();
try {
	conn = connection.getConnect("db_leaveapplication");    
	st1=conn.createStatement();
	stmt=conn.createStatement();

} catch (Exception e) {
    e.printStackTrace();
} 

bt=request.getParameter("button");
System.out.println("bt"+bt);

	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		status="All";
		
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
        status=request.getParameter("status");
	}

	dt2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime=""+dt2+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time=""+dt1+" 23:59:59";
	System.out.println("Inside Leave Request!!!!!!");

	String uname = session.getAttribute("leaveusername").toString();
	String ReportingtoHod = session.getAttribute("leaveuserhod").toString();
	String empname = session.getAttribute("leaveemail").toString();
	String data = request.getParameter("status");
	String strLeaveVal = request.getParameter("statLeave");
	
	
	System.out.println("uname!!!!!!"+ uname);
	System.out.println("ReportingtoHod!!!!!!"+ReportingtoHod);
	System.out.println("empname!!!!!!"+empname);
	System.out.println("Inside Leave Request!!!!!!");
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <%if (bt== null || bt.equals("null")) { %>
                <h5 class="content-header-title text-center mb-0" style="color: #060637">Leave Report  from <%=datex1%> to <%=datex2%></h5>
          <%}else{ %>
                 <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=status%> Leave Report  from <%=datex1%> to <%=datex2%></h5>
          
          <%} %>
    </div>
  </div>
<form name="leave" method="get"  action="">
		    <div class="row col-12" id="ext_row">
		    <div class="col-md-3"></div>     
             <div class="col-md-2 ms-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
						<select class="form-select" name="status" id="status">
							
							<%
																						if (data != null) {

																							if (data.equalsIgnoreCase("Pending"))

																							{
																					%>	
								
									<option value="All1" >All</option>	
								<option value="Pending" selected="selected" >Pending</option>
								<option value="Approved">Approved</option>
							<option value="NotApproved">Rejected</option>
							<option value="Cancel">Canceled</option>		
								
						<%
																	} else if (data.equalsIgnoreCase("All1")) {
																%>	
							<option value="All1" selected="selected">All</option>	
							<option value="Pending" >Pending</option>
							<option value="Approved">Approved</option>
							<option value="NotApproved">Rejected</option>
							<option value="Cancel">Canceled</option>	
							
							
						
						<%
																												} else if (data.equalsIgnoreCase("Approved")) {
																											%>	
							<option value="All1" >All</option>	
							<option value="Pending" >Pending</option>
							<option value="Approved" selected="selected">Approved</option>
							<option value="NotApproved">Rejected</option>
							<option value="Cancel">Canceled</option>	
							
							
						
						<%
																												} else if (data.equalsIgnoreCase("NotApproved")) {
																											%>
							
						<option value="All1" >All</option>	
						<option value="Pending" >Pending</option>
						<option value="Approved" >Approved</option>
						<option value="NotApproved" selected="selected">Rejected</option>	
						<option value="Cancel">Canceled</option>	
							
							
					<%
																					} else {
																				%>
							
							<option value="All1" >All</option>	
								<option value="Pending" >Pending</option>
						<option value="Approved" >Approved</option>
						<option value="NotApproved" >Rejected</option>
							<option value="Cancel" selected="selected">Canceled</option>	
							
						<%
															}

															} else {
														%>
							
						
							<option value="All1">All</option>	
						<option value="Pending">Pending</option>		
							<option value="Approved">Approved</option>
							<option value="NotApproved">Rejected</option>
							<option value="Cancel">Canceled</option>	
							
						<%
															}
														%>
							
						</select>
					 <script>
                            const mySel = document.getElementById("status");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>			
		                </div>
			      </div>
			     <div class="col-md-2" id="fromDate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div> 
			<script type="text/javascript">
			             Calendar.setup(
			             {
			                 inputField  : "data",         // ID of the input field
			                 ifFormat    : "%d-%b-%Y",     // the date format
			                 button      : "trigger"       // ID of the button
			             }
			                           );
			        </script>
			   
			   <div class="col-md-2" id="toDate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				 				
 				</div>
		    </div>
			   
   	    <script type="text/javascript">
			             Calendar.setup(
			             {
			                 inputField  : "data1",         // ID of the input field
			                 ifFormat    : "%d-%b-%Y",     // the date format
			                 button      : "trigger1"       // ID of the button
			             }
			                           );
           </script>
           
           <div class="col-md-1 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			</div>
			
<input type="hidden" name="rid" id="ridHidden">
<input type="hidden" name="type" id="typeHidden">
<input type="hidden" name="index" id="indexHidden">
         </form>
           
			<%
			
				String data_del = "";
				if (data != null) {
					datex1 = new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd-MMM-yyyy")
									.parse(datex1));
					datex2 = new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd-MMM-yyyy")
									.parse(datex2));

				} else {

					data = strLeaveVal;
					data_del = "loop";
				}

				//System.out.println(data);
				if (data_del.equalsIgnoreCase("loop")) {

					System.out.println("11111" + datex1);
					if (datex1 != null) {
						datex1 = new SimpleDateFormat("yyyy-MM-dd")
								.format(new SimpleDateFormat("dd-MMM-yyyy")
										.parse(datex1));
						datex2 = new SimpleDateFormat("yyyy-MM-dd")
								.format(new SimpleDateFormat("dd-MMM-yyyy")
										.parse(datex2));
					}
			%>
<form method="post" name="leave" action="leaveapproved.jsp" >
<%
		String uroleofuser = session.getAttribute("leaveemprole").toString();
		String typevalue = session.getAttribute("leaveempdept").toString();
		String username = session.getAttribute("leaveemail").toString();
		java.util.Date d = new java.util.Date();
		String datetoday = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(d);
		String sql = "";

		Date yesterday = new Date();
		final Format frt1 = new SimpleDateFormat("yyyy-MM-dd");
		String now = frt1.format(yesterday);
		String abc111 = now.substring(0, 7);
		abc111 = abc111 + "-01";
		java.util.Date dte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today_td = formatter.format(dte);

		String current_day = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(abc111));
		String currentday1 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(today_td));

		String check = "-", new_stataus = "-";
		if (data != null) {

			check = "status1";
			if (data.equalsIgnoreCase("Pending1")) {
				new_stataus = "Pending";

				data = "Pending";

			} else if (data.equalsIgnoreCase("Approved1")) {
				new_stataus = "Approved";
				data = "Approved";

			} else if (data.equalsIgnoreCase("All1")) {
				new_stataus = "NoStatus";

			} else if (data.equalsIgnoreCase("NotApproved1")) {
				new_stataus = "NotApproved";
				data = "Rejected";

			} else {

				new_stataus = "Cancel";
				data = "Cancelled";
			}

		} else {

		}

		System.out.println("Qry==new_stataus=$$$$$$$$$$$$$$$=>>"
				+ check);
		System.out.println("Qry==new_stataus=&&&&&&&&&&&&&&&&&=>>"
				+ new_stataus);

		if ("emp".equalsIgnoreCase(uroleofuser)
				|| "contractor".equalsIgnoreCase(uroleofuser)) {
			sql = "select * from t_leaverequest where emailid='" + username
					+ "' and status='" + new_stataus
					+ "' order by firstdayofleave desc";

		} else if ("All".equalsIgnoreCase(typevalue)) {

			System.out.println("ELSEEEEEEEEEEEEEEEEEE==All @@@@=>>");
			sql = "select * from t_leaverequest where (hod='" + uname
					+ "' or  emailid='" + uname + "' or emailid like '%%' ) and status='"
					+ new_stataus + "' order by firstdayofleave desc";

		} else if (check.equalsIgnoreCase("status1")) {

			System.out.println("ELSEEEEEEEEEEEEEEEEEE==IFFF @@@@=>>");
			if (new_stataus.equalsIgnoreCase("NoStatus")) {
				sql = "select * from t_leaverequest where URole in ('hod','HR')  order by firstdayofleave desc";

			} else if (new_stataus.equalsIgnoreCase("-")) {

			} else {
				sql = "select * from t_leaverequest where (hod='"
						+ uname + "' or  emailid='" + uname
						+ "') and status='" + new_stataus
						+ "' order by firstdayofleave desc";

			}

		} else {
			System.out.println("ELSEEEEEEEEEEEEEEEEEE===>>");

////***********Logic to get Hodempid to get subordinates email and id**************///
String emailidofhod="";String Emailemp="";String empidofhod="";String EmployeesEmail="";
uname=uname.trim();
String sql14="select  email,empid from db_leaveapplication.t_leaveadmin where  email like '"+empname+"'";

ResultSet rs4 = st.executeQuery(sql14);
System.out.println("sql14 issssss>>" + sql14);
while(rs4.next())
{

emailidofhod=rs4.getString("email");
empidofhod=rs4.getString("empid");

}
empidofhod=empidofhod.trim();
///********Logic to get Employees from there Reportinghod************//
String sql16="select empid,Uname,name,Email from db_leaveapplication.t_leaveadmin where ReportingtoHod like '"+empidofhod+"'";
ResultSet rs6 = st.executeQuery(sql16);
System.out.println("sql16 issssss>>" + sql16);
while(rs6.next())

{
	Emailemp=rs6.getString("Email");
	EmployeesEmail=EmployeesEmail + Emailemp +",";
}
EmployeesEmail=EmployeesEmail.substring(0,EmployeesEmail.length()-1);
System.out.println("Employees Email issssss>>" + EmployeesEmail);
////**********Logic to display data***************************////
sql="select * from db_leaveapplication.t_leaverequest where (hod='"+uname+"' or  emailid IN('"+EmployeesEmail+"')) and firstdayofleave between '"+abc111+"' and '"+today_td+"'  order by firstdayofleave desc";
		}
		ResultSet rs = stmt.executeQuery(sql);
		int i = 1;
		String srnum = "";
%>
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>                          
		
		<%
			try {
					if ((!(uroleofuser.equalsIgnoreCase("emp")) || !(rs
							.getString("emailid").equalsIgnoreCase(username)))) {
		%>
						<th>
						<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
						<font color="white" style="font-size:12px;">Chk &nbsp;&nbsp;/&nbsp;&nbsp;</font></a> 
						<a href="#" onclick="unCheckAll()"> <font color="white" style="font-size:12px;">UnChk</font></a>
					</th>
			<%
				}
					} catch (Exception e) {
						System.out.println("Exception----->" + e);
					}
			%>
		
		
	
		<th>Sr.No.</th>
		<th>Days</th>
		<th>From</th>
		<th>Type</th>
		<th>Reason</th>
		<th>Report on</th>
		<th>Name</th>
		<th>Status</th>
		<th>HOD</th>
		<%
			if (data != null) {
					if (data.equalsIgnoreCase("cancel1")) {
		%>
				
			
		<%
										} else {
									%>
		<th>Action</th>
		<%
			}

				} else {
		%>
			<th>Action</th>	
	<%
			}
		%>
		<th>Applied Date</th>
	</tr>
	</thead>
	<tbody>
<%
	while (rs.next()) {
			srnum = rs.getString("srno");

			String color = "";
			if (rs.getString("status").equalsIgnoreCase("pending")) {
				color = "#AEF8B1";

			} else if (rs.getString("status").equalsIgnoreCase(
					"Approved")) {

				color = "#C7C1F7";
			} else if (rs.getString("status").equalsIgnoreCase(
					"NotApproved")) {
				color = "#FB9BA5";

			} else {
				color = "#FF9933";
			}

			System.out.println("Qry=color=>>" + color);
			Date dt = rs.getDate("firstdayofleave");
%>
	<tr bgcolor="<%=color%>">
	<input type="hidden" name="rid<%=i%>" id="rid<%=i%>" value="<%=rs.getString("srno")%>">
		<%
	   			if ((!(uroleofuser.equalsIgnoreCase("emp")) || !(rs
	   							.getString("emailid").equalsIgnoreCase(username)))) {
	   						if (rs.getString("emailid").equalsIgnoreCase(username)) {
	   		%>
			<td></td>
			<%
				} else if ((!new_stataus.equalsIgnoreCase("cancel")) && (!new_stataus.equalsIgnoreCase("NotApproved")) && (!new_stataus.equalsIgnoreCase("Approved")) ) {
			%>
			<td><input type="checkbox" name="cb<%=i%>" id="cb<%=i%>" value="<%=rs.getString("srno")%>"></input></td>
		
		<%
			}else
			{%>
				<td></td>
				<%
			}
				
					}
		%>
		<td align="right"><div align="right"><font size="2" color="black"><%=i%></font></div></td>
		<td align="right"><div align="right" style="overflow: auto;"><font size="2" color="black"><%=rs.getString("daysapplied")%></font></div></td>
		<td align="right"><div align="right"><font size="2" color="black"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(rs
															.getString("firstdayofleave")))%></font></div></td>
		<td align="left"><div align="left"><font size="2" color="black"><%=(rs.getString("typeofleave")).substring(0, (rs
									.getString("typeofleave")).length() - 6)%></font></div></td>
		<td align="left"><div align="left" style="overflow: auto; width: 200px;"><font size="2" color="black"><%=rs.getString("reasonforleave")%></font></div></td>
		<td align="right"><div align="right"><font size="2" color="black"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(rs
															.getString("dateofreporting")))%></font></div></td>
		<td align="left"><div align="left"><a href="" onmouseover="ajax_showTooltip(window.event,'showEmpDetails.jsp?empName=<%=rs.getString("name")%>',this);return false" onMouseOut="ajax_hideTooltip();"><font size="2" color="black"><%=rs.getString("name")%> </font></div></td>
		<%
			if ("Approved".equalsIgnoreCase(rs.getString("status"))) {
		%>
						<td align="left"><div align="left"><font size="2" color="black">Accepted</font></div></td>
						<%
							} else if ("NotApproved".equalsIgnoreCase(rs
											.getString("status"))) {
						%>
							<td align="left"><div align="left"><font size="2" color="black">Rejected</font></div></td>
							<%
								} else {
							%>
							<td align="left"><div align="left"><font size="2" color="black"><%=rs.getString("status")%></font></div></td>
							<%
								}

										String hodname = "select Name from t_leaveadmin where Email='"
												+ rs.getString("HOD") + "'";
										ResultSet rsHodname = st1.executeQuery(hodname);
										System.out.println(">>>>hodname>>>>>" + hodname);
										if (rsHodname.next()) {
							%>
			<td align="left"><div align="left" style="overflow: auto; width: 80px;"><font size="2" color="black"><%=rsHodname.getString("Name")%></font></div></td>
		<%
			} else {
		%>
			<td><font color="#AEF8B1">-</font> </td>
			<%
				}
			%>
		
		<%
					if (uroleofuser.equalsIgnoreCase("emp")
									|| rs.getString("emailid").equalsIgnoreCase(
											username)) {
								if ((rs.getString("status").equalsIgnoreCase("Pending"))
										&& (uroleofuser.equalsIgnoreCase("emp") || rs
												.getString("emailid").equalsIgnoreCase(
														username))) {
				%>
				<td class="text-center"><a href="#" onclick="return onSubmitForCancle('leave','<%=rs.getString("srno")%>','<%=i%>')">Cancel</a></td>
			<%
				} else {
			%><td></td><%
				}
						} else {
							if (rs.getString("status").equalsIgnoreCase(
									"NotApproved")
									|| rs.getString("status").equalsIgnoreCase(
											"Approved")) {
			%>
								<td align="left"><div align="left"><br><a href="#" onclick="return onSubmitForRevert('<%=rs.getString("srno")%>','<%=i%>')"><font size="2" color="#09195B">Revert</font></a></div></td>
								<%
									} else if (rs.getString("status").equalsIgnoreCase(
														"Cancel")) {

													if (data != null) {
														if (data.equalsIgnoreCase("cancel1")) {

														} else {
								%>
									<td></td>
									<%
										}

														} else {
									%>
									<td></td>
									<%
										}
													} else {
									%>
								<td class="text-center"><a href="#" onclick="return onSubmit1('leave','<%=rs.getString("srno")%>','<%=i%>')">Approve</a>
								<br><a href="#" onclick="return onSubmitForNot1('leave','<%=rs.getString("srno")%>','<%=i%>')">Reject</a></td>
								<%
									}
											}
								%>
		<td align="right"><div align="right" style="width: 80px;"><font size="2" color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm")
									.format(new SimpleDateFormat(
											"yyyy-MM-dd HH:mm:ss").parse(rs
											.getString("inserteddatetime")))%></font></div></td>
	</tr>
	
	<%
			i++;
				}
		%>
			</tbody>
		</table>
	</form>		
				<input type="hidden" name="cntr" value="<%=i%>" />
				
				<%
					if (!(uroleofuser.equalsIgnoreCase("emp"))) {
				%>
				
<div class="row col-12 mt-4 mb-2">
    <div class="col-md-2" style="width:8%;">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="onSubmit(document.leave,'<%=srnum%>','<%=i%>')"> Approve </button>
    </div>
    <div class="col-md-2">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="return onSubmitForNot(document.leave,'<%=srnum%>','<%=i%>');"> Reject </button>
    </div>
</div>
				<%
					}
				%> 
<%
	} else if (data.equals("Pending1") || data.equals("Approved1")
			|| data.equals("NotApproved1") || data.equals("cancel1")) {
%>
<form method="post" name="leave1" action="">
       	<%
						String uroleofuser = session.getAttribute("leaveemprole").toString();
						String typevalue = session.getAttribute("leaveempdept").toString();
						String username = session.getAttribute("leaveemail").toString();
						java.util.Date d = new java.util.Date();
						String datetoday = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.format(d);

						int len = data.length();
						data = data.substring(0, len - 1);
						String srnum = "";
						String sql = "";
						if ("emp".equalsIgnoreCase(uroleofuser)) {
							sql = "select * from db_leaveapplication.t_leaverequest where emailid='"
									+ username
									+ "' and Status='"
									+ data
									+ "' order by firstdayofleave desc";

						} else if ("All".equalsIgnoreCase(typevalue)) {
							sql = "select * from db_leaveapplication.t_leaverequest where URole='hod' and Status='"
									+ data + "' order by firstdayofleave desc";
						} else {
							sql = "select * from db_leaveapplication.t_leaverequest where Status='"
									+ data
									+ "' order by firstdayofleave desc";
						}
						ResultSet rs = st.executeQuery(sql);
						System.out.println(sql);
						int i = 1;
				%>
				<table id="example" class="display" style="width:100%">        
			       <thead>
			            <tr>
						<%
							try {
									if ((data.equals("Pending"))
											&& (!(uroleofuser.equalsIgnoreCase("emp")) || !(rs
													.getString("emailid")
													.equalsIgnoreCase(username)))) {
						%>
						<th>
						<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
						<font color="white" style="font-size:12px;">Chk /</font></a> 
						<a href="#" onclick="unCheckAll()"> <font color="white" style="font-size:12px;">UnChk</font></a>
					</th>
						<%
							}
								} catch (Exception e) {
									System.out.println("Exception------->" + e);
								}
						%>
						<th>Sr.No.</th>
						<th>Days</th>
						<th>From</th>
						<th>Type</th>
						<th>Reason</th>
						<th>Report on</th>
						<th>Name</th>
						<th>Status</th>
						<th>HOD</th>
						<th>Action</th>
						<th>Applied Date</th>
					</tr>
					</thead>
					<tbody>
				<%
					while (rs.next()) {
							srnum = rs.getString("srno");
				%>
				<tr>	
						<%
							if ((data.equals("Pending"))
											&& (!(uroleofuser.equalsIgnoreCase("emp")) || !(rs
													.getString("emailid")
													.equalsIgnoreCase(username)))) {
										if (rs.getString("emailid").equalsIgnoreCase(username)) {
						%>
								<td></td>
								<%
									} else {
								%>
							<td class="text-center"><input type="checkbox" name="cb<%=i%>" id="cb<%=i%>" value="<%=rs.getString("srno")%>"></input></td>
							<%
								}
										}
							%>
						<td class="text-center"><input type="hidden" name="rid<%=i%>" id="rid<%=i%>" value="<%=rs.getString("srno")%>"/><%=i%></td>
						<td class="text-center"><%=rs.getString("daysapplied")%></td>
						<td class="text-center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd").parse(rs.getString("firstdayofleave")))%></td>
						<td class="text-center"><%=(rs.getString("typeofleave")).substring(0, (rs.getString("typeofleave")).length() - 6)%></td>
						<td class="text-center"><%=rs.getString("reasonforleave")%></td>
						<td class="text-center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("dateofreporting")))%></td>
						<td class="text-center"><a href="" onmouseover="ajax_showTooltip(window.event,'showEmpDetails.jsp?empName=<%=rs.getString("name")%>',this);return false" onMouseOut="ajax_hideTooltip();"><%=rs.getString("name")%></td>
						<%
							if ("Approved".equalsIgnoreCase(rs.getString("status"))) {
						%>
							<td class="text-center">Accepted</td>
							<%
								} else if ("NotApproved".equalsIgnoreCase(rs
												.getString("status"))) {
							%>
							<td class="text-center">Rejected</td>
							<%
								} else {
							%>
							<td class="text-center"><%=rs.getString("status")%></td>
							<%
								}

										String hodname = "select Name from t_leaveadmin where Email='"
												+ rs.getString("HOD") + "'";
										ResultSet rsHodname = st1.executeQuery(hodname);
										System.out.println(hodname);
										if (rsHodname.next()) {
							%>
								<td class="text-center"><%=rsHodname.getString("Name")%></td>
							<%
								} else {
							%>
							<td></td>
							<%
								}
							%>
						<%
							if (uroleofuser.equalsIgnoreCase("emp")
											|| rs.getString("emailid").equalsIgnoreCase(
													username)) {
										if ((rs.getString("status").equalsIgnoreCase("Pending"))
												&& (uroleofuser.equalsIgnoreCase("emp") || rs
														.getString("emailid").equalsIgnoreCase(
																username))) {
						%>
								<td class="text-center"><a href="#" onclick="onSubmitForCancle('leave1','<%=rs.getString("srno")%>','<%=i%>')">Cancel</a></td>
							<%
								} else {
							%><td></td><%
								}
										} else {
											if (rs.getString("status").equalsIgnoreCase(
													"NotApproved")
													|| rs.getString("status").equalsIgnoreCase(
															"Approved")) {
							%>
								<td class="text-center"><br><a href="#" onclick="return onSubmitForRevert('<%=rs.getString("srno")%>','<%=i%>')">Revert</a></td>
								<%
									} else if (rs.getString("status").equalsIgnoreCase(
														"Cancel")) {
								%>
								<td></td>
								<%
									} else {
								%>
								<td class="text-center"><a href="#" onclick="return onSubmit1('leave1','<%=rs.getString("srno")%>','<%=i%>')">Approve</a>
								<br><a href="#" onclick="return onSubmitForNot1('leave1','<%=rs.getString("srno")%>','<%=i%>')">Reject</a></td>
								<%
									}
											}
								%>
					<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("inserteddatetime")))%></td>
					</tr>
					<%
											i++;
												}
										%>
				</tbody>
			</table>	
		</form>	
				<input type="hidden" name="cntr" value="<%=i%>" />	
				
				<%
					if ((data.equals("Pending"))
								&& (!(uroleofuser.equalsIgnoreCase("emp")))) {
				%>
				<div class="row col-12 mt-4 mb-2">
				    <div class="col-md-2" style="width:8%;">
				        <button type="button" class="btn btn-primary" id="button" name="button" onclick="onSubmit(document.leave,'<%=srnum%>','<%=i%>')"> Approve </button>
				    </div>
				    <div class="col-md-2">
				        <button type="button" class="btn btn-primary" id="button" name="button" onclick="return onSubmitForNot(document.leave,'<%=srnum%>','<%=i%>');"> Reject </button>
				    </div>
				</div>
				<%
 					}
 				%>
				<%
					//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					} else {

						String frm = new SimpleDateFormat("dd-MMM-yyyy")
								.format(new SimpleDateFormat("yyyy-MM-dd")
										.parse(datex1));
						String tdt = new SimpleDateFormat("dd-MMM-yyyy")
								.format(new SimpleDateFormat("yyyy-MM-dd")
										.parse(datex1));
						//System.out.println("LOOp=data==444===>>"+data);

						String color = "", nw_stts = "";
						if (data.equalsIgnoreCase("All1")) {
							//color="#AEF8B1";
							nw_stts = "NoSttaus";
							data = "ALL1Loop";
						} else if (data.equalsIgnoreCase("Approved")
								|| data.equalsIgnoreCase("pending")) {

							//color="#C7C1F7";
						} else if (data.equalsIgnoreCase("NotApproved")) {
							//color="#FB9BA5";
							data = "Rejected";

						} else {

							//color="#FF9933";

							data = "Cancelled";
						}
						//System.out.println("LOOp=nw_stts==444===>>"+nw_stts);
				%>
<form method="post" name="leave2" action="leaveapproved.jsp">
				<%
						if (data.equalsIgnoreCase("Cancelled")) {

							data = "Cancel";

						}

						if (data.equalsIgnoreCase("Rejected")) {

							data = "NotApproved";

						}
						String uroleofuser = session.getAttribute("leaveemprole").toString();
						String typevalue = session.getAttribute("leaveempdept").toString();
						String username = session.getAttribute("leaveemail").toString();
						java.util.Date d = new java.util.Date();
						String datetoday = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.format(d);
						String sql = "";
						if ("emp".equalsIgnoreCase(uroleofuser)|| "contractor".equalsIgnoreCase(uroleofuser)) {

							if (nw_stts.equalsIgnoreCase("NoSttaus")) {
								sql = "select * from db_leaveapplication.t_leaverequest where emailid='"
										+ empname
										+ "'  and firstdayofleave between '"
										+ datex1
										+ "' and '" + datex2 + "'  ";

							} else {

								sql = "select * from db_leaveapplication.t_leaverequest where emailid='"
										+ empname
										+ "' and Status='"
										+ data
										+ "' and firstdayofleave between '"
										+ datex1
										+ "' and '" + datex2 + "'  ";
							}

						} else if ("All".equalsIgnoreCase(typevalue)) {

							System.out.println("elseIFFFFF1111=>" + nw_stts+"allll"+typevalue);
							if (nw_stts.equalsIgnoreCase("NoSttaus")) {

								System.out.println("******************=>");
								sql = "select * from db_leaveapplication.t_leaverequest where (hod='"
										+ empname
										+ "' or  emailid='"
										+ empname
										+ "' or  emailid like  '%%') and firstdayofleave between '"
										+ datex1
										+ "' and '" + datex2 + "'  ";
								
								System.out.println("*******emp***nnmm********=>" + empname);
								
							} else {

								System.out.println("elsemmmmmmmmmmm=mdmdmd=>");
								sql = "select * from db_leaveapplication.t_leaverequest where (hod='"
										+ empname
										+ "' or  emailid='"
										+ empname
										+ "' or  emailid like  '%%') and   Status='"
										+ data
										+ "' and  firstdayofleave between '"
										+ datex1
										+ "' and '" + datex2 + "'  ";
								

						}

						} else {
							if (nw_stts.equalsIgnoreCase("NoSttaus")) {
								System.out.println("ifffffffffffff==>");
								sql = "select * from db_leaveapplication.t_leaverequest where (hod='"
										+ empname
										+ "' or  emailid='"
										+ empname
										+ "')    and firstdayofleave between '"
										+ datex1 + "' and '" + datex2 + "'  ";

							} else {
								System.out.println("elsemmmmmmmmmmm==> empname" +empname );
								sql = "select * from db_leaveapplication.t_leaverequest where (hod='"
										+ empname
										+ "' or  emailid='"
										+ empname
										+ "')  and   Status='"
										+ data
										+ "' and  firstdayofleave between '"
										+ datex1
										+ "' and '" + datex2 + "'  ";

							}
						}
						System.out.println("last loop==>" + sql);
						ResultSet rs = st.executeQuery(sql);
						int i = 1;
						String srnum = "";
				%>
	<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
						<%
							try {
									if ((data.equals("Pending"))
											&& (!(uroleofuser.equalsIgnoreCase("emp")) || !(rs
													.getString("emailid")
													.equalsIgnoreCase(username)))) {
						%>
					<th>
						<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
						<font color="white" style="font-size:12px;">Chk /</font></a> 
						<a href="#" onclick="unCheckAll()"> <font color="white" style="font-size:12px;">UnChk</font></a>
					</th>
						
						<%
							}
								} catch (Exception e) {
									System.out.println("Exception-------->" + e);
								}
						%>
						<th>Sr.No.</th>
						<th>Days</th>
						<th>From</th>
						<th>Type</th>
						<th>Reason</th>
						<th>Report on</th>
						<th>Name</th>
						<th>Status</th>
						<th>HOD</th>
						<%
							System.out.println("data=1111==>>>>>" + data);
								if (data.equalsIgnoreCase("cancel")) {
						%>
							
							 
					<%
														 						} else if (data.equalsIgnoreCase("ALL1Loop")) {
														 					%>		
						<th>Action</th>	
					<%
							} else {
						%>
						<th>Action</th>
						
				<%
											}
										%>
						
						
						<th>Applied Date</th>						
					</tr>
					</thead>
					<tbody>
				<%
					while (rs.next()) {
							srnum = rs.getString("srno");
%>
					<tr>
						<%
							if ((data.equals("Pending"))
											&& (!(uroleofuser.equalsIgnoreCase("emp")) || !(rs
													.getString("emailid")
													.equalsIgnoreCase(username)))) {
										if (rs.getString("emailid").equalsIgnoreCase(username)) {
						%>
							<td></td>
							<%
								} else {
							%>
						<td>
						
						<input type="checkbox" name="cb<%=i%>" id="cb<%=i%>" value="<%=rs.getString("srno")%>"></input></td>
						<%
							}
									}
						%>
						<td class="text-center"><%=i%></td>
						<td class="text-center"><%=rs.getString("daysapplied")%></td>
						<td class="text-center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("firstdayofleave")))%></td>						
						<td class="text-center"><%=(rs.getString("typeofleave")).substring(0, (rs.getString("typeofleave")).length() - 6)%></td>
						<td class="text-center"><%=rs.getString("reasonforleave")%></td>
						<td class="text-center"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("dateofreporting")))%></td>
						<td class="text-center"><a href="" onmouseover="ajax_showTooltip(window.event,'showEmpDetails.jsp?empName=<%=rs.getString("name")%>',this);return false" onMouseOut="ajax_hideTooltip();"><%=rs.getString("name")%></td>
						<%
							if ("Approved".equalsIgnoreCase(rs.getString("status"))) {
						%>
						<td class="text-center">Accepted</td>
						<%
							} else if ("NotApproved".equalsIgnoreCase(rs.getString("status"))) {
						%>
							<td class="text-center">Rejected</td>
							<%
								} else {
							%>
							<td class="text-center"><%=rs.getString("status")%></td>
							<%
								}
										String hodnm = "-";
										String hodname = "select Name from t_leaveadmin where Email='"
												+ rs.getString("HOD") + "'";
										ResultSet rsHodname = st1.executeQuery(hodname);
										if (rsHodname.next()) {
							%>
							<td class="text-center"><%=rsHodname.getString("Name")%></td>
						<%
							} else {
						%>
							<td>-</td>
							<%
								}
							%>
						
						<%	if (uroleofuser.equalsIgnoreCase("emp")|| rs.getString("emailid").equalsIgnoreCase(username)) {
								if ((rs.getString("status").equalsIgnoreCase("Pending"))&& (uroleofuser.equalsIgnoreCase("emp") || rs
									.getString("emailid").equalsIgnoreCase(username))) {
						%>
								<td class="text-center"><a href="#" onclick="return onSubmitForCancle('leave2','<%=rs.getString("srno")%>','<%=i%>')">Cancel</a></td>
							<%
								} else if ((rs.getString("status").equalsIgnoreCase("Cancel"))&& data.equalsIgnoreCase("ALL1Loop"))
											{
							%>
									<td>-</td>
								<%
								} else if ((rs.getString("status").equalsIgnoreCase("Cancel"))
										&& (uroleofuser.equalsIgnoreCase("emp") || rs.getString("emailid").equalsIgnoreCase(username))) {
																				}else {
																	%>
 								<td>-</td> 
								<%}
									} else {
										if (rs.getString("status").equalsIgnoreCase("NotApproved")|| rs.getString("status").equalsIgnoreCase("Approved")) {

 																%>
								<td class="text-center"><br><a href="#" onclick="return onSubmitForRevert('<%=rs.getString("srno")%>','<%=i%>')">Revert</a></td>
								<%
									} else if (data.equalsIgnoreCase("ALL1Loop")) {
								%>
								<td> </td>
							<%
								}else if (rs.getString("status").equalsIgnoreCase("Cancel")) {
							%>
								<%
									} else {
							%>
								<td class="text-center"><a href="#" onclick="return onSubmit1('leave2','<%=rs.getString("srno")%>','<%=i%>')">Approve</a>
								<br><a href="#" onclick="return onSubmitForNot1('leave2','<%=rs.getString("srno")%>','<%=i%>')">Reject</a></td>
								<%
									}
											}
								%>
					<td class="text-center"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("inserteddatetime")))%></td>
					</tr>
					<%
					i++;
					}
					%>
					</tbody>
					</table>
					</form>
				<input type="hidden" name="cntr" value="<%=i%>" />
				
				<%
									if ((data.equals("Pending"))
												&& (!(uroleofuser.equalsIgnoreCase("emp")))) {
								%>
<div class="row col-12 mt-4 mb-2">
    <div class="col-md-2" style="width:8%;">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="onSubmit(document.leave,'<%=srnum%>','<%=i%>')"> Approve </button>
    </div>
    <div class="col-md-2">
        <button type="button" class="btn btn-primary" id="button" name="button" onclick="return onSubmitForNot(document.leave,'<%=srnum%>','<%=i%>');"> Reject </button>
    </div>
</div>				
								
				 
				<%
 					}
 				%>
			
	</div>
				<%
					String dtanew = "-";
					}
				%>
 <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        //scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	     //   scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination

	        stateSave: true,
	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)	  
	         buttons : [
	        	 'colvis',
				{
	        		 extend : 'collection',
						className: 'btn btn-outline-secondary  ',
						 text:'Export',
						 orientation: 'landscape',
	                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Leave Request Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
	                         title: 'Leave Request Report from '+$("#data").val()+ ' to ' +$("#data1").val(),						
	                         orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
	                         title: 'Leave Request Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
	                         title: 'Leave Request Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Leave Request Report from '+$("#data").val()+ ' to ' +$("#data1").val(),							},
					],
				},
           ], 
       
       });

   });
   
</script>
<script>
function checkAll() {
    var checkboxes = document.querySelectorAll("input[type='checkbox']");
    checkboxes.forEach(function(cb) {
        cb.checked = true;
    });
}

function unCheckAll() {
    var checkboxes = document.querySelectorAll("input[type='checkbox']");
    checkboxes.forEach(function(cb) {
        cb.checked = false;
    });
}

function onSubmit1(form, rid, index)
{
    var msg = confirm("To confirm approval, Please click OK");

    if(!msg){
        return false;
    }

    var url = "leaveapproved.jsp?rid=" + rid + "&type=update&index=" + index;

    try
    {
        var frm = document.forms[form];

        if(!frm){
            alert("Form not found: " + form);
            return false;
        }

        frm.action = url;
        frm.submit();
    }
    catch(e)
    {
        alert("Error: " + e);
    }

    return false;
}

function onSubmitForNot1(form, rid, index)
{
    var msg = confirm("To reject approval, Please click OK");

    if(!msg){
        return false;
    }

    var url = "leaveapproved.jsp?rid=" + rid + "&type=not&index=" + index;

    var frm = document.forms[form];

    if(!frm){
        alert("Form not found: " + form);
        return false;
    }

    frm.action = url;
    frm.submit();

    return false;
}

function onSubmit(form, rid, index)
{
	try
	{
		var cnt;
		if(form.name == "leave")
		{
			cnt = document.leave.cntr.value;
		}
		else if(form.name == "leave1")
		{
			cnt = document.leave1.cntr.value;
		}
		else
		{
			cnt = document.leave2.cntr.value;
		}
	}
	catch (e){}

	// ✅ Get all checked checkboxes
	var checkboxes = document.querySelectorAll("input[type='checkbox']:checked");
	var total = checkboxes.length;
	var srNo = "";

	// ✅ Build comma separated values (FIX: remove .0 using parseInt)
	checkboxes.forEach(function(cb, i){
		let val = parseInt(cb.value);   // 🔥 IMPORTANT FIX

		if(i === 0){
			srNo = val;
		} else {
			srNo += "," + val;
		}
	});

	// ✅ Validation
	if(total === 0)
	{
		alert("Please select at least one checkbox.");
		return false;
	}

	// ✅ Confirm
	var msg = confirm("To disconfirm approval, Please click on OK");
	if(msg)
	{
		document.getElementById("ridHidden").value = srNo;   // 🔥 use srNo here
		document.getElementById("typeHidden").value = "update";
		document.getElementById("indexHidden").value = index;

		var url = "leaveapproved.jsp";

		try
		{
			if(form.name == "leave")
			{
				document.leave.action = url + "?rid=" + srNo + "&type=update&index=" + index;
				document.leave.submit();
			}
			else if(form.name == "leave1")
			{
				document.leave1.action = url + "?rid=" + srNo + "&type=update&index=" + index;
				document.leave1.submit();
			}
			else
			{
				document.leave2.action = url + "?rid=" + srNo + "&type=update&index=" + index;
				document.leave2.submit();
			}
		}
		catch (e){}
	}
	else
	{
		return false;
	}
}
function onSubmitForNot(form, rid, index)
{
	try
	{
		var cnt;
		if(form.name == "leave")
		{
			cnt = document.leave.cntr.value;
		}
		else if(form.name == "leave1")
		{
			cnt = document.leave1.cntr.value;
		}
		else
		{
			cnt = document.leave2.cntr.value;
		}
	}
	catch (e){}

	// ✅ Get all selected checkboxes
	var checkboxes = document.querySelectorAll("input[type='checkbox']:checked");
	var total = checkboxes.length;
	var srNo = "";

	// ✅ Build comma-separated values (FIX: remove .0)
	checkboxes.forEach(function(cb, i){
		let val = parseInt(cb.value);  // 🔥 IMPORTANT FIX

		if(i === 0){
			srNo = val;
		} else {
			srNo += "," + val;
		}
	});

	// ✅ Validation
	if(total === 0)
	{
		alert("Please select at least one checkbox.");
		return false;
	}

	// ✅ Confirm
	var msg = confirm("To disconfirm approval, Please click on OK");
	if(msg)
	{
		// 🔥 FIX: use srNo instead of rid
		document.getElementById("ridHidden").value = srNo;
		document.getElementById("typeHidden").value = "not";
		document.getElementById("indexHidden").value = index;

		var url = "leaveapproved.jsp";

		try
		{
			if(form.name == "leave")
			{
				document.leave.action = url + "?rid=" + srNo + "&type=not&index=" + index;
				document.leave.submit();
			}
			else if(form.name == "leave1")
			{
				document.leave1.action = url + "?rid=" + srNo + "&type=not&index=" + index;
				document.leave1.submit();
			}
			else
			{
				document.leave2.action = url + "?rid=" + srNo + "&type=not&index=" + index;
				document.leave2.submit();
			}
		}
		catch (e){}
	}
	else
	{
		return false;
	}
}

function onSubmitForCancle(form, rid, index)
{
    alert("in cancel function " + form);

    var msg = confirm("To cancel leave, Please click OK");

    if(!msg){
        return false;
    }

    var url = "leaveapproved.jsp?rid="+rid+"&type=cancel&index="+index;

    try
    {
        var frm = document.forms[form];

        if(!frm){
            alert("Form not found: " + form);
            return false;
        }

        frm.action = url;
        frm.submit();
    }
    catch(e)
    {
        alert("Error: " + e);
    }

    return false;
}



function onSubmitForRevert(rid,index)
{
	alert("hii");
var msg=confirm("To Revert,Please click on OK");
 if(msg==true)
 {
 location.assign("leaveapproved.jsp?rid="+rid+"&type=revert&index="+index+"");
 }
 else
 {
 return false;
 }
}
function submit()
{
	alert(document.selection.name.value);
}
</script>

 <%@ include file="footer.jsp" %>
 </body>
</html>