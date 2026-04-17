<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>
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
			Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null , st7 = null,st8=null;

			
			
				String todaysDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
					.format(new java.util.Date());
			String todaysTime = new SimpleDateFormat(" HH:mm:ss")
					.format(new java.util.Date());

			NumberFormat nf = new DecimalFormat("#0.00");

			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				st5 = conn.createStatement();
				st6 = conn.createStatement();
				st7 = conn.createStatement();
				st8 = conn.createStatement();
			} catch (Exception e) {
			}
			String mailbody="<html><body>";
			String Toid = "";
			String Tocc = "purchase@twtech.in,avlsupport@mobile-eye.in";
			String Twrefno="";
			String Model="";
			String Part="";
			String Description = "";
			String Specifications="";
			String enqrefno=request.getParameter("purenqrefno");
			String twrefno=request.getParameter("twrefno");
			System.out.println("REF NO I S      "+enqrefno);
			//String SqlEnqDet = "SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseenq WHERE PurchaseEnqNo='"+enqrefno+"' ";
			String SqlEnqDet = "SELECT * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseenq WHERE PurchaseEnqNo='"+enqrefno+"' and TWRefNo='"+twrefno+"'";
			System.out.println(">>>>>>>>>>>      " + SqlEnqDet);
			ResultSet rsEnqDet = st.executeQuery(SqlEnqDet);
			if (rsEnqDet.next()) 
			{
				String suppliercode=rsEnqDet.getString("Suppliercode");	
				Twrefno = rsEnqDet.getString("TWRefNo");
				
				String sql="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+suppliercode+"'";	
				System.out.print("sql>>>"+sql);
				ResultSet rssql=st1.executeQuery(sql);
				rssql.next();
				String suppliername=rssql.getString("SupplierName");
				String add=rssql.getString("Address");
				String stat=rssql.getString("State");
				String count=rssql.getString("Country");
				String zip=rssql.getString("Zip");
				String contact=rssql.getString("ContactPerson");
				String phn=rssql.getString("Phone");
				String fx=rssql.getString("Fax");
				Toid = rssql.getString("EMail"); 
				
				
				mailbody += "<table style=\"font-size:small;\"  width=\"100%\"  cellspacing=\"0\" cellpadding=\"0\"><tr>";
			    
				String companydata="select * from db_GlobalERP.CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
				ResultSet rsdata=st2.executeQuery(companydata);
				rsdata.next();
				
				String companyname=rsdata.getString("Companyname");
				String address=rsdata.getString("address");
				String phone=rsdata.getString("phone");
				String mail=rsdata.getString("emailid");
				String website=rsdata.getString("website");
				String fax=rsdata.getString("fax");
				
				
				
				mailbody+="<td style=\"font-size: small; \" align=\"center\" >";
				mailbody+="<b>"+companyname+"</b><br>";
				mailbody+= address+"<br>";
				mailbody+= phone+" "+fax+"<br>";
				mailbody+= mail+"  "+website+"</td>";
				mailbody+="</tr></table><br>";
				mailbody+="<table style=\"border: thin solid;\"  width=\"100%\">";
				mailbody+="<tr><td><b>Ref No:</b></td><td>"+rsEnqDet.getString("TWRefNo")+"</td></tr>";
				mailbody+="<tr><td><b>Enquiry No:</b></td><td>"+enqrefno+"</td></tr>";
				mailbody+="<tr><td><b>Enquiry Date:</b></td><td>"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnqDet.getString("PurEnqDate")))+"</td></tr>";
				mailbody+="<tr><td>Supplier:</td><td><b>"+suppliername+"</b></td></tr>";
				mailbody+="<tr><td><b>Kind Attn:</b></td><td>"+contact+"</td></tr>";
				mailbody+="<tr><td></td><td><b>Please offer your most competitive rates.</b></td></tr>";
				mailbody+="<tr><td><b>Phone:</b></td><td>"+phn+"</td></tr>";
				mailbody+="<tr><td><b>Fax:</b></td><td>"+fx+"</td></tr>";
				
			}
	
  mailbody+="</table>"; 
    
    
mailbody+="<div align=\"center\" style=\"font-size: small;\"><b><u>";
mailbody+="SUB : Request For Quotation</u></b></div>";
mailbody+="<div align=\"left\" style=\"font-size: small;\">";
mailbody+="Dear Sir,<br>";
mailbody+="Kindly quote us immediately for the following by FAX or E-MAIL to<br>";
mailbody+="purchase@twtech.in<br>+918600034609</div><br></br>";
 
mailbody+="<table border=\"1\" style=\"border-spacing: 0px;font-size: small;width:100%\" class=\"sortable\">";
mailbody+="<tr style=\"border-spacing: 0px\">";
mailbody+="<th>Sr No</th><th>Group</th><th>Make</th><th>Model</th><th>Part No</th><th style=\"width: 400px;\">Description</th><th>Specification</th><th>Quantity</th></tr>";
	
int i=1;
	String refMakeNameTable="",sqlDisplayDesc="";
		//String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo ='"+ enqrefno + "'  ";
		String sqlPurDet = "SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster WHERE Purchase_RefNo='"+ enqrefno + "'";
				ResultSet rsPurDet = st3.executeQuery(sqlPurDet);
				System.out.println("TTTTTTTTTTTTTTTTTTTTTTTT     "+sqlPurDet);
				while (rsPurDet.next()) {
						System.out.println("in while..");
					    String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
						int groupCode=0;
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						//quantity = rsPurDet.getString("Quantity");
						quantity = rsPurDet.getString("ApprovedQuantity");
						Description = rsPurDet.getString("ItemDescription");
						Specifications = rsPurDet.getString("Specifications");
						
						String Groupsql = "SELECT TheGroupName FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st4.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable="tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM db_GlobalERP."+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st5.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM db_GlobalERP.tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st6.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						if(rsSql.next())
						{
							
							 Model=rsSql.getString("Model");
							 Part=rsSql.getString("Partno");
						}else{
							Model="-";
							Part="-";
						}
							
	mailbody +=	"<tr><td><div align=\"right\">"+(i++)+"</div></td><td><div align=\"left\">"+groupName+"</div></td>"+
			     "<td><div align=\"left\">"+makeName+"</div></td><td><div align=\"left\">"+Model+"</div></td>"+
				"<td><div align=\"left\">"+Part+"</div></td><td><div align=\"left\">"+Description+"</div></td>"+
				"<td><div align=\"left\">"+Specifications+"</div></td><td><div align=\"right\">"+quantity+"</div></td></tr>";
				
				System.out.println(i);
				System.out.println(groupName);
				System.out.println(makeName);
				System.out.println(Model);
				System.out.println(Part);
				System.out.println(Description);
				System.out.println(Specifications);
				System.out.println(quantity);
					
					}
		
	
				mailbody +=	"</table>";
				mailbody +=	"<div style=\"font-size: small;\">Awaiting your early reply	<br>";
                mailbody += "</div>";
                mailbody += "<div align=\"right\" style=\"font-size: small;\"><b>";
                mailbody += "For Transworld Compressor Technologies Ltd.</b><br>";

   mailbody += session.getAttribute("EmpName").toString() +"<br>";
   mailbody += "(Authorised Signatory)</div>";
   
   mailbody +="<br><br><div class=\"regards mt-5\">\n" + 
			"<p>Thanks & Regards</p>\n" + 
			"<p>Transworld Support Team</p>\n" + 
			"<p>Phone: +91-20-41214444 +91-8600006061 +91-9762007125</p>\n" + 
			"<p>Email: <a href=\"avlsupport@mobile-eye.in\">avlsupport@mobile-eye.in</a></p>\n" + 
			"<p>Copyright @2008-2023 by Transworld Technologies Ltd. All Rights Reserved </p>\n" + 
			"</div>"
			+ "</div></body></html>";
   
   mailbody += "</body></html>";
 
  // System.out.println("mailbody:"+mailbody);
   String subjectline = "Request For Quotation-"+Twrefno;
   
  int send =0;
   
 String sqlinsrt = "insert into db_GlobalERP.t_allpendingmailtableERP(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath) values ('TWSupport','REQUEST FOR QUOTATION','" + mailbody + "','" + subjectline + "','" + Toid + "','" + Tocc + "',NOW(),'Pending','Transworld','','')";  
 System.out.println("insert--->"+sqlinsrt);
 send = st7.executeUpdate(sqlinsrt);
 
 if(send>=1){
	 
	%><script>alert("Email will be sent within the next 15 minutes");</script><%
 
 }
 
 response.sendRedirect ("PEDetails.jsp?transactionId="+enqrefno+"&condition=null&twref="+Twrefno);
 %>
 </body>
 </html>  
</jsp:useBean>  
 
 
