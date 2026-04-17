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
// Variable Declaration

String Customer = "",city="",nxtfollowDttime = " ", NextFollowDt =" ", NextFollowtime=" ";
String mrktName = "";
	String todaysDate = session.getAttribute("today").toString(); 
	String yesterdaysDate=session.getAttribute("Yesterday").toString();
	LocalDate tomorrow = LocalDate.now().plusDays(1);
	String tomoDate = tomorrow.toString();  // Already in yyyy-MM-dd format
	System.out.println(tomoDate);

 // Connection Initialization
Connection conn = null;
Statement st = null,st1= null,st2= null,st3= null,st4= null,st5= null,st6= null,st7= null,st8= null,st9= null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 
%>  
<%
try{

String code = request.getParameter("Code1");
String Custcount = request.getParameter("count1");
String number = request.getParameter("number");
String dt1 = request.getParameter("dt1");
String dt2 = request.getParameter("dt2");

String sqlMarktRep = "Select MarketingRepName  from "+ session.getAttribute("CompanyMasterID").toString()+ "marketingrepmaster where MarketingRepCode='" + code + "'";
	ResultSet rsMrktRep = st.executeQuery(sqlMarktRep);
	System.out.println(sqlMarktRep);
	while (rsMrktRep.next()) {
	
		mrktName = rsMrktRep.getString("MarketingRepName");
	}
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> <!-- Added text-center class -->
    <div class="row breadcrumbs-top">
         <h5 class="content-header-title text-center mb-0" style="color: #060637"><%=mrktName%> Customers</h5>
    </div>
</div>
 <br>
<table id="example" class="display" style="width:100%">        
       <thead>
            <tr>
            		<th class="col-width-4">SrNo.</th>
					<th>Company</th>
					<th>Contact Person</th>
					<th>Phone</th>
					<th>Mobile</th>
					<th>City</th>
					<th>Next FollowUp</th>
					<th>FollowUps</th>
	        
            </tr>
        </thead> 
        <tbody>
        <%
						int j = 1;
						

						ResultSet rsList = null;

						if (number.contains("1")) {
							String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "
									+ session.getAttribute("CompanyMasterID").toString() + "followup where MarketingRepcode='"
									+ code + "' AND ProspCustName <> '-'  Group By ProspCustName";
							System.out.println("1st If Query===>" + sqlList);
							rsList = st1.executeQuery(sqlList);
							System.out.println(sqlList);

						} else if (number.contains("2")) {
							System.out.println("IN    2nd    IF for followup customer*********");

									String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "
									+ session.getAttribute("CompanyMasterID").toString() + "followup where MarketingRepcode='"
									+ code + "' AND ProspCustName <> '-' AND FollowUpDate < '" + dt1 + "' and FollowUpDate > '"
									+ dt2 + "' Group By ProspCustName";

							System.out.println(sqlList);
							rsList = st1.executeQuery(sqlList);
							System.out.println(sqlList);

						} else if (number.contains("3")) {

							String sqlList = "SELECT * FROM db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
									+ "followup Group By ProspCustName having max(NextFollowUpDate)  Between '" + dt2
									+ "' AND '" + dt1 + "' and MarketingRepcode = '" + code + "'";
							System.out.println("3rd If Qry=====>" + sqlList);
							rsList = st1.executeQuery(sqlList);

						} else if (number.contains("4")) {

							String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "
									+ session.getAttribute("CompanyMasterID").toString() + "followup where MarketingRepcode='"
									+ code + "' AND ProspCustName <> '-'  AND  FollowUpDate = '" + yesterdaysDate + "' ";
							System.out.println(sqlList);
							rsList = st1.executeQuery(sqlList);
							System.out.println(sqlList);
						} else if (number.contains("5")) {

							String sqlList = "SELECT * FROM db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
									+ "followup Group By ProspCustName having max(NextFollowUpDate)='" + yesterdaysDate
									+ "'  and MarketingRepcode = '" + code + "'";
							System.out.println(sqlList);
							rsList = st1.executeQuery(sqlList);

						} else if (number.contains("6")) {

							String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "
									+ session.getAttribute("CompanyMasterID").toString() + "followup where MarketingRepcode='"
									+ code + "' AND ProspCustName <> '-'  AND  NextFollowUpDate = '" + todaysDate + "' ";
							System.out.println(sqlList);
							rsList = st1.executeQuery(sqlList);
							System.out.println(sqlList);
						} else if (number.contains("7")) {

							String sqlList = "select ProspCustName,ContactPerson,Address,City,ProspCustCode from "
									+ session.getAttribute("CompanyMasterID").toString() + "followup where MarketingRepcode='"
									+ code + "' AND ProspCustName <> '-'  AND  NextFollowUpDate = '" + tomoDate + "'";
							System.out.println(sqlList);
							rsList = st1.executeQuery(sqlList);
							System.out.println(sqlList);
						} else {
							System.out.println("Inside elseee@*@*@*@*@*");
						}

						List<String> CustName = new ArrayList<String>();

						while (rsList.next()) {
							Customer = rsList.getString("ProspCustName");
							String custcode1 = rsList.getString("ProspCustCode");

							if (!Customer.equals("null")) {
								int count = 0;
								String sqlCount = null;

								sqlCount = "Select ProspCustName from " + session.getAttribute("CompanyMasterID").toString()
										+ "followup where ProspCustName='" + Customer + "' AND FollowUpDate < '" + dt1
										+ "' and FollowUpDate > '" + dt2 + "'";

								ResultSet rsCount = st.executeQuery(sqlCount);
								System.out.println("*********************************      " + sqlCount);
								while (rsCount.next()) {
									count++;
									String abc = rsCount.getString("ProspCustName");
									CustName.add(abc);
								}

								for (String s : CustName) {
									//  System.out.println("Customer Name===>"+s);
								}
								System.out.println("CNT******==>>>" + count);

								String phone = "", email = "", mobile = "", City = "", Product = "", salescode = "", type = "";

								String sqldata = "Select Phone,EMail,MobileNo,SalesCustomerCode,City,IntrestedProduct from "
										+ session.getAttribute("CompanyMasterID").toString() + "prospectivecustmaster "
										+ "where CompanyName='" + Customer.trim() + "'";

								System.out.println("sqldata " + sqldata);
								ResultSet rsdata = st.executeQuery(sqldata);
								if (rsdata.next()) {

									phone = rsdata.getString("Phone");
									email = rsdata.getString("EMail");
									mobile = rsdata.getString("MobileNo");
									City = rsdata.getString("City");
									Product = rsdata.getString("IntrestedProduct");
									salescode = rsdata.getString("SalesCustomerCode");

									if (salescode == "0" || salescode.equals("0")) {
										type = "Prospect";
									} else {
										type = "Customer";
									}
								}

								if (number.contains("2")) {

									System.out.println("Next Followup date For Contain 2");

									String Sqlfollow = "select * from " + session.getAttribute("CompanyMasterID").toString()
											+ "followup where MarketingRepcode='" + code
											+ "' AND  ProspCustName <> '-' AND ProspCustCode ='" + custcode1
											+ "' AND  FollowUpDate < '" + dt1 + "' and FollowUpDate > '" + dt2
											+ "' Group By ProspCustName";
									System.out.println("Sqlfollowup " + Sqlfollow);
									ResultSet followup = st4.executeQuery(Sqlfollow);

									if (followup.next()) {
										System.out.println("iinnnifffff");
										 NextFollowDt = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd")
														.parse(followup.getString("NextFollowUpDate")));
										 NextFollowtime = followup.getString("NextFollowUpTime");
										nxtfollowDttime = NextFollowDt + " " + NextFollowtime;

										System.out.println(j + "Dttime " + nxtfollowDttime);
									} 
								}
								if (number.contains("3")) {

									String Sqlfollow = "SELECT * FROM db_GlobalERP."
											+ session.getAttribute("CompanyMasterID").toString()
											+ "followup Group By ProspCustName having max(NextFollowUpDate)  Between '" + dt2
											+ "' AND '" + dt1 + "'  and MarketingRepcode = '" + code + "'  AND ProspCustCode ='"
											+ custcode1 + "'";

									System.out.println("Sqlfollowup " + Sqlfollow);
									ResultSet followup = st5.executeQuery(Sqlfollow);

									if (followup.next()) {

										System.out.println("Inifffff");
										 NextFollowDt = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd")
														.parse(followup.getString("NextFollowUpDate")));
										 	NextFollowtime = followup.getString("NextFollowUpTime");
											nxtfollowDttime = NextFollowDt + " " + NextFollowtime;
										System.out.println(j + "Dttime " + nxtfollowDttime);
									}
								}
								
								if (number.contains("4")) {

									System.out.println("Next Followup date For Contain 4");

									String Sqlfollow = "select * from  " + session.getAttribute("CompanyMasterID").toString()
											+ "followup where MarketingRepcode= '" + code
											+ "' AND ProspCustName <> '-' AND ProspCustCode ='" + custcode1
											+ "' AND  NextFollowUpDate =  '" + yesterdaysDate + "' ";
									System.out.println("Sqlfollowup " + Sqlfollow);
									System.out.println("iinnniffff ");
									ResultSet followup = st6.executeQuery(Sqlfollow);

									if (followup.next()) {
										 NextFollowDt = new SimpleDateFormat("dd-MMM-yyyy") .format(new SimpleDateFormat("yyyy-MM-dd").parse(followup.getString("NextFollowUpDate")));
										 NextFollowtime = followup.getString("NextFollowUpTime");
										nxtfollowDttime = NextFollowDt + " " + NextFollowtime;
										System.out.println(j + "Dttime " + nxtfollowDttime);
									} 
								}

								if (number.contains("5")) {
									nxtfollowDttime = "-";
								} 
								
								if (number.contains("6")) {
									System.out.println("Next Followup date For Contain 6");

									String Sqlfollow = "select * from  " + session.getAttribute("CompanyMasterID").toString()
											+ "followup where MarketingRepcode= '" + code
											+ "' AND ProspCustName <> '-' AND ProspCustCode ='" + custcode1
											+ "' AND  NextFollowUpDate =  '" + todaysDate + "' ";
									System.out.println("Sqlfollowup " + Sqlfollow);
									ResultSet followup = st7.executeQuery(Sqlfollow);

									if (followup.next()) {

										 NextFollowDt = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd")
														.parse(followup.getString("NextFollowUpDate")));
										 NextFollowtime = followup.getString("NextFollowUpTime");
										nxtfollowDttime = NextFollowDt + " " + NextFollowtime;
										System.out.println(j + "Dttime " + nxtfollowDttime);
									} 
								}
								if (number.contains("7")) {
									System.out.println("Next Followup date For Contain 7");

									nxtfollowDttime = "";
									String Sqlfollow = "select * from  " + session.getAttribute("CompanyMasterID").toString()
											+ "followup where MarketingRepcode= '" + code
											+ "' AND ProspCustName <> '-' AND ProspCustCode ='" + custcode1
											+ "' AND  NextFollowUpDate =  '" + tomoDate + "' ";
									System.out.println("Sqlfollowup " + Sqlfollow);
									ResultSet followup = st8.executeQuery(Sqlfollow);
									System.out.println("Sqlfollowu " + Sqlfollow);
									if (followup.next()) {

										 NextFollowDt = new SimpleDateFormat("dd-MMM-yyyy")
												.format(new SimpleDateFormat("yyyy-MM-dd")
														.parse(followup.getString("NextFollowUpDate")));
										 NextFollowtime = followup.getString("NextFollowUpTime");
										nxtfollowDttime = NextFollowDt + " " + NextFollowtime;
										System.out.println(j + "Dttime " + nxtfollowDttime);
									} 
								}
				%>
        <tr>
					<td class="text-center"><%=j%></td>
					<td class="text-left"><%=Customer%></td>
					<td class="text-left"><%=rsList.getString("ContactPerson")%></td>
					<td class="text-center"><%=phone%></td>
					<td class="text-center"><%=mobile%></td>
					<%
					if (city.contains("null")|| city.isEmpty()) { 
						city = "-";
					}
				%>
					<td class="text-left"><%=city%></td>
					<td class="text-right"><%=nxtfollowDttime%></td>
					<td class="text-center">
							<a href="#"
								onclick="followupPopup('customerFollowupThirdLevel.jsp','<%=Customer%>','<%=rsList.getString("ContactPerson")%>','<%=phone%>','<%=email%>','<%=City%>','<%=Product%>','<%=dt2%>','<%=dt1%>')"><%=count%></a>
						</td>

				</tr>
				<%
					j++;

							} //end of if
						} //end of while loop
				%>
        
        </tbody>
 </table>
 </div>

 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
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
	                         title: 'Customers of <%=mrktName%>',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Customers of <%=mrktName%>',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Customers of <%=mrktName%>',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Customers of <%=mrktName%>',
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Customers of <%=mrktName%>',
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>
<script type="text/javascript">
		function followupPopup(webadd, companyName, companyPerson,
				companyPhone, companyEmail, companyCity, companyProduct,
				fromdate, todate) {

			window.location = webadd + '?companyName=' + companyName
					+ '&companyPerson=' + companyPerson + '&companyPhone='
					+ companyPhone + '&companyEmail=' + companyEmail
					+ '&companyCity=' + companyCity + '&companyProduct='
					+ companyProduct + '&fromdate=' + fromdate + '&todate='
					+ todate;

		}
	</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>