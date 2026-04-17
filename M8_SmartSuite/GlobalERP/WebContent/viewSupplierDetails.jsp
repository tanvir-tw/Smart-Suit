<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>

	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>

	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	</head>
	<body>
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st2 = null;
		if(request.getParameter("supplierCode")==null)
		{
			String itemDesc=request.getParameter("itemDesc").replace("`","\"").replace("~","&");
			String itemCode=request.getParameter("itemCode");
			String tableToBeAccessed="";
			int numberOfRows=0;			 
			%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.4em; height: 4px; background-color: #339CCB">
	</div>

	<div align="center" style="font-size: 1.5em;">Supplier Details
	for :-<a> <%=itemDesc %></a></div>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 1em; height: 4px; background-color: #339CCB">
	</div>
	<%
			try {
				String mkcode=request.getParameter("makecode");
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				ResultSet rsCount=null;
				String comid=session.getAttribute("CompanyMasterID").toString();
					tableToBeAccessed=request.getParameter("tableToBeAccessed").toString();
					String tbl=tableToBeAccessed.substring(0, 5);
					try{
						if(tableToBeAccessed.contains("tbl_"))
							rsCount=st.executeQuery("SELECT count(*)  FROM "+tableToBeAccessed+" WHERE itemCode='"+itemCode+"'");
						else{
							String s="SELECT count(*)  FROM "+comid+"tbl_"+tbl+"im_make"+mkcode+" WHERE ItemCode='"+itemCode+"'";
							System.out.println("SQL-"+s);
							rsCount=st.executeQuery(s);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
					if(rsCount.next())
						numberOfRows=rsCount.getInt(1);
					System.out.println(numberOfRows);
					
					String sql="SELECT * FROM "+tableToBeAccessed+" a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet b on (a.suppliercode=b.suppliercode) "+
					"  WHERE a.itemCode='"+itemCode+"'";
					
					
					
					
					//db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_comprim_make106
					ResultSet rs=null; 
					try{
						System.out.println("SQL-"+sql);
					rs=st2.executeQuery(sql);
					}catch(Exception e){
						
						String sql1="SELECT * FROM "+comid+"tbl_"+tbl+"im_make"+mkcode+" a LEFT OUTER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet b on (a.suppliercode=b.suppliercode) "+
								"  WHERE a.ItemCode='"+itemCode+"'";
						System.out.println("SQL1-"+sql1);
						rs=st2.executeQuery(sql1);
					}
					
if(numberOfRows==1)
{
	  rs.next();
	%>
	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Supplier Name </b></td>
			<td><label><%=((rs.getString("SupplierName")!=null) ? rs.getString("SupplierName") : "-") %>
			</label></td>

			<td><b>Supplier Code</b></td>
			<td><label><%=((rs.getString("SupplierCode")!=null) ? rs.getString("SupplierCode") : "-") %>
			</label></td>
		</tr>
		<tr>
			<td valign="top"><b>Contact Person</b></td>
			<td valign="top"><label><%=((rs.getString("ContactPerson")!=null) ? rs.getString("ContactPerson") : "-") %>
			</label></td>

			<td valign="top"><b>Address</b></td>
			<td valign="top"><label><%=((rs.getString("Address")!=null) ? rs.getString("Address") : "-")%>
			<br><%=((rs.getString("State")!=null) ? rs.getString("State") : "")%>
			<br><%=((rs.getString("Country")!=null) ? rs.getString("Country") :"" )%>
			<br><%=((rs.getString("Zip")!=null) ? rs.getString("Zip") :"" ) %>
			</label></td>
		</tr>

		<tr>
			<td><b>Email</b></td>
			<td><label> <%=((rs.getString("Email")!=null) ? rs.getString("Email") : "-") %></label>
			</td>

			<td><b>Phone,Mobile & Fax</b></td>
			<td><label><%=((rs.getString("Phone")!=null) ? rs.getString("Phone") : "-")+ " , "+
			 		((rs.getString("Mobile")!=null) ? rs.getString("Mobile") : "-")+ " ,  "+
			 		((rs.getString("Fax")!=null) ? rs.getString("Fax") : "-")
			 		%> </label></td>
		</tr>
		<tr>
			<td><b>WebSite</b></td>
			<td><label><%=((rs.getString("WebSite")!=null) ? rs.getString("WebSite") : "-") %>
			</label></td>

			<td><b> Supplier Product:</b></td>
			<td><label> <%=((rs.getString("SupProduct")!=null) ? rs.getString("SupProduct") : "-") %></label>
			</td>
		</tr>
		<tr>
			<td><b>Rating</b></td>
			<td><label><%=((rs.getString("Sup_Rating")!=null) ? rs.getString("Sup_Rating") : "-") %></label>
			</td>

			<td><b>Weekly Off on</b></td>
			<td><label> <%=((rs.getString("WeeklyOff")!=null) ? rs.getString("WeeklyOff") : "-") %></label>
			</td>
		</tr>

	</table>

	<br>
	<div align="center" style="font-size: 1.3em;">Product Details</div>
	<br>
	
	<table border='1px' class='sortable'>
		<tr>
			<th>Landed Price</th>
			<th>Price Date</th>
			<th>Cost Factor</th>
			<th>Selling Price</th>
			<th>OEM Prices</th>
			<th>Stock</th>
			<th>Sign</th>
			<th>Entered on</th>
		</tr>
		<tr>
			<td>
			<div align="right"><%=((rs.getString("LandedPrice")!=null) ? rs.getString("LandedPrice") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("PriceDate")!=null) ? new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat(
								"yyyy-MM-dd")
								.parse(rs.getString("PriceDate"))) : "-")%></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("CostFactor")!=null) ? rs.getString("CostFactor") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("SellingPrice")!=null) ? rs.getString("SellingPrice") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("OEMPrices")!=null) ? rs.getString("OEMPrices") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("InOurStock")!=null) ? rs.getString("InOurStock") : "-") %></div>
			</td>
			<td>
			<div align="left"><%=((rs.getString("EnteredBy")!=null) ? rs.getString("EnteredBy") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("EnteredonDate")!=null) ? new SimpleDateFormat(
						"dd-MMM-yyyy")
						.format(new SimpleDateFormat(
								"yyyy-MM-dd")
								.parse(rs.getString("EnteredonDate"))) : "-") %></div>
			</td>
		</tr>
	</table>
	<%
}
else if(numberOfRows!=0)
{
	%>
	<table border='1px' class='sortable'>
		<tr>
			<th>Sr no</th>
			<th>Supplier Code.</th>
			<th>Supplier Name</th>
			<th>Landed Price</th>
			<th>Price Date</th>
			<th>Cost Factor</th>
			<th>Selling Price</th>
			<th>OEM Prices</th>
			<th>Stock</th>
			<th>Sign</th>
			<th>Entered on</th>
		</tr>
<%
				 int i=1;
				 while(rs.next()){
%>
		<tr>
			<td> 
			<div align="right"><%= i++ %></div>
			</td>
			<td>
			<div align="right"><%=rs.getString("SupplierCode") %></div>
			</td>
			<td>
			<div align="right"><a href="#" onclick="window.location='?supplierCode=<%=rs.getString("suppliercode")%>';"> 
			<%=rs.getString("SupplierName") %></a></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("LandedPrice")!=null) ? rs.getString("LandedPrice") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("PriceDate")!=null) ? rs.getString("PriceDate") : "-")%></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("CostFactor")!=null) ? rs.getString("CostFactor") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("SellingPrice")!=null) ? rs.getString("SellingPrice") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("OEMPrices")!=null) ? rs.getString("OEMPrices") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("InOurStock")!=null) ? rs.getString("InOurStock") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("EnteredBy")!=null) ? rs.getString("EnteredBy") : "-") %></div>
			</td>
			<td>
			<div align="right"><%=((rs.getString("EnteredonDate")!=null) ? rs.getString("EnteredonDate") : "-") %></div>
			</td>
		</tr>
<%
		 	}
 %>
	</table>
	<%
			}
			try {  conn.close(); } catch (Exception e) { e.printStackTrace(); }
		} catch (Exception e) {
				e.printStackTrace();
				%>
				
			<div style="height: 20px;margin: 0 auto;padding: 0px 0 15px 0;background: #1582AB;
    border-top: 1px solid #1885B0;margin-top:28%;
    font-family: Arial, Helvetica, sans-serif;" ><center>	No Data Found</center></div>
				<%
		}
	}
		else{
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
					String sql="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"supplierdet "+
					"  WHERE SupplierCode='"+request.getParameter("supplierCode")+"'";
					
					ResultSet rs=st.executeQuery(sql);
 
	  if(rs.next()){
	%>
	
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.4em; height: 4px; background-color: #339CCB">
	</div>

	<div align="center" style="font-size: 1.5em;">Supplier : <a>
	<%=((rs.getString("SupplierName")!=null) ? rs.getString("SupplierName") : "-") %> 
	</a>
	</div>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 1em; height: 4px; background-color: #339CCB">
	</div>

	<table bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		<tr>
			<td><b>Supplier Name </b></td>
			<td><label><%=((rs.getString("SupplierName")!=null) ? rs.getString("SupplierName") : "-") %>
			</label></td>

			<td><b>Supplier Code</b></td>
			<td><label><%=((rs.getString("SupplierCode")!=null) ? rs.getString("SupplierCode") : "-") %>
			</label></td>
		</tr>
		<tr>
			<td valign="top"><b>Contact Person</b></td>
			<td valign="top"><label><%=((rs.getString("ContactPerson")!=null) ? rs.getString("ContactPerson") : "-") %>
			</label></td>

			<td valign="top"><b>Address</b></td>
			<td valign="top"><label><%=((rs.getString("Address")!=null) ? rs.getString("Address") : "-")%>
			<br><%=((rs.getString("State")!=null) ? rs.getString("State") : "")%>
			<br><%=((rs.getString("Country")!=null) ? rs.getString("Country") :"" )%>
			<br><%=((rs.getString("Zip")!=null) ? rs.getString("Zip") :"" ) %>
			</label></td>
		</tr>

		<tr>
			<td><b>Email</b></td>
			<td><label> <%=((rs.getString("Email")!=null) ? rs.getString("Email") : "-") %></label>
			</td>

			<td><b>Phone,Mobile & Fax</b></td>
			<td><label><%=((rs.getString("Phone")!=null) ? rs.getString("Phone") : "-")+ " , "+
			 		((rs.getString("Mobile")!=null) ? rs.getString("Mobile") : "-")+ " ,  "+
			 		((rs.getString("Fax")!=null) ? rs.getString("Fax") : "-")
			 		%> </label></td>
		</tr>
		<tr>
			<td><b>WebSite</b></td>
			<td><label><%=((rs.getString("WebSite")!=null) ? rs.getString("WebSite") : "-") %>
			</label></td>

			<td><b> Supplier Product:</b></td>
			<td><label> <%=((rs.getString("SupProduct")!=null) ? rs.getString("SupProduct") : "-") %></label>
			</td>
		</tr>
		<tr>
			<td><b>Rating</b></td>
			<td><label><%=((rs.getString("Sup_Rating")!=null) ? rs.getString("Sup_Rating") : "-") %></label>
			</td>

			<td><b>Weekly Off on</b></td>
			<td><label> <%=((rs.getString("WeeklyOff")!=null) ? rs.getString("WeeklyOff") : "-") %></label>
			</td>
		</tr>
	</table>

	<%
	  }
	try { 
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		%>
		No Data Found
		<%
	}
} catch (Exception e) {
	e.printStackTrace();
	%>
	No Data Found
	<%
}
		}
	%>

	<br><br> <br><br> <br><br> <br><br>

	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>