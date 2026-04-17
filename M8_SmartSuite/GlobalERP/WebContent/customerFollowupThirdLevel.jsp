<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ include file="header.jsp"%>
<%@ include file="ConnectionComplaint.jsp"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>

	<script src="dropdown.js" type="text/javascript"></script>
	<script src="ledgerDetails.js" type="text/javascript"></script>

	<script language="JavaScript1.2">

	function getCompanies()
	{
		document.getElementById('companyList').style.visibility = 'visible';
			var company=document.ledgerDetails.companyNames.value;
			var ajaxRequest;  // The variable that makes Ajax possible!

			if(company=="")
			{
				document.getElementById('companyList').style.visibility = 'hidden';
				document.ledgerDetails.companyName.value="";
				document.ledgerDetails.companyEmail.value="";
				document.ledgerDetails.companyPerson.value="";
				document.ledgerDetails.companyCity.value="";
				document.ledgerDetails.companyProduct.value="";
				document.ledgerDetails.companyPhone.value="";
			}
			else
			{
				company=company.replace(".", "");
				company=company.replace(",", "");
				company=company.replace("$", "");
				company=company.replace("#", "");
				company=company.replace("?", "");
				company=company.replace("-", "");
				company=company.replace("_", "");
				company=company.replace(" ", "");
				company=company.replace("(", "");
				company=company.replace(")", "");
			try{
				// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
			}  
			catch (e)
			{
				// Internet Explorer Browsers
				try
				{
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{
					try
					{
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch (e)
					{
						// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}

			ajaxRequest.onreadystatechange = function()
			{
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					document.getElementById("companyList").innerHTML=reslt;
				} 
			}
			var queryString = "?company=" +company;
			ajaxRequest.open("GET", "AjaxGetLedgerCompaniesCustomer.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}//end of else
		
	}
function sendSMS(){

	var ajaxRequest;  // The variable that makes Ajax possible!
	var company=document.ledgerDetails.companyName.value;
	var contact=document.ledgerDetails.companyPerson.value;
	var phone=document.ledgerDetails.companyPhone.value;
	var email=document.ledgerDetails.companyEmail.value;
	var product=document.ledgerDetails.companyProduct.value;
	var city=document.ledgerDetails.companyCity.value;
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			alert(reslt);
		}
	}
	var queryString = "?company=" +company+"&contact="+contact+"&phone="+phone+"&email="+email+"&city="+city+"&product="+product;
	ajaxRequest.open("GET", "AjaxSendSMS.jsp" + queryString, true);
	ajaxRequest.send(null); 
}
	
function showVisitingCardDetails(i,j,k,l,m,n)
{
		document.getElementById('visitingCard').style.visibility='visible';
		document.ledgerDetails.companyNames.value='';
		document.getElementById('companyList').style.height = '10px'; 
		document.getElementById('companyList').style.visibility = 'hidden';
		document.ledgerDetails.companyName.value=i;
		document.ledgerDetails.companyEmail.value=j;
		document.ledgerDetails.companyPerson.value=k;
		document.ledgerDetails.companyCity.value=l;
		document.ledgerDetails.companyProduct.value=m;
		document.ledgerDetails.companyPhone.value=n;
		document.getElementById('tabS').style.visibility='hidden';
 
}

function newwindow(webadd)
{ 
		if(document.ledgerDetails.companyName.value=="" || document.ledgerDetails.companyName.value==null)
			alert("Please select a company ");
		else
			window.open(webadd+'?email='+document.ledgerDetails.companyEmail.value+'&toDate='+document.ledgerDetails.todate.value+'&fromDate='+document.ledgerDetails.fromdate.value+'&company='+document.ledgerDetails.companyName.value,'jav','width=470,height=500,top=250,left=600,resizable=no');
		
}

function newSMSwindow(weba)
	{ 
		if(document.ledgerDetails.companyName.value=='' || document.ledgerDetails.companyName.value==null)
			alert("Please select a company ");
		else
		window.open(weba+'?companyName='+document.ledgerDetails.companyName.value+'&email='+document.ledgerDetails.companyEmail.value+'&contactPerson='+document.ledgerDetails.companyPerson.value+'&companyPhone='+document.ledgerDetails.companyPhone.value+'&companyProduct='+document.ledgerDetails.companyProduct.value+'&companyCity='+document.ledgerDetails.companyCity.value,'jav','width=470,height=350,top=250,left=600,resizable=no');
	}

	function popUp()
	{
		//alert("IN popup");
		document.getElementById("showdocuments").style.visibility="visible";
	}

	function cancelentryform()
	{
		document.getElementById("showdocuments").style.visibility="hidden";
	}
	

	function getimage(image)
	{
		//alert(image);
		try{
		window.open('getimage.jsp?image='+image+'','mywindow','width=1000,height=750,resizable=no,scrollbars=yes');
		}catch(e)
		{}
	}
	 
	if (document.all || document.getElementById)
		document.body.style.background = " white top no-repeat ";
</script>
<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.custwisefollowupreport.action ="excel.jsp";
          document.forms["custwisefollowupreport"].submit();
}
</script>
</head>
<body>
	 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
		Connection conn1 = null;
			Statement st = null, st1 = null, st3 = null, st4 = null, stconn1 = null,st5 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String companyName="",phone="",contact="",email="",product="",city="";
			String serverid="",usernm="",passwd="";
			
			System.out.println("######Inside Third Level*&#*&#");
	%>
	<%
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	System.out.println("######Inside Third Level*&#*&#");
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
	fromDate=request.getParameter("fromdate");//new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=request.getParameter("todate");//new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	if (!(null == request.getParameter("companyName"))) 
	{
		companyName=request.getParameter("companyName");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct");
	}	
try {
				conn = erp.ReturnConnection();
				conn1 = DriverManager.getConnection(DB_NAME1,DB_USERNAME1,DB_PASSWORD1);
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				st5 = conn.createStatement();
				stconn1 = conn1.createStatement();
				
				System.out.println("=====62 connection created===");
		 
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
			
				
			System.out.println("######Inside Third Level*&#*&#  From Date"+fromDate+"To Date===>>"+toDate);	
	%>
 
	<div
		style="font-size: 1.5em; text-align: center; margin-top: 5px; margin-bottom: 5px;"><a> 

		  FollowUp Report for <%=request.getParameter("companyName") %></a>
 </div>
<form name='ledgerDetails' action="" method="get" >

<table width="50%" border="0" align="center">
<tr>
<td style="width: 20px">

<div id="visitingCard" style="visibility: visible;">
			<table  bgcolor="#C6DEFF">
				<tr>
					<td align="left" ><div id="Company"><b>Company</b></div></td>
					<td align="left">
					<div id="companyName"><input type="text" name="companyName" 
						id="search-text" value="<%=companyName %>"
						style='border-style: none; width: 200px; height: 12px; background-color: #C6DEFF;'' readonly="readonly" /></div>
					</td>
					<td align="center" style="width: 25%"><div id="Contact"><b>Contact </b></div></td>
					<td valign="top" align="right">
					<div id="companyPerson"><input type="text"
						name="companyPerson" id="search-text" value="<%=contact %>" readonly="readonly"
						style='border-style: none; width: 200px; background-color: #C6DEFF;'' /></div>
					</td>

<!--								<td valign="top" style="width: 30px;">-->
<!--				<a href="#" style="font-weight: bold; color: black; " onclick="newSMSwindow('smsvc.jsp');">-->
<!--<img src="images/sms.png" width="25px" height="22px" style="border-style: none"></img>-->
<!--</a> -->
<!--			</td>-->

				</tr>
								<tr>
					<td align="left"><div id="Phone"><b>Phone</b></div></td>
					<td align="left">
					<div id="companyPhone"><input type="text" name="companyPhone"
						id="search-text" value="<%=phone %>"
						style='border-style: none; width: 200px; height: 12px; background-color: #C6DEFF;'' readonly="readonly"/></div>
					</td>
					<td align="center" style="width: 25%" valign="middle"><div id="Email"><b>E-Mail </b></div></td>
					<td valign="top" align="right" style="">
					<div id="companyEmail">
					<textarea
										name="companyEmail" rows="1" id="search-text"   readonly="readonly"
										style='border-style: none; width: 200px; height: 30px; background-color: #C6DEFF;''><%=email %></textarea>
		 </div>
					</td>
					<td>
						
					</td>

					</tr>
								<tr>
					<td align="left"><div id="Product"><b>Product</b></div></td>
					<td align="left">
					<div id="companyProduct"><input type="text" name="companyProduct"
						id="search-text" value="<%=product %>"
						style='border-style: none; width: 200px; height: 12px; background-color: #C6DEFF;'' readonly="readonly"/></div>
					</td>
					<td align="center" style="width: 25%"><div id=City"><b>City </b></div></td>
					<td valign="top" align="right">
					<div id="companyCity"><input type="text" readonly="readonly"
						name="companyCity" id="search-text" value="<%=city %>"
						style='border-style: none; width: 200px; background-color: #C6DEFF;'' /></div>
					</td>
<td></td>
				</tr>
				</table>

</div>

</td><td align="left" valign="top"> 
<!--			<table width="100%" border="0">-->
<!--			<tr>-->
<!--			<td valign="top" style="width: 70px;" rowspan="4" >-->
<!--				<a href="#" style="font-weight: bold; color: black; " onclick="newwindow('emailFollowup.jsp');">-->
<!--<img src="images/email.png" width="25px" height="22px" style="border-style: none"></img>-->
<!--</a>  -->
<!--			</td>-->
<!--			</tr>-->
<!--			</table>-->
			</td>
<td>

</td>
</tr>
</table>


</form>



<%

String sqlftp="select * from "+session.getAttribute("CompanyMasterID").toString()+"ftpconnection";
ResultSet rsftp=st.executeQuery(sqlftp);
rsftp.next();
serverid=rsftp.getString("ServerID");
usernm=rsftp.getString("Username");
passwd=rsftp.getString("Password");


//int a=0;
//String sqlCount="select count(Distinct DocumentName),1 as Nos from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+request.getParameter("companyName")+"' and DocumentStatus='Upload'";
//System.out.println(">>>>>    ************   "+sqlCount);
//ResultSet rscount=st2.executeQuery(sqlCount);
//rscount.next();
//a=rscount.getInt(1);
//System.out.println("%%%%%%%%^^^^^^^^^^^^^^   "+a);
/////////////////////////
int a=0;
					Set<String> tempset = new LinkedHashSet<String>(  );
					
					String sqlCount="select Distinct DocumentName from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+request.getParameter("companyName")+"' and DocumentStatus='Upload'";
					System.out.println(sqlCount);
					ResultSet rscount=st2.executeQuery(sqlCount);
					while(rscount.next())
					{
					%>	
					
					
					<% 
				//System.out.println("=========vall1111==============>>"+rsdt.getString("DocumentName"));
				String delims12= "[,]";
				if(rscount.getString("DocumentName").equalsIgnoreCase("-"))
				{
					
				}
				else
				{
				String[] tok = rscount.getString("DocumentName").split(delims12);
				
				
				
				//for (String t1 : tok)
					%>
					
					
					<%
					for (int ij=1;ij<tok.length;ij++)
					{
					System.out.println("=========valll2222==============>>"+tok[ij]);
					tempset.add(tok[ij]);
					//String[] result = temp.toArray(tok[ij] );
					%>
					<%	
					
				     }
					%>
					
					<%
				}
				%>
					
					
					
					
					
					
					
					<%}
					Iterator iterconut = tempset.iterator();
					while (iterconut.hasNext()) {
					  
					  String val11=iterconut.next().toString();
					  //System.out.println("VAL########"+val);
					  a++;
					
					%>	
					
						
						<%} 

System.out.println("file count=================>"+a);


%>


<br>
<div id="showdocuments" style="position:absolute;margin-left:330px ;margin-top:20px;background-color:#C6DEFF;border:solid thin black;">	  	
		<table>
				<tr>
					<td><b>Uploaded Documents </b>
					</td>
					<td align="right"><input type="button" name="cancel" id="cancel" value="X"  onclick="cancelentryform()" style="width:20; color:red;" />
					</td>
				</tr>
				<tr>
				  <td colspan="0">
					<table style="width: 200px;height: 200px;" border="1"  cellspacing="0" cellpadding="0" class='sotable'>
					 <tr>
						<th align="center"><font size="2" color="black"><b>Sn.</b></font></th>
					 	<th align="center"><font size="2" color="black"><b>FileName</b></font></th>
					 </tr>
					<%
					int cnt=1;
					Set<String> temp = new LinkedHashSet<String>(  );
					
					String data="select Distinct DocumentName from "+session.getAttribute("CompanyMasterID").toString()+"followup where ProspCustName='"+request.getParameter("companyName")+"' and DocumentStatus='Upload'";
					System.out.println(data);
					ResultSet rsdt=st1.executeQuery(data);
					while(rsdt.next())
					{
					%>	
					
					
					<% 
				System.out.println("=========vall1111==============>>"+rsdt.getString("DocumentName"));
				String delims12= "[,]";
				if(rsdt.getString("DocumentName").equalsIgnoreCase("-"))
				{
					
				}
				else
				{
				String[] tok = rsdt.getString("DocumentName").split(delims12);
				
				
				
				//for (String t1 : tok)
					%>
					
					
					<%
					for (int ij=1;ij<tok.length;ij++)
					{
					System.out.println("=========valll2222==============>>"+tok[ij]);
					temp.add(tok[ij]);
					//String[] result = temp.toArray(tok[ij] );
					%>
					<%	
					
				     }
					%>
					
					<%
				}
				%>
					
					
					
					
					
					
					
					<%}
					Iterator iter = temp.iterator();
					while (iter.hasNext()) {
					  
					  String val=iter.next().toString();
					  System.out.println("VAL########"+val);
					
					%>	
					
						<tr>
						<td><font color="black"><%=cnt++%></font></td>
						<td><a href="DocumentsAttached.jsp?documentName=<%=val%>" onclick="window.open(this.href);return false;"><font size="2"><%=val%></font><br></br></a></td>
						</tr>
						<%} %>
					</table>
					</td>	
				</tr>
		</table>
</div>	
<script>document.getElementById("showdocuments").style.visibility="hidden";</script>

<br><br>

<%	
String sqlDetails="",companyCode="",openingBalance=null;
double sumDebit=0,sumCredit=0;

%>
<form id="custwisefollowupreport" name="custwisefollowupreport" method="post" >
<%
         //final String exportFileName="Followup_Repor"+session.getAttribute("CompanyMasterID").toString()+"between_"+fromDate+"_and_"+toDate+".xls";

final String exportFileName="CustomerInfo.xls";

%>
<table width="100%" border="0" align="center">
		<tr>
			<td>
			 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><font size="1">&nbsp;&nbsp;&nbsp;<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
<!--							<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">-->
<!--                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>-->
                           
                           <a href="#" onclick="javascript:window.open('excel_customer_third_level.jsp?companyName=<%=request.getParameter("companyName") %>&fromdate=<%=fromDate %>&todate=<%=toDate %>');" title="Export To Excel">

				<img src="images/excel.jpg"	width="15px" height="15px"></img></a>
                           <a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
        	</td>
		</tr>
		
</table>

<div id="table1" style="visibility: visible;">

<table border="1px"  class="sortable" width="75%">
	<tr>
	<th>Sr.No</th>
	<th>Sign</th> 
	<th>Contact Person</th> 
	<th>Follow-Up Date</th>
	<th>Status</th>
	<th>Comments</th>
	<th>Follow-Up Type</th>
	<th>Next Follow Up Date</th>
	<th>Preparation For Next FollowUp</th>
	<th>Payment Follow-Up</th>
	<th>Expected Amount</th>
	<th>Spoken To</th>
	<th>Reply</th>
	<th>Remarks</th>
<!--	<th>File Attched</th>-->
	</tr>
 <% 
 
 					System.out.println("The company name is >>>>>>>>>>>>>>>>>>>>>>:"+request.getParameter("companyName"));
 
					int i = 1;
					sqlDetails = " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup AS a LEFT OUTER JOIN   "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
					"  AS b ON ( a.MarketingRepCode = b.MarketingRepCode )			"+
					"where a.ProspCustName='"+request.getParameter("companyName")+"'  and followupdate between '"+fromDate+"' and "+
					" '"+toDate+"'  ORDER BY  a.followupdate DESC ";
					System.out.println(sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) {
						
						String abc="";
						if (!(null == rsDetails.getString("MarketingRepName"))) {
							 abc=rsDetails.getString("MarketingRepName");	
						}else
						{
							abc="-";	
						}
						
						%>
	<tr>
						<td align="left"><div align ="right"><%=i++ %></div></td>
						<td align="left"><div align ="left"><%=rsDetails.getString("MarketingRepName") %></div></td>
						<td align="left"><div align ="left"><%=rsDetails.getString("ContactPerson") %></div></td>
						
						<td><div align ="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
									(rsDetails.getString("FollowUpDate")))%></div></td>
						<td><div align ="left"><%=rsDetails.getString("Status") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("Comments") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("FollowUpType") %></div></td>
						<td><div align ="left"><%=new SimpleDateFormat(
																"dd-MMM-yyyy")
																.format(new SimpleDateFormat(
																		"yyyy-MM-dd")
																		.parse(rsDetails
																				.getString("NextFollowUpDate")))%></div></td>
						<td><div align ="left"><%=((rsDetails.getString("Preparation")!=null ) && (rsDetails.getString("Preparation")!="" ) ? rsDetails.getString("Preparation") : "-") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("PaymentFollowup") %></div></td>
						<td><div align ="right"><%=((rsDetails.getString("AmountExpected")!=null ) && (rsDetails.getString("AmountExpected")!="" ) ? rsDetails.getString("AmountExpected") : "-") %></div></td>
						<td><div align ="left"><%=((rsDetails.getString("SpokenTo")!=null ) && (rsDetails.getString("SpokenTo")!="" ) ? rsDetails.getString("SpokenTo") : "-") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("Reply") %></div></td>
						<td><div align ="left"><%=((rsDetails.getString("Remarks")!=null ) && (rsDetails.getString("Remarks")!="" ) ? rsDetails.getString("Remarks") : "-") %></div></td>
						
						
						
						
	</tr>
						<%
					}
 
					if(i==1){
%>						<tr><td colspan="15">***</td></tr>
						<tr><td colspan="15"><b><%=request.getParameter("companyName") %>
 						&nbsp;&nbsp;is not followed up since <u><%=fromDateCal %></u> &nbsp;to&nbsp;  <%=toDateCal %></u></b></td></tr>

<%					}//end of if
%></table>
<br></br><br></br>

<%

} catch (Exception e) {
out.print("!!!Connection Lost!!!");
}
finally{
	conn.close();
}%>

</div>
</form>
	 
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