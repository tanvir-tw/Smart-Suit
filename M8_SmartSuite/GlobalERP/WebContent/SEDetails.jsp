<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ include file="headernew.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GlobalERP</title>
<script src="dropdown.js" type="text/javascript"></script>
<script src="ledgerDetails.js" type="text/javascript"></script>

</head>
<body style="background-color: azure;">


	<%
		Connection conn = null;
			Statement st = null,st1=null,st2=null,stgrp=null,stlbl=null;
			boolean isInvoiceSelected = false;
			int count=0;
			int d=0;
			Date today = new Date();
			String enqDate=new SimpleDateFormat("dd-MMM-yyyy").format(today);
			String date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enqDate));
			
			Date mothafter=new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			cal.add(Calendar.DAY_OF_MONTH,+30);
			Date MonthAsDate=cal.getTime();
			String monthafter=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(MonthAsDate);
			String monthafterInMMM=new SimpleDateFormat("dd-MMM-yyyy hh:mm;ss").format(MonthAsDate);
			System.out.println(monthafterInMMM+"())))))))))))))))))))))  ");
			
			Date today1 = new Date();
			String fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today1);
			
			String type=request.getParameter("condition");
			System.out.println("TYPE IS    "+type);
			
			String salesEnqRefNumber = request
					.getParameter("transactionId");
			String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="",fromdate="";
			
			System.out.println("After Type"+salesEnqRefNumber);
			
			try {
				conn = connection.getConnect("db_GlobalERP");
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				stgrp=conn.createStatement();
				stlbl=conn.createStatement();
			} catch (Exception e) {
			}
	%>
	<div class="container-fluid mt-2" id="main">
		<div class="content-header-col-md-7-mt-10 col-12">
			<div class="row breadcrumbs-top">
				<h5 class="content-header-title text-center mb-0"
					style="color: #060637">Sales Enquiry :<%=request.getParameter("transactionId")%></h5>
			</div>
			<br>
		</div>
		
		
		
		<%
if(type.equalsIgnoreCase("View") )
{
%>		
<%
	String salesEnqNumber="";
	String sqlInvoice = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqRefNo = '"
					+ salesEnqRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlInvoice);
	
	System.out.println("date query-------------->"+sqlInvoice);
	if (rsTransaction.next()) 
	{
				String dueDate = "";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
							.format(new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss")
									.parse(rsTransaction
											.getString("SalesEnqDueDate")));
				} catch (Exception e) {
				}
				salesEnqNumber=rsTransaction.getString("SalesEnqNo");
				dueDate=rsTransaction.getString("SalesEnqDueDate");
%>
	<div class="container-fluid">
				<div class="card p-3 shadow-sm" id="visitingCard"
					style="max-width: 1100px; margin: auto; min-height: 140px;" >

					<div class="row">
					
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Enq No:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("SalesEnqNo")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Enq Date:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("SalesEnqDate")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Customer Name:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CompanyName")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Contact:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("ContactPerson")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
								<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Ref No:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CustRefNo")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>					
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Address:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("Address") + " , "
							+ rsTransaction.getString("city") + " , "
							+ rsTransaction.getString("zip") + " , "
							+ rsTransaction.getString("state") + " , "
							+ rsTransaction.getString("country")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						
						
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Phone:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("Phone")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						
						
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Fax:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("fax")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						
						
				<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Entered By:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("TWEmpName")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Due Date:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("SalesEnqDueDate")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="duedate" value="<%=rsTransaction.getString("SalesEnqDueDate")%>"/>
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Status:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=(rsTransaction.getInt("SalesEnqClosed") == 0 ? "Open": "Closed")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
					    <div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Customer Remarks:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CustRemarks")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
</div>



</div>
</div>

<!--Datatable  -->
<br>
<table id="example" class="display" style="width: 100%;">
<thead>
		<tr>
		<th class="col-width-4">Sr. No</th>
			<%
		String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
	<th><%=rslbl.getString("Make") %></th>
	<th><%=rslbl.getString("Model") %></th>
	<th><%=rslbl.getString("PartNO") %></th>
	<th><%=rslbl.getString("Description") %></th>
	<%} %>
			<th>Group</th>
			<th>Supplier</th>
			<th>Landed Price</th>
			<th>Selling Price</th>
			<th>Price Entered On</th>
			<th>Stock</th>
 
		</tr>
		</thead>
		<tbody>
	<%
	int i=1;
		String sqlSalesDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster as b ON (a.TheGroup=b.TheGroupCode)  WHERE a.SalesEnqNo = '"
						+ salesEnqNumber + "'  ";
	
				ResultSet rsSalesDet = st.executeQuery(sqlSalesDet);
				while (rsSalesDet.next()) {
						String makeCode = "", itemCode = "", groupCode = "", quantity, makeName = "",groupName="";
						makeCode = rsSalesDet.getString("make");
						itemCode = rsSalesDet.getString("itemcode");
						groupCode = rsSalesDet.getString("TheGroup");
						quantity = rsSalesDet.getString("quantity");
	
						String tableToBeAccessed = rsSalesDet.getString("TheTableToBeAccessed").toLowerCase();
	
						String sqlItemDetails = "SELECT * FROM "
								+ tableToBeAccessed + " AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b "+
								" ON (a.supplierCode=b.supplierCode) where a.ItemCode='"
								+ itemCode + "' ";
						
						System.out.println(sqlItemDetails);
						System.out.println(sqlItemDetails);
						
						ResultSet rsItemDetails = st1
								.executeQuery(sqlItemDetails);
						if (rsItemDetails.next())
						{
							if (tableToBeAccessed.contains("other"))
								makeName = rsItemDetails.getString("makeName");
							else{
								makeName = "";
								String grpsql="select TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode="+groupCode;
								ResultSet rsgrp=stgrp.executeQuery(grpsql);
								if(rsgrp.next())
								{
									groupName=rsgrp.getString("TheGroupName");
								}
								System.out.println("GROUP Name IS:::::::::======="+groupName);
								
								String sqlMakeCode="SELECT * from "+tableToBeAccessed.substring(0,9)+"_"+groupName.substring(0,5).toLowerCase()+"makemaster where makecode='"+makeCode+"'";
								ResultSet rsMakeCode=st2.executeQuery(sqlMakeCode);
								if(rsMakeCode.next())
									makeName=rsMakeCode.getString("makename");
								
							}
							String priceDate="-";
							try{
								priceDate=(rsItemDetails.getString("PriceDate")==null || rsItemDetails.getString("PriceDate").contains("0000-00-00") ?"-":rsItemDetails.getString("PriceDate"));
							}catch(Exception e){e.printStackTrace();}
	%>
						<tr>
							<td class="text-center"> <%=i++%> </td>
							<td class="text-left"> <%=makeName %> </td>
							<td class="text-left"> <%=rsItemDetails.getString("Model")%> </td>
							<td class="text-left"> <%=rsItemDetails.getString("Partno")%> </td>
							<td class="text-left"> <%=rsItemDetails.getString("Description")%> </td>
							<td class="text-left"> <%=rsSalesDet.getString("TheGroupName")%> </td>
							<td class="text-center"> <%=(rsItemDetails.getString("SupplierName")==null? "-" :rsItemDetails.getString("SupplierName"))%> </td>
							<td class="text-right"> <%=rsItemDetails.getString("LandedPrice")%> </td>
							<td class="text-right"> <%=rsItemDetails.getString("SellingPrice")%> </td>
							<td class="text-right"> <%=priceDate%> </td>
							<td class="text-right"> <%=rsItemDetails.getString("InOurStock")%> </td>
				 	</tr>
<%
						}
					}
		}
	%>
</tbody>
</table>

<br>


<%} %>

	
<%
if(type.equalsIgnoreCase("close"))
{
%>		
<%
	String salesEnqNumber="";
	String sqlInvoice = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqRefNo = '"
					+ salesEnqRefNumber + "' ";
	ResultSet rsTransaction = st.executeQuery(sqlInvoice);
	if (rsTransaction.next()) 
	{
				String dueDate = "";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
							.format(new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss")
									.parse(rsTransaction
											.getString("SalesEnqDueDate")));
				} catch (Exception e) {
				}
				salesEnqNumber=rsTransaction.getString("SalesEnqNo");
%>
<div class="container-fluid">
    <div class="card p-3 shadow-sm" id="visitingCard"
         style="max-width: 1100px; margin: auto; min-height: 140px;">

        <div class="row">

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Enq No:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("SalesEnqNo")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Enq Date:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("SalesEnqDate")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Customer Name:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("CompanyName")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Contact:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("ContactPerson")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Ref No:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("CustRefNo")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Address:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("Address") + " , "
                           + rsTransaction.getString("city") + " , "
                           + rsTransaction.getString("zip") + " , "
                           + rsTransaction.getString("state") + " , "
                           + rsTransaction.getString("country")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Phone:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("Phone")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Fax:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("fax")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Entered By:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("TWEmpName")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Due Date:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("SalesEnqDueDate")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Status:</b></label>
                    <input type="text"
                           value="<%=(rsTransaction.getInt("SalesEnqClosed") == 0 ? "Open" : "Closed")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="d-flex align-items-center">
                    <label style="width:130px; min-width:130px;"><b>Customer Remarks:</b></label>
                    <input type="text"
                           value="<%=rsTransaction.getString("CustRemarks")%>"
                           class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
                </div>
            </div>

        </div>
    </div>
</div>

<%-- <div class="container-fluid">
				<div class="card p-3 shadow-sm" id="visitingCard"
					style="max-width: 1100px; margin: auto; min-height: 140px;" >

					<div class="row">
					
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Enq No:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("SalesEnqNo")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Enq Date:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("SalesEnqDate")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Customer Name:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CompanyName")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Contact:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("ContactPerson")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						
					
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Ref No:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CustRefNo")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Address:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("Address") + " , "
							+ rsTransaction.getString("city") + " , "
							+ rsTransaction.getString("zip") + " , "
							+ rsTransaction.getString("state") + " , "
							+ rsTransaction.getString("country")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Phone:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("Phone")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Fax:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("fax")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Entered By:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("TWEmpName")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Due Date:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=dueDate%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="duedate" value="<%=dueDate%>"/>
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Status:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=(rsTransaction.getInt("SalesEnqClosed") == 0 ? "Open"
											: "Closed")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Customer Remarks:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CustRemarks")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						
						</div>
						</div>
						</div> --%>
						<br>
<table id="example" class="display" style="width: 100%;">
<thead>
		<tr>
		<th>Sr. No</th>
			<%
		String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
	<th><%=rslbl.getString("Make") %></th>
	<th><%=rslbl.getString("Model") %></th>
	<th><%=rslbl.getString("PartNO") %></th>
	<th><%=rslbl.getString("Description") %></th>
	<%} %>
			<th>Group</th>
			<th>Supplier</th>
			<th>Landed Price</th>
			<th>Selling Price</th>
			<th>Price Entered On</th>
			<th>Stock</th>
 
		</tr>
		</thead>
		<tbody>
	<%
	int i=1;
		String sqlSalesDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster as b ON (a.TheGroup=b.TheGroupCode)  WHERE a.SalesEnqNo = '"
						+ salesEnqNumber + "'  ";
	
				ResultSet rsSalesDet = st.executeQuery(sqlSalesDet);
				while (rsSalesDet.next()) {
						String makeCode = "", itemCode = "", groupCode = "", quantity, makeName = "",groupName="";
						makeCode = rsSalesDet.getString("make");
						itemCode = rsSalesDet.getString("itemcode");
						groupCode = rsSalesDet.getString("TheGroup");
						quantity = rsSalesDet.getString("quantity");
	
						String tableToBeAccessed = rsSalesDet.getString(
								"TheTableToBeAccessed").toLowerCase();
	
						String sqlItemDetails = "SELECT * FROM "
								+ tableToBeAccessed + " AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b "+
								" ON (a.supplierCode=b.supplierCode) where a.ItemCode='"
								+ itemCode + "' ";
						
						System.out.println(sqlItemDetails);
						System.out.println(sqlItemDetails);
						String grpsql="select TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode="+groupCode;
						ResultSet rsgrp=stgrp.executeQuery(grpsql);
						if(rsgrp.next())
						{
							groupName=rsgrp.getString("TheGroupName");
						}
						System.out.println("GROUP Name IS:::::::::======="+groupName);
						
						ResultSet rsItemDetails = st1
								.executeQuery(sqlItemDetails);
						if (rsItemDetails.next())
						{
							if (tableToBeAccessed.contains("other"))
								makeName = rsItemDetails.getString("makeName");
							else{
								makeName = "";
								String sqlMakeCode="SELECT * from "+tableToBeAccessed.substring(0,9)+"_"+groupName.substring(0,5).toLowerCase()+"makemaster where makecode='"+makeCode+"'";
								ResultSet rsMakeCode=st2.executeQuery(sqlMakeCode);
								if(rsMakeCode.next())
									makeName=rsMakeCode.getString("makename");
								
							}
							String priceDate="-";
							try{
								priceDate=(rsItemDetails.getString("PriceDate")==null || rsItemDetails.getString("PriceDate").contains("0000-00-00") ?"-":rsItemDetails.getString("PriceDate"));
							}catch(Exception e){e.printStackTrace();}
	%>
						<tr>
							<td class="text-right"><%=i++%> </td>
							<td class="text-left"><%=makeName %> </td>
							<td class="text-left"><%=rsItemDetails.getString("Model")%> </td>
							<td class="text-right"><%=rsItemDetails.getString("Partno")%> </td>
							<td class="text-left"><%=rsItemDetails.getString("Description")%> </td>
							<td class="text-right"><%=rsSalesDet.getString("TheGroupName")%> </td>
							<td class="text-left"><%=(rsItemDetails.getString("SupplierName")==null? "-" :rsItemDetails.getString("SupplierName"))%> </td>
							<td class="text-right"><%=rsItemDetails.getString("LandedPrice")%> </td>
							<td class="text-right"><%=rsItemDetails.getString("SellingPrice")%> </td>
							<td class="text-right"><%=priceDate%> </td>
							<td class="text-right"><%=rsItemDetails.getString("InOurStock")%> </td>
				 	</tr>
<%
						}
					}
		}
	%>
</tbody>
</table>

<div align="center" id="closebutton" style="margin-top: 3em;">
	<input type="submit" name="closeEnquiry" value="close Enquiry" onclick="closeEnq();" class="btn btn-primary" id="button" />
</div>

<form name="form2" method="get" action="closeEnq.jsp">

    <div id="header" style="font-size: 1.1em; margin-top: 15px;">
        <b>Reason For Cancelling :</b>
    </div>

    <div id="cancellingreason" style="margin-top: 10px; max-width: 430px;">
        <div class="shadow-sm p-2 bg-white rounded">
            <textarea name="reasoncancel"
                      id="reasoncancel"
                      class="form-control border-0 shadow-none"
                      style="height: 160px; resize: none;"></textarea>
        </div>
    </div>

    <input type="hidden" name="reasonforcancel" value="reasonforcancel"/>
    <input type="hidden" name="salesrefno" value="<%=salesEnqRefNumber %>"/>

    <div align="center" id="submitbutton" style="margin-top: 15px;">
        <input type="submit"
               name="Submit TT"
               value="Submit Reason"
               class="btn btn-primary"
               id="button"
               onclick="return validrs();" />
    </div>

</form>

<script>
    document.getElementById("header").style.visibility = "hidden";
    document.getElementById("cancellingreason").style.visibility = "hidden";
    document.getElementById("submitbutton").style.visibility = "hidden";
</script>

<script>
    document.getElementById("header").style.visibility = "hidden";
    document.getElementById("cancellingreason").style.visibility = "hidden";
    document.getElementById("submitbutton").style.visibility = "hidden";
</script>
<%} %>

<%
if(type.equalsIgnoreCase("revise"))
{
//*********************************************  FOR REVISE **************************************************************************	
%>

<%
	String salesEnqNumber="";
		String sqlInvoice = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_det WHERE SalesEnqRefNo = '"
					+ salesEnqRefNumber + "' ";
			ResultSet rsTransaction = st.executeQuery(sqlInvoice);
			if (rsTransaction.next())
			{
				String dueDate = "";
				try {
					dueDate = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
							.format(new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss")
									.parse(rsTransaction
											.getString("SalesEnqDueDate")));
				} catch (Exception e) {
				}
				salesEnqNumber=rsTransaction.getString("SalesEnqNo");
%>

<div class="container-fluid">
				<div class="card p-3 shadow-sm" id="visitingCard"
					style="max-width: 1100px; margin: auto; min-height: 140px;" >

					<div class="row">
					
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Enq No:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("SalesEnqNo")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Enq Date:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=date%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="enqdate" value="<%=date%>"/>
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Customer Name:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CompanyName")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="company" value="<%=rsTransaction.getString("CompanyName")%>"/>
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Contact:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("ContactPerson")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="contactperson" value="<%=rsTransaction.getString("ContactPerson")%>"/>
						</div>
						
					
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Ref No:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CustRefNo")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="refno" value="<%=rsTransaction.getString("CustRefNo")%>"/>
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Address:</b></label>
							<input type="hidden" name="address" value="<%=rsTransaction.getString("Address")%>"/>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("Address") + " , "
							+ rsTransaction.getString("city") + " , "
							+ rsTransaction.getString("zip") + " , "
							+ rsTransaction.getString("state") + " , "
							+ rsTransaction.getString("country")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								
							<input type="hidden" name="city" value="<%=rsTransaction.getString("city") %>"/>
				<input type="hidden" name="zip" value="<%=rsTransaction.getString("zip") %>"/>
				<input type="hidden" name="state" value="<%=rsTransaction.getString("state") %>"/>
				<input type="hidden" name="country" value="<%=rsTransaction.getString("country") %>"/>	
								
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Phone:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("Phone") %>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="phone" value="<%=rsTransaction.getString("Phone") %>"/>
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Fax:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("fax")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="fax" value="<%=rsTransaction.getString("fax")%>"/>
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Entered By:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("TWEmpName")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Due Date:</b></label>
						<input type="text" name="companyName" id="search-text"
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="expirydate" value="<%=monthafter %>"/>
						</div>
						<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Status:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=(rsTransaction.getInt("SalesEnqClosed") == 0 ? "Open"
											: "Closed")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
						</div>
							<div class="col-md-4 d-flex align-items-start">
							<label class="me-2" style="width: 130px;"><b>Customer Remarks:</b></label>
							<input type="text" name="companyName" id="search-text"
								value="<%=rsTransaction.getString("CustRemarks")%>" 
								class="form-control form-control-sm bg-light border-0 p-0 shadow-none">
								<input type="hidden" name="custremark" value="<%=rsTransaction.getString("CustRemarks")%>"/>
						</div>
						<input type="hidden" name="customercode" value="<%=rsTransaction.getString("CustomerCode") %>"/>
		<input type="hidden" name="addresscode" value="<%=rsTransaction.getString("AddressCode") %>"/>
						</div>
						</div>
						</div>
						
						
						
<table id="example" class="display" style="width: 100%;">
<thead>
		<tr>
		    <th>Sr. No</th>
			<%
		String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
	<th><%=rslbl.getString("Make") %></th>
	<th><%=rslbl.getString("Model") %></th>
	<th><%=rslbl.getString("PartNO") %></th>
	<th><%=rslbl.getString("Description") %></th>
	<%} %>
			<th>Group</th>
			<th>Supplier</th>
			<th>Quantity</th>
			<th>Landed Price</th>
			<th>Selling Price</th>
			<th>Price Entered On</th>
			<th>Stock</th>
 		</tr>
 		</thead>
 		<tbody>
	<%
	    int i=1;
		
		String sqlSalesDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"salesenq_items AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster as b ON (a.TheGroup=b.TheGroupCode)  WHERE a.SalesEnqNo = '"
						+ salesEnqNumber + "'  ";
		System.out.println("&&&&&&&&&***********************          "+sqlSalesDet);
		ResultSet rsSalesDet = st.executeQuery(sqlSalesDet);
		while (rsSalesDet.next()) {
		String makeCode = "", itemCode = "", groupCode = "", quantity, makeName = "",groupName="";
		makeCode = rsSalesDet.getString("make");
		itemCode = rsSalesDet.getString("itemcode");
		groupCode = rsSalesDet.getString("TheGroup");
		quantity = rsSalesDet.getString("quantity");
	    
		String tableToBeAccessed = rsSalesDet.getString(
							"TheTableToBeAccessed").toLowerCase();
		System.out.println("?>>>>>>>>>>>>>>>      "+tableToBeAccessed);
		String sqlItemDetails = "SELECT * FROM "
								+ tableToBeAccessed + " AS a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b "+
								" ON (a.supplierCode=b.supplierCode) where a.ItemCode='"
								+ itemCode + "' ";
												
		System.out.println(sqlItemDetails);
		
		String grpsql="select TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster where TheGroupCode="+groupCode;
		ResultSet rsgrp=stgrp.executeQuery(grpsql);
		if(rsgrp.next())
		{
			groupName=rsgrp.getString("TheGroupName");
		}
		System.out.println("GROUP Name IS:::::::::======="+groupName);
		ResultSet rsItemDetails = st1.executeQuery(sqlItemDetails);
		if (rsItemDetails.next())
						{
							if (tableToBeAccessed.contains("other"))
								makeName = rsItemDetails.getString("makeName");
							else{
								makeName = "";
								String sqlMakeCode="SELECT * from "+tableToBeAccessed.substring(0,9)+"_"+groupName.substring(0,5).toLowerCase()+"makemaster where makecode='"+makeCode+"'";
								ResultSet rsMakeCode=st2.executeQuery(sqlMakeCode);
								if(rsMakeCode.next())
									makeName=rsMakeCode.getString("makename");
								
							}
							String priceDate="-";
							try{
								priceDate=(rsItemDetails.getString("PriceDate")==null || rsItemDetails.getString("PriceDate").contains("0000-00-00") ?"-":rsItemDetails.getString("PriceDate"));
							}catch(Exception e){e.printStackTrace();}
%>
						<tr>
							<td>
							<div align="right"><%=i++%></div></td>
							<td><div align="left"><%=makeName %></div></td>
							<td><div align="left"><%=rsItemDetails.getString("Model")%></div></td>
							<td><div align="right"><%=rsItemDetails.getString("Partno")%></div></td>
							<td><div align="left"><%=rsItemDetails.getString("Description")%></div></td>
							<td><div align="right"><input type="hidden" name="groupname<%=d %>" value="<%=rsSalesDet.getString("TheGroupName")%>"/><%=rsSalesDet.getString("TheGroupName")%></div></td>
							<td><div align="left"><%=(rsItemDetails.getString("SupplierName")==null? "-" :rsItemDetails.getString("SupplierName"))%></div></td>
							<td><div align="right"><input type="text"  id="quantity<%=d %>" name="quantity<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	            			   border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	           				   color: #000000;" value="<%=rsSalesDet.getString("Quantity") %>" /></div></td>
							<td><div align="right"><%=rsItemDetails.getString("LandedPrice")%></div></td>
							<td><div align="right"><input type="text"  id="sellingprice<%=d %>" name="sellingprice<%=d %>" style="width : 70px; padding: 4px 5px 2px 5px;
	               				border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
	              				color: #000000;" value="<%=rsItemDetails.getString("SellingPrice") %>" /></div></td>
							<td><div align="right"><%=priceDate%></div></td>
							<td><div align="right"><%=rsItemDetails.getString("InOurStock")%></div></td>
				 	   </tr>
				 	   <input type="hidden" name="groupcode<%=d %>" value="<%=groupCode%>"/>
				 	   <input type="hidden" name="makecode<%=d %>" value="<%=makeCode%>"/>
				 	   <input type="hidden" name="itemcode<%=d %>" value="<%=itemCode%>"/>
				 	   <input type="hidden" name="quantity<%=d %>" value="<%=rsSalesDet.getString("Quantity") %>"/>
				 	   <input type="hidden" name="description<%=d %>" value="<%=rsItemDetails.getString("Description") %>"/>
				 	   
				 	   
<%                       d++;
						}
					}count=i-1;
				}
%>

 </tbody>     	
</table>
						
	<input type="hidden" name="count"  id="count" value="<%=count %>"/>
	<input type="hidden" name="salesenqrefno" id="salesenqrefno" value="<%=request.getParameter("transactionId") %>"/>
	<%
	System.out.println("transaction Id ISSSSSSSSSSSSSSSSSSSS"+request.getParameter("transactionId"));
	%>

<br>
<br>	
	
	<div align="center">
	<input type="submit" class="btn btn-primary" id="button" onclick=""	name="ReviseEnquiry" value="Revise Enquiry" />
	</div>	
		
	
	
<%} %>
		</div>

	<script type="text/javascript">

	function validrs(){ 

		var cancel=document.getElementById("reasoncancel").value;
		if(cancel=="")
			{
			alert("Please Insert Reason First");
			return false;
			}
		}
	
	
	function closeEnq()
	{
		//alert("Do YOU want to close This Enquiry??");
		var agree=confirm("Pls Enter Reason For Closing This  Enquiry");
		if (agree)
		{
		document.getElementById("header").style.visibility="visible";
		document.getElementById("cancellingreason").style.visibility="visible";
		document.getElementById("submitbutton").style.visibility="visible";
		return true ;
		}
		else
		return false ;
	}
	
	
	function redirect(webadd,senqrefno)
	{
	
		window.open(webadd+'?senqrefno='+senqrefno,'jav');
	}

	function redirectforpdf(webadd,senqrefno)
	{
	
		window.open(webadd+'?senqrefno='+senqrefno,'jav');
	}
	</script>
		<script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  
	        stateSave: true,
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]],
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
								title: 'SEDetails Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                            text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'SEDetails Report '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                            text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                            className: 'dropdown-item',
								title: 'SEDetails Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                            extend: 'print',
                            text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                            className: 'dropdown-item',
								title: 'SEDetails Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'SEDetails Report '+$("#data").val()+ 'to' +$("#data1").val(),
							},
					],
				},
           ], 
       
       });

   });
   
</script>
<%@ include file="footer.jsp"%>
</body>
</html>