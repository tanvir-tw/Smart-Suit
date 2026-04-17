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
<style>
table td {
 padding: 8px 10px;
    vertical-align: top;
}
</style>
</head>
<body style="background-color: azure;">

<%
    Statement st1 = null;
   ResultSet rs = null;
    String rejectedEntries = "ProspCustAddedOn,AddedOnDate,SalesCustomerCode,VendorCode";

    Connection con = null;
    try {
        con = connection.getConnect("db_GlobalERP");
        st1 = con.createStatement();
      
        String sql = "SELECT * FROM " + session.getAttribute("CompanyMasterID")+ "prospectivecustmaster WHERE CompanyName='" + request.getParameter("companyName") + "'";
        rs = st1.executeQuery(sql);
        if (rs.next()) {
%>
<div class="container-fluid mt-2" id="main">
			<section class="container" style="max-width: 1110px;" id="basic--layouts">

				<div class="row">
					<div class="col-md-12 col-12">
						<div class="card" style="background-color: transparent;">
							<div class="card-body">
											<div class="row breadcrumbs-top">		          		                    
		          		                      <h5 class="content-header-title text-center mb-0" style="color: #060637">Current Details for : <%=((rs.getString("companyName")!=null) ? rs.getString("companyName") : "-") %> </h5>
		    		                      	</div>
		    		                      <br>
		    		                      	<div class="card shadow-lg mb-4 rounded-3">
												<div class="card-body">
											<div class="row g-1">
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Customer Code</div>
											    <div><%= (rs.getString("CustomerCode") != null) ? rs.getString("CustomerCode") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Address</div>
											    <div><%= (rs.getString("Address") != null) ? rs.getString("Address") : "-" %></div>
											  </div>
											
											 <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Entered On</div>
											    <div><%= (rs.getString("ProspCustAddedOn") != null) ? rs.getString("ProspCustAddedOn") : "-" %></div>
											  </div>
											  
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">City</div>
											    <div><%= (rs.getString("city") != null) ? rs.getString("city") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">State</div>
											    <div><%= (rs.getString("State") != null) ? rs.getString("State") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Country</div>
											    <div><%= (rs.getString("Country") != null) ? rs.getString("Country") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Zip</div>
											    <div><%= (rs.getString("Zip") != null) ? rs.getString("Zip") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Contact Person</div>
											    <div><%= (rs.getString("ContactPerson") != null) ? rs.getString("ContactPerson") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Entered By</div>
											    <div><%= (rs.getString("CustEnteredByRep") != null) ? rs.getString("CustEnteredByRep") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Category</div>
											    <div><%= (rs.getString("Category") != null) ? rs.getString("Category") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Email</div>
											    <div><%= (rs.getString("Email") != null) ? rs.getString("Email") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">STD,Phone,Mobile & Fax</div>
											    <div><%=((rs.getString("STDCode")!=null) ? rs.getString("STDCode") : "-")+"  "+((rs.getString("Phone")!=null) ? rs.getString("Phone") : "-")+ " , "+
												 		((rs.getString("MobileNo")!=null) ? rs.getString("MobileNo") : "-")+ " ,  "+
												 		((rs.getString("Fax")!=null) ? rs.getString("Fax") : "-") %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Residency No, Alternate No</div>
											    <div><%=((rs.getString("ResiNo")!=null) ? rs.getString("ResiNo") : "-")+" , "+
												 		((rs.getString("TelephoneNo2")!=null) ? rs.getString("TelephoneNo2") : "-") %></div>
											  </div>
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Website</div>
											    <div><%= (rs.getString("WebSite") != null) ? rs.getString("WebSite") : "-" %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Interested Product</div>
											    <div><%= (rs.getString("IntrestedProduct") != null) ? rs.getString("IntrestedProduct") : "-" %></div>
											  </div>
											  
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Sales Customer Code</div>
											    <div><%=((rs.getString("SalesCustomerCode")!=null) ? rs.getString("SalesCustomerCode") : "-")  %></div>
											  </div>
											  
											    <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Added On</div>
											    <div><%=((rs.getString("AddedOnDate")!=null) ? rs.getString("AddedOnDate") : "-") %></div>
											  </div>
											  
											    <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Weekly Off on</div>
											    <div><%=((rs.getString("WeeklyOffon")!=null) ? rs.getString("WeeklyOffon") : "-") %></div>
											  </div>
											
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Comments</div>
											    <div><%=((rs.getString("Comments")!=null) ? rs.getString("Comments") : "-") %></div>
											  </div>
											    <!-- Potential Value -->
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Potential Value</div>
											    <div><%= (rs.getString("PotentialValue") != null) ? rs.getString("PotentialValue") : "-" %></div>
											  </div>
											  
											   <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Assighned by</div>
											    <div><%=((rs.getString("Assighnedby")!=null) ? rs.getString("Assighnedby") : "-") %></div>
											  </div>
											  
											  <div class="col-md-3 col-sm-6 col-12  p-2">
											    <div class="fw-bold">Lead Ref</div>
											    <div><%=((rs.getString("leadRef")!=null) ? rs.getString("leadRef") : "-") %></div>
											    
											    <%System.out.println("lead ref "+rs.getString("leadRef")); %>
											  </div>
											</div>
										</div>
									</div>													  
		    		              </div>
		    		            </div>
		    		        </div>
		    			</div>
		  			</section>
	 			</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>
<%@ include file="footer.jsp"%>
</body>
</html>