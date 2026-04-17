<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">	
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" type="image/png" href="images/favicon.png">
<title>GlobalERP</title>
</head>
<body style="background-color:azure;">

<%
String last30Days = "", last60Days = "", last90Days = "", lastOneYear = "", lastTwoYears = "", lastThreeYears = "";

Connection conn = null;
Statement st1 = null, st2 = null, st5 = null;
String GroupName = "";

try {
	conn = connection.getConnect("db_GlobalERP");
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st5 = conn.createStatement();
} catch (Exception e) {
	e.printStackTrace();
}
%>
<%
try {
%>
<br>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> <!-- Added text-center class -->
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637">Ageing Report</h5>
    </div>
</div>

			<form name="formreport" id="formreport" method="get">
				<div class="row col-12">
				<div class="col-md-1"></div>
				
					<div class="col-md-1" style="width: 82px">
						<label for="checkbox"><b>Show Zero</b></label>
						<div class="form-check">
							<input type="checkbox" name="showZero" value="showZero" checked="checked" />
						</div>
					</div>
			
					<div class="col-md-2">
						<label for="dropdown"><b>Balance in range</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="balanceStartRange" name="balanceStartRange">
								<option value="min" selected>MIN</option>
								<option value="0">0</option>
								<option value="10000">&gt;10,000</option>
								<option value="50000">&gt;50,000</option>
								<option value="100000">&gt;1,00,000</option>
								<option value="1000000">&gt;10,00,000</option>
							</select>
							
							 <script>
                            const mySel = document.getElementById("balanceStartRange");
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

					<div class="col-md-2">
						<label for="dropdown"><b>To</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="balanceEndRange" name="balanceEndRange">
								<option value="max" selected>MAX</option>
								<option value="10000">&lt; 10,000</option>
								<option value="50000">&lt; 50,000</option>
								<option value="100000">&lt; 1,00,000</option>
								<option value="1000000">&lt; 10,00,000</option>
							</select>
							<script>
                            const mySel = document.getElementById("balanceEndRange");
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
					<div class="col-md-1">
						<label for="dropdown"><b>Sort by</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="sortBy" name="sortBy">
								<option selected="selected">-</option>
								<option value="amount">Amount</option>
								<option value="lastTransactions">lastTransactions</option>
							</select>
							<script>
                            const mySel = document.getElementById("sortBy");
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


					<div class="col-md-2">
						<label for="input"><b>Active Since(Years)</b></label>
						<input class="form-control" type="text" id="transactionsSince" name="transactionsSince" placeholder=" " style="font-size: 0.7rem;">
						<div id="inputlist"></div>
					</div>


					<div class="col-md-1">
						<label for="dropdown"><b>Group</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="group" name="group">
								<option value="1">Compressor</option>
								<option value="2">DGSet</option>
								<option value="3">DigitalEquipment</option>
								<option value="4">Endoscope</option>
								<option value="all" selected>All</option>
							</select>
						<script>
                            const mySel = document.getElementById("group");
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



					<div class="col-md-2 mt-4">
						<input type="submit" class="btn btn-primary" id="button"
							name="button" value="Submit">

					</div>

				</div>
			</form>
			<br>

			<table id="example" class="display" style="width:100%">
				<thead>
					<tr>

						<th class="col-width-4">Sr.No</th>
						<th>Company</th>
						<th>Branch Name</th>
						<th>Group</th>
						<th>Contact</th>
						<th>Mobile No</th>
						<th>Last Tr. date</th>
						<th>Tr ID</th>
						<th>Current Balance</th>
						<th>>=30</th>
						<th>31-60</th>
						<th>61-90</th>
						<th>= 91</th>
					</tr>
				</thead>
				<tbody>

					<%
					if (request.getQueryString() != null) {
						boolean showZeroBalance = true;
						if (request.getParameter("showZero") == null)
							showZeroBalance = false;
						String startRange = request.getParameter("balanceStartRange");
						String endtRange = request.getParameter("balanceEndRange");
						String sortby = request.getParameter("sortBy");
						String transactionSince = request.getParameter("transactionsSince");
						String group = request.getParameter("group");
						System.out.println(
						startRange + " " + endtRange + " " + sortby + " " + transactionSince + " " + group);

						String balanceBetween = " ";
						if (!(startRange.equalsIgnoreCase("min")))
							balanceBetween = " AND Balance >=" + startRange;
						if (!(endtRange.equalsIgnoreCase("max")))
							balanceBetween += " AND Balance <=" + endtRange;

						String showZeroBalanceInQuery = "";
						if (showZeroBalance)
							showZeroBalanceInQuery = " AND Balance!=0  ";

						String orderBy = " ";

						String category = " ";
						if (!(group.equalsIgnoreCase("all"))) {
							if (group.equalsIgnoreCase("1"))
						category = " AND b.category='1' ";
							else if (group.equalsIgnoreCase("2"))
						category = " AND b.category='2' ";
							else if (group.equalsIgnoreCase("3"))
						category = " AND b.category='3' ";
							else
						category = " AND b.category='4' ";
						}

						String transactionDate = " ";
						if (!(transactionSince.equalsIgnoreCase("all"))) {
							if (transactionSince.equalsIgnoreCase("1"))
						transactionDate = "  AND TransactionDate >= '" + lastOneYear + "' ";
							else if (transactionSince.equalsIgnoreCase("2"))
						transactionDate = "  AND TransactionDate >= '" + lastTwoYears + "' ";
							else
						transactionDate = "  AND TransactionDate >= '" + lastThreeYears + "' ";
						}

						int i = 1;

						String sql = "SELECT CustomerCode, max( TransactionDate )" + " FROM "
						+ session.getAttribute("CompanyMasterID").toString() + "customerledgeraccount where 1  " + transactionDate
						+ " and customercode in (select customercode from " + session.getAttribute("CompanyMasterID").toString()
						+ "customerdet where isdatavalid=1 ) " + " GROUP BY customercode ";

						System.out.println(">>>>   " + sql);

						ResultSet rs = st.executeQuery(sql);
						while (rs.next()) {

							String sqlGroup = "select TheGroupName from " + session.getAttribute("CompanyMasterID").toString()
							+ "tbl_groupmaster where TheGroupCode =(select Category from "
							+ session.getAttribute("CompanyMasterID").toString() + "customerdet where CustomerCode='"
							+ rs.getString("CustomerCode") + "')";
							System.out.println(sqlGroup);
							ResultSet rsGroup = st1.executeQuery(sqlGroup);
							System.out.println(sqlGroup);
							GroupName = "";
							if (rsGroup.next()) {
						GroupName = rsGroup.getString(1);
							}
							String sqlDetails = "SELECT * " + "	FROM " + session.getAttribute("CompanyMasterID").toString()
							+ "customerledgeraccount AS a" + "	INNER JOIN " + session.getAttribute("CompanyMasterID").toString()
							+ "customerdet AS b ON ( a.customercode = b.customercode )" + "	WHERE a.CustomerCode ='"
							+ rs.getString("CustomerCode") + "' " + category
							+ "  order by a.TransactionDate desc,a.TransactionId desc";
							System.out.println(sqlDetails);

							ResultSet rsDetails = st1.executeQuery(sqlDetails);
							if (rsDetails.next()) {

						String sqlSum = " SELECT sum( debitamount ) , 90 AS a     " + "  FROM "
								+ session.getAttribute("CompanyMasterID").toString()
								+ "customerledgeraccount                        " + "  WHERE transactiondate < '" + last90Days
								+ "'                " + "  AND customercode = '" + rs.getString("CustomerCode")
								+ "'                              " + "  UNION                                               "
								+ "  SELECT sum( debitamount ) , 6090 AS b                  " + "  FROM "
								+ session.getAttribute("CompanyMasterID").toString()
								+ "customerledgeraccount                        " + "  WHERE transactiondate < '" + last60Days
								+ "'                " + "  AND transactiondate >= '" + last90Days + "'                  "
								+ "  AND customercode = '" + rs.getString("CustomerCode") + "'                              "
								+ "  UNION                                               "
								+ "  SELECT sum( debitamount ) , 3060 AS c                  " + "  FROM "
								+ session.getAttribute("CompanyMasterID").toString()
								+ "customerledgeraccount                        " + "  WHERE transactiondate < '" + last30Days
								+ "'                " + "  AND transactiondate >= '" + last60Days + "'                  "
								+ "  AND customercode = '" + rs.getString("CustomerCode") + "'                              "
								+ "  UNION                                               "
								+ "  SELECT sum( debitamount ) , 30 AS d                  " + "  FROM "
								+ session.getAttribute("CompanyMasterID").toString()
								+ "customerledgeraccount                        " + "  WHERE transactiondate >= '" + last30Days
								+ "'                " + "  AND customercode = '" + rs.getString("CustomerCode")
								+ "'                              " + "  UNION                                               "
								+ "  SELECT sum(debitamount), 5 AS e                  " + "  FROM "
								+ session.getAttribute("CompanyMasterID").toString()
								+ "customerledgeraccount                        " + "  WHERE customercode = '"
								+ rs.getString("CustomerCode") + "'                              "
								+ "  UNION                                               "
								+ "  SELECT sum( creditamount ) , 6 AS f                 " + "  FROM "
								+ session.getAttribute("CompanyMasterID").toString()
								+ "customerledgeraccount                        " + "  WHERE customercode = '"
								+ rs.getString("CustomerCode") + "' 							";
						System.out.println(">>>>   " + sqlSum);
						ResultSet rsSum = st2.executeQuery(sqlSum);

						double thirty = 0, sixty = 0, ninety = 0, moreThanninety = 0;
						double thirtyDeduction = 0, sixtyDeduction = 0, ninetyDeduction = 0, moreThanninetyDeduction = 0;

						double creditAmount = 0, debitAmount = 0, totalCreditAmount = 0;
						moreThanninety = 0;
						if (rsSum.next())
							moreThanninety = rsSum.getDouble(1);

						if (rsSum.next())
							ninety = (rsSum.getString(1) == null ? 0 : rsSum.getDouble(1));

						if (rsSum.next())
							sixty = (rsSum.getString(1) == null ? 0 : rsSum.getDouble(1));

						if (rsSum.next())
							thirty = (rsSum.getString(1) == null ? 0 : rsSum.getDouble(1));

						if (rsSum.next())
							debitAmount = (rsSum.getString(1) == null ? 0 : rsSum.getDouble(1));

						if (rsSum.next())
							totalCreditAmount = creditAmount = (rsSum.getString(1) == null ? 0 : rsSum.getDouble(1));

						if (moreThanninety >= creditAmount) {
							moreThanninetyDeduction = moreThanninety - creditAmount;
							thirtyDeduction = thirty;
							sixtyDeduction = sixty;
							ninetyDeduction = ninety;
						} else if (moreThanninety < creditAmount) {
							moreThanninetyDeduction = 0;
							creditAmount = creditAmount - moreThanninety;

							if (ninety >= creditAmount) {
								ninetyDeduction = ninety - creditAmount;
								thirtyDeduction = thirty;
								sixtyDeduction = sixty;
							} else {
								ninetyDeduction = 0;
								creditAmount = creditAmount - ninety;

								if (sixty >= creditAmount) {
									sixtyDeduction = sixty - creditAmount;
									thirtyDeduction = thirty;
								} else {
									sixtyDeduction = 0;
									creditAmount = creditAmount - sixty;
									//System.out.println("?????  "+thirty+"  "+creditAmount);
									if (thirty >= creditAmount) {
										thirtyDeduction = thirty - creditAmount;
									} else {
										thirtyDeduction = 0;
										creditAmount = creditAmount - thirty;
									}
								}
							}
						}

						if (creditAmount > debitAmount) {
							moreThanninetyDeduction = thirtyDeduction = sixtyDeduction = ninetyDeduction = 0;
						}

						boolean proceed = true;
						if (((debitAmount - totalCreditAmount) == 0 && showZeroBalance == false))
							proceed = false;
						if (proceed) {
					%>
					<tr>
						<td class="text-center"><%=i++%></td>

						<td class="text-left"><a href="#" onclick="popUp('customerDetails.jsp','<%=rsDetails.getString("CompanyName")%>','Customer','<%=rs.getString("CustomerCode")%>')"><%=rsDetails.getString("CompanyName")%></a></td>
						<td class="text-left"> <%=rsDetails.getString("BranchName")%> </td>
						<%
						if (GroupName == "") {
							GroupName = "-";
						}
						%>

						<td class="text-left"> <%=GroupName%></td>
						<td class="text-left"><%=rsDetails.getString("ContactPerson")%></td>
						<td class="text-center"><%=rsDetails.getString("MobileNo")%></td>
						<td class="text-right"> 
								<%
								try {
								%><%=new SimpleDateFormat("dd-MMM-yyyy")
							.format(new SimpleDateFormat("yyyy-MM-dd").parse(rsDetails.getString("TransactionDate")))%>
								<%
								} catch (Exception e) {
								System.out.println(e);
								}
								%>
							
						</td>
						<td class="text-center"><%=rsDetails.getString("transactionid")%></td>
						<%
						String STPCQuery = "select * from db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
								+ "prospectivecustmaster where CompanyName='" + rsDetails.getString("CompanyName") + "'";
						System.out.println("STPCQuery--->" + STPCQuery);
						String CompanyName = "", ContactPerson = "", Phone = "", EMail = "", City = "", IntrestedProduct = "";
						ResultSet STPCRS = st5.executeQuery(STPCQuery);
						if (STPCRS.next()) {

							CompanyName = STPCRS.getString("CompanyName");
							ContactPerson = STPCRS.getString("ContactPerson");
							Phone = STPCRS.getString("Phone");
							EMail = STPCRS.getString("EMail");
							City = STPCRS.getString("City");
							IntrestedProduct = STPCRS.getString("IntrestedProduct");

						}
						%>
						<td class="text-left"><a href="ledgerdetails.jsp?companyName=<%=CompanyName%>&customercode=<%=rs.getString("CustomerCode")%>&companyPerson=<%=ContactPerson%>&companyPhone=<%=Phone%>&companyEmail=<%=EMail%>&companyCity=<%=City%>&companyProduct=<%=IntrestedProduct%>"><%=new DecimalFormat("0.00").format(debitAmount - totalCreditAmount)%></a></td>
						<td class="text-right"> <%=new DecimalFormat("0.00").format(thirtyDeduction)%></td>
						<td class="text-right"><%=new DecimalFormat("0.00").format(sixtyDeduction)%> </td>
						<td class="text-right"> <%=new DecimalFormat("0.00").format(ninetyDeduction)%> </td>
						<td class="text-right"><%=new DecimalFormat("0.00").format(moreThanninetyDeduction)%></td>
					</tr>

					<%
					}
					}
					}
					}
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</tbody>
			</table>
		</div>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	       /* fixedColumns : {
			left : 3	
	       }, */
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)	  
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
	                         title: 'Aging Report Details',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Aging Report Details',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Aging Report Details',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Aging Report Details',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Aging Report Details',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>

<script>
			function popUp(webadd,company,type,customercode)
			{ 
				window.open('customerDetails.jsp'+'?companyName='+company+'&customercode='+customercode+'&type='+type,'jav','width=750,height=670,top=30,left=300,resizable=no');
			}
</script>
	<%@ include file="footer.jsp"%>
</body>
</html>