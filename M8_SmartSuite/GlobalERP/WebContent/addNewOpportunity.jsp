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
	String selectedName;
	String FollowUpType = "", company = "", contact_id = "", mobileno = "", email = "", phone = "", Address = "", city = "",
			state = "", country = "", zipcode = "", mobileno1 = "", mobileno2 = "", AlternetNO = "", Email1 = "",
			Email2 = "";
	%>
	<%
	// Connection Initialization
	Connection con = null;
	Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;

	try {
		con = connection.getConnect("db_GlobalERP");
		st = con.createStatement();
		st1 = con.createStatement();
		st2 = con.createStatement();
		st3 = con.createStatement();
		st4 = con.createStatement();

	} catch (Exception e) {
		e.printStackTrace();
	}

	String Category = request.getParameter("customertype");
	System.out.println("Category------->" + Category);
	String CustomerCode = "";

	String companyname = request.getParameter("companyname");
	companyname = companyname.replace("...", "&");

	System.out.println("COMANY NAW->" + companyname);
	System.out.println("COMANY NAW->---------------->" + companyname);

	System.out.println("CompanyName is:" + companyname);

	String Custcode = request.getParameter("customercode");
	System.out.println("Customercode->" + Custcode);
	System.out.println("-CAt====" + Category);

	if (Category.equals("Prospect")) {
		System.out.println("HIIIIIII");
		String OriginalCompany = "select * from  db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
		+ "prospectivecustmaster where CompanyName='" + companyname + "' and CustomerCode='" + Custcode + "' ";

		System.out.println(OriginalCompany);

		ResultSet rscomp = st3.executeQuery(OriginalCompany);
		System.out.println("OriginalCompany" + OriginalCompany);
		while (rscomp.next()) {
			CustomerCode = rscomp.getString("CustomerCode");
			//System.out.println("CUSTOMER CODE---->"+CustomerCode);
		}
	} else {

		String OriginalCompany1 = "select * from  db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
		+ "prospectivecustmaster where SalesCustomerCode='" + Custcode + "' ";
		ResultSet rscomp1 = st4.executeQuery(OriginalCompany1);
		System.out.println("OriginalCompany1" + OriginalCompany1);
		while (rscomp1.next()) {
			CustomerCode = rscomp1.getString("CustomerCode");
			//System.out.println("Sales Customer code-------->"+CustomerCode);
		}
	}
	%>
	<%
	try {
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
									<h5 class="content-header-title text-center mb-0"
										style="color: #060637">
										Add New Opportunity For
										<%=companyname%></h5>
								</div>
								<br>

								<form name="addCustomer" action="Insertoppo.jsp" method="post"
									onsubmit="return formValidation();">

									<div class="card shadow-lg mb-4 rounded-3">
										<div class="card-body">
											<div class="row col-12">
												<div class="col-5">
													<div class="input-container">
														<label style="font-size: 13px;"> <span
															style="color: black;">Marketing Rep. Name :</span> <span>
																<%=session.getAttribute("EmpName").toString()%>
														</span>
														</label>
													</div>

												</div>
												<div class="col-4">
													<div class="input-container">
														<%-- <label >Transporter :<%=companyname%> --%>
														<label style="font-size: 13px;"> <span
															style="color: black;">Transporter :</span> <span>
																<%=companyname%>
														</span> <input type="hidden" name="comp" id="comp"
															value="<%=companyname%>"> <input type="hidden"
															name="comp" id="comp" value="<%=companyname%>"></label>
													</div>
												</div>
												<div class="col-3"></div>
											</div>

											<div class="row col-12">
												<div class="col-3  ">
													<div class="input-container">

														<label class="tcolor">Contact Person</label> <select
															id="spokento" name="spokento" onclick="re(0)"
															onchange="contact();" class="form-select">
															<%
															Statement st_st = con.createStatement();
															String sql1 = "";

															System.out.println("----" + request.getParameter("customercode"));

															System.out.println("comapnt name fro submit" + request.getParameter("comp"));

															if (Category.equals("Customer")) {
																sql1 = "SELECT DISTINCT(contactperson),contact_id,mobileno,email,phone,Address,city,state,country,zipcode,mobileno1,mobileno2,AlternetNO,Email1,Email2 FROM "
																+ session.getAttribute("CompanyMasterID") + "contactdet WHERE salesCustomerCode='" + Custcode
																+ "' AND mobileno <> 'null'";
															} else {
																sql1 = "SELECT DISTINCT(contactperson),contact_id,mobileno,email,phone,Address,city,state,country,zipcode,mobileno1,mobileno2,AlternetNO,Email1,Email2 FROM "
																+ session.getAttribute("CompanyMasterID") + "contactdet WHERE customercode='" + Custcode
																+ "' AND mobileno <> 'null'";
															}

															ResultSet rs_st = st_st.executeQuery(sql1);
															while (rs_st.next()) {
															%>
															<option value="<%=rs_st.getString("contactperson")%>">
																<%=rs_st.getString("contactperson")%>
															</option>
															<%
															}
															ResultSet rs_st1 = st_st.executeQuery(sql1);

															if (rs_st1.next()) {
															System.out.println("First Contact Person :- " + rs_st1.getString("contactperson"));

															contact_id = rs_st1.getString("contact_id");
															mobileno = rs_st1.getString("mobileno");
															email = rs_st1.getString("email");
															phone = rs_st1.getString("phone");
															Address = rs_st1.getString("Address");
															city = rs_st1.getString("city");
															state = rs_st1.getString("state");
															country = rs_st1.getString("country");
															zipcode = rs_st1.getString("zipcode");
															mobileno1 = rs_st1.getString("mobileno1");
															mobileno2 = rs_st1.getString("mobileno2");
															AlternetNO = rs_st1.getString("AlternetNO");
															Email1 = rs_st1.getString("Email1");
															Email2 = rs_st1.getString("Email2");

															if (contact_id == null) {
																contact_id = "";

															}
															if (mobileno == null) {
																mobileno = "";

															}
															if (email == null) {
																email = "";

															}
															if (phone == null) {
																phone = "";

															}
															if (Address == null) {
																Address = "";

															}
															if (city == null) {
																city = "";

															}
															if (state == null) {
																state = "";

															}
															if (country == null) {
																country = "";

															}
															if (zipcode == null) {
																zipcode = "";

															}
															if (mobileno1 == null) {
																mobileno1 = "";
															}
															if (mobileno2 == null) {
																mobileno2 = "";

															}
															if (AlternetNO == null) {
																AlternetNO = "";

															}
															if (Email1 == null) {
																Email1 = "";

															}
															if (Email2 == null) {
																Email2 = "";
															}

															} else {
															System.out.println("First Contact Person Not Available");
															contact_id = "";mobileno = ""; email = ""; phone = "";
															Address = "";
															city = ""; state = ""; country = ""; zipcode = "";
															mobileno1 = ""; mobileno2 = ""; AlternetNO = "";
															Email1 = ""; Email2 = "";
															}
															%>
														</select> <input type="hidden" name="assignedBy"
															value="<%=session.getAttribute("EmpName").toString()%>" />
													</div>
												</div>

												<div class="col-3 mt-4">
													<div class="input-container">
														<a href="#" onclick="addCon(1)"
															style="text-decoration: none;"> Add Contact</a>
													</div>
												</div>

												<div class="col-3 mt-4">
													<div class="input-container">
														<input id="website" name="website"
															class="form-control floating-input" value=""
															placeholder=""> <label for="website"
															class="floating-label">WebSite</label>

													</div>
												</div>
												<div class="col-3  ">
													<div class="input-container">

														<label class="tcolor">Assign To</label> <select
															id="assignTo" name="assignTo" class="form-select">
															<%
															String sql = "select MarketingRepName ,MarketingRepCode from db_GlobalERP."
																	+ session.getAttribute("CompanyMasterID").toString() + "marketingrepmaster "
																	+ " WHERE username<>'' and password<>''  and (Compressor=1 OR	DigitalEquipment=1 OR 	DGSet=1 OR 	Endoscope=1 OR 	OtherGroups=1 ) order by MarketingRepName";
															ResultSet rs = st.executeQuery(sql);
															%>
															<option
																value="<%=session.getAttribute("EmpName").toString()%>"><%=session.getAttribute("EmpName").toString()%></option>
															<%
															while (rs.next()) {
															%>
															<option value="<%=rs.getString(1)%>">
																<%=rs.getString(1)%></option>
															<%
															}
															%>
														</select> <input type="hidden" name="assignedBy"
															value="<%=session.getAttribute("EmpName").toString()%>" />
													</div>
												</div>

											</div>
											<div class="row col-12 mt-3">

												<div class="col-3">
													<div class="input-container">
														<input id="leadRef" name="leadRef"
															class="form-control floating-input" type="text"
															placeholder="" value=""
															onblur="return contactpersonfun11();"> <label
															for="leadRef" class="floating-label">Lead
															reference</label>
														<div>
															<label id="contact9" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Character Value</font></label>
														</div>

													</div>
												</div>
												<div class="col-3">
													<div class="input-container">
														<input id="opportunityname" name="opportunityname"
															class="form-control floating-input" type="text"
															placeholder="" value=""
															onblur="return contactpersonfun5();"> <label
															for="opportunityname" class="floating-label">Opportunity
															Name</label>
														<div>
															<label id="contact5" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Opportunity Name</font></label> <label id="contact6"
																style="display: none;"><font face="Arial"
																size="1" color="red">Please Enter Character Value</font></label>
														</div>
													</div>
												</div>

												<div class="col-3">
													<div class="input-container">

														<input class="form-control floating-input" type="text"
															id="email" name="email" placeholder="" value=""
															onblur="return validateEmail();" required> <label
															for="email" class="floating-label">E-mail</label>
														<div>
															<label id="email3" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	EmailID</font></label> <label id="email1" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	valid EmailID</font></label> <label id="email2" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	valid EmailID</font></label>
														</div>

													</div>
												</div>

												<div class="col-3 ">
													<div class="input-container">
														<textarea class="form-control floating-input" id="address"
															name="address" rows="1" placeholder=""><%=Address%></textarea>
														<label for="address" class="floating-label">Address</label>

													</div>
												</div>

											</div>
											<div class="row col-12">
												<div class="col-3 ">
													<div class="input-container">
														<label class="tcolor">Country</label> <select
															class="form-select" id="country1" name="country1"
															onchange="showbox();showbox2();" required>
															<option value="<%=country%>"><%=country%></option>
															<%
															String sqlDropdown3 = "SELECT Distinct(Country) FROM db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
																	+ "citystctryinfo order by Country asc";
															ResultSet rsDropdown3 = st2.executeQuery(sqlDropdown3);
															while (rsDropdown3.next()) {
															%>
															<option value="<%=rsDropdown3.getString(1)%>"><%=rsDropdown3.getString(1)%></option>

															<%
															}
															%>

														</select>
														<div>
															<input class="form-control floating-input" type="text"
																name="newcountry" id="newcountry" style="display: none" />
															<a style="font-weight: bold; color: blue; display: none"
																id="f14" onclick="showminus2('-')">(-)</a> <label><a
																id="f15" onclick="showentryform2();">Add Country</a></label>
														</div>
													</div>
												</div>

												<div class="col-3">
													<div class="input-container">
														<label class="tcolor">State</label> <select disabled
															class="form-select" id="state" name="state"
															onchange="showbox1()">
															<option value="<%=state%>"><%=state%></option>
															<%
															String sqlDropdown2 = "SELECT Distinct State FROM db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
																	+ "citystctryinfo order by State asc ";
															ResultSet rsDropdown2 = st2.executeQuery(sqlDropdown2);
															while (rsDropdown2.next()) {
															%>
															<option value="<%=rsDropdown2.getString(1)%>"><%=rsDropdown2.getString(1)%></option>

															<%
															}
															%>


														</select>
														<div>

															<input class="form-control floating-input" type="text"
																name="newstate" id="newstate" style="display: none" /> <a
																style="font-weight: bold; color: blue; display: none"
																id="f12" onclick="showminus1('-')">(-)</a> <label><a
																style="display: none;" id="f13"
																onclick="showentryform1();">Add State</a></label>
														</div>
													</div>
												</div>

												<div class="col-3">
													<div class="input-container">

														<label class="tcolor">City </label> <select disabled
															class="form-select" id="city" name="city">
															<option value="<%=city%>"><%=city%></option>
															<%
															String sqlDropdown1 = "SELECT Distinct City FROM db_GlobalERP." + session.getAttribute("CompanyMasterID").toString()
																	+ "citystctryinfo order by City asc";
															ResultSet rsDropdown1 = st2.executeQuery(sqlDropdown1);
															while (rsDropdown1.next()) {
															%>
															<option><%=rsDropdown1.getString(1)%></option>

															<%
															}
															%>
														</select>
														<div>
															<input class="form-control floating-input" type="text"
																name="newcity" id="newcity"
																style="width:; display: none" /> <a
																style="font-weight: bold; color: blue; display: none"
																id="f10" onclick="showminus('-')">(-)</a> <label><a
																id="f11" style="display: none;"
																onclick="showentryform();">Add City</a></label>
														</div>

													</div>
												</div>





												<div class="col-3 mt-4">
													<div class="input-container">
														<input class="form-control floating-input" type="text"
															id="zip" name="zip" value="<%=zipcode%>" placeholder=""
															onblur="return pin();"> <label for="zip"
															class="floating-label">PinCode</label> <label id="zip1"
															style="display: none;"><font face="Arial"
															size="1" color="red">Please Enter Numeric Value</font></label> <label
															id="zip2" style="display: none;"><font
															face="Arial" size="1" color="red">Please Enter 6
																digit Value</font></label>

													</div>
												</div>
												<div></div>

											</div>

											<div class="row col-12 mt-3">
												<div class="col-3">
													<div class="input-container">

														<input class="form-control floating-input" type="text"
															id="mobile" name="mobile" placeholder="" required
															onblur="return funmob1();"> <label for="mobile"
															class="floating-label">Mobile No</label>
														<div>
															<label id="mob1" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric value</font></label> <label id="mob12" style="display: none;"><font
																face="Arial" size="1" color="red">Number Should
																	Be 10-15 Digits</font></label> <label id="mob123"
																style="display: none;"><font face="Arial"
																size="1" color="red">Please Enter Mobile Number</font></label>
														</div>

													</div>
												</div>


												<div class="col-3">
													<div class="input-container">

														<input class="form-control floating-input" type="text"
															id="faxno" name="faxno" value="" placeholder=""
															onblur="return fax();"> <label for="faxno"
															class="floating-label">Fax No</label>
														<div>
															<label id="fax1" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric Value</font></label> <label id="fax2" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric Value</font></label>
														</div>
													</div>


												</div>
												<div class="col-3">
													<div class="input-container">
														<input class="form-control floating-input" type="text"
															id="std" name="std" placeholder="" value=""
															onblur="return units5();"> <label for="std"
															class="floating-label">STD Code</label>
														<div>
															<label id="noofunits3" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric Value</font></label> <label id="noofunits4"
																style="display: none;"><font face="Arial"
																size="1" color="red">Please Enter Numeric Value</font></label>
														</div>

													</div>
												</div>
												<div class="col-3">
													<div class="input-container">
														<input class="form-control floating-input" type="text"
															id="phone" name="phone" value="<%=phone%>" placeholder=""
															required onblur="return funmob2();"> <label
															for="phone" class="floating-label">Phone No</label>
														<div>
															<label id="phone1" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric value</font></label> <label id="phone12"
																style="display: none;"><font face="Arial"
																size="1" color="red">Number Should Be 6-14 Digits</font></label>
															<label id="phone3" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Phone Number</font></label>
														</div>
													</div>
												</div>
											</div>


											<div class="row col-12">
												<div class="col-3">
													<div class="input-container">

														<label class="tcolor">Category</label> <select
															id="category" name="category" class="form-select">
															<option value="0">Select</option>

															<%
															String sqlDropdown = "SELECT TheGroupName,TheGroupCode FROM db_GlobalERP."
																	+ session.getAttribute("CompanyMasterID").toString()
																	+ "tbl_groupmaster where IsDataValid='1' order by TheGroupName";
															ResultSet rsDropdown = st2.executeQuery(sqlDropdown);
															while (rsDropdown.next()) {
															%>
															<option value="<%=rsDropdown.getString(2)%>">
																<%=rsDropdown.getString(1)%></option>

															<%
															}
															%>
														</select>
													</div>
												</div>
												<div class="col-3 mt-4">
													<div class="input-container">
														<input class="form-control floating-input" type="text"
															id="product" name="product" value="" placeholder="">
														<label for="product" class="floating-label">Interested
															In Product</label>

													</div>

												</div>
												<div class="col-3 mt-4">
													<div class="input-container">
														<input id="potentialValue" name="potentialValue"
															class="form-control floating-input" type="text" value=""
															placeholder="" onblur="return code1();" /> <label
															for="potentialValue" class="floating-label"
															for="element_1">Potential Value</label>

														<div>
															<label id="std3" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric Value</font></label> <label id="std4" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric Value</font></label>
														</div>

													</div>
												</div>

												<div class="col-3 mt-4">
													<div class="input-container">
														<input class="form-control floating-input" type="text"
															id="alternateNumber" name="alternateNumber"
															maxlength="15" value="<%=AlternetNO%>" placeholder=""
															onblur="return  funmob3();"> <label
															for="alternateNumber" class="floating-label">Alternate
															Number</label>
														<div>
															<label id="mob7" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric value</font></label> <label id="mob8" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric value</font></label>
														</div>
													</div>

												</div>

											</div>

											<div class="row col-12 mt-3">

												<div class="col-3">
													<div class="input-container">
														<input id="noofunits" name="noofunits"
															class="form-control floating-input" type="text"
															placeholder="" value="" onblur="return  units();" /> <label
															class="floating-label" for="noofunits">No Of
															Units</label>

														<div>
															<label id="noofunits1" style="display: none;"><font
																face="Arial" size="1" color="red">Please Enter
																	Numeric Value</font></label> <label id="noofunits2"
																style="display: none;"><font face="Arial"
																size="1" color="red">Please Enter Numeric Value</font></label>
														</div>
													</div>
												</div>
												<div class="col-3 ">
													<div class="input-container">
														<textarea class="form-control floating-input"
															id="comments" name="comments" rows="1" placeholder=""></textarea>
														<label for="comments" class="floating-label">Comments</label>
													</div>
												</div>

											</div>
											<div class="d-grid gap-2 col-3 mx-auto mt-3">
												<button id="submit" name="submit" class="btn" type="submit"
													onclick="return check123()">Submit</button>
											</div>

										</div>
									</div>
									<input type="hidden" name="type111" id="type111"
										value="<%=Category%>"> <input type="hidden"
										name="company111" id="company111" value="<%=companyname%>">
									<input type="hidden" name="companycode111" id="companycode111"
										value="<%=Custcode%>"> <input type="hidden"
										name="comp" id="comp" value="<%=companyname%>"> <input
										type="hidden" name="originalcustcode" id="originalcustcode"
										value="<%=Custcode%>"> <input type="hidden"
										name="assignedBy"
										value="<%=session.getAttribute("EmpName").toString()%>" /> <input
										type="hidden" name="companyname" id="companyname"
										value=<%=companyname%>> <input type="hidden"
										name="customercode" id="customercode" value=<%=CustomerCode%>>
									<input type="hidden" name="type111" id="type111"
										value=<%=Category%>>

								</form>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>



	<%
	} catch (Exception e) {
	e.printStackTrace();
	}
	%>

	<script>
		function formValidation() {

			document.getElementById("contact9").style.display = "none";
			var name5 = document.getElementById("leadRef").value;
			var invalid = /[^A-Za-z\s]/;
			var oth = name5.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if (name5 == " " || oth == " ") {

			} else {
				if (invalid.test(name5)) {
					document.getElementById("contact9").style.display = "";
					return false;
				}
			}

			document.getElementById("noofunits6").style.display = "none";
			document.getElementById("noofunits7").style.display = "none";
			var mob = document.getElementById("count").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("noofunits6").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("noofunits7").style.display = "";
					return false;
				}

			}

			document.getElementById("contact5").style.display = "none";
			document.getElementById("contact6").style.display = "none";
			var name = document.getElementById("opportunityname").value;
			//var invalid=/[^A-Za-z\s]/;

			if (name == "" || oth == "") {

				/* alert("it is empty plz fill"); */
				document.getElementById("contact5").style.display = "";
				return false;
			}
			var invalid = /^[@,&.\-A-Za-z0-9]+[\s\-]*[\s\-@.,&A-Za-z0-9]*[A-Za-z]+$/;

			var oth = name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			if (!invalid.test(name)) {

				/* alert("Regular not match"); */
				document.getElementById("contact6").style.display = "";
				return false;
			}

			document.getElementById("email3").style.display = "none";
			document.getElementById("email1").style.display = "none";
			document.getElementById("email2").style.display = "none";

			var txtEmail = document.getElementById("email").value;
			var text = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

			if (txtEmail == "") {
				document.getElementById("email3").style.display = "";
				return false;
			}

			if (!text.test(txtEmail)) {
				document.getElementById("email2").style.display = "";
				return false;

			}

			document.getElementById("zip1").style.display = 'none';
			document.getElementById("zip2").style.display = 'none';
			var invalid = /^[0-9]+$/;
			var mob = document.getElementById("zip").value;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("zip1").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("zip2").style.display = "";
					return false;
				}
			}

			document.getElementById("mob1").style.display = "none";
			document.getElementById("mob12").style.display = "none";
			document.getElementById("mob123").style.display = "none";
			var invalid = /^[+]{0,1}[0-9]+$/;
			var mob = document.getElementById("mobile").value;
			if (!(mob == 0)) {
				if (!invalid.test(mob)) {
					document.getElementById("mob1").style.display = "";
					return false;
				}
				if ((mob.trim().length < 10) || (mob.trim().length > 15)) {
					document.getElementById("mob12").style.display = "";
					return false;
				}
			} else {
				mob = "";
				document.getElementById("mob123").style.display = "";
				return false;
			}

			document.getElementById("fax1").style.display = "none";
			document.getElementById("fax2").style.display = "none";
			var mob = document.getElementById("faxno").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("fax1").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("fax2").style.display = "";
					return false;
				}
			}

			document.getElementById("noofunits3").style.display = "none";
			document.getElementById("noofunits4").style.display = "none";
			var mob = document.getElementById("std").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("noofunits3").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("noofunits4").style.display = "";
					return false;
				}
			}

			document.getElementById("phone1").style.display = "none";
			document.getElementById("phone3").style.display = "none";
			document.getElementById("phone12").style.display = "none";
			var invalid = /^[0-9 ]+$/;
			var mob1 = document.getElementById("phone").value;

			if (!(mob1 == 0)) {
				if (!invalid.test(mob1)) {
					document.getElementById("phone1").style.display = "";
					return false;
				}
				if ((mob1.trim().length < 6) || (mob1.trim().length > 15)) {
					document.getElementById("phone12").style.display = "";
					return false;
				}
			} else {
				mob1 = "";
				document.getElementById("phone3").style.display = "";
				return false;
			}

			document.getElementById("contact3").style.display = "none";

			document.getElementById("mob7").style.display = "none";
			document.getElementById("mob8").style.display = "none";
			var mob = document.getElementById("alternateNumber").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("mob7").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("mob8").style.display = "";
					return false;
				}

			}

			document.getElementById("std3").style.display = "none";
			document.getElementById("std4").style.display = "none";
			var mob = document.getElementById("potentialValue").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("std3").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("std4").style.display = "";
					return false;
				}

			}

			document.getElementById("noofunits1").style.display = "none";
			document.getElementById("noofunits2").style.display = "none";
			var mob = document.getElementById("noofunits").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("noofunits1").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("noofunits2").style.display = "";
					return false;
				}

			}

		}

		function code1() {
			document.getElementById("std3").style.display = "none";
			document.getElementById("std4").style.display = "none";
			var mob = document.getElementById("potentialValue").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("std3").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("std4").style.display = "";
					return false;
				}

			}
		}
		function contactpersonfun1() {

			document.getElementById("contact3").style.display = "none";
			var name1 = document.getElementById("weeklyOffOn").value;
			var invalid = /[^A-Za-z\s]/;
			var oth = name1.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if (name1 == " " || oth == " ") {

			} else {
				if (invalid.test(name1)) {
					document.getElementById("contact3").style.display = "";
					return false;
				}
			}
		}
		function funmob3() {

			document.getElementById("mob7").style.display = "none";
			document.getElementById("mob8").style.display = "none";
			var mob = document.getElementById("alternateNumber").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("mob7").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("mob8").style.display = "";
					return false;
				}

			}

		}

		function validateEmail() {
			document.getElementById("email3").style.display = "none";
			document.getElementById("email1").style.display = "none";
			document.getElementById("email2").style.display = "none";

			var txtEmail = document.getElementById("email").value;

			var text = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,15})+$/;

			if (txtEmail == "") {
				document.getElementById("email3").style.display = "";
				return false;
			}

			if (!text.test(txtEmail)) {
				document.getElementById("email2").style.display = "";
				return false;

			}

		}
		function contactpersonfun12() {
			document.getElementById("contact10").style.display = "none";
			document.getElementById("contact20").style.display = "none";
			var name = document.getElementById("companyName").value;
			//	var invalid=/[^A-Za-z\s]/;
			var invalid = /^[a-zA-Z  .]+$/;
			var oth = name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if (name == "" || oth == "") {
				document.getElementById("contact10").style.display = "";
				return false;
			}
			if (!invalid.test(name)) {
				document.getElementById("contact20").style.display = "";
				return false;
			}
		}

		function contactpersonfun5() {
			document.getElementById("contact5").style.display = "none";
			document.getElementById("contact6").style.display = "none";
			var name = document.getElementById("opportunityname").value;
			var invalid = /^[@,&.\-A-Za-z0-9]+[\s\-]*[\s\-@.,&A-Za-z0-9]*[A-Za-z]+$/;

			var oth = name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if (name == "" || oth == "") {
				document.getElementById("contact5").style.display = "";
				return false;
			}
			if (!invalid.test(name)) {

				document.getElementById("contact6").style.display = "";
				return false;
			}
		}
		function showbox() {
			var country = document.getElementById("country1").value;
			if (country != null) {
				document.getElementById("f13").style.display = "";

			} else {
				document.getElementById("f13").style.display = 'none';

			}
			var ajaxRequest; // The variable that makes Ajax possible!
			try {
				ajaxRequest = new XMLHttpRequest();
			} catch (e) {
				try {
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState == 4) {
					var reslt = ajaxRequest.responseText;
					document.getElementById("state").disabled = false;
					document.getElementById("state").innerHTML = reslt;

				}
			};

			var queryString = "?country=" + country;
			ajaxRequest.open("GET", "AjaxGetState.jsp" + queryString, true);
			ajaxRequest.send(null);

		}
		function showbox2() {
			var country = document.getElementById("country1").value;
			var ajaxRequest; // The variable that makes Ajax possible!
			try {
				ajaxRequest = new XMLHttpRequest();
			} catch (e) {
				try {
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState == 4) {
					var reslt = ajaxRequest.responseText;
					document.getElementById("city").innerHTML = reslt;

				}
			};

			var queryString = "?country=" + country;
			ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
			ajaxRequest.send(null);

		}

		function showbox1() {

			//alert("hi");
			var state = document.getElementById("state").value;
			if (state != null) {
				document.getElementById("f11").style.display = "";

			} else {
				document.getElementById("f11").style.display = 'none';

			}
			var ajaxRequest; // The variable that makes Ajax possible!
			try {
				ajaxRequest = new XMLHttpRequest();
			} catch (e) {
				try {
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState == 4) {
					var reslt = ajaxRequest.responseText;
					document.getElementById("city").disabled = false;
					document.getElementById("city").innerHTML = reslt;

				}
			};

			var queryString = "?state=" + state;
			ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
			ajaxRequest.send(null);

		}
		function funmob1() {
			document.getElementById("mob1").style.display = "none";
			document.getElementById("mob12").style.display = "none";
			document.getElementById("mob123").style.display = "none";
			var invalid = /^[0-9]+$/;
			var mob = document.getElementById("mobile").value;
			if (!(mob == 0)) {
				if (!invalid.test(mob)) {
					document.getElementById("mob1").style.display = "";
					return false;
				}
				if ((mob.trim().length < 10) || (mob.trim().length > 15)) {
					document.getElementById("mob12").style.display = "";
					return false;
				}
			} else {
				mob = "";
				document.getElementById("mob123").style.display = "";
				return false;
			}

		}
		function funmob2() {

			document.getElementById("phone1").style.display = "none";
			document.getElementById("phone3").style.display = "none";
			document.getElementById("phone12").style.display = "none";
			var invalid = /^[0-9 ]+$/;
			var mob1 = document.getElementById("phone").value;

			if (!(mob1 == 0)) {
				if (!invalid.test(mob1)) {
					document.getElementById("phone1").style.display = "";
					return false;
				}
				if ((mob1.trim().length < 6) || (mob1.trim().length > 15)) {
					document.getElementById("phone12").style.display = "";
					return false;
				}
			} else {
				mob1 = "";
				document.getElementById("phone3").style.display = "";
				return false;
			}
		}
		function pin() {
			document.getElementById("zip1").style.display = 'none';
			document.getElementById("zip2").style.display = 'none';
			var invalid = /^[0-9]+$/;
			var mob = document.getElementById("zip").value;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("zip1").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("zip2").style.display = "";
					return false;
				}
			}
		}
		function fax() {
			document.getElementById("fax1").style.display = "none";
			document.getElementById("fax2").style.display = "none";
			var mob = document.getElementById("faxno").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("fax1").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("fax2").style.display = "";
					return false;
				}

			}
		}

		function units5() {
			document.getElementById("noofunits3").style.display = "none";
			document.getElementById("noofunits4").style.display = "none";
			var mob = document.getElementById("std").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("noofunits3").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("noofunits4").style.display = "";
					return false;
				}

			}
		}
		function units9() {
			document.getElementById("noofunits6").style.display = "none";
			document.getElementById("noofunits7").style.display = "none";
			var mob = document.getElementById("count").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("noofunits6").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("noofunits7").style.display = "";
					return false;
				}

			}
		}

		function units() {
			document.getElementById("noofunits1").style.display = "none";
			document.getElementById("noofunits2").style.display = "none";
			var mob = document.getElementById("noofunits").value;
			var invalid = /^[0-9]+$/;
			if (!(mob == 0)) {
				if (isNaN(mob)) {
					document.getElementById("noofunits1").style.display = "";
					return false;
				}
				if (!invalid.test(mob)) {
					document.getElementById("noofunits2").style.display = "";
					return false;
				}

			}
		}

		function addCon() {
			// 	 alert("1");
			var customername = "";
			var customercode = "";

			customername = document.getElementById("company111").value;
			customercode = document.getElementById("companycode111").value;
			var Category = document.getElementById("type111").value;
			var customername1 = customername.replace("&", "...");
			var url = "addcontact.jsp?companyname=" + customername1
					+ "&customercode=" + customercode + "&Type=" + Category
					+ "&isclose=true";
			var win = window.open(url, '_blank');
			win.focus();

			re(1);

		}

		function contact() {
			var customername = "";
			var customercode = "";
			var contactperson = document.getElementById("spokento").value;
			customername = document.getElementById("company111").value;
			customercode = document.getElementById("companycode111").value;
			var Category = document.getElementById("type111").value;
			customername = customername.replace(/,/, '...');
			customername = customername.replace(/;/, '**');
			customername = customername.replace(/:/, '##');

			customername = customername.replace(/_/, '*****');
			customername = customername.replace(/-/, '#####');

			customername = encodeURIComponent(customername);

			customername = customername.replace(/\ /g, '*');

			customername = customername.replace(/\&/g, '..');

			//alert("Customer---------"+customername);
			var ajaxRequest; // The variable that makes Ajax possible!

			try {
				// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
			} catch (e) {
				// Internet Explorer Browsers
				try {
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState == 4) {//alert("######################### ");

					var reselt = ajaxRequest.responseText;
					//alert("Original result"+reselt);
					var finalres = reselt.split("#");
					document.getElementById("mobile").value = finalres[1]; //comtype
					document.getElementById("email").value = finalres[2]; //comname
					document.getElementById("phone").value = finalres[3]; //code
					document.getElementById("address").value = finalres[4];
					document.getElementById("country1").value = finalres[5]; //comtype
					document.getElementById("state").value = finalres[6]; //comtype
					document.getElementById("city").value = finalres[7]; //comtype
					document.getElementById("zip").value = finalres[8]; //comname
					document.getElementById("mobile").value = finalres[1]; //code
					document.getElementById("alternateNumber").value = finalres[10]; //comtype
				}

			}

			var queryString = "?customername=" + customername
					+ "&customercode=" + customercode + "&Type=" + Category
					+ "&contactperson=" + contactperson;
			ajaxRequest.open("GET", "AjaxContactPersonDetails.jsp"
					+ queryString, true);
			ajaxRequest.send(null);
		}

		var globalcompany;
		var flag = true;
		function hideList(e) {
			if (e.which == 0) {
				document.getElementById("ProspectList").style.visibility = 'hidden';
			}
		}
		function hideOnClick() {
			//	document.getElementById("ProspectList").style.visibility='hidden';
		}
		function getProspectes() {
			var list;
			document.getElementById("comlist").style.display = "";

			document.getElementById("list").style.visibility = 'visible';
			var prospect = document.addCustomer.companyName.value;
			var ajaxRequest; // The variable that makes Ajax possible!

			try {
				ajaxRequest = new XMLHttpRequest();
			} catch (e) {
				try {
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState == 4) {
					var reslt = ajaxRequest.responseText;
					document.getElementById("list").innerHTML = reslt;

				}
			}
			var queryString = "?prospect=" + prospect + "&displayList=true";
			ajaxRequest.open("GET", "ListOfSuppliers.jsp" + queryString, true);
			ajaxRequest.send(null);
		}

		function validateProspectes() {
			document.getElementById("companynaw1").style.display = 'none';

			var compnaw = document.getElementById("companyName").value;

			if (compnaw.trim() == "" || compnaw.trim() == null) {
				document.getElementById("companynaw1").style.display = "";
				return false;
			}
			compnaw = compnaw.replace(/,/, '...');
			compnaw = compnaw.replace(/;/, '**');
			compnaw = compnaw.replace(/:/, '##');
			compnaw = compnaw.replace(/_/, '*****');
			compnaw = compnaw.replace(/-/, '#####');

			compnaw = encodeURIComponent(compnaw);
			var ajaxRequest; // The variable that makes Ajax possible!

			try {
				ajaxRequest = new XMLHttpRequest();
			} catch (e) {
				try {
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			ajaxRequest.onreadystatechange = function() {
				if (ajaxRequest.readyState == 4) {
					var reselt = ajaxRequest.responseText;
					var finalres = reselt.split("#");
					var finalrescount = finalres[1].trim();
					if (finalrescount >= 1) {
						alert("Customer Name Already Exists !!You Can Not Add This Customer---->"
								+ finalres[0].trim());
						document.addCustomer.companyName.value = "";
						document.getElementById("comlist").style.display = 'none';
					}

				}

			}

			var queryString = "?prospect=" + compnaw;

			ajaxRequest.open("GET", "AjaxCheckForCustomer.jsp" + queryString,
					true);
			ajaxRequest.send(null);

		}

		function showentryform2() {

			document.getElementById("country1").disabled = true;
			document.getElementById("newcountry").style.display = "";
			document.getElementById("f14").style.display = "";
			document.getElementById("f15").style.display = 'none';
			document.getElementById("f13").style.display = "";

			//document.getElementById("city").value='-';
			//document.addCustomer.city.style.visibility="hidden";
		}
		function showminus2(id) {
			document.getElementById("country1").disabled = false;
			document.getElementById("f14").style.display = 'none';
			document.getElementById("newcountry").style.display = 'none';
			document.getElementById("f13").style.display = 'none';
			document.getElementById("f15").style.display = "";
			document.getElementById("newcountry").value = "";

		}
		function showentryform1() {

			document.getElementById("state").disabled = true;
			document.getElementById("newstate").style.display = "";
			document.getElementById("f12").style.display = "";
			document.getElementById("f13").style.display = 'none';
			document.getElementById("f11").style.display = "";

		}
		function showminus1(id) {
			document.getElementById("state").disabled = false;
			document.getElementById("f12").style.display = 'none';
			document.getElementById("newstate").style.display = 'none';
			document.getElementById("f11").style.display = 'none';

			document.getElementById("f13").style.display = "";
			document.getElementById("newstate").value = "";
		}

		function showentryform() {

			document.getElementById("city").disabled = true;//select id
			document.getElementById("newcity").style.display = "";//input type id
			document.getElementById("f10").style.display = "";
			document.getElementById("f11").style.display = 'none';
		}
		function showminus(id) {
			document.getElementById("city").disabled = false;
			document.getElementById("f10").style.display = 'none';
			document.getElementById("newcity").style.display = 'none';

			document.getElementById("f11").style.display = "";
			document.getElementById("newcity").value = "";

			//document.addCustomer.city.style.visibility="visible";

		}

		function getClient1(id) {
			//alert("in2 get"+id);

			if (id == "+") {
				document.getElementById("f1").style.display = 'none';
				document.getElementById("mobileno1").style.display = '';
				document.getElementById("f2").style.display = "";
				document.getElementById("f3").style.display = "";

			}
		}
		function getClient2(id)

		{
			if (id == "+") {
				document.getElementById("f1").style.display = 'none';
				document.getElementById("mobileno2").style.display = '';
				document.getElementById("f2").style.display = 'none';
				document.getElementById("f3").style.display = 'none';
				document.getElementById("f4").style.display = "";

			} else {
				document.getElementById("mobileno1").value = "";
				document.getElementById("f1").style.display = "";
				document.getElementById("mobileno1").style.display = 'none';

				document.getElementById("f2").style.display = 'none';
				document.getElementById("f3").style.display = 'none';
			}
		}

		function getClient3(id) {

			if (id == "-") {
				document.getElementById("mobileno2").style.display = 'none';
				document.getElementById("f2").style.display = "";
				document.getElementById("f3").style.display = "";
				document.getElementById("f4").style.display = 'none';

			}
		}

		function Disable() {
			var abc = document.getElementById("country1").value;

			if (abc == "Select") {
			} else {

				document.getElementById("state").disabled = true;
				document.getElementById("city").disabled = true;
			}

		}

		function check123() {
			var oppname = document.getElementById("opportunityname").value;
			var mobileno = document.getElementById("mobile").value;
			var phone = document.getElementById("phone").value;

			var email = document.getElementById("email").value;

			if (email == "") {
				alert("Please Enter Email Address");
				return false;

			}

			if (mobileno == "") {
				alert("Please Enter Mobile Number");
				return false;
			}

			if (oppname == "") {
				alert("Please Enter Opportunity Name");
				return false;
			}
			if (phone == "") {
				alert("Please Enter Phone Number");
				return false;
			}

			return true;

		}

		var v = 0;
		function re(count) {
			if (count == 1) {
				v = 1;
			}

			if (count == 0) {
				if (v == 1) {
					document.getElementById("wait").style.display = "";
					$("#refreshthis1").load(document.URL + " #refreshthis1");
					v = 0;
				}
			}
		}

		function load() {
			re(0);
			setTimeout(re, 3000);
		}
	</script>

	<%@ include file="footer.jsp"%>
</body>
</html>