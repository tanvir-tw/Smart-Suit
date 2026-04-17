<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import=" java.text.*"
	import="moreservlets.listeners.*" errorPage=""%>
<%@ include file="headernew.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GlobalERP</title>
<link rel="stylesheet" href="cssnew/newentryform.css" />

</head>
<body style="background-color: azure;">
	<%
	  // 1. Declare variables
    String category, customerType, frequency, billType, toId, toCc;
    String billStatus, operationalStatus, rate, companyCode, companyName;
    String coreForms, loginName, password, isDataValid, custDisc;
    String creditLimit, paymentTerms, paymentMode, telephone2, vendorCode, tallyName;
    String transactionExisted;
	Statement stdynamicdrop = null, st2 = null, st = null, st3 = null, st90 = null;
	String category1 = "";
	String CustomerType1 = "";
	String Frequency1 = "";
	String BillType1 = " ";
	String ToId1 = " ", ToCc1 = " ", BillStatus1 = "", OperationalStatus1 = "", Rate1 = "";
	%>

	<%
	// Connection Initialization
	Connection con = null;
	try {
		con = connection.getConnect("db_GlobalERP");

		stdynamicdrop = con.createStatement();
		st2 = con.createStatement();
		st = con.createStatement();
		st3 = con.createStatement();
		st90 = con.createStatement();

	} catch (Exception e) {
		e.printStackTrace();
	}

	companyCode = request.getParameter("companyCode");
	System.out.println("companyCodecompanyCodecompanyCode-------------" + companyCode);
	%>

	<%
	try {
		String sqlte = "SELECT TypeValue as Customer,ERPCode,category,CustomerType,ERPTransporterRate as Rate ,BillFrequency as Frequency,BillType,ToId,ToCc,BillStatus,OperationalStatus FROM db_gps.t_transporter where  ERPCode="
		+ companyCode + " ";
		ResultSet rscat = st90.executeQuery(sqlte);
		if (rscat.next()) {
			category1 = rscat.getString("category");
			CustomerType1 = rscat.getString("CustomerType");
			Frequency1 = rscat.getString("Frequency");
			BillType1 = rscat.getString("BillType");
			ToId1 = rscat.getString("ToId");
			ToCc1 = rscat.getString("ToCc");
			BillStatus1 = rscat.getString("BillStatus");
			Rate1 = rscat.getString("Rate");
			OperationalStatus1 = rscat.getString("OperationalStatus");
		}
	%>


	<%
	String sql = "SELECT * from db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
			+ "customerdet where CustomerCode = '" + request.getParameter("companyCode") + "' limit 1";

	System.out.println(sql);
	ResultSet rs = st.executeQuery(sql);
	if (rs.next()) {
		    category = rscat.getString("category");
		    customerType = rscat.getString("CustomerType");
		    frequency = rscat.getString("Frequency");
		    billType = rscat.getString("BillType");
		    toId = rscat.getString("ToId");
		    toCc = rscat.getString("ToCc");
		    billStatus = rscat.getString("BillStatus");
		    operationalStatus = rscat.getString("OperationalStatus");
		    rate = rscat.getString("Rate");
		    companyCode = rs.getString("CustomerCode");
		    companyName = rs.getString("CompanyName");
		    coreForms = rs.getString("CorEForms");
		    loginName = rs.getString("LoginName");
		    password = rs.getString("CustPassword");
		    isDataValid = rs.getString("IsDataValid");
		    custDisc = rs.getString("CustDiscountPercent");
		    creditLimit = rs.getString("CustCreditLimit");
		    paymentTerms = rs.getString("CustPaymentTerms");
		    paymentMode = rs.getString("CustPaymentMode");
		    telephone2 = rs.getString("TelephoneNo2");
		    vendorCode = rs.getString("VendorCode");
		    tallyName = rs.getString("TallyName");
		    transactionExisted = rs.getString("TransactionExisted");
	%>
	<div class="container-fluid mt-2" id="main">
		<div class="container">
			<section class="container" style="max-width: 1000px;"
				id="basic--layouts">

				<div class="row">
					<div class="col-md-12 col-12">
						<div class="card" style="background-color: transparent;">
							<div class="card-body">
											<div class="row breadcrumbs-top">		          		                    
		          		                      <h5 class="content-header-title text-center mb-0" style="color: #060637">Edit Billing Details of <%=rs.getString("CompanyName") %></h5>
		    		                      </div>
		    		                      <br>
							
								<form name="addCustomer" method="post" action="billingUpdate.jsp" onSubmit="return ValidateEmail() && ValidateEmail1() && ratevalidate()">
									<div class="card shadow-lg mb-4 rounded-3">
								<div class="card-body">
										
											<div class="row col-12 mt-4">
												<div class="col-4 ">
													<div class="input-container">
														<label class="tcolor">Category</label> 
														<select name="category" id="category" class="form-select">
														<option value="<%=category1%>"><%=category1%></option>
															<%
															String sqlDropdown = "SELECT distinct category FROM db_gps.t_transporter";
															ResultSet rsDropdown = st2.executeQuery(sqlDropdown);
															while (rsDropdown.next()) {
															%>
															<option value="<%=rsDropdown.getString("category")%>">
																<%=rsDropdown.getString("category")%></option>

															<%
															}
															%>
														</select>

													</div>
												</div>


												<div class="col-4 ">
													<div class="input-container">
														<label class="tcolor">Customer Type</label> <select
															name="customertype" id="customertype" class="form-select">
															<option value="<%=CustomerType1%>"><%=CustomerType1%></option>
															<%
															String sqlDropdown2 = "SELECT distinct CustomerType FROM db_gps.t_transporter";
															ResultSet rsDropdown2 = st2.executeQuery(sqlDropdown2);
															while (rsDropdown2.next()) {
															%>
															<option
																value="<%=rsDropdown2.getString("CustomerType")%>">
																<%=rsDropdown2.getString("CustomerType")%></option>

															<%
															}
															%>
														</select>

													</div>
												</div>

												<div class="col-4 ">
													<div class="input-container">
														<label class="tcolor">Operational Status</label> <select
															name="operationalstatus" id="operationalstatus"
															class="form-select">
															<option value="<%=OperationalStatus1%>"><%=OperationalStatus1%></option>
															<%
															String sqlDropdown6 = "SELECT distinct OperationalStatus FROM db_gps.t_transporter";
															ResultSet rsDropdown6 = st2.executeQuery(sqlDropdown6);
															while (rsDropdown6.next()) {
															%>
															<option
																value="<%=rsDropdown6.getString("OperationalStatus")%>">
																<%=rsDropdown6.getString("OperationalStatus")%></option>

															<%
															}
															%>
														</select>
													</div>
												</div>
											</div>
											<div class="row col-12 mt-4">
												<div class="col-4 ">
													<div class="input-container">
														<input class="form-control floating-input" type="text"
															id="rate" name="rate"
															value="<%=rscat.getString("Rate")%>" placeholder=""
															onblur="return ratevalidate();"> <label
															for="rate" class="floating-label">Rate</label>
														<div>
															<label id="phone4"
																style="display: none; color: red; font-size: 10px">
																Only Positive Numeric value allowed </label> <label id="phone6"
																style="display: none; color: red; font-size: 10px">
																Please Enter Rate </label>
														</div>
													</div>
												</div>
												<div class="col-4 ">
													<div class="input-container">
														<textarea class="form-control floating-input" id="email"
															name="email" rows="1" placeholder="" onblur="return ValidateEmail();"> <%=rscat.getString("ToId")%></textarea>
														<label for="email" class="floating-label">To Id</label> <label
															id="email1" style="display: none;">Please Enter
															EmailID & if no email id enter '-'</label> <label id="email2"
															style="display: none; color: red; font-size: 10px">Please
															Enter valid EmailID & if no email id enter '-'</label> <label
															id="email3"
															style="display: none; color: red; font-size: 10px">Please
															Enter EmailID & if no email id enter '-'</label>

													</div>
												</div>
												<div class="col-4 ">
													<div class="input-container">
														<textarea class="form-control floating-input" id="email0"
															name="email0" rows="1" placeholder=""
															onblur="return ValidateEmail1();"> <%=rscat.getString("ToCc")%></textarea>
														<label for="email0" class="floating-label">To Cc</label> <label
															id="email11" style="display: none;">Please Enter
															EmailID & if no email id enter '-'</label> <label id="email12"
															style="display: none; color: red; font-size: 10px">Please
															Enter valid EmailID & if no email id enter '-'</label> 
															<label id="email13" style="display: none; color: red; font-size: 10px">Please Enter EmailID & if no email id enter '-'</label>

													</div>
												</div>
											</div>

											<div class="row col-12 mt-4">
												<div class="col-4 ">
													<div class="input-container">
														<label class="tcolor">Frequency</label> <select
															name="frequency" id="frequency" class="form-select">
															<option value="<%=Frequency1%>"><%=Frequency1%></option>
															<%
															String sqlDropdown3 = "SELECT distinct BillFrequency FROM db_gps.t_transporter";
															ResultSet rsDropdown3 = st2.executeQuery(sqlDropdown3);
															while (rsDropdown3.next()) {
															%>
															<option
																value="<%=rsDropdown3.getString("BillFrequency")%>">
																<%=rsDropdown3.getString("BillFrequency")%></option>

															<%
															}
															%>
														</select>
													</div>
												</div>

												<div class="col-4 ">
													<div class="input-container">
														<label class="tcolor">Bill Type</label> <select
															name="billtype" id="billtype" class="form-select">
															<option value="<%=BillType1%>"><%=BillType1%></option>
															<%
															String sqlDropdown4 = "SELECT distinct BillType FROM db_gps.t_transporter";
															ResultSet rsDropdown4 = st2.executeQuery(sqlDropdown4);
															while (rsDropdown4.next()) {
															%>
															<option value="<%=rsDropdown4.getString("BillType")%>">
																<%=rsDropdown4.getString("BillType")%></option>

															<%
															}
															%>
														</select>
													</div>
												</div>
											</div>

											<div class="d-grid gap-2 col-3 mx-auto mt-3">
												<button id="saveForm" name="submit" class="btn"
													type="submit" value="Submit">Submit</button>
											</div>

										</div>
										</div>
	 
<input type="hidden" name="category1" value="<%=category%>">
<input type="hidden" name="CustomerType1" value="<%=customerType%>">
<input type="hidden" name="Frequency1" value="<%=frequency%>">
<input type="hidden" name="BillType1" value="<%=billType%>">
<input type="hidden" name="ToId1" value="<%=toId%>">
<input type="hidden" name="ToCc1" value="<%=toCc%>">
<input type="hidden" name="BillStatus1" value="<%=billStatus%>">
<input type="hidden" name="OperationalStatus1" value="<%=operationalStatus%>">
<input type="hidden" name="Rate1" value="<%=rate%>">
<input type="hidden" name="companyname" value="<%=companyCode%>">
<input type="hidden" name="companyname1" value="<%=companyName%>">
<input type="hidden" name="coreforms1" value="<%=coreForms%>">
<input type="hidden" name="login1" value="<%=loginName%>">
<input type="hidden" name="password" value="<%=password%>">
<input type="hidden" name="isdatavalid" value="<%=isDataValid%>">
<input type="hidden" name="custdisc" value="<%=custDisc%>">
<input type="hidden" name="creditlimit" value="<%=creditLimit%>">
<input type="hidden" name="paymentterms" value="<%=paymentTerms%>">
<input type="hidden" name="paymentmode" value="<%=paymentMode%>">
<input type="hidden" name="telephone2" value="<%=telephone2%>">
<input type="hidden" name="vendorcode" value="<%=vendorCode%>">
<input type="hidden" name="tallyname" value="<%=tallyName%>">
<input type="hidden" name="transactionexisted" value="<%=transactionExisted%>">							
								</form>

							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>




	<%}%>
	<%
	} catch (Exception e) {
	System.out.print(e);
	e.printStackTrace();

	}
	%>

	<script>
		function Validation() {

			//******************Validation for ToId *****************************  
			document.getElementById("email3").style.display = "none";
			document.getElementById("email1").style.display = "none";
			document.getElementById("email2").style.display = "none";

			var txtEmail = document.getElementById("email").value;

			var valid = true;

			/* valid = emails.forEach(function(email){
				
					validate(email.trim());
			}); */
			valid = emails.every(validate);

			function validate(email) {
				var text = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;

				//alert(email);
				if (email.trim() == "") {
					//alert(email);
					document.getElementById("email3").style.display = "";
					return false;
				}

				if (!text.test(email) && !(email.trim() == "-")) {
					document.getElementById("email2").style.display = "";
					return false;

				}

				return true;
			}

			return valid;

			//******************Validation for Rate *****************************  

			document.getElementById("phone4").style.display = "none";
			document.getElementById("phone6").style.display = "none";
			//var invalid=/^[0-9 ,]+$/; \   
			//var invalid=/^\d*\.?\d*$/;
			//before decimal 2 values and after 1 /^[0-9]{1,2}(\.[0-9])?$/
			//var invalid = /^[1-9][0-9](\\.\\d)?$/;
			var invalid = /^\d+(\.\d{2})?$/;
			var mob = document.getElementById("rate").value;

			if (!(mob == "")) {
				if (!invalid.test(mob)) {
					document.getElementById("phone4").style.display = "";
					return false;
				}

			} else {
				mob = "";
				document.getElementById("phone6").style.display = "";
				return false;
			}

			//******************Validation for ToCc *****************************  

			document.getElementById("email13").style.display = "none";
			document.getElementById("email11").style.display = "none";
			document.getElementById("email12").style.display = "none";

			var txtEmail = document.getElementById("email0").value;

			var emails = txtEmail.split(",");

			emails.forEach(function(email) {

				validate(email.trim());
			});

			function validate(email) {
				var text = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;

				//	alert(email);
				if (email.trim() == "") {
					//alert(email);
					document.getElementById("email13").style.display = "";
					return false;
				}

				if (!text.test(email) && !(email.trim() == "-")) {
					document.getElementById("email12").style.display = "";
					return false;

				}
			}

		}

		function ValidateEmail() {
			document.getElementById("email3").style.display = "none";
			document.getElementById("email1").style.display = "none";
			document.getElementById("email2").style.display = "none";

			var txtEmail = document.getElementById("email").value;

			var emails = txtEmail.split(",");

			var valid = true;

			/* valid = emails.forEach(function(email){
			
			 validate(email.trim());
			 }); */
			valid = emails.every(validate);

			function validate(email) {
				var text = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;

				//alert(email);
				if (email.trim() == "") {
					//alert(email);
					document.getElementById("email3").style.display = "";
					return false;
				}

				if (!text.test(email) && !(email.trim() == "-")) {
					document.getElementById("email2").style.display = "";
					return false;

				}
				return true;
			}
			return valid;
		}

		function ValidateEmail1() {
			document.getElementById("email13").style.display = "none";
			document.getElementById("email11").style.display = "none";
			document.getElementById("email12").style.display = "none";

			var txtEmail = document.getElementById("email0").value;
			var emails = txtEmail.split(",");
			var valid = true;
			valid = emails.every(validate);

			function validate(email) {
				var text = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,40})+$/;

				//alert(email);
				if (email.trim() == "") {
					//alert(email);
					document.getElementById("email13").style.display = "";
					return false;
				}

				if (!text.test(email) && !(email.trim() == "-")) {
					document.getElementById("email12").style.display = "";
					return false;

				}

				return true;
			}

			return valid;

		}

		function ratevalidate() {
			document.getElementById("phone4").style.display = "none";
			document.getElementById("phone6").style.display = "none";
			var invalid = /^[0-9]+$/;
			var mob = document.getElementById("rate").value;

			if (!(mob == "")) {
				if (!invalid.test(mob)) {
					document.getElementById("phone4").style.display = "";
					return false;
				}

			} else {
				mob = "";
				document.getElementById("phone6").style.display = "";
				return false;
			}
		}
	</script>

	<%@ include file="footer.jsp"%>
</body>
</html>