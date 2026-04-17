<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">



	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>


	<script language="JavaScript1.2">

</script>

	<%
		//erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		    Connection conn = null, cn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			//String selectedName;
			//String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			//String companyName="",phone="",contact="",email="",product="",city="";			
			//String id=request.getParameter("id");
			//System.out.println("ID CMING IS   ++++++++++++++          "+id);
			String DBDriver="com.mysql.cj.jdbc.Driver";
			String DBNAME="jdbc:mysql://"+host1+"/db_GlobalERP";
			String DBUSERNAME=user1;
			String DBPASSWORD=pass1;
			//String DBNAMEPAY="jdbc:mysql:// twdb.fleetview.in/db_leaveapplication";
			int invoiceno=0, customercode=0, itemcode=0;
			Date invoicedate = null;
			float grandtotal = 0;
			String terms="",freighttype="",paymentmode="",seandsqrefno="",annexure="",companyname="",invoicetype="",thetabletobeaccessed="",quantity="",description=""; 
			String sql = "", sql1 = "";
	%>
	<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) 
	{
	  fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	  fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate")))
	{
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	/*
	System.out.println(request.getParameter("checkAll"));
	System.out.println(request.getParameter("checkAll"));
	System.out.println(request.getParameter("checkAll"));
	System.out.println(request.getParameter("checkAll"));
	
	if (null == request.getParameter("checkAll") && null != request.getParameter("companyName"))
	{
		companyName=request.getParameter("companyName");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct"); 
	}
	*/
		try {
				//conn = erp.ReturnConnection();
				Class.forName(DBDriver);
				cn = DriverManager.getConnection(DBNAME,DBUSERNAME,DBPASSWORD);
				st = cn.createStatement();
				st1 = cn.createStatement();
				st2 = cn.createStatement();
				System.out.println("in try");
			} catch (Exception e) {
			}
			
		System.out.println("After try");	
/*			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
*/
	%>
 
	<div style="font-size: 1.7em; text-align: center;"><a> 

		 Invoice Details Report </a>
   </div>
   
<form name='ledgerDetails' action="" method="get" >
                                                                                                                                                                                                                                                                                              
    <table width="100%" border="0">
      <tr>
        <!--
          <td align="right" valign="top">
			   <table>
			      <tr>
				     <td align="right" valign="top"><input type="checkbox" id="checkAll" name="checkAll" checked="checked" onchange="showHideAll();" value="checkAll"/></td><td >All &nbsp;&nbsp;&nbsp;</td>
		 
                     <td>
			   	       <div id="suplierNames">Suplier Name: &nbsp;
					   <input type="text" name="suplierNames" id="search-text" value='' onkeyup="getSupliers()" /></div>
		             </td>
		          </tr>
		       </table>
		  </td>
		  
		  <td align="left" style="width: 250px;">
			    <div id='suplierList'>
			       <div style="height: 10px; width: 400px; overflow: auto;">
			         <table style="display: none;">

  			         </table>

			       </div>
			    </div>
		   </td>
         -->
		   <td align="left" valign="top" style="width: 80px;">			 
			    <input type="text" id="fromdate" name="fromdate" value="<%=fromDateCal %>" size="15" readonly style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
			    <!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			    <script type="text/javascript">
			      Calendar.setup(
			        {
			          inputField  : "fromdate",         // ID of the input field
			          ifFormat    : "%d-%b-%Y",     // the date format
			          button      : "fromdate"       // ID of the button
			        }
			      );
			    </script>
            </td>
            
            <td align="left" valign="top" style="width: 10px;">
			&nbsp;<b>To </b> 
			</td>
			
			<td align="left" valign="top" style="width: 80px;">
			    <input type="text" id="todate" name="todate" value="<%=toDateCal %>" size="15" readonly style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />					
			      <script type="text/javascript">
			        Calendar.setup(
			        {
			          inputField  : "todate",         // ID of the input field
			          ifFormat    : "%d-%b-%Y",    // the date format
			          button      : "todate"       // ID of the button
			        }
			      );
			      </script>
			 </td>
			 
			 <td align="left" valign="top">&nbsp;&nbsp;
	             <input type="submit" name="submit" id="submit" style="border: outset;" value="GO"></input>
	         </td>
					
			 <td>
			      <table align="right">
			        <tr>	
				       <td align="right">
					      <font size="1">&nbsp;&nbsp;&nbsp;<%=new java.util.Date()%></font>
				          <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">  
	                        <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	                      </a>
					      <a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img>
					      </a>			 
			            </td>
		            </tr>
		          </table>
	          </td>
		</tr>
	</table>

</form>

<br></br>

<%
//if(request.getParameter("suplierNames")!=null )
if(request.getParameter("fromdate")!=null && request.getParameter("todate")!=null)
{
%> 
<%
   fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
   fromDateCal=request.getParameter("fromdate");
   System.out.println("from date is"+fromDate);
   toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
   toDateCal=request.getParameter("todate");
   System.out.println("to date is"+toDate);
//String sqlDetails="SELECT "+session.getAttribute("CompanyMasterID").toString()+"invoicedet.invoiceno, customercode, invoicedate, grandtotal, terms, freighttype, paymentmode, seandsqrefno, annexure, companyname, invoicetype, itemcode, thetabletobeaccessed FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items ON "+session.getAttribute("CompanyMasterID").toString()+"invoicedet.invoiceno = "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items.invoiceno WHERE invoicecancelled =0";
String sqlDetails="SELECT "+session.getAttribute("CompanyMasterID").toString()+"invoicedet.invoiceno, customercode, invoicedate, grandtotal, seandsqrefno, companyname, invoicetype, itemcode, quantity, thetabletobeaccessed FROM "+session.getAttribute("CompanyMasterID").toString()+"invoicedet INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items ON "+session.getAttribute("CompanyMasterID").toString()+"invoicedet.invoiceno = "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items.invoiceno WHERE invoicecancelled =0 and (invoicedate between '"+fromDate+"' and '"+toDate+"') and thetabletobeaccessed = 'tbl_digitim_make26'" ;
/*
boolean isCheckedAll=false;
isCheckedAll=(request.getParameter("checkAll")!=null ? true : false);
String sqlDetails="",suplierCode="",openingBalance=null;

suplierCode=(request.getParameter("suplierNames")!=null ? request.getParameter("suplierNames") : "-");
 
*/ 
 
%>
<form name="purchaseenq" method="post" >

<%
String exportFileName="PurchaseEnqDet_det.xls";   // GIVE YOUR REPORT NAME
%>
<div id='purchase'>

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<div id="tabS" style="visibility: visible;">
 
 	<table border="1px"  class="sortable">
	<tr>
		<th>Invoice No</th>
		<th>Customer Code</th>
		<th>Invoice Date</th>
		<th>Grand Total</th>
		<th>SE and SQ Ref No.</th>
		<th>Company Name</th>
		<th>Invoice Type</th>
		<th>Item Code</th>
		<th>Quantity</th>
		<th>Description</th>
	</tr>
	<%
	//int i=1;
					/*if(!isCheckedAll)
							sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq  as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where b.SupplierName ='"+suplierCode+"' and a.PurEnqDate between '"+fromDate+"' and '"+toDate+"' Order by a.PurEnqDate  Desc";
					else
					*/	
						//	sqlDetails ="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq  as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PurEnqDate between '"+fromDate+"' and '"+toDate+"' Order by a.PurEnqDate  Desc";
					
					System.out.println(sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) 
					{
						
						invoiceno = rsDetails.getInt("invoiceno");
						System.out.println("invoiceno is"+invoiceno);
						customercode = rsDetails.getInt("Customercode");
						System.out.println("customercode is"+customercode);
						invoicedate = rsDetails.getDate("invoicedate");
						System.out.println("invoicedate is"+invoicedate);
						grandtotal = rsDetails.getFloat("grandtotal");
						System.out.println("grandtotal is"+grandtotal);
						//terms = rsDetails.getString("terms");
						//System.out.println("terms is"+terms);
						//freighttype = rsDetails.getString("freighttype");
						//System.out.println("freighttype is"+freighttype);
						//paymentmode = rsDetails.getString("paymentmode");
						//System.out.println("paymentmode is"+paymentmode);
						seandsqrefno = rsDetails.getString("seandsqrefno");
						System.out.println("seandsqrefno is"+seandsqrefno);
						//annexure = rsDetails.getString("annexure");
						//System.out.println("annexure is"+annexure);
						companyname = rsDetails.getString("companyname");
						System.out.println("companyname is"+companyname);
						invoicetype = rsDetails.getString("invoicetype");
						System.out.println("invoicetype is"+invoicetype);
						itemcode = rsDetails.getInt("itemcode");
						System.out.println("itemcode is"+itemcode);
						quantity = rsDetails.getString("quantity");
						System.out.println("quantity is"+quantity);
						thetabletobeaccessed = rsDetails.getString("thetabletobeaccessed");
						System.out.println("thetabletobeaccessed is"+thetabletobeaccessed);
						sql1 = "show tables like '%"+thetabletobeaccessed+"%'";
						System.out.println("sql1 is"+sql1);
						ResultSet rs2 = st2.executeQuery(sql1);
						System.out.println("sql1 is"+sql1);
						if(rs2.next())
						{
						   System.out.println("The table is present");
						   //sql = "select description from "+thetabletobeaccessed+" where itemcode = "+itemcode+" and description like '%Vehicle Tracking System On Board%'";
						   sql = "select description from "+thetabletobeaccessed+" where itemcode = "+itemcode+" and description like '%Vehicle Tracking System On Board%'";/* or description like '%In%Vehicle%Journey%Risk%Management%(%JRM%)%')";*/
						   System.out.println("2nd query is after execution is"+sql);
						   ResultSet rs1 = st1.executeQuery(sql);
						   System.out.println("2nd query is after execution is"+sql);
						   if(rs1.next())
						   {
							   description = rs1.getString("description");
						       System.out.println("Description is"+description);
						
	%>
	<tr>
		<td align="right">
		  <div align="right"> <%=invoiceno %></div>
		</td>
		
		<td>
		<div align="right"><%=customercode%></div>
		</td>
		
		<td>
		<div align="left"><%=invoicedate%></div>
		</td>
		
		<td>
		<div align="right"><%=grandtotal%></div>
		</td>
		
		<td>
		<div align="left"><%=seandsqrefno%></div>
		</td>	
				
		<td>
		<div align="right"><%=companyname%></div>
		</td>
		
		<td>
		<div align="right"><%=invoicetype%></div>
		</td>
		
		<td>
		<div align="right"><%=itemcode%></div>
		</td>
		
		<td>
		<div align="right"><%=quantity%></div>
		</td>
		
		<td>
		<div align="right"><%=description%></div>
		</td>
	</tr>
	<%      }//inner if
			}//outer if
			else
			{
				//System.out.println("in else");
				//String gotopage = "invoiceagainstrpt.jsp";
				//String msg = "Record does not exist";
				/* response.sendRedirect("alertGoTo.jsp?msg="+msg+"&goto="+gotopage); */
				continue;
			}	
		}
}
%>
</table>
</div>
</div>
</form>
	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
		<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>