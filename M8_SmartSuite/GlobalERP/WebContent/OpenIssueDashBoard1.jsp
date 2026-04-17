 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
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
Connection con;
ResultSet rs = null, rs1 = null,rs2=null,rs3=null;
Statement stmt = null,stmt1=null,stmt2=null;


String datenew1 = "", datenew2 = "", sql_active = "";
String targetClosure = "", date1 = "", date2 = "", dept = "", user_id1 = "", tDate1 = "", tDate2 = "", EmpName = "";
int OpenCount = 0, CloseCount = 0, WIPCount = 0, RejectCount = 0, HangCount = 0;
int GrandTotalSum = 0, OpenCountSum = 0, WIPCountSum = 0, RejectCountSum = 0, CloseCountSum = 0, GrandTotal = 0,totalCount=0, i = 0, statusCount = 0;
String concernPerson = "", sql = "",nothingCount="",hangCount="", priority = "", Status = "", ReportedDate = "";

try {
	con = connection.getConnect("db_GlobalERP");    
 	stmt=con.createStatement();
 	stmt1 = con.createStatement();
 	stmt2 = con.createStatement();
} catch (Exception e) {
 e.printStackTrace();
} 



String Bt = request.getParameter("button");
String concernName = request.getParameter("EmpName");
datenew1 = request.getParameter("from_date1");
datenew2 = request.getParameter("to_date1");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");
String Sesrole1 = session.getAttribute("role").toString();

System.out.println("Ses role :- " + Sesrole1);

if (datenew1 == null) {

	System.out.println("==in if==");

	Calendar cal = Calendar.getInstance();
	String today_dt = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	String data2 = today_dt;
	String temp = data2;
	String toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	//cal.add(Calendar.DATE, -1);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	//System.out.println("Current Date"+new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime()));
	String data1 = yesterday_dt;
	temp = data1;
	System.out.println("Current Temp " +temp);
	String fromDate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String fromDate1 = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

	if (Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin")) {
		tDate1 = datenew1;
		tDate2 = datenew2;
	} else {
		tDate1 = datenew1;
		tDate2 = datenew2;
	}
} else {
	System.out.println("==in else==");
	date1 = datenew1;
	date2 = datenew2;

	tDate1 = date1;
	tDate2 = date2;
}

DateFormat df123 = new SimpleDateFormat("dd-MMM-yyyy");
DateFormat df1234 = new SimpleDateFormat("yyyy-MM-dd");
String dataDate1 = df1234.format(df123.parse(tDate1));
System.out.println("Data date 1 = " + dataDate1);
String dataDate2 = df1234.format(df123.parse(datenew2));

String name = session.getAttribute("EmpName").toString();
String sessiondept = session.getAttribute("department").toString();
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h2 class="content-header-title text-center mb-0" style="color: #060637;font-size:20px">Developer Wise Dashboard</h2>
    </div>
</div>
  <form name="openissuereport" id="openissuereport" method="post">
 <input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
	<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />

		    <div class="row col-12">
		    <div class="col-md-2"></div>
		    <div class="col-md-2">
				  <label for="dropdown"><b>Name</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="EmpName" name="EmpName">
			            <%
									sql_active = "select distinct(EmpName) as EmpName from db_GlobalERP.UserMaster WHERE dept = 'software' and ActiveStatus = 'Yes' and dotprojectid!='-' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by EmpName";
									%>
									<%
									rs = st.executeQuery(sql_active);
									System.out.println("query " + sql_active);
									String selectedEmpName = request.getParameter("EmpName"); // Capture the selected value
									%>
									<option value="All" <%= "All".equals(selectedEmpName) ? "selected" : "" %>>All</option>
									<%
									while (rs.next()) {

										EmpName = rs.getString("EmpName");

										System.out.println("department-->" + EmpName);
										boolean isSelected = EmpName.equals(selectedEmpName);
									%>

									<option value="<%= EmpName %>" <%= isSelected ? "selected" : "" %>><%= EmpName %></option>
									<%
									}
									%>


							</select>
		   				 
		   				  <script>
                            const mySel = document.getElementById("companyName1");
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; 
                             } else if (savedValue) {
                              mySel.value = savedValue;
                               }
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value);
                               });
                             </script>	
		    </div>
		    </div>
				<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="from_date1" id="data"  class="form-control" value="<%=datenew1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="to_date1"  class="form-control" value="<%=datenew2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
			<div class="col-md-2"></div>
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
 <br>

<%
try{
if (Bt == null || Bt.equals("null")) {
	System.out.println("in if");
	 sql="SELECT Concern,"
			 + "(SELECT count(*) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS total,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Close' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS close,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Hang' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Hang,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Open' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Open,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'WIP' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS WIP,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Reject' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Reject,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = '-' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Nothing "
			 + "FROM (SELECT DISTINCT (Concern) as Concern FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"' and Department in ('software' ,'All')) AS main";
			
	System.out.println("Sql Query == null " + sql);
}
else {
	System.out.println("in else");
	if(concernName=="All" || concernName.equalsIgnoreCase("All")){

		concernName="";
		sql="SELECT Concern,"
				 + "(SELECT count(*) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"' and Status!='Hang' and Status!='-') AS total ,"
				 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Close' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS close,"
				 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Hang' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Hang,"
				 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Open' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Open,"
				 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'WIP' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS WIP,"
				 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Reject' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Reject,"
				 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = '-' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Nothing "
				 + "FROM (SELECT DISTINCT (Concern) as Concern FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"' and Department in ('software' ,'All') and Concern like'%"+concernName+"%') AS main";
				
		System.out.println("Sql Query == " + sql);
	}
	sql="SELECT Concern,"
			 + "(SELECT count(*) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"' and Status!='Hang' and Status!='-') AS total ,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Close' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS close,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Hang' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Hang,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Open' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Open,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'WIP' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS WIP,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = 'Reject' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Reject,"
			 + "(SELECT COUNT(Status) FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker WHERE Status = '-' AND Concern = main.Concern and ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"') AS Nothing "
			 + "FROM (SELECT DISTINCT (Concern) as Concern FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"OpenIssueTracker where ReportedDate >='"+dataDate1+"' and ReportedDate <='"+dataDate2+"' and Department in ('software' ,'All') and Concern like'%"+concernName+"%') AS main";
			
	System.out.println("Sql Query one person == " + sql);
	
	
}

%>
	<div class="main-container">
    <div class="row"> <!-- Corrected from .table-row -->
        <!-- Left Column: Table -->
        <div class="col-md-7">
            <div class="card custom-card" id="datatableCard" style="margin-left: 2%;">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="dataTable" class="display table table-bordered table-hover" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>Allocate To</th>
                                    <th>Total</th>
                                    <th>Open</th>
                                    <th>WIP</th>
                                    <th>Reject</th>
                                    <th>Close</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    rs1 = stmt.executeQuery(sql);
                                    while (rs1.next()) {
                                        concernPerson = rs1.getString("Concern");
                                        GrandTotal = rs1.getInt("total");
                                        OpenCount = rs1.getInt("Open");
                                        WIPCount = rs1.getInt("WIP");
                                        RejectCount = rs1.getInt("Reject");
                                        CloseCount = rs1.getInt("Close");
                                %>
                                <tr>
                                    <td class="text-left"><%=concernPerson%></td>
                                    <td class="text-center"><%=GrandTotal%></td>
                                    <td class="text-center"><%=OpenCount%></td>
                                    <td class="text-center"><%=WIPCount%></td>
                                    <td class="text-center"><%=RejectCount%></td>
                                    <td class="text-center"><%=CloseCount%></td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr style="background-color:#D8E5F3;">
                                    <%
                                        rs2 = stmt2.executeQuery(sql);
                                        while (rs2.next()) {
                                            GrandTotal = rs2.getInt("total");
                                            OpenCount = rs2.getInt("Open");
                                            WIPCount = rs2.getInt("WIP");
                                            RejectCount = rs2.getInt("Reject");
                                            CloseCount = rs2.getInt("Close");

                                            GrandTotalSum += GrandTotal;
                                            OpenCountSum += OpenCount;
                                            WIPCountSum += WIPCount;
                                            RejectCountSum += RejectCount;
                                            CloseCountSum += CloseCount;
                                        }
                                    %>
                                    <th>Total</th>
                                    <th class="text-center"><%=GrandTotalSum%></th>
                                    <th class="text-center"><%=OpenCountSum%></th>
                                    <th class="text-center"><%=WIPCountSum%></th>
                                    <th class="text-center"><%=RejectCountSum%></th>
                                    <th class="text-center"><%=CloseCountSum%></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column: Pie Chart -->
        <div class="col-md-5">
            <div class="card custom-card" id="pieCard">
                <div class="card-body">
                    <div class="card-responsive">
                        <canvas id="myPieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
	
	
	
	
	
 </div>  

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Prepare data for the pie chart
        var data = {
            labels: ['Open', 'WIP', 'Reject', 'Close'],
            datasets: [{
                data: [<%= OpenCountSum %>, <%= WIPCountSum %>, <%= RejectCountSum %>, <%= CloseCountSum %>],
                backgroundColor: ['red', 'blue', 'yellow', 'green'],
            }]
        };

        // Get the canvas element
        var ctx = document.getElementById('myPieChart').getContext('2d');

        // Create the pie chart using Chart.js
        var myPieChart = new Chart(ctx, {
            type: 'pie',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: true,
                    position: 'bottom',
                },
            },
        });
    </script>
    
<script>
	$(document).ready(function() {
		// Initialize DataTable
		$('#dataTable').DataTable({
		// Disable entries display, search bar, and pagination
			searching: false,
	        lengthMenu: [[5, 10, 25, 50, 100,-1], [5, 10, 25, 50, 100,"All" ]],
	       
	        search: false,
	        scrollY: 150,
		});
	});
</script>


 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>

 <%@ include file="footer.jsp" %>
 </body>
</html>